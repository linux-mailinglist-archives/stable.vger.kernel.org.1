Return-Path: <stable+bounces-110291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9248DA1A6C7
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 16:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376D4188A4F4
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 15:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A27212B38;
	Thu, 23 Jan 2025 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3VlQ0GN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74CA212B13;
	Thu, 23 Jan 2025 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737645123; cv=none; b=CnG7qDk7i/eUWhSjt9UcMRLnTGPzbOIsl7uuIazlBmBAgX2HZM1ESl8f197f+jP5tI/axj9mZTSCatW6/h5EALQwBxhdolc4eslItQzdZf+NERfdCOx5P/P/gU9yyxABIBEaqZ+gqgaAdcoAsFgkPKVxBftfUxgPLv2An4uwJ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737645123; c=relaxed/simple;
	bh=OAPyvyM2d8XjWR8/KefsHREi8FdRrr7wgZo8Qz5PqGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmluPuOhwHVSocuc/mKm77P1qzZilpUs3BUW1y6aHTdd9GKc1pegfnMTXN8LWydU6ERTLid3tYRLIK8D3ZLFtGD7/NEHc0RHKNQ/ZdLx1UN2j4srklltiwVDNmhhU1pL8rD2JnDc603E7lYy6YOIimzCItv3cY7ZwNaWcV4RLtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3VlQ0GN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6881C4CED3;
	Thu, 23 Jan 2025 15:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737645123;
	bh=OAPyvyM2d8XjWR8/KefsHREi8FdRrr7wgZo8Qz5PqGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W3VlQ0GNR8FI9zfUkwu/nWIkXA6ynIPFO5U7Ogly/+H1cWiYi5Q+sRvxZ0VWgfV/f
	 3m0lmBplCI1QXH+dRnXusUw7X/zomZICVOvJqWF2J0XxVhW4aAOowx3wZrbCj+gBpk
	 U7RfDII/xWjDJ9HWZhtjzRcADZwkEgzTB4vqSQht0Bnmruyt5/NCmoFkhlg1qbLtpb
	 QyRfgJ3nR54Pke9M4XZD1LzoVTO9ZPRo+8AZh/iLph12NjFecdbOA0Yvt8L9DRDdDQ
	 V/pgf0Fr0gTEG2rVQDDY+WsHifsPEWRmym6yCWri2vgIte8SCdYF5iA1+EJ0lB72H/
	 LWUhtVf//WNpQ==
Date: Thu, 23 Jan 2025 07:12:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gui-Dong Han <2045gemini@gmail.com>
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, horms@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] atm/fore200e: Fix possible data race in
 fore200e_open()
Message-ID: <20250123071201.3d38d8f6@kernel.org>
In-Reply-To: <20250122023745.584995-1-2045gemini@gmail.com>
References: <20250122023745.584995-1-2045gemini@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 02:37:45 +0000 Gui-Dong Han wrote:
> Protect access to fore200e->available_cell_rate with rate_mtx lock to
> prevent potential data race.
> 
> In this case, since the update depends on a prior read, a data race
> could lead to a wrong fore200e.available_cell_rate value.
> 
> The field fore200e.available_cell_rate is generally protected by the lock
> fore200e.rate_mtx when accessed. In all other read and write cases, this
> field is consistently protected by the lock, except for this case and
> during initialization.

Please describe the call paths which interact to cause the race.

