Return-Path: <stable+bounces-64793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B536943460
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 18:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4177E1F2254E
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F031BD4EA;
	Wed, 31 Jul 2024 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="H+Bu4DHp"
X-Original-To: stable@vger.kernel.org
Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C251BC09A;
	Wed, 31 Jul 2024 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722444567; cv=none; b=Q1/lRTRYKmofjzyuHKL2LrbjVjDbre0xIjkhmu+xQXZ9qcHubOOCVoxt+7VRmF8lpYFti/stRQxSrefIgsIEgswZ7t8d309TmP5xIz68cnj48Aw27KLazQonnOEkXxhQY3PNluZopKY6hT+omw1tuKybuDacHA0GAHVa0jqA7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722444567; c=relaxed/simple;
	bh=CgXJx6ckBCTaY1Mrgdc3twbLieJeQ+a0Gwri3SQ6P3c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYmL2eJwzQNdPArGe/H1K9lJektIGE/tQAcDU0fFQl0O+dpGVKo6W94Tk1qNd70S9nh+JVATI0GRcrBx/085GgC5VM+UKK8DLB6Q86Tdu9fXDTNX7Taw9CvviCaAW+GoW8TVht7vFDb2AyFqNExlu5WrAFXo4CBv8MZxWhE9fCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=H+Bu4DHp; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Wed, 31 Jul 2024 18:49:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1722444559;
	bh=CgXJx6ckBCTaY1Mrgdc3twbLieJeQ+a0Gwri3SQ6P3c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 references:reply-to:Sender:Subject:Subject:To:To;
	b=H+Bu4DHp9x3Xc89gtbP/6qg/Pcx2/6C3eD48T1V5InI4qNg6wKNMsjxiWfGZCnm6c
	 wn7ZeXu35kPxYvNs0hhPTrz4MnA77UJ+vaSCKtGAZWjgZ8QlbEAAjwCAZl458ocpXa
	 qOs3CyyOHRlA7o2f9tCv6ZQzR/JxhUf+yrmQfk6AUQssvNplB01aUI5qj/ffohJz1L
	 5c77YILELX8/qo3nDinLt0lemKV5yKI8fAxw7FPDR+cplV7qUmWX4Yz8qnV+4J/hSX
	 StQcvIoda+GqrSzUTOM2ygbyFM4gU5/Z1QbWmJhSbYM4+B+FKe2ybusIQ2KeVH9alT
	 s6Ii6kltIy6UA==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
Message-ID: <20240731164918.GA3343@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240731095022.970699670@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731095022.970699670@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.10.3 release.
> There are 809 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 02 Aug 2024 09:47:47 +0000.
> Anything received after that time might be too late.

Hi Greg

6.10.3-rc3 compiles, boots and runs here on x86_64
(AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

