Return-Path: <stable+bounces-108186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40F8A08F13
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 12:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0E61676B7
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C252F20ADF6;
	Fri, 10 Jan 2025 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="wu/Ok8Py"
X-Original-To: stable@vger.kernel.org
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFA1209F5E
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508221; cv=none; b=S5HENexIK8WQXZ3vTxwV1djN5juWJW98eIP9qqqxn3OBce3lJGRTjVfOAGC5ElatixZxxum/eh9dDkMr0yST8zRROQ1qW1wNluTQcA7EjG3yo2DS1t3OJQeFTKWskyLaI8cEdUw5YUqDYCv9tn4S4ntm6kANwZp1pZD9pri1Qhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508221; c=relaxed/simple;
	bh=8suFlJSdwhlzeurLYV6vZmvLV/Zmm60PB5eRDqAliBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGYQ+rZ0a+S3LE8T2WSrbW/sGa8Cu09bhXtN+DR8g/2VL01/FqGBQ3GBTdSWHGrYVO0GM7tEUOkj5Q32yRDH0b2CTyR9gx4QC/GajsCEOrifkURrIiYPXvT/pPdWGkMpG/4rP1Ma4gPcUKO+LVPtO1MUej3WXNiucn+jQZWQ5YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=wu/Ok8Py; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YTzmd06VMz2QW;
	Fri, 10 Jan 2025 12:23:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736508208;
	bh=AkGUvhzMrBSFXYXKtQDMeL/d61+J59HOBg+e9MRRLQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wu/Ok8Pykffa+a7aBUkIMcEIF36ndP3gH7o4II4f5WFgCAxNH7Wsicn/9cTdHgurl
	 34k4/WRQ/fmpvNIO8pc2F66U+o46bqU9qsYjkNwDHx7R5g+dA5+RCqHcAeDUE28OHy
	 7KffLNL7vcxdYsQjj6ejAFdK0SVb5tQ+9im5w8VM=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YTzmc39lTzb6d;
	Fri, 10 Jan 2025 12:23:28 +0100 (CET)
Date: Fri, 10 Jan 2025 12:23:27 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Gax-c <zichenxie0106@gmail.com>
Cc: gnoack@google.com, jamorris@linux.microsoft.com, jannh@google.com, 
	kees@kernel.org, linux-security-module@vger.kernel.org, chenyuan0y@gmail.com, 
	zzjas98@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] samples/landlock: Fix possible NULL dereference in
 parse_path()
Message-ID: <20250110.ieMie0Choc0m@digikod.net>
References: <20241128032955.11711-1-zichenxie0106@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128032955.11711-1-zichenxie0106@gmail.com>
X-Infomaniak-Routing: alpha

Thanks! I've simplified a bit your patch and pushed it to my next tree.

On Wed, Nov 27, 2024 at 09:29:56PM -0600, Gax-c wrote:
> From: Zichen Xie <zichenxie0106@gmail.com>
> 
> malloc() may return NULL, leading to NULL dereference.
> Add a NULL check.
> 
> Fixes: ba84b0bf5a16 ("samples/landlock: Add a sandbox manager example")
> Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
> Cc: stable@vger.kernel.org
> ---
> v2: Modify logic & Add Fixes tag.
> ---
>  samples/landlock/sandboxer.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index 57565dfd74a2..ef2a34173d84 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -91,6 +91,9 @@ static int parse_path(char *env_path, const char ***const path_list)
>  		}
>  	}
>  	*path_list = malloc(num_paths * sizeof(**path_list));
> +	if (*path_list == NULL)
> +		return -1;
> +
>  	for (i = 0; i < num_paths; i++)
>  		(*path_list)[i] = strsep(&env_path, ENV_DELIMITER);
>  
> @@ -127,6 +130,11 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
>  	env_path_name = strdup(env_path_name);
>  	unsetenv(env_var);
>  	num_paths = parse_path(env_path_name, &path_list);
> +	if (num_paths == -1) {
> +		fprintf(stderr, "Failed to allocate memory\n");
> +		ret = 1;
> +		goto out_free_name;
> +	}
>  	if (num_paths == 1 && path_list[0][0] == '\0') {
>  		/*
>  		 * Allows to not use all possible restrictions (e.g. use
> -- 
> 2.34.1
> 
> 

