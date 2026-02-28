Return-Path: <stable+bounces-220257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LsXDPwuo2nb+AQAu9opvQ
	(envelope-from <stable+bounces-220257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:07:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 816C21C5717
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0A04306147E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19863379EFC;
	Sat, 28 Feb 2026 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiRmJ0b2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF73A379EF6;
	Sat, 28 Feb 2026 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300160; cv=none; b=vArxjm46h8Ic4PvdrU1riIknlxEavTrSSY1HLRbCdaqxKHkRnrnu0//hdGKK2gVxe7r9h5hxwDyS+rmiMa3DwEHKyOiv58OQcVcEuSaTYxUaZNkQ4//H9L9c3szL0167zXbJgTUP49QWFFX042qgnKcZXY9eAiO32RvsFoksEMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300160; c=relaxed/simple;
	bh=TYqVDXtQ0/PIYnUvVHVN5F6H+dM+ladLlhiwnGNLqp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a75z6Bgi+ElPSaRbm7LMHaFGqH5zRimmiZ36bRy8ohGQlwUaqd68w6Gdb7gX1x1MtX8JN6c12vGuUx8SuYJUoeRZ7NtgCJjG9tgzPQnaUwLHYoPdA17Yem/A3n/TFg8FfLgNIx7as9J6wuF8borfjIDuShzuZmkFwK+lqRnJPyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiRmJ0b2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFE0C19423;
	Sat, 28 Feb 2026 17:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300160;
	bh=TYqVDXtQ0/PIYnUvVHVN5F6H+dM+ladLlhiwnGNLqp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BiRmJ0b2Sg2YNb/Z61iDtiAxY5jJCbMDyzOKhFXNtKgqfAAMyNhl8jwO/PJbbQqJr
	 uP3tb1FGBjg7OieK/uBXGARZP0zC/AUfFCbQMkkIKuGjxOB7G05qacdEBsAsl5+zCy
	 MHoG4+3oJCZNo/PV3ufKqewzqtgF10wbgaatnB+oH6YI2U3uW1q2UmmIZyOzlRMOrM
	 OAR6SmNQAARtEWczR2HHO+KysabxBBrWmUrfevum+NDqWbU/PjgOiJO89uydkri7iC
	 t29i42KXIy4O2Mn/o+4eoQvhcTpIdnqo8ZjkY781w/vCiojv8265+KUDRB5otxBwx8
	 6uy4J8aWITyDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Szymon Wilczek <szymonwilczek@gmx.com>,
	syzbot+405dcd13121ff75a9e16@syzkaller.appspotmail.com,
	Mike Isely <isely@pobox.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 179/844] media: pvrusb2: fix URB leak in pvr2_send_request_ex
Date: Sat, 28 Feb 2026 12:21:32 -0500
Message-ID: <20260228173244.1509663-180-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.com,syzkaller.appspotmail.com,pobox.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220257-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,405dcd13121ff75a9e16,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 816C21C5717
X-Rspamd-Action: no action

From: Szymon Wilczek <szymonwilczek@gmx.com>

[ Upstream commit a8333c8262aed2aedf608c18edd39cf5342680a7 ]

When pvr2_send_request_ex() submits a write URB successfully but fails to
submit the read URB (e.g. returns -ENOMEM), it returns immediately without
waiting for the write URB to complete. Since the driver reuses the same
URB structure, a subsequent call to pvr2_send_request_ex() attempts to
submit the still-active write URB, triggering a 'URB submitted while
active' warning in usb_submit_urb().

Fix this by ensuring the write URB is unlinked and waited upon if the read
URB submission fails.

Reported-by: syzbot+405dcd13121ff75a9e16@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=405dcd13121ff75a9e16
Signed-off-by: Szymon Wilczek <szymonwilczek@gmx.com>
Acked-by: Mike Isely <isely@pobox.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
index b32bb906a9de2..5807734ae26c6 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
@@ -3709,6 +3709,11 @@ status);
 				   "Failed to submit read-control URB status=%d",
 status);
 			hdw->ctl_read_pend_flag = 0;
+			if (hdw->ctl_write_pend_flag) {
+				usb_unlink_urb(hdw->ctl_write_urb);
+				while (hdw->ctl_write_pend_flag)
+					wait_for_completion(&hdw->ctl_done);
+			}
 			goto done;
 		}
 	}
-- 
2.51.0


