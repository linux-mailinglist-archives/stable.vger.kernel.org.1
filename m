Return-Path: <stable+bounces-107852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2B9A0407D
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 14:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A74AA7A26CB
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 13:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEA11F12F3;
	Tue,  7 Jan 2025 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzKjXZdM"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C661F12E5;
	Tue,  7 Jan 2025 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736255441; cv=none; b=LooD+OLncWHkO7OwoE0OUety89IAqWxPQmSxJcfKloBe0eRhg0aUvmV41Bn/HEP8RMXEE5141ToGglHjBUJghy643HyZ3fXYDPOWqI24ZKoMGavKFi12i6mkrOK5FmDiz8WprmTEzbUjpiVvRbm+eabdUFyS+GQkKfkvvTVp6Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736255441; c=relaxed/simple;
	bh=ADthGajJ7+jWaB9VjhYsjhEH3MBHyp118HkFuCCVAs0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DST0rEWcaGZAefgxgTqqg5yA4F8u86vvAurXOvZWITGStcg6Y3UgvlwVaqK8uKENwo4+JYfpxoFmPKrsl66+cajDoqvHjPh8dieP96uepy/GOFh80NR+S9TcHoWfqd1IcLsbB1AAJeltu1d9FTKlnpdySXJakIj+SqLl7yASyqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzKjXZdM; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4678cd314b6so147812191cf.3;
        Tue, 07 Jan 2025 05:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736255437; x=1736860237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyZlC18SS7DOxCTGKSOqaGQPIN80T4lc/PP/O9Mt8pw=;
        b=ZzKjXZdMDn3NYApjE9/+BWEMkPsHqXTyOMr8NS9D5El5tiVYke8vlaCgxSrLcjzVHE
         FiyhLiVCoUoIV7Qgbj8Tcez2qwZ4LisF/TCiAtn4A5AYgpwnSiutGo8AfC8ldd6VB7nG
         Vz8GOwRyQlW9u/zYO9HaRDxSvIhwJSgw8wRgIvx6jYCLRU3Dx39W0tu4H6fc79tbqytK
         FXJhicxe51SNPCVXGV3P5EaV0vt3ILEwp71+doD+qcvS55Eka5fqA/73PM5lRG+cH23l
         R8OHClicumd1NQeW1ALUAMfHOqoA+Sl4kac71l+uNhcohHBQnAcwCXAJehc6AX9OAHlX
         t1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736255437; x=1736860237;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LyZlC18SS7DOxCTGKSOqaGQPIN80T4lc/PP/O9Mt8pw=;
        b=MR8A8tFBd8iG86OxHuRK6jAwxpjLfy6RTXl3FSJlR83NHLx5mjZt0e5yh8KHCATAV8
         MU2ZqPfs3BQCp6Kx4YanI8Sw9/BgP8AhZexS6l3LdFEYg7tbXZR5japqo7IX6vMYTLNc
         btsakxJAz+uTdoYCG9CvyOf6WBcTtdOvaMGvq1H5otYhohVbWL5oP0ngf89PB9hiK4zY
         FrgJKaJDXBVGDHwAICx2NmMEvvC3BnJc3r5xF2J8AtYpoHuyA26ofAjhewYCODIxJDBH
         ssXDi2tAOh1kTVH7tyOuD72Q/NKWHu5oQ2jJVUAksHReVYRQZmmGQq3s28K6paLobweD
         sfHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp0g+kX/y13u1of24RzyLbsGpp1u4iDZO+EaOzIhtdv6o2uyqasDpPA1XlN7gpfcNWhfEmw64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7E/8n51TMCFph4t5ShhplKNA9CrayTXtBlddLbHcHFP1hOCH
	cNJciTqKywu1bzl1QiRLAI5OmnyxSH2YZufQIzw5h5b7mTP/oAVj
