Return-Path: <stable+bounces-28259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A13187D179
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 17:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE5D1C21989
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 16:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A3845008;
	Fri, 15 Mar 2024 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrACjc1h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2D2BD19;
	Fri, 15 Mar 2024 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521567; cv=none; b=C3U2QAI1fUsGg6isiOzf6a6rZmByJ4q/bxnYYmufmlrM9fGAo2EGuVoFL4GMQnmfQLOGgjhJ+honWgH7oRDGUd1z3sUvjOOOTbeDuzj6Bax3t6/ld6N7XL0mONDArXwtf6kWAJOV2njy0InQZqgP9rVp+zb9n9FwSBMoiPK0/sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521567; c=relaxed/simple;
	bh=IzJk7AOCoYLXieCArB4efm0NZS82K8nZGO0e760LYXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d82QNV/DXCV3Sz48FhpB275lHHuUytRHwLNkyWy8pAQtUmLZ2p08Huhl8oARy8THXUKO6rrFBkW7EH7YuOpgGV3NPDeQtyvEvPtbi5YZqyx18CSwFYcz+hNWu9JJZJAWQgvRUw0RpgEexOZEuevabZc7DQxG2LaDFwxP9cjua70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrACjc1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E8CC433F1;
	Fri, 15 Mar 2024 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521567;
	bh=IzJk7AOCoYLXieCArB4efm0NZS82K8nZGO0e760LYXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NrACjc1h3HwK8Qluv4p2ISBwy96gV9h2aMopUYzMFDPOtTHNFOBHgJl3U93bxj8F/
	 SeHkhu0yHmntgkmMi/dOMqYhqKW8oAaJ9zJj2FKIWVAmwZ9fi/Yr8tMAmyja1DBc9M
	 TF+sKHQLzOqFBuWJDE2zn4Ze3f1uOpIrfTrvJZ1ORGUjPPijekMqKya4S3xDNjIgfF
	 OLQzcoEqS6HsJk/By+xUKQj4oVavuEyLRhbvI5UTZm2mQpyqpqiUADESx/q1spevsH
	 hN8lLBJjyvBz7qyX9thzmdimKIt0gaYJGDyQSTdPYIG0Gdoi/aXkv9QgAdspbOSiOy
	 vGgKJ1k5lek3w==
Date: Fri, 15 Mar 2024 12:52:45 -0400
From: Sasha Levin <sashal@kernel.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de
Subject: Re: [PATCH 5.10 00/73] 5.10.213-rc1 review
Message-ID: <ZfR83VSHE2RZKs5Q@sashalap>
References: <20240313164640.616049-1-sashal@kernel.org>
 <ZfKhPaFngJTrTJyt@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZfKhPaFngJTrTJyt@codewreck.org>

On Thu, Mar 14, 2024 at 04:03:25PM +0900, Dominique Martinet wrote:
>Sasha Levin wrote on Wed, Mar 13, 2024 at 12:45:27PM -0400:
>> This is the start of the stable review cycle for the 5.10.213 release.
>> There are 73 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>
>Thanks Sasha for submitting a stable rc review!
>
>If it's not too much trouble, would it be possible to have a different
>header in the 00 patch from the other patches for my mailbox?
>The mails Greg sends have the X-KernelTest-* headers (patch, tree,
>branch etc) only in the cover letter, while all the patches themselves
>only have 'X-stable: review' and 'X-Patchwork-Hint: ignore'
>
>I don't really care much what actual tags are on which as long as
>there's a way to differentiate that cover letter from the rest so I can
>redirect it to a mailbox I actually read to notice there's a new rc to
>test, without having all the patches unless I explicitly look for them.
>
>If it's difficult I'll add a regex on the subject for ' 00/' or
>something, I'd prefer matching only headers for robustness but just let
>me know.

I should be able to adjust my scripts to match what Greg does. Thanks
for pointing it out!

-- 
Thanks,
Sasha

