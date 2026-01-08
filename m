Return-Path: <stable+bounces-206259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8282D03B02
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7830303DA8E
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5993590A4;
	Thu,  8 Jan 2026 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UUJkFkzy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5993587D7;
	Thu,  8 Jan 2026 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858016; cv=none; b=YNiVTtZl6pwaa9NHrJRWzYzj069TYHbNuvl1urrF4NLWmSGs+9v/JmukRBi39gAN25a3TQFB+PCatbuPomnlbL8d19CyI4bsIQlSR1KdkdUigLsshqtzvc/JedQypsFmF5krKS7o3mp2y/q5SS0qKPASPYtaLCzYDplz5bFzJxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858016; c=relaxed/simple;
	bh=5+SdFtFpvfVBRC1yw3afiHubv5GqGFOOHAl152Y+UdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KACmVE4u2+ZzGokeU4cpTkLY/gps2u8MSl74myj3O3PEGiNbvDYWUUtQQpKdg1TcLgGDui+BBBzmuJ9PudUqQVBpUa+XzX65SLLPJaCn6Q2/atMSKJoUft3ZrUmmuQjVp9P3yAP2aKzoEy9SygNMc49UBzX9SDgcY7TZ6hB3V+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UUJkFkzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F92C116D0;
	Thu,  8 Jan 2026 07:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767858015;
	bh=5+SdFtFpvfVBRC1yw3afiHubv5GqGFOOHAl152Y+UdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UUJkFkzyCrHBeu6dh1crhIRZIqjp7p3j2/kME1v1hrG7jH4RWdQbxHUJB0u8wuEh2
	 qJBBbAb3XKLFqffVfxQs4PzP/a8ODsAO3fyrrCup2p3QCqu5mm8uyN3VGahs+fZBcf
	 OfoVJtz44jobB4tYQK5q8z5rxSxN7Z6LuPxKXkrE=
Date: Thu, 8 Jan 2026 08:40:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [char-misc v2] mei: trace: treat reg parameter as string
Message-ID: <2026010824-symphony-moisture-cb3b@gregkh>
References: <20260108065702.1224300-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108065702.1224300-1-alexander.usyskin@intel.com>

On Thu, Jan 08, 2026 at 08:57:02AM +0200, Alexander Usyskin wrote:
> Use the string wrapper to check sanity of the reg parameters,
> store it value independently and prevent internal kernel data leaks.
> Trace subsystem refuses to emit event with plain char*,
> without the wrapper.
> 
> Cc: stable@vger.kernel.org

Does this really fix a bug?  If not, there's no need for cc: stable or:

> Fixes: a0a927d06d79 ("mei: me: add io register tracing")

That line as well.

thanks,

greg k-h

