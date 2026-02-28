Return-Path: <stable+bounces-220398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNCIFs42o2lg+gQAu9opvQ
	(envelope-from <stable+bounces-220398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:41:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C60E81C61F4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E31C3389EE9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF85F3ABCF6;
	Sat, 28 Feb 2026 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G33OQ2n1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CCC3ABCEB;
	Sat, 28 Feb 2026 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300290; cv=none; b=AFPZqZQIgnNqLRDaPWGTHky4WoV+B1Sda7crfaMGl3Q9aqzsAVoaFUZIxdbwNlwJJBnFwTPTgnc+lA4GQMe9LM78DTno8U1bjJVsWfm9OT9lmX34MvoYrMHfr0t8gj3wleep6hpM3McJp2+uQ8Y8Ip+3q18oMJNA7Paq1feewWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300290; c=relaxed/simple;
	bh=5CmZ0ezQLskFJVxiDwB6Jj+vIZnoq5Jpd3GF+gEM7EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sC09uVTFq9PgRW3tLcN3L58wMF9NV9rggMJA6hEPvlqfIXRAeUKzaXWhkvh4gzck1XHqh+fc3kpuVSh1hFMHAlkS1IW4XeLCbFOezfw0O+mRI0s49Vi4u2upgZZgwkrLCquwLdE8GPAe9ALRymQh3gj+H3cE0mqpouGv3YBmCR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G33OQ2n1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2D3C19425;
	Sat, 28 Feb 2026 17:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300290;
	bh=5CmZ0ezQLskFJVxiDwB6Jj+vIZnoq5Jpd3GF+gEM7EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G33OQ2n1lSZmBLdcXWKiP80X+a3j9Z5dOK1kf1TaEnTKq/ifiyh6RvbkdzO+lOcN4
	 NrNNgFkuQzlK1QSthXidq6z9sVO6kYVPYrHPw4FZLeB9BXEqXToE96GjOqXC47QNeK
	 1IJ74OBUyAqduyNXUzua9T1CBDyj8pVP2BTKeQ3EJyuKpYXfagEliuIFe1lpM04kUF
	 qVaAJTonGw/UInKZehyXCihPo9tYwlnihu850Gm1mWd0x57n22G0T/Yikwvdx1rN3Z
	 kLKDSZU2JnnbFhNVmj54npomRJgqkXv/SA6wWNS1/phrDNL3dmSFnRlJ3Cy4FuRhLf
	 1UrqCQydZJ/Vg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 319/844] Bluetooth: hci_conn: use mod_delayed_work for active mode timeout
Date: Sat, 28 Feb 2026 12:23:52 -0500
Message-ID: <20260228173244.1509663-320-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220398-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: C60E81C61F4
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
 net/bluetooth/hci_conn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 98f0461b3dd7d..dc085856f5e91 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2620,8 +2620,8 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
 
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


