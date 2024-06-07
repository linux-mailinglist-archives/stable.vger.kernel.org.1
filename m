Return-Path: <stable+bounces-49989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C06900AAA
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 18:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82861C218FC
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 16:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97B719AD62;
	Fri,  7 Jun 2024 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O6HnjGYK"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275C219AA65
	for <stable@vger.kernel.org>; Fri,  7 Jun 2024 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717778834; cv=none; b=P0DuJACA1Zh2B8KezCm/PSB3XN3G1oBrC2hV9N/LfUR3Pawrapa6jAskxIxoRW0Cb9PBX3p5wCBF6RMwdSzDCLueXjfpSfq1y0+hi1DawkwYx49P8FYUZw8dtRcoP9wN36G6bOwcLM27KhiTWBQk6iXTyyluCQS5YvYXeA6BoxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717778834; c=relaxed/simple;
	bh=yygfjpWf7c4mRu3wc8784otqW9r1u1MIqacYFxxAi/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfgTJukzb8pgpic52jfnexz03WCAE8sbl03cX1mPfcmtBzxH65QgnuGLzC5WIQaDuZiN4UJ8jca5EBT0/IK8wiJWTUknUiI+5Jj5BW0hD856s4c23Pm97OipNJflBw9Qs0WzLF8mLn5aV6ObdFIBL+P+7BaeMonYTPbCV0dMm44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O6HnjGYK; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52b8b638437so2666814e87.3
        for <stable@vger.kernel.org>; Fri, 07 Jun 2024 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717778831; x=1718383631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VEc27/+QDjvxPdxrPe9MQft414aDa0ng2g5tZw7JHxo=;
        b=O6HnjGYKklXmJwur7DN9WWBSz670aIuc6FXFT0vE1sCHQvHND3ZvYqaeIyexF/P2z7
         kxLJiyGFaj3XDyshOb4PDlLaNC6MTbUa2PymOPFHq/ECncaaDiA5kFRjW8kbbVPUWMUY
         iWGpBw9NERdvzsMvjrxgQyzQHgoWf4+7jV77zUR+arDzxxZRBBB2AgAnGc/9mEOm6iut
         nti2iCgu+IjqMLcMMC70PZn2OwMoIAGxCm5SccyoZYWSVKTnBPt15z5yzKkeROGuGSyL
         fxMyPy6GfikIF/rmECDfy1zK/vxF9aCeLbR6OjPk8vmXtcmKpCE0+AQWcm/Ojk63vzt2
         1dRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717778831; x=1718383631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEc27/+QDjvxPdxrPe9MQft414aDa0ng2g5tZw7JHxo=;
        b=Uh63YeK3uiI1qd1yNoU8i771UlbRGcDrvd8S/FWjRGWEjq4zR/9pB10XfjPKgT+2g4
         8VROPDAEwyMMU1iSsYQFbJXyZYZjaozilSlcd8uIrkUd6pgLnJdfzLCo4B8PZsFLIZzL
         s2eGMD4fhKkmwchJNCnVQAkC/RhRImKSNAp+tLLXmCsvxeKj77oZZpoqmKMZlZOiWlhv
         8pTPCHubCqC9M7pdypkEjiVFrnZgEKZFofOG5DLWwYun0qniZh75QwUpytI5MFDXJdPn
         l8B7/XhWiRup0KTLDerdseBStPyjaYFJ/4M8qEj1zyA6x2Oy6douX4VrjmHtosVeBHbV
         0+xA==
X-Forwarded-Encrypted: i=1; AJvYcCV8+omv91+ZNOFHZOqwZ5r1eDwpL3moRPqA0noCOgKXTcuTsvvTjELCX0pLq0HTObm0KGWCKMXODBOjMJlPrj7h+1DHj7jP
X-Gm-Message-State: AOJu0YzgaldED8TS7K+WaUGpnO25t6zfsBJgG3i3kGj8ra6kc9QZU2vX
	qWW43VmGwNxeyzOSVynCbrGPDPpgZFJKSDf5xp1OygGf8NXG5oWV6EerlgzyUZo=
X-Google-Smtp-Source: AGHT+IESCl691aQ/xAkEAiHxKXbz4d/ior2BLKSileBECqIsyor4crwcMeyTbLAuYXaItW8WP91YVA==
X-Received: by 2002:ac2:5e91:0:b0:52b:c294:f005 with SMTP id 2adb3069b0e04-52bc294f418mr764139e87.12.1717778831114;
        Fri, 07 Jun 2024 09:47:11 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm273700566b.18.2024.06.07.09.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:47:10 -0700 (PDT)
Date: Fri, 7 Jun 2024 19:47:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joy Chakraborty <joychakr@google.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	linux-kernel@vger.kernel.org, manugautam@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] nvmem: rmem: Fix return value of rmem_read()
Message-ID: <b4eddc66-9fe7-4f52-936a-7cfd8c2b424c@moroto.mountain>
References: <20240607160510.3968596-1-joychakr@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607160510.3968596-1-joychakr@google.com>

On Fri, Jun 07, 2024 at 04:05:10PM +0000, Joy Chakraborty wrote:
> reg_read() callback registered with nvmem core expects 0 on success and
> a negative value on error but rmem_read() returns the number of bytes
> read which is treated as an error at the nvmem core.
> 
> This does not break when rmem is accessed using sysfs via
> bin_attr_nvmem_read()/write() but causes an error when accessed from
> places like nvmem_access_with_keepouts(), etc.
> 
> Change to return 0 on success and error in case
> memory_read_from_buffer() returns an error or -EIO if bytes read do not
> match what was requested.
> 
> Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as nvmem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joy Chakraborty <joychakr@google.com>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

You mentioned some other functions that had similar bugs.  Could you
fix those as well.

regards,
dan carpenter


