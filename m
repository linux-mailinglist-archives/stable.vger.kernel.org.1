Return-Path: <stable+bounces-220350-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BtpDCo1o2kI+gQAu9opvQ
	(envelope-from <stable+bounces-220350-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:34:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEEC1C5F74
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A78B030FC169
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C066E39D33F;
	Sat, 28 Feb 2026 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue33K5Ms"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED0539D335;
	Sat, 28 Feb 2026 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300248; cv=none; b=WIdDcYcZseIUK7NyOSc7NkfSxqx5luTAp8XJUM78WpndJPcLlNCN82XOpvY+9d+4UlhhGpl57qZUAEVXC82+HMgjP9iCb8+hhFNU9Vu2LaFn33XPFO4c+axV9e+BRq0M/BqNemlb/6T0C1YECyliGmfSnyBlwZrO6ipymwWjE3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300248; c=relaxed/simple;
	bh=ait0UnyhWWr6Thg9BUSixOwDijx3Xm4bJINamHlf2ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrMTS0v8RBMAfP0QxT2UfaTt0P9OJlz7GJztWxqTkkhpbWRHK61UNQLHyD4aavYjvvZ1S7pCx1YHW78MjQWa3CZYG5Pr27LOIr0nfXCoS8/6XQt7b4mgvsjHtTW9TGroEFdQQg2tijfAdviiXUX9df1gd0FqRWyX2/4Nhgabyu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ue33K5Ms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D65C19425;
	Sat, 28 Feb 2026 17:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300248;
	bh=ait0UnyhWWr6Thg9BUSixOwDijx3Xm4bJINamHlf2ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ue33K5Mslj/9WAQyXZAYcq90tvypHN06tvFbr8/RrK1cxvZIARCLJ3ks+hrhPk2kl
	 SY8QmcbvioEryxFQq4GYLPBxLVB3xRFD5SePtzCNxHLtqV3RH148JLgvBwyOXj+Ot5
	 vuU26UyHHKFonBJ9j7XWTLjKogc3M1xXVid5akNNr0nYTOc2T8Qb3IqMAqmlxhuCrw
	 PHUEDlhVpYzstkb0Sm484U1hploero6QTPcETvcx46nTDlLh8/8PIk3Sxrg82hJ8xL
	 XeSbYlPPENhau6Rgf91gxRK5ThetgDK9ChdpMh569m4FUsXMPGgiBXmK7aec43y99n
	 8Q6rDyoFuvypw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zenm Chen <zenmchen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 272/844] wifi: rtw89: Add support for D-Link VR Air Bridge (DWA-F18)
Date: Sat, 28 Feb 2026 12:23:05 -0500
Message-ID: <20260228173244.1509663-273-sashal@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220350-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9FEEC1C5F74
X-Rspamd-Action: no action

From: Zenm Chen <zenmchen@gmail.com>

[ Upstream commit 292c0bc8acb687de7e83fc454bb98af19187b6bf ]

Add the ID 2001:3323 to the table to support an additional RTL8832AU
adapter: D-Link VR Air Bridge (DWA-F18).

Compile tested only.

Link: https://github.com/morrownr/rtw89/pull/44
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260112004759.6028-1-zenmchen@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/rtw8852au.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852au.c b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
index 74a976c984ad8..ccdbcc178c2a4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852au.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
@@ -52,6 +52,8 @@ static const struct usb_device_id rtw_8852au_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3321, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3323, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x332c, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x013f, 0xff, 0xff, 0xff),
-- 
2.51.0


