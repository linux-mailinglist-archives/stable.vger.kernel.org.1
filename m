Return-Path: <stable+bounces-37980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D137089F9F1
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 16:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C5328590A
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 14:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57ED116C6AD;
	Wed, 10 Apr 2024 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj0JxiS1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CFB43AB5;
	Wed, 10 Apr 2024 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759666; cv=none; b=AbyqU5pH7IWNd1O6SHJ4iDu4GJFVAh+cJvOTiC60WlJpVBM02OhcYpJVNbGYlDPwBNDYH6ACM+b2U+rOp6JiVCbRbPdEBZlR9q5EnVfr3EC2MouQjJCgqwcNtKcHMO1r9bGPqEOKqfKbu+Z2iE5HAkqatAYmLO5X1ERGzK1M8Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759666; c=relaxed/simple;
	bh=bz/oHKSjEf6FgXoa8fCr/785oUgiXRozlZrE1+Asp1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJwS78j+jy4LPhT+eF7AUYup0dJC7tTNKVl1hUTlDjLyugv3BvwVr79n2ZOX4BsUe6jba43almGop51GWaTdX1wxN31Fa2uTYXg61uLYcvCZqUqZmn6Db3kdO17+9T0mLeTJn3NS3rBz8P91hgpPUs4DDRXM0GudORk0646+f+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj0JxiS1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so8362034a12.1;
        Wed, 10 Apr 2024 07:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712759663; x=1713364463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XsY9i5J1DKu25sfuXNOnGVtCjVYnBq3+YDHmrpnhBN4=;
        b=jj0JxiS1am0gN26rk3OTGE+wu/suPzx/eCTA+P16zM91PPtuR3AUCMQ7cMEjOb4JNQ
         3e7AUf6QOJubI7OKVu3DRxms/b+sbo10Y3XPNvg04TW1dwTHq9SAADiD0k4vgk7xEhSJ
         4nCalp4mR8QoGGofbgRXFHGcx9gyaR2LWokoEe0IHNeYt9fdcEiC41kYuqZG3oDM1pZR
         oG2pJC9l/6m/kcGRBZm+TtahSVd0pKrbxKxw2TUs3BxQvq9cXxmMI4hxT60yk65wzUC8
         XiO4dXCf2glPP/FjIdX8yfkEQwGRwxfhv/sm6k1JNNv6N1ncMYE4xG+ANb3xAxupdGH5
         U3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712759663; x=1713364463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsY9i5J1DKu25sfuXNOnGVtCjVYnBq3+YDHmrpnhBN4=;
        b=mrNA5GFAvwT655VaTlgn7mCWa7MUmDMUA2dq94ZRHsH2Uu91eR3/0MOtxLbnZ0/SOf
         e2QbGhdrr+rh1ABS07ld6jO0XMk9XifWvr8u709LqB1gBKI2TOTd87nYmzyyipWeSLp6
         2jodOy/I6nClqQv96JhHtEkgbZLWjzmqtkZ5/QjTIDvuuZDvldsRryy4yANtGqyZiGmQ
         v7uaUP6xap0W17jhV4yIvugOm//JYOTqp5e+kuEen74VO46e/TWtKshJe2vNymx3BeUD
         fLG0lKsXFj4Z+gKw4A5iAk9e1iJPvOgHmjympXL1HE3L58ypZEygSwHjYv3r4awakScY
         EgzA==
X-Forwarded-Encrypted: i=1; AJvYcCUPzEBMNpxKu1WH7YAJdKMuXr9deecj4L6vnMmCeFX/+ttbjA7Vh+/u7d3dSn1r4LE9a+iFhZLmWtJ+F3bzvMkwqD49IotRXPSDm8fPLQ/Tu2orzuvgGb5v7jABiSmF
X-Gm-Message-State: AOJu0YwVOofKMW7/yerBlBcd0jyiYn96uhvTlruGc2M+EVlYAlRBQ6Rj
	4tpscZnvoZ6yL8uXmT3tJGB5Z/HRNMmYTWFmG0d+32jlvWmkX152
X-Google-Smtp-Source: AGHT+IFOYaxjNyCn31D0+/QWIPwRWdtitFLndjB6ISZxp48/Czt91R/WG8+dyf3qtL2w4e2a7aLgVw==
X-Received: by 2002:a50:cc8f:0:b0:56e:2db0:c7b6 with SMTP id q15-20020a50cc8f000000b0056e2db0c7b6mr1912881edi.42.1712759662724;
        Wed, 10 Apr 2024 07:34:22 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d201:1f00::b2c])
        by smtp.gmail.com with ESMTPSA id w17-20020aa7da51000000b0056e66f1fe9bsm3106393eds.23.2024.04.10.07.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:34:22 -0700 (PDT)
Date: Wed, 10 Apr 2024 17:34:19 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, gregkh@linuxfoundation.org
Cc: xu <xu.xin.sc@gmail.com>, stable@vger.kernel.org,
	vladimir.oltean@nxp.com, LinoSanfilippo@gmx.de, andrew@lunn.ch,
	daniel.klauer@gin.de, davem@davemloft.net, f.fainelli@gmail.com,
	kuba@kernel.org, netdev@vger.kernel.org, rafael.richter@gin.de,
	vivien.didelot@gmail.com, xu.xin16@zte.com.cn
Subject: Re: Some questions Re: [PATCH net] net: dsa: fix panic when DSA
 master device unbinds on shutdown
Message-ID: <20240410143419.ptupie3hyivjuzqf@skbuf>
References: <20220209120433.1942242-1-vladimir.oltean@nxp.com>
 <20240410090644.130032-1-xu.xin16@zte.com.cn>
 <09f0fc793f5fe808341e034dadc958dbfe21be8c.camel@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09f0fc793f5fe808341e034dadc958dbfe21be8c.camel@redhat.com>

On Wed, Apr 10, 2024 at 11:14:09AM +0200, Paolo Abeni wrote:
> On Wed, 2024-04-10 at 09:06 +0000, xu wrote:
> > Hi! Excuse me, I'm wondering why this patch was not merged into the 5.15 stable branch.
> 
> Because it lacked the CC: stable tag?
> 
> You can still ask (or do) an explicit backport, please have a look at:
> 
> Documentation/process/stable-kernel-rules.rst
> 
> Cheers,
> 
> Paolo
> 

My email records say that it was backported to 5.16:
https://lore.kernel.org/lkml/20220214092515.419944498@linuxfoundation.org/
On 5.15 I have no idea why not (no email).

Anyway, on linux-5.15.y, "git cherry-pick -xs ee534378f00561207656663d93907583958339ae"
does apply (it says "auto-merging"), so maybe Greg can just pick up the fix with one command?

