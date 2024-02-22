Return-Path: <stable+bounces-23288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ED085F12F
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 06:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D600283F6A
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 05:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B18C111BB;
	Thu, 22 Feb 2024 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ydH/fLEd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D77179A1
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 05:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708581485; cv=none; b=E4YTrDrwMXg2K81KBu3lwuExKMwMsoOdPCAnyH10VctgiTAT8Im9Oe8lC0qFxZNIPEwUpV1ieBROB80dtAvJwMs6it4DFlHjMXCGIl0uilG8lfbA64w5wSxPZDp5xP1J8v4mmfujWoGUg63ponK/k+MBtIMDLH5QL6pOYFCnyrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708581485; c=relaxed/simple;
	bh=aAZ5cA6Y1myXJq1t8eSAnj7nwii9j9vPxdPOEXMlDdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2ewolA7zBY6iewMdal6vgoFXDwZANhDs3hUMNCNXU1yQb9jLfkHe6wih5Fltf5CdNhAJR3SGr3my45Losgb+pV1FCgyrcygPz66m81CrJSD+zZornnwrXgHL4V3lgnf61SzA/T0lFMXXepJZtGDMz7XUFW3oNZNoccj0hRa9wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ydH/fLEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E063C43390;
	Thu, 22 Feb 2024 05:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708581484;
	bh=aAZ5cA6Y1myXJq1t8eSAnj7nwii9j9vPxdPOEXMlDdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ydH/fLEdyuJ6j0qv/xzWJ/QSnIbYbONRISCzFT4tC7Nv/3AL4YQoEM/lio7+hf0ek
	 +fmXLnQLsYwRKIyLnNvSoUUOZ3o9NK5WIYnwkxo6kargu2ypjkUD8BsPJUfYn9DrCK
	 bUb900C2um3H9RvDGKvMvf57tvCZ4edIICtveDr8=
Date: Thu, 22 Feb 2024 06:58:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: He Gao <hegao@google.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1] Backport the fix for CVE-2024-23851 to v6.1
Message-ID: <2024022252-primate-human-937c@gregkh>
References: <20240220232339.3846310-1-hegao@google.com>
 <2024022153-onyx-shindig-26ac@gregkh>
 <CAGVOQjFLBCGh5zRTZcmiyNNtgnMn8MBeAFqY1FNm_rtT3Pp7gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGVOQjFLBCGh5zRTZcmiyNNtgnMn8MBeAFqY1FNm_rtT3Pp7gg@mail.gmail.com>

On Wed, Feb 21, 2024 at 10:52:41AM -0800, He Gao wrote:
> I used "git apply" and it required the change. But "patch" can work
> directly so yes the original patch works fine.
> 
> In that case, I believe the original patch will also work for 6.6 and 6.7.

Great, all done, thanks!

greg k-h

