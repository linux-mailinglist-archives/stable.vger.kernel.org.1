Return-Path: <stable+bounces-126043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D62A6F900
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AFFB1686A6
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCB32561DB;
	Tue, 25 Mar 2025 11:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SPSPgycB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26CC1EE7A7
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903676; cv=none; b=qfHfre/jNmxPbzV2UEGWM591Ol4SmCizsKy69L7Yw9uls4N9ARIKL8V6sohy9GymrLR434LavhbThO76EIDVU5EWwkQVl+EhZkZU0Cr0Bh5pdY8zvuf46WpTo2wBbWgGLf46DpT8fp99zOfzR+cHKlP0JrirBuQeq/YZVd1lkBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903676; c=relaxed/simple;
	bh=AiIWHnfXTWOGMJ3ZCHz9VLxivBHZ/SYRYngA9pQvQUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKY1Ko2G5oi5iZTDRmgSMPdv1jHyKBw0SGXwnyKL2LvG32SVEJ5JK5AVEoVOiWwoiFQFItyApwQQl1TTvSCVcjZ4uKYNknSWvQho59QB1WQ6bABW5xgX5uaWJKIvBLiDHRBcDfgEbGg/rOk0MaciTJ9O/Bxfw4inXQ7zrgxlOHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SPSPgycB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6D9C4CEE4;
	Tue, 25 Mar 2025 11:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742903674;
	bh=AiIWHnfXTWOGMJ3ZCHz9VLxivBHZ/SYRYngA9pQvQUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPSPgycB/W6Ps+ulTWGof++lt8vKkyLA+Wtt1Oq/68iGCKIXcqz5eBV+6HUe8bPGs
	 gJsiPx5zNu9tUrs/s111IggbkyaGjUyWkfUsrKHmGEjL7rMWuVD4p9xeECc7evzlk+
	 /3hws4OfFXkGz0dMngGMyd8hWS2/q5JrT3oROgjo=
Date: Tue, 25 Mar 2025 07:53:11 -0400
From: Greg KH <gregkh@linuxfoundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] mm/migrate: fix shmem xarray update during
 migration
Message-ID: <2025032549-arousal-grout-a4df@gregkh>
References: <20250324210259-4c1c4c7f7c182ab8@stable.kernel.org>
 <D37260CA-F91D-4293-963F-C9863B47FDCA@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D37260CA-F91D-4293-963F-C9863B47FDCA@nvidia.com>

On Tue, Mar 25, 2025 at 07:44:57AM -0400, Zi Yan wrote:
> Hi Sasha,
> 
> On 25 Mar 2025, at 7:33, Sasha Levin wrote:
> 
> > [ Sasha's backport helper bot ]
> >
> > Hi,
> >
> > Summary of potential issues:
> > ⚠️ Found matching upstream commit but patch is missing proper reference to it
> >
> 
> What is the proper way of referring to the original upstream commit? I see
> “(cherry picked from commit 60cf233b585cdf1f3c5e52d1225606b86acd08b0)” was
> added in the git log.

Yes, that works, but for some reason Sasha's bot doesn't seem to pick
that up :(

So no worries here, I've taken this patch now.

greg k-h

