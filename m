Return-Path: <stable+bounces-74151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2AB972D6B
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C607B226C1
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF33188012;
	Tue, 10 Sep 2024 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xHfuLcWQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22291862B8
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960196; cv=none; b=mB6vmMJiMyaxgvpPfpU7+iD112PXN8ifhie0mXMSf5S4jwe2hqH1GhgY/DPada1x0ZpJrX3ssVLiSeIUaYLNxAezlM9ky7oTWBUma6C3ZrS8Q6rMp1flQKt2WD+2RmJ9cB/yJU+KO1k5h9dnddMq+yb14u/TCiYZmJPeZuXOjvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960196; c=relaxed/simple;
	bh=vMojZjgYjXqc6slb0V2+tBHjGuo9cqgYxfczasD1iBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uG+kTGfyZjsIctWTXbHEY7M+Be1ZN1Spu2fxNwmCsJwRigMLQTrS6G9smmH7lbLDK2X/yiZY+50YKeI9FRuqOW2jK4PCGtjuqZxRE4QffaAuOTzUINkJzJ60k5VcbRtdUEjUtbcQUdFmnZJAY6S1U5H5i0ga0K70l/MWo4P9w4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xHfuLcWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB54AC4CEC3;
	Tue, 10 Sep 2024 09:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725960196;
	bh=vMojZjgYjXqc6slb0V2+tBHjGuo9cqgYxfczasD1iBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xHfuLcWQ0O9PRnypaZ55gRmYzNp50W8AUHHZ2aJDsDVPb1ZxN273ach4l2J1oFca+
	 pQFFs+1hcFytbpMkuwENYiUDG+2PFivWNgcixgrhRwM3TVVOEoA+ZQIW1sskGjNGH/
	 Vmo75yw0nwDtYkRGj61VPOSTvf3XvnLiAaOSkdTg=
Date: Tue, 10 Sep 2024 11:23:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: He Lugang <helugang@uniontech.com>
Cc: stable@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 6.6.y 2/2] iio: adc: ad7124: fix DT configuration parsing
Message-ID: <2024091053-boundless-blob-20bd@gregkh>
References: <2024090914-province-underdone-1eea@gregkh>
 <20240910090757.649865-1-helugang@uniontech.com>
 <0ACF46DADA3C2900+20240910090757.649865-2-helugang@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ACF46DADA3C2900+20240910090757.649865-2-helugang@uniontech.com>

On Tue, Sep 10, 2024 at 05:07:57PM +0800, He Lugang wrote:
> From: Dumitru Ceclan <mitrutzceclan@gmail.com>
> 
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Why is this 2 different addresses?

And why was this sent twice?

confused,

greg k-h

