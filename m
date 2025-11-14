Return-Path: <stable+bounces-194794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B07C5D6EC
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 14:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79D6A35C866
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE7A31A7EA;
	Fri, 14 Nov 2025 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G7ErAIfA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B7E221F0A
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763127771; cv=none; b=KiMuHyL4hVtnoyJwEjjPvuLOHOLwFCkNt6bh9FWtjkdy4j3G2KQhnFWO23iD3gDAAYeIJbsnKkwVRmHv7ZNm7HhvhI4rouZQf2+ShujKfB37XHPsOTtqaaalHszLm0Vp6eTV5Gqoxjm/EjEngD9ur1AjlvoCrTfdGA1N23I34jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763127771; c=relaxed/simple;
	bh=X3mcG2vMwzimtVf21V3jtBMPOXzPKbZyCnkRy7OCEdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLwOqm2/F1AxYa3STxu1BAAOaMeVh3vYzhQvOPlI1wrpCF+1v3qyB+CHEI4tX5BEmhA6LRoXI00DIS44pWqnr65zb9+PI23pERd+tZWx/TXhDjfNGSYDxXR8+8lCb7kY5n1iRC55upmh8jnb+Of9dh0zwP+ADscGrco+4eItQOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G7ErAIfA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b735ce67d1dso204588666b.3
        for <stable@vger.kernel.org>; Fri, 14 Nov 2025 05:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763127766; x=1763732566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HuAu7Wso0jBRWrpiRglWcgUTTHMBIgLYwTxF+99E0AU=;
        b=G7ErAIfAgK0Isgkh9l3alG0R4GJaVNg0maoYtY9Z8F5fvpM5r12hNcvRVs5E3oktDV
         lyp9ilmMqwXA36zhP0JKF8Bd6eW4k1/WiiDbB7jNwRX5aat0l5B9+ngdw8B52j2QHjwO
         Dxc6Sy+64UIj6SOA3T/4/iWw8N1oeQBXdcD4CYsOtUYqObgaVAlt8ysLgc0yWk03NCuC
         FAJHPH+0rJG1M7GGIT02AxGCPsOmLImSJ4nGFa3zn/AIx0Pm+67YPtquhgMP4rBMbVhe
         +FX2CDawqLVPyFGzWX9d1mttUIawYW8O7hshyAqdme3+ctR/8BBsc9q/eszgq+Wtk4Pr
         41vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763127766; x=1763732566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HuAu7Wso0jBRWrpiRglWcgUTTHMBIgLYwTxF+99E0AU=;
        b=flbrcSO+LcjXaQ0ZD8FyRw3iXFZrHRKMDjvGPR5mzLfZzHWSJTTkOW+o81R8/FSR2m
         m28a5O2MbeJbVTdJmm7UJ4R1kkCU3WhXfBNBALAONbj8t+VQgzbD3evNuJWRxtqUCwO+
         ahKAm5/1CgOWCXP2VxhAuJMoLFQX/1o6WzvhSHthW8V1DWdx0AUNtZ87mIKgKMhFxDtJ
         qgILjGW+vBzCHKvkA7m7pYtLiKOXmh6ckn1btpS5qA2gEVFrYzPiXWVfA3x8t/YeqGZw
         1YjEEJdOX378XUV/Qa0CcPZDqC6XU9A8unZHkN99tnY8yYMsynnKMaONbDUqLak0owl0
         46mg==
X-Forwarded-Encrypted: i=1; AJvYcCV5DjH9Q4Vh5ZJ1J9UEmDNB/PZ1c2oItx7FvDQUDVdPVSw83ZnOCIdwe5ltVpTaBB8HDcstA0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXhMwSSvRLl+jgOANYoAe1Pod7MOCiJy2MLjOsk+fX4eHsV6yq
	7czRIsiEb4EMV6WMgGADMzuWx/dF881MTl59GbEwrYHyMLDN6Es2slHWI9PCArS1DVw=
X-Gm-Gg: ASbGnctLU047AAeilstYojJBQOjNSm4pCWUnVe93Dhf2f8rXkSsae8K1ISwSah7gAQJ
	NegyK9j1fa0deGUwzyWk06ngDTxXl8pt6Af2MmKfXCOtiW9MYJhBRxaDCLcDO6EwE0PKewWoaXp
	eVp1hp+pEL8okJcJRlcAZWAXnr1B6mszGAYxCD2F1zTbLfvSTF9bLhJKlKB7EFd+vRElAEhhkzf
	jH+IOvtzku7/zFEXErbCXUOy8aldoyAXFhZQ9JghVO5zlfYIiRTaCuC5PSptnrnqkvow+XMiHQ7
	aRx8odt3rUP0SZXYq0ifc1urXfNBx6zm/OnXWpwEqDDnXb5g1KnFQ+M1R5F23F4UsDOF9ylVyyM
	Mz2G7RhG6ByDiZ4CjTRsDAulmriCc6eDVwTXzPnsXXrTq4m7zjichJiexdwcrVWdM0LibyQjNEu
	VatU4=
X-Google-Smtp-Source: AGHT+IH52iI5y4jXnMGTK2DYK4Ukz3c2m/wINIYF9V1Z4HGtLQlOTyNuyhHDzpzkKA9UKrLWBFbCyg==
X-Received: by 2002:a17:907:787:b0:b73:5f48:6159 with SMTP id a640c23a62f3a-b73678088e2mr294471266b.5.1763127766444;
        Fri, 14 Nov 2025 05:42:46 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fa80cb6sm397095166b.7.2025.11.14.05.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 05:42:46 -0800 (PST)
Date: Fri, 14 Nov 2025 14:42:44 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sherry Sun <sherry.sun@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Derek Barbosa <debarbos@redhat.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH printk v2 1/2] printk: Allow printk_trigger_flush() to
 flush all types
Message-ID: <aRcx1OQ07nEB1Yp8@pathway.suse.cz>
References: <20251113160351.113031-1-john.ogness@linutronix.de>
 <20251113160351.113031-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113160351.113031-2-john.ogness@linutronix.de>

On Thu 2025-11-13 17:09:47, John Ogness wrote:
> Currently printk_trigger_flush() only triggers legacy offloaded
> flushing, even if that may not be the appropriate method to flush
> for currently registered consoles. (The function predates the
> NBCON consoles.)
> 
> Since commit 6690d6b52726 ("printk: Add helper for flush type
> logic") there is printk_get_console_flush_type(), which also
> considers NBCON consoles and reports all the methods of flushing
> appropriate based on the system state and consoles available.
> 
> Update printk_trigger_flush() to use
> printk_get_console_flush_type() to appropriately flush registered
> consoles.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

