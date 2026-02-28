Return-Path: <stable+bounces-220347-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDqaOhkzo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220347-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:25:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9328A1C5C55
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7E91309F092
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF4539C21F;
	Sat, 28 Feb 2026 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGKTcSzg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CFA39C216;
	Sat, 28 Feb 2026 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300245; cv=none; b=mc/XLyviSMi9p4rmLyeaDOo5AewJh1kJzultlWGVauyofvxprSsHoDPBXOiXYeed1cmyUXrShFtrvUchQ8vDz3QFGohU/DVgmfZQ+bqV+BuzeSfyEajjSBFT8WPsdeqGLELbFkXr3/WHSlgfKfdRTybNOyTFdHhKyrYFdLM3O8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300245; c=relaxed/simple;
	bh=vGJ+ODU1O2pnF5slHFB5e8eITxNGC7zuB7JpGnFop2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUwyHPNB/2+TR18lmx1Sce6AEO1F7RE7QQ/A7evtrIVm85dCYKAotKg+GhtdpaWOdQubyrmqMh7JHIQjpaIRzJw2f/WdPPX2tZesC+LxW89hqO7jgWlxrt4s3VUurdJHTh7/DrggLhMH5YKmj5f9AhwSf5wC7hV/FrKy3wfANIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGKTcSzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FF6C19423;
	Sat, 28 Feb 2026 17:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300245;
	bh=vGJ+ODU1O2pnF5slHFB5e8eITxNGC7zuB7JpGnFop2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IGKTcSzghzwwou9FxEQcM8yOo6bt8g+uPfAC6O7WNbzZkJu8WLw/0GZ2GTX7W3BOY
	 jvPRL9j87tyL4G/W6KRenoB6zEqfzm/nLt+3H9oU2lmZmBME9Xw77Q5toZ2DuDzyK+
	 uHPtna0JKyGn2saX9tOF4klUPmBOxNm0IrRtWA/xRjciZQFBJRhRvqSwNz2SYgRDKs
	 p0gnpo9BmiOJ7t38XBqA0LYj70EBR3KX0se+3OH+UAxG9E6WdNZzpA/P/8i1/kiaNl
	 gjU0P9uiquZny+CurVfiOCta08Abn9EAum5xi8wyKiB/IZwRdDzOrhI11Ncljy4VRR
	 OcEi/BvMN3VRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Szymon Wilczek <swilczek.lx@gmail.com>,
	syzbot+67969ab6a2551c27f71b@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 269/844] wifi: libertas: fix WARNING in usb_tx_block
Date: Sat, 28 Feb 2026 12:23:02 -0500
Message-ID: <20260228173244.1509663-270-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,intel.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220347-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,67969ab6a2551c27f71b];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,msgid.link:url,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 9328A1C5C55
X-Rspamd-Action: no action

From: Szymon Wilczek <swilczek.lx@gmail.com>

[ Upstream commit d66676e6ca96bf8680f869a9bd6573b26c634622 ]

The function usb_tx_block() submits cardp->tx_urb without ensuring that
any previous transmission on this URB has completed. If a second call
occurs while the URB is still active (e.g. during rapid firmware loading),
usb_submit_urb() detects the active state and triggers a warning:
'URB submitted while active'.

Fix this by enforcing serialization: call usb_kill_urb() before
submitting the new request. This ensures the URB is idle and safe to reuse.

Reported-by: syzbot+67969ab6a2551c27f71b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=67969ab6a2551c27f71b
Signed-off-by: Szymon Wilczek <swilczek.lx@gmail.com>
Link: https://patch.msgid.link/20251221155806.23925-1-swilczek.lx@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/libertas/if_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net/wireless/marvell/libertas/if_usb.c
index b3c4040257a67..924ab93b7b671 100644
--- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -426,6 +426,8 @@ static int usb_tx_block(struct if_usb_card *cardp, uint8_t *payload, uint16_t nb
 		goto tx_ret;
 	}
 
+	usb_kill_urb(cardp->tx_urb);
+
 	usb_fill_bulk_urb(cardp->tx_urb, cardp->udev,
 			  usb_sndbulkpipe(cardp->udev,
 					  cardp->ep_out),
-- 
2.51.0


