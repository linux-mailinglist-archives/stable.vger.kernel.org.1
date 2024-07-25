Return-Path: <stable+bounces-61371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A2193BEC6
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 11:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124951C2115F
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 09:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71433196C9B;
	Thu, 25 Jul 2024 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bfl0LHCX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CAF15FA60
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898719; cv=none; b=mkCgvrEWdeFdLxXXF/z+ppZrU50nmbnEBpKQmxOYjWW5mbm8dEFrW2vvhgWNQh+EzOGdTxaSw3hbXyGiFrACPJ/HZ7sKX6gU8Wng3K8+3RH9MCDPnu8sVSkZi6wlRn7bVsqi6AJAbzGSLTdfdrvVd0XOvbF4yTqGW/k/vr44Jvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898719; c=relaxed/simple;
	bh=uBJoTntlF9hVkGuScDW+2vv25IX3hqMqmdQadmSeL6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KC3Hl5Sk+eBO0bz36KHwsNraTwAcXRGVpY/A7cGNEyy0seOY/ro2yKk/awYsg3GjFAtG9z1HkM1SZJqCwFoC+PF0SM80Znr+PJiRTVRkvqHtmkhjolgkO0OghDOthGwVfCo3zLus+aUNmUEVcb9q+r7ETlPtABrYVJPPvPQf72o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bfl0LHCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6131C32786
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 09:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721898718;
	bh=uBJoTntlF9hVkGuScDW+2vv25IX3hqMqmdQadmSeL6c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bfl0LHCXVaBvsAh4FsebBANvHn594dQGsRWd9q2ar/FMz6iYpGWPXuFhWchlKsi4n
	 4rCy3+vou0/C+3IIBtIEwEtM5W8wmikhQ+qeXt5AKGArDyBMkDHEgUrO3BZI3gG9J5
	 SfKFggwbws/vcZgpjDhzIlks83rIxG3idJa2J8ldWVKJ8NLP/eMM6Mt6YF1MUqu42H
	 k+eoeB364XiU2f+8c9nMn05RiVT6S/vupTJ8EHMHYZTY7TgU95RHXkCWBx0t9NaEu3
	 WLnJMhJd/q+l1rn2YdqpNHJ7CrU0NFlllHxsDnvEx5/V4v9Dk5khKx7dIvYD1TBgOm
	 oaXIE9AamurQw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52efc89dbedso692045e87.3
        for <stable@vger.kernel.org>; Thu, 25 Jul 2024 02:11:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0Yaqab4/UUtjxoPhW+MV5Bedp3YFdbRH0YQHsZCAuNp1KBRaNisd0CYY5/sK5w6hFoC02ISeVTHrSQ21EWfel9RUj07Al
X-Gm-Message-State: AOJu0YzWx+Coa3umzQxRGwVg48hGMo+ohe5a3fMJGk/btH+DMlGNScVN
	mhz4Vvx9Wocbb8Bha980347BYdBNKl439u5QG5Voc+U0FojSJJVbOSHaDQWjnzWeUVhX+0MQW4q
	aBEZxJQTNAAc2gV9m+oa6c6EGhO0=
X-Google-Smtp-Source: AGHT+IF7XrWn3IJHrokF18ERYvKorjLvmPd307AtcvlWEmc5QKIQk2cQVOXUH9R6WzcF81J60e/fP0C9tzjPEzzuZZ4=
X-Received: by 2002:a05:6512:3b8:b0:52f:df:db40 with SMTP id
 2adb3069b0e04-52fd60fb67dmr781942e87.56.1721898717191; Thu, 25 Jul 2024
 02:11:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725090345.28461-1-will@kernel.org>
In-Reply-To: <20240725090345.28461-1-will@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 25 Jul 2024 11:11:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEin0zf4poMAKwbLFdmdeWH8-L9AtbmtG6o3gYQyEZu-Q@mail.gmail.com>
Message-ID: <CAMj1kXEin0zf4poMAKwbLFdmdeWH8-L9AtbmtG6o3gYQyEZu-Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: Fix lockless walks with static and dynamic
 page-table folding
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org, 
	Asahi Lina <lina@asahilina.net>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jul 2024 at 11:03, Will Deacon <will@kernel.org> wrote:
>
> Lina reports random oopsen originating from the fast GUP code when
> 16K pages are used with 4-level page-tables, the fourth level being
> folded at runtime due to lack of LPA2.
>
> In this configuration, the generic implementation of
> p4d_offset_lockless() will return a 'p4d_t *' corresponding to the
> 'pgd_t' allocated on the stack of the caller, gup_fast_pgd_range().
> This is normally fine, but when the fourth level of page-table is folded
> at runtime, pud_offset_lockless() will offset from the address of the
> 'p4d_t' to calculate the address of the PUD in the same page-table page.
> This results in a stray stack read when the 'p4d_t' has been allocated
> on the stack and can send the walker into the weeds.
>
> Fix the problem by providing our own definition of p4d_offset_lockless()
> when CONFIG_PGTABLE_LEVELS <= 4 which returns the real page-table
> pointer rather than the address of the local stack variable.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/r/50360968-13fb-4e6f-8f52-1725b3177215@asahilina.net
> Fixes: 0dd4f60a2c76 ("arm64: mm: Add support for folding PUDs at runtime")
> Reported-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/pgtable.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

