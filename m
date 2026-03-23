Return-Path: <stable+bounces-227917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WICME+L7wGkwPAQAu9opvQ
	(envelope-from <stable+bounces-227917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:37:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F01892EE567
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FF1A3013686
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB41F37F74C;
	Mon, 23 Mar 2026 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cca36gek"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2343783D5
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 08:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254762; cv=none; b=juywqEto7Is+QZOO/AlCXDjq5C6opu1qODUMHSg6rd8Uj4IUdJRYOLIKJaMUrO7dRrqGreyBrd2UhwZfz/5Z0SZDDDqmIGp75RaGGpr1ooDdJKwHw5BcdWbfbmgt8Wwhg6wrtX3YRHDDkCG6pn6d4EvDAQneZXaAf5E7ggHdkEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254762; c=relaxed/simple;
	bh=OM4/8EjqVIC4YfRgUxJxtAfGfU91Jx+od/JJ0lKT8ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAv8GM9VxXTtQ4aoBzf5ttJzMebCkgjGAbWn+PcaaZI5EPst449gaQ0HzGPRrZatEQUwPslsxf6bPdqGcZZWiAXRz67ENy/k3bd5ooC6oA785YxQtg4SEfVw2AtTkL03Yjtzw5AHxcVYNdSIAFvT8kIJusfRNmi+E6jI6gfJva0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cca36gek; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so26017565e9.3
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 01:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774254759; x=1774859559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fr3pV3yyRiJVOwrQfx1saRdyigbk5kS5X76An04qniw=;
        b=cca36gekC8kcWOc1c3TpI2dT+mm3p6Asxh6IlGNrtAfkEs/Y7WZsQvBf0dV8X7RcNA
         fMdZ4233lusvKl3bW1aTBZMpO5KTO2sqrt62fcuVsyT2WhGTo9k5PcdT3JdsCyRy+9Aa
         vAuMTyofkeFrIQSkOjxQfTxNwxeFqSA7ZPPLCCZD+SeeWNRatevYXU61Hp2B3DLg0jkD
         82V6FbUR47paASV99V98TT0G4I3fIXOIGJRLhRt6TmN2FnKj23LJyDzrgGDStY4sS+3b
         YSI/TzNPTeqk6LB2dAGKxonhkTUdy/yiP5Eh+VHw9AVOYJ5o0M6CzMwHbwZbwwH7Vn/J
         lKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774254759; x=1774859559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fr3pV3yyRiJVOwrQfx1saRdyigbk5kS5X76An04qniw=;
        b=UxvytzVmTwD/neuu7aT4xNq2/jr5teolslsSqq4EYTWS3wj0joM8RLpr+gzHtgBjla
         z9WVRl5aJIqft1lkl+mFV83S+jLzkP5G5nvQHtbTORJXa9DJZrrwBYqjqneydiJtbHnn
         kzYa5BhVKufMGDFtlYYpxbsO0F49fPfpwa4CC5uCdGL7EY/KCvj+PrU9RuOkaS38+r60
         e9oxDOVtunVEK/1E7bjIYoittMu8cqAN12qZ+eypHqLe8opWUPKnwt8bslJFd99Y10wJ
         wm8vr6CW9h0KRy53m4pU2ly8uiliX3Af5ladzz+gLoaWfSpXE2yDVBjZWclRG+opHBLo
         mdCg==
X-Forwarded-Encrypted: i=1; AJvYcCWceqSYv4dj6K+cEUFKphbw2Dg9qbOEVG5Bxa3ByhJI/SL7EsedJpVJRex4udinBSAAxlu6LWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9VJ/Tv1zjBJKWxfywmx/PxmkGf1Af4hr72LWYJnVZez+0AokB
	hUlA3IEstb7C4pQAownVPXcpmQlax7mZH6Rp4idI3fDQx5IsoWRYNhQyqSwM1MpmKW8=
X-Gm-Gg: ATEYQzyErolXHgWhc+eD62p8S0XX4pGl7LzH+zatxEfgRcGCcFaBNqedWjO7TZzbAJb
	pRXrbBvySUK7meGnjqofgIPBQKI/q4vk6KC/+tIVQ5Fdfxj4Yp5nlY7EN7Vt+E2YKZAg1RZOUyY
	boXwuGnJRj31vlIIHX8sCT6++vNtkvgRFQnIq+IC06AZRa0MLhNpZNeAJJD8NPQOaI1y41QzmR+
	gzEDR7KozYSZGXUw5P9xb5TrSy92YUyQHmbZS31YRifZDFj6XMG1gsVwinh6Vu07nK8wfhqKH5L
	5uXIiUTrlbfErRQMlRdaBGrPv4/nu93FbkrhC8GVJFtFlCXc52wHac9DsazAaOFTMNRz5IHwJaf
	D76n5jKG+NmYeatb9qw2GyEn9BRGdPx7yEvUQCcboAb7zA5nZ6l9TxQPBIHgMLJmtJAznNczrxi
	pfZ5DTaRe4J2D7FzHCeq8CdvTC+u45
X-Received: by 2002:a05:600c:1e09:b0:485:4526:ee06 with SMTP id 5b1f17b1804b1-486fedfb677mr162420025e9.11.1774254759594;
        Mon, 23 Mar 2026 01:32:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe032a55sm515752485e9.7.2026.03.23.01.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:32:39 -0700 (PDT)
Date: Mon, 23 Mar 2026 11:32:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: fix division by zero in ps_to_hz()
Message-ID: <acD6pMfM9XjTXdhf@stanley.mountain>
References: <SYBPR01MB7881AFBFCE28CCF528B35D0CAF4BA@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB7881AFBFCE28CCF528B35D0CAF4BA@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,siliconmotion.com,linuxfoundation.org,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-227917-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F01892EE567
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 03:31:56PM +0800, Junrui Luo wrote:
> ps_to_hz() is called from hw_sm750_crtc_set_mode() without validating
> that pixclock is non-zero. A zero pixclock passed via FBIOPUT_VSCREENINFO
> causes a division by zero.
> 
> Fix by rejecting zero pixclock in lynxfb_ops_check_var(), consistent
> with other framebuffer drivers.
> 
> Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---

Seems reasonable.

There is no Closes tag.  Could we get some more information about how
this was found and tested?

regards,
dan carpenter


