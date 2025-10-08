Return-Path: <stable+bounces-183603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 563B1BC5168
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 15:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7801A4F9628
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 13:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A638E241691;
	Wed,  8 Oct 2025 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AwKnMQKO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEDA20DD72
	for <stable@vger.kernel.org>; Wed,  8 Oct 2025 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928444; cv=none; b=gGF8LMYuD8mBTYmA2LfECcUtHdDEuZk23g6OO6IvLh7BR+6eDI+DIJswQcq8g58a+Rc8m1qtg7HR0Kfh/lYEj/R9shY+8+56x6fnuju6UzDnzXR6xbV7kVYLayOw08ZPyfeHEtbpoHO3TRwL7ylhRHz1HIw74FIIjG7DI8Pa2hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928444; c=relaxed/simple;
	bh=Xn7kzTEF/V6ednxDOkE1/Sg4/wO2XSCQ16Jb55Z1Ze4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOXSA8Up5PMQMoxjNrJC/B46d3YvSHRHhtWym1ZU3tbPHzyw0VkYW6yCw6NM5ZocRSVqRImcWbTT8gw8o+s68/DPzyM/lkXkeq1/gr42+47rP7wDm4M3eYcLAT0TX1xBpYsJ5k1UHF3COpLs7oII2s9ZG4WqTd09zw6FfM3Vjlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AwKnMQKO; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so9695953a91.1
        for <stable@vger.kernel.org>; Wed, 08 Oct 2025 06:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759928442; x=1760533242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2LSe4ertuHY5UCTpJu4xbHCRSqUTutEtA/GWNFzMyBY=;
        b=AwKnMQKOaFoH/XFAA1/2aFogbjB90KoEfAiA3+7zP/LwFMKTRA842ob3V5opWrm8Lb
         FGrSK5MEw48bRJJvVG4T9bSYo0SKYtTjuSuvJLi+0CUllcNWvy6ccsXsj5g7bCYR1WHw
         /I8Egi5sASZojloStSr315jM7Q8g3bHIfqe8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759928442; x=1760533242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LSe4ertuHY5UCTpJu4xbHCRSqUTutEtA/GWNFzMyBY=;
        b=Yju5YWsjRrDN1WHbJu/t8xGWvWE7q+6ZhyljNdnsQfswI+JArBAf1bXcLFxA3cvmow
         gEJlbMwjaqNySfs4DzZx4haqGuxxjsSqebST2mri0x0GHB7bklgpeXF8I6odo24yusw9
         5HdNEpX3m3UohWXVdeb/dhEpSl/vEJwrpOSkwun7AQDKodba71iDfla8tTLvkqvm1xu4
         DBLMM5G9XuIuaKvC0pQjBQ27Nh0sM9ABNIW5jTayra15T/4ytzu3oGPzKDZjRKjkYtLv
         CAPllvZxOnNaAXvxzNx4vFiwJUXi1J94t+Q89cviUdTidjLjJ4obky296Tx3aOkKxJbC
         22Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUBpjXjHLKZ0NohYWadCs+4yy49xwfauW0QFYfR3x6jxg9iFjK3GSGm/owRKc12TzAaFutGj0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm+60dxzXDekl7KwhoMSfuVXQKs61eGc0fEeI24mLHddp58WEA
	JvQMUIF7AHRodxeqSG04MMaIuAE1ai5iyrSqMl7lEvrsCMyaQtqGDy5KMb78y+nnYw==
X-Gm-Gg: ASbGnctLzhS+3t2DjnBh2hABP+iPYpVHgW8ImfjfnCvDONBQj17PDg+5hBqvbmKUQeD
	8Y7/Hi/5NO2EKzZM3mHDofVzSHwA4evVr5w6Y01bms9vEWNBzuRbRuqpaCKQ02Q1Aj7fgWjwIxr
	F8E2mUELIJe3B11lkVXZLAhRQYToK79gZwoea9RrDDDFZ7dHoxP06QLtiLFVzMzUFh9YFBL/Oiy
	e0zlj5AgM+F/TLoOc1GXRrM8Z+argDjoX928MSxNvjO3kI4T8eyxJCavUcV4ohQVYGLWXzCqIlm
	JASeHCOdiNLn9LtPXUMpUjChvDe6MHFdRkvcTZECOVROfVJqAwu6mXSOJwr54UlD6vnwQMVTM9w
	L3xT+50iAGX4RZL9ZU7APL9lqWokPCYpDT1bSR91X3Wo2qfc407tsNJ6zn0r2cUSN5EM3Q54=
X-Google-Smtp-Source: AGHT+IHp6lps6Tj0HDAkAwY/QdXKotjR6QS87QUoHQkIeAqcTqgqsc53Y+CMU+TaHQbQnjsgq+4XVw==
X-Received: by 2002:a17:90b:3e82:b0:32e:e3af:45f6 with SMTP id 98e67ed59e1d1-33b51112242mr4111189a91.10.1759928440572;
        Wed, 08 Oct 2025 06:00:40 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:465a:c20b:6935:23d8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b51113776sm3396141a91.14.2025.10.08.06.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:00:40 -0700 (PDT)
Date: Wed, 8 Oct 2025 22:00:35 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Will Deacon <will@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Tomasz Figa <tfiga@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: kvm: arm64: stable commit "Fix kernel BUG() due to bad backport
 of FPSIMD/SVE/SME fix" deadlocks host kernel
Message-ID: <qbiybep4kcm7hijtvg6qum4ubic37s6xnlzq2jvr5jwqjoffc4@htxzojej2zsv>
References: <hjc7jwarhmwrvcswa7nax26vgvs2wl7256pf3ba3onoaj26s5x@qubtqvi3vy6u>
 <aOYkuatjNVyiQzU1@willie-the-truck>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOYkuatjNVyiQzU1@willie-the-truck>

On (25/10/08 09:45), Will Deacon wrote:
[..]
> > We found out a similar report at [1], but it doesn't seem like a formal
> > patch was ever posted.  Will, can you please send a formal patch so that
> > stable kernels can run VMs again?
> 
> Yup, already queued up for stable:
> 
> https://lore.kernel.org/r/20251003183917.4209-1-will@kernel.org
> https://lore.kernel.org/r/20251003184018.4264-1-will@kernel.org
> https://lore.kernel.org/r/20251003184054.4286-1-will@kernel.org

Splendid!

> Sorry for the breakage.

No worries!

