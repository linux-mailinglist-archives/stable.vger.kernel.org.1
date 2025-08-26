Return-Path: <stable+bounces-172933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4F5B359AE
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCD01B68346
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 10:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F04C31AF20;
	Tue, 26 Aug 2025 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vp9KK4Bm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93EA2F3C1E;
	Tue, 26 Aug 2025 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202375; cv=none; b=prBhP40Gfrtliki3oB0P9XW08V+zk3oW4XKQNSyxwfqynOwxwQHGASvzd3bVpALnzs6lgiiBD/LY23SKYOPF/8i9QZeUKThkuodnwZXf17e5pBs51Jb4qjriNERusctZzM6xWHZzJYWIbP10NDfL2Ng39EDB/2y03DJ4kq5wzLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202375; c=relaxed/simple;
	bh=ft+j/BZCOwUuq0W5WLsFa2upMAkDXScJjIENKY3BDSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIL5ZynkVwBmlv5XX2t25KWfSMdIHI/h6psz/WEbt/oFkroTWH4ZzYLgAuNtECybf7JhAqe6gQ6sTMsGQP4iOgbd2ESgLtxJoeGKRx6gvU/6JQHu+OHZaOCGKyrJFLe7YSOe0OuT0JffRG6lj4K1lWXKwr6u8v8FrufGStpm34M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vp9KK4Bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D824C4CEF1;
	Tue, 26 Aug 2025 09:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756202374;
	bh=ft+j/BZCOwUuq0W5WLsFa2upMAkDXScJjIENKY3BDSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vp9KK4BmGKqCmvCWycDbopZgIj5304UjSTsj42iTAW+wpf6fgQuBBMBN1jfKmQPUn
	 n9yqn2YCfSbfzi/zSuAr9TcHH/WmZjTlavVNDIv38psTLHaHvaz3cbqD8L++D1J8Yr
	 Y1DCsF1UFBorHsgstX9C11lsOpmQeSFonbNU6oSXQmQlejygG5qyWPceixdgemoS2Q
	 iszxtTGeoppaEsfx4nHK/evJrW4t8QLJxtRsJf6mYCroJ8Kq+X2K9hOa+ZH6L339qj
	 7cwpzfU2Thp0brypOR/r7aQvsFo5CAmrRn+e6WMnDGtuAYdqsRZYIyXWBaRbSct2Za
	 DVfnchx111eTA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uqqSY-000000000mF-34tY;
	Tue, 26 Aug 2025 11:59:23 +0200
Date: Tue, 26 Aug 2025 11:59:22 +0200
From: Johan Hovold <johan@kernel.org>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Telit Cinterion LE910C4-WWX new
 compositions
Message-ID: <aK2FeoHi-lBs5ASj@hovoldconsulting.com>
References: <20250822090839.39443-1-Fabio.Porcedda@telit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822090839.39443-1-Fabio.Porcedda@telit.com>

On Fri, Aug 22, 2025 at 11:08:39AM +0200, Fabio Porcedda wrote:
> From: Fabio Porcedda <fabio.porcedda@gmail.com>
> 
> Add the following Telit Cinterion LE910C4-WWX new compositions:
 
> Cc: stable@vger.kernel.org
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>

Applied, thanks.

Johan

