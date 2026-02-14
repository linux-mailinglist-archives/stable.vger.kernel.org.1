Return-Path: <stable+bounces-216592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AIXLiDqkGkfdwEAu9opvQ
	(envelope-from <stable+bounces-216592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 22:33:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 521C013D9E2
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 22:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98AD9305246B
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 21:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9893148D2;
	Sat, 14 Feb 2026 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWt/uS4n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA693126DA;
	Sat, 14 Feb 2026 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104455; cv=none; b=sUobfu1F+RSoS7eSxTxbetiz2bTbt5271tnPSBAbXOWiG3YCB2UQa1f+Bnv/VwQnzC/YTdEfWS+qnRJw0Q6QY0nz7OgVAmTN41mfvHDBh/rRQJCGklJevD5ofDw9MXE2CyOo/tUALE4SAUplewwPGE8kVG4fQSVC1FaoYUGpev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104455; c=relaxed/simple;
	bh=RQOxmVIvXYWi+v0QQNEVNzi+ybYeMWxpsMp149GN7Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NsOKCCLjjxA8LKS7XXBKEH5BV4DnS085QkIaM2vF8NUbC0Q9+ucpOxRxJCYWlbGNeSoVdpzsSH7BKpVDY1X/VDGZkhCqhK8iSLMpHQoCzteO7bGhIMNsoi7UVXiRmX4BQwAb0A2VnugcOKkOzH4okbQ/mqPOu5tHPRGjqiMWlgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWt/uS4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5BAC19425;
	Sat, 14 Feb 2026 21:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104455;
	bh=RQOxmVIvXYWi+v0QQNEVNzi+ybYeMWxpsMp149GN7Vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CWt/uS4ncaegpAuM6vkCUiEUNkhGixq+4MWGYC35BRN+MjMEyS/jwy7Wwn55ujuGf
	 xbirtNKAg2iPKiMlTKkJZAiRRTNK4cIvlg0atXjGAXiHb5WxTWR4o3mqpfbhgwST53
	 FIWT+N4FRiHdptDMgAFroLlfCCHHOFM2zf6/0vh/2WG/tp5Y5ACbTONSGADe6gZ3eN
	 RzVjmwjHqg0itI1HsnpuQM2BaDFsuCl19bnnJdUD2wnqhh3Fpt6ko2eBdyAWKFVQLM
	 jVCGb8+k1RXf2RofIKs+duoGJ9Pf+oRpun1dif3bA/YGNu1CToUDetFd78e47PDibf
	 BMZhnLgnXU44A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.10] Bluetooth: hci_conn: use mod_delayed_work for active mode timeout
Date: Sat, 14 Feb 2026 16:24:00 -0500
Message-ID: <20260214212452.782265-95-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214212452.782265-1-sashal@kernel.org>
References: <20260214212452.782265-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[roku.com,intel.com,kernel.org,holtmann.org,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216592-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,roku.com:email]
X-Rspamd-Queue-Id: 521C013D9E2
X-Rspamd-Action: no action

From: Stefan Sørensen <ssorensen@roku.com>

[ Upstream commit 49d0901e260739de2fcc90c0c29f9e31e39a2d9b ]

hci_conn_enter_active_mode() uses queue_delayed_work() with the
intention that the work will run after the given timeout. However,
queue_delayed_work() does nothing if the work is already queued, so
depending on the link policy we may end up putting the connection
into idle mode every hdev->idle_timeout ms.

Use mod_delayed_work() instead so the work is queued if not already
queued, and the timeout is updated otherwise.

Signed-off-by: Stefan Sørensen <ssorensen@roku.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis of Bluetooth: hci_conn: use mod_delayed_work for active mode
timeout

### 1. COMMIT MESSAGE ANALYSIS

The commit message clearly describes a **behavioral bug**:

- `queue_delayed_work()` does nothing if the work is already queued
- This means the timeout is never refreshed/reset when
  `hci_conn_enter_active_mode()` is called while work is already pending
- The consequence: the connection may enter idle mode prematurely (every
  `hdev->idle_timeout` ms from the *first* queuing, not from the *last*
  activity)
