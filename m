Return-Path: <stable+bounces-100551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4449EC6BA
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFF2188A113
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30ED1D61AF;
	Wed, 11 Dec 2024 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fAtJfprA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782CA1D2B0E
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904914; cv=none; b=DP3BPkLtn40PLs30zPudBTog2IDwfQyTJbPqbFPEGspwhkI5HJNjCKKTk722BAlP1ypaFoa77sO5wPNWXLTzJ80uedbuGG1XlxcdVZSci4EKX15uI1bYsl3mvysUxlmf172eNgo5q4tufo86YNjUVC+mleEwmfcrwbEzqeYvyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904914; c=relaxed/simple;
	bh=2VP2P/WFmOXAUErg03UmZXTZxzahDMZqHcTF+D8aK8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tr/kx8wWBAAtSZHwM2fXZ+t2SxGPdoC0aPe6s8DKxRibymciNGmTm8YLkZMlRNcBXHp+IGDrxHgawaVVmeOnECjyYGMCkQQP8hNsCjx4TxcLKkPEiYdGCd3khoEFzI3RF01L44t26ZJK2JKyvLFj+fM6305p1Dk4XSiER5y3LMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fAtJfprA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A448DC4CED2;
	Wed, 11 Dec 2024 08:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733904914;
	bh=2VP2P/WFmOXAUErg03UmZXTZxzahDMZqHcTF+D8aK8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fAtJfprA69XfQcCFOo80s3UXZ/aaIZwOSEBnIoGjABpNzIkRNH7u9Q/cQBcNvtbAU
	 YFZ7dyJxaa7br6DXLmZ/3dz48H94SndGZpgiQ3rcJ9u57MAz3f2N0nQMHTvNQjmb+Y
	 3wHQ7a5ltMLoa4ubTMimVnuRnx/McWf/HekoXL3s=
Date: Wed, 11 Dec 2024 09:14:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jianqi.ren.cn@windriver.com
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] cpufreq: amd-pstate: add check for
 cpufreq_cpu_get's return value
Message-ID: <2024121111-tubular-diffuser-ccd5@gregkh>
References: <20241206104115.1273254-1-jianqi.ren.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206104115.1273254-1-jianqi.ren.cn@windriver.com>

On Fri, Dec 06, 2024 at 06:41:15PM +0800, jianqi.ren.cn@windriver.com wrote:
> From: Anastasia Belova <abelova@astralinux.ru>
> 
> [ Upstream commit 5493f9714e4cdaf0ee7cec15899a231400cb1a9f ]
> 

Please cc: all relevant people on backports.

