Return-Path: <stable+bounces-53790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 701DA90E64C
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819F91C2197A
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3417D075;
	Wed, 19 Jun 2024 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RQ5+b5tZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7E17BB15
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787092; cv=none; b=S8PXSwVNf/eobbKZQyppBuNosNHHTqjd/hFC7vG+Jhy1YhPi5P3v+gY/ukki1lKUKPBjXVGHyqHiTHtlCmitnag5c+XXTY3bj5xvO//WL8DsLfaEf+9JQ28TlD5yJ0/hhpGzjQS5zfyDX81jjvZSbh2VaDpbljLe/jlOHeLWTDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787092; c=relaxed/simple;
	bh=BW/0xiWauTklwmPyBYspH//6h+G191srJ+5J1pw9obI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2Nxn6rGlYgs9wQ50MBhnXvDtmsTBHwp2jJ5uM/onVBIRKw/W/S+Z8CSvFyg3eOa6bQ3v92iHUPQGnyhzR/BVKunXWYWtgt9LVpKkOahECA9nv2jg+V8gu8UBAPjtwu27psJzk/dNRuXc14MYCVlmU21d8+EH8sG2rxUER8ZRRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RQ5+b5tZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89098C2BBFC;
	Wed, 19 Jun 2024 08:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718787091;
	bh=BW/0xiWauTklwmPyBYspH//6h+G191srJ+5J1pw9obI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RQ5+b5tZTIMWqqDf7ofGAXil3Bbj2J1lU3mivvompWm6k+qCJNEN+VQ8qj6j1kvoB
	 Ane4XM4QDvxKLK0cEuNMDxzKmd5XIph0FeOuPZl2pvjNhCu76vCo1R1qWG2eoztjSv
	 ju5l42lkVtxtpZdrEvQy/adgBgERFdJy9cvTc94I=
Date: Wed, 19 Jun 2024 10:51:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: stable@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 6.9 1/2] wifi: iwlwifi: mvm: support
 iwl_dev_tx_power_cmd_v8
Message-ID: <2024061917-kinswoman-nylon-c35f@gregkh>
References: <20240618110924.24509-1-emmanuel.grumbach@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618110924.24509-1-emmanuel.grumbach@intel.com>

On Tue, Jun 18, 2024 at 02:09:23PM +0300, Emmanuel Grumbach wrote:
> commit 8f892e225f416fcf2b55a0f9161162e08e2b0cc7 upstream.
> 
> This just adds a __le32 that we (currently) don't use.

Why is this needed for a stable tree if this is nothing that is actually
used and then we need another fix for it after that?

I can't see how this commit actually does anything on it's own, what am
I missing?

What bug is this fixing?  A regression?  Is this a new feature?

confused,

greg k-h

