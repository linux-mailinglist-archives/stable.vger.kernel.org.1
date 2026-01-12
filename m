Return-Path: <stable+bounces-208106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C3DD12142
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 11:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 495643069A7E
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80DB34F257;
	Mon, 12 Jan 2026 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wx9jFbXZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F79334F476;
	Mon, 12 Jan 2026 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768215245; cv=none; b=kppgOfSdSYoZMAeY6yVlf67irS8xRx64auezJYS4lVI5FuBZi1CmzsgjOkr0mNg7ys00kc9qCBH3v7FxqwTdOGg9dZ7PB+3gngqxIuuYH1qELexfDRGziFjsnl5QNhuAD2aYJlApRkaOrB2wdOBLYpHHuBKnn+HGQjAcDnVhG54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768215245; c=relaxed/simple;
	bh=sRevZ+3iQD7XJxY4cvxc5Xq5k3GUWTihPCQW7TVAZj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzAD6+05olcHYi3gLvNGME+8KoK3bTU1HLTFFRKd1eqPITj3TIucT4JJF6Egq/9L6xMYzVpbmLqnw1SMLC4JcyHq5saKB1XwQaSSFO9isQyJgWU+YmKGd8DUPFJXfb5leWB8l3DjqnXl4AkAAEG/g2u0dRRZWE6PLtUVj15VFjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wx9jFbXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D443EC19421;
	Mon, 12 Jan 2026 10:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768215245;
	bh=sRevZ+3iQD7XJxY4cvxc5Xq5k3GUWTihPCQW7TVAZj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wx9jFbXZR9xXr4y1VYRteDOpetxxqjJXAMTqJisPAjigi9KqNImOpd6lca9O8fp6z
	 kkJCqhTZjII6smauU39KwF/qGMH2GfQo14x9cMq61Xq+DO1n4yvtpnhqwYMBLSdsDK
	 Aw4hCdvpDg/ncfAy2qDZk3Tz+RiCH6XQYTEgf7LA=
Date: Mon, 12 Jan 2026 11:51:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rahul Sharma <black.hawk@163.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zqiang <qiang.zhang@linux.dev>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2 v6.12] usbnet: Fix using smp_processor_id() in
 preemptible code warnings
Message-ID: <2026011236-chill-unpleased-9f58@gregkh>
References: <20260112030008.2439120-1-black.hawk@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112030008.2439120-1-black.hawk@163.com>

On Mon, Jan 12, 2026 at 11:00:08AM +0800, Rahul Sharma wrote:
> From: Zqiang <qiang.zhang@linux.dev>
> 
> [ Upstream commit 327cd4b68b4398b6c24f10eb2b2533ffbfc10185 ]
> 
> Syzbot reported the following warning:

Already in the 6.12.64 release, thanks!

greg k-h

