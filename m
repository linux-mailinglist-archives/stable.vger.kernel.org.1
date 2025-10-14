Return-Path: <stable+bounces-185688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88086BDA309
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 16:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185A43B01EA
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 14:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6E32FFDD7;
	Tue, 14 Oct 2025 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p0kQet/l"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD9E2FF65E
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453909; cv=none; b=dMOqGlD5EzI7ZfKB6xQW3Q4/V1iJUBNekqEbKbysSWSfWRIiaQQCOTbedXe5Fp9/r8aNYtFJKCjEyv4HANDl8bJMiAfT14KORFbFuu+zeydTKehaIWhEqNW/Q6/lLqvBP73Xux4zG3p8UM2SgP20xmi/cSS5zV/c9iTkPyu/AT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453909; c=relaxed/simple;
	bh=R2Sf2U8v7Pq+Fg3Z0NqLmsByNIeFp1YqvdAKF4SarPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbI/evOSj2+pmqxosW+6K7RIrhbsbydHovg//iffM///JFOa3Pw69UEgucxFJ4Xon+JmARFCe5fbZE5s9DjtvBpnr0CLo8gCt3vZlWhOIHBpj/GKfTZivKn67G6pBIeFs5ecziXxsycNLDXOR84JoTKWKGogrSuOS3nVU8zAVk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p0kQet/l; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <55adf770-a6b2-46d0-98bd-cbcc03e344b0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760453894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jvro9e9/KYoRyaECvLBiqtrB+AY8FxjZREzbiFZyRD8=;
	b=p0kQet/lLU+N4ylar5G4lDbEKyiMXbnIJ7BQQ9ZSf762+Cth2LXQuCyPSeHwNggxPojWsg
	mCkAirn0ydepA4z/aJC9y3ejtFVbnF0dlmCH15xAYnEUZhVY+SV2UjWXxzXgwiAAL5wD5b
	drxTDwxRVnSJUmF6+m8wE2L8Jx490kE=
Date: Tue, 14 Oct 2025 15:58:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] gve: Check valid ts bit on RX descriptor before hw
 timestamping
To: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org
Cc: joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
 pkaligineedi@google.com, jfraker@google.com, ziweixiao@google.com,
 thostet@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251014004740.2775957-1-hramamurthy@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251014004740.2775957-1-hramamurthy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 14/10/2025 01:47, Harshitha Ramamurthy wrote:
> From: Tim Hostetler <thostet@google.com>
> 
> The device returns a valid bit in the LSB of the low timestamp byte in
> the completion descriptor that the driver should check before
> setting the SKB's hardware timestamp. If the timestamp is not valid, do not
> hardware timestamp the SKB.
> 
> Cc: stable@vger.kernel.org
> Fixes: b2c7aeb49056 ("gve: Implement ndo_hwtstamp_get/set for RX timestamping")
> Reviewed-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Tim Hostetler <thostet@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

