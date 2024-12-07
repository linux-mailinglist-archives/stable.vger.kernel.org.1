Return-Path: <stable+bounces-100034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935939E7E90
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 07:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8241E16A5D6
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 06:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB6C6E2BE;
	Sat,  7 Dec 2024 06:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gg+kK+aK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B1E360;
	Sat,  7 Dec 2024 06:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733553116; cv=none; b=ocL3teCiYBfpIM8YTPrK8P43WxautTpEAmbEL/9JsdWZ1t6v5hjNxcT14ytUX/Iy+sNzLfym59gvdetVTkdpaNQMLrqXu1QcgIDGBtLGasYwo4ned1dZvKcbGBcEhrRIWa3UMRut0IWngyN4dpJtptIvrkoF2/7GZsJoShHZ7XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733553116; c=relaxed/simple;
	bh=WX70jKtqu3HbtTsSfomRJ8WtD4pmoAPdhIae74hdd5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcEvepGzJR8y9LlGZ/qT0EXsgu7zv/kpEl1dLd/E0vSSR8VyurY838yH57BwWb5pKdtEfwqhIkXKB3nnATXhX+HxoQMHkUh7oK/CDRXLnd846fax3aEqP5xY+OFzdeUXGkq6bYGUnEBbZ7Ox+KSwELVZMEgOGQEcmt/sk+N1984=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gg+kK+aK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50404C4CECD;
	Sat,  7 Dec 2024 06:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733553115;
	bh=WX70jKtqu3HbtTsSfomRJ8WtD4pmoAPdhIae74hdd5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gg+kK+aKrsElWLcF2UvV70Y29Bvj0C7WMKcHzfGojr+gwEyM8G08QzByitFUntH0b
	 fTYIY5mDqfPKOGwOs4UuxzMqqlRiFdeNbfmpcssrdworiNrzAEdFHT0OBl6POwnl0v
	 HBEFVZw/wjZ4VIBNykYAKe8tfH5206AfS308UugM=
Date: Sat, 7 Dec 2024 07:31:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hui Wang <hui.wang@canonical.com>
Cc: stable@vger.kernel.org, linux-serial@vger.kernel.org,
	hvilleneuve@dimonoff.com
Subject: Re: [stable-kernel-only][5.15.y][5.10.y][PATCH] serial: sc16is7xx:
 the reg needs to shift in regmap_noinc
Message-ID: <2024120740-violet-breath-763f@gregkh>
References: <20241207001225.203262-1-hui.wang@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207001225.203262-1-hui.wang@canonical.com>

On Sat, Dec 07, 2024 at 08:12:25AM +0800, Hui Wang wrote:
> Recently we found the fifo_read() and fifo_write() are broken in our
> 5.15 and 5.4 kernels after cherry-pick the commit e635f652696e
> ("serial: sc16is7xx: convert from _raw_ to _noinc_ regmap functions
> for FIFO"), that is because the reg needs to shift if we don't
> cherry-pick a prerequiste commit 3837a0379533 ("serial: sc16is7xx:
> improve regmap debugfs by using one regmap per port").
> 
> Here fix it by shifting the reg as regmap_volatile() does.
> 
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Why not take the proper upstream commit instead?


