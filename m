Return-Path: <stable+bounces-76024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7E7977428
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 00:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A751F25156
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 22:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176591C2449;
	Thu, 12 Sep 2024 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fM2zoiHp"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D40191F8F
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726179426; cv=none; b=Xgh3gf+SqveLAG+mRdk5DH2YkhWKBIXvETj2kBo5Ve1Z5QXEmahtOWklqqelfjckYwBpQBImKo3TUA07IJacORJPBbkTgSj2rV8nMRmRN1EzWw22yJ7mxaWJNaHKXB+2T2Rw1sxxk5HNa4N5BcO9Z+FiptF45gtGZvISpaBuHk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726179426; c=relaxed/simple;
	bh=7jW1lpk3kIMO+KnNV43hPB0+le0/il1cP3oT2VYmTW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s9GgpVV1NPRhMWUUaimygWLGP0e8w24pll80RmueVvqmr3T3gC7zcN3w0adKHGy2lNVSk1TRhfTMphFbDkYCJGG+Gl/usbSmOjDR8eIA8vINaLz9lOQLDzWXZHEAZFCHPpPCEgACeGqldaJIOY7sXd13e+i/acaYKLyO4FtgxRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fM2zoiHp; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <26a35c93-5a59-4ca1-ba62-01258767b214@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726179420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xcAaAUH/XpTJobVFOPAuYyrAxzloWB0KzX4fS/1XGOU=;
	b=fM2zoiHpGWPGwkitjqjDqi/lXNkI8cgS0A0+zleMwQ4XHjvrQ1V9av3KieNLHH/nu33yF8
	XBw+yqqjvQW4ziMUXx2TarBUNGgQomrxHVfoLKp+/q4NY/8gAznD4pBOqAMCuFzJYnjQaa
	02374pU5iBKNCnMM/j4EvusX1JkWDaQ=
Date: Thu, 12 Sep 2024 23:16:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] fbnic: Set napi irq value after calling
 netif_napi_add
To: Brett Creeley <brett.creeley@amd.com>, alexanderduyck@fb.com,
 kuba@kernel.org, kernel-team@meta.com, davem@davemloft.net,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jdamato@fastly.com, stable@vger.kernel.org
References: <20240912174922.10550-1-brett.creeley@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240912174922.10550-1-brett.creeley@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/09/2024 18:49, Brett Creeley wrote:
> The driver calls netif_napi_set_irq() and then calls netif_napi_add(),
> which calls netif_napi_add_weight(). At the end of
> netif_napi_add_weight() is a call to netif_napi_set_irq(napi, -1), which
> clears the previously set napi->irq value. Fix this by calling
> netif_napi_set_irq() after calling netif_napi_add().
> 
> This was found when reviewing another patch and I have no way to test
> this, but the fix seemed relatively straight forward.
> Cc: stable@vger.kernel.org
> Fixes: bc6107771bb4 ("eth: fbnic: Allocate a netdevice and napi vectors with queues")
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>

I agree that irq vector is lost without this patch.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>



