Return-Path: <stable+bounces-176761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94F5B3D47F
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 18:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5816163532
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 16:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5301E520C;
	Sun, 31 Aug 2025 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIgCjUVm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E38EEDE
	for <stable@vger.kernel.org>; Sun, 31 Aug 2025 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756659139; cv=none; b=RLB/2klNirrggypo0ufCxJtWdtSlQp7tTPsOqtoIb38MQh+qFH0lr9Buthma4cUWI7VG4+zGHndJNB6YES+WbY4mp0ujChqqqW6k67mR1Es3wX2g3TFsqUMkhaVCChIP0EJKg3LMglnH+YYPv+uFef9F4ropMt1AXdIBf+axOZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756659139; c=relaxed/simple;
	bh=hVSF5GCY7baUcWAUtuUC9vi9KJDhH75Sh4Qo8VCd340=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnwTt23P+ccxYdxqAI+sCaAFBUhythkoLazqmeqT7wJpWExbunNjkYy16xOB27tObFpA5H+FhZb29jHN3fGon9eXRQcnCh5EqpCkA5hf4iywB0R2tiS+KmSKcf7srQ8AxIOuxqaptuNt1QJ0rkREelYuo9gKvpFeqIOQaMM2yLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CIgCjUVm; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0411b83aafso130986966b.1
        for <stable@vger.kernel.org>; Sun, 31 Aug 2025 09:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756659136; x=1757263936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xVRAiqDOKLqVp+buslyfxt4z88i9IW6+14Og48x7tGw=;
        b=CIgCjUVmHF81ZRV/KCPzOCmd/NEqe6uU9MYNSSssdiNSI+LAq2OijJQ76XigmPuwOY
         bnlFXyoP6fz7lWtmjAi9IoM7RJlQYOFlKs4a/vWgOVIQJ8mQ5KKk108ExWoLkh4ju8Ip
         p/F8rGNC6gqQBnYvnQ8JPo4dSrF2cOnARN+ZKnmBre/Dm4k6Smu0Cyt1I/4FSqKynw+S
         x0/Z6ttxIt2Jkp13YyaJlfkLB//vj5a3xUxCc1jSSJgHT9WIsm/07kxEZGZAzt+pC7Sk
         vNvTDye/ReGQgYKqkmUAWcpUF7bVMMRyBZT+M+XjZkRvAbY6W/XF7cfHUI+S+KmBkwtc
         V6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756659136; x=1757263936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVRAiqDOKLqVp+buslyfxt4z88i9IW6+14Og48x7tGw=;
        b=BiezoyjFmS+DakkMgBqYWYBVqi3d2DjQmW+6WKiCor3AeThyXiJw9VLTtwY6TvSrMt
         HL5D5R5cW8IjzIXqEFVsf9wSx80R0Y7U8oTBLJ77OGqaJ4SWTj+1cgJT7ttfODbuKKmj
         /xBb9qIKNJHIFLFvVmPJey7e/hTu5FEgVoXbZ+8XUpaPH4nZVRCD0wwZ1GVVCarcE8gS
         ikhiS4VM3tEe5qQ+DN/ivpFxoFBJl/C9ZNYHEkLMfgTHv9iRNBFNmUOZha3PhAj2MmdP
         aD5YkAH+I3WkT8iUNrmWWlGmxOS6i/CQjGf7yqZffzEpxRoY4ST9m3rgwA2PbuTOcILv
         6pUg==
X-Gm-Message-State: AOJu0YwPZXv72RWOBO3bo2JxtY8CTGYjrUufgD0WI9L13YJ862V3i6Kf
	MwTBE75b+wJtkcsCZ8z791TK1nmHLmIHg6U4SVRH1YHh6aBg7X5PHpH7t8rKca8ZBOU=
