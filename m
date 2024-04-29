Return-Path: <stable+bounces-41675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF11F8B56E8
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8D4283227
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D513D961;
	Mon, 29 Apr 2024 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dj8UibF5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2671C200D5
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390650; cv=none; b=evMOVEYvTGvK3sf6tak5Ey2gBMgITP8zZ97YIaV37iTXVY7kEESFAAszruCY65jNCv0iX80fgWoCxCh6/+W5WFJP1foQxlRJjQSHJVFKhd/cR/Gq03TcslGCNcGLD8wZiSV+3W0FwSasdadstZkC8/so+arFvYRJFgspsuYhPhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390650; c=relaxed/simple;
	bh=HHi0Txo2nZnVidAmbzPaVjo33YWorfF2PJp8omzU9ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awlpS90D1owf7EZc1nr+0SXo5AINYF2VpABFmqcByCyKnGWY8UDgzXF+8AXCr5xQvC92+GKEh+l+AqM00CaSxzmCLBQvwhnd+MATpsWfynCmnz41aSd+eML6z9Q+lOYAAGiJjZXfZ5ebL0jgynpz8jyDzFsHVRfgD0TMtibyyy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dj8UibF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37196C113CD;
	Mon, 29 Apr 2024 11:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714390650;
	bh=HHi0Txo2nZnVidAmbzPaVjo33YWorfF2PJp8omzU9ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dj8UibF5Mohg3i9v+d6yUSgsOkUknKVC2xjLzVG5CmHL1owHsuAux6fvRShR9K+6i
	 SCxIUyVrHNvqazuG6usJwPBIgRoSpTD4jNUSGesTZ6ZTa10bGyOIBErMTAvv70za2t
	 7V0c6MWPnYLeKaKYThT4NeNHKeH00lMoH+C5yBBw=
Date: Mon, 29 Apr 2024 13:37:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: ojeda@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
	gary@garyguo.net, julian.stecklina@cyberus-technology.de,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] kbuild: rust: force `alloc` extern to
 allow "empty" Rust" failed to apply to 6.1-stable tree
Message-ID: <2024042901-wired-monsoon-010b@gregkh>
References: <2024042909-whimsical-drapery-40d1@gregkh>
 <CANiq72ndLzts-KzUv_22vHF0tYkPvROv=oG+KP2KhbCvHkn60g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72ndLzts-KzUv_22vHF0tYkPvROv=oG+KP2KhbCvHkn60g@mail.gmail.com>

On Mon, Apr 29, 2024 at 01:25:37PM +0200, Miguel Ojeda wrote:
> On Mon, Apr 29, 2024 at 1:21 PM <gregkh@linuxfoundation.org> wrote:
> >
> > The patch below does not apply to the 6.1-stable tree.
> 
> Yeah, this one was only intended for 6.6+:
> 
> > Cc: stable@vger.kernel.org # v6.6+
> 
> Was the annotation above incorrect?

That was, but you also say:
	Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
which is in 6.1, so what am I supposed to believe?

Hence the email :)

thanks,

greg k-h

