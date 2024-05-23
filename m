Return-Path: <stable+bounces-45669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829958CD1BB
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 14:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34EB1C20B27
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 12:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3713D1487D5;
	Thu, 23 May 2024 12:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xLDqECOk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5C013EFFB
	for <stable@vger.kernel.org>; Thu, 23 May 2024 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716465877; cv=none; b=GxYiK+bm9GxgODWFLhYGzwSGnvQDNQJvYKCfZSKPNJy5oF2UoLfjGkRU+yPuOemNok5EjF74xDLM6aXohkMl3U/v42Py6OZKKZQ97ETIY4KBgOupEzInH6Wm/xBuQt9wA8jY/0geJLgX4KSpO/nTgQ7+GUBI2DdgPxk7V7emPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716465877; c=relaxed/simple;
	bh=Y0LhSmJVz8BjWLfi2oZbkhX4rCSvcY2bxJLpmMkX5Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRM+2zdgoc/0FIAQRfY5kOgKcjd/Hp0J/6+jZ9tAlId84DMBBOuoETy/NkJJXNpb3ebvFVD1h4lMg1tH8kvE7fUTbUGza6+ssb4Vgc3NJPYAhAwSu6WA9vRblyhVmbh34VbZlDUdaKFSQzsN/ohQ9pvoBYraXQdcYS4Cvk57b2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xLDqECOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CFFC2BD10;
	Thu, 23 May 2024 12:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716465876;
	bh=Y0LhSmJVz8BjWLfi2oZbkhX4rCSvcY2bxJLpmMkX5Ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xLDqECOkG1aj05Tjc4X1sZAdMJ3KwYseZJm6hWJYuNyrZP1WaPp9PrHuyl405tLBz
	 UysG/fxOSQoNpOcIUhhNOOUPHBI5vraKzdJow37dAj8V6IUJ8f8MA3aXbZRTidwa1Z
	 XRt9ttn9VXVK/oKeEVy4Qo/NRnP/9yXtX76Fz7M4=
Date: Thu, 23 May 2024 14:04:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: stable@vger.kernel.org, dsterba@suse.com, pavel@denx.de
Subject: Re: [PATCH 5.10 / 5.4 / 4.19] btrfs: add missing mutex_unlock in
 btrfs_relocate_sys_chunks()
Message-ID: <2024052326-suds-scrutiny-9e45@gregkh>
References: <2024051346-unvocal-magnetism-4ae1@gregkh>
 <20240513230649.1060173-1-dominique.martinet@atmark-techno.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513230649.1060173-1-dominique.martinet@atmark-techno.com>

On Tue, May 14, 2024 at 08:06:49AM +0900, Dominique Martinet wrote:
> [ Upstream commit 9af503d91298c3f2945e73703f0e00995be08c30 ]
> 
> The previous patch that replaced BUG_ON by error handling forgot to
> unlock the mutex in the error path.
> 
> Link: https://lore.kernel.org/all/Zh%2fHpAGFqa7YAFuM@duo.ucw.cz
> Reported-by: Pavel Machek <pavel@denx.de>
> Fixes: 7411055db5ce ("btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()")
> Cc: stable@vger.kernel.org
> Reviewed-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> ---
> The conflict is in 7411055db5ce ("btrfs: handle chunk tree lookup error
> in btrfs_relocate_sys_chunks()") but that no longer cleanly applies
> after the backport of 7411055db5ce ("btrfs: handle chunk tree lookup
> error in btrfs_relocate_sys_chunks()"); it's probably simpler to just
> use the old mutex name directly.
> 
> This commit applies and builds on 4.19.313, 5.4.275 and 5.10.216

Now queued up, thanks.

greg k-h

