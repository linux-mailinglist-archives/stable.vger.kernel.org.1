Return-Path: <stable+bounces-57947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BFC926472
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 17:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCE51F21FF8
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 15:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56372180A94;
	Wed,  3 Jul 2024 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p58rk8sw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC3C180A64;
	Wed,  3 Jul 2024 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019413; cv=none; b=jOeEJjWLhgrPKTjboj0quz3BmLaeujneAj9PQT/trillDjRULpGkJ4JZ8auZlpV3YmG7ovOcuPH0k3bi49j1F3lkV2opePNCC7trv0I2XidjcaN8E3TcxsEwpTweSMvoV6CRCwMm7cec/ojIXxBmqW6dloVihXy8HJJqnN1+eWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019413; c=relaxed/simple;
	bh=8fLf5saJRRvwzPYwzm3t4nhdxaXW8budd0rLUeJYNfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNrLJfTEE0mW27C/9+UcnPHkuf2qjnWRjIzU62z/i8aTn8tZiwyoIelMppz13xTM203qnqaA8FkV5Z2Bh6VlELU5NJgx38aBDsqbOdcto73J1XZWnz8SkrXbx17kivQu6sPITHCxQj1lRzMEap/9s9UZeMvK43D60qr6wz26rFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p58rk8sw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5FAC4AF0C;
	Wed,  3 Jul 2024 15:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720019412;
	bh=8fLf5saJRRvwzPYwzm3t4nhdxaXW8budd0rLUeJYNfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p58rk8swixnthiPBPiCb3f1y/SBWnQBaZlg9xHhtZ24NfKUZH4XLfIKVUYZOsqhV1
	 jrEStna4xS/WqMKpQLFvHJB9Nt8SWg9dfcjJ/LKtpESJNJQ5omGCl3s4CeVT3NMtKB
	 GHEoDZdS5SYtpJ4ZUsdpGKw7HBORcVoIUhBT76MmgRrqHjSPL3fkglGeDbXG0wXiJg
	 Z6MP1oAxEuYPnNkbU/kqfoXOJtB7BF8UuD61EhOINs8U3MSoCQu+L24Uoml4LKioO0
	 HTEKuUdY78TyhVeFJqN5XRGIuUBbd6NaBwXVlpwxOtkU04w8qu5Pm9fF9SoZelJANY
	 7oMiXSK0rdZWw==
Date: Wed, 3 Jul 2024 16:10:08 +0100
From: Simon Horman <horms@kernel.org>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH iwl-net v1 3/4] igc: Remove unused qbv_count
Message-ID: <20240703151008.GP598357@kernel.org>
References: <20240702040926.3327530-1-faizal.abdul.rahim@linux.intel.com>
 <20240702040926.3327530-4-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702040926.3327530-4-faizal.abdul.rahim@linux.intel.com>

On Tue, Jul 02, 2024 at 12:09:25AM -0400, Faizal Rahim wrote:
> Removing qbv_count which is now obsolete after these 2 patches:
> "igc: Fix reset adapter logics when tx mode change"
> "igc: Fix qbv_config_change_errors logics"
> 
> The variable qbv_count serves to indicate whether Taprio is active or if
> the tx mode is in TSN (IGC_TQAVCTRL_TRANSMIT_MODE_TSN). This is due to its
> unconditional increment within igc_tsn_enable_offload(), which both runs
> Taprio and sets the tx mode to TSN.
> 
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

Hi Faizal,

This change looks good to me.
However, it seems more appropriate as a clean-up for iwl-next
once the previous to patches make it there via iwl-net.

That notwithstanding,

Reviewed-by: Simon Horman <horms@kernel.org>

...

