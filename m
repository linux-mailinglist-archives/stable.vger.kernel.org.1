Return-Path: <stable+bounces-112028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B433A25BE9
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 15:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B323A12C1
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 14:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA0220551A;
	Mon,  3 Feb 2025 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l7xVIPK5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5BF1EEF9
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738591638; cv=none; b=AvcRmPvReEAjoR6R3e7hYaNcvVqHl62TWbRI5i6ZKzRgcUXDazW/a2P9hNDuQ29f+JPa0jfFjCUGUDPBxyoxK09MCJwhnZIDv8eoT6YsDihNBjjnsVM+7FR1KL7qVjYIr8qRrvu3Y5KeltZ/vz8slAFkc4b5/Uzp/Hot/SHdhcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738591638; c=relaxed/simple;
	bh=XLxLCwkQMzi9qV3v2PwJ7Ny9Gg18VCktEuPP8bq3ILY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMuuwoLtx9bkRMEwpl17KaeK6SovlyVsdnGLbzYfQyLyOVu+UsBBwbdL71Eh4V6wV7Jr7zcd2GJ2v0cc3aeYL0hS/eYvC1A9KKlmc57fTPUo6Kp2634sC3YrUZZT5Gag33Tp3kNvivpMBA8OGemDQt6rzOP4MLjvRMSBABOJRbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l7xVIPK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0F4C4CED2;
	Mon,  3 Feb 2025 14:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738591636;
	bh=XLxLCwkQMzi9qV3v2PwJ7Ny9Gg18VCktEuPP8bq3ILY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l7xVIPK5//FdPb1iygiRnPLo+mfQ+nXDrfg141RKZkHfEQjpbuDeppxBJUYww91lG
	 59rDsO/q2+JlrHehK99bPLdxv7CENeosl3jNMzF/eg70GE45bXCYfYmjES5tViSAYP
	 HQkbIpq5E6s8NxuOVeyzjmlzzQ8w3zoTD9YDN4BM=
Date: Mon, 3 Feb 2025 15:07:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Shubham Pushpkar -X (spushpka - E INFOCHIPS PRIVATE LIMITED at Cisco)" <spushpka@cisco.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [Fix CVE-2024-50217 in v6.6.y] [PATCH] btrfs: fix use-after-free
 of block device file in __btrfs_free_extra_devids()
Message-ID: <2025020300-operate-tag-f3d6@gregkh>
References: <20250203104254.4146544-1-spushpka@cisco.com>
 <2025020310-daydream-crop-4269@gregkh>
 <SA0PR11MB4701319AF5E422D47C4365C0D7F52@SA0PR11MB4701.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA0PR11MB4701319AF5E422D47C4365C0D7F52@SA0PR11MB4701.namprd11.prod.outlook.com>

On Mon, Feb 03, 2025 at 11:40:11AM +0000, Shubham Pushpkar -X (spushpka - E INFOCHIPS PRIVATE LIMITED at Cisco) wrote:
> Hi Greg,
> 
> Thank you for your valuable feedback on my recent patch submission regarding the CVE fix.
> 
> I appreciate your point about the CVE reference in the commit message. I will revise the patch to remove the CVE identifier, as it is indeed managed in the assignment database.
> 
> Regarding the cc list, I apologize for not including everyone involved in the original commit. I will ensure to cc all relevant parties when I resubmit the patch to facilitate better communication and feedback.
> 
> Thank you once again for your guidance. Please let me know if there are any additional changes or considerations I should be aware of.

Yes, please always test your patches before sending them out.

Because of a lack of testing here, I'm going to have to ask you to get a
signed-off-by from another of your coworkers so that we know two people
have verified that the change is correct and actually works for any
future stuff you submit.

thanks,

greg k-h

