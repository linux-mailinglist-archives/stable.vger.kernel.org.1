Return-Path: <stable+bounces-256202-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M+ACs2qGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256202-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:51:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 833E05F9B54
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DAA5313FE83
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6EC33372A;
	Thu, 28 May 2026 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K2I9k1fp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C0D339866;
	Thu, 28 May 2026 20:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001041; cv=none; b=APja5XM1lQ1dLcd/wyeonJz9CFsCj3nC6+TkM6aDyiSAxycRF+jyd74q1gDU7Rg8Ym0Lao75XKVcPtAB2d5C6Hbfbf+6Ydj/MQCD0yVVRXA8s4+amBiYyZXIYFSeszTyKjUiTWGUHjPXPz9PlpA1NXSRQ//EuoFn4foX28GK9QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001041; c=relaxed/simple;
	bh=41St2Lz2stu0lSD/Lvs7eT6ydDMNNBhmoAaywyWVt20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+unIMa9WQFXn93NdRUsjuWpAMDIsdQ93Q1lmK69TBeSvRQwVxbKCV/rZD3zViZ145NH+mVWwn6+12nHmC3EqfI9ryOZIC1Vfj0V3+0RbmOeHkfWrrk3OOU7WhpyZW0xW9voOMfSCMzMFg97Rck/0B2sKgmsRa0oazbheoTZQlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K2I9k1fp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A340B1F000E9;
	Thu, 28 May 2026 20:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001040;
	bh=6NjDfCmXKdTDduFBX1t8QV5mSi8Kpda42uSq65Y92x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K2I9k1fpernJXplB7Ugj+CRq1VMzDcsFiQjNpnOVB1/suxhGy6y+7pmAoZGniXfD8
	 Wxd7SMaEfOpPuHl9CMIuL41BaJ7T7JklT+Pt4iMM5OEmeQ3W+/xPxw2V9N2J0S/t5V
	 2cNKbBrgSyXFxZowQiqloLaU22GBgHLbTMFf0sHs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiajia Liu <liujiajia@kylinos.cn>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 260/272] Bluetooth: btmtk: fix urb->setup_packet leak in error paths
Date: Thu, 28 May 2026 21:50:34 +0200
Message-ID: <20260528194636.376852407@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256202-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,kylinos.cn:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 833E05F9B54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiajia Liu <liujiajia@kylinos.cn>

[ Upstream commit dd1dda6b8d6e1f4376a5b3055a04f0ecbdb4d6bd ]

The setup_packet of control urb is not freed if usb_submit_urb fails or
the submitted urb is killed. Add free in these two paths.

Fixes: a1c49c434e150 ("Bluetooth: btusb: Add protocol support for MediaTek MT7668U USB devices")
Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btmtk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 98cb8529d8bcd..08a8c3a5d7b7d 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -496,6 +496,7 @@ static void btmtk_usb_wmt_recv(struct urb *urb)
 		return;
 	} else if (urb->status == -ENOENT) {
 		/* Avoid suspend failed when usb_kill_urb */
+		kfree(urb->setup_packet);
 		return;
 	}
 
@@ -569,6 +570,7 @@ static int btmtk_usb_submit_wmt_recv_urb(struct hci_dev *hdev)
 		if (err != -EPERM && err != -ENODEV)
 			bt_dev_err(hdev, "urb %p submission failed (%d)",
 				   urb, -err);
+		kfree(dr);
 		usb_unanchor_urb(urb);
 	}
 
-- 
2.53.0




