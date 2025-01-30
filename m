Return-Path: <stable+bounces-111267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB5DA22AA2
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 10:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD831887964
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 09:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F42B1A8415;
	Thu, 30 Jan 2025 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qWAsnHKx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB04118F2DD
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738230420; cv=none; b=W5VDREGZKKdqe/pO5P8DVJnU7bLx9xQ4w81axqW04a5uhT8UV8kwDOBW5eWZDTjnjx4lOzuUdfkNgsAJeKlZmECf7M75+2N1z2RUPzKQv8UYQLe3suYZWtQL0Ei4NcTg+Vyl1Pd523eFYq+PP49Jfttn4Nj+CknRa9kpLQ2X0os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738230420; c=relaxed/simple;
	bh=GMStrwcL7R1LNP4jJGW9WSvxAScuig1trqKtU8sFqXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDPQk8PZxFv3SvutqwzZ5TjxOVEbEgjCjfS22+D0b2qTtT6XtreFJMM4Mnmwnlaio91bm0DarwFjOIjX4NEulbOdYJup5lKxg+EFJepa8g4/G+BSQGzYYXN8gfuVgHJhvKbXvSywb5vPywvAzVAJ0MVMvh4jVouIGdy9AAf5M44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qWAsnHKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F46C4CED2;
	Thu, 30 Jan 2025 09:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738230419;
	bh=GMStrwcL7R1LNP4jJGW9WSvxAScuig1trqKtU8sFqXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWAsnHKxUkz8a4OdXAFZn47m3U2dpI053y4ZIOTnI8vAnWhI7FllOfXRuXaH/WrHA
	 9DGXf+VwF1dte1fM4XeLEZUmezEg0z5nr3CKMFJH+mSgUCY6Cfd+e0NhoeaZWdF6ff
	 dl7nS6A5xh7vN/idsMQcNTNd67J9wcbj6zHYwhvI=
Date: Thu, 30 Jan 2025 10:46:56 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: stable@vger.kernel.org, lvc-project@linuxtesting.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2 6.1] wifi: iwlwifi: add a few rate index validity
 checks
Message-ID: <2025013031-slit-claw-f9bb@gregkh>
References: <2025012949-unclasp-probation-a0df@gregkh>
 <20250129143230.2449278-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129143230.2449278-1-dmantipov@yandex.ru>

On Wed, Jan 29, 2025 at 05:32:30PM +0300, Dmitry Antipov wrote:
> From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
> 
> commit efbe8f81952fe469d38655744627d860879dcde8 upstream.
> 
> Validate index before access iwl_rate_mcs to keep rate->index
> inside the valid boundaries. Use MCS_0_INDEX if index is less
> than MCS_0_INDEX and MCS_9_INDEX if index is greater than
> MCS_9_INDEX.
> 
> Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> Link: https://lore.kernel.org/r/20230614123447.79f16b3aef32.If1137f894775d6d07b78cbf3a6163ffce6399507@changeid
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v2: (re)adjust copyright notice

You also fixed the grammer in the changelog!  Ugh, let me just go
backport these myself, please don't change things that you shouldn't
need to change...

greg k-h

