Return-Path: <stable+bounces-132822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F41EBA8AE9A
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 05:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BA44414BE
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 03:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016F91FCFE2;
	Wed, 16 Apr 2025 03:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajCYtk6P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E3315B543;
	Wed, 16 Apr 2025 03:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744775230; cv=none; b=jSkFumfJWnyuj/ab6449UsFZtp1/G16FWopGtG7OWaP/yz5MZf8KyccQCKbeGuZvY4VhMwZHKYQnmydj2QkSHBW+8sxWfbcSk89wwaNyE8DCPPPZBmNujkdX7tivyO/gyYv+LBgcb9fk1ifWJ0q54vV/XTfFa5NLtPke8KT3sXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744775230; c=relaxed/simple;
	bh=mUjUk9HaVhPnl5rig69nbaVVP2JnNmkWbsOwSLuVeBs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nfqmt9RAU5YknZaRKbnogi0+NkbQB2kYA5gBYzOk2u8t7Zl/dfJ6ER7pmYI62akYJBUHG8qXTzIAqlVidibLscLupWjk6sf3pXzoAgaPfiKz2ZqqqpLcTF+af/PCWRefMA4FOJ4gyADC7ghiuC/dKzAVvnuzd3nkpfTio0ESvbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajCYtk6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D07C4CEE2;
	Wed, 16 Apr 2025 03:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744775230;
	bh=mUjUk9HaVhPnl5rig69nbaVVP2JnNmkWbsOwSLuVeBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ajCYtk6PGXPyjLXjQqw+udtMlkBVKble6Y1pU1dWxgxktzLX28cei/l5fymtk2rZY
	 qtujj/DGZ0Kiz/lq5BdVhi7aVIwfFHkYFOl+5+tUyjzfnbKqzEJ3m3h8qXshndveM0
	 RZTJ4DpzWMJUSb1XV3zzxmlAVZDv/Qt6L4npsJRSuDSiDkq8thAPgrsL5nY5wFmje/
	 cSQ5G8oCYF3pVXdkwUwVtVNdk3i3zR9qbyAbPZ9KjiROWOQofdyowJETjMwgUjpCb7
	 JPyQsb5SikEu3VhoTbNfqbH7FSn+eNBf9tkkdGv6WvpVbUV9UWVMVD4v9sv0u2MwpC
	 izGwYT0ZPBJkw==
Date: Tue, 15 Apr 2025 20:47:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com,
 stable@vger.kernel.org
Subject: Re: [PATCH 4/5] net: ch9200: add missing error handling in
 ch9200_bind()
Message-ID: <20250415204708.13dc3156@kernel.org>
In-Reply-To: <20250412183829.41342-5-qasdev00@gmail.com>
References: <20250412183829.41342-1-qasdev00@gmail.com>
	<20250412183829.41342-5-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Apr 2025 19:38:28 +0100 Qasim Ijaz wrote:
>  	retval = usbnet_get_endpoints(dev, intf);
> -	if (retval)
> +	if (retval < 0)
>  		return retval;

This change is unnecessary ? Commit message speaks of control_write(),
this is usbnet_get_endpoints().

