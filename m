Return-Path: <stable+bounces-163380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614FBB0A681
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 16:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855D916CFBD
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 14:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BCA2DCC02;
	Fri, 18 Jul 2025 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYi3LRkS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B163E1624FE;
	Fri, 18 Jul 2025 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752849799; cv=none; b=bUxmiil/gIfR15y/f2Eg+xvwrRr4yNO7tZRsfcSPAKsV+kvVaOJ9MCY6piYEmkcMCYtcSZo4qVxxGnHdKoaCxodQBMbMLHg9mZ4vB9pCB13/NKWilk1Uf7l9MLc3Yr0afshu6OBEr4fi0VCQUUFVYpfIaqrhNXt/Yv0NL5ZQSF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752849799; c=relaxed/simple;
	bh=YMkW5nEf7hm4pm313ZbbRzQoRqjdYejYVjMs44cA3Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixZ5QOgOhmEjf3X0RMp/V3aM3wBxGj2nojU4P7+aaZdsWMWx9oCSL+WGi0aXi/K1dGsQrv2r8KnPqTn07rQee4kx/XtbeCYamgO2JCEWS6sccBDkETreDshh4mS72GexnjRa+iSBKpoGnYNFxxkAhSo4O9enj3Z3AEvfze9v/H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYi3LRkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB3EC4CEEB;
	Fri, 18 Jul 2025 14:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752849797;
	bh=YMkW5nEf7hm4pm313ZbbRzQoRqjdYejYVjMs44cA3Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYi3LRkS5k8FwopumFP4I+IVnd4SCUM4EvcG0MYLMib4Iy+1sGXmEL1OcCkrmaxOu
	 uZ/WRH0Lh2p1rXHAMFljH6w3MLdLUcyqX+CkQa8SG8GfqX9kWyHoclNmRblQtOptOO
	 td+nz9mmVJYzIbHDkqpXqD87/tDz2/5J6oyfJaGWMZNB3Wj0t3fYDf+OczfThCUm/d
	 KeK9LRxYSf0qJbgsWpUgQajt85BJsD8UCO28+d804LJNdC1m9v6JR4lFYJLcoFH8Eo
	 3Z9GtMDz/kcc2mzDLXjQsOo6dAqtVi8SxnzHMYeENNhMXgaTPbpeqiU3Wk3zUxD2mV
	 cryTDUu3igVow==
Date: Fri, 18 Jul 2025 15:43:13 +0100
From: Simon Horman <horms@kernel.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: ioana.ciornei@nxp.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] dpaa2-switch: Fix device reference count leak
 in MAC endpoint handling
Message-ID: <20250718144313.GH2459@horms.kernel.org>
References: <20250717022309.3339976-1-make24@iscas.ac.cn>
 <20250717022309.3339976-3-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717022309.3339976-3-make24@iscas.ac.cn>

On Thu, Jul 17, 2025 at 10:23:09AM +0800, Ma Ke wrote:
> The fsl_mc_get_endpoint() function uses device_find_child() for
> localization, which implicitly calls get_device() to increment the
> device's reference count before returning the pointer. However, the
> caller dpaa2_switch_port_connect_mac() fails to properly release this 
> reference in multiple scenarios. We should call put_device() to 
> decrement reference count properly.
> 
> As comment of device_find_child() says, 'NOTE: you will need to drop
> the reference with put_device() after use'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 84cba72956fd ("dpaa2-switch: integrate the MAC endpoint support")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


