Return-Path: <stable+bounces-116337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 520DEA35037
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 22:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7FC716A9C5
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 21:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37B7269800;
	Thu, 13 Feb 2025 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJy2LAQb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC9266B73;
	Thu, 13 Feb 2025 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480858; cv=none; b=NFjJOjA2NQOk620kiTBoYhh6xGySKQEUJSH/XhW7df9yx6hhqAMjjlKJLBpEvqUQxdYY6NQBULBQQ3n7PINSbxmvQSzBWekhZMnlEVhSuj6MTTxfATEXwcp+6mZeNkgj8AzC2nnXQimMMhOKnea9mylupbJIZEYkcakh6HVEvVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480858; c=relaxed/simple;
	bh=TafgeYLB37luVrkS85uWHNNuJq8xdW6/RJc0El72wMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7PgkO0lKFV0vqyc0MAGIWaoqqq4s9XhpDDviDLHaoToXHDxOwXRzW8s0Hc4nN+jB6cOSTnNS+zsvMHshlAdOaDXskscXZ3RwkIOv3wAJosiY+z45wWv1SPqFP8HR7V4NzLLusp9yq+vYJFCDNnckJzzIB6OYdF2LP0bRHeLVhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJy2LAQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70487C4CED1;
	Thu, 13 Feb 2025 21:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739480857;
	bh=TafgeYLB37luVrkS85uWHNNuJq8xdW6/RJc0El72wMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJy2LAQbyodyu4wy4pWNS45Qz6mC4wZlLuVDkX94l3VbK8m3WsLD+ng4WmkaSSKBm
	 hJvS5qvDYTbN/RUdfEMgvr99IWFALh6UvqD7PtM2199k9Wn6HVID4iVT8HdPKCNi+2
	 PbVddaPCoS21/BjPrM2761cr6WFCiblmgok0i4TOB0WpkxVvytG0LkuMOH+RZ6prQz
	 SgJpJ1hvoqWcHG+ojLILZTgoZGHvSmkbRP2hDl2vwHBsMLC7CscdQW6y3ekmWSkdWp
	 I5fGf1HDEhnhTHTmFoDss1XGkTtmKBnhju4sPjvV1DoKGTOt2AlaOwRJW++QnKcDn9
	 guhXz42cDwq8g==
Date: Thu, 13 Feb 2025 21:07:33 +0000
From: Daniel Thompson <danielt@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Haoyu Li <lihaoyu499@gmail.com>, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	chenyuan0y@gmail.com, zichenxie0106@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] drivers: video: backlight: Fix NULL Pointer Dereference
 in backlight_device_register()
Message-ID: <Z65fFRKgqk-33HXI@aspen.lan>
References: <20250130145228.96679-1-lihaoyu499@gmail.com>
 <87ldun6u5o.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldun6u5o.fsf@intel.com>

On Mon, Feb 03, 2025 at 03:21:23PM +0200, Jani Nikula wrote:
> On Thu, 30 Jan 2025, Haoyu Li <lihaoyu499@gmail.com> wrote:
> > In the function "wled_probe", the "wled->name" is dynamically allocated
> > (wled_probe -> wled_configure -> devm_kasprintf), which is possible
> > to be null.
> >
> > In the call trace: wled_probe -> devm_backlight_device_register
> > -> backlight_device_register, this "name" variable is directly
> > dereferenced without checking. We add a null-check statement.
> >
> > Fixes: f86b77583d88 ("backlight: pm8941: Convert to using %pOFn instead of device_node.name")
> > Signed-off-by: Haoyu Li <lihaoyu499@gmail.com>
> > Cc: stable@vger.kernel.org
>
> IMO whoever allocates should be responsible for checking NULL instead of
> passing NULL around and expecting everyone check their input for NULL.

Agreed. This should be fixed in at callsites.


Daniel.

