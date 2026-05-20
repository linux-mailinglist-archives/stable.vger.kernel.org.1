Return-Path: <stable+bounces-251269-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPkNJtoYDmqA6AUAu9opvQ
	(envelope-from <stable+bounces-251269-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:26:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E80B5599921
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80C6233EA2C2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3CD36A352;
	Wed, 20 May 2026 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AmY+wDkB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13D32DC76C;
	Wed, 20 May 2026 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297544; cv=none; b=mYubkSihlcJQO5sjamJkzx30KJRuUlqG2p6iK4PCzX1MwZQsyt/XBK1zWZ1TaHh/02WeUqs4e9XXMHmkUxAjU9srk/3IuwpDG/i0WfFzzFd1zAp1FUPqNdufCEIBwuvDUfQXYuIF+j6oytRNGAPrS+vloLpZvhudLQXqa5u7P7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297544; c=relaxed/simple;
	bh=GVEnSkoN1xuQkrurUS8NsJdyJBYzefPcA9/RGX27J/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAoAoEO4oSuAeU2anBSHqW2/2U51OenZKsNyuZkljAEsvWKwqGbm+tZb51xBOVyt118/JF7dPDs5qVTgT5vPSr7ry3lRuTCiRVnOJYOQgeEtJ8JFV0LpO2ffp+q8bWly/YIt6s/1wmrEi453Rv5+1QcuoidC4Xc0TRQYOSECyYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AmY+wDkB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B191F000E9;
	Wed, 20 May 2026 17:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297542;
	bh=VvqBitUhEm3kqj8ps6j7c2kAygTSY2b7IkurU4R3TlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AmY+wDkByBx6uehcED0neArW+N4EhbMp2RoYyDCZ54ev1J2N+s44yfsXgXVzR61ZV
	 Lme0MARqIxgR4KHMoIzWNal8xDKtqow8DbjWoZ00CAmEKDKOQh7VLzDqu5sXrczJiV
	 cZeoN2+AFb1sJFDvDfe/uYMWO5LIFm7vYHpM5y/A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+74afbb6355826ffc2239@syzkaller.appspotmail.com,
	Heitor Alves de Siqueira <halves@igalia.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 070/957] wifi: libertas: dont kill URBs in interrupt context
Date: Wed, 20 May 2026 18:09:13 +0200
Message-ID: <20260520162136.082547048@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251269-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,74afbb6355826ffc2239];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,syzkaller.appspot.com:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,igalia.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: E80B5599921
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heitor Alves de Siqueira <halves@igalia.com>

[ Upstream commit 7c5c2b661bdb78c1472b8833265c9ed1ee880039 ]

Serialization for the TX path was enforced by calling
usb_kill_urb()/usb_kill_anchored_urbs(), to prevent transmission before
a previous URB was completed. usb_tx_block() can be called from
interrupt context (e.g. in the HCD giveback path), so we can't always
use it to kill in-flight URBs.

Prevent sleeping during interrupt context by checking the tx_submitted
anchor for existing URBs. We now return -EBUSY, to indicate there's
a pending request.

Reported-by: syzbot+74afbb6355826ffc2239@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=74afbb6355826ffc2239
Fixes: d66676e6ca96 ("wifi: libertas: fix WARNING in usb_tx_block")
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
Link: https://patch.msgid.link/20260313-libertas-usb-anchors-v1-2-915afbe988d7@igalia.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/libertas/if_usb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net/wireless/marvell/libertas/if_usb.c
index 60bfff523b918..f6b9a3c43c93c 100644
--- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -429,7 +429,12 @@ static int usb_tx_block(struct if_usb_card *cardp, uint8_t *payload, uint16_t nb
 		goto tx_ret;
 	}
 
-	usb_kill_anchored_urbs(&cardp->tx_submitted);
+	/* check if there are pending URBs */
+	if (!usb_anchor_empty(&cardp->tx_submitted)) {
+		lbs_deb_usbd(&cardp->udev->dev, "%s failed: pending URB\n", __func__);
+		ret = -EBUSY;
+		goto tx_ret;
+	}
 
 	usb_fill_bulk_urb(cardp->tx_urb, cardp->udev,
 			  usb_sndbulkpipe(cardp->udev,
-- 
2.53.0




