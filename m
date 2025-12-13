Return-Path: <stable+bounces-200952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F84ACBA815
	for <lists+stable@lfdr.de>; Sat, 13 Dec 2025 11:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8905A300444E
	for <lists+stable@lfdr.de>; Sat, 13 Dec 2025 10:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD832F658D;
	Sat, 13 Dec 2025 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVsYd9qj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CDA2F6599;
	Sat, 13 Dec 2025 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765620850; cv=none; b=s55CM1bY0vDWqjFehjDrg1NZUiYIjHyr4H4ZmsbSw967N4va+2TCIU44Ip72a6iuPJjauizm2+2FB0YqWkR1EClKdfaxEuapkVe/oemd+IVGtBH94TyEmRo0WiUNdkRceYnBbSV4Uv2e3JLp1bIzrPQT5a5XtO4z9Z2x1ailTsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765620850; c=relaxed/simple;
	bh=UypVGThd2QMZh1G5BmcptTylVjAolKsHKeCehdTTZMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmmdgMu+wQhU+x+PGrNajQ9C+Mga9sb/Lvw9mQWisiQ8AIMJeUZduvaDA+DzLd4byQOVuBuIiqFb6o37yWebt8NS5QJXhpqZQBQSKcerz3Rjx8zMq7Y0JFVjnob8Il9jvTET6KVPrZE0PLp+HZgm5UE+C+XEa4xnR4gD5bzxRt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVsYd9qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB4CC19421;
	Sat, 13 Dec 2025 10:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765620850;
	bh=UypVGThd2QMZh1G5BmcptTylVjAolKsHKeCehdTTZMQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GVsYd9qjo3oLVFbqIS3iJRGqmfPoVZxyLA3hG2UqatwYN6u0v0zjdlxqAQ2RYOq7M
	 m2Xy2Po3fjnCnK5Ued8oZctTsy3i+Zyyq6bZKIhqEPCznKi5ocNQD83LfG6covk4lv
	 gjLzk6YdWptfZWEMfrPWeo49E+UAnU2Y4X8dAs66DzlfRhXxfG1HmfDy7OAeNm8n1Q
	 2s838XuiUyg62R6xr7v2lcAIQ4hNPCRZqEigGjQ4I3MTBD/sBTsLlwCKGs2XvZxfKi
	 HIsb/hPNFak2u4uIElAkMa9IoR5pLXuihzaphMTQFWVtvLYKy89rl7b8VQgrcpbu9D
	 lzlIOzQjsUrTA==
Date: Sat, 13 Dec 2025 11:14:05 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 jason@os.amperecomputing.com, "Rafael J. Wysocki" <rafael@kernel.org>, Tony
 Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Hanjun Guo
 <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai
 Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>
Subject: Re: Patch "RAS: Report all ARM processor CPER information to
 userspace" has been added to the 6.18-stable tree
Message-ID: <20251213111405.65980c34@foz.lan>
In-Reply-To: <20251213094943.4133950-1-sashal@kernel.org>
References: <20251213094943.4133950-1-sashal@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Sacha,

Em Sat, 13 Dec 2025 04:49:42 -0500
Sasha Levin <sashal@kernel.org> escreveu:

> This is a note to let you know that I've just added the patch titled
> 
>     RAS: Report all ARM processor CPER information to userspace
> 
> to the 6.18-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      ras-report-all-arm-processor-cper-information-to-use.patch
> and it can be found in the queue-6.18 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

You should also backport this patch(*):

	96b010536ee0 efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs

It fixes a bug at the UEFI parser for the ARM Processor Error record:
basically, the specs were not clear about how the error type should be
reported. The Kernel implementation were assuming that this was an
enum, but UEFI errata 2.9A make it clear that the value is a bitmap.

So, basically, all kernels up to 6.18 are not parsing the field the
expected way: only "Cache error" was properly reported. The other
3 types were wrong.

(*) You could need to backport those patches as well:

	a976d790f494 efi/cper: Add a new helper function to print bitmasks
	8ad2c72e21ef efi/cper: Adjust infopfx size to accept an extra space


Regards,
Mauro

Thanks,
Mauro

