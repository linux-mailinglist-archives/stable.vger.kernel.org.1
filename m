Return-Path: <stable+bounces-52066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C259A907839
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 18:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A1E1F2303C
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 16:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1622F143C7E;
	Thu, 13 Jun 2024 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZVdLj6I"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BE41494CD;
	Thu, 13 Jun 2024 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295854; cv=none; b=T72lwmaWEsAD/P/HlTqEXiUkupuCki6OThn0z+XItil3wc1VF8Xbhrr25YEJWifr2FsYuRm6mza2TVTQKjWrhEZbpkWK/cBKNVDwN5/r+vAfShYHXNT/2DD3GfG62fyqF4tZssC01V/fj4tmlPq9me8SfS1IMZzdLyd4KKY6lyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295854; c=relaxed/simple;
	bh=ZMO54sEj6G7+dnyZmApzdzks0Br8TpFhp9WbA1x5IPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euHEoexNhH6CsEtcJGjNTTCzfy8ZwPxqoNaj7pvozuaIhfEqew9RsGwUTFaxro7Efk7+1iQbg9Okfw9URnF/CtRICo2FsQAjBna/+aldp4/AgfMOcHv6UhKv5Behk8P9ahXwxOXyZh70IcshbZ2SO4xJ0G++J3N1KYivvqEQayU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZVdLj6I; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f4c7b022f8so11816525ad.1;
        Thu, 13 Jun 2024 09:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718295853; x=1718900653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtbozP1bj1RT/YO+b6J5IfcQJsTgR/wm/yUx2H9BANo=;
        b=FZVdLj6IMG9bQs7sjZnutLDt8p9W+WrSFL6DbnRsvZhW5SZ6ggZe4uM9GpSxFH5ajn
         Gg7yNYBpLysmWC36WMU1ELjBGOJo1FsKTlBJFMzOFvFRwFTzsaBatidhMOWBvIKGeMbJ
         usHfX8vCoy8E2dCNAhNhq8Rr5ujP1w9Yei/C8blswkk3ps5opiRxVG3xcCA+MYDYNQUB
         Nmodoj0Pk3adfvDUwYFlo+YtBuwm+f6NfiB+mH9ggh2wMeazaBBGirBQE8rGlmVGdjPz
         n2JWkv5f55XrHM7h8LRPkdvGsMBQmZduBNtKbMcDUIoep3Gd8B/iDZkvwJaHEMxrbLT9
         bcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718295853; x=1718900653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtbozP1bj1RT/YO+b6J5IfcQJsTgR/wm/yUx2H9BANo=;
        b=LdLjEwwBId7lLKe3msliuQXYOXPr9FQ6s0htxmVBO4zYOJ7AZpMcVArvRKoVWo+9uE
         izV0pdHkpQjrAnQnVoMD+oh986CT0n5TQhETWnVI6Vwns1datQDqkEbz7V3dDotCK8jh
         Z4JZ5FoighzikEy9pd3a43dxlRVLwUpuAgz8pV+LjQuf2eYfjt+5AVgd4vU6kvLWUzKL
         fukjXlr9e94ktQ//PE9HLaWqluHzVgFeX8GBN5mLUxpbgqB7d2U2e0+0bsWD9WQ53fQG
         FDygWjwzO8Dhuv6LFD4Dwen9gGGvhwrwzmbCeE1eG0kTrV8O3YfTej/OCZ/LIEcP4Wpw
         J9XQ==
X-Forwarded-Encrypted: i=1; AJvYcCX79GXQM+o4ZuYqSeavqAIp0WP/uGgboqoyMJ+553uY8Ls0dGw19lqXhMs9RznCuLh49bBV3ctCNA5hagBfLaqyxm/Ap0jrHfF77dXi
X-Gm-Message-State: AOJu0Ywetf7kRF0dSA15w718YkqdK+pP+fLKpSLfpKyWPs/lwrenwlHg
	UNEQbgB6mgFWY+6vA2h3DhOyfpe+EiAtwqmuWbSPeoP75GK+FRKN2AX+tA==
X-Google-Smtp-Source: AGHT+IFwXiHO/szr9rGN1ZzQ5d1mtO9VMwLAtzaq4KCnnCjvlmgsVWLYkjqN8iqF2OT683d0Mi5l0g==
X-Received: by 2002:a17:902:b587:b0:1f7:2051:c816 with SMTP id d9443c01a7336-1f8627ea802mr1470735ad.35.1718295852641;
        Thu, 13 Jun 2024 09:24:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55e5fsm15906145ad.59.2024.06.13.09.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 09:24:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 13 Jun 2024 09:24:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 4.19 000/213] 4.19.316-rc1 review
Message-ID: <5adf6fda-7936-4a45-8372-dde37f993afb@roeck-us.net>
References: <20240613113227.969123070@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613113227.969123070@linuxfoundation.org>

On Thu, Jun 13, 2024 at 01:30:48PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.316 release.
> There are 213 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
>

$ git grep remove_new
drivers/hsi/controllers/omap_ssi_core.c:        .remove_new = ssi_remove,
drivers/hsi/controllers/omap_ssi_port.c:        .remove_new = ssi_port_remove,

There is no remove_new callback in v4.19.y, so this results in

drivers/hsi/controllers/omap_ssi_core.c:653:3: error:
      field designator 'remove_new' does not refer to any field in type
      'struct platform_driver'
  653 |         .remove_new = ssi_remove,

Guenter

