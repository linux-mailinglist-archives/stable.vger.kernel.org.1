Return-Path: <stable+bounces-159199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF39AF0CBE
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 09:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADE548504A
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 07:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020A2231827;
	Wed,  2 Jul 2025 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yWW6octh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EB6230BD9;
	Wed,  2 Jul 2025 07:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751441910; cv=none; b=i/sDFVH0VUnc5yujfjsEdMAD+SP7PM6EuA4kkqukELIkgUvYZZf7vGUyMPB7kqde8miVYrxtZ/48CKav/IbXULvXdckz038iGV7CXZfTgLxgJoDkc0WajxuZu0S/9bm+nGgemD7VGiBy/iN6FFDA9D0+XHxVoq6fAk2kaWFsLj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751441910; c=relaxed/simple;
	bh=0tcw+axVh6y4RjKxKI3wHuE++w1UVnfyUOJdIVZdk9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2vFdhD9kA6CcE5/0i0bA2wpJHiA5vvufsCR3ZpgA3/U3v6QDDFTQfN5bwcOFOdaFZRAn7DEsv0ETTbVdKgCAEkxIlvVpFhqitjLKvyLE3V739J1LAwP6ow9zyYaAT3Y/RHT6O5XuDT1k6PFhcFHBjvtPfFdrH6CcYuO4ibKytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yWW6octh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C9FC4CEED;
	Wed,  2 Jul 2025 07:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751441910;
	bh=0tcw+axVh6y4RjKxKI3wHuE++w1UVnfyUOJdIVZdk9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yWW6octhHNtpBbPt9q+j2kOdtTxQXKgeXXY0js5lA/QP0uF44UKF8/sUp31YiDVSU
	 IXyBIZvjHfRmQNy/GCN/f47ndB4AqJiCPCEXuDreSXqH24RVo0Hm8MNg+poYFRH9nJ
	 euMgSEW+UaVBuMM/mPR2Zr95lZP8i90VMQpgZPgs=
Date: Wed, 2 Jul 2025 09:38:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: andi.shyti@kernel.org, andi.shyti@linux.intel.com,
	matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
	ville.syrjala@linux.intel.com, sashal@kernel.org,
	stable@vger.kernel.org, stable-commits@vger.kernel.org
Subject: Re: Patch "drm/i915/gem: Allow EXEC_CAPTURE on recoverable contexts
 on DG1" has been added to the 6.1-stable tree
Message-ID: <2025070249-blade-robotics-0bca@gregkh>
References: <2025063043-down-countable-2999@gregkh>
 <175136652541.22602.12580210971758725103@jlahtine-mobl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175136652541.22602.12580210971758725103@jlahtine-mobl>

On Tue, Jul 01, 2025 at 01:42:05PM +0300, Joonas Lahtinen wrote:
> Hi Greg,
> 
> Please do note that there is a revert for this patch that was part of
> the same pull request. That needs to be picked in too in case you are
> picking the original patch.
> 
> I already got the automated mails from Sasha that both the original commit
> and revert were already picked into 6.1, 6.6 and 6.12 trees. Are now in
> a perpetual machinery induced loop where the original commit and revert will
> be picked in alternating fashion to the stable trees? [1]

Yes.

> Regards, Joonas
> 
> [1] Originally, I was under the assumption stable machinery would
> automatically skip over patches that have later been reverted, but
> that doesn't seem to be the case?

Nope, if that were to happen then we would be adding it back over time
as we would go "hey, we missed this one!" all the time.  Adding the
commit and revert is best.

thanks

greg k-h

