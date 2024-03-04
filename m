Return-Path: <stable+bounces-25883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2442486FF4E
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 11:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B87CCB23C5B
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 10:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8CC3717C;
	Mon,  4 Mar 2024 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P4s0sK4x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD66A364CF;
	Mon,  4 Mar 2024 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548969; cv=none; b=HzFZUHuW3Dc+5LhPMoYGGwRwyV91/gztUX4YVtNMJteyG9ko5nwSOvjY48VysVD0KVK2+6yrOOVFCGXxEDPOY34+riAdWdqXDJpR8oMKyiQ5/mRliCWXlBak9nCsc6xsqDTwwN9x/0deykJSkgibOoNMHGgJzQiV7DMMlTvRF14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548969; c=relaxed/simple;
	bh=V5fcT4xKaaljAl/3SVxmCZ7qFbY1AvXsibo4PeR1n2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7jQ/h66g7zTp+Xu5G71pDSzav8I2ezdKx3cXOZEB8EMlkgo7lSAOCImVVKOC9PFQj3QcfVNqNVkrGF1mXmoziFBXridYkDaJTl34h/gsCn2CPWG6OVCTpxrYQIKzXUpWVtsILBy4fq0apPDAMk9f9LK0u9f4NqSCNkWAvm1n5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P4s0sK4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17ECBC433C7;
	Mon,  4 Mar 2024 10:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709548968;
	bh=V5fcT4xKaaljAl/3SVxmCZ7qFbY1AvXsibo4PeR1n2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4s0sK4xISCq6LtGbcEioHxTeDFVSSEMdHoL+p4dQcMak25CyxHh7C4WimnXl/mxJ
	 u/2mCaEUtxwKMm3QPsc2DQ7GevUTCbUW7EyJ/qreyZlVZu1Xccs76BCkItY79LX3HS
	 nrFqX2ds+pvE+XseDAIRLPfycxeJdo8fSsItLK3I=
Date: Mon, 4 Mar 2024 11:42:45 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
	stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: Please apply commit 5b750b22530fe53bf7fd6a30baacd53ada26911b to
 linux-6.1.y
Message-ID: <2024030439-setback-dandruff-edfb@gregkh>
References: <20240228014555.GA2678858@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228014555.GA2678858@dev-arch.thelio-3990X>

On Tue, Feb 27, 2024 at 06:45:55PM -0700, Nathan Chancellor wrote:
> Hi Greg and Sasha,
> 
> Please apply upstream commit 5b750b22530f ("drm/amd/display: Increase
> frame warning limit with KASAN or KCSAN in dml") to linux-6.1.y, as it
> is needed to avoid instances of -Wframe-larger-than in allmodconfig,
> which has -Werror enabled. It applies cleanly for me and it is already
> in 6.6 and 6.7. The fixes tag is not entirely accurate and commit
> e63e35f0164c ("drm/amd/display: Increase frame-larger-than for all
> display_mode_vba files"), which was recently applied to that tree,
> depends on it (I should have made that clearer in the patch).
> 
> If there are any issues, please let me know.

Now queued up, thanks.

greg k-h

