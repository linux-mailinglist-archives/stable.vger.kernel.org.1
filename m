Return-Path: <stable+bounces-62608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467B793FE6B
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 21:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01537285125
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 19:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B127188CA5;
	Mon, 29 Jul 2024 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M+ueuUBr"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BDD824AF;
	Mon, 29 Jul 2024 19:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281951; cv=none; b=r+6nxJJr7YoYoc27snf0k+rr91ETWCxNBkcHHrrrYZ6CI2YYoretn0m78Up6h+2CSsoN5ZVB0IfAdHnhHxBqkV5sm7u5xQ5k5tpYy4//wtHH6EKy6xJQNkZ4s6/FhWwRKSZRXLcmZrukY9aPMBEFZ8x12v35CZ4dzRRApQCyhPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281951; c=relaxed/simple;
	bh=iCH+EAXe7Y9aB/wfVqR8xYZ52Lp9Ys8wwOorK2yBiDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5gXIBAOukpn716tztfYFcwW/g/LQlEJfM4yQRliFoupv95mE6qN5Ox3SMeEbnomEE0KT8wB3MtMaOwhHYYTZuEIyrge/dWRb+xGtqNJqzYpRJnsTTnKUyJlR+olPcwvhjIdTVgDWFqBC4fWl1BLqxEmDUlqjNMlvIPhaTCvW5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M+ueuUBr; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <64e27c5b-19bd-455b-842c-facab55fef42@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722281945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3W6gMDI+jl/O2enWAPr3MJPV8FGjizyoMnNHOsC4RSY=;
	b=M+ueuUBrRZVjrOEqR7tCCpUWviNH+mKWxRiP96jGps8HNIrpYAW4iUBu8tHOaPkkNoYhPB
	efmtnShxy37NBmM0DlnSi5eq/8v08qwNWsJKBXWsPd5azxDovAoggWpmF8g4Ed7JqcJnvK
	f3MsovIzNC/07Al4kQMa/QBH+2CHrxA=
Date: Mon, 29 Jul 2024 15:38:59 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Patch "drm: zynqmp_dpsub: Always register bridge" has been added
 to the 6.9-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Michal Simek <michal.simek@amd.com>
References: <20240603114605.1823279-1-sashal@kernel.org>
 <12c2adcf-cc18-48a8-8411-0ba9ec3551e0@linux.dev>
 <2024061237-unisexual-unawake-1efe@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <2024061237-unisexual-unawake-1efe@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/12/24 08:42, Greg KH wrote:
> On Mon, Jun 03, 2024 at 11:04:28AM -0400, Sean Anderson wrote:
>> Hi Sasha,
>> 
>> Please also pick [1] when it is applied.
>> 
>> --Sean
>> 
>> [1] https://lore.kernel.org/all/974d1b062d7c61ee6db00d16fa7c69aa1218ee02.1716198025.git.christophe.jaillet@wanadoo.fr/
> 
> Please let us know when this hits Linus's tree.
> 
> thanks,
> 
> greg k-h

This is in Linus's tree as commit 4ea3deda1341 ("drm: zynqmp_dpsub: Fix
an error handling path in zynqmp_dpsub_probe()").

--Sean

