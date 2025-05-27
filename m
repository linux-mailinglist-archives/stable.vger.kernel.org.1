Return-Path: <stable+bounces-146434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B85AC4E71
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 14:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDCE91BA08BE
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 12:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E788F2741DC;
	Tue, 27 May 2025 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PXI++bkF"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B862C271441
	for <stable@vger.kernel.org>; Tue, 27 May 2025 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748347892; cv=none; b=blwAmtP3tDF4bbosWjNiiGpNkK38dQotjiL8hh/THGYy5EKlsaLf4sG2N3S4nWD+X7VyvjgK0JP9TM+yuIA68p7pwFJroYQodgXSoTnzdYAYqikHjmeMFS9catpEVdaVwzB0AxFR0sDBKrw9tAxBVXlL10GKkbKY9jhLJP1sTg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748347892; c=relaxed/simple;
	bh=N0jjmf/kmkyvAxAXac21ttYuTZnd34V4RTWarAbSnHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+Gnvd2wGOa8OYkEb8RVvH/SMASiAKADJlnEaXcsKbdNAvaTy7UfMc/fA+H+nusntkSAkH/QvuMlRHIeqjYJmTOTRfkJqkV919JwyKqMdW2otH7JQZV2Vyk3Eg7JvkI6QhS1FUN+cb1o+D6RuCC2mAEgx4sxi9mW/YwUBWXs1gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PXI++bkF; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6faa5c69550so32708686d6.3
        for <stable@vger.kernel.org>; Tue, 27 May 2025 05:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748347889; x=1748952689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7XDEIh7cWs+9i/urKEMylLez5Ew3kmQCefiIWKozcak=;
        b=PXI++bkFpkZ4yCBjPm14L/h4cT3lkPuSoENrTrdOa6/Np+Q0OlTVs3uH752cilqY6v
         /D9p0wwJmPNLvjM8ido3qLSFCLDRq35B9O9VhsAIxhfrHzpK1phJ8eTul2PFE/MDeP+x
         PVZ42b5c1h7lPq4bfITr15vlwcK5vK+t2B3nmMVHW6zeD9uFeDwT91wqGYxhYFkox//K
         9NDR9I2AMJXyC6qcMTZcA9eZ1ehlg8TmDXmVwAV4RT8GMwsw3PrVSCFmEfNUAvMhY+pQ
         HQ+4qfHA2T7tJbvHOIWM+ZDB6n6rWQ5v3kRRn0VdCXsW1Wv1FghIm0wZTLvRF4xXNPva
         A64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748347889; x=1748952689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XDEIh7cWs+9i/urKEMylLez5Ew3kmQCefiIWKozcak=;
        b=vgmCVRI/ebgCpz1OiQZO+9YWMPKf6TEnMpQpxDsWKRA+mB7OsfuBjJTTRJZBzagiKG
         gT1ZezvY5mxCFUMRENQyeAJ4EeMvJoU4SQ7diuoqsamnaYxNqywxd7D2iaz7wj/pF509
         RJVGOhXoDdk4zvbIEaDoMslZPgBIvqTrLpVzFjN8sLChj8VJaRwiNl6/bZfYYiO7udd6
         CNRzhSZ63nx9AtHOTQNYFCkJ3rSEyhOuAlqKEYWmq6NVcPLCOLYjkiOaZ7+FZixsgQj1
         PW8OPw7iWEIEpIA708tnHaG59Bh12tB1w4rln7pvxpcZnBFO9Jz5NLpQscL9E1MOvTKX
         pM0A==
X-Forwarded-Encrypted: i=1; AJvYcCVBEJQC+Ic4ZkWTEJPZ0CKEYBTaQyeTwu2MLsNH5+4vdEPDCDe2gwI0s4L7gOh3SyoRcX8/5u4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFraNOUaV1RqzvBzWv7M2okux2IC+SE5Encj3bhRzV2M9S0gTX
	SKtf/wUnwOZUSHipM58sLn2FgNavwv4+qLkZe9SdmW8osllVyvgWYchvoGTCWnekUmk=
X-Gm-Gg: ASbGnctbK9LpLenQjPL7WC2wGCgoL+XOV+bwy40kaslxjVIr2Mz1u9shlm5VcDtwVO9
	P2fm4imMYecbe/PBc3A2iHzrBxG2qyVQTjibV/N2Fmrd0TZvOZ7N7InyIhLljoEmfmNWcIhVmXn
	gkbNqt1qMgJ64V/tYx9Oj0SiBlUKqlCP5IFiAcJP8N++4snoPUlvgw+GfaT8O8nOV6A7OR4fc35
	f6BR3bZd4rGYGtVJ42wl3nColHopB6x8QiCqvjdNIj8oxDOVZx4csXVm2Qw3KCk7/82V6NXnKj1
	YfpUSK58I1tHu1ypYcj1h/hTSTpPuJWqX15wndMGy2s47P9WRjpVukgBH2gpxBqGiEdeytnYHnF
	sQUE7volWHTi6G6cSJqM+9UZrnlVE3q9OJxN0Vw==
X-Google-Smtp-Source: AGHT+IGOFTXFB5+rAUr8E/GqCzuxsYlYPeiD9+d/FGPHL3B5HdbhA3MJLfSRW3SyI7yXaYSDYR+MhQ==
X-Received: by 2002:a05:6214:20e5:b0:6e8:f2d2:f123 with SMTP id 6a1803df08f44-6fa9d27eea4mr230852526d6.13.1748347889555;
        Tue, 27 May 2025 05:11:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6faa3704157sm42245476d6.36.2025.05.27.05.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 05:11:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uJt9U-00000000ZUZ-2C0j;
	Tue, 27 May 2025 09:11:28 -0300
Date: Tue, 27 May 2025 09:11:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Michal Simek <michal.simek@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] fpga: zynq-fpga: use sgtable-based scatterlist wrappers
Message-ID: <20250527121128.GB123169@ziepe.ca>
References: <CGME20250527093152eucas1p24a904b0d973252ebc0d05034a276e9cf@eucas1p2.samsung.com>
 <20250527093137.505621-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527093137.505621-1-m.szyprowski@samsung.com>

On Tue, May 27, 2025 at 11:31:37AM +0200, Marek Szyprowski wrote:
> Use common wrappers operating directly on the struct sg_table objects to
> fix incorrect use of statterlists related calls. dma_unmap_sg() function
> has to be called with the number of elements originally passed to the
> dma_map_sg() function, not the one returned in sgtable's nents.
> 
> CC: stable@vger.kernel.org
> Fixes: 425902f5c8e3 ("fpga zynq: Use the scatterlist interface")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/fpga/zynq-fpga.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

