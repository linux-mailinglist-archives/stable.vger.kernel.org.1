Return-Path: <stable+bounces-95953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC569DFDCA
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 10:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B4D163E7F
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 09:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592061FC7FA;
	Mon,  2 Dec 2024 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CL6uyUZb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A8B1FC7FC
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133018; cv=none; b=Jg9chCzqwbua9/n9b0mOpuq71r69Eselc4LL2FO3SNSN6GBgGh4e2NspttmoUGvxlO5CNVKG4ZHQuSgQqtl/G30sB7ozO20VVtfccFamODkuOy7MJI+FEhsRE9Wag2EVJfqvs4rhVrXdZpoRmz+0wSlJ9gfNC7jS+R89VkhXghM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133018; c=relaxed/simple;
	bh=7bBMPz9RLZ8ESghJcaNOX6dnNrMlSOi63u6NQIop8O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PS6r5kRgWY+SSuUsYG7Yl06+PjfSDjpdnPvDNMJkrNW56YpEyZ1uJCLUzOgPo3elmf9M14beHIpigfZYug3ohPgaqNzuh2dQo/+/Q/8XiW/oehiKQxvoXSP/1z2HO4Ifn1v/13H8qsqzQHchaA9VOiJK1S38MbrccfSg4okzJ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CL6uyUZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181CFC4CED2;
	Mon,  2 Dec 2024 09:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733133017;
	bh=7bBMPz9RLZ8ESghJcaNOX6dnNrMlSOi63u6NQIop8O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CL6uyUZbIJ8f/7rKvbqzX/2nmHQCaZum4cV6PDnaMlUTY7lyAYPfIifWPA1eaj1jp
	 hXW3KlCK82sgzvo9dIe7Mc2Yit7eekFrjMEQP9L6Mfv010EGTTVRBJXOzPKB+K0oQm
	 mB2tmS9q49Eq62s3bFuxBxrN5NwO9mygPtxYtDu0=
Date: Mon, 2 Dec 2024 10:50:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: stable@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>
Subject: Re: [PATCH 6.11 27/31] drm/xe/display: Do not suspend resume dp mst
 during runtime
Message-ID: <2024120222-mammal-quizzical-087f@gregkh>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
 <20241122210719.213373-28-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122210719.213373-28-lucas.demarchi@intel.com>

On Fri, Nov 22, 2024 at 01:07:15PM -0800, Lucas De Marchi wrote:
> From: Suraj Kandpal <suraj.kandpal@intel.com>
> 
> commit 47382485baa781b68622d94faa3473c9a235f23e upstream.

But this is not in 6.12, so why apply it only to 6.11?

We can't take patches for only one stable branch, so please fix this
series up for 6.12.y as well, and then we can consider it for 6.11.y.

Also note that 6.11.y will only be alive for maybe one more week...

thanks,

greg k-h

