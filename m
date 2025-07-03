Return-Path: <stable+bounces-159308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE89AF74C5
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E143AA345
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 12:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8682E6D0C;
	Thu,  3 Jul 2025 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxlorSTA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EF82E3B07;
	Thu,  3 Jul 2025 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751547279; cv=none; b=no9kc3ux2C91ypbfGomOot/b1c7s9+N8uChlXFhC38lCwBSLo4/FXmPLMZWvg89sbxfs+6mzUaEoVshgkMh77Lf6fNUGq/K3jv4WyCjpMmpwJzYz6agDhCfDm0roWVdsQpVdXxIxCZ4XDZzDPSOSW3bfeFg6OLU7Lsa+6AlCkWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751547279; c=relaxed/simple;
	bh=ze4SaQOFArB01MNd8YrR+zTdChwqwAAWc0eSVRtAzo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZWEqcYQbY1BFBMeFOP5wgXGfIYk3Jb6nMP4NJb0L6fFMNKW/VOGYQ+O3gy+33SnEPMvQNRTv111v21GLAL0RiiD3E2RQnItP+HuzJWmD5TYVx2zWHWPBm4HPZlnxTzljeLnZq8K3/GRfVQppu48wD3BKEmeShz473ENwSlL+bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxlorSTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00531C4CEF0;
	Thu,  3 Jul 2025 12:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751547277;
	bh=ze4SaQOFArB01MNd8YrR+zTdChwqwAAWc0eSVRtAzo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NxlorSTACSMHMB9P6HyhJAvvpF3DZcccmJJXemG5114WfVxwDZ7BoVJaESLRhEAYh
	 XeHNToUQuca05VvXwxo4ZPWOfVm7u0Xz4Voj37OmiCo2C991z/nmD3pRDZCyjmVR/2
	 X2Pwtn+KdGlugIStpEEJPD71x4aRRopl4UwmbA7n0Q2+JFryCUT407RnL5xBdeyTwM
	 bj+PRIV5DakuW+bX3/KK3wwSGClQdYXPpv55ifzv+FmKb81N++QPUaPrW0EU6+15t3
	 esl34fraBOeH/tKQ/ceLeg+p3tqT2SBEUoyEIJu42VTcqx1oyydtR1BbTa3weomMCy
	 xpz58m1QZunVA==
Date: Thu, 3 Jul 2025 08:54:35 -0400
From: Sasha Levin <sashal@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: Patch "KVM: arm64: Set HCR_EL2.TID1 unconditionally" has been
 added to the 6.12-stable tree
Message-ID: <aGZ9i7yZWoUwTrP2@lappy>
References: <20250703015257.2692314-1-sashal@kernel.org>
 <867c0pbqym.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <867c0pbqym.wl-maz@kernel.org>

On Thu, Jul 03, 2025 at 09:48:01AM +0100, Marc Zyngier wrote:
>On Thu, 03 Jul 2025 02:52:57 +0100,
>Sasha Levin <sashal@kernel.org> wrote:
>>
>> This is a note to let you know that I've just added the patch titled
>>
>>     KVM: arm64: Set HCR_EL2.TID1 unconditionally
>>
>> to the 6.12-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      kvm-arm64-set-hcr_el2.tid1-unconditionally.patch
>> and it can be found in the queue-6.12 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>>
>>
>> commit 0510d3297a23920caf74a63e3f38c0ede70d6555
>> Author: Sasha Levin <sashal@kernel.org>
>
>Really?

Sorry, I was working on fixing up backports of stable@ tagged commits
that didn't get backported when they should, and I've committed this
with "git commit" instead of "git rebase --continue" which apparently
overwrites the author information.

I'll just drop it for now.

-- 
Thanks,
Sasha

