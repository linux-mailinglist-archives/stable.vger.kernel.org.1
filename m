Return-Path: <stable+bounces-200992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 075AACBC30D
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 02:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92B5A300DCA3
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 01:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B40B29D29B;
	Mon, 15 Dec 2025 01:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqGvJDZT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005BF191F98
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 01:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765762767; cv=none; b=dv41muFoXVetul+XqMy/KqaW3oaaGd2SwQfPeFCrorXVX5MAjoV2+i0tuppCUP/Bc7Ql9YDTR8Wn5BsE/qqOipUMzq5S7bO1kTZUuvEQuEoIGT9ZprT5U24prUbN3xss9cJTYpFhwrtaQNCvbX+2O8xM840MMeGcK/9mu/AXKRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765762767; c=relaxed/simple;
	bh=k0AIvnDWVMG7Y4wKZy8PhAxFrYCzZJ0PZRlPyQMp2d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZH814Xyk2ghVk+s2GPDttKlIutG6koZangGjU7nXtKH/hRyBZxPgHK3gRgBCxG7JyMjXtoY8N2TRiSdr3FobiFP/hVklYoRjh2WrllnVIidLqGBwLDKWVM1mbR1NDJgxSsxHTo3c7beU4lCIBP0qBbhKAJ5NKvUnM1XG+TK/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kqGvJDZT; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c84ec3b6eso554023a91.3
        for <stable@vger.kernel.org>; Sun, 14 Dec 2025 17:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765762764; x=1766367564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ANBknulCzJ+NpT/RV9+tvFzXk2SLbrdyzL4bSFdcmvU=;
        b=kqGvJDZTxNqlZhVm3XoMzYF0aT4mbjfjNYu1/ZMWAg6La+VpbvyGcSU7ZENHnsJ2BR
         hPo1n4cUNXJIFKiowsXxwogTiSt/UUhwN+7Yi6yxRw6HX5kh/8j/mNZd8No250JJ7/QR
         FBDl1eZgG6FZnG+E3bZ8kVgESKnQT9EtwzeCp3S6GojrFszRx3wewHCgUKL1ZkuftbXl
         p7zO4cXGqcEaTKiPBUJcDoa53byMafJ5MsGn5qmFxUILfIfWCkbtG1S6xlhR4xu8w3rX
         3sTHuMfqcMxJ4pYAURdzvScqAvEbpjr8rlpehFxtIpl1z2SXYDo1ons25kcasdY9/ide
         LzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765762764; x=1766367564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANBknulCzJ+NpT/RV9+tvFzXk2SLbrdyzL4bSFdcmvU=;
        b=oby/0f4aJdFFJn8UkB6ee5/AttlT9clfD5txcWT1a1eQUNS0jDqDOuovujRBHBrtrY
         8Zhhc0W+JFD0o0EN78I2p6fi7By2P52ScJbiM3vKn6Iv9m3CctJCmC0dmU/nBwKsq78o
         aNs4bwNv00+WsXsSAaGLvxagDKMx2blbL5++pweY7S/XoTZcm37IVyJ60UkTh/2GrDD+
         2M8iF0Dlz7GLSvQiFarfDojfinOYXagQczalD1uPY2B83XIgMIZX5tJWpzMU7UiLkrI/
         aerkxvL4Wz6FIE6emXRjWQgDNcB0W5L94rB/qz/MXKSvEwnI6GLKwHgg/8y8OowNKbSL
         mcEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXODRDtqxmCcAssG28Tu1E8+PwjlCZfehzUgq3IhZf5HS95cGoyjufOnaBzKp36V70txSkwR5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR+xxKvdKR987hbpGcJlYL56NyI0YRLwbCubXYTqxqxYMU3s5S
	cfVUgfrYoOy2nh7t6l2bed8/sAQ+QL5Ftpw1jN/5KvkhHCQQcHjPUtGBl4cMtp6Nod8=
X-Gm-Gg: AY/fxX4KOKPZM9+FExTHqjnYy9rsHESOm6tULVZ1p/BVU2vF0H5+LrWJ6MOLtMjGDL/
	AY/w1zxWmriTBC+mXtxDeiGGwIWhFdYNQXSwZr5PX9ecEvdi3/cgvI1O1zK5du9hEsrt49mU4KG
	L61vjvQd3QGUcAtOYGcehJntgMggXparuOMzqOvKKVoFoR/2p7vhe9jZVA15/6VGJM8GafqV3DQ
	zojxS1MnX7hF+vcLDYBp3DohgM0V1kKB4Gvv3wN1xB8MP+HpQuxRI/TbIJMB5Qf4hWKD/9UesBo
	h8wel9N8MPivvzK3ZdnZI25EXjAKW9Bz0/WoX12O1bjRe86n7i647kXi+CfwT/yrrmgN5HzzeS6
	EWfSX1iAId1A5rydcv+MPNiI4rBVZJHNGXQlQ3/hKHUZXIXBbaPJlnFOZuxbe0jrl1eEZI+bXD6
	UBF0SJwLPPcvxr2HV2kRUu8oNkFo6YwjCdXOGdvGdvrA==
