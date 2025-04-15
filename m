Return-Path: <stable+bounces-132701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 565A0A894E6
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 09:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA11D3AAFC0
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 07:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41673274FC7;
	Tue, 15 Apr 2025 07:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+soWiVh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B224275105
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702010; cv=none; b=qLxG9sQgqj9b1lK6estlpIve64imZL41Ljxmq7nhqZ2x6WwnOPIWb0EN47FLyBCfMq2ox4kBFIqiyCJmpy1FFk67F2QXVuWmdm56A5CdrbO7cCsjOWNhx+Up0WsDH0ajQYQKNoaueAytg0FC0r2slVr48QPv8+56iEl5VZfS2yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702010; c=relaxed/simple;
	bh=ndmBc8dT+YUFbZUh8JSUskzkgEjtafSmthf85hpWieE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyW+MBd4zBFuo4myPbveiX+Pb1n2K2LXHZuAFG0D4PVINdi3DDzDI1MX8iNvDIuezVTWAm0BSfBUqRFA8abTxtN89kK+nAXGAIrd2YrOLDG/cKqFOcSYqo05XyOY7gf7IvzTd0+Ps5PPpllD1aL+VUkWLApy+JTn/AeGraAygyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s+soWiVh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227b650504fso50027095ad.0
        for <stable@vger.kernel.org>; Tue, 15 Apr 2025 00:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744702008; x=1745306808; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fCJNaeHH0qeNbjhZ4y2YJBf4Ih9X6gqwUBqd6D7xbtk=;
        b=s+soWiVhFQrvqTx0PlOvSWQB0LYI6Dkq5xgIaduyCsfnVJa13I13EqbaI4VC6PcBl3
         XjNA8/BCKPVDBzf5YW3dvfaAb/yI31loHO61jR8cOy1YgDB0/EI6wlfQ4cGvlf9kFBET
         rt6szD6Qh4uanOiCoab3ZWaE08xdAyXTcaL0gPZPMEQ38AWbCgEUQ2dl1HB9MXNGVfQ6
         NUcdpdNo3jFORAKu+xvPntisZSk8qhKJhcGLbsIkFvz4kKyYrSNxPmDyhfIlLVki3J8f
         /yJ/LGPRZdTnh8BC+PeXpyfWlIxRetl1g27htSY8jMg8/5b4/UoAkR15iYWbpcmHhA3g
         kfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744702008; x=1745306808;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fCJNaeHH0qeNbjhZ4y2YJBf4Ih9X6gqwUBqd6D7xbtk=;
        b=cn/5NMFRoq0fNIRKLrj/Y58JRfoaYCccs9gNYlcAzEu+t2Atjnp49wXcqu8Nmor5KV
         Mzvi7MoI0ZlsnYmQRvjnbDrM1bLPFUFhBPNmB6yEttG+hz9D2E/4xfnOlliLz8T4aoXy
         g5WyYD4nQWy/yStA7VuougTTbBg/H+VRfiX/3BdJJfGnj0VuW07nri1BnVmSDCie3HYB
         tXcEZdRszGiC4MGEQ2pCcTKmdtrnGKABZkSGPUcxHmAZ908Vxa3FQjIiDpRDQrOQ7906
         AphuVgOJqs9SGNSj7KPN4FkEdO/vQ0AYfsAu8d92rCVy6EaqUQDUwDLFwAXGlNbVABzY
         8HEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh7pHNjkt0nvP5J1sOynQKuisx2uMA2ECOxpWFISUCWhzL5FEQIpnIrKXFWVIdrj6Xv78Pbe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEXv2KfJmDbAXGUV/BGvkEriJw49b/IPiz14+vPiqRkfricIhv
	LqLh4kx75yqUPLdpQVAw7er7PCfR/GBvRLKxOE5z2CDSe/lQ9BXYEpzqvk+wzQ==
X-Gm-Gg: ASbGncuQPod1Al0lKX9Ddg8sSToFZvzPSOILulNxtHJYvWDUe9oNLPu+v7m3uY9QVcO
	hLHojgnclAsT8rjn54wx4TWvqBPfilHeqqUyRke5MjyBgbxv4gcyHaX1KTRXrHtBZ3IJO9xOXt9
	xz/6b2yX6vrPvKzz3Xm9jQu75MQyv24OnpMlDr96pTPi5Up7ReMWOcNcBoLnz6VLxgX3W7egfHI
	EJP5Q2vMRPuifhvLhM1UTyfOR9x1GyWo/77JoBLDdfBevMZ6u3+bYBUBuo6N53cvmo1pjxiK0Sj
	FqP+n3WP9bOrD+0P5ydQRPwvq7kekvyKnslAzz13W2XNtOzPCw==
