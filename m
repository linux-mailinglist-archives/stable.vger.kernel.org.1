Return-Path: <stable+bounces-77885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B9C98801F
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 10:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463362843DB
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 08:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E566175D2C;
	Fri, 27 Sep 2024 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CgUPagSZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002AF13B58B
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727424976; cv=none; b=XjyLef64rewhKAJ6h3lVrlNFtu0DMiC92lOZHtA5pMwqA5wFp3tbgKsvGrY6LZoGXZpejUZgxLOZIFsggVzGp/Q34Smv0oPJ45JAvoUgzdbBAJv8/tgXZNbdQjvaM2KMlA2Ta+z6v7vusBWAl/1R3P6s4N+UgP488RnMb8+1QlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727424976; c=relaxed/simple;
	bh=roXz7SvUPZVKaa4gp06k0R/WIEgquAd4f4YtZBIOY8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JToNVt75OpktlMTkYDczXMDAuIRb2ZPxXBxRKQRx9mlzZgpi2OUIgWVO4eeCxxrKctv29F8EmbtXF6QrfMJ0/aqS6ezWDV/6Evlctayeo1CZEInOSU2ZD0cyZ+X/qvqSdJrLIodZy00+lsZMVAgWQzup1VMjslJibmgjoV0pXyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CgUPagSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A39FC4CEC4;
	Fri, 27 Sep 2024 08:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727424975;
	bh=roXz7SvUPZVKaa4gp06k0R/WIEgquAd4f4YtZBIOY8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CgUPagSZn0qp5w1HitUcDTAn6+T5H+R+eUS057hlh/Z0XNL3HtsTXFNGjwrd7K7ly
	 8nC02FouVu05vg4wKQXwIhn4SHU9Qp/BwVyx9agxHie9eoX6SbQOcAFXmKQHdqxw9P
	 0/smLH+JSAUyhGaFbef3F/83wy6unKeLFeVc64Cg=
Date: Fri, 27 Sep 2024 10:16:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xiangyu Chen <xiangyu.chen@windriver.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1] wifi: mac80211: Avoid address calculations via out
 of bounds array indexing
Message-ID: <2024092746-strum-unwell-4ac9@gregkh>
References: <20240919080722.3565234-1-xiangyu.chen@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919080722.3565234-1-xiangyu.chen@windriver.com>

On Thu, Sep 19, 2024 at 04:07:22PM +0800, Xiangyu Chen wrote:
> From: Kenton Groombridge <concord@gentoo.org>
> 
> [ Upstream commit 2663d0462eb32ae7c9b035300ab6b1523886c718 ]

What about 6.6.y?  We can not take older-only patches, you know this :(

Please resend all that are needed, this is now dropped from the review
queue.

greg k-h

