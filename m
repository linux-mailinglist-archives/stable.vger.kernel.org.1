Return-Path: <stable+bounces-158895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4C7AED86E
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670451622A8
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 09:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFF61F2BB8;
	Mon, 30 Jun 2025 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F5DNTiiy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFAB1DF97D
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275078; cv=none; b=dtfzpOyiBgYljcKiURfbNZMp6hul/jFUtuWRIdzToq7t/d0JDIgcGqM6phPjyenLV1c7UkVV5+ePT0QGYgUHfe0tw94/Qb7wd0C8k+osvC5edPb3Iif2wWq2l5DscHB/J7N2ktRubGrJUMj36f/l1lvW5Vt4c5sVIwPIWJaOnQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275078; c=relaxed/simple;
	bh=Y4laI1JKLIxINcmOzs4NzyU8n0Tys6ZxNfM6uGSKr0k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EHs1RoB0zRwKCsA4lJy6sSlQyDzTFiZLWWiN8Nj+ApsRxyiyS4K6yuHHz1nSOa3pVf3FwGFXc7ZTk/FGsPot7HnL8TAJa0CtBFOz+oxrXt2II0dBkY9YsJDILfedvPn/jFOQbWY3ppm5rcVA0ZjWfGEXfBA15svXRk7iamQyNLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F5DNTiiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D45C4CEE3;
	Mon, 30 Jun 2025 09:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751275078;
	bh=Y4laI1JKLIxINcmOzs4NzyU8n0Tys6ZxNfM6uGSKr0k=;
	h=Subject:To:Cc:From:Date:From;
	b=F5DNTiiyQNtOWSVF/MaurmVntbYdAZo010nXOEr34VlbWfxzC4DChDFWpDb6AS1+Y
	 4Wbm9z2OepKtYbJjTKtgviaGQSY+cZA9JRGBWKA4Elc5GV+rRge6JzUbeuRL618dvg
	 BxAO0AEBvroxhlWPnugbxnGIBlcUuuZfGuX13NGI=
Subject: FAILED: patch "[PATCH] staging: rtl8723bs: Avoid memset() in aes_cipher() and" failed to apply to 5.10-stable tree
To: nathan@kernel.org,dan.carpenter@linaro.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 11:17:55 +0200
Message-ID: <2025063055-overfed-dispute-71ba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a55bc4ffc06d8c965a7d6f0a01ed0ed41380df28
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063055-overfed-dispute-71ba@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a55bc4ffc06d8c965a7d6f0a01ed0ed41380df28 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 9 Jun 2025 14:13:14 -0700
Subject: [PATCH] staging: rtl8723bs: Avoid memset() in aes_cipher() and
 aes_decipher()

After commit 6f110a5e4f99 ("Disable SLUB_TINY for build testing"), which
causes CONFIG_KASAN to be enabled in allmodconfig again, arm64
allmodconfig builds with older versions of clang (15 through 17) show an
instance of -Wframe-larger-than (which breaks the build with
CONFIG_WERROR=y):

  drivers/staging/rtl8723bs/core/rtw_security.c:1287:5: error: stack frame size (2208) exceeds limit (2048) in 'rtw_aes_decrypt' [-Werror,-Wframe-larger-than]
   1287 | u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
        |     ^

