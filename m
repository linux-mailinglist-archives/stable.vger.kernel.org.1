Return-Path: <stable+bounces-75886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E4D975931
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 19:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4CF21C2337F
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 17:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E644A1B251A;
	Wed, 11 Sep 2024 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy92hCvX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1921B142F;
	Wed, 11 Sep 2024 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075178; cv=none; b=FyhkT/8PaDy7v9d0x62yq1EtE4a1LDfLB/rxnPLBKISsJ4xlVZ5UkRmaCZfDiBAduL9Llf8RYa2lKS9rOjxC2dMMj2Dq/ZuD4x4prKndoVu2CyZtNsgV6OUUueTECyC6Pd0uW22Zp1IcwzN8v3M9eGHZCxlwbTI3TZz8aAqUijw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075178; c=relaxed/simple;
	bh=nb43cDsO0TADiQir4ODMmF3/zIgggQPtWv1K/xJZfOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/nwDqY58G82mjMguAIrNiY2mEm/sP23rBxlmi3ytr/9v2X6sxiA3ALNaCM2tay2P4AB6Ua6UVuLG/FEP875GitcQWG3q2d5ztPG9eLsB+RPLuGvaOjphNmKDBI6tP47iNdlXwnjgtxhmcfbsIOPqgKiNiFgboj3iRgUyXaQjdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yy92hCvX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb1e3b449so6608445e9.3;
        Wed, 11 Sep 2024 10:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726075175; x=1726679975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WVEqi6YJV2uXXOJa4zIXz+knYBt9ewc3uLNRHvGVXVM=;
        b=Yy92hCvXqjL+cJ1Mh3N3bYPlL7AL6S68qt9/Rf/3CL3fbW7E3ivM/YINgcYnDLKCfA
         D8sAJauW0+GBriZVd0kBMTRJNcpFJBtVE+H9fdYYLbyqTh39aRGhPDRQ51ljtvyuY28J
         zsZK/ek/zfpnR729HluhMN3Y/LVrwfFlGuWy3JGwdDeeWNY954SNZgd7rDUNq4kpQW9+
         Rp1xLKF6Fdmpx6m2T7vSAugORCJelv8bmCb+2GYxNx3fdiL3jWB48p+ALI0ytBIdDw47
         NxnImUMnEU95f6bifwGVNa8EdHCkzTop+QeiND26KmR9LjSbix+9Sc1Hq09gXzv+Hbca
         vPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726075175; x=1726679975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVEqi6YJV2uXXOJa4zIXz+knYBt9ewc3uLNRHvGVXVM=;
        b=Z9R/CthfZmSIBq9OoHYYFrb8VkHAN/EOgLlFZGCQ79I+ngOWEGa07AYpVSbdwp9BK4
         eWoUpt924g66mX1ToJUPHgXPoXLD4SSVYlKSs3xBWji4r3rXdrQANMf1ax+z30UU8aDv
         5dO+3gaB3s2X/ouOX7PxVV/O4uxM6SFDh77rqf3Z5KgbYW51s81iIkXOoTJsO1r7UwSx
         VmFhd/VCQpiK6VOBBa/IT1bKrJu2alQKJl543rE8lH27cL030xk0WDs5UhyBFj5d72UT
         x339+pvWzAiM8rpAV0+ophxtAzBNRQE9Y7fJ3/k3W5vc0lt+GtQSpTq34mpWjH788Pid
         OXDA==
X-Forwarded-Encrypted: i=1; AJvYcCVaxiUDO48eU3pWuOUzeDlUA7BYgcuqnDSCOvnpHhlc9lUYb5m5qRJxoQjfCv9bWEWkBSNBIbg5@vger.kernel.org, AJvYcCXjpzRSJVRZbjShRvDzAP1bYutN2TXRwjFhzRHIGyHJu6CpugY4qemcZuJG5vbJNoQJ0FM5W/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSFBTeVaS+qwtVbljQWzjT88FA5n96XEZam/VeCEDljUqjD+af
	c4FBE4iOAkWGUpnNecVAzLOuQmTMU/ujtGlEPYwD3I66t3Pdel2x
X-Google-Smtp-Source: AGHT+IHWYHM19QehhAcotmTIJvBKXFis0R5R6N0r5fH8IHZwGZcMtIleCSsPTl1axXVq8UXDAEZAHA==
X-Received: by 2002:a05:600c:3b25:b0:42c:b79c:5647 with SMTP id 5b1f17b1804b1-42cdb53861dmr1187725e9.3.1726075175094;
        Wed, 11 Sep 2024 10:19:35 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8b7fcsm148928345e9.47.2024.09.11.10.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 10:19:34 -0700 (PDT)
Date: Wed, 11 Sep 2024 20:19:32 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: dsa: lan9303: avoid dsa_switch_shutdown()
Message-ID: <20240911171932.yqt5emtb4xmrdqgq@skbuf>
References: <20240911144006.48481-1-alexander.sverdlin@siemens.com>
 <20240911162834.6ta45exyhbggujwl@skbuf>
 <9976228b12417fd3a71f00bd23000e17c1e16a3f.camel@siemens.com>
 <06f6c7d6f1e812c862af892f89d56d74b69995f9.camel@siemens.com>
 <7b9dc2a2494c2af62cd37e506bbad73a44819c36.camel@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b9dc2a2494c2af62cd37e506bbad73a44819c36.camel@siemens.com>

On Wed, Sep 11, 2024 at 05:09:08PM +0000, Sverdlin, Alexander wrote:
> On Wed, 2024-09-11 at 19:04 +0200, Alexander Sverdlin wrote:
> > > > The difference between that and this is the extra lan9303_disable_processing_port()
> > > > calls here. But while that does disable RX on switch ports, it still doesn't wait
> > > > for pending RX frames to be processed. So the race is still open. No?
> > 
> > besides from the below, I've expected this question... In the meanwhile I've tested
> > mv88e6xxx driver, but it (accidentally) has no MDIO race vs shutdown.
> > After some shallow review of the drivers I didn't find dev_get_drvdata <= mdio_read
> > pattern therefore I've posted this tested patch.
> > 
> > If you'd prefer to solve this centrally for all drivers, I can test your patch from
> > the MDIO-drvdata PoV.
> 
> But this would mean throwing away the whole
> "net: dsa: be compatible with masters which unregister on shutdown" work?

I did not propose anything (yet). I'm still trying to form a mental model
of what is broken and what works. Hence the request to test that change.

OTOH, this patch is equally throwing away the whole "net: dsa: be
compatible with masters which unregister on shutdown" work (for lan9303).

