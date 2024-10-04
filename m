Return-Path: <stable+bounces-80750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DB89905AC
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 16:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3396B22F8F
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 14:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5534D21791D;
	Fri,  4 Oct 2024 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SN1Ou5gr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D37721790B;
	Fri,  4 Oct 2024 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051175; cv=none; b=jgIJv58JzcJd8fNYPOMugCwP6NcXOqtlcdr1WH6ai8jkIvhTBzE+dJ1ky2/fITXrKHEU6eCuw82eeMQASdDrtXaxn7GEjMlpgWSOqd9IAvBDOcMs77SiKnSctrGfPNKWY2JTP6leFjdsbom2KpzFsCgZTyPnte1leuZ15OYm0xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051175; c=relaxed/simple;
	bh=KFi1jXYpPeiWz4kRbnCz1BASNcFRlFUNBNrtMEWM8/U=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3QHKYYpUV8SpPc24eQ/zC2v74zAyN2ikRgAtHJIo8LnkgGwaA/velbLd7wl+BG5SJWGRDYRK4miWe+1zqg8+ep4JyvozA8XfgqQ9v6bXsnZFwh5ZddPstcTFc2BGAQE9BFnatVmBg02Jo1EQE4fGcyKCuj2/liT600UUVSB4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SN1Ou5gr; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cc84c12c2so1227761f8f.3;
        Fri, 04 Oct 2024 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728051172; x=1728655972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LJ3ed/WBG9rJQ5Y6GF4Ay+xNTUZeksnK2kLLIlU2gZE=;
        b=SN1Ou5gr58AWUYICy+zM6DbcKvgdCGIy02R+DCGDkUKI/o3DKQnF8n8SXxjCCZDS0n
         7UI+y4h5kQhoF4pQ9FSXZYz/8v6b2RjoC8BUqw35kmcirqBYuTsbayy5Hndzn7ttLdgj
         HCnoYahiJUOLkpYGJFjCtKkbpRt/fm/VddER9M1J1gll9Ky34UmUk+aj5H7KbREgAYt5
         XacYSHONh9DHQe5v5+2BthvMUZxqId1NZ0JvEpqUaq+7XXasvBZWPF/ohAm49JDI9YN+
         M5TvsJt5XHvCxDQv5RQhf3+RPv1rmwlTUM/KLGEwAD6bX5GTCTJdzGLXtSPxOdxyGzMM
         Z9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728051172; x=1728655972;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJ3ed/WBG9rJQ5Y6GF4Ay+xNTUZeksnK2kLLIlU2gZE=;
        b=JY/tYovG6Ja8K6oselK7SD4KgNXtckbb7q/SgZsTAIqTIBsh5Zx6vb91LbP4riBYyO
         Y9eG9RhUGu+oiEgBKR+3duD2cJOOa/9mWK1ILMF4pB0MQu4yFg0dTRQZW/kLLUchiuvP
         mbohGSD5HbHqeDRMMSthk6Zw4E0lMsWpMqpCI6S1nCXknLvfVuFOJkxy1oaohAf+s/PG
         jobWilEfe4pUl9aK79R+0uKSwtQl7Q9hqIt1LCLPESAHZ9M2aZxRTOu8bTxCTiFWgm6R
         7YWPChzymJ2CfSd3pAjg7mKyxGj1RamuuEwjpY230RIEwQqmygS0xh5VTpnAMb8gfKwS
         cbBg==
X-Forwarded-Encrypted: i=1; AJvYcCUaDgto1LaOi74MkZF0amcUMmGFq+E3kI0FI9+F6dwNWw82QZ5gu9q7THTRICbgBD8J2fUM3ta1e/4LygY=@vger.kernel.org, AJvYcCV265DRzI9JhtT/0805IfwzvHAQMQuov+sen5Uy2JCxqIDTJRvRInxONOp+85+XcAyShlOsg2zq@vger.kernel.org, AJvYcCWTwtMJLzWcin8WPuIjTWZVpTPQf3PFbD3yNbCE25XiGLW47yrPC20ixLOUmRZpQ3Jx29y4yUPZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyYm0d2ai7xmEgco1U0/h9oFI260R/0OZuWm//Wxh39x4C3WeO9
	phJdIBdsOZTv3L+vQG1AOtIbXpB0ggwP2YfWqqyu5Tz95qvpS0pK
X-Google-Smtp-Source: AGHT+IH5qnO8v87Y+PtBzIsG2zvcReIsL7B/t3XYP1/RS6ppPLz7IXhWCk7CrV+Nr3L7bFDjzXKXBQ==
X-Received: by 2002:a05:6000:1866:b0:37c:c870:b454 with SMTP id ffacd0b85a97d-37d0e8f708fmr2160057f8f.49.1728051171654;
        Fri, 04 Oct 2024 07:12:51 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d08212a10sm3332442f8f.27.2024.10.04.07.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 07:12:51 -0700 (PDT)
Message-ID: <66fff7e3.df0a0220.275e8c.fc30@mx.google.com>
X-Google-Original-Message-ID: <Zv_33Ku4g204jViW@Ansuel-XPS.>
Date: Fri, 4 Oct 2024 16:12:44 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
	stable@vger.kernel.org
Subject: Re: [net PATCH 2/2] net: phy: Skip PHY LEDs OF registration for
 Generic PHY driver
References: <20241003221006.4568-1-ansuelsmth@gmail.com>
 <20241003221006.4568-2-ansuelsmth@gmail.com>
 <2dcd127d-ab41-4bf7-aea4-91f175443e62@lunn.ch>
 <66ffb1c2.df0a0220.1b4c87.ce13@mx.google.com>
 <a463ca8c-ebd7-4fd4-98a9-bc869a92548c@lunn.ch>
 <66fff1c0.050a0220.f97fa.fec2@mx.google.com>
 <ce1feaa5-b9e0-4245-8e64-6e90bcf528eb@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce1feaa5-b9e0-4245-8e64-6e90bcf528eb@lunn.ch>

On Fri, Oct 04, 2024 at 04:11:22PM +0200, Andrew Lunn wrote:
> > Ok I will squash this and the net-next patch and change to dbg.
> > 
> > Do you think it's still "net" content? I'm more tempted to post in
> > net-next since I have to drop the Generic PHY condition.
> 
> Does it cause real problems for users? That is the requirement for
> stable.
>

Not strictly bugs or kernel panic, just annoyance, ok will post to
net-next. 

-- 
	Ansuel

