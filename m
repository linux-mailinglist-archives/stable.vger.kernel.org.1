Return-Path: <stable+bounces-163032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7C2B06826
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 22:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A181894169
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 20:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7362286426;
	Tue, 15 Jul 2025 20:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="eVzGOSpM"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CA21F0E24
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 20:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612879; cv=none; b=YWYFGthSim8j0rgEh0FOpBtRc8tuS0T0dJCQIJugfYEz4gZRm1urGwPlvYqh5UK2RINAE84oGoE62ivSkwiMN+K0OjlghDw/ibBsxFZHmau3nOH1+tWIoEfM1YiyM7c2n4g2nG+WHCp1r4h0FO2WFB0LIC5sJIlSje93e5V0OD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612879; c=relaxed/simple;
	bh=LgzU2asF5k3vCSDeX/qaDB63uYpGRuRl2pAYtPM9Er0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZklyC27J6+8VonFO+ORCgcNNDYk1kO/4XgJY4wQMiBoega8PMlt0k8wiYUhMCHbTZxU3MVOX2huSt+EMwNW/RN4iyjc+s0iSedx/XNVmDRU3QhP6JQxw50c5iNXqM0e/qHOCIows8nU4M2UUfTx8/MvaZCzT8Fsyf2xJfrUc80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=eVzGOSpM; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6159fb8b2aaso121358eaf.0
        for <stable@vger.kernel.org>; Tue, 15 Jul 2025 13:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1752612876; x=1753217676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dswGOwktWgcG3nWkirJ4ZrbQLweSksGqsERuN4NP0eY=;
        b=eVzGOSpMu/TYis/YgvFJNsqvRhsB/VFyOE2RZHlF5naj5L/gj+4UBpenU6YEvnWO8I
         HXLf6ynYhHheby+HkMM1RYNAyjCIwQhlCmiJ7eycv882bMgAAcg6R7PcvmLAOxodOrEl
         odvAXsKS19+vPuYpUzz3i5Z2EXhXoJ8K1Ur4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752612876; x=1753217676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dswGOwktWgcG3nWkirJ4ZrbQLweSksGqsERuN4NP0eY=;
        b=eBUR4y6NzJ3wC79I0TlN4Q9C8P/5BXI5bJ2Z6CIQrwXm8FndJgH2MNv9RYGrFwdI53
         cRWwwAYWahxvNTcbLd9tis8mRkaP0Mh2CsnlKT2omVZn9FxsPFX7lk229gGsroM8US1j
         eQJqWf441aGkkteQA345iZ7k1LkzjDeIBIETW13nd/tPQpaNz8Ch+TRUFGi/H/+u6s8Q
         uqyOiExK4z7L5P9CUawVkBQBL45+AjBZxQa4RPmQlvbNihmj+F0zsbiTI4V17ENLxmkN
         OkamdCnaecXqZtq116g6VuLlH9bgp/4EfoC/VS0AaBSpJl4gmQhkrIgMHUzNFp41v0KX
         uhEA==
X-Gm-Message-State: AOJu0YwqjkbKTz47ILs2rdkJxonN7VT35VOtZhUjfglt0lBKw+UQkUdT
	eEcDig0fjoeeZDdrI21GL4szzG2tfZdI08YNjHod4eZmwYbG7mL1Ph+o/P3Q9lEp5g==
X-Gm-Gg: ASbGncu2jeJe5mlC4gLVNgNBPgxwuVHZFBUwUe4TXhI11Jze5bq0RDG4w90m6+t0fdG
	QwR3m3cIWNS7J05+w7SMYoV3naj4VTl1aer17NklNpm1+fTAVb9S6xQZQC5Nwf9XmHPY3AKvtS5
	qGPql/T6QnFmh/ftAkgWDR1wUsK46acIPR9i6slbKeiFiiEclqJMCPhNHOf8zQhosLLIv+L6VrO
	SvuJidAbn8zG7IIzm80rRUyi4o4wNj/LUvpg6WXDPztrFQl+RJbKDt09uJUVPPgKfxxb6rFXYXk
	pWc3goQADGQ2XLy6dELHpZhmf+Lw7HULvIXIJPHYGq6YtGv1qZuuDUwjs4dI93RNc/h5Tjh/806
	f8eVKWeufYR4lk5R1zK9dcvr5oLuWoUyYVDhqyaM=
X-Google-Smtp-Source: AGHT+IG4xXPN2wvRnEfCL4V5sXmNlCYgQJBzs4thoSEZ169SkgQkdBQK8ezpsfkZiO6kPftgImN21w==
X-Received: by 2002:a05:6870:80d4:b0:2d4:ce45:6987 with SMTP id 586e51a60fabf-2ffb224847emr297680fac.9.1752612875994;
        Tue, 15 Jul 2025 13:54:35 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e60109587sm469093a34.64.2025.07.15.13.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 13:54:35 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 15 Jul 2025 14:54:33 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.15 000/192] 6.15.7-rc1 review
Message-ID: <aHbACXMz1Ype5uW5@fedora64.linuxtx.org>
References: <20250715130814.854109770@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>

On Tue, Jul 15, 2025 at 03:11:35PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.7 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

