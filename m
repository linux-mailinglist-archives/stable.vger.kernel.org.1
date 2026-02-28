Return-Path: <stable+bounces-220325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePd2GVsxo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:18:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE3E1C5A15
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D263308D87C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775EE395B6E;
	Sat, 28 Feb 2026 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwrAef1e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383F3395B65;
	Sat, 28 Feb 2026 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300226; cv=none; b=CZuSiNFwd118a7aPoOXTyJGYsNyKNFlxd8FdlgCOme7PnzZJ+CEHEJV2xhNkyYRAUPVBeyXPAjnj/hpALS9H3LL4e+2T72VSnVlIsmgWMVb4jYfAIDD6VwK7CipttdIN+XEd9X6yMuLdLiHHnoSA+67THjYh0932tOHdjHgJ0jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300226; c=relaxed/simple;
	bh=6cByhZIvmeZBiTyBxKSnmX8affQe08Fb3O+dT5u/7HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVuRjjC1OvmuKK3OCmhukGYmo6sAeOhoShJl4Vn/r+cxlEz1CzfSLryBY/vVVXohg5kos1AYce+TCS/AxTBywWVLmhq5n1QtTKKQkJINIwS/kfRYJholssSKHlPQzucUY0AzlRCawpheh6ENSMBLC3eAIDb1HUu8GW/AK5CvyeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwrAef1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F4BC116D0;
	Sat, 28 Feb 2026 17:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300226;
	bh=6cByhZIvmeZBiTyBxKSnmX8affQe08Fb3O+dT5u/7HI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UwrAef1ePWpjbPY+WbaBWIHlVOPnm6q+zr/XimTRlRm5ZUT21awXXjwE/DidfdQyQ
	 Bup5iYGPJubWVireCBpRHfBHX0/rSiWEvs2OemKhbe0m0dOwzO4HMzz/iVhasfNShz
	 iSpmFkB2DANHTIsZAItUF2zH68KVlYVFo8kji/a+YITR8LptNliCMaNP7yU7xb7ezV
	 +qXefh385BcLRMGxJB+KF78tjDQXex62KnGnJQAaatjABNqGrNMNk/3xj8/yZBUE4q
	 I98Q4Ao+TqCGpyg2o7VBgMpjOOeINzqKqkyD2M1w15M+SCdfsC9KPkPVRSYDqPLAfJ
	 eMOndgOi7jLXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lianqin Hu <hulianqin@vivo.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 247/844] ALSA: usb-audio: Add iface reset and delay quirk for AB13X USB Audio
Date: Sat, 28 Feb 2026 12:22:40 -0500
Message-ID: <20260228173244.1509663-248-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220325-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,vivo.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 1FE3E1C5A15
X-Rspamd-Action: no action

From: Lianqin Hu <hulianqin@vivo.com>

[ Upstream commit ac656d7d7c70f7c352c7652bc2bb0c1c8c2dde08 ]

Setting up the interface when suspended/resumeing fail on this card.
Adding a reset and delay quirk will eliminate this problem.

usb 1-1: New USB device found, idVendor=001f, idProduct=0b21
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: AB13X USB Audio
usb 1-1: Manufacturer: Generic
usb 1-1: SerialNumber: 20210926172016

Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
Link: https://patch.msgid.link/TYUPR06MB6217522D0DB6E2C9DF46B56ED265A@TYUPR06MB6217.apcprd06.prod.outlook.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 7fabaeb3781a2..86c329632e396 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2146,6 +2146,8 @@ struct usb_audio_quirk_flags_table {
 
 static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	/* Device matches */
+	DEVICE_FLG(0x001f, 0x0b21, /* AB13X USB Audio */
+		   QUIRK_FLAG_FORCE_IFACE_RESET | QUIRK_FLAG_IFACE_DELAY),
 	DEVICE_FLG(0x03f0, 0x654a, /* HP 320 FHD Webcam */
 		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_MIC_RES_16),
 	DEVICE_FLG(0x041e, 0x3000, /* Creative SB Extigy */
-- 
2.51.0


