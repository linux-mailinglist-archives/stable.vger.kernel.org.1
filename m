Return-Path: <stable+bounces-21821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FF485D62F
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 11:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28471C21E7B
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 10:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9536E3EA66;
	Wed, 21 Feb 2024 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b/WwYXn5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5661E3FB20
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513109; cv=none; b=lylYyOGr8lLyGgOSIrfU0J++/HFlIMHfHxxJ6UvVPqYPeaHD0gXg6WDSV8cpXNY1DGh/BD7c2SCc6ieAy0S61+lJTnXiKGo5WF1zCSJLhDH0/LrjUGcuFIB6pY6bjEK0hXiP6jV6cPcegow09RPBCPkLAbPmLIJBKf8ZiHout6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513109; c=relaxed/simple;
	bh=crTK93nbEa0Vt6sT/Od8lgLdtxc7gD268EYIlP7OicM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pllNfBRgYTnxum1hNsxeskRMQT8xz56iKovN3vqHDUOAF/VH+eDRUrqWw0NhRVau5dGDudyEymj6eohDK7xnqtHxScmRJ0j4CSNcAqVdHfOwqhiWsLeD8JODAZC2IOazYfrBqNHsUSM1GiaNhpFH+BQqjY0y2stnlHefocT+WbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b/WwYXn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9274AC43394;
	Wed, 21 Feb 2024 10:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708513109;
	bh=crTK93nbEa0Vt6sT/Od8lgLdtxc7gD268EYIlP7OicM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/WwYXn5wGOBkB1ZyA9Z4aNZBVQh1dPa8s2ikELz6/CQY7PVXYjSamcCDBFMiMuap
	 +ciTE05jwMrgoE7/ALulS5OlWdapKY87nkUfXfFjIsjWZ0SBGHkFMw4GdV4PfGRoUm
	 3pg6nk/gZ+CikWau0xv5+QoII7dZJQNvfZSSpVJE=
Date: Wed, 21 Feb 2024 11:58:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: stable@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Justin Forbes <jforbes@fedoraproject.org>
Subject: Re: [PATCH -stable] Documentation/arch/ia64/features.rst: fix
 kernel-feat directive
Message-ID: <2024022117-unclothed-stool-64dd@gregkh>
References: <6e02ac20-490a-48ff-9370-5e466cb740bb@oracle.com>
 <20240205103959.281871-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205103959.281871-1-vegard.nossum@oracle.com>

On Mon, Feb 05, 2024 at 11:39:59AM +0100, Vegard Nossum wrote:
> My mainline commit c48a7c44a1d0 ("docs: kernel_feat.py: fix potential
> command injection") contains a bug which can manifests like this when
> building the documentation:
> 
>     Sphinx parallel build error:
>     UnboundLocalError: local variable 'fname' referenced before assignment
>     make[2]: *** [Documentation/Makefile:102: htmldocs] Error 2
> 
> However, this only appears when there exists a '.. kernel-feat::'
> directive that points to a non-existent file, which isn't the case in
> mainline.
> 
> When this commit was backported to stable 6.6, it didn't change
> Documentation/arch/ia64/features.rst since ia64 was removed in 6.7 in
> commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture"). This
> lead to the build failure seen above -- but only in stable kernels.
> 
> This patch fixes the backport and should only be applied to kernels where
> Documentation/arch/ia64/features.rst exists and commit c48a7c44a1d0 has
> also been applied.
> 
> A second patch will follow to fix kernel_feat.py in mainline so that it
> doesn't error out when the '.. kernel-feat::' directive points to a
> nonexistent file.
> 
> Link: https://lore.kernel.org/all/ZbkfGst991YHqJHK@fedora64.linuxtx.org/
> Fixes: e961f8c6966a ("docs: kernel_feat.py: fix potential command injection") # stable 6.6.15
> Reported-by: Justin Forbes <jforbes@fedoraproject.org>
> Reported-y: Salvatore Bonaccorso <carnil@debian.org>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/arch/ia64/features.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/ia64/features.rst b/Documentation/arch/ia64/features.rst
> index d7226fdcf5f8..056838d2ab55 100644
> --- a/Documentation/arch/ia64/features.rst
> +++ b/Documentation/arch/ia64/features.rst
> @@ -1,3 +1,3 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> -.. kernel-feat:: $srctree/Documentation/features ia64
> +.. kernel-feat:: features ia64
> -- 
> 2.34.1

Sorry for the delay, now queued up.

greg k-h