X-Gm-Gg: ASbGncs0yl/1vBLaOwStYv6crQglLsD9qHLcE0maqzFrHlh1cuvUez7B6g9RapbYanE
	U1RR+BPkd+YdoV4IC2IHhtZvs4cCSfRS4+UHK7S79/8Ci6tY7ZPmYH3ubZC/KAYF0t4QLvJ1t2m
	VCc2EiyTq1gGSpYYs6KPSQI+vegNNkYNtXisECYNKuB+aWDTXFfyI8tSnUu8USRPr4DL/K43sjn
	s4gODOW5gdsm4B+g6tfL8OFSVKfBCk0dbV4lZczlcSPbEgui5pRK1k7QGrGlr3dWxbTn0p50xLW
	vsifHkWCTuSxcwkL/+YNl5v1UXtLbDRaIHlqT4JoJHI4vdZpf/v69Tk9jeuog3hbDesWs/LIYGI
	n1+HJ8N1NapJ1n3n1+BqbYxZb845lMvQJxVNycJrh
X-Google-Smtp-Source: AGHT+IEvnfJujsi5cFXshPDKJ17p+0VdURuecWHuMZzw11hzdDhPHuf8F3r8bz38kGFw/bXwl8ZBIA==
X-Received: by 2002:a17:906:3757:b0:b04:1249:2b24 with SMTP id a640c23a62f3a-b04124939a7mr274932766b.37.1756659136055;
        Sun, 31 Aug 2025 09:52:16 -0700 (PDT)
Received: from linaro.org ([77.22.248.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff16b57124sm475098266b.28.2025.08.31.09.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 09:52:15 -0700 (PDT)
Date: Sun, 31 Aug 2025 18:52:09 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Clark <rob.clark@oss.qualcomm.com>
Subject: Re: [PATCH 6.16 278/457] soc: qcom: mdt_loader: Fix error return
 values in mdt_header_valid()
Message-ID: <aLR9uVafCI6Xd8aC@linaro.org>
References: <20250826110937.289866482@linuxfoundation.org>
 <20250826110944.250667129@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826110944.250667129@linuxfoundation.org>

Hi Greg,

On Tue, Aug 26, 2025 at 01:09:22PM +0200, Greg Kroah-Hartman wrote:
> 6.16-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Dan Carpenter <dan.carpenter@linaro.org>
> 
> commit 9f35ab0e53ccbea57bb9cbad8065e0406d516195 upstream.
> 
> This function is supposed to return true for valid headers and false for
> invalid.  In a couple places it returns -EINVAL instead which means the
> invalid headers are counted as true.  Change it to return false.
> 
> Fixes: 9f9967fed9d0 ("soc: qcom: mdt_loader: Ensure we don't read past the ELF header")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Link: https://lore.kernel.org/r/db57c01c-bdcc-4a0f-95db-b0f2784ea91f@sabinyo.mountain
> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This patch breaks firmware loading on most Qualcomm platforms, see e.g.
the replies from Val and Neil on the original patch [1, 2].

There is a fix pending, which should soon land in mainline:
https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=qcom-drivers-fixes-for-6.17&id=25daf9af0ac1bf12490b723b5efaf8dcc85980bc

For the next 5.4-6.16 stable releases, could you pick up either the fix
or revert this patch together with commit "soc: qcom: mdt_loader: Ensure
we dont read past the ELF header"?

The problematic commit ("soc: qcom: mdt_loader: Fix error return values
in mdt_header_valid()") wasn't backported directly to 5.4-6.1, but a
quick look suggests that Sasha squashed the problematic change in the
manual backports of "soc: qcom: mdt_loader: Ensure we dont read past the
ELF header" (at least for 5.4-5.15). I think we will need the fix for
all trees (5.4-6.16), or we should revert the patch(es) to avoid the
regression.

Thanks,
Stephan

[1]: https://lore.kernel.org/linux-arm-msm/ece307c3-7d65-440f-babd-88cf9705b908@packett.cool/
[2]: https://lore.kernel.org/linux-arm-msm/aec9cd03-6fc2-4dc8-b937-8b7cf7bf4128@linaro.org/

