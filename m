Return-Path: <stable+bounces-50254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA81905305
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879611F21C87
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A5D172BD7;
	Wed, 12 Jun 2024 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ld/2jsHm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2720316C85B;
	Wed, 12 Jun 2024 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196893; cv=none; b=mj5jy3iIOYl1ldWncLu1cHK5hR8JqTc/T4XxXzivxTS1iXyrRCS+TrM0u+VUUgvCFgLtQtv5p9+L7IqADDBDuc2szmI9Ghh9lBuQl9073b88G2CmWHy5OgLHuwm4MUuYEaPq1Voc4f0IOTZB+X3ElXruiiF1k6caGGRJLXiPC7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196893; c=relaxed/simple;
	bh=xJNU5fx+9pxV+SbMQ5zrmGP8hyVDg+xCEMQZCe52KKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcMNmfo6YdHB/d0/HJC8NAPrcL3ygo174oZh4BB5EDPO1rjWKCw2AvltkjE8R3moPqlFVILmkog/wPM0QpkJ65tTFtbpis+8+RqSY8C6eoYmKuOPaWRZoasSB3aq40jj6wvyz3tQgBvKC0bG3EgbXQ1wgV22cffZvi40GWR13W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ld/2jsHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D37C3277B;
	Wed, 12 Jun 2024 12:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718196892;
	bh=xJNU5fx+9pxV+SbMQ5zrmGP8hyVDg+xCEMQZCe52KKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ld/2jsHmMLudLjUH7Vjn3LMdB4xWhDGcPzXg3IN3GfnX/M9D/NeC5Sa0KRkxtwFIw
	 VhqkK3Bhert4Jj3EVL2bAlhDIONjjwKXHkdIm9x5SZaE7Du28jgfUhVa/4aXL68hqJ
	 IaxJHBHKb/DdNALdo/FzbxQdcXcqblztpxop8pMg=
Date: Wed, 12 Jun 2024 14:54:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, Baokun Li <libaokun1@huawei.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Sandeep Dhavale <dhavale@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 6.9.y] erofs: avoid allocating DEFLATE streams before
 mounting
Message-ID: <2024061231-nuclear-almighty-1a81@gregkh>
References: <20240530092201.16873-1-hsiangkao@linux.alibaba.com>
 <2911d7ae-1724-49e1-9ac3-3cc0801fdbcb@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2911d7ae-1724-49e1-9ac3-3cc0801fdbcb@linux.alibaba.com>

On Tue, Jun 04, 2024 at 08:33:05PM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> ping? Do these backport fixes miss the 6.6, 6.8, 6.9 queues..

Sorry for the delay, all now queued up.

well, except for 6.8.y, that branch is now end-of-life, sorry.

greg k-h

