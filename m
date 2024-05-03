Return-Path: <stable+bounces-43020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD068BB130
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 18:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2963FB22364
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 16:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B3E156F2B;
	Fri,  3 May 2024 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ugk+WlhV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25956156F25;
	Fri,  3 May 2024 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754818; cv=none; b=UJ1hKvm/pwz3DPnC89/w+sZFZq/SLldw0UEjWsFJ3iCuPNoMVnL4VSeJj0XxE+UuuqHgw5VHCXEAeIiiPpyUYEUzr+cEIMZ1ZZ/ecx/KHtETkzyc+kVWaRRDFUHFAHaqLhqUQeKnxXT3RhG0b3zaUs6/ZC3m/xclOtgg2rJ9VMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754818; c=relaxed/simple;
	bh=5xBH8qzvo1lkGnwNzi04D+WYbyb9vRqEeRE4/Ponzjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDrmMu9Qe93ItBNZTfcShhIJL6GIkfrdaFMguwco+6B/i3RZn4Ft4RHWs3sBq9X9woq7FjO3HNtGwRvZ3CCOqW6gqSaWfSnFLi3+hBqdHu03GwcbFIvTWkaN+vLQJqZg8d6AAnAdbfmTEQtb6rx7Pj6NorwBlLqSuSBCZs3iVNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ugk+WlhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C96C116B1;
	Fri,  3 May 2024 16:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714754818;
	bh=5xBH8qzvo1lkGnwNzi04D+WYbyb9vRqEeRE4/Ponzjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ugk+WlhVt8hCLjdZCjC+TeLXo5DAWWC5lF/enxi5vu/fo4nd2qVASKQTk/qmXrNO4
	 ZnyjSuZ3uuM3Cjz0gLt9398nWBFg7rw25otUtro9BYKUKUPTrjIf3B0L1jo+dZjz4y
	 wJBbSkG6nOnTpfYE6tp/Eo6LXJ+fDXz5X10yBo1m4Im59vBlxB+waM+qOr/JLxXPFk
	 HqpPuNgdLr6eGeB0HJDD3bZ1Vojh4Ggw/35kMZML7lNwD4XK06llQVOAF+C4zcF/ee
	 wLfMxMV3004vFMEhppEsl3w03UqM1jkq/MkZrPbRPvSO1Y7P06GJVCpvYVx9epRCRS
	 jZT3/BcqdSDLA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s2w3o-000000002bJ-1HAF;
	Fri, 03 May 2024 18:47:00 +0200
Date: Fri, 3 May 2024 18:47:00 +0200
From: Johan Hovold <johan@kernel.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, johan+linaro@kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: Patch "Bluetooth: qca: fix invalid device address check" has
 been added to the 6.8-stable tree
Message-ID: <ZjUVBBVk_WHUUMli@hovoldconsulting.com>
References: <20240503163852.5938-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503163852.5938-1-sashal@kernel.org>

Hi Sasha,

On Fri, May 03, 2024 at 12:38:51PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     Bluetooth: qca: fix invalid device address check
> 
> to the 6.8-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      bluetooth-qca-fix-invalid-device-address-check.patch
> and it can be found in the queue-6.8 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please drop this one temporarily from all stable queues as it needs to
be backported together with some follow-up fixes that are on their way
into mainline.

> commit 2179ab410adb7c29e2feed5d1c15138e23b5e76e
> Author: Johan Hovold <johan+linaro@kernel.org>
> Date:   Tue Apr 16 11:15:09 2024 +0200
> 
>     Bluetooth: qca: fix invalid device address check
>     
>     [ Upstream commit 32868e126c78876a8a5ddfcb6ac8cb2fffcf4d27 ]

Johan