X-Google-Smtp-Source: AGHT+IEEH/MPRy5s7U+kyHScGR0GHLIOXl1SxGpgweU/Mtzit1FYvEDkVU28mycvGRDH2rPMUZtm9A==
X-Received: by 2002:a17:90b:35d2:b0:34a:48ff:694 with SMTP id 98e67ed59e1d1-34abd7a4d37mr6767705a91.31.1765762764021;
        Sun, 14 Dec 2025 17:39:24 -0800 (PST)
Received: from p14s (p7838222-ipoefx.ipoe.ocn.ne.jp. [123.225.39.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe13f7e6sm3093132a91.0.2025.12.14.17.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 17:39:23 -0800 (PST)
Date: Sun, 14 Dec 2025 18:39:19 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rpmsg: core: fix race in driver_override_show() and use
 core helper
Message-ID: <aT9mx4cd4JldZtyc@p14s>
References: <20251202174948.12693-1-hanguidong02@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202174948.12693-1-hanguidong02@gmail.com>

On Wed, Dec 03, 2025 at 01:49:48AM +0800, Gui-Dong Han wrote:
> The driver_override_show function reads the driver_override string
> without holding the device_lock. However, the store function modifies
> and frees the string while holding the device_lock. This creates a race
> condition where the string can be freed by the store function while
> being read by the show function, leading to a use-after-free.
> 
> To fix this, replace the rpmsg_string_attr macro with explicit show and
> store functions. The new driver_override_store uses the standard
> driver_set_override helper. Since the introduction of
> driver_set_override, the comments in include/linux/rpmsg.h have stated
> that this helper must be used to set or clear driver_override, but the
> implementation was not updated until now.
> 
> Because driver_set_override modifies and frees the string while holding
> the device_lock, the new driver_override_show now correctly holds the
> device_lock during the read operation to prevent the race.
> 
> Additionally, since rpmsg_string_attr has only ever been used for
> driver_override, removing the macro simplifies the code.
> 
> Fixes: 39e47767ec9b ("rpmsg: Add driver_override device attribute for rpmsg_device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>

Applied.

Thanks,
Mathieu

> ---
> I verified this with a stress test that continuously writes/reads the
> attribute. It triggered KASAN and leaked bytes like a0 f4 81 9f a3 ff ff
> (likely kernel pointers). Since driver_override is world-readable (0644),
> this allows unprivileged users to leak kernel pointers and bypass KASLR.
> Similar races were fixed in other buses (e.g., commits 9561475db680 and
> 91d44c1afc61). Currently, 9 of 11 buses handle this correctly; this patch
> fixes one of the remaining two.
> ---
>  drivers/rpmsg/rpmsg_core.c | 66 ++++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index 5d661681a9b6..96964745065b 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -352,50 +352,38 @@ field##_show(struct device *dev,					\
>  }									\
>  static DEVICE_ATTR_RO(field);
>  
> -#define rpmsg_string_attr(field, member)				\
> -static ssize_t								\
> -field##_store(struct device *dev, struct device_attribute *attr,	\
> -	      const char *buf, size_t sz)				\
> -{									\
> -	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
> -	const char *old;						\
> -	char *new;							\
> -									\
> -	new = kstrndup(buf, sz, GFP_KERNEL);				\
> -	if (!new)							\
> -		return -ENOMEM;						\
> -	new[strcspn(new, "\n")] = '\0';					\
> -									\
> -	device_lock(dev);						\
> -	old = rpdev->member;						\
> -	if (strlen(new)) {						\
> -		rpdev->member = new;					\
> -	} else {							\
> -		kfree(new);						\
> -		rpdev->member = NULL;					\
> -	}								\
> -	device_unlock(dev);						\
> -									\
> -	kfree(old);							\
> -									\
> -	return sz;							\
> -}									\
> -static ssize_t								\
> -field##_show(struct device *dev,					\
> -	     struct device_attribute *attr, char *buf)			\
> -{									\
> -	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
> -									\
> -	return sprintf(buf, "%s\n", rpdev->member);			\
> -}									\
> -static DEVICE_ATTR_RW(field)
> -
>  /* for more info, see Documentation/ABI/testing/sysfs-bus-rpmsg */
>  rpmsg_show_attr(name, id.name, "%s\n");
>  rpmsg_show_attr(src, src, "0x%x\n");
>  rpmsg_show_attr(dst, dst, "0x%x\n");
>  rpmsg_show_attr(announce, announce ? "true" : "false", "%s\n");
> -rpmsg_string_attr(driver_override, driver_override);
> +
> +static ssize_t driver_override_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
> +	int ret;
> +
> +	ret = driver_set_override(dev, &rpdev->driver_override, buf, count);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t driver_override_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
> +	ssize_t len;
> +
> +	device_lock(dev);
> +	len = sysfs_emit(buf, "%s\n", rpdev->driver_override);
> +	device_unlock(dev);
> +	return len;
> +}
> +static DEVICE_ATTR_RW(driver_override);
>  
>  static ssize_t modalias_show(struct device *dev,
>  			     struct device_attribute *attr, char *buf)
> -- 
> 2.43.0
> 

