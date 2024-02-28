Return-Path: <stable+bounces-25442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A275686B92E
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 21:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D161C263E4
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 20:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E1F74418;
	Wed, 28 Feb 2024 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z+RAqYC8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A63620DFF
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709152785; cv=none; b=BZhGhLgRUsbuqMqXV2LZFaI6QRm9jfNCNOX9HML5hR/CgEzp8IDxrgwuy/6HSCgJS9QmzNfv4DXWwwbduw3Sxr3+JaSO/gsH1HtDqHM53v9qj4zGKh8ZOwdtdLatg43PHJ1j1TIAJj6DJkApfe0Q+D47LCJ8YtAK+V51c/oWjqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709152785; c=relaxed/simple;
	bh=XGVStHb8y9qSUzs6dep3cN+bk9roRYQbeBfT9knwOIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXFPOs+gjOUqSook8+y2hA9k8vUM4OT1mV7OuBWMXpzLDfokbIumy8iawiACw/Fe81KzuNIvhldf9d84TTdiH/N4P2DUWbtnbMj/nT1fx0SLydnm83HvLkYNIenPotAg+tI9M3+EVoORERNUjCHOB6txlZnFC+EnI2CsBKeVKBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z+RAqYC8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-299a2456948so85255a91.1
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 12:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709152783; x=1709757583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SN804jzc01partIzI2Ah9KqFEvJhnq4W2RCgOUJ5uBM=;
        b=Z+RAqYC8bhY+Qxcw9SbQHP87crJA7xuaQFtcaNfTgLfz1rt4zEXSYFwnq/Jih+eUb0
         IjwlVjWTDjDGm2jXdmPvmKyy6PgqoK+GiAiRrxkRbGLF3A34FjlciQyR2qcCQiuHi5Cv
         uxBawJSMUjH58ZAmNbqVPjUdI/KkssKYTsJyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709152783; x=1709757583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SN804jzc01partIzI2Ah9KqFEvJhnq4W2RCgOUJ5uBM=;
        b=F1RD+zJBCrpeMrXmjk5BmbjBRsi7J0QFMPEg/dQVPTJnNTsrAKZDKuWZjJ57A43gnG
         5/wUMskRrLGFLLSTlx5D4DU8nmX6DwVUqZUeEh5K38T17BKvPFaJsLSGqEoZP8BBdV0N
         58T2Q6m7oRSXd/2Jku1w7XPgOI9M3PK4RMjWVJ52865QjkQyFxKVlHQ5iq072ALkGMl7
         eGD1dVbFts8+8+/4FzDLolMmyJBNqWjBzbONi8kqXToSBc1IFdLyan/jC4+JrYSuJscP
         jg6yvK6AFslI9DGatmG3PzdqYzkV08uKHdMUdEMqYT9pY/+ROytXcK7lZHr9wjfdktzV
         8KSA==
X-Forwarded-Encrypted: i=1; AJvYcCU0s8U9DOB4lkOYJ+VS8AvU/mqNGwBp40sPCbvn76PPUxcJaoFNTA4BIE8pA2Auiyw37WKJrqTU8zMBBXPuYmbGxL/LlRR1
X-Gm-Message-State: AOJu0YzZ/vS3wLR4cGOcbLsMyxzh3VYhyi1nzjaStYB9Y7z5GWL6Lexw
	NQKNrTADa26uUndbCSb4u9qxW+LsDgaOkV200748ivz1R0htBITfhPJqCNB4Hg==
X-Google-Smtp-Source: AGHT+IFLfWxA/Th4MZy8uxTVg4Aj3LQW9lYFKKfkZwp409nzeV0dHtSQ5wDsY3J6R2HhEBTSJ2b2OQ==
X-Received: by 2002:a17:90b:314e:b0:299:4a63:9e50 with SMTP id ip14-20020a17090b314e00b002994a639e50mr298019pjb.14.1709152783512;
        Wed, 28 Feb 2024 12:39:43 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090a4a8400b00299a0efa221sm29805pjh.35.2024.02.28.12.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 12:39:42 -0800 (PST)
Date: Wed, 28 Feb 2024 12:39:42 -0800
From: Kees Cook <keescook@chromium.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 000/122] 5.10.211-rc1 review
Message-ID: <202402281231.F7A20FCE@keescook>
References: <20240227131558.694096204@linuxfoundation.org>
 <Zd53aNc1aFrCYxFd@codewreck.org>
 <2024022804-askew-stung-cba8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022804-askew-stung-cba8@gregkh>

On Wed, Feb 28, 2024 at 07:06:38AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 28, 2024 at 08:59:36AM +0900, Dominique Martinet wrote:
> > Greg Kroah-Hartman wrote on Tue, Feb 27, 2024 at 02:26:01PM +0100:
> > > Kees Cook <keescook@chromium.org>
> > >     net: dev: Convert sa_data to flexible array in struct sockaddr
> > > (ca13c2b1e9e4b5d982c2f1e75f28b1586e5c0f7f in this tree,
> > > b5f0de6df6dce8d641ef58ef7012f3304dffb9a1 upstream)
> > 
> > This commit breaks build of some 3rd party wireless module we use here
> > (because sizeof(sa->sa_data) no longer works and needs to use
> > sa_data_min)

Just FYI, it's possible that things using sizeof(sa->sa_data) were buggy
to begin with since the struct size isn't actually dictated by that size
(it's only the minimum possible size).

> > With that said I guess it really is a dependency on the arp_req_get
> > overflow, so probably necessary evil, and I don't think we explicitly
> > pretend to preserve APIs for 3rd party modules so this is probably
> > fine... The new warnings that poped up (and were reported in other
> > messages) a probably worth checking though.
> 
> We NEVER preserve in-kernel APIs for any out-of-tree code as obviously,
> we have no idea what out-of-tree code is actually using, so it would be
> impossible to do so.
> 
> Also, it's odd that a driver is hit by this as no in-kernel driver was,
> so perhaps it's using the wrong api to start with :)

The reason is that most drivers don't want this size (see above) and
all the in-tree code that did need adjustment got adjusted (visible in
the referenced patch). :) But that's the risk of an out-of-tree driver:
it doesn't get those fixes automatically.

Out of curiosity, which drivers broke and what's needed to get them into
upstream (or at least staging)?

-Kees

-- 
Kees Cook

