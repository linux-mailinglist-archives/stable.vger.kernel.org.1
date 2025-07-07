Return-Path: <stable+bounces-160349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6D6AFAF12
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 11:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8451767A8
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 09:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAE728A1F9;
	Mon,  7 Jul 2025 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwuIO+Mi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CBB19F421;
	Mon,  7 Jul 2025 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751878869; cv=none; b=nMQKtD01x75iDfakbboxgsK3QwMbYcEm0yRbOOh/z0HnuZtEKdaWdbbNKYg+zSpPP4MMQMv9qx7Omb5JWqTmOVdPaSyF9ecCTeHhgSaKGHi3eKXkEqMIoTM+56fnh0/EBECDsRhze9xyIG/KYjFlJ4sdffZWRX7oKfhxredyzBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751878869; c=relaxed/simple;
	bh=24gyF1taVTxprKDEd+rLNk+GtDDxWmbXhwmk849/WWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8fzZBSHiXldhH4SIrTwq6C41qhv3uAH54OCiqZMT9YJEWaApn/F/Dcr6h3WdnTCUcionsgtlBqYynnbzRG9hbEhDrFXwg4EQchDZNjXFP0pQCB+dREDpJ+9K9E2j1biRN5tEA5lmVGW8+vYcf2t6HIRXlPgAoA7lFSkwe9e90Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwuIO+Mi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A0AC4CEE3;
	Mon,  7 Jul 2025 09:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751878869;
	bh=24gyF1taVTxprKDEd+rLNk+GtDDxWmbXhwmk849/WWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cwuIO+MiSF26xvbooegOGFArbkFQbJeMsk1yK4RPMXoLyRDKVgFGsod9UHyUoiJlm
	 mgweD/93f6A+xjoYBX8uTrg225ptbSCuzwSXViwV7ZWFrMnKFk/y9Hh0HOa2MdyL3T
	 0VAXkNAJIBLEjY6DmMRE7GS0ZUQsF8P8FuvVXFR0s7taBMmHxLD+mZtb/9CSULctf2
	 C9XOsddfAPrDx5PObrvCF+DuVpUUn56lMyNT/XVx3MEYHT0Pk2aGzDwmDIdCR7/lc9
	 9jPaxE4TD4r5JkdOdwh9brdRrSv6CfnT1LCdLujxnJ2v92CeM5q1D2RfXjuiS9fljv
	 w6gPVmTb0XxTQ==
Date: Mon, 7 Jul 2025 10:01:04 +0100
From: Simon Horman <horms@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v2] ice: Fix a null pointer dereference in
 ice_copy_and_init_pkg()
Message-ID: <20250707090104.GB89747@horms.kernel.org>
References: <20250703095232.2539006-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703095232.2539006-1-haoxiang_li2024@163.com>

On Thu, Jul 03, 2025 at 05:52:32PM +0800, Haoxiang Li wrote:
> Add check for the return value of devm_kmemdup()
> to prevent potential null pointer dereference.
> 
> Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization (DDP) download")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> Changes in v2:
> - modify the Fixes commit number. Thanks, Michal!

Reviewed-by: Simon Horman <horms@kernel.org>


