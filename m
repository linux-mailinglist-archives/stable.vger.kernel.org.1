Return-Path: <stable+bounces-136657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2848A9BEB9
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 08:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101CE1B84DDA
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 06:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF4E22A4E2;
	Fri, 25 Apr 2025 06:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lu1No+Y2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC71197A76
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745562969; cv=none; b=WZ7cyUizy1VucIkpDYZfW+kmbGV8zuuC4xIrQnS+rgfP1YvAiVgLsCt5cd2gA9ImFgh4nP1t/QJkB5IkiGNGKkvvYSgAOBK/fM/VfVbkWR7H23Qt+QOwkhXGXiFPJtbPWQLioPpD1auHe3Qz855q/MfUY0ZoRjCTXtd6JI4oe+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745562969; c=relaxed/simple;
	bh=c30zG2UmTaHnEoSGaMIs4ovdIDAdo0pRlyC9NLqolUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIJS5t4n9F/3hqfQ8sqfPC347reGTK1zNv6/MBFsDio/wr5Igd0qtBy+xv9GgJa4/4VMXMUHdBa5twdQ3RjpI3bKccyV4uOFpA3XZ1e4yaZ0d0uFBs2aphFvPEHJheYpBiW0/IhYbV/DzVCbS7CpW6jf8KpEUGsvIOSn9SqAFy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lu1No+Y2; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-acb415dd8faso279641666b.2
        for <stable@vger.kernel.org>; Thu, 24 Apr 2025 23:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745562966; x=1746167766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7VLSGs5/forf28aN2hH9r89UHkESsLZXOk5Gaagye4=;
        b=Lu1No+Y2UADdGuGh8bQu0Ie9KDqih4tzR2fue8VRTpGCDX7XiekMeyjLHDuLaBntCY
         7fZzOyHOe05bBQ8S9GQPfWuJLG94nsJ6wtmMVfr4dNMDlSrj4hUg9zwX2FE1VfHKF1XH
         1/vyFjuEmF87Y2aj7349LbxyujBC1D66KgrRRV6Kg1ovas1zt2qeYn9Dchk6HHX5vIpv
         yFbekG7KOY36mZk+uIo8fLsjr7ISgpw2xCbCixH+nohVMuGDvGBfOtLYOON6H8y3Ord2
         zvzxv0vKFtX21g3MQjoVu7EnbHPyUGXJVMdpEQreKZ2jvvYTFhIoMYylcZNea2vU34qS
         LGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745562966; x=1746167766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7VLSGs5/forf28aN2hH9r89UHkESsLZXOk5Gaagye4=;
        b=kQ30iInCpDy9qs1FOemVf4IvAOHSlI7+1QUKhpMYwenKMLHoxlpeOASQi1iPlgh+gi
         Y3Qu3sJuo3fmSiy1u47l0ZRjs5rHoICFRDrC/j9GnW2qXqCXvdUV2SldU5URjmi0UkFi
         WvLcWkcpSvTvxFnpQzPDsdCGueZT6u/45SC7R7M0JH+CM+HdQ6abLqRy6eag+2tfyIlv
         UH96Xlu0mMkcg1TTzeTDo0nm+1l6vnDkTLFUURDOfGpHSOv1W5VCvPHlAYUoaiwwwqJj
         R0+qh/7yTMP7bTCUVDBFklyMTcXopVkzSwMN5TwOzGTJIFymqG9tzpMDwyQa9CgjA3GW
         7wWg==
X-Gm-Message-State: AOJu0YzwMmL1YCdg4jsCLf7N51iiGX1UAyE6siYOLOjUigzJWMVg21qY
	gDBVtaarwcG5TMM4nCRq4acoR1Ns0TOQfYwGu42tGSwLFqjSDO0Dsf61WDS2J9tTgo8yo7xCMBC
	A2pR+qA==
X-Gm-Gg: ASbGncubaIqGl4P3zTmqj5T5fJYGK8GxcAla/fHIQh8xW1YZgstPRDat+MjrQaIOGJB
	9iW7ze2K8afPxW7I7BPMfX7k6fAl2DklaK2SGEY1fWWWsiDL/OZi6zUwOM1vIchCCZz3x0Alcog
	UyUmshOXmBmcKbmXcVjpAGsy4Gn08ObvQetKDkrLf3pRarKMGDEhvy3kBtXmeNHuqynWvw037Ae
	2q5IIvoR7pI/4eunDzAEFDqdJ54DhIUt3Tvuf7nY4SYJfGPygR3/l0SrfqakvuBosQOde9lYSzp
	SO8H5qcjSU/2DAgdm+yxWdxmveBbPA7JYAPm
X-Google-Smtp-Source: AGHT+IGDOnQIWs+kFz3Q0CmmIHQuQe7rZGKhWTQkW0TP7SUFL14kzzF5zCcMYJAawpvoEu2NNkwcEg==
X-Received: by 2002:a17:907:9485:b0:ac7:75ce:c91d with SMTP id a640c23a62f3a-ace7108ac55mr104315166b.15.1745562965709;
        Thu, 24 Apr 2025 23:36:05 -0700 (PDT)
Received: from u94a ([2401:e180:8d6c:c147:7e8d:44fa:c193:53fc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f774e534sm780423a91.17.2025.04.24.23.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 23:36:05 -0700 (PDT)
Date: Fri, 25 Apr 2025 14:35:59 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: Re: [PATCH stable 6.12 6.14 1/1] selftests/bpf: Mitigate
 sockmap_ktls disconnect_after_delete failure
Message-ID: <aok6og6gyokth2rap7qdhtmc4saljzg43qbrvtbeopjuuq6275@hptib2h2wpac>
References: <20250425055702.48973-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425055702.48973-1-shung-hsi.yu@suse.com>

On Fri, Apr 25, 2025 at 01:57:01PM +0800, Shung-Hsi Yu wrote:
> From: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> commit 5071a1e606b30c0c11278d3c6620cd6a24724cf6 upstream.
> 
> "sockmap_ktls disconnect_after_delete" test has been failing on BPF CI
> after recent merges from netdev:
> * https://github.com/kernel-patches/bpf/actions/runs/14458537639
> * https://github.com/kernel-patches/bpf/actions/runs/14457178732
> 
> It happens because disconnect has been disabled for TLS [1], and it
> renders the test case invalid.
> 
> Removing all the test code creates a conflict between bpf and
> bpf-next, so for now only remove the offending assert [2].
> 
> The test will be removed later on bpf-next.
> 
> [1] https://lore.kernel.org/netdev/20250404180334.3224206-1-kuba@kernel.org/
> [2] https://lore.kernel.org/bpf/cfc371285323e1a3f3b006bfcf74e6cf7ad65258@linux.dev/
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Link: https://lore.kernel.org/bpf/20250416170246.2438524-1-ihor.solodrai@linux.dev
> [ shung-hsi.yu: needed because upstream commit 5071a1e606b3 ("net: tls:
> explicitly disallow disconnect") is backported ]
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

I missed that 5071a1e606b3 was added to 6.1 and 6.6, too. Please apply
this one for 6.14, 6.12, 6.6, and 6.1.

Thanks!
Shung-hsi Yu

