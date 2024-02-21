Return-Path: <stable+bounces-23219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B23DA85E54B
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 19:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42685B219E1
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 18:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCC784FD8;
	Wed, 21 Feb 2024 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdXL1d2+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF30F8004E;
	Wed, 21 Feb 2024 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539152; cv=none; b=amDDTe6DOKvH+U4+5i73N/W4VWnZ/yQIejO/Lc3hHOKuGysCa0JkTzdZpKL9KYhS4MUGR+BsRhOW15mZxWwUVCSs42ZXgK5sqxQSqClLseSf/Qj3SENWAHNdXyAJBRjORP7zs7IMasKuRlaLIJcEn2NTIkCrQ53P0UkyjqD51iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539152; c=relaxed/simple;
	bh=PzLiycT+1h/MMGR0MF1SXY4d8fpd7bI7QzCYFG7wdXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttucmD/w8HLUo5ylztfA0ctGFhwCgvu7th+XUc5B2H0ev5duRX+wxNv3fwJ6j+WICAaR+hNXHUxhh6BkZYvE/MCfK0t7QVvO4vW9N7HQjN0x4XeB5oYc53BtdSSDe3FCjEuMIr16g0frgDF7xsdliXqdqmeYGXEsUfWVtUBHNPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdXL1d2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A81FC433C7;
	Wed, 21 Feb 2024 18:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708539152;
	bh=PzLiycT+1h/MMGR0MF1SXY4d8fpd7bI7QzCYFG7wdXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HdXL1d2+/6TxUaWMrYhFnVm+/7z7MWtRYFxKFxwyKm+AupC1wFHK1xrT524d83Om2
	 YcDMaSBivvKGEvxaqPFXfKgTnvoYCyA3bh5B4BLLYs46/WMIxrsJhkY3j7ndG6OXc5
	 VnAHnXAiWspYkMT9srHcfBWtLX9uP7aNRmGIq4LCY8hJgm1QTLDqkLsIYpxrXvQY7j
	 cpAFDRthC1S5C6CIdBbmuiGKvF7uZYWovgFd+bbWlJBn9qFuB6FWLEVP7wziY4I49o
	 r4cm/YLcYmNQuiaMS9PmifMHNLOqkmZIMRHFIcmE5yZuYsFfzW6S0Cw9nNeotGBYbn
	 jBGyno5toEmrg==
Date: Wed, 21 Feb 2024 19:12:27 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: stable@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ata: libata-core: Do not call
 ata_dev_power_set_standby() twice
Message-ID: <ZdY9C59M0aPDtj8C@fedora>
References: <20240219154431.1294581-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219154431.1294581-1-cassel@kernel.org>

On Mon, Feb 19, 2024 at 04:44:30PM +0100, Niklas Cassel wrote:
> From: Damien Le Moal <dlemoal@kernel.org>
> 
> For regular system shutdown, ata_dev_power_set_standby() will be
> executed twice: once the scsi device is removed and another when
> ata_pci_shutdown_one() executes and EH completes unloading the devices.
> 
> Make the second call to ata_dev_power_set_standby() do nothing by using
> ata_dev_power_is_active() and return if the device is already in
> standby.
> 
> Fixes: 2da4c5e24e86 ("ata: libata-core: Improve ata_dev_power_set_active()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---

Applied:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-6.8-fixes

