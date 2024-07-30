Return-Path: <stable+bounces-62641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16949408DF
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 08:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58A55B22C70
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 06:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0720115B542;
	Tue, 30 Jul 2024 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SWEUQXje"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4F41494B5
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 06:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722322240; cv=none; b=Hb09j05b5VMAI8xLcaF2mPB/+r1eqyU+7AsJ4Gy4O66oemG1EFIml/m/QzmS8+AUbLvjCyj4SLNfyKqODQv+GEj8SSYJu/dgoQxbC75Awcae7vwLzbfvjzB/3Qp1+y6EcrXZ1a7Lx2EpyCNhy6wfk8dISS5+ZVIJwH46PieTpNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722322240; c=relaxed/simple;
	bh=2gdm028FXj6u7d5pCIoCaxkyQNJ3kKpwLHj0UJ7bVh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cj77mUNRbGMl/he0VKhYrEEaL0o7eGDmyEyCddmEsIJ6asBF5oPebfNiWYGsP29JgfsXHcfUYGNw1UhYQrmgPPRx1v2pVMCWBYKMNyBqX+IZke9rTDrv5OVg0av3lCbnpTTUeZH03TLhGUEMTy0c81MhHFg9OVAWcYsdo4v7Oec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SWEUQXje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DE2C32782;
	Tue, 30 Jul 2024 06:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722322240;
	bh=2gdm028FXj6u7d5pCIoCaxkyQNJ3kKpwLHj0UJ7bVh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SWEUQXjeAftkyt6nz4ceblCQwWSwHyIe4whHO94jC6AtaxnAQOjKKbUkz+r9OfFJa
	 lwjxaYIXw8LaPeU+jnTr6o8gBQylBmGNy4CWHscd4AGg0LcJo5wtl+krhshq523hd+
	 Qq58y9/aW2zG/UKB2nK0iaUMLFyTGkDQUqJATDbA=
Date: Tue, 30 Jul 2024 08:50:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexey Kuznetsov <kuznetsov.alexey@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: asus_wmi: Unknown key code 0xcf
Message-ID: <2024073006-padded-fraternal-e82a@gregkh>
References: <8cd6293f66f9399a859330a348c79fa3dacb0202.camel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cd6293f66f9399a859330a348c79fa3dacb0202.camel@gmail.com>

On Tue, Jul 30, 2024 at 09:36:13AM +0300, Alexey Kuznetsov wrote:
> Hello!
> 
> My Asus Laptop (ASUS VivoBook PRO 15 OLED M3500QA-L1072) reporting this
> wmi code everytime I connect power cable.
> 
> I got no key code on power disconnect.
> 
> [11238.502716] asus_wmi: Unknown key code 0xcf
> 

Please report this to the correct mailing list (the input list), stable
is not where this can be resolved, sorry.

greg k-h

