Return-Path: <stable+bounces-152578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8935AD7C05
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 22:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490BF3ABF08
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 20:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3F62D6624;
	Thu, 12 Jun 2025 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSOP6+uM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A0A299AB5;
	Thu, 12 Jun 2025 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759071; cv=none; b=S+qOcykz3a3SpZzmUya8bVJVHYon0XKCnfUhgMnmmRLMNnxUqKJgfnxuHRYEGL7XhFooC0pWR0fa2yRRI64ql1sRqD1+/28+REOH/XC/bRgHBXt9MfwUXzPjKw0MJfJgerOCQINDCmLGPOejoqWAyhZlLm0JK3Jfyc6LS64OSZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759071; c=relaxed/simple;
	bh=Clk6OwZmh4ZEk4FzjZoCDmqsCAM60jPVZknBM3DT4/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIB/rR9TfHefBwBVO+KM0BIAeFSlD2UxUSv5iGa4lYp5TO1UO+Rk4qFu57d7ZrtI1TM/XZvz0UeA3BNlOTLnBfsigZiVGeHmPLjJlhDkTPTPzwhAuWqQvm1oDPoxJO89zbNez37rsDGwI4eDqjXFxs2Xrb9E1vlq314KzImHnEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSOP6+uM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-236470b2dceso13930035ad.0;
        Thu, 12 Jun 2025 13:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749759070; x=1750363870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2OwgwZVQBwTEcYeuh/g3X6zYyRvhSS/rJsXEikR9Okw=;
        b=HSOP6+uMt2RkMDWUBXePXvfV8l9FMa7gXh6aWrZWOKEwJ17dQhwhcdGmT06yjdUUZ5
         e5jnJ9T6Tl8ftUM7crOTsuucZcgYzjhI3PRjmhY8URMv47gVtdu1aDuvaK3Rp4GZrHGE
         lowyNa02dPHEaOucubxoVc9CfVQuK9tgLZCSS65ExG1WyYUQYI+1+yyeQmrxbIwf1LQr
         PV32raTZtLDYNsoVeDxGPIupWhZ+2mw0/5sJqgmreldjVNqJrJg1R4lzr1cIBorRo/yX
         PHlTNfdZGsvwqLfdjWhz5iAZHxWCCHY0P0fzqqI/8qii95GGkOa9UHOzW9GFLK07vdwq
         bIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749759070; x=1750363870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OwgwZVQBwTEcYeuh/g3X6zYyRvhSS/rJsXEikR9Okw=;
        b=B226hJWLt/RYn779jxJymi2hoGkYDykcTcXk6mRAx2tQe4oCFIBlwzu+mrGRhgUdaJ
         86W10IUhRw15gOgq+3Sy6u9NkJmAM9B2/ekx1/BVwBy+sQ/lYLe4ZX7WAR1JjqijtNet
         7/tTK4ROHitn+GmKLcXDEcV2gHJ67tKlwsQkq9R7a/uSNCqF6sr7XvfhYNHfChEw04NZ
         aq5/SxWo4pfiOc27NV/FrOCimhEc/ZxPpVetODWGi4ApMiHlNETY5hg7cIMrkVKPsS9D
         IRqxGkPxfwDz4mC0FaliK7/bRTUBOCle7po5ZiRb9ChcNeQdLdtmUKAQYXlpwqpONq2+
         P/Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUqmKVTlWEt9LYe+aYiGG90IaNUzj58gfp8uNIUdtt0T6EYn+WgIdiPnxaGrGi1HBRNYvK3iEo=@vger.kernel.org, AJvYcCWd+Re/AsOgFT8vS4JCVZ2Nr4f0KaswqrYPgdNytn1E8558MOfnWVkYBtBceA2VodlDOaTz3xBd@vger.kernel.org
X-Gm-Message-State: AOJu0YyQPbZVUhRqI+5hl82X7ZtfZPEhyhlcTlPLirtSF6j6/XpoUHrc
	+7eABnZhOGcruOBXQLXPs5nYxjfEVctLlA4BZZGka9jsB8JTEV5w+beY
X-Gm-Gg: ASbGnctClLy8qzQuDslLVlIwahsCwAHO1q4OjFUCjb/2UXvK9Km09gk22q3zeWUvgWw
	Kb2x2zg6a9p88pd3bmESbTPyeRoRO41IOPlC5OGrG8MWGPJmowiC+4ZE+cazKovAhpR299G+Hmm
	kP0iNBa2trz6E84qOYGGOMzTwIV43g7tpFuGKK8J6gHeW0jUFdrHR1zp5diwx092ACjjsDmKsKp
	CRBizZ0wL3S5K+jMk/78KYGN6LO2uLgKK+7YHiBS7yBKbbJFycA36NOnKgAc+GwvYV579EthJOF
	kvCqdlIQNdasTg6mtqn4SnbC+4QH7jS9XMwJ6NbEWoiwkAtyrTwwtxEG8ZVa6Tam3GJaY3+vWxJ
	l
X-Google-Smtp-Source: AGHT+IFGsiJo4rfJ8gjCA7awGuxU2HrgWahfe/ktAVdfm2HduveCgZaB7bOrXpFTRMt8vuTJLxsI9g==
X-Received: by 2002:a17:903:166d:b0:234:ba37:879e with SMTP id d9443c01a7336-2365dc1e884mr5827085ad.38.1749759069680;
        Thu, 12 Jun 2025 13:11:09 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea8d2dsm1173205ad.160.2025.06.12.13.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 13:11:08 -0700 (PDT)
Date: Thu, 12 Jun 2025 13:11:07 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Gerrard Tai <gerrard.tai@starlabs.sg>, stable@vger.kernel.org
Subject: Re: [PATCH net] net_sched: sch_sfq: reject invalid perturb period
Message-ID: <aEs0W32lPsKZiZFp@pop-os.localdomain>
References: <20250611083501.1810459-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611083501.1810459-1-edumazet@google.com>

On Wed, Jun 11, 2025 at 08:35:01AM +0000, Eric Dumazet wrote:
> Gerrard Tai reported that SFQ perturb_period has no range check yet,
> and this can be used to trigger a race condition fixed in a separate patch.
> 
> We want to make sure ctl->perturb_period * HZ will not overflow
> and is positive.
> 
> Tested:
> 
> tc qd add dev lo root sfq perturb -10   # negative value : error
> Error: sch_sfq: invalid perturb period.
> 
> tc qd add dev lo root sfq perturb 1000000000 # too big : error
> Error: sch_sfq: invalid perturb period.
> 
> tc qd add dev lo root sfq perturb 2000000 # acceptable value
> tc -s -d qd sh dev lo
> qdisc sfq 8005: root refcnt 2 limit 127p quantum 64Kb depth 127 flows 128 divisor 1024 perturb 2000000sec
>  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
>  backlog 0b 0p requeues 0

Please kindly provide a selftest (as a separate patch) since it looks
fairly easy to reproduce. With AI copilot today, this becomes much
easier, so hopefully it won't bring you much burden. :)

Thanks.

