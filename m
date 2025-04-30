Return-Path: <stable+bounces-139092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114D0AA4130
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 04:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C72920AA0
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 02:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC0D1C84B2;
	Wed, 30 Apr 2025 02:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TPDmKOFD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8432D023
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 02:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745981885; cv=none; b=QrtluZhJMd32epPVz0xUqDWHFKPKrT0R21Iq2Ez6ZtoT0vmbdB/6QK7sUUQBR+4EHAyJFIGrY00doc50qZ/f/wvcgazZqne+6DTa2tbp8wc0fSr0FhtUSP1Z0CYu5+nahlM+c5d1YKEixRgbahclV9u27XdvHQ8yLd1ioUjOFIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745981885; c=relaxed/simple;
	bh=vSVqtBuB+jDZR9oAppVW3n9jSJJUZ7Ihd2hGUqwZ6Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuFrpAwlFx9cU74k75XcYlqvuUIyVq/HPYZ7VIMzD1ou7mRJN5YJrQKyKvwrf9DPT54UKQ3SRC8BqznlckhPmXq9IakcouyfCOThtj/YZUrH7NN3xwRv5vTt5mrcm4VxmqpCfaPH/wSq1Y/JmA1h+xa2BPWvVOS+qDewW6qenjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TPDmKOFD; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ac2c663a3daso1342423966b.2
        for <stable@vger.kernel.org>; Tue, 29 Apr 2025 19:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745981881; x=1746586681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=orERZRi+X77AnHhL2gqMTjYmeyPepMy3FKT+ifyIpL4=;
        b=TPDmKOFD4z3G5hXT9Hreo9sBEgUK3ihddmLiVySX4KRXy+HCGUdZJdi9gsO4OGbR0c
         f1c/oDxgfuNojW4qgdV4nZHLcgJwarXrLZCmonX8iuZxlhsm6SZydZz9S/8FTYensJLz
         b546ZTYW9zdYWMk97aOgAK3jdOmPh9Y45I70rrIon/mtzU8NPUkdziIQfGKKNmWTPFlM
         k5lE//7LPQeDSswoVw/zJ0EzCCcWn641jE+u++PUMSmUR6IC+D3h0NZnGRaXAbsvMQKY
         88g7BApMFl5ve4DzhHj66Azfb1wxAdsED7vzAfpArJXpWSNThKcxiCQAWney/vgmpGQh
         qa3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745981881; x=1746586681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orERZRi+X77AnHhL2gqMTjYmeyPepMy3FKT+ifyIpL4=;
        b=jN0dapPN9l0WUENfv4B5ShqCdOlAByrmWtx78dXXRFKQWxTZCYAYtWTwOEbq4uwYkt
         72XgL0HVeTGAaN22iW2PowgQg5ms8NtfGuywvkv+WgTAkxRzXUPskMMhxQRebA4I4DbH
         3x4g0Nb9MK2o09O9hxQ3AXrMBja+kLX1yUMAUH4NNgsL1RuSGgAqo6qpMorcrxlmLVSZ
         aEVzL7q8+gzsYex+UBbssBMmmJpyfJMsmtUCz9mW9ETQpI9j6Gwvz3SYC5tqDpbXbYp+
         XJJV4+Krs6hSyieCkjRD29HyOWTcPaLudmzYtDSb8ljoBoVbPbeBsf8SRXqUSxW67Fa9
         YmHA==
X-Gm-Message-State: AOJu0YxdeDKYkPVi7/326w1nou8L5iwh7TeqTmv45hiC/E46tNbn4SGE
	XWswPIkins4aVufp70TsINht5fe48YaHjG8Pf8bttYFAFRVpWXOoS6id/FHV2rU=
X-Gm-Gg: ASbGncuxREnzT7i4f03dXXLinCQQYqp8M4DJQsq9sY7AXNzcpBuqG/1CVlQp30fYov+
	0Ip1o13bHkb61tZNb9+a7kKlymmi9ucFcizpFekSLV6dsjU7voBSj1ODRDvTwU2gfUzJ951gNvS
	xTr+1c1IcOd4Kq/beMRyM3Fnr50iGwV/bqHk02b3kf2PL0oYptx0HrO1qlyS+ixJqyLSRxYXLgU
	329cbmPbZQ7IMXjMAS8Gtpv13fbU9QPPGwZB6eFbwS803kPF2GJtrsouT/qZvqWw/3Welcq0cNW
	5tMafW2WIRiMFhKrxVCDl0niPWGDVT00fGNAAnUnPeDR6jSKOcgAKLYJxLivTL9ZA/zAd0ighoV
	n
X-Google-Smtp-Source: AGHT+IEWjFrMLBqOV/1rb7M+m2k06D+kpRwrzKt1j1RkJYk/ipaKYAiZsHrqN38WPJ7aRNgfa7eHCg==
X-Received: by 2002:a17:907:6d15:b0:acb:4cd7:2963 with SMTP id a640c23a62f3a-acee241c417mr87778166b.33.1745981880926;
        Tue, 29 Apr 2025 19:58:00 -0700 (PDT)
Received: from u94a (27-240-163-208.adsl.fetnet.net. [27.240.163.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acec2e5ad9fsm246073666b.23.2025.04.29.19.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 19:58:00 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:57:48 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.14 000/311] 6.14.5-rc1 review
Message-ID: <4vosggktdpxcddwlbopxxfzs5nscgllrqrhyxfibzd74wur65c@qo26jck7ok3q>
References: <20250429161121.011111832@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>

On Tue, Apr 29, 2025 at 06:37:17PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.5 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes (with 82303a059aab
cherry-picked from bpf tree to deal with sockmap_ktls failure, it will
be sent to stable once it made its way to Linus' tree).

Link: https://github.com/shunghsiyu/libbpf/actions/runs/14738691393/job/41371100920
Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

...

