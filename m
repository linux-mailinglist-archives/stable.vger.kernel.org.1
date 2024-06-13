Return-Path: <stable+bounces-50489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07399069B2
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6047BB23BB7
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE79141981;
	Thu, 13 Jun 2024 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+jejdCP"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0101411E5
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718273440; cv=none; b=JdCSqYMu2XxsC/hIhNlnRguiOndWxz90WFf/cmz6eT7RbyD7qtg7gnDR5y8vW+RcOKROfU52Vk98A1Tz7aAXp/dsLwiPvjZ1r9AKFvJMq2jXqapJo0jqddEz0Hi68U5xug4rpIp7mKPyNUCl4VAl38drht0DuGqsJJn9w8ZtuLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718273440; c=relaxed/simple;
	bh=mOMZE1BImQgQqVos0pSrYVwUrtiIOEk/BT5krayXtjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIA1hJSECG+9ASMFr2EhtzLiIKgON9PHoGA7AqoeBOnbFQtwCuixb+Sc12r1ffXTRGLAkkgtz1GAXJ1nhs9zHKLbTHn8scxdnRWgnh5t9FUaszY6rJfdkxfshD9LzAFqJ6c5UPszQkU7eJxc/yyp4E9iGm9YeO9Gid/s+vpN14c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S+jejdCP; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52c89d6b4adso830679e87.3
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 03:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718273437; x=1718878237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VnOXzfBQPF+LHXjU6pXBEMJF3WvZiisnuKFTk0ZYuAo=;
        b=S+jejdCPSgiDz1ZDqAOPS79cij4ikRaQJnFPWZjdD6wTKuVVopRz3lllO8SKqrvFSw
         C90yFR52ZUGIC0jUbbhnFrMnlGlJw2Rb7NxesuEnfpSPlotY+yvJbQkmKJLZBR6MxRiE
         rROuYy8ZlhB4EEa7viqg/m7j/qZ5OjoTPN6qMxxzgCfv6PNH4qg6xNGwyfKbValyW/LL
         KQ6omeOHDMuupUUycGOIoea0n/vhIJIND5ooye/jIqWVIy8A/3WbkuPnVyHoG/3WXX5l
         gFnbiNT9GeExEqiCHSl77azExi6zvAVccfQfR/TbFMaq5WWCzZgevXbU5Ev5FhxqKuOM
         Biiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718273437; x=1718878237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnOXzfBQPF+LHXjU6pXBEMJF3WvZiisnuKFTk0ZYuAo=;
        b=Vev3DGAExN/qxtGBf9TBtUzfmquOo1mqQNKU282+3YiPEjkNIcIeGmKSD4iYaKXHmX
         cMr7+QvRnJTyYYw1hgabH2n4SRbfKR5tCOCcGO+VDEPuakuzV/xAWP+FdVqpfyjwaX3/
         DvSR6yq3pL2D9LM+0nczAug2bDoVNO7MuE8PeC9iQgp888rrTIGGoTQJSSRlQRB46XFR
         8xJ0Kwc1Ugxg90Bp6AzfYPJfEmR0oqlpE3OO4hijN4aWsUqBz7QzxF5ax3ZOyLIYrTHC
         l0oUSPkBKM5xLsDxbXuOa1lhBZiOsZeEia01ir6wE193gZqvefeV11XqxkEfVx2ejzuI
         qWIA==
X-Forwarded-Encrypted: i=1; AJvYcCVfC5U3oZhW/qkeZjvuQJQK+bP07vQu/BQjoYC0rd5rm24/ID5fMlyWZZLXFbSqMn3Qj0HRqxSLym2Q+HK5JgN5HTmRCPe3
X-Gm-Message-State: AOJu0Ywu6e5csAEO/lAONUNK1WuN0t0eDkiN6X95codmT4aG+f7/sdVU
	Fi/hCAVyCGnePq4aEVJlGDNUwo8f1c5Sk47uYYNx9N+etmJWk2LmrU4synffBxc=
X-Google-Smtp-Source: AGHT+IEnmrWgnM5SGxICW1vWwc2O/mTW96VNMeI3/JiExHdDPaxx2NlTGNeh1bZrVaDWkM08FDbyLQ==
X-Received: by 2002:a05:6512:44a:b0:52c:8a4e:f4bf with SMTP id 2adb3069b0e04-52c9a400d27mr2332640e87.51.1718273437098;
        Thu, 13 Jun 2024 03:10:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287ad17sm146604e87.225.2024.06.13.03.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 03:10:36 -0700 (PDT)
Date: Thu, 13 Jun 2024 13:10:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e80100-crd: fix DAI used for
 headset recording
Message-ID: <7rfoogp7w3gmtyawmil5lilx4blbpnb3nzl5tv2onydmzblcqw@qooqesspnrp4>
References: <20240611142555.994675-1-krzysztof.kozlowski@linaro.org>
 <20240611142555.994675-2-krzysztof.kozlowski@linaro.org>
 <90f5ad41-7192-4c01-90c0-ad9c54094917@linaro.org>
 <9e9cbc0b-f9fd-439c-93d1-054179f7b07f@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e9cbc0b-f9fd-439c-93d1-054179f7b07f@linaro.org>

On Thu, Jun 13, 2024 at 11:11:05AM +0200, Krzysztof Kozlowski wrote:
> On 13/06/2024 09:45, Konrad Dybcio wrote:
> > 
> > 
> > On 6/11/24 16:25, Krzysztof Kozlowski wrote:
> >> The SWR2 Soundwire instance has 1 output and 4 input ports, so for the
> >> headset recording (via the WCD9385 codec and the TX macro codec) we want
> >> to use the next DAI, not the first one (see qcom,dout-ports and
> >> qcom,din-ports for soundwire@6d30000 node).
> >>
> >> Original code was copied from other devices like SM8450 and SM8550.  On
> >> the SM8450 this was a correct setting, however on the SM8550 this worked
> >> probably only by coincidence, because the DTS defined no output ports on
> >> SWR2 Soundwire.
> > 
> > Planning to send a fix for that?
> > 
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Not really, because microphone works on these targets and changing it
> would require testing. I don't have boards suitable for testing, so
> let's just leave it.

If you provide instructions, I can test microphones on SM8450 HDK.

-- 
With best wishes
Dmitry

