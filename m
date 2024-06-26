Return-Path: <stable+bounces-55863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C24918A03
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 19:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8FC1C23013
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 17:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AF518FDC3;
	Wed, 26 Jun 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/qi2/Gq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857CA18EFC7;
	Wed, 26 Jun 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719422603; cv=none; b=Abf8Z7J+ive5wGvT/b8c30JAJP3XaJwUwfUO2UdbaI+MyylWj0HtAYsjDMSyGDYYh/C2zUkfAG+QnACLo95FjHj6h71aFwReIQ6zBObJrkCrrjxDkL8pdmWVA40rYAtjgbBEpBIdlRdtERCZcEWo6P6dDa0X85KgkGOVzZiOVbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719422603; c=relaxed/simple;
	bh=kxM1rzXSM3apA5h4Q/eu9A9wQfIY40O7JKkfcPhJV3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjWzlIL4/v0EkZytLKMwaLRsSXgXD3dtmvSVYdzD7UmEnrHKxsY1rYhxjAsGAHvDlOZ4VyEvgSEkpMtSNZJfu097tmi7n1cEVmBaVJV3iLtCyd8t3Q27eAm0D7FC/rcF+K7ZoTNXuCZB9Tnu8/dSyFXm3t4DrN6RAyg6y6YdkLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/qi2/Gq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD26C116B1;
	Wed, 26 Jun 2024 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719422603;
	bh=kxM1rzXSM3apA5h4Q/eu9A9wQfIY40O7JKkfcPhJV3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d/qi2/GqYvcuAcBQtiC6zuLgWhZKJiytzdol82KuxYy9UKwG6b0VgbI4xZnJoZFcE
	 btj9JT7Go8wkvARY4ep5ysQvPs296jULQmv4EFJxszCIuws7HFVwqz1uSpKDV8NtyY
	 QKS5/yOEfWKMpBlHV/3t7wQb1QUhqU5ApTlkv/AhKh/6bvKmohmYI1whN22yveVLzZ
	 0vD7p/+/nUycern/GYGtbPGWLHAhX4qs4PWKe+3vsGAVQ/cmzzrVQOwyp9kcUTmBiQ
	 yZ+AAghWqTJvYQNm1bnVptZUksToM77LsQzmhLhrZRrwPR5q6kGZKG17b51w++RgwV
	 tDKHbXkn7C1pQ==
Date: Wed, 26 Jun 2024 10:23:20 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-fc: Remove __counted_by from
 nvmet_fc_tgt_queue.fod[]
Message-ID: <20240626172320.GB50752@fedora-macbook-air-m2>
References: <20240529-drop-counted-by-fod-nvmet-fc-tgt-queue-v1-1-286adbc25943@kernel.org>
 <20240626170605.GA66745@fedora-macbook-air-m2>
 <ZnxNnFxTQCcPWhQM@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnxNnFxTQCcPWhQM@kbusch-mbp.dhcp.thefacebook.com>

On Wed, Jun 26, 2024 at 11:19:24AM -0600, Keith Busch wrote:
> On Wed, Jun 26, 2024 at 10:06:05AM -0700, Nathan Chancellor wrote:
> > Ping? This is still relevant and I don't think this is a compiler bug
> > that would justify withholding this change.
> 
> Sorry, I misunderstood the discussion to "wait" on this. Queued up in
> nvme-6.10 now.

No worries, thanks a lot for the quick response!

Cheers,
Nathan

