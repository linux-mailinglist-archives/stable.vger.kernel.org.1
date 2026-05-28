Return-Path: <stable+bounces-255944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALydLdinGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:38:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 529085F933A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F19F931321F3
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EF531DD97;
	Thu, 28 May 2026 20:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VAHgUQ1N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE82313550;
	Thu, 28 May 2026 20:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000316; cv=none; b=hxijYJDNx/Oz1IRHFldVht7OiFEnjc7VdhapmODa9bQIQxIxoR9Wp9SRD25Whuzta0oZjmVNdZyDPOgOkQntIP+8o00rbTrIMY5DmoFcCbkPBRYfKmM+i7MnVKKcvBTqJ6Tc+z9oYmmC4osAdCxir3HDWcLjfazdbCXEl3omqek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000316; c=relaxed/simple;
	bh=G4Ojz9deQ72q9wQyrSj7KhZoL8PfZY0aolNIMG5NlYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hu7MwEHbOXxbH5GTPE1Tbsp6xf7CtH7R2/65U/Rt2y8cKdSZ75wSKo8dYY8AYiLhgLoUm597dOWoayLqnKo092zqnAC+unYbx98+QCUqRo9be0eHaUi/w2es6VrtzgVYa2EVDkhtYfZ+KSH6yd33wTVqOgcKcBDOmXXu/At+alQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VAHgUQ1N; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493EF1F000E9;
	Thu, 28 May 2026 20:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000315;
	bh=8w/mJSoMtTLC/CdPMnm0GN8j8M0IGgcOoM+c+Grap4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VAHgUQ1N6we1poMJTg5Dl9eVdTV/G4lwGQ82WZl4xjXB435FTPXNvBB7439BMK3yA
	 DYO1pVlZZMofDuURWxWP3F5789LR91ZVWvHuR8hr4sYMKHds7/K0SlR1UY8Oy7MQUK
	 7cm3hmqXx0Xrc+8DUAD0hJUo9X6Inui6exNdcdZU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiajia Liu <liujiajia@kylinos.cn>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 353/377] Bluetooth: btmtk: fix urb->setup_packet leak in error paths
Date: Thu, 28 May 2026 21:49:51 +0200
Message-ID: <20260528194648.646129407@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255944-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,kylinos.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 529085F933A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index cf05746e9db5a..38ba8f2bd2f96 100644
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




