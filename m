Return-Path: <stable+bounces-160033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10666AF7BF6
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE97F1CA7A17
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470952253B0;
	Thu,  3 Jul 2025 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o7fn/bj6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE08F227581;
	Thu,  3 Jul 2025 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556155; cv=none; b=W18poZtjKvyRWpGsgIiGn5c8o/ZiM1tkLnTMtk/PQL5Iov/lrXnQjZbP8LXGvA79P3brOLQm3+AusvIqnOo0bwkbLd3bB+5V2izJwxZOXvoxgP20cRHURnzxPZGV54/sG6+T7XKJYzKOCPFfnTqaAseh33JRIvTQb21h5dNhls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556155; c=relaxed/simple;
	bh=YIohKWaqmqNusVzvHc9AtxEJnNNcYs19/WeUxSu2Jb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJ+ERYYUaXCxgosN+rmBJFySyVtJ6VgQyIybgkZTLtZe6ZHhPKSfZdQWQ90O7sFrkU8hi1zqLYgrCBpQU7nmMumcJlI/z6KfCccOqS0ERo7G9pKsnZM0osQs+vtZwKcQh4xn/4QMh1sUuyb0rYQj1j5zC/KSfhLZn7QMP/p9YTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o7fn/bj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAF7C4CEE3;
	Thu,  3 Jul 2025 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751556154;
	bh=YIohKWaqmqNusVzvHc9AtxEJnNNcYs19/WeUxSu2Jb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o7fn/bj6jRN26nukwqsHXKeXC4WUsIIyDNG2hioq8TBswQNhC/soAbT73L0joWIx2
	 KYS1T0KTbWSVIusT6dTb2SuHDcOYRcFicMoNYcCWqGBrzuSyVEE74c+3JW2I4+kiPc
	 5sjW60MIjE1fnaSetQ23o/MokuhR//t7h1b+K9ac=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 6.1 090/132] staging: rtl8723bs: Avoid memset() in aes_cipher() and aes_decipher()
Date: Thu,  3 Jul 2025 16:42:59 +0200
Message-ID: <20250703143942.936755275@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143939.370927276@linuxfoundation.org>
References: <20250703143939.370927276@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

commit a55bc4ffc06d8c965a7d6f0a01ed0ed41380df28 upstream.

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
---
 drivers/staging/rtl8723bs/core/rtw_security.c |   44 ++++++++------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -869,29 +869,21 @@ static signed int aes_cipher(u8 *key, ui
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
@@ -1081,15 +1073,15 @@ static signed int aes_decipher(u8 *key,
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
@@ -1097,14 +1089,6 @@ static signed int aes_decipher(u8 *key,
 
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



