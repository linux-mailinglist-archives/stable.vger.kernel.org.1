Return-Path: <stable+bounces-52067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C54907863
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 18:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73B71C21362
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 16:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B3C1420BC;
	Thu, 13 Jun 2024 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1POFTFF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AA41304B0;
	Thu, 13 Jun 2024 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296511; cv=none; b=h4BXQuxJk0DrfbPLdJIwzvLNLMQDIiBrTuQqhxCA6Nxy4C80mPcPqnhIQzNL9hjn8VW7vrroLXRO9rKhHRw2SqvsF5dBqgU8z4yn8iEgGgwr7novhm9gml1hWJ9A6W8UBVbZX69iytaImlmiQIshpvwyrFXCYZLEPp5nEG72dC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296511; c=relaxed/simple;
	bh=7euHBXMSi/kaVkj8AhsW9pAkb/1KDYWGLaUHuBaHXwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPepuO9ZT0N7hDe5RiVLKH16HE+6MNxeCA3x+Eg5J4LBemGS/TssPfMwC+QIXczsgUII6pBajoPVJ5BRHkOd6pQzkJLYxlttTcomMM0V9JbgJ79aUs51q5F7WUpWY8kK0TBpWgC6HZb3WAubmTUugDdoepAnnNIae2OWqVZaD8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1POFTFF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f44b5b9de6so10761825ad.3;
        Thu, 13 Jun 2024 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718296509; x=1718901309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=som+/sJ+Se4Beu8MAdu4wW2b1WRUEu8QLH2yvLXXBlM=;
        b=F1POFTFFa/v2kcczc+9Oq9sL5Hagup9gcYJK5TAjrlMUk4JPm3TjVhtFT3HvlAavYv
         jZnuu5qCSfLv4ylJECoWkAIXwZiN8dVjyzU616kbtEG08eP1uHa5jfy6bmcNHeLYBUeV
         2CnDvOCW6AxHKQ5s9OPuR5+RjMPNYnreEV1dpkCx03dkHXXAWFpglyQd/sRatYhoNDdq
         5y0kCcZMmAt6DyNjK/AUqyXGXZOBfAZuPKEIWXip5MZGBjcDIAhpRyyOzW1OngR94qNf
         ArE+DnqgPrAeTkPzgVUN6/fdEKhzd+fU7QXWc+EWAlK7Xxt/tDswgRdTO1RP2qozpyu0
         yL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718296509; x=1718901309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=som+/sJ+Se4Beu8MAdu4wW2b1WRUEu8QLH2yvLXXBlM=;
        b=JwwGt78wBYd+9rCpyO9DJBqcHh8Ev6JbojuPEyF1fj0/MMfl7aCDVlA6mp0XzMjQNs
         ls35isQ/DVAo8+bYRJwjfphWcxByxUYY4dcjyYMHHQY4vjqH8WI7ajyM49lWA+2yyApW
         6v7LijUEO3nmnHtLL203RSEFXqGMcc1cUwnfSymnZjY/1l54sv29x53a0RpEhe0RxpRW
         a2YPTJmNPREq+A0MvMmOE0kqnt7pjG87+YZBcZ7VIKCyUmDzB62Bj5NDGcBquundFDR/
         AGsXT7lvUFAelUCi9bcMDn40/l5/oUV8o33Ihgu4Y20ZnsmkJNwo2BU7pKnYqr+x2QOB
         2QHg==
X-Forwarded-Encrypted: i=1; AJvYcCVjefHIRu7Mfedl5Nx1xlgOLH6ycOm1Z1iPziU+ULEioIPZIx5cMSfHkG/cmrhlx5Dfl3wuTprTTNFnSyiBSr0b67CWSlBAyhLTreTP
X-Gm-Message-State: AOJu0Yy/JDJSc52X1g0+OIo5N5Eg9Ggxl+KNTwpNUg11GlbnliDRGDAX
	p6kOnrNoTW7S16khbJUbPo9xbPGP/aUA629fNtKcYWpLlDEu9Smh
X-Google-Smtp-Source: AGHT+IHpCGuCoL507defMb9VqgUzyDLOdtSlPTwYqUErBCiK90elGO8dIGwxF5qj7XmILZ94Kj5RTw==
X-Received: by 2002:a17:903:2a84:b0:1f6:fcca:12dc with SMTP id d9443c01a7336-1f8627df843mr2427545ad.28.1718296509435;
        Thu, 13 Jun 2024 09:35:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee8096sm15972805ad.171.2024.06.13.09.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 09:35:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 13 Jun 2024 09:35:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.4 000/202] 5.4.278-rc1 review
Message-ID: <3ed1ecee-78bb-450e-933f-1e06b1e392bd@roeck-us.net>
References: <20240613113227.759341286@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613113227.759341286@linuxfoundation.org>

On Thu, Jun 13, 2024 at 01:31:38PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.278 release.
> There are 202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
> 

net/nfc/nci/core.c:1455:15: error:
      mixing declarations and code is incompatible with standards before C99
      [-Werror,-Wdeclaration-after-statement]
 1455 |         unsigned int hdr_size = NCI_CTRL_HDR_SIZE;

Maybe enable C99 on older kernel branches ?

The code is

+static bool nci_valid_size(struct sk_buff *skb)
+{
+       BUILD_BUG_ON(NCI_CTRL_HDR_SIZE != NCI_DATA_HDR_SIZE);
+       unsigned int hdr_size = NCI_CTRL_HDR_SIZE;

Swapping those two lines would be another possible fix.

Guenter

