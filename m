Return-Path: <stable+bounces-111720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB03BA2326B
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 18:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EAAC166063
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 17:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40411EEA5E;
	Thu, 30 Jan 2025 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kkB/BR8n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A095E1EEA51;
	Thu, 30 Jan 2025 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738256751; cv=none; b=Bt5BL2MDhD9hwutsicX6E3iinNmv93YQkVnbDpbW4P9sZ0Dh89QJa8W2y9o+jNw2OPbpZ7xD+F5V1f86lUxc4KW7jB8Up+iqC2k6k5YH9lBMlixN3Om4YRFwkjV2Fqo0UL4q5a0/N0nbnNlEyypn1lbdPUYmzelD5O0SYlfz4iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738256751; c=relaxed/simple;
	bh=KTJUW2FOWeUIMD+vUaqR6E5ZtU9Qt0OKHTlmVLWJ2Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGf/Z4fDfJJ4d/hxWYLf+yoWO8LKCLPdlTqxKmqthyyllRZDyhmXtTx8Ox30TzJ10FrfQtkkCFhXSewkWz9YJHLZcT2v8uQUmQ1sTo7nX5R/JsenLmRsfG/EMbY9v7zWmnv1UIh9/uJMTTbAarnVrVhgd91HFmgjUdD6HeHw7i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kkB/BR8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C55C4CEE0;
	Thu, 30 Jan 2025 17:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738256751;
	bh=KTJUW2FOWeUIMD+vUaqR6E5ZtU9Qt0OKHTlmVLWJ2Gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kkB/BR8nhgRtVxhpDkPUath2FMWTTrY6SSsrBtW+q4t7PpsORw779U73ubISSDt0V
	 STZz6T1L0KmcJoTz1Oco9+YJbYXiuHFYhsMPGNNbLCGTA1aMy89csXV2OCetsoso2q
	 bzvy9/amI0U3+cDQRzk09LkojqVkMsIn5VG3vJFQ=
Date: Thu, 30 Jan 2025 18:05:47 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 082/133] drm/v3d: Ensure job pointer is set to NULL
 after job completion
Message-ID: <2025013027-repressed-batting-4dac@gregkh>
References: <20250130140142.491490528@linuxfoundation.org>
 <20250130140145.823285670@linuxfoundation.org>
 <12607ce2-01f3-4fb6-8b50-33a9f7f26381@igalia.com>
 <2025013044-tipped-discourse-e9e7@gregkh>
 <6b7a8ab6-3174-483a-a26f-895b5ecbdbfd@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b7a8ab6-3174-483a-a26f-895b5ecbdbfd@igalia.com>

On Thu, Jan 30, 2025 at 01:45:22PM -0300, Maíra Canal wrote:
> Hi Greg,
> 
> On 30/01/25 13:26, Greg Kroah-Hartman wrote:
> > On Thu, Jan 30, 2025 at 12:56:25PM -0300, Maíra Canal wrote:
> > > Hi Greg,
> > > 
> > > This patch introduced a race-condition that was fixed in
> > > 6e64d6b3a3c39655de56682ec83e894978d23412 ("drm/v3d: Assign job pointer
> > > to NULL before signaling the fence") - already in torvalds/master. Is it
> > > possible to push the two patches together? This way we wouldn't break
> > > any devices.
> > 
> > As all 5.15 and newer devices are broken right now, that's not good :(
> 
> I agree, it's terrible. I'm currently waiting for stable to pick up the
> fix (as it is quite quick, thanks for the great work). For a even
> quicker solution, should I send the fix for the newer stable branches or
> you can queue 6e64d6b3a3c39655de56682ec83e894978d23412 directly?
> 
> I added the "Fixes:" tag to the fix and CCed stable.

You did it all right here, it's just that we can't normally take patches
until they show up in a -rc release unless specifically asked to (or
it's a trivial one).  You hit the window where the longest delay is, not
your fault.

thanks,

greg k-h

