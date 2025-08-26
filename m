Return-Path: <stable+bounces-173733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4BAB35EE0
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486833AAC3A
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658B23090E8;
	Tue, 26 Aug 2025 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtuuOliK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9974D2798ED;
	Tue, 26 Aug 2025 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756210300; cv=none; b=S75qCEBbePhyQeImcbLkZv/P+dEa5+iFcesd7xT/Ta48CWiS2VmV0PjRtvGv2efkAFvyAQZ9rDO+XcG9tNVW/F+KQ41sIougObsgvZBRcqObN9jvBkyP5GiJ+IVwK8MfrL0kzN093cXgaXOhR9JbI5G64n3L5veKVlOpfqHExeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756210300; c=relaxed/simple;
	bh=RhEbsQKmIX/lirH/uUzChufR/shylRIDYLkxgKJenr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8dkTfjYtYYoXkBd0OoSQ5WMlNnrshM9L9UrV8RN7TFg5R89aMxvHxfvRcDJwVPdrHINh4jM3H4h82ZXXilhu+W0/CcXAayWaXFRqcj4658jPcaK3nOKwnkJLpQvolBo5ADLMWt9ZAtzIjSZ18HX7ATPjGq6vwArnS/eaAn9Zwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtuuOliK; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c98b309804so1677204f8f.1;
        Tue, 26 Aug 2025 05:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756210296; x=1756815096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bgo2eJak2Be9BA5zOK9ll3HUyMbKDaGl7xMwm/BsZe0=;
        b=DtuuOliKuY+8CUlHQ1yZiJ+WNTG9gNRXTUh3IC7oZK4EMOVmcxhEXYFnrdjUcf8mLN
         QPtkt7U16qCOX/8Ycb3tVnHKsbp0iekFl/j5CRZo07JHhs43q8W38peheiMm8BKTcRka
         avSZhkGD/EIdymf17UBub+VMu2CSQGaeX4cIFYFbiLDNJ3iOqwoP2BP0zMXu49bvE3cf
         m/fIctlvimbgGnICPgseJsKw6CwL7aaWQnJDxUtlPFB8as9JTdiMT9GEABF2FVjt1yUk
         LklbHs0WUkiEzG6yBSVwOoAzq2mflBE0FECInOopWx8vFrEwSUA8aNEWrHSbrP8rcNQS
         19vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756210296; x=1756815096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgo2eJak2Be9BA5zOK9ll3HUyMbKDaGl7xMwm/BsZe0=;
        b=sbB12946ZaX87jev6iGdSwvkhsGLG4f7HwFE0KV1+2VwgLtWf7Mvj/mg+ubPTeJr+O
         8JHXcDEXTnrqLUMkQBQm58StUWqWTJyMULObbcq7Z3KfGhh9msDrBVinLRm2cAJT6csy
         tH+gRaYC+bm19my/Zjr5WQxoWQ2ktVm7ITKoXiFezns9QIrPSVhh/1quDUNXLXlTDDPF
         vyEsWU6GnNml/fEfe2eUCxS++hdKU+R6sgYLyH7mfASWLYPD3dOJL0b2bHGAqrPKzg7K
         F6Xbp1O+TqZ5NYLLrWkQoAiZPjwNCxV9zVydHu0W+0IDF3x0pGKh6mnGbXk9Gk6ImEjA
         AJzg==
X-Forwarded-Encrypted: i=1; AJvYcCVgtZWCRTZ7s4Jnl9mtu0PKgNuXp9JFuPBCwbh/7Ioq7v1100mbhtBiw1BETe3aQeP5wJeb3dl4@vger.kernel.org, AJvYcCXWt/cY6VfbPUVo2vFm9XDuTV0H9cdOp5zFmqejhzNs1qqbbG11hkBAA1m7CYLiQY/eKBrRUZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6bT3oIpy0n1ptwtSmIkGw4bQTwvv3pJouxvX0FzKyVOoceA4T
	EK0H/t4raA94MIyE8YeiBCqpiPdqBzze/qwjpV86wlt2feZQBKXwI+Fq5OCBonnO
