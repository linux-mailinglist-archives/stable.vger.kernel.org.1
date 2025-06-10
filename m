Return-Path: <stable+bounces-152262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 898ACAD3134
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 11:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57EB018940D0
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 09:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3F328A3E1;
	Tue, 10 Jun 2025 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XSPSFszC"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D584B280A5A
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749546487; cv=none; b=DzgGJ9v9ztZ3ly2B1JSE/oeZ9K20EqAnalz8PLw4WGQuIdIMNKFC//RURVM5J/ngR4dzkXsFUlHlrT3j37XCP0LZaIzz87KvbRy60VDylUDN9pH8K556/u4It21gTxD1vapzoNHD9AEq3TkblS/vaDkx0xLqeLceTAOb4RnrFck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749546487; c=relaxed/simple;
	bh=vX7dGgNAk4b5/FGNFMh1N632X7tTQ7n9HQAfh2++OA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gmMlUtzWdZjGG28eW08MZf1wa1tX8UO33ZPaiNr0oRvTKUKGULQ9MxOBH3+qiPeQiLCoqYx1R/z194zpqjsgz4b0xHvVCiXW5fG5gKIMwil1qtk7RpxVQOuqCXtQ9z4eaiCZljqjYO9SKC7IVfFCKNJCWjNxOVcWFCxaeeG8C0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XSPSFszC; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2d4e91512b4so3235784fac.1
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 02:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1749546484; x=1750151284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vX7dGgNAk4b5/FGNFMh1N632X7tTQ7n9HQAfh2++OA8=;
        b=XSPSFszCN6ZHbBFU2pkt5munsNpLvXnKIpw4/gS7wS6bqpjRFpheYKRSK+RmmDVF59
         hu8R+VvhXi226SqHIhn7vNdmHj+zoQ0mJ/m9073AC59SJ5c5hZRbVMXoPtTWM+yINCKq
         obHV6h5/7Dphzw8S7XAmaXyUiZhtiUxMKZAbhIk+Hhd6GvtGA6dOEdPab/HsEr4HQC4M
         Sqfx3xLT+wFE2OGP6ZIf6f0R9pgbenPig9vCzBdyYDx607XbBCcqtPcAXALKGQNs+elh
         jD4xtt4RkKzwtyrB4ThgWMz9B+lp01wwae0SozOtgxcNBFhZ3E5224N5vlYatAgtCNuq
         5RBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749546484; x=1750151284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vX7dGgNAk4b5/FGNFMh1N632X7tTQ7n9HQAfh2++OA8=;
        b=OpGtSowq+2yidE7Iq+eB7Eqq1tf1lX/z28ZEIW4QEROH4NVFYMNmtvBmffpVGFVxul
         KGI2oeNz00BU10/kgEeNWAX5sAlVZrNeU8IuguU2u65X1/U1nBGBRmxxJmC9SrPZo0At
         jBXrXsvKCHzbjgjPfHKkH6X3hZyAcjTIz8YFPcbTWpuAxuqYesG2pnvih9qTMjslJm04
         lpLSZ2MT2Sv6qBrY91twJKxVRQqcqdqgRFTfc2PvDocgsui1BBV9kLEjaw1OMcSU60rK
         cq6LDM+0t+YDFO9SPAboqtukEFjcTtpAYmkcZlAFaw7Ui4hRFBv5ihinWmQzHIm5DQ8q
         TPbg==
X-Gm-Message-State: AOJu0YxhsuLuS9Ha2Bo8cBaeKlejEYC2IEoq+N4xc5qs1s5iRyqBApZ8
	DGusQZCON/77EgP1zz0Yl38XGbx5kPvj184Y0tM9/OTNejUmOUZtT28ERYTRmpiZkBD3yY8g6KF
	AnLCRy2leQMeo8sNF5cZDRmylwQXSGcpG1u6WAqNeSw==
X-Gm-Gg: ASbGncvNa4ntSW+WlzoCKdZIiamzZjuBGAR93h3i5RMi3yfnS9kYdZZw2R+S8B47v0a
	4pa1YSNdOZm6//rnX3/WJFMgmd2ARsl6IFVrUf3geyxcv1QSYHXJ08Q83Y+xWVhTsyxNTLBwUAl
	DJ1vWTjlMr4DjGF2xYdEDxEVVp23oKTOB5RRPMCPPoev07IEFvMb6gCu7R
X-Google-Smtp-Source: AGHT+IHMfNZCwnd6vXybcVIniDLYPuMDu8WKsskKBcpBcqOLGXZlR8IcyYwO+ilM/gtPqgyQLnbexS0m57shr3ilsSE=
X-Received: by 2002:a05:6871:4315:b0:2d6:2a40:fb9d with SMTP id
 586e51a60fabf-2ea011ab501mr10787266fac.28.1749546483893; Tue, 10 Jun 2025
 02:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609074348.54899-2-cuiyunhui@bytedance.com> <aEaQ__Dc5PSA5dQ9@902657ab729a>
In-Reply-To: <aEaQ__Dc5PSA5dQ9@902657ab729a>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 10 Jun 2025 17:07:52 +0800
X-Gm-Features: AX0GCFvRgChwovQIjyF1Kg5WgdIKVbyyt9_B3y_fvjO10aGZy-f19ZAp4iufqE8
Message-ID: <CAEEQ3wmK4LcRBuTPY0_h=tSN3kPOrbCE+w1_AbFD-mtfVNVmBg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 2/4] serial: 8250: avoid potential
 PSLVERR issue
To: kernel test robot <lkp@intel.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 9, 2025 at 3:45=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi,
>
> Thanks for your patch.
>
> FYI: kernel test robot notices the stable kernel rule is not satisfied.
>
> The check is based on https://www.kernel.org/doc/html/latest/process/stab=
le-kernel-rules.html#option-1
>
> Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to ha=
ve the patch automatically included in the stable tree.

This is an improvement and does not require adding Cc: stable@vger.kernel.o=
rg.

> Subject: [PATCH v8 2/4] serial: 8250: avoid potential PSLVERR issue
> Link: https://lore.kernel.org/stable/20250609074348.54899-2-cuiyunhui%40b=
ytedance.com
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>
>
Thanks,
Yunhui

