Return-Path: <stable+bounces-119866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94158A489D6
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 21:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18BF3ACE6D
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 20:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4465426FA70;
	Thu, 27 Feb 2025 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZemE8IaV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F156726E97A;
	Thu, 27 Feb 2025 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687978; cv=none; b=MkHU4ap1ziJyG64bEtnsKYJbnFhn1uIg4JtFteuitdUzEhGjH8p7eNh4ExMf5oTk+Tu5bUvtwUev+2LAAkncHG+mvBClF/lCdFLHZcD+MNOEvtRrChq1IPa45wE2cR1Hx8uEGzaCQqvk3NqRNcE64GdXVbBgjnD5yHndszzhRq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687978; c=relaxed/simple;
	bh=HS/AUV6+Qpsw3N32uy3TyW+OGn3hvfruRaKt+iFFMg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BN0LTCuzY6z6rT0wyQPl+uOLDclDtBGm/fHtb+n1SCWBfJ8WpakolMcJ9KtnzjRcFwjogtFks/8zztdCVeNZijJRsPFw1GmzmjgbVfBSOKlMdJGo3oyG1BDnRwn63tXANo7W/pJ6Bht62wXrnBIwhzgtWGrVV+wMQCLyZSSJ6Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZemE8IaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1400C4CEDD;
	Thu, 27 Feb 2025 20:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740687977;
	bh=HS/AUV6+Qpsw3N32uy3TyW+OGn3hvfruRaKt+iFFMg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZemE8IaVZyzzWcQTcjHDhHLYPWMeFwP1iQShD2UV29ukIaVc4ZdPLRyAjiFEkLqfj
	 zIdeHsqImXcpaPaYqCwTPzCt5FsfMiy8OKpek/aWRahy22rfTTg6WB2djdN7QvVSLW
	 n2V2EjAf+JZhtXZuJpPyrtMRYSDwJKGQJ4Ubzzz0=
Date: Thu, 27 Feb 2025 12:25:07 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christian Heusel <christian@heusel.eu>
Cc: Arnd Bergmann <arnd@arndb.de>, Sean Rhodes <sean@starlabs.systems>,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, qf <quintafeira@tutanota.com>
Subject: Re: [PATCH] Revert "drivers/card_reader/rtsx_usb: Restore interrupt
 based detection"
Message-ID: <2025022758-traps-nebulizer-5356@gregkh>
References: <20250224-revert-sdcard-patch-v1-1-d1a457fbb796@heusel.eu>
 <0944ac33-c460-4d3b-9ec8-db70d11ee9c1@heusel.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0944ac33-c460-4d3b-9ec8-db70d11ee9c1@heusel.eu>

On Thu, Feb 27, 2025 at 02:40:04PM +0100, Christian Heusel wrote:
> On 25/02/24 09:32AM, Christian Heusel wrote:
> > This reverts commit 235b630eda072d7e7b102ab346d6b8a2c028a772.
> > 
> > This commit was found responsible for issues with SD card recognition,
> > as users had to re-insert their cards in the readers and wait for a
> > while. As for some people the SD card was involved in the boot process
> > it also caused boot failures.
> > 
> > Cc: stable@vger.kernel.org
> > Link: https://bbs.archlinux.org/viewtopic.php?id=303321
> > Fixes: 235b630eda07 ("drivers/card_reader/rtsx_usb: Restore interrupt based detection")
> > Reported-by: qf <quintafeira@tutanota.com>
> > Closes: https://lore.kernel.org/all/1de87dfa-1e81-45b7-8dcb-ad86c21d5352@heusel.eu
> > Signed-off-by: Christian Heusel <christian@heusel.eu>
> 
> Hey Arnd, hey greg,
> 
> could one of you pick this up? Sean said in the other thread that going
> with the revert for now seems like the best option and that he'll
> revisit this once he has time...

Yes, will go queue this up right now, thanks.

greg k-h

