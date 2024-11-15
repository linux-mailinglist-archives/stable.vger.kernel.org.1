Return-Path: <stable+bounces-93069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C8F9CD4FC
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 02:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80462B23531
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 01:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327BE44375;
	Fri, 15 Nov 2024 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G/AphG99"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803F92D7BF
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 01:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731633656; cv=none; b=pxjwDJKJVFEM/zJip5EW+7jHX2NocD9EycqtFgH9+8CU5AMcmHErqperSxmZNKHFbebnI+lpWe3LkqY1hDUJ23iieBHlDKi6e4HGxGl8vkF3S5j1Aa8Zp/fTtCqQXM+TfBjk7ZlW6REZDnulgiPn+4HX7Zz6fxJ1f/2p3I9bBsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731633656; c=relaxed/simple;
	bh=xFupdPanBMLI+ABKya55+UjriRVNgH8ZIVix4PbWMgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+Mr2pV0gq0qqXpWQ68QdVkDXcExmpbohtSNjWqk/y7BoBEeb9TI6DRD2wWM06euQTJWLauQFyLP+RJXWu4T33lsQF3MecPxVE7GokvAccvzZCTPeRAnW0T9RVgPxxW69oWjWDY8x3l2psQn8tSzV1YX/h+BiJXNtprvPS/xLAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G/AphG99; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71817c40110so667258a34.1
        for <stable@vger.kernel.org>; Thu, 14 Nov 2024 17:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731633653; x=1732238453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2O2T+qVNNUEKkj7Tqgh2CcsQdUVXnIL4zFWqjYgwwmY=;
        b=G/AphG993JqWh2gEevkwILgBJpsYaFQmwS+365XUSqVCfO5GIKnNs8y8Y2H20yymzz
         rlstd17WRXi1DC2C71SpTiHCKpi6Hw4skhGaQZeedCRNR0Ol11yeMwZ5AEdV8p2uxNAt
         ZVhjQXUvP3BOxJOzhbU9j/wN2AR/r1L6tUET8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731633653; x=1732238453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2O2T+qVNNUEKkj7Tqgh2CcsQdUVXnIL4zFWqjYgwwmY=;
        b=uaMASBzMRB67ftIqg1UfuAyxlBZMCuNVTvpgASjBWP0dfQJfIgf5dnDqwSx/5TwZMC
         IUd/81fDoGfZrBxhmhuxN+shlGY2gxeYdmSMh5DOWtXbpDlkLJ7bW37DbamAzEk1VSKF
         4QDb2W+foji4qUpL3l2Y3bmKdBeZMCvCxXTOQfQcn1bHUksN2vDcLRa4kv7OtQNIEvTr
         d/6+8MuMfhm2/jCxRZVsE8JNSn5s0wtzqqq5olvQUviersbM/YKyXGvIKdLJEmnMmJRK
         tug9WdXAqtlblNxq7OHvh+27Sw/CmyQmSPlnjpDHIJxLJ7VCXqLVok4CpxF7t9Dlk3aJ
         WA/g==
X-Forwarded-Encrypted: i=1; AJvYcCX1TmnvDmuOyWcNYhmVR0wRWCL6qCmu2h9O8Xj9OilQbfj/yNDTkWtp70SphADTHtu6cGGh/8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZpKUek2GDbZfhAUQ6GB8MR9SYK/KukjFraD7U1O2/E7akzqL1
	RWArWff2lf7ClXccIkScnp6e7upQAQDVW7y9CoDRE2r8jHRBxkqnlwvCIcMLKA==
X-Google-Smtp-Source: AGHT+IGirkxddJ67bwjyV5yqtTRTNRwP6Jl33D77JprOQQfPM28upKVhV1Mcl5w+rVeXg7rv+U3Xew==
X-Received: by 2002:a05:6830:4708:b0:718:83f7:9df4 with SMTP id 46e09a7af769-71a779e3720mr1017143a34.23.1731633653545;
        Thu, 14 Nov 2024 17:20:53 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:f2ec:a79f:1362:3ac3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1ddbca3sm258701a12.84.2024.11.14.17.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 17:20:53 -0800 (PST)
Date: Fri, 15 Nov 2024 10:20:48 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 5.15] udf: Allocate name buffer in directory iterator on
 heap
Message-ID: <20241115012048.GK1458936@google.com>
References: <20241113043050.1975303-1-senozhatsky@chromium.org>
 <ZzZB9-DX7IWbfSXs@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzZB9-DX7IWbfSXs@sashalap>

On (24/11/14 13:31), Sasha Levin wrote:
> On Wed, Nov 13, 2024 at 01:30:35PM +0900, Sergey Senozhatsky wrote:
> > From: Jan Kara <jack@suse.cz>
> > 
> > [ Upstream commit 0aba4860b0d0216a1a300484ff536171894d49d8 ]
> > 
> > Currently we allocate name buffer in directory iterators (struct
> > udf_fileident_iter) on stack. These structures are relatively large
> > (some 360 bytes on 64-bit architectures). For udf_rename() which needs
> > to keep three of these structures in parallel the stack usage becomes
> > rather heavy - 1536 bytes in total. Allocate the name buffer in the
> > iterator from heap to avoid excessive stack usage.
> > 
> > Link: https://lore.kernel.org/all/202212200558.lK9x1KW0-lkp@intel.com
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Your S-O-B is missing, but also it doesn't build:

OK, didn't know that I need to add my SoB.

> fs/udf/directory.c: In function 'udf_fiiter_init':
> fs/udf/directory.c:251:25: error: implicit declaration of function 'kmalloc'; did you mean 'kvmalloc'? [-Werror=implicit-function-declaration]
>   251 |         iter->namebuf = kmalloc(UDF_NAME_LEN_CS0, GFP_KERNEL);
>       |                         ^~~~~~~
>       |                         kvmalloc
> fs/udf/directory.c:251:23: warning: assignment to 'uint8_t *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
>   251 |         iter->namebuf = kmalloc(UDF_NAME_LEN_CS0, GFP_KERNEL);
>       |                       ^
> fs/udf/directory.c: In function 'udf_fiiter_release':
> fs/udf/directory.c:315:9: error: implicit declaration of function 'kfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
>   315 |         kfree(iter->namebuf);
>       |         ^~~~~
>       |         kvfree

Hmm.  Upstream fs/udf/directory.c doesn't include slab.h and 5.15
with this patch applied "builds on my computer".  So I can amend
Jan's patch to include slab.h, I guess?  Is that okay?

