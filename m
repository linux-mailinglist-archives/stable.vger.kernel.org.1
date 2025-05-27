Return-Path: <stable+bounces-147884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C46AC5B89
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 22:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3446F188D5AD
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 20:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A851FFC55;
	Tue, 27 May 2025 20:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbwjt5l7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0534202F6D
	for <stable@vger.kernel.org>; Tue, 27 May 2025 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748378565; cv=none; b=BB9/n7YVlwk63fu9BSZbLLZUWsFvOr7+LsP9F7bH4XNmaWWZ4Wb3Od+xS7g2b1hs/NdiumgjnGDn7FXhNBgme+hBhaFVHRJGPYFsLPB9sU2zR+PwQtEGa2D/XTsCOaHQzI/CpOuuzQkiOdrdyT9ofOF98UxXfsgCLkvL5vQHkUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748378565; c=relaxed/simple;
	bh=uP/ETRmxYfpv79+aKID0wczhU8q7Cin7HrOkWLqkoYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbgVGlN4zsVrHmf7a2lt12lqkbpfY2nB0mQ1UC32oGMPQdoNNEuSe7DWC3FydozEAaxILXngHWw9eKF4wDOlU/MRqF0F2FxpYGBLpe0+2XpnjOcdrJQ9XPjgHC8R40nU0ZUcZBBT80frvDH94DTRIElWTL06XgPFHDlP4ZpBCXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbwjt5l7; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso4053675b3a.2
        for <stable@vger.kernel.org>; Tue, 27 May 2025 13:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748378562; x=1748983362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=71zN33qLtaIe0yTmvh4SAEZ3YM0w29hvj5dmuTw77xU=;
        b=lbwjt5l7OVnaNB5pc2iR3LETCF3aBLubleh5jmpZWTqVU2q70naXsrqfLewMNdTIIb
         VvojatVRJeI0rjwnWToqCPkUGlabGtLJamNIy9HXz8E37aRqWbh3Lt3iObZf8Hvm2ehk
         iAWGqJsKrNHPCDF/owP2LV3IKSPntQoXb1whOeMeLfeiDkrlU52hl53lJCiOZ+/Q9VbV
         MJc2UPxtW9E90wwtXFftq1ijSel8bv4PGSFng1fPRa7Vh7nbhAsgwiZiC7vyqkymdqOh
         ek1KkUz1WBszKfCwj/5eGynHhLTjp3/eaMYYL7TjTX+8Vl4hZ1v96Qt/Is2dJibHHRps
         g33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748378562; x=1748983362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71zN33qLtaIe0yTmvh4SAEZ3YM0w29hvj5dmuTw77xU=;
        b=p7vrKTu43crY+KOFGHVbW5EcRQEf/rGWARTH6kHymuIrvKV5vycOr1AwLz2daBMyBf
         MM4wA81cmPs/4RGcwvuoEn32oeVgOkt7xrdepSAhQTKvgUWdcYM/TlnAyrFn1/gTlER5
         +1zJKWMJgvlu4YoCSp35IFK2RpUcficxcvH1MNOnr1TOVvAx28MAOjPXXDhPSig+++oH
         mIpWz7KzS/cNeIZNvPWle+MmOjM/jV3kSXcuK4i+3NhojZZRyO6POOm5ei1LUejN7NF3
         xo+OkwxTjYrAGgtTG1DxrBDCwEgemd01zkdDiK5zWpaZitZPx8IdWeEWfgfmTCttqw6a
         ps2w==
X-Gm-Message-State: AOJu0YzmAZXy0wWSxGysB189Rh7G2vSGSFEIZJr8jTj+C//xEleNh8LN
	sbMgs2ANkCl7cFjzULqy/yc7++qxMydaN/Lke7QLMbT+9XO32JTL+b9D
X-Gm-Gg: ASbGncsQt1OmX80mEYXCYP1TXOIVG03ENYGAOjhTlSTE7fCM1Ucj074wIdwFlGiS6Rv
	uyUhgEfrL3LvKvWdXowArqOyIEB+jy5jbHxjv1tNwcMXWPqR+nH5ycXlBP0/3dlG+p4yvXFGVPb
	2KNBnfcZXDkOSH5fnNyMNjs3T/g0hlqWUAN/7U+qkERBRjVaZvT9XxZi7O84FpOAi2iIFJQUNtq
	DJBBOxuyLrUi1fDRv+OIJIArWSXCs7XM1QoCsZzbN/e/WmzmNuMLezODPoxVEqTRT1SAXiZ7l61
	ONOoMVfz1OlMweozEan7oQPCdQ0Yco3kRubbw33U5vdyH5moV2bh
X-Google-Smtp-Source: AGHT+IHpuppsxx7/qH07XR9DEL3kqR66WdWTpxQfInM5tiIRbZC5YtXPXT5Egumuq53I/QwZEA2kGw==
X-Received: by 2002:a05:6a00:1482:b0:740:67aa:94ab with SMTP id d2e1a72fcca58-745fdaf1dadmr21321973b3a.0.1748378561773;
        Tue, 27 May 2025 13:42:41 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:234b:b801:3ed0:528a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7465e6484f4sm10275b3a.32.2025.05.27.13.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 13:42:41 -0700 (PDT)
Date: Tue, 27 May 2025 13:42:39 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Hanno =?utf-8?B?QsO2Y2s=?= <hanno@hboeck.de>
Subject: Re: [PATCH 6.14 750/783] Input: synaptics-rmi - fix crash with
 unsupported versions of F34
Message-ID: <i7tnbh7l2blxussxcdgjuvcpkzet5w552dqu6vl5upus4xf74n@dva72me3bdia>
References: <20250527162513.035720581@linuxfoundation.org>
 <20250527162543.672934881@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527162543.672934881@linuxfoundation.org>

Hi Greg,

On Tue, May 27, 2025 at 06:29:07PM +0200, Greg Kroah-Hartman wrote:
> 6.14-stable review patch.  If anyone has any objections, please let me know.

Can you hold this for a bit? I might need to revert this.

Thanks.

-- 
Dmitry

