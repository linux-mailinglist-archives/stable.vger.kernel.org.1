Return-Path: <stable+bounces-179322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256C3B5427D
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 08:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD871C23156
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 06:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B801280305;
	Fri, 12 Sep 2025 06:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cpvLPB6G"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F695286D64
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 06:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757657222; cv=none; b=ZYyJPw6sH0Km4HdROoPAqzrTGJMKfkAL4VCywxisHhfwokTLUQ4m+XhAaRFtvpY1LAYsbPWFhKRyWGmwWqnGb2TbBWZE+9p1tYd0vW26fiURC4pYe3nvqCPLEmQFK03y9CR392xg1KgfUJMPyA/jGZAOk/zZC4JiryywcqmsBe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757657222; c=relaxed/simple;
	bh=J7ebgsSOU/+m7MUBY6Y0wTA7ivnCKbQ2KriY72t6P9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMQu5XJVEaD7sBjXvJYYs7eaUfogth8B6qfs7CBaqaOpqGwjQs6wgCccW+mqTt8APTCnn+5POc1DHxvw+PkQj2BuRGagjSLkKZAXNzAEfwydBsjDQcfNNPqVu5meiYXTEY9Tt31q17cjEmBOg7EPcfLIza3v2ypJHt8d4D6DsOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cpvLPB6G; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f753ec672so1678022e87.2
        for <stable@vger.kernel.org>; Thu, 11 Sep 2025 23:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757657218; x=1758262018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lB5FktB8/5J4NSxT9Jjpfp64bihH79idm8uD0pyv3Sk=;
        b=cpvLPB6GeK9s7dC3bkoKC6UHV0jv0/zCaWYqqjQ9v/R0GBDShzz6xtUyyrUdG0pLOp
         VMGYB/5KzAp4PQOK4FsmWupgyBpdmeMpayMKr4NdsYITMkjtY1Y/sUxmMtmvCSwgvty/
         a/D9Yt2TZjTQqyU9llYdyGxOanfO0T1mzx6XX175DGwfwdXZ/NAEXo9au7rKBgX6kX1k
         Pnzki/sW6Mr/G8T6RGe4kbciGcqs6x29MVh2ugluU03FaOPkmyo9SkcvQnjSczOWG3PX
         4QAsHqJIdl4hJE1IWd+XZGQGUgriVgFw8ORmaH0xDeaDT/1Ngat6ltRvhaDBV4RWAENM
         B8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757657218; x=1758262018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lB5FktB8/5J4NSxT9Jjpfp64bihH79idm8uD0pyv3Sk=;
        b=RBBsti1wLCUCmW9fgSTepOzlAssVoL/JkA1YXBWUD+9bJ9Q18Mm/jggX3YqPPL+yEI
         KAoK/wIDxJasXby+K09/lh//Rov1ToLRl0cBVlVAdIQv77Db7QFTNK+yJAxuoPtzj16N
         dUXmkp77LmS3Fbwz4FEf70gX7PT8BOpC+Txii1F+MVcYB5OVRddYO4STyiXFwrVrO8TA
         /N8Z1GTP2/EPEzP51D/TsbrM5cb4RJmVi8fXPRyFx5miyXEX5y+S35nTF3rS+teP+I5s
         y1u49bcv77HMxwvcFiokxsTgWnzzMCoUCKeRLVstNgyfHgmPUdKLdPK6QPipMY5woARo
         24Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXvh84DHSkLJ8CvBqtmS9AB/Dl9Qwif0WGBrCegvC5Fdrmb1EPNW/qXoJPeFJXY4IasF9YnbXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26nmcsdt2oH/7JlNPV1St3P59UAJFNp15FzGq0buLcPJz/KPu
	BEShaUJiZKfRzYDSvpJH1CROyXiysnjA/yuL6wah1VWX42i3DX4rtNFi8kNDEV/Tceg=
X-Gm-Gg: ASbGncvhSQtIagJ4MWcGhaP36IBxPeg8XFssnRfQUipGrt1hOkdvSjZQd0mEw232dIE
	lmmh2L+V9ZJxW37P+p5I7DAhIlUWCKy2SRXArXdUzx2rWxNU3k0UYOSbDuStWLEXexuZkdxeuB1
	YJ9vqQsPeWvS5FGVr0VIR/INOmEEJAPa9czz6llOC4ytHnDKmSvG838IZTDr0jkfaLu8wo1Oy9c
	5PIe1vXFltQvqtIPfICEBdG8lZoNsTsqeMScOAmgXt30bv5Z0nfzwdhchmeTthtDIFi8b6X6Ouz
	SgjVX9kX1J0yk22nWYwnmyWemqWgbeV8+EcXvCkpNYLHECJGW9mte9ktKNdp6RlSig1bUNeXcZy
	1UyvVlHnYyGbCSe7Ra2m3tgpmzZK7rXM2+fgReKwpyeylsSu24OrsLbhULAq5h+lSwA==
X-Google-Smtp-Source: AGHT+IE71rEGB081PBLdScsfzSjSdSw6Z/pFN6aBX9OQzO88wLDWOZrCaDv039zv6HKilPxbDHoxow==
X-Received: by 2002:ac2:4cb1:0:b0:55f:7be9:7a32 with SMTP id 2adb3069b0e04-5704f1ce6f0mr493677e87.37.1757657217951;
        Thu, 11 Sep 2025 23:06:57 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460dfa5sm887553e87.112.2025.09.11.23.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:06:57 -0700 (PDT)
Date: Fri, 12 Sep 2025 09:06:55 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, arnd@arndb.de, stable@vger.kernel.org,
	Jon Mason <jon.mason@arm.com>, Ross Burton <ross.burton@arm.com>,
	bruce.ashfield@gmail.com
Subject: Re: [PATCH] arm64 defconfig: remove CONFIG_SCHED_DEBUG reference
Message-ID: <aMO4fzACWKFtwJ0v@nuoska>
References: <20250911144714.2774539-1-mikko.rapeli@linaro.org>
 <386a9d77-f708-4a47-8318-b83f862d5c1d@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <386a9d77-f708-4a47-8318-b83f862d5c1d@linaro.org>

Hi,

On Thu, Sep 11, 2025 at 05:01:11PM +0200, Krzysztof Kozlowski wrote:
> On 11/09/2025 16:47, Mikko Rapeli wrote:
> > It has been completely removed since v6.14-rc6 by
> 
> In the future please use kernel style commit SHA ("foo") style.
> Checkpatch probably complained about this as well - are you sure that
> you had no warnings here?

Oops forgot to run checkpatch :/
 
> > commit dd5bdaf2b72da81d57f4f99e518af80002b6562e
> > Author:     Ingo Molnar <mingo@kernel.org>
> > AuthorDate: Mon Mar 17 11:42:54 2025 +0100
> > Commit:     Ingo Molnar <mingo@kernel.org>
> > CommitDate: Wed Mar 19 22:20:53 2025 +0100
> > 
> >     sched/debug: Make CONFIG_SCHED_DEBUG functionality unconditional
> 
> So all above is not necessary.
> 
> Anyway, this was already sent:
> https://lore.kernel.org/all/20250828103828.33255-1-twoerner@gmail.com/

Good, hope this is queued and lands in stable too. Would be nice to get
this to 6.16.y.

Cheers,

-Mikko