- `mod_delayed_work()` fixes this by resetting the timer if already
  queued, or queuing if not

The commit message is well-written and explains the mechanism clearly.
The author (Stefan Sørensen) understood the semantic difference between
the two APIs.

### 2. CODE CHANGE ANALYSIS

The change is **minimal** - a two-line change replacing one function
call with another:

```c
- queue_delayed_work(hdev->workqueue, &conn->idle_work,
- msecs_to_jiffies(hdev->idle_timeout));
+               mod_delayed_work(hdev->workqueue, &conn->idle_work,
+                                msecs_to_jiffies(hdev->idle_timeout));
```

- `queue_delayed_work()` → queues work only if not already queued;
  returns false and does nothing if already queued
- `mod_delayed_work()` → if work is pending, cancels and re-queues with
  the new delay; if not pending, queues it fresh

This is exactly the right fix. The function
`hci_conn_enter_active_mode()` is called whenever there's activity on
the connection, and the idle timeout should be reset from the last
activity, not remain fixed from the first.

### 3. BUG CLASSIFICATION

This is a **real behavioral bug** affecting Bluetooth connection power
management:

- **Without the fix**: A Bluetooth connection may be put into sniff/idle
  mode too early if `hci_conn_enter_active_mode()` is called multiple
  times. The first call sets the timer, and subsequent calls (which
  indicate continued activity) fail to extend it. The connection gets
  idled based on the *first* activity, not the *last*.
- **User impact**: Bluetooth connections may experience unexpected power
  state transitions, potentially causing latency issues, dropped
  connections, or degraded performance for active Bluetooth devices
  (audio, input devices, etc.).

### 4. SCOPE AND RISK ASSESSMENT

- **Lines changed**: 2 (just the function name and indentation)
- **Files touched**: 1 (`net/bluetooth/hci_conn.c`)
- **Risk**: Very low. `mod_delayed_work()` is a well-established kernel
  API that has been available for many years. The semantic change is
  exactly what the code intended.
- **Could it break something?** Extremely unlikely. The only behavioral
  change is that the idle timeout now properly resets on each call,
  which is the correct behavior. If anything, the old behavior was
  silently broken.

### 5. USER IMPACT

Bluetooth is widely used:
- Audio devices (headphones, speakers)
- Input devices (keyboards, mice)
- Phone tethering
- IoT devices

Premature idle mode transitions could affect any of these use cases.
While this may not cause crashes, it affects the reliability of
Bluetooth connections, which is important for stable kernel users.

### 6. STABLE TREE CRITERIA CHECK

- **Obviously correct?** Yes - the commit message explains the API
  difference clearly, and `mod_delayed_work()` is the standard pattern
  for "reset this timer"
- **Fixes a real bug?** Yes - incorrect idle timeout behavior for
  Bluetooth connections
- **Small and contained?** Yes - 2-line change in a single file
- **No new features?** Correct - this is purely a bug fix
- **Tested?** Accepted by Bluetooth maintainer (Luiz Augusto von Dentz),
  merged to mainline

### 7. DEPENDENCY CHECK

This change has no dependencies. `mod_delayed_work()` has been in the
kernel since 3.x era. The surrounding code in
`hci_conn_enter_active_mode()` is stable and has existed for a long
time.

### Conclusion

This is a clean, minimal, obvious bug fix. It corrects a long-standing
behavioral issue in Bluetooth power management where the idle timeout
was not being properly reset. The fix is exactly two lines, uses a well-
established API, has zero risk of regression, and improves Bluetooth
connection reliability for all users. It perfectly meets stable kernel
criteria.

**YES**

 net/bluetooth/hci_conn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b5e345fa6c344..1214216c7818e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2615,8 +2615,8 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
 
 timer:
 	if (hdev->idle_timeout > 0)
-		queue_delayed_work(hdev->workqueue, &conn->idle_work,
-				   msecs_to_jiffies(hdev->idle_timeout));
+		mod_delayed_work(hdev->workqueue, &conn->idle_work,
+				 msecs_to_jiffies(hdev->idle_timeout));
 }
 
 /* Drop all connection on the device */
-- 
2.51.0


