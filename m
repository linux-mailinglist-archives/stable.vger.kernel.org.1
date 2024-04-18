Return-Path: <stable+bounces-40165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C198A96DC
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 12:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376051C21123
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 10:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48E915B543;
	Thu, 18 Apr 2024 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GzpC7BWK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8629D15AAB2
	for <stable@vger.kernel.org>; Thu, 18 Apr 2024 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434396; cv=none; b=JRJ2XvIIcksJfKSDEPQ6yeFDNwxrEarpJ0l33wU/67QazapCweKkLGWBRTDH+mFnAN3jiWjs83WRb5zCTXvZJGV5glUw/Dm6oVHQoxezTjKr0UKI5hBS5UzZqAONANopBd5BZaIf2OiBt4/1RSCpiV0IpFSbyiNdg0fqDvPKheM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434396; c=relaxed/simple;
	bh=VvTaPn2Gc6bdRK2mGZR1EXydOl/d2u9LRWO+hmR+rzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PD3FXQg/gqnFl1d4PHrSHePUXM0EJiAg1xAiwK0h11wbR1EycVEywGGE8e6BK0Kmp63EHaALAKGMAL2UyvLWTzBIhQNPsaNb+EbfE6/c0z3+38pXqKMc7B6ROBj1vVgWpnTVcOAu0HAgs6PeYIyIfqA0qO/qzws9pTLSTgGHiw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GzpC7BWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0722C113CC;
	Thu, 18 Apr 2024 09:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713434396;
	bh=VvTaPn2Gc6bdRK2mGZR1EXydOl/d2u9LRWO+hmR+rzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GzpC7BWKuC/2OvNQTOliftn5AzboKj9aedntnDqdVQ8EegKOzcJbLlQpdcMn48gXs
	 no1WnmutNOlkJ/Lj3wtety6Byb6OTKrvjl11d9bgkTWKWcVrFmP7GyBUCb0RwRGLcL
	 gemqY/gHEjsjvQCiqrrff0TIGrnqnYzG2rZL+Hrs=
Date: Thu, 18 Apr 2024 11:59:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: izbyshev@ispras.ru, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: Fix io_cqring_wait() not
 restoring sigmask on" failed to apply to 6.1-stable tree
Message-ID: <2024041846-crook-cloak-2b30@gregkh>
References: <2024041502-handsaw-overpass-5b8a@gregkh>
 <f3f0e73c-b038-4c50-bd0f-ec725c01c62e@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3f0e73c-b038-4c50-bd0f-ec725c01c62e@kernel.dk>

On Mon, Apr 15, 2024 at 10:17:10AM -0600, Jens Axboe wrote:
> On 4/15/24 6:36 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 978e5c19dfefc271e5550efba92fcef0d3f62864
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041502-handsaw-overpass-5b8a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> And lastly, here's the 6.1-stable version.

All now queued up, thanks.

greg k-h