X-Gm-Gg: ASbGncsrQCqjFh+I3CY/Ny6AzI6+V1LdqginFrrSwo53cDP+DPjJ21NfvXTHZ49c9e1
	yKIJVqkxJFvbLFBsgiYomMlLI+aZPKDk+e1VRkCtvYKlUsb8OILDiL+34UyUzmqJiwQxe9sCBJt
	AyXxJTyoLXKiqioqQ65hKSMN6Mz1t3UnheDlEt8Gs2ex7bMjtaCOc/G77Tkxb+ICsYz0mLXOXhD
	iZ5EjPA4nJLRw7iXiamdGd9DWmP5htBLr7BaAUxIEcyFf/lgfOm9NUdnO4s7xiY/m6PJMmm5uYk
	4STd/iOFvS/BBWPr1Lacyd1z6sfl
X-Google-Smtp-Source: AGHT+IEPyxAUWSUdJdMbMamDFe9RlQY5ctTqXp9Ht4VmNKlzKeTLFX43ShuxBih720QX6qsqu3TfPg==
X-Received: by 2002:ac8:7d52:0:b0:467:5ea8:83e7 with SMTP id d75a77b69052e-46a4a8add7emr768053081cf.9.1736255436838;
        Tue, 07 Jan 2025 05:10:36 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e64d9c1sm186324551cf.2.2025.01.07.05.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 05:10:36 -0800 (PST)
Date: Tue, 07 Jan 2025 08:10:36 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 Jakub Kicinski <kuba@kernel.org>, 
 stable@vger.kernel.org, 
 jdamato@fastly.com, 
 almasrymina@google.com, 
 amritha.nambiar@intel.com, 
 sridhar.samudrala@intel.com
Message-ID: <677d27cc5d9b_25382b294fd@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250106180137.1861472-1-kuba@kernel.org>
References: <20250106180137.1861472-1-kuba@kernel.org>
Subject: Re: [PATCH net] netdev: prevent accessing NAPI instances from another
 namespace
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> The NAPI IDs were not fully exposed to user space prior to the netlink
> API, so they were never namespaced. The netlink API must ensure that
> at the very least NAPI instance belongs to the same netns as the owner
> of the genl sock.
> 
> napi_by_id() can become static now, but it needs to move because of
> dev_get_by_napi_id().
> 
> Cc: stable@vger.kernel.org
> Fixes: 1287c1ae0fc2 ("netdev-genl: Support setting per-NAPI config values")
> Fixes: 27f91aaf49b3 ("netdev-genl: Add netlink framework functions for napi")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Splitting this into fix per-version is a bit tricky, because we need
> to replace the napi_by_id() helper with a better one. I'll send the
> stable versions manually.
> 
> CC: jdamato@fastly.com
> CC: almasrymina@google.com
> CC: amritha.nambiar@intel.com
> CC: sridhar.samudrala@intel.com
> ---
>  net/core/dev.c         | 43 +++++++++++++++++++++++++++++-------------
>  net/core/dev.h         |  3 ++-
>  net/core/netdev-genl.c |  6 ++----
>  3 files changed, 34 insertions(+), 18 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 7c63d97b13c1..e001df4cb486 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -753,6 +753,36 @@ int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
>  }
>  EXPORT_SYMBOL_GPL(dev_fill_forward_path);
>  
> +/* must be called under rcu_read_lock(), as we dont take a reference */
> +static struct napi_struct *napi_by_id(unsigned int napi_id)
> +{
> +	unsigned int hash = napi_id % HASH_SIZE(napi_hash);
> +	struct napi_struct *napi;
> +
> +	hlist_for_each_entry_rcu(napi, &napi_hash[hash], napi_hash_node)
> +		if (napi->napi_id == napi_id)
> +			return napi;
> +
> +	return NULL;
> +}
> +
> +/* must be called under rcu_read_lock(), as we dont take a reference */

Instead of function comments, invariant checks in code?

Like in dev_get_by_napi_id:

        WARN_ON_ONCE(!rcu_read_lock_held());

