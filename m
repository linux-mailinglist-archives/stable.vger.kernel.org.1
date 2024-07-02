Return-Path: <stable+bounces-56324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44534923846
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 10:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3671C21FDE
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 08:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076FE148303;
	Tue,  2 Jul 2024 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UhBTVrKw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA81F84D39
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909442; cv=none; b=HB9jgpxznykEyQq9McJxhbbwCLpkX6i6WuOvYZMLZ/fu6KuK1oeJjwaLKhuqtT7bzC3TGtcD5407r/Nyr/TMaTv3IgVKKTtLwy5vPZJ4UMPg4LySnvj6JyXNVdlQXT5rXizVs31YC/X3dpMsJHDyIWIJuRl1IeJ1mfIrVVWu49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909442; c=relaxed/simple;
	bh=jAbIAefGD0o6Hj8rHGQud89x9cYiwlkfGlHCxGcgJlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1puT0m4AITg2LyeXfiuogEwZMYVgkuTzJruAljlzZBJWcb1tMdHSLa+WbOOWfE2TIKUmfEo4Gkqh6qF7qhyCzMRoZDXwaZ3tv5F1JTMtc6mGfsxNQH/pGw03I5p+wfFJcbkKn1zQIIhkcAfpABASphiFU3BTYQFN21FaAbLrWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UhBTVrKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C0AC116B1;
	Tue,  2 Jul 2024 08:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719909442;
	bh=jAbIAefGD0o6Hj8rHGQud89x9cYiwlkfGlHCxGcgJlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UhBTVrKwmmjD/kaK9vYWrZKdth5/yzUTzgTfulYKQREHIQStqFp9t0zlhUOE2V4Om
	 461ydTan5Pblc5wcxu1WZ17Be+aejVhAjy+vbt0Ac7vtpQOS9r/sSe9Eysqa/cVqTK
	 49iM7TyKA1iZhLBFL7D6TsYY61OCP+DuDEunprR4=
Date: Tue, 2 Jul 2024 10:37:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: stable@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.9.y
Message-ID: <2024070256-viselike-salutary-dd63@gregkh>
References: <psi6r5zzddyfqixjk2yj2wymtfriasu2qqal7aszzwkypfn4tk@gicez33v2iv2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <psi6r5zzddyfqixjk2yj2wymtfriasu2qqal7aszzwkypfn4tk@gicez33v2iv2>

On Sat, Jun 29, 2024 at 06:11:48PM -0400, Kent Overstreet wrote:
> Hi Greg, couple bcachefs fixes; this gets the downgrade path working so
> 6.9 works with the latest tools release.
> 
> CI testing... https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs-for-v69
> 
> The following changes since commit 12c740d50d4e74e6b97d879363b85437dc895dde:
> 
>   Linux 6.9.7 (2024-06-27 13:52:32 +0200)
> 
> are available in the Git repository at:
> 
>   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-06-20-stable-v6.9

PUlled and turned into individual patches and queued up, thanks.

greg k-h

