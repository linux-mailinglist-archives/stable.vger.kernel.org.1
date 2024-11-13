Return-Path: <stable+bounces-92880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD1D9C6711
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 03:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009EF2848CD
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 02:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3F113049E;
	Wed, 13 Nov 2024 02:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="v+WPt11r"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B7D7082F
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 02:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731463510; cv=none; b=txx/XVvqS8PUtHYbgwPdX3fjTKgYNDa354F/zxuOF7CH+WspC0ACn7HkyDjwyk1OWTSjG30R7Om4lMfFan8SABOXKbHIE3AhnnM7z6CJqXaE+Wz+Dk9fpIljRwENZEdTJHGUgqe7B/fzCG5bfrgdJ2X+Y8aa4hhWQpB9SUAHaZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731463510; c=relaxed/simple;
	bh=cZnw/3d3PzrW45LyARayO0lNM4W6T7F7djT+bgWr9KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocAYJIdmCRSUbj8Gpnmm37QvqpLhKuS0y4IRaeU0Z1nvHjC6C+/LwkxPRSul0jeiu/4mXpiEHjwdOSNHC+MD7vKvEOw8lRZH6TKvjxB9rTn1SpZJg3+Jr2vbES1cMMk4jbxjcarfkDYDIcnEXSAlNWkbywnj4PBPKHeEyxFQu5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=v+WPt11r; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so4954360a91.2
        for <stable@vger.kernel.org>; Tue, 12 Nov 2024 18:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731463508; x=1732068308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMHgs78kJCT59kXAGyaHtemSt2oZrSdkOMKAYsOBJwg=;
        b=v+WPt11rn6f+WywNl7fcGBmz9BUQ4BjOvHs1RgyfVhq8no4RyR07DlUua0XokrWrxC
         hOYiFQICXQrzHKAJsjMoYkQ3m2dgcDGsjv9jXrpruxy9tzUTzb+czjo+gVxHnRge7krr
         4tfUUrSHvP67kiVHvwrpkYnMTBuS27QZt6lY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731463508; x=1732068308;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMHgs78kJCT59kXAGyaHtemSt2oZrSdkOMKAYsOBJwg=;
        b=TaI988wWk4/pB4o1q25N9ObFUfuYqgVIZhi6Q51wNjE4AKHZf8N5dvO5l/PVQDUsgO
         17T+e1M2HBed35Mr57CrO1o9tcUzPiUgy+Br3A9BarXjTTox5lvwcHSs/XjTL51JUl0L
         uqZoVv0uPoq6zYucW9JkS3XCY9bZaTe4HM90O43Z6c1mfPLwd9QYe5rpmUSa9BTJUYr6
         ovtGIwa4dPLdhMAluNoEfIlpqp63aPJnHQBvP2Tdx0xvXe37jD3Lw/jmtSNG9lllJgFw
         FjC7/Uy2Zj4muiFbkazVkVRKEcRX3X3cBFF9dTDL4Ns2A2T5Fj/2tHr8wZ3AnTXtk717
         bJ9g==
X-Forwarded-Encrypted: i=1; AJvYcCXDfJi13V+OYHjnVYIJVK70PzeyshrJFn9I/V2SKzbZ1H5TWBjd4uOvhDD+aaE9ReFvLd5P5yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU9bKRCuVovf5HG4617PQY5h/TiO16agkfiE12BfZGteetktTf
	pzcXj16O4zii7zm2TC7iyjoQ6Ii9GCuhf+R2wXhckTDibIuNXeUruOLe+7Bnd7w=
X-Google-Smtp-Source: AGHT+IE3BGRjmhR0ZvvRxux2FPKe4+dk1Cle8rzXMHK76AdSLTy/P4WM0poxY1ZTUsslRuA+89mD9Q==
X-Received: by 2002:a17:90b:1d11:b0:2e3:171e:3b8c with SMTP id 98e67ed59e1d1-2e9e4c73c42mr6334898a91.25.1731463508401;
        Tue, 12 Nov 2024 18:05:08 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3eca101sm275665a91.14.2024.11.12.18.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 18:05:07 -0800 (PST)
Date: Tue, 12 Nov 2024 18:05:05 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	mkarsten@uwaterloo.ca, stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net 1/2] netdev-genl: Hold rcu_read_lock in napi_get
Message-ID: <ZzQJUdjWDGqbm2QQ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, mkarsten@uwaterloo.ca,
	stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20241112181401.9689-1-jdamato@fastly.com>
 <20241112181401.9689-2-jdamato@fastly.com>
 <20241112172840.0cf9731f@kernel.org>
 <ZzQFeivicJPnxzzx@LQ3V64L9R2>
 <20241112180102.465dd909@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112180102.465dd909@kernel.org>

On Tue, Nov 12, 2024 at 06:01:02PM -0800, Jakub Kicinski wrote:
> On Tue, 12 Nov 2024 17:48:42 -0800 Joe Damato wrote:
> > Sorry for the noob question: should I break it up into two patches
> > with one CCing stable and the other not like I did for this RFC?
> > 
> > Patch 1 definitely "feels" like a fixes + CC stable
> > Patch 2 could be either net-next or a net + "fixes" without stable?
> 
> Oh, sorry, I didn't comment on that because that part is correct.
> The split is great, will make backporting easier.

OK, cool, that's what I figured. Thanks for the guidance; will
repost shortly.

