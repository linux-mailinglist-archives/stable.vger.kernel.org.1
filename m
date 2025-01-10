Return-Path: <stable+bounces-108209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D97A097DE
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 17:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA3F27A3ABE
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 16:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3F32135B4;
	Fri, 10 Jan 2025 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fc98Rz6n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4115F212D6E;
	Fri, 10 Jan 2025 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527861; cv=none; b=alPxPj6WLqBVKbPHT/1SOM8d+ZJmdykSDXDo3NNNfWZEhiC2UkU3MiRz8RHRsY9cj837M7mdITL88rR+6fUbOyJah45bOMporsKQLj/n6QKsoCrrEy19hc4RTjWEKQEwdaE9DAviNb5kWt/xjH7P+cuVUZZ+iy4IEc6/95gX+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527861; c=relaxed/simple;
	bh=E5EtxMeyWUUCs8tTLOFLUz2X93/43HeEReam767DSIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSatdWFl+LzHQRc6qf/GGKPGqNcLu2x03P3uSZ2+hHx7KM1nmsgq0uyacb0/AVtk8q2E4En4OFvB3bXI5pK88aUgcnmQdE2PDgQgMqSJiof7m6kMduaqFo4nDjJZhRct0qdtJjGyhGHj/ZfNniby0Sh8/ioa0SMb9/vdkWzbQ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fc98Rz6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F2AC4CED6;
	Fri, 10 Jan 2025 16:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736527860;
	bh=E5EtxMeyWUUCs8tTLOFLUz2X93/43HeEReam767DSIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fc98Rz6ntxow0a2CAtsMRPtAgSXIHcLiF1M61ZKF+95kudGEkGWYshcSYarcsEEzG
	 56ovRgn2HyLMk+KsQ+D1j78pQw81VQUw0iRg6ONUFns1yxD/9WZP+HyeCtdqT0PMKE
	 K+KBg9n6eqBwBGOw0a5TRrEdJEG9w/JsB5PtFAR3qiccnkyBVEMe5sUhHsrOwPCKtU
	 pY+YZhXlPlc5QquQ0J5OGa9cTcLJtcYUbVRpGG5egeVIQHS1EERv3spOghasLbL5OO
	 Q08/tdcJyheZniR53/EGzuSb3nQv2KGl0QY69rtmBRauTY3HEbZxfDgxtFEG/ivUEh
	 bZCIVE6Z8QFsA==
Date: Fri, 10 Jan 2025 08:50:57 -0800
From: Kees Cook <kees@kernel.org>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jann Horn <jannh@google.com>,
	Hanno =?iso-8859-1?Q?B=F6ck?= <hanno@hboeck.de>,
	Jiri Slaby <jirislaby@kernel.org>, linux-hardening@vger.kernel.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] tty: Permit some TIOCL_SETSEL modes without
 CAP_SYS_ADMIN
Message-ID: <202501100850.5E4D0A5@keescook>
References: <Z2ahOy7XaflrfCMw@google.com>
 <20250110142122.1013222-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250110142122.1013222-1-gnoack@google.com>

On Fri, Jan 10, 2025 at 02:21:22PM +0000, Günther Noack wrote:
> With this, processes without CAP_SYS_ADMIN are able to use TIOCLINUX with
> subcode TIOCL_SETSEL, in the selection modes TIOCL_SETPOINTER,
> TIOCL_SELCLEAR and TIOCL_SELMOUSEREPORT.
> 
> TIOCL_SETSEL was previously changed to require CAP_SYS_ADMIN, as this IOCTL
> let callers change the selection buffer and could be used to simulate
> keypresses.  These three TIOCL_SETSEL selection modes, however, are safe to
> use, as they do not modify the selection buffer.
> 
> This fixes a mouse support regression that affected Emacs (invisible mouse
> cursor).
> 
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/ee3ec63269b43b34e1c90dd8c9743bf8@finder.org
> Fixes: 8d1b43f6a6df ("tty: Restrict access to TIOCLINUX' copy-and-paste subcommands")
> Signed-off-by: Günther Noack <gnoack@google.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

