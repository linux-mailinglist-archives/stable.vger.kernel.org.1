Return-Path: <stable+bounces-194518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B889AC4F68A
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 19:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3092A3A6CB6
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 18:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39A626D4C7;
	Tue, 11 Nov 2025 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="TulYEGSm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B3E265CA6
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762885224; cv=none; b=Z0fJrgHspBf04cG02zE5QXJhXjZjE3LYNpkc23QjQlrng0pAApTEgP8IMS9fZLQBCYGkWH3tED9LQh2rQxSzQ6jIoz7da0eDB6u2VocZff7Qu1HTvrDEwHFV6L4FtS//Pysm1m7Nijl1Mh1FMUbN6SKIh0oUYN+67HEfHjmE3bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762885224; c=relaxed/simple;
	bh=n95I+wM9yjtOPWAMaBFaxz6m9Ftg/IKT0PcTyfUSGlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1uE2no9vFUwLPGKyAmPNkxogoaOiWDH6elBNB2uUHRgLo3UEV3B5OKHSJYwYseCNWk9HJljff6Zkeo8hrIMkzKdoOLKoelwzlBH8YEGY0J5bsCgdr4Ot/t2AmYC9sP/BQTqY1cv/9UN9dz37fOQ8sndrb6GwloF/F3me+G5m4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=TulYEGSm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297e239baecso11208845ad.1
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 10:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1762885222; x=1763490022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xH7fLeRJDduUwW8OBykePNE1qy/cPCbf7jTb60w/cyc=;
        b=TulYEGSmoX5B/lHWrQEHLk/lwUTQ77E7MwMKuvWo1GLFofbLvQLryotrhe3E162PYr
         SGpCD1kKLWQhmEyWLcWOyMC144uZbCp7duffyw3ovthXHHSAvXFppGK5ajXrBbv/8YLd
         ZE61CV2geqC9YfPPJ1mhjigGdRhOHjIR3mPf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762885222; x=1763490022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xH7fLeRJDduUwW8OBykePNE1qy/cPCbf7jTb60w/cyc=;
        b=F5cGMYA8Ptfd+9sV0QDtx+qXIkx4uN6JDF/StLNM3os8FT62DwpUZB4xodJT3X8dsW
         9hD090TnkXgn316HyMGeaJBgnADUVK8JXx9l3asI613R0JqnuTafHZ9xCqY3C5L8CYK2
         kiq1s/48FkDpAGGbioL/V2yligVn8kVBw8SD7Pdfux/EQKN7IHwCTYCOOHZHPnICgzfQ
         qgpzY5k5cmfxv1sb+YmUncVmASNICVOba6M9fJlo2DQLVc7Gu6bfpo9IzHuHj2lq60UR
         xbiMaIDSoSKgK5obHT7hsEEU4FGOvk8Iq4POc04IY6updarVXNNWazcqp57O80+/OAnk
         CB5w==
X-Gm-Message-State: AOJu0YxDgLWnlLLohK4UyAUmqixYiK7uQC2oOJWqwPrCyoYUJ6BqX9tf
	1d8zxhGyIMIU9N3HxAW6w26PijvIq1Q03zr0m/Z+AkXwTgy81JkWzC1PDtp9wGykHQ==
X-Gm-Gg: ASbGncu5ZXj0PR4vrt73GDTPhKx1BnYIxDx+cMSOsLlAGecTYPh9xHGFyyutpoM89U7
	aLkaKulwPtgrF/oYvNgkSMZepUrQsN9Vg/ywhEE5LCXZX2N5w6Qj+VjVcU9L1X39IZVl/NR3zZ2
	SsIq26xGpltaCb0EbuHN4n2Js6GiT8CGvW7AJCtviOLsj4ErazteGgBkpI/cnVxoFA1dpRjFD/e
	wgXZE3dZ0lV+U79eZxvxP2zlMsrHOJR3CbpvvlG+JrbhAQyERJ3VtoOUCGiKvqwgsKgFqRSuq3G
	sSQQgZBcKmy7ipleh6VOB/ZHNjDxnCDk6pYXythjiiat/+kAJwlc5mENKFX0v2923g416Y+Jl3A
	eQpcoq501vF1k9BBVOUpfCweWMyAJyiU7rcUkH1EHe1ktX637m0fgc9UbIhUz6uKyiTDJvReQ7S
	GrLIHtnqqEC8moYf123lgcMw==
X-Google-Smtp-Source: AGHT+IFISfayPR8Fe6WwyNlqhp69sJHz84+HZ2Bp8C2NA+i+9BczyVM/K1Yo6kiGYGLWOtzHIehM7g==
X-Received: by 2002:a17:903:18d:b0:297:df99:6bd4 with SMTP id d9443c01a7336-29840842cb3mr52741695ad.18.1762885222074;
        Tue, 11 Nov 2025 10:20:22 -0800 (PST)
Received: from fedora64.linuxtx.org ([216.147.123.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dceb2efsm3747495ad.110.2025.11.11.10.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 10:20:21 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 11 Nov 2025 11:20:19 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Yuan Chen <chenyuan@kylinos.cn>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.17 145/849] bpftool: Add CET-aware symbol matching for
 x86_64 architectures
Message-ID: <aRN-Y5tjf6v5AtSf@fedora64.linuxtx.org>
References: <20251111004536.460310036@linuxfoundation.org>
 <20251111004539.911440769@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111004539.911440769@linuxfoundation.org>

On Tue, Nov 11, 2025 at 09:35:15AM +0900, Greg Kroah-Hartman wrote:
> 6.17-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> [ Upstream commit 6417ca85305ecaffef13cf9063ac35da8fba8500 ]
> 
> Adjust symbol matching logic to account for Control-flow Enforcement
> Technology (CET) on x86_64 systems. CET prefixes functions with
> a 4-byte 'endbr' instruction, shifting the actual hook entry point to
> symbol + 4.
> 
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Quentin Monnet <qmo@kernel.org>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Link: https://lore.kernel.org/bpf/20250829061107.23905-3-chenyuan_fl@163.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I am guessing this is missing the other patch that went with this
upstream 70f32a10ad423fd19e22e71d05d0968e61316278. Without it, this
patch breaks the build.

Justin

