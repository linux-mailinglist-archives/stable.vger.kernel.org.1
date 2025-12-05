Return-Path: <stable+bounces-200089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE07CA5BE4
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 01:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28DD3304EB0B
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 00:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3D61E8337;
	Fri,  5 Dec 2025 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5rk6J6l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8507800;
	Fri,  5 Dec 2025 00:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764894172; cv=none; b=S8dk9hXiafJ/3RMmb01aY2Vxx6PES0Qp8nXXx60tj/uX3fpCCg2xLRRoY5TWgG1SwhcZGHicly5fX4j7AZOXTelaFyjra2B/AxPPWWmWY79H5TQXnmU6xOxKjIgD8wc+zna8UtxUMs8YLaSYD1uQn3XsrSWpYp90S2fHEcl7b60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764894172; c=relaxed/simple;
	bh=Mv/Yf5qUPtaJ+aXcJ/pliKz7h14XmR4v8kreCWxmRwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7EsdbDI2/Acl24WQ/x+iKwNUCoJkmCvp+ZOreOUWjKQqVpu7eaV6HtKbLkLy67wgBNQGOLp81O43Akv3NrmnycC5P8gA8V8S4JlMNflQai/p8FPo2kbl/YpzYAtp7CIXqF/lkNayp2DSr7T2Nnf/ME02ZqpyzrN5d2l8XCHQ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5rk6J6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F5EC4CEFB;
	Fri,  5 Dec 2025 00:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764894171;
	bh=Mv/Yf5qUPtaJ+aXcJ/pliKz7h14XmR4v8kreCWxmRwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j5rk6J6lTzRISrAwoAwJgTUZbMxT8I62mUOi5bcG93chxim95JlY5LgZux9mVWlRm
	 4RlWhPPOdn304R+xD5eDL4A+klPwg4VS/uDJrBwPDkmjFY1P09X5kG83NvGqehc/Vd
	 H3J2YotrvaHjoWF9M15As0+O+rKZAEAT7InUb/SoBPBNh0WdgeqOQQQ+JG79Xe8gG6
	 /tjafZLzdx+G/xSBlicYtCsBUqr/6etTZ/nfC0V6W7ToEYh1JEU1Z860vwEZFB4QZ/
	 ui6TZpELIRa4dYjvDEWR4z/8zmYUJQYcXvi7qmt/m90x1uQZMN0xa/ji7kJJbF+kSS
	 PpNhsE1DnVygw==
Date: Thu, 4 Dec 2025 17:22:45 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, Will Deacon <will@kernel.org>,
	Christopher Covington <cov@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y RESEND] KVM: arm64: silence
 -Wuninitialized-const-pointer warning
Message-ID: <20251205002245.GA3463270@ax162>
References: <20251204-b4-clidr-unint-const-ptr-v1-1-95161315ad92@google.com>
 <2lse2swdqrovimdsakgtriadki2fsvikhuetjzxztoui5hpsai@6mmc64ugt22k>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2lse2swdqrovimdsakgtriadki2fsvikhuetjzxztoui5hpsai@6mmc64ugt22k>

On Thu, Dec 04, 2025 at 12:53:58PM -0800, Justin Stitt wrote:
> Quick correction:
> 
> On Thu, Dec 04, 2025 at 12:50:11PM -0800, Justin Stitt wrote:
> > A new warning in Clang 22 [1] complains that @clidr passed to
> > get_clidr_el1() is an uninitialized const pointer. get_clidr_el1()
> > doesn't really care since it casts away the const-ness anyways.
> > 
> > Silence the warning by initializing the struct.
> > 
> > This patch won't apply to anything past v6.1 as this code section was
> > reworked in Commit 7af0c2534f4c ("KVM: arm64: Normalize cache
> > configuration"). There is no upstream equivalent so this patch only
> > needs to be applied (stable only) to 6.1.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 7c8c5e6a9101e ("arm64: KVM: system register handling")
> > Link: https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e [1]
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Resending this with Nathan's RB tag, an updated commit log and better
> > recipients from checkpatch.pl.
> 
> My usage of $ b4 trailers must've not been correct because this 6.1
> version didn't pick up Nathan's RB tag. Whoops! Hopefully whoever picks
> this up can add that for me :)

Looks like you resent the first iteration of this change [1] instead of
the second [2], hence why 'b4 trailers -u' did not work, since I never
reviewed the first iteration after Marc rejected it :)

Your 5.15 resend looks correct though.

[1]: https://lore.kernel.org/20250724-b4-clidr-unint-const-ptr-v1-1-67c4d620b6b6@google.com/
[2]: https://lore.kernel.org/20250728-stable-disable-unit-ptr-warn-v1-1-958be9b66520@google.com/

Cheers,
Nathan

