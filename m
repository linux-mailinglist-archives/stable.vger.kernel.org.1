Return-Path: <stable+bounces-50245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924629052A4
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356492824A9
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D5A16FF38;
	Wed, 12 Jun 2024 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dbavpwRY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0604516F29C
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195943; cv=none; b=vAo0VZSoO1hIz9GoVuOO6ryuE9vF2UNOe2JZG0/oUA258Qt5RFe6K2AN5C3Osdr/z6mfcDGLA6DS78BA4oFnGWA5/i1c2xNPcjF6eAA+ZPwp4B8Xiokle4aZEopKaHkfkwlbuNOmCDyu+198f00lYJ/RKZXJMZAIaxqsKsP/fu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195943; c=relaxed/simple;
	bh=TWjT7V5fukOQyVgmHI8i6F964Urk3f3IiI92u2PeAnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubdySiavyxxcLcYzkMgQqgmIsKU4ZTOu56WSugSbccLYY+PMflgdofqCaR+4lyThLOpQUK8KU6Q9EmRkuutct8AK76BuiD765dMM9V2jCNTtyPBjoU6Hj8QcSEEDMszln+SQLExbSf4F/aHPYnrnF2yCMMmjX5Mx5i/2Tf0Ld/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dbavpwRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BDEC3277B;
	Wed, 12 Jun 2024 12:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718195942;
	bh=TWjT7V5fukOQyVgmHI8i6F964Urk3f3IiI92u2PeAnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dbavpwRYSCOx26YMQLHXBz2qH/E54cMJYlBcaQ3yilYWCcv+3r7dR66Q6UE9XyTXp
	 qfhepFQsvh3t2u/wHjxxRUsQNcls+mfI7L5o1IN1J1xB3Eszgg8VNu7DYgn+gwaw/T
	 emELsbkjtoPXZkBWRrTpNwWoSR3dlhDO5wVg3pYs=
Date: Wed, 12 Jun 2024 14:38:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	sjb7183@psu.edu
Subject: Re: [PATCH 4.19 5.4 5.10 5.15 6.1] nilfs2: fix use-after-free of
 timer for log writer thread
Message-ID: <2024061254-dig-relax-0743@gregkh>
References: <2024052603-deceiving-stood-2b59@gregkh>
 <20240527212637.5907-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527212637.5907-1-konishi.ryusuke@gmail.com>

On Tue, May 28, 2024 at 06:26:37AM +0900, Ryusuke Konishi wrote:
> commit f5d4e04634c9cf68bdf23de08ada0bb92e8befe7 upstream.
> 
> Patch series "nilfs2: fix log writer related issues".
> 
> This bug fix series covers three nilfs2 log writer-related issues,
> including a timer use-after-free issue and potential deadlock issue on
> unmount, and a potential freeze issue in event synchronization found
> during their analysis.  Details are described in each commit log.
> 
> This patch (of 3):
> 
> A use-after-free issue has been reported regarding the timer sc_timer on
> the nilfs_sc_info structure.
> 
> The problem is that even though it is used to wake up a sleeping log
> writer thread, sc_timer is not shut down until the nilfs_sc_info structure
> is about to be freed, and is used regardless of the thread's lifetime.
> 
> Fix this issue by limiting the use of sc_timer only while the log writer
> thread is alive.
> 
> Link: https://lkml.kernel.org/r/20240520132621.4054-1-konishi.ryusuke@gmail.com
> Link: https://lkml.kernel.org/r/20240520132621.4054-2-konishi.ryusuke@gmail.com
> Fixes: fdce895ea5dd ("nilfs2: change sc_timer from a pointer to an embedded one in struct nilfs_sc_info")
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Reported-by: "Bai, Shuangpeng" <sjb7183@psu.edu>
> Closes: https://groups.google.com/g/syzkaller/c/MK_LYqtt8ko/m/8rgdWeseAwAJ
> Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> Please apply this patch to the stable trees indicated by the subject
> prefix instead of the patch that failed.
> 
> This patch is tailored to replace a call to timer_shutdown_sync(), which
> does not yet exist in these versions, with an equivalent function call,
> and is applicable from v4.15 to v6.1.
> 
> Also, all the builds and tests I did on each stable tree passed.

Now queued up, thanks.

greg k-h

