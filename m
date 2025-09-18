Return-Path: <stable+bounces-178775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9FFB48005
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78643ADCDF
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AF31F12F4;
	Sun,  7 Sep 2025 20:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OdW5DpP/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F397E107;
	Sun,  7 Sep 2025 20:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757277920; cv=none; b=pISXwyQ52fSDFPuOw6SPV6uxj+N0wbxctNXD+VIxFWm4ru58hY0SynHoeOf/ItcPVsIsnVFXnTjrmc3dmcefQwjc7aFD+K+2WdXIHff3YEHfrhE7b6g7+gM3C6ywCtkGIvHWHcempfvjAn8LZlfUchEcJ5H48K6uIzPa/vBpufU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757277920; c=relaxed/simple;
	bh=w2ccw3sx9rNaWCF4aNp7ZOzFNoid0Ge1gQwkPNri1YU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqilpO1EwGckPrDEQfm3pcMJv82j8YfSqkcU+7lapd6CX+PDcn7j9G/H7L2SJvzPc0Gy/jfUJufZDgejHQTemEJS2j/Q6FScdLZIX8WWlFylBhNvbZs4Pfr5qteZkRIHbrECo+Br2UTFPBc0jAXSnyP37Ep0p7AIjbzY1KeH/J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OdW5DpP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12365C4CEF0;
	Sun,  7 Sep 2025 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757277918;
	bh=w2ccw3sx9rNaWCF4aNp7ZOzFNoid0Ge1gQwkPNri1YU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OdW5DpP/8fYYi+KJrCsEsxWiQ0tXUVbIxCEPDkLFL48sOnzQtquqMeHg4Aahu6xO2
	 f2tSmGm2IC2sMeiSBbGm6c+D3HDZYOvAuZzsJ1tmkaCFRlu49n2mOZthvHFud8xmU5
	 uHjiLYtbcyXFE7rziJZqfxif88pWVeoURlGhiMZs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 6.16 120/183] wifi: mt76: mt7996: Initialize hdr before passing to skb_put_data()
Date: Sun,  7 Sep 2025 21:59:07 +0200
Message-ID: <20250907195618.643161943@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
References: <20250907195615.802693401@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

commit 87b07a1fbc6b5c23d3b3584ab4288bc9106d3274 upstream.

A new warning in clang [1] points out a couple of places where a hdr
variable is not initialized then passed along to skb_put_data().

  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:1894:21: warning: variable 'hdr' is uninitialized when passed as a const pointer argument here [-Wuninitialized-const-pointer]
   1894 |         skb_put_data(skb, &hdr, sizeof(hdr));
        |                            ^~~
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:3386:21: warning: variable 'hdr' is uninitialized when passed as a const pointer argument here [-Wuninitialized-const-pointer]
   3386 |         skb_put_data(skb, &hdr, sizeof(hdr));
        |                            ^~~

Zero initialize these headers as done in other places in the driver when
there is nothing stored in the header.

Cc: stable@vger.kernel.org
Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Link: https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e [1]
Closes: https://github.com/ClangBuiltLinux/linux/issues/2104
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Link: https://patch.msgid.link/20250715-mt7996-fix-uninit-const-pointer-v1-1-b5d8d11d7b78@kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1879,8 +1879,8 @@ mt7996_mcu_get_mmps_mode(enum ieee80211_
 int mt7996_mcu_set_fixed_rate_ctrl(struct mt7996_dev *dev,
 				   void *data, u16 version)
 {
+	struct uni_header hdr = {};
 	struct ra_fixed_rate *req;
-	struct uni_header hdr;
 	struct sk_buff *skb;
 	struct tlv *tlv;
 	int len;
@@ -3377,7 +3377,7 @@ int mt7996_mcu_set_hdr_trans(struct mt79
 {
 	struct {
 		u8 __rsv[4];
-	} __packed hdr;
+	} __packed hdr = {};
 	struct hdr_trans_blacklist *req_blacklist;
 	struct hdr_trans_en *req_en;
 	struct sk_buff *skb;



