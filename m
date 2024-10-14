Return-Path: <stable+bounces-83733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D56B099C022
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 08:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5E91C224BE
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8699140E34;
	Mon, 14 Oct 2024 06:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MsC/mUOC"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FC6136353
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728887990; cv=none; b=QTGkrw4ZXfFyiQhnt5rRl6+hfYZ6ckV1R2rcu6WBF5owT77EMcBc0ypKx5+Sthj0cRL0TdBCPFaNvO0+gdTfs56rWsgq0/zs9ZIjXKwygRjOftNV4OsOuUb7I40ya6O4qQzeKtvvpNNF0ZsY3fTCyydRSHirz+L/R0xmW663Bb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728887990; c=relaxed/simple;
	bh=FQphEFLBshXmaOE3JlV8b4bsc8E8MCSy4Ag9EHta9/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9fR1s0wc1xOEh0oL1aLOUMlXglzqvtJyCU9a/7FFeCU0HQxTNcjvQXWy85SOIOnai7hJLoEQJ1/NFRDtV8Wc85ira4wo/YLQeSN1IQnPS2qXmOgwP2YXVxxikHay3MhkW8F9OX30N2YTICSquwyjPrAcnCPuue9tyi2FQy8wqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MsC/mUOC; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9952ea05c5so606057566b.2
        for <stable@vger.kernel.org>; Sun, 13 Oct 2024 23:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728887987; x=1729492787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TRglJQJqC3kB/kH32ye3qji7yvxN38IgBxBdJmfg+rI=;
        b=MsC/mUOCd+/tH4VAk8FfvGu+bkjTDSY7kAb4HJPI0M/gD91bivIC4zecikPKHSZFjP
         8X+a5e0ZPRPEGhrVWolYW1T5iKJJyhN4iUrrtk0b/hA0KT5kndunjTmiEQaqL3N0osbL
         22SvV4+0ALZpEOUPw4H6qhdD8irH8tXp+HhsdPLL+SsAo9Te/4sDTpEodzRkHliEnQlj
         vrL8K2yU8ShMFDXE4aYKcURn0G4KVNfJaBwUNCxppwAl+KQX1Q/qw4ctu+H3sD4IMh3n
         7LSP42BzV2nDhqAlt4hqfcy/eqImuvCGaia1cYn23vfmQamcngqYze8wcLlHgbit0uZ1
         BmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728887987; x=1729492787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRglJQJqC3kB/kH32ye3qji7yvxN38IgBxBdJmfg+rI=;
        b=tiZOwoZbtQx/VFLyeeAxa/CBUfbGXWq62KDhtEx1FlTmkXYNycWUxjlEXkiHEG3yyo
         EX5VmsTn/5PF3eWr6Mbp/ajvC/kg/UsXycqBMEsOw+DH5luLO7Ld4qm44+ejBVBlD/h9
         zr0/aIsLB7aQ8JNW0DvBl6moepAS1ZGI81haQ4P+eI5zhYilYw95k/28RMm5Pn2WDRBl
         pTvjgz5eyu5ulKdPozo0QpmrdD/jO5J0VlT1DJmoOF5k5K5fdnLP98xWuC0J/9r3OjFk
         sKct1OENl1Q0QXXVM8z8rEItzJnUWHptA1ZEPEFWqsvpwFO363jgWw6H6aNMKuePJnNn
         pcNA==
X-Forwarded-Encrypted: i=1; AJvYcCWHaZYsP2Y3NpcdsfgcdmyIMYa1nW47CWc0f4oLI05BRskxpDg2jih1b29sbGTve7i+4m0uCw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZnCCKAzUvlfpB+0VsVogbAsm9r8tKzFOpmFuWB+WW0vFUEGqQ
	/zMhrRuh2JHirnjj+oCRmE8BexrIlwupw2R4qja5DGNn4QnpdWBznl+jHcY8Djw=
X-Google-Smtp-Source: AGHT+IGEOBmGpibQOzzCmzYJ/UdGfI18YNbVf3R8nb5+9YuL5TW0UD8qfNB6tNPfAZALkQ3UkrXf3A==
X-Received: by 2002:a17:907:3f99:b0:a99:f4fd:31c8 with SMTP id a640c23a62f3a-a99f4fd33b7mr460434866b.22.1728887987168;
        Sun, 13 Oct 2024 23:39:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99e97b13b6sm294033366b.151.2024.10.13.23.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 23:39:46 -0700 (PDT)
Date: Mon, 14 Oct 2024 09:39:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	kernel-list@raspberrypi.com, Stefan Wahren <wahrenst@gmx.net>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: vchiq_arm: Utilise devm_kzalloc() for
 allocation
Message-ID: <43471db1-f34b-4e4c-af58-4fc0f45248bd@stanley.mountain>
References: <20241014061256.21858-1-umang.jain@ideasonboard.com>
 <20241014061256.21858-2-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014061256.21858-2-umang.jain@ideasonboard.com>

On Mon, Oct 14, 2024 at 11:42:55AM +0530, Umang Jain wrote:
> The struct vchiq_arm_state 'platform_state' is currently allocated
> dynamically using kzalloc(). Unfortunately, it is never freed and is
> subjected to memory leaks in the error handling paths of the probe()
> function.
> 
> To address the issue, use device resource management helper
> devm_kzalloc(), to ensure cleanup after its allocation.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---

Checkpatch warns that:

WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

(I'm the person who created this checkpatch warning.)  Fixes tags aren't just
for regressions they're for any bug fixes.  So the Fixes tag here should point
to when the driver was introduced.

Even if the Fixes tag points to the first git commit, it's useful information
so, please, always include it.

regards,
dan carpenter


