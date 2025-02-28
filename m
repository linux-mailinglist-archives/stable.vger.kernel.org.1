Return-Path: <stable+bounces-119953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D718FA49CC1
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 16:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C043A623C
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 15:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71951EF36F;
	Fri, 28 Feb 2025 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="aKrCgxB2"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1321EF369
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755191; cv=none; b=UdN9TD7d+BU8qe7Fw7eNpHtqr3CJXOFN++oYeZ0X4mwbBwD2jCFKVBBqIpADMnIRUNPPUrp6fRS4rqes9xeopi0LD6W3BxRWYMvIPpqVPoswCQLDv/mgPR4vyJzgoVZaDZCWu14J9XNsX32PbkhvNeDUWOYqzkm5WzIWKMpQqm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755191; c=relaxed/simple;
	bh=olVrCQ7UdaQjy46v5P/GSEQYTGRyn0iXsncNea20IsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCeW4VHT8tPO1xlL+7/J2sP8i+huSEyfKxkSRv7zAels5kvY1qa4mheG/p7ac/XBVEkgeCwAXmiAhmS23j7uABHabxNLExZO7wsj17sqRikF9QKPq9TTnlzlYWRpkFVsNmsmiu1tv76tcPYPLn2m/RECtmCs0dZCWv/8ZmWDsGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=aKrCgxB2; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-472242b0da5so20537091cf.1
        for <stable@vger.kernel.org>; Fri, 28 Feb 2025 07:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1740755189; x=1741359989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sdm5h7ySdGHF2dP5ZUS41EvuGX6rO7bkR29o37l7ikc=;
        b=aKrCgxB2JmK6oMIaK9/FrZeSLggxm0+91KbaRl/CZbX7bdicpiA8M3C2glgdpE3goa
         A3M9Gq2fLSZeJc7bkn45adheA7QTlV0NVQ0SZH3c6BEnP+cPUGec8QuLdHI6n9f6dvux
         SiwCa+yOF0JNKRZCeIzzSq6G7Ro98VkvL4C+4rf6yms2cqWDaSQGEwnpyU5zeftjHWPM
         cgXATCAhQaSc9ys4XtGhOxQNYhnhleT376kAsTjRFUMUPpR4oNM+CVEOIOfKkKgPrtR6
         zZ5W4uY4P2hCRNK0b6kUVpIbDIY8PIsnymnim53vXGnDOseiAO8KHK8SM+G2xP2SHw5p
         QWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740755189; x=1741359989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sdm5h7ySdGHF2dP5ZUS41EvuGX6rO7bkR29o37l7ikc=;
        b=WbIXd3KoylFhMUn1D3SoJZiZrdWl0KbcE5R6LgEsNshy8BLcBAuhpGRISEzYqycPBn
         jgwiJsXjkoowud/yVgV5WzNoQRZr6k2TcXrIIo10TS9wvcp2zkrKnF6KgitHoy+YSHZW
         S4QXo3GmXBNZ6HAbZt7pVbl4hyK0jOoJxd07X4T+fY/E+ePNv5mv1teXcfTxsAZHhvWv
         A4wZ/9eqg8WgOXqoy/5FymLRfuo7ULlUjD+IdYJTEJJ+TqSYNAcQ1ZGwSC2uPmwA3AAa
         JlukJDixfbzWwmsv2fiSf7r0MyD4nBgQTe55mx7riBmfgd9Sv/tUA3FGrfraAqnbYCyv
         8Zcg==
X-Forwarded-Encrypted: i=1; AJvYcCUGAMCw0QzBWTEhkk3F2ikYPHftHUhBXx1o910x5EIFf6usgNVvQ1dryOuGwes55tWZHJaxWqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdqrwFQPbCccfgjbyINT13JmWTFNzaStkfVYmh11yDWoJB71J4
	ORE2Qf6g099oWNKNwD3mNlq1x1zf+J8BaukDt2f2TLnNy7CP4xN5oJqfdldweQ==
X-Gm-Gg: ASbGnctPC6s1F4nN/VrDzYV+muORHzV/20y6qoBW4eKyM0cAyeQ4LKDf8MJciGNjHIS
	mNuKh6+2ZrQ++mtcvVOcY5qlQCFEoZX3iCciq7BX3Cf42xJNlFrtnYsnIGZzBHAa+3ReYHjcAed
	2x/ViKuDFKRYGL6Lpn5pUdNdi4HNB9AOdOQeD02XRCLfUtRUPl1vgVtMXcqoXv+Ucc82LNterPv
	FckWr3jLpau0K/3FIj5+SRnmYvweHxjfqS5aAjNZZ31Ij2dCrr9L3NRQoTxasBY+GSQeEIPnkZI
	23WJUcXW7Vd96HShzzBau80dXzCIp2tKgzULNBvYaHfntkfCRCh3ZZbYDGP3Xm66eyt1fw1Wjo5
	ZXa4kURxn+3ImaNOohNc=
X-Google-Smtp-Source: AGHT+IHfWvDK9PeEa52zO3qX3pzdLJiMyo31UITfvvHt1/OXvd6ktHhMaHffVTjDOsAmO6gnooeXIg==
X-Received: by 2002:a05:622a:1994:b0:471:c042:7757 with SMTP id d75a77b69052e-474bc0979bbmr56949661cf.31.1740755188473;
        Fri, 28 Feb 2025 07:06:28 -0800 (PST)
Received: from rowland.harvard.edu (nat-65-112-8-24.harvard-secure.wrls.harvard.edu. [65.112.8.24])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474691a1d9dsm25621241cf.6.2025.02.28.07.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 07:06:27 -0800 (PST)
Date: Fri, 28 Feb 2025 10:06:24 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
	"javier.carrasco@wolfvision.net" <javier.carrasco@wolfvision.net>,
	"make_ruc2021@163.com" <make_ruc2021@163.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Pawel Eichler <peichler@cadence.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] usb: hub: lack of clearing xHC resources
Message-ID: <14c38dde-e2b6-4981-bd24-c714aaa54ef5@rowland.harvard.edu>
References: <20250228074307.728010-1-pawell@cadence.com>
 <PH7PR07MB953841E38C088678ACDCF6EEDDCC2@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB953841E38C088678ACDCF6EEDDCC2@PH7PR07MB9538.namprd07.prod.outlook.com>

On Fri, Feb 28, 2025 at 07:50:25AM +0000, Pawel Laszczak wrote:
> The xHC resources allocated for USB devices are not released in correct
> order after resuming in case when while suspend device was reconnected.
> 
> This issue has been detected during the fallowing scenario:
> - connect hub HS to root port
> - connect LS/FS device to hub port
> - wait for enumeration to finish
> - force host to suspend
> - reconnect hub attached to root port
> - wake host
> 
> For this scenario during enumeration of USB LS/FS device the Cadence xHC
> reports completion error code for xHC commands because the xHC resources
> used for devices has not been properly released.
> XHCI specification doesn't mention that device can be reset in any order
> so, we should not treat this issue as Cadence xHC controller bug.
> Similar as during disconnecting in this case the device resources should
> be cleared starting form the last usb device in tree toward the root hub.
> To fix this issue usbcore driver should call hcd->driver->reset_device
> for all USB devices connected to hub which was reconnected while
> suspending.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> cc: <stable@vger.kernel.org>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> 
> ---
> Changelog:
> v3:
> - Changed patch title
> - Corrected typo
> - Moved hub_hc_release_resources above mutex_lock(hcd->address0_mutex)
> 
> v2:
> - Replaced disconnection procedure with releasing only the xHC resources

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>


