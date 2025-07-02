Return-Path: <stable+bounces-159182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D807AF08D6
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 05:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A5B4A5DE9
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 03:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D123C47B;
	Wed,  2 Jul 2025 03:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCJNXREF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A3423B0
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 03:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751425370; cv=none; b=DjRtJVn6hxEOtCULXkQBKm1UGWp5qvAggMBGbL/RKNki4LtVk1WwP3AZFkq67H6SyD4sXC/4OnFXfuX7NxBMHDQIrr/1Cp2JXztUZD4azUhHbIVPtstUDmSwwLupu/ONhH8XiVn3zvg8aFA4v7MSG7hwR508E4mrD5cEBcCfnfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751425370; c=relaxed/simple;
	bh=3BeZV52G7LNe+l2AbAwMOK1ym02PisGmpQlRT8oRfYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eau1i2+6XbXPRl9TtuYVLgkhlprBWhTwnxfsEhK7sWhrNR27G+iMlJyBkD58atFetC7/M586Ct60bVJoQDH/Y36y3RxgEPaYWAgM9viiWeo2cKVs3VDHhMivInGh38WiTAoHU22ojCjZK3YNfWM27qWO4rsqPG92N5hfQWO70ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCJNXREF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC6BC4CEEF;
	Wed,  2 Jul 2025 03:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751425370;
	bh=3BeZV52G7LNe+l2AbAwMOK1ym02PisGmpQlRT8oRfYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kCJNXREF+OnUJEphurLorBzP0owgJy0p3JTSsme3b63Q4rqw8Mz6nj64NFGRBu82r
	 O2ZgIa6s3zdU66aEKkbw0mJ3z+xD5o0Yl41df7LExVJE8A90+vJf8R4ug3IDn6ELHn
	 gJ9uRFT/kRcCZyXYs3g8qB853d+TxfvFJw0vpYnXAwpDiLUSdCniRZW052PCQQaeFN
	 RhwnLakbY6t1ZhZw/4PWQhVCk0YNEOFLlxTpY2kmx2LddUIHMSaPNnk8BoBEi0xBKP
	 jIiQ+0Hk4TbTR8Y08mHn3gPvDUYJAojAejCJAYHbzd+pIS0XH62IN5Xil6qWg4PDnv
	 2iFZWDaNcfvuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 and 5.4] staging: rtl8723bs: Avoid memset() in aes_cipher() and aes_decipher()
Date: Tue,  1 Jul 2025 23:02:48 -0400
Message-Id: <20250701211415-f25753bf340e041d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250701152324.3571007-1-nathan@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: a55bc4ffc06d8c965a7d6f0a01ed0ed41380df28

Status in newer kernel trees:
6.15.y | Present (different SHA1: 53d7bf452fe7)
6.12.y | Present (different SHA1: 5da335f62003)
6.6.y | Present (different SHA1: b62980fa236b)
6.1.y | Present (different SHA1: 5d678ffa4843)
5.15.y | Present (different SHA1: 4b29ab1d5c42)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a55bc4ffc06d8 ! 1:  72e918d867583 staging: rtl8723bs: Avoid memset() in aes_cipher() and aes_decipher()
    @@ Metadata
      ## Commit message ##
         staging: rtl8723bs: Avoid memset() in aes_cipher() and aes_decipher()
     
    +    commit a55bc4ffc06d8c965a7d6f0a01ed0ed41380df28 upstream.
    +
         After commit 6f110a5e4f99 ("Disable SLUB_TINY for build testing"), which
         causes CONFIG_KASAN to be enabled in allmodconfig again, arm64
         allmodconfig builds with older versions of clang (15 through 17) show an
    @@ Commit message
         Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
         Link: https://lore.kernel.org/r/20250609-rtl8723bs-fix-clang-arm64-wflt-v1-1-e2accba43def@kernel.org
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Signed-off-by: Nathan Chancellor <nathan@kernel.org>
     
      ## drivers/staging/rtl8723bs/core/rtw_security.c ##
    -@@ drivers/staging/rtl8723bs/core/rtw_security.c: static signed int aes_cipher(u8 *key, uint	hdrlen,
    +@@ drivers/staging/rtl8723bs/core/rtw_security.c: static sint aes_cipher(u8 *key, uint	hdrlen,
      		num_blocks, payload_index;
      
      	u8 pn_vector[6];
    @@ drivers/staging/rtl8723bs/core/rtw_security.c: static signed int aes_cipher(u8 *
      
      	frsubtype = frsubtype>>4;
      
    +-
     -	memset((void *)mic_iv, 0, 16);
     -	memset((void *)mic_header1, 0, 16);
     -	memset((void *)mic_header2, 0, 16);
    @@ drivers/staging/rtl8723bs/core/rtw_security.c: static signed int aes_cipher(u8 *
      	if ((hdrlen == WLAN_HDR_A3_LEN) || (hdrlen ==  WLAN_HDR_A3_QOS_LEN))
      		a4_exists = 0;
      	else
    -@@ drivers/staging/rtl8723bs/core/rtw_security.c: static signed int aes_decipher(u8 *key, uint	hdrlen,
    +@@ drivers/staging/rtl8723bs/core/rtw_security.c: static sint aes_decipher(u8 *key, uint	hdrlen,
      			num_blocks, payload_index;
    - 	signed int res = _SUCCESS;
    + 	sint res = _SUCCESS;
      	u8 pn_vector[6];
     -	u8 mic_iv[16];
     -	u8 mic_header1[16];
    @@ drivers/staging/rtl8723bs/core/rtw_security.c: static signed int aes_decipher(u8
     +	u8 padded_buffer[16] = {};
      	u8 mic[8];
      
    - 	uint frtype  = GetFrameType(pframe);
    -@@ drivers/staging/rtl8723bs/core/rtw_security.c: static signed int aes_decipher(u8 *key, uint	hdrlen,
    + 
    +@@ drivers/staging/rtl8723bs/core/rtw_security.c: static sint aes_decipher(u8 *key, uint	hdrlen,
      
      	frsubtype = frsubtype>>4;
      
    +-
     -	memset((void *)mic_iv, 0, 16);
     -	memset((void *)mic_header1, 0, 16);
     -	memset((void *)mic_header2, 0, 16);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |

