Return-Path: <stable+bounces-119964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCDCA49EFF
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 17:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D563188F75D
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 16:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3BB27425F;
	Fri, 28 Feb 2025 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fHOywo9E"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10972272924
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760650; cv=none; b=s+CgAWXJqvRZ6OAF8bRueEfd/6zf5WD7kUTnLh+WfKTL6+ypOzbNkTNQ7z1+hFkz2SgjMtnhvi5SBlKUbnZbUEfsukrCjNAVTJJfJMhoRFhjVeej6tqrBHmdnBa8FW/rssuhTVQorCseW7NFWziXqAIsTrhrG6k1dhfqaX1jlg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760650; c=relaxed/simple;
	bh=bgjg/hEmlBXv67fTl4fRy81b4dDXu1T6gmhB1dO3WdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYnt5hfnm4s7MHcfltA+JzMxwikC9Q1jnfCShh5uUwVJ/Y33VIsiwkABJtRxRQvzXKWolafz23d6ZGI3skEKxYMbMgKltAmczESkpH+76K/RnCvRWHgVuWLU6Rve5CS7I2ihV6VUS4t2f7PWeABXZ9waX6Rk8OEVKFqz3zIBYJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fHOywo9E; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <64a6131a-79d8-4250-9215-5e565a598424@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740760635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVrsBw3fKJbseyJjn+B6nGAkxIf2sXzvqUGFkrakjmA=;
	b=fHOywo9ErC6m0P2jZEnXQ7vgcWmHdqXDSEWMuHjpx8US8oTSv8SFvwhhQGwmXILoZ1sSHW
	2L+PDHrt4ebf5xGK0aUX26AV+QieJTdRzSQStv0zR8QJU1A4/yiUM9rFfZs2y+VadKZXIp
	bcKMq1xV57NluZrX5IoESMTwIhEOJ6s=
Date: Fri, 28 Feb 2025 16:37:10 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 net-next] dpll: Add an assertion to check
 freq_supported_num
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>, przemyslaw.kitszel@intel.com
Cc: arkadiusz.kubalewski@intel.com, davem@davemloft.net, jan.glaza@intel.com,
 jiri@resnulli.us, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20250228150210.34404-1-jiashengjiangcool@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250228150210.34404-1-jiashengjiangcool@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/02/2025 15:02, Jiasheng Jiang wrote:
> Since the driver is broken in the case that src->freq_supported is not
> NULL but src->freq_supported_num is 0, add an assertion for it.
> 
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

