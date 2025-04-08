Return-Path: <stable+bounces-131769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FA6A80EE8
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 16:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F6219E129A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449892AD0C;
	Tue,  8 Apr 2025 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nFvuYi0G"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB2E1C5D61
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744123731; cv=none; b=V7D05JF5JvMPvWc1fwlYopFydko6Uvt6K/P9oJPaudCouX936ZzlnSe2haMuXUN8b2LcLZW8M4X/0HzGEyXK94zUYj5it+CBD3eLIkjC2rnAqzvcQc8otLsuqWIrFCt6djeCn6b7+CmwqB0L5Tc0e6KYbvUF0rTVVeLYCnoEjJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744123731; c=relaxed/simple;
	bh=xs9UidCT3MYnyp8IlbWUPszhMdI9KMudS/gNmSIwYe0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lf+tYG/3oleUo5ZCWVNhSHtqinUmJZG+djuRdM80t/tZ46MG85GmwMPNRhi5835zGzFsw2HfWqOm7Hs4362YyFFL/Aw3+s5z8bm4LEEVfMsR963xqhm9G9Pb0wDBBu2qd+TI1VNA+OaZ24EGoEmjPImKuaZFPCOc4c8BDFXJRPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nFvuYi0G; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744123726;
	bh=xs9UidCT3MYnyp8IlbWUPszhMdI9KMudS/gNmSIwYe0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nFvuYi0G+qyevvHOD6KixZtUSVXDGxtyyuMcIyFvWevcqy5H9SU0l9Pu/Zzo4cdOO
	 TqsMn2VSxd+Fr0nCJShJgxHb5w3XMzlwYOpnbX2+RrKXXZMjhllBj1xbqnbcN0Id1q
	 EUssE2q73mHpkp276bjIDBHj6iQuuN7KNlgH04B7xxQghL5BnDjzj256EppPa6OC53
	 TVT4z9FczCoU8N312WaeKSqLWtfZqVMv2El45Nne26+iDxJOwDjUx1Oiyf5kP7RFwf
	 BzaQXfrkTo62f6z7Pn2ZHb3wfxaMIAMNu/D/AuZWmIGLZsIFPIjXWe5bQRHlO4h8Xa
	 5t/nTnAgW9AMQ==