X-Google-Smtp-Source: AGHT+IHguLmuMIGRBsFlyspehfjQDN2w8AskD61wkAT+OvpAWkCdIa3KMt+LNv9RjQaYs4JZBwB+yQ==
X-Received: by 2002:a17:903:904:b0:227:ac2a:1dcf with SMTP id d9443c01a7336-22bea4bd870mr208246955ad.23.1744702007792;
        Tue, 15 Apr 2025 00:26:47 -0700 (PDT)
Received: from thinkpad ([120.60.71.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c93aa3sm110866935ad.149.2025.04.15.00.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:26:47 -0700 (PDT)
Date: Tue, 15 Apr 2025 12:56:41 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Sumit Kumar <quic_sumk@quicinc.com>
Cc: Alex Elder <elder@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_krichai@quicinc.com, quic_akhvin@quicinc.com, 
	quic_skananth@quicinc.com, quic_vbadigan@quicinc.com, stable@vger.kernel.org, 
	Youssef Samir <quic_yabdulra@quicinc.com>
Subject: Re: [PATCH] bus: mhi: ep: Update read pointer only after buffer is
 written
Message-ID: <gq4s5je4grjjqwhrmrqrurglm4kctnsslwr4kllxdyphy4re4d@kzacgpg7k3xj>
References: <20250409-rp_fix-v1-1-8cf1fa22ed28@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250409-rp_fix-v1-1-8cf1fa22ed28@quicinc.com>

On Wed, Apr 09, 2025 at 04:17:43PM +0530, Sumit Kumar wrote:
> Inside mhi_ep_ring_add_element, the read pointer (rd_offset) is updated
> before the buffer is written, potentially causing race conditions where
> the host sees an updated read pointer before the buffer is actually
> written. Updating rd_offset prematurely can lead to the host accessing
> an uninitialized or incomplete element, resulting in data corruption.
> 
> Invoke the buffer write before updating rd_offset to ensure the element
> is fully written before signaling its availability.
> 
> Fixes: bbdcba57a1a2 ("bus: mhi: ep: Add support for ring management")
> cc: stable@vger.kernel.org
> Co-developed-by: Youssef Samir <quic_yabdulra@quicinc.com>
> Signed-off-by: Youssef Samir <quic_yabdulra@quicinc.com>
> Signed-off-by: Sumit Kumar <quic_sumk@quicinc.com>

Applied to mhi-fixes!

- Mani

> ---
> ---
>  drivers/bus/mhi/ep/ring.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bus/mhi/ep/ring.c b/drivers/bus/mhi/ep/ring.c
> index aeb53b2c34a8cd859393529d0c8860462bc687ed..26357ee68dee984d70ae5bf39f8f09f2cbcafe30 100644
> --- a/drivers/bus/mhi/ep/ring.c
> +++ b/drivers/bus/mhi/ep/ring.c
> @@ -131,19 +131,23 @@ int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ring_element *e
>  	}
>  
>  	old_offset = ring->rd_offset;
> -	mhi_ep_ring_inc_index(ring);
>  
>  	dev_dbg(dev, "Adding an element to ring at offset (%zu)\n", ring->rd_offset);
> +	buf_info.host_addr = ring->rbase + (old_offset * sizeof(*el));
> +	buf_info.dev_addr = el;
> +	buf_info.size = sizeof(*el);
> +
> +	ret = mhi_cntrl->write_sync(mhi_cntrl, &buf_info);
> +	if (ret)
> +		return ret;
> +
> +	mhi_ep_ring_inc_index(ring);
>  
>  	/* Update rp in ring context */
>  	rp = cpu_to_le64(ring->rd_offset * sizeof(*el) + ring->rbase);
>  	memcpy_toio((void __iomem *) &ring->ring_ctx->generic.rp, &rp, sizeof(u64));
>  
> -	buf_info.host_addr = ring->rbase + (old_offset * sizeof(*el));
> -	buf_info.dev_addr = el;
> -	buf_info.size = sizeof(*el);
> -
> -	return mhi_cntrl->write_sync(mhi_cntrl, &buf_info);
> +	return ret;
>  }
>  
>  void mhi_ep_ring_init(struct mhi_ep_ring *ring, enum mhi_ep_ring_type type, u32 id)
> 
> ---
> base-commit: 1e26c5e28ca5821a824e90dd359556f5e9e7b89f
> change-id: 20250328-rp_fix-d7ebc18bc3be
> 
> Best regards,
> -- 
> Sumit Kumar <quic_sumk@quicinc.com>
> 

-- 
மணிவண்ணன் சதாசிவம்