This comes from aes_decipher() being inlined in rtw_aes_decrypt().
Running the same build with CONFIG_FRAME_WARN=128 shows aes_cipher()
also uses a decent amount of stack, just under the limit of 2048:

  drivers/staging/rtl8723bs/core/rtw_security.c:864:19: warning: stack frame size (1952) exceeds limit (128) in 'aes_cipher' [-Wframe-larger-than]
    864 | static signed int aes_cipher(u8 *key, uint      hdrlen,
        |                   ^

-Rpass-analysis=stack-frame-layout only shows one large structure on the
stack, which is the ctx variable inlined from aes128k128d(). A good
number of the other variables come from the additional checks of
fortified string routines, which are present in memset(), which both
aes_cipher() and aes_decipher() use to initialize some temporary
buffers. In this case, since the size is known at compile time, these
additional checks should not result in any code generation changes but
allmodconfig has several sanitizers enabled, which may make it harder
for the compiler to eliminate the compile time checks and the variables
that come about from them.

The memset() calls are just initializing these buffers to zero, so use
'= {}' instead, which is used all over the kernel and does the exact
same thing as memset() without the fortify checks, which drops the stack
usage of these functions by a few hundred kilobytes.

  drivers/staging/rtl8723bs/core/rtw_security.c:864:19: warning: stack frame size (1584) exceeds limit (128) in 'aes_cipher' [-Wframe-larger-than]
    864 | static signed int aes_cipher(u8 *key, uint      hdrlen,
        |                   ^
  drivers/staging/rtl8723bs/core/rtw_security.c:1271:5: warning: stack frame size (1456) exceeds limit (128) in 'rtw_aes_decrypt' [-Wframe-larger-than]
   1271 | u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
        |     ^

Cc: stable@vger.kernel.org
Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/20250609-rtl8723bs-fix-clang-arm64-wflt-v1-1-e2accba43def@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 1e9eff01b1aa..e9f382c280d9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -868,29 +868,21 @@ static signed int aes_cipher(u8 *key, uint	hdrlen,
 		num_blocks, payload_index;
 
 	u8 pn_vector[6];
-	u8 mic_iv[16];
-	u8 mic_header1[16];
-	u8 mic_header2[16];
-	u8 ctr_preload[16];
+	u8 mic_iv[16] = {};
+	u8 mic_header1[16] = {};
+	u8 mic_header2[16] = {};
+	u8 ctr_preload[16] = {};
 
 	/* Intermediate Buffers */
-	u8 chain_buffer[16];
-	u8 aes_out[16];
-	u8 padded_buffer[16];
+	u8 chain_buffer[16] = {};
+	u8 aes_out[16] = {};
+	u8 padded_buffer[16] = {};
 	u8 mic[8];
 	uint	frtype  = GetFrameType(pframe);
 	uint	frsubtype  = GetFrameSubType(pframe);
 
 	frsubtype = frsubtype>>4;
 
-	memset((void *)mic_iv, 0, 16);
-	memset((void *)mic_header1, 0, 16);
-	memset((void *)mic_header2, 0, 16);
-	memset((void *)ctr_preload, 0, 16);
-	memset((void *)chain_buffer, 0, 16);
-	memset((void *)aes_out, 0, 16);
-	memset((void *)padded_buffer, 0, 16);
-
 	if ((hdrlen == WLAN_HDR_A3_LEN) || (hdrlen ==  WLAN_HDR_A3_QOS_LEN))
 		a4_exists = 0;
 	else
@@ -1080,15 +1072,15 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 			num_blocks, payload_index;
 	signed int res = _SUCCESS;
 	u8 pn_vector[6];
-	u8 mic_iv[16];
-	u8 mic_header1[16];
-	u8 mic_header2[16];
-	u8 ctr_preload[16];
+	u8 mic_iv[16] = {};
+	u8 mic_header1[16] = {};
+	u8 mic_header2[16] = {};
+	u8 ctr_preload[16] = {};
 
 		/* Intermediate Buffers */
-	u8 chain_buffer[16];
-	u8 aes_out[16];
-	u8 padded_buffer[16];
+	u8 chain_buffer[16] = {};
+	u8 aes_out[16] = {};
+	u8 padded_buffer[16] = {};
 	u8 mic[8];
 
 	uint frtype  = GetFrameType(pframe);
@@ -1096,14 +1088,6 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 
 	frsubtype = frsubtype>>4;
 
-	memset((void *)mic_iv, 0, 16);
-	memset((void *)mic_header1, 0, 16);
-	memset((void *)mic_header2, 0, 16);
-	memset((void *)ctr_preload, 0, 16);
-	memset((void *)chain_buffer, 0, 16);
-	memset((void *)aes_out, 0, 16);
-	memset((void *)padded_buffer, 0, 16);
-
 	/* start to decrypt the payload */
 
 	num_blocks = (plen-8) / 16; /* plen including LLC, payload_length and mic) */