Received: from [IPv6:2606:6d00:11:e976::5ac] (unknown [IPv6:2606:6d00:11:e976::5ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B3A7A17E0C8D;
	Tue,  8 Apr 2025 16:48:45 +0200 (CEST)
Message-ID: <174c2a14d0fb81326e86e2cbc4954a4fd546c467.camel@collabora.com>
Subject: Re: [PATCH 6.14 059/731] media: verisilicon: HEVC: Initialize
 start_bit field
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>,  Sebastian Fricke
 <sebastian.fricke@collabora.com>, Hans Verkuil <hverkuil@xs4all.nl>, Sasha
 Levin <sashal@kernel.org>
Date: Tue, 08 Apr 2025 10:48:44 -0400
In-Reply-To: <20250408104915.644896685@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
	 <20250408104915.644896685@linuxfoundation.org>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=mQGiBEUQN0MRBACQYceNSezSdMjx7sx6gwKkMghrrODgl3B0eXBTgNp6c431IfOOEsdvk
 oOh1kwoYcQgbg4MXw6beOltysX4e8fFWsiRkc2nvvRW9ir9kHDm49MkBLqaDjTqOkYKNMiurFW+go
 zpr/lUW15QqT6v68RYe0zRdtwGZqeLzX2LVuukGwCg4AISzswrrYHNV7vQLcbaUhPgIl0D+gILYT9
 TJgAEK4YHW+bFRcY+cgUFoLQqQayECMlctKoLOE69nIYOc/hDr9uih1wxrQ/yL0NJvQCohSPyoyLF
 9b2EuIGhQVp05XP7FzlTxhYvGO/DtO08ec85+bTfVBMV6eeY4MS3ZU+1z7ObD7Pf29YjyTehN2Dan
 6w1g2rBk5MoA/9nDocSlk4pbFpsYSFmVHsDiAOFje3+iY4ftVDKunKYWMhwRVBjAREOByBagmRau0
 cLEcElpf4hX5f978GoxSGIsiKoDAlXX+ICDOWC1/EXhEEmBR1gL0QJgiVviNyLfGJlZWnPjw6xhhm
 tHYWTDxBOP5peztyc2PqeKsLsLWzAr7QnTmljb2xhcyBEdWZyZXNuZSA8bmljb2xhc0BuZHVmcmVz
 bmUuY2E+iGIEExECACIFAlXA3CACGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFTAi2sB
 qgcJngAnRDBTr8bhzuH0KQwFP1nEYtfgpKdAKCrQ/sJfuG/8zsd7J8wVl7y3e8ARbRDTmljb2xhcy
 BEdWZyZXNuZSAoQi4gU2MuIEluZm9ybWF0aXF1ZSkgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29
 tPohgBBMRAgAgBQJFlCyOAhsDBgsJCAcDAgQVAggDBBYCAwECHgECF4AACgkQcVMCLawGqBwhLQCg
 zYlrLBj6KIAZ4gmsfjXD6ZtddT8AoIeGDicVq5WvMHNWign6ApQcZUihtElOaWNvbGFzIER1ZnJlc
 25lIChCLiBTYy4gSW5mb3JtYXRpcXVlKSA8bmljb2xhcy5kdWZyZXNuZUBjb2xsYWJvcmEuY28udW
 s+iGIEExECACIFAkuzca8CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFTAi2sBqgcQX8
 An2By6LDEeMxi4B9hUbpvRnzaaeNqAJ9Rox8rfqHZnSErw9bCHiBwvwJZ77QxTmljb2xhcyBEdWZy
 ZXNuZSA8bmljb2xhcy5kdWZyZXNuZUBjb2xsYWJvcmEuY29tPohiBBMRAgAiBQJNzZzPAhsDBgsJC
 AcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRBxUwItrAaoHLlxAKCYAGf4JL7DYDLs/188CPMGuwLypw
 CfWKc9DorA9f5pyYlD5pQo6SgSoiC0R05pY29sYXMgRHVmcmVzbmUgKEIgU2MuIEluZm9ybWF0aXF
 1ZSkgPG5pY29sYXMuZHVmcmVzbmVAdXNoZXJicm9va2UuY2E+iGAEExECACAFAkUQN0MCGwMGCwkI
 BwMCBBUCCAMEFgIDAQIeAQIXgAAKCRBxUwItrAaoHPTnAJ0WGgJJVspoctAvEcI00mtp5WAFGgCgr
 +E7ItOqZEHAs+xabBgknYZIFPU=
Organization: Collabora Canada
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0 (3.56.0-1.fc42) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Le mardi 08 avril 2025 à 12:39 +0200, Greg Kroah-Hartman a écrit :
> 6.14-stable review patch.  If anyone has any objections, please let
> me know.


For the entire set of backport, thanks.

Nicolas

> 
> ------------------
> 
> From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> 
> [ Upstream commit 7fcb42b3835e90ef18d68555934cf72adaf58402 ]
> 
> The HEVC driver needs to set the start_bit field explicitly to avoid
> causing corrupted frames when the VP9 decoder is used in parallel.
> The
> reason for this problem is that the VP9 and the HEVC decoder share
> this
> register.
> 
> Fixes: cb5dd5a0fa51 ("media: hantro: Introduce G2/HEVC decoder")
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c
> b/drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c
> index 85a44143b3786..0e212198dd65b 100644
> --- a/drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c
> +++ b/drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c
> @@ -518,6 +518,7 @@ static void set_buffers(struct hantro_ctx *ctx)
>  	hantro_reg_write(vpu, &g2_stream_len, src_len);
>  	hantro_reg_write(vpu, &g2_strm_buffer_len, src_buf_len);
>  	hantro_reg_write(vpu, &g2_strm_start_offset, 0);
> +	hantro_reg_write(vpu, &g2_start_bit, 0);
>  	hantro_reg_write(vpu, &g2_write_mvs_e, 1);
>  
>  	hantro_write_addr(vpu, G2_TILE_SIZES_ADDR, ctx-
> >hevc_dec.tile_sizes.dma);

