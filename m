Return-Path: <stable+bounces-118432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B0EA3DA3E
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 13:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C3C189E80D
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 12:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BFC1F4615;
	Thu, 20 Feb 2025 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XYhMlWAb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1421C831A;
	Thu, 20 Feb 2025 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740055263; cv=none; b=l2BXw/qcxlN6ZE48NlFUeperHEKUYMrAeHrwrkw0zbacg7Sc2kCf+erfWNOkoS+qUjz0mXu+aSVJckdWSFbhL90GcEEMCIAKl59748oP5FiYzc7apv3WmfpU018ihIAQtBBqsJlT/K7UJSbuxJX3ISCvZaBSulvglLm76niq3Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740055263; c=relaxed/simple;
	bh=vcz8id6kh/tQSinqUfNUplzzW80d3HXm2rhjsaUZE2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZcZfhWnSV4ik74s/UHrVHo6/da2/8yOtfvGxyjca1lLiL9YydLlwajafMwqwCcsGeganD5dbyUptLK0cemrrOaP+SNVLdBboeTUEpPp12g422Mc3S8iUWnjDaSbRbel6luFsm9c6Cv96bt6AdWlyagL+UMOfh4aZs6pixA2Jjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XYhMlWAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F398EC4CED1;
	Thu, 20 Feb 2025 12:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740055263;
	bh=vcz8id6kh/tQSinqUfNUplzzW80d3HXm2rhjsaUZE2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XYhMlWAbL6IQKeTn0ZqXCfEXKxq4atBoFreYpQi9YWl4SXtnXlLeMDa5s/z5A+48F
	 wX57fAXomGN3kC/CTLzKwtpfE7M1vLY56q7/DEtmiAGtrR4dHivyz+LncH/xkvjp5b
	 CWel/V5+pA3WvWuvw0o5C1IORYVbdVXX6dMqZc8M=
Date: Thu, 20 Feb 2025 13:41:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Binbin Zhou <zhoubinbin@loongson.cn>,
	linux-sound@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] driver core: platform: avoid use-after-free on
 device name
Message-ID: <2025022005-affluent-hardcore-c595@gregkh>
References: <20250218-pdev-uaf-v1-0-5ea1a0d3aba0@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218-pdev-uaf-v1-0-5ea1a0d3aba0@bootlin.com>

On Tue, Feb 18, 2025 at 12:00:11PM +0100, Théo Lebrun wrote:
> The use-after-free bug appears when:
>  - A platform device is created from OF, by of_device_add();
>  - The same device's name is changed afterwards using dev_set_name(),
>    by its probe for example.
> 
> Out of the 37 drivers that deal with platform devices and do a
> dev_set_name() call, only one might be affected. That driver is
> loongson-i2s-plat [0]. All other dev_set_name() calls are on children
> devices created on the spot. The issue was found on downstream kernels
> and we don't have what it takes to test loongson-i2s-plat.
> 
> Note: loongson-i2s-plat maintainers are CCed.
> 
>    ⟩ # Finding potential trouble-makers:
>    ⟩ git grep -l 'struct platform_device' | xargs grep -l dev_set_name
> 
> The solution proposed is to add a flag to platform_device that tells if
> it is responsible for freeing its name. We can then duplicate the
> device name inside of_device_add() instead of copying the pointer.

Ick.

> What is done elsewhere?
>  - Platform bus code does a copy of the argument name that is stored
>    alongside the struct platform_device; see platform_device_alloc()[1].
>  - Other busses duplicate the device name; either through a dynamic
>    allocation [2] or through an array embedded inside devices [3].
>  - Some busses don't have a separate name; when they want a name they
>    take it from the device [4].

Really ick.

Let's do the right thing here and just get rid of the name pointer
entirely in struct platform_device please.  Isn't that the correct
thing that way the driver core logic will work properly for all of this.

thanks,

greg k-h

