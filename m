Return-Path: <stable+bounces-135128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5427FA96CD3
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 15:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68EE8400BC3
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 13:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4F328C5BA;
	Tue, 22 Apr 2025 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iWbMdgHp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F628C5B4;
	Tue, 22 Apr 2025 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328532; cv=none; b=UcN8QwD5NJBEaNwpiuALw5fFvr/d1U9uZLoecqjQ+ms5dJmDaexqLv3tC0/dQwSjzO1sUkjiMxgMEknvuy62akxhfSG04VqYMxQhN0Dfttff4UEBCwUwAbfijjTgB4ouHgsn2yCnFRwaB2PUPkw1lh7FW+QlNw24R0Fb3N5aaK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328532; c=relaxed/simple;
	bh=2me7VBvAa2GZQE5A/roufyixEHNbO9DV7E/3wBj0/4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD+FwUAZVDg/4C9IKS2bIYWthh93Ucba+sacI7RS8U6q0y/qpIGzuFB7N4aV3EMNdAYCERyOZcczoJnLhFCvGcQpWoPrBBt/KxKNRdIW1IW4Utg+n+M9msAgMnYPmcezZE27lu31aNmGN0KiJXoLLloj8y3VgVUA3Kl6LD8V34Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iWbMdgHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B816CC4CEE9;
	Tue, 22 Apr 2025 13:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745328532;
	bh=2me7VBvAa2GZQE5A/roufyixEHNbO9DV7E/3wBj0/4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iWbMdgHpfz08LG91tG3OtdAk9ffFq/qpS4FiRI4TKgteuhS5LbZPRyecxt0gzSbWK
	 3zsSqEL9E2I1vrTXs//+hRrBRzL+kpfG7VKBQD9bZKFwL9pe9Yc2VELwVK58eiGrmb
	 4rmrE8MiCfUoYI0R/HuZEOHy2whieSwknQzhioiw=
Date: Tue, 22 Apr 2025 15:28:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aditya Dutt <duttaditya18@gmail.com>
Cc: stable@vger.kernel.org, Dave Kleikamp <dave.kleikamp@oracle.com>,
	Dave Kleikamp <shaggy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	jfs-discussion@lists.sourceforge.net, skhan@linuxfoundation.org,
	Manas Ghandat <ghandatmanas@gmail.com>
Subject: Re: [PATCH 5.15.y] jfs: define xtree root and page independently
Message-ID: <2025042210-stylized-nearest-ea59@gregkh>
References: <20250415180939.397586-1-duttaditya18@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415180939.397586-1-duttaditya18@gmail.com>

On Tue, Apr 15, 2025 at 11:39:39PM +0530, Aditya Dutt wrote:
> From: Dave Kleikamp <dave.kleikamp@oracle.com>
> 
> [ Upstream commit a779ed754e52d582b8c0e17959df063108bd0656 ]
> 
> In order to make array bounds checking sane, provide a separate
> definition of the in-inode xtree root and the external xtree page.
> 
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> Tested-by: Manas Ghandat <ghandatmanas@gmail.com>
> (cherry picked from commit a779ed754e52d582b8c0e17959df063108bd0656)
> Closes: https://syzkaller.appspot.com/bug?extid=ccb458b6679845ee0bae
> Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
> ---
> Tested using C reproducer here: https://syzkaller.appspot.com/x/repro.c?x=113bb250e80000
> (given in the dashboard link above
> UBSAN is not triggered when this commit is there.
> It is triggered when it is not.

Please always submit backports for all relevant stable trees.  We can't
take this one until the newer trees are fixed.

Please resubmit all ones needed.

thanks,

greg k-h