X-Gm-Gg: ASbGncsi+uUj5gUHtdLmNh8EtjG84d6KxlrNsa+rMjGX8UJaiuGHPz8SlEwjYzX1cob
	ufeDH1J/ioRfFKowimq7A4ii2Ox7nQ0tY7/m6CSVwpgnRN0myz4ofaW28DUMzvxHHf61gFhJNka
	MbTw1H1xMh/H4KYQ5H+Iyj5RRsfr6OMxDXrbtvA0sgsOg2r7u3QBOqYZSvAd6pMi569Eh7lmd/t
	qplIbJlSrvfkGfHDsFeDptndNp4xLw1DVMK9sg6NrjKGHuUGrSPsoHR1YQfA4Lg8DzbSpGVUT3b
	cmb0Q96EpCGbVS0B3nmoQ07Gedam14vEOm/l0R5yw6jQMtMAV3V3nXXzd/Efc7uBCeHcZ144MM2
	78C9fEX71IdBGzsPwxEV8tUThQEYCNlLBk/Q=
X-Google-Smtp-Source: AGHT+IFyt1noHdTU+Lxyu4hFFrhdSpjqHvjbZWL24i076P4M6ZzzL90XYNqTJ7uxCxOxl+awWvRnUA==
X-Received: by 2002:a05:6000:24c9:b0:3b7:93d3:f478 with SMTP id ffacd0b85a97d-3c5dce01212mr12959641f8f.51.1756210295606;
        Tue, 26 Aug 2025 05:11:35 -0700 (PDT)
Received: from localhost.localdomain ([45.128.133.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211e87sm15670520f8f.44.2025.08.26.05.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:11:35 -0700 (PDT)
Date: Tue, 26 Aug 2025 14:11:26 +0200
From: Oscar Maes <oscmaes92@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: bacs@librecast.net, brett@librecast.net, davem@davemloft.net,
	dsahern@kernel.org, netdev@vger.kernel.org,
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: ipv4: fix regression in local-broadcast
 routes
Message-ID: <20250826121126-oscmaes92@gmail.com>
References: <20250825060229-oscmaes92@gmail.com>
 <20250825060918.4799-1-oscmaes92@gmail.com>
 <20250825155630.5848c357@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825155630.5848c357@kernel.org>

On Mon, Aug 25, 2025 at 03:56:30PM -0700, Jakub Kicinski wrote:
> On Mon, 25 Aug 2025 08:09:17 +0200 Oscar Maes wrote:
> > Commit 9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")
> > introduced a regression where local-broadcast packets would have their
> > gateway set in __mkroute_output, which was caused by fi = NULL being
> > removed.
> > 
> > Fix this by resetting the fib_info for local-broadcast packets.
> 
> Meaning that 9e30ecf23b1b would still change behavior for the subnet
> broadcast address?
> 

Yes. This is OK because subnet broadcast addresses have separate entries
in the local fib table.

> > diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> > index f639a2ae881a..98d237e3ec04 100644
> > --- a/net/ipv4/route.c
> > +++ b/net/ipv4/route.c
> > @@ -2575,9 +2575,12 @@ static struct rtable *__mkroute_output(const struct fib_result *res,
> >  		    !netif_is_l3_master(dev_out))
> >  			return ERR_PTR(-EINVAL);
> >  
> > -	if (ipv4_is_lbcast(fl4->daddr))
> > +	if (ipv4_is_lbcast(fl4->daddr)) {
> >  		type = RTN_BROADCAST;
> > -	else if (ipv4_is_multicast(fl4->daddr))
> > +
> > +		/* reset fi to prevent gateway resolution */
> > +		fi = NULL;
> > +	} else if (ipv4_is_multicast(fl4->daddr))
> >  		type = RTN_MULTICAST;
> >  	else if (ipv4_is_zeronet(fl4->daddr))
> >  		return ERR_PTR(-EINVAL);
> 
> nit: please add curly braces around all branches of this if / else if /
> else ladder, per kernel coding style guide.
> -- 
> pw-bot: cr

