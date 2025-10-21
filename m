Return-Path: <stable+bounces-188857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DD5BF92B6
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 01:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 431EE355EE7
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 23:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051222BEC5A;
	Tue, 21 Oct 2025 23:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpqFC4DZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B428D2BE04F;
	Tue, 21 Oct 2025 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761087747; cv=none; b=nisvvBaCJhn5eaf+Dhx1MdDC9u+HknU5YX5EhSLJOYBb7pGlE57viZ0raYaPY3154qeyZMXcCUR0Yr9PtmxtKdxl9HF+MAKP2yfjU/SYeK4BYFSJMUz7K7IFTBWRj7djvCizuuo3thed/ll2rAS4SYvpGJDN2OGmSd3T0Ana0rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761087747; c=relaxed/simple;
	bh=v/+dGwChhlNRieM+YeSzahbru2Z7XLUCWKHZ/1o3rEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tx/UIlopbxG89gR04/iCdWPcZXgN1l2/QxLCd1lJlHfX8SoKoOIjNgNXTa8eJ54CD8ALFENGytDPlbAcWaU2OQA9dfsHKFDw03ZHHMZVvNzqC8CjwXUy8+VRMNsDjizqGAfbi0riWY/YJm+s3DnSeqn/+TI5BQt+ZtbRam6inDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpqFC4DZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCDAC4CEF1;
	Tue, 21 Oct 2025 23:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761087747;
	bh=v/+dGwChhlNRieM+YeSzahbru2Z7XLUCWKHZ/1o3rEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WpqFC4DZcnSRGEDTpckZAXPcch3mcBA/RYJ9HI8yuyRD79XB0+iZq9ZWIMfLhNOap
	 xKjFu6iDCYMZca0aerqeVUUarL2v8ApP9ZQ+dcHQZREIsYm5GjiszY9I8A1ShXjTBe
	 kSxrwOsB4pGLOrOUrzibWpu/g1qxC9ogvj2ke/HjJtMy1bSqX517Gw1F2d4CfVJ1NG
	 i/beRENj5DaRmUcZQNRB8LqMPGFnEBiZFNGB+Y/RHmmQa+A9HcAFIRqvCp1WolLEoc
	 d9itqWkzp0BHm+E25s/xAlzj3UghXlJLfZOo5Yh4TFB8C9xhSqTjDeNJuy0xW2UONP
	 9f0ysxNMCalxw==
Date: Wed, 22 Oct 2025 01:02:22 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
	masahiroy@kernel.org, Alexey Gladkov <legion@kernel.org>,
	Nicolas Schier <nsc@kernel.org>
Subject: Re: [REGRESSION] Secureboot violation for linux enrolled by-hash
 into db v6.17.4 and v6.18-rc1
Message-ID: <20251021230222.GA2339441@ax162>
References: <CANBHLUjPbXYghPx5zDwLDcGKXb7v7+1u-bpZ=L9r=qW7vDZ=cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANBHLUjPbXYghPx5zDwLDcGKXb7v7+1u-bpZ=L9r=qW7vDZ=cg@mail.gmail.com>

+ Nicolas and Alexey just for visibility

On Tue, Oct 21, 2025 at 03:00:56PM +0100, Dimitri John Ledkov wrote:
> If one enrolls linux kernel by-hash into db (for example using
> virt-fw-vars), the secureboot fails with security violation as EDK2
> computation of authenticode for the linux binary doesn't match the
> enrolled hash.
> 
> This is reproducible in AWS VMs, as well as locally with EDK2 builds
> with secureboot.
> 
> Not affected v6.17
> Not affected v6.17.3
> Affected v6.17.4
> Affected v6.18-rc1
> Affected v6.18-rc2
> 
> Suspected patches are:
> 
> $ git log --oneline  v6.17.3..v6.17.4 -- scripts/
> 8e5e13c8df9e6 kbuild: Add '.rel.*' strip pattern for vmlinux
> 7b80f81ae3190 kbuild: Restore pattern to avoid stripping .rela.dyn from vmlinux
> 5b5cdb1fe434e kbuild: keep .modinfo section in vmlinux.unstripped
> 86f364ee58420 kbuild: always create intermediate vmlinux.unstripped
> 
> Reverting all of the above, makes secureboot with by-hash enrolled
> into db work again.
> 
> I will try to bisect this further to determine the culprit. It feels
> like the strip potentially didn't update section offsets or their
> numbers or something like that.

A bisect would definitely help since the first sentence of this message
is almost complete gibberish to me :) Is this a part of the build
process somewhere or does this happen after vmlinux is produced?

Cheers,
Nathan

