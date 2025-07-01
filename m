Return-Path: <stable+bounces-159155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB747AEFE06
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 17:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0B33B6D3C
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 15:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69619279331;
	Tue,  1 Jul 2025 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1SLSVPG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2862526F44C
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383438; cv=none; b=Pxok59/BnzAenJNsONcPvSC99Cmkbzu8FJO0Qt1PW4W5NA6EMV9mtM+/SCTZIW79wijJOhCBGB9HAEMhXFNYkztXtL5IrRJz6ursgiPL7MvZsblSfOaZ61pFngPX6TpBUWcIKsVVjxA1BBFGL4rLzJQREAhz9RNZ0zJYwykQYt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383438; c=relaxed/simple;
	bh=8fGk8ccn0PBE55Br8FfS0s8A/t59X02TR723cHLWSmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDFPHi7T4LdFXU7UPg/l4FlWGSlueRHvxtnWycOk74TyKTSA8Qafg8z3Uz6L0kwk/Dqto3guhFzKSrJs48niyZD1xweSavx2EXSkOQ859ZHR7yAhI2ryIWwal/f3K5Cc9muFNKrvWvoIyrwhyzUVjGkV6MxtHzN5TzB9Uq7IjQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1SLSVPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634D7C4CEEB;
	Tue,  1 Jul 2025 15:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751383437;
	bh=8fGk8ccn0PBE55Br8FfS0s8A/t59X02TR723cHLWSmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1SLSVPGycYW2TNJczV+j2U5BCX9I8d5JGMkGpO4znrZYxnv1J+wSNKpTC03PaWp0
	 32R+Ufh/rKh7lAZserbkETV3urNNPqvEdvazQDEE9D8if0qKWyQbQUJ8tJW/9Fh9xM
	 PGH8c0KXDnRb7JOeNTJtlU12cz2w74hbcEEgKi/m0qLRXp1NMwVJZO4xWhkUU7qCz0
	 jx+hwzzINNOljngUmAEmFXChUmMBNXzBnWSuQ4dUvEsKwUfRA+t2sCuyTqqVtycoNr
	 UaXzxouW3ugb2euRA88ywxhzRYaenWYaTWdauC4mlpib0gHUOsw+LvcMtrkwZDDMHm
	 U63TX8RDmJHhg==
From: Nathan Chancellor <nathan@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	nathan@kernel.org,
	dan.carpenter@linaro.org
Subject: [PATCH 5.10 and 5.4] staging: rtl8723bs: Avoid memset() in aes_cipher() and aes_decipher()
Date: Tue,  1 Jul 2025 08:23:24 -0700
Message-ID: <20250701152324.3571007-1-nathan@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <2025063055-overfed-dispute-71ba@gregkh>
References: <2025063055-overfed-dispute-71ba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 46 ++++++-------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 159d32ace2bc..cc709e849f39 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -1299,30 +1299,21 @@ static sint aes_cipher(u8 *key, uint	hdrlen,
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
 
-
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
@@ -1540,15 +1531,15 @@ static sint aes_decipher(u8 *key, uint	hdrlen,
 			num_blocks, payload_index;
 	sint res = _SUCCESS;
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
 
 
@@ -1557,15 +1548,6 @@ static sint aes_decipher(u8 *key, uint	hdrlen,
 
 	frsubtype = frsubtype>>4;
 
-
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
-- 
2.50.0


