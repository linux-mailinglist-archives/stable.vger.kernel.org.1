Return-Path: <stable+bounces-196759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1483C81508
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 16:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 01C39348FB0
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 15:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5B731812E;
	Mon, 24 Nov 2025 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAdTIE5m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7B23176E3
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763997596; cv=none; b=Fi7/Ov0LjuQw1WRwlh1XMJ5ODkI/N2jywoovgYijaojIMPflxXyWcR4VmnrN3rYB5MCDI/ItVt2lGRbrred6mGvc8jm6eMEqqKiEhDDvD6cfedXnqqx4E8pbDBTk56cy6UwvV+Z22J59HIMVUBflEDOeQDJt0QJ9HQBTDD4dQes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763997596; c=relaxed/simple;
	bh=Th5Aur9Evfw5uQL4XI1DDwjCLq0Vfh1XVNf1hPvMCJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHkCgKjm/8SKj05qDXlQ2jcCycGQdPMLT5mh0BKrtdp79B/RheDv+WfaCF81JHjZTxF5COp9ruq4EC1w+cZ2KCS1JKE3V3cAGScvtnvCTghJgODZs26YpKHlk/UTAijIiFdyfziDy/Gi+yNzSUKLH/7UFkjpPmoH3FJEK7wPHs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAdTIE5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A65C116D0;
	Mon, 24 Nov 2025 15:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763997596;
	bh=Th5Aur9Evfw5uQL4XI1DDwjCLq0Vfh1XVNf1hPvMCJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HAdTIE5mWLVg64tyiq0rE353ORgZDBLrsD8Mq7kbbnhCrog1NRD3yzvevjks1Ywzd
	 AiDmnjA6xqFuxlMB0G0WZmEbDQwWILUUIqduEkT3zFSbJ4UEKZLQ1HewOmBKIB6/AF
	 SSCKSL9PlXQWP15ijw2aVoddKo2q+KIcGpKMLbN8wbzJa0eOUUS8HMthGUyGJ+wTG7
	 wW7IYis2zXHq26qRfDWReHSTtSjQVBq6p2XIyMWvblaTRdj/IzdIvKQ1zBXlFlCl/z
	 JowmSXQYjcvGwOGD8twobT+msDIARP+T9OV+dysTCTRUEqC1XRevRK+1psD6FC0hbP
	 l/UVXM83o/2lw==
Date: Mon, 24 Nov 2025 10:19:54 -0500
From: Sasha Levin <sashal@kernel.org>
To: Sebastian Ene <sebastianene@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 6.6.y] KVM: arm64: Check the untrusted offset in FF-A
 memory share
Message-ID: <aSR3mrQM_DlFeOGd@laps>
References: <2025112429-pasture-geometry-591b@gregkh>
 <20251124141134.4098048-1-sashal@kernel.org>
 <2025112405-campus-flatworm-25a5@gregkh>
 <aSRy8LqAopE82ZPs@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aSRy8LqAopE82ZPs@google.com>

On Mon, Nov 24, 2025 at 03:00:00PM +0000, Sebastian Ene wrote:
>On Mon, Nov 24, 2025 at 03:50:45PM +0100, Greg KH wrote:
>> On Mon, Nov 24, 2025 at 09:11:34AM -0500, Sasha Levin wrote:
>> > From: Sebastian Ene <sebastianene@google.com>
>> >
>> > [ Upstream commit 103e17aac09cdd358133f9e00998b75d6c1f1518 ]
>> >
>> > Verify the offset to prevent OOB access in the hypervisor
>> > FF-A buffer in case an untrusted large enough value
>> > [U32_MAX - sizeof(struct ffa_composite_mem_region) + 1, U32_MAX]
>> > is set from the host kernel.
>> >
>> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
>> > Acked-by: Will Deacon <will@kernel.org>
>> > Link: https://patch.msgid.link/20251017075710.2605118-1-sebastianene@google.com
>> > Signed-off-by: Marc Zyngier <maz@kernel.org>
>> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>> > ---
>> >  arch/arm64/kvm/hyp/nvhe/ffa.c | 9 +++++++--
>> >  1 file changed, 7 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
>> > index 8d21ab904f1a9..eacf4ba1d88e9 100644
>> > --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
>> > +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
>> > @@ -425,7 +425,7 @@ static void __do_ffa_mem_xfer(const u64 func_id,
>> >  	DECLARE_REG(u32, npages_mbz, ctxt, 4);
>> >  	struct ffa_composite_mem_region *reg;
>> >  	struct ffa_mem_region *buf;
>> > -	u32 offset, nr_ranges;
>> > +	u32 offset, nr_ranges, checked_offset;
>> >  	int ret = 0;
>> >
>> >  	if (addr_mbz || npages_mbz || fraglen > len ||
>> > @@ -460,7 +460,12 @@ static void __do_ffa_mem_xfer(const u64 func_id,
>> >  		goto out_unlock;
>> >  	}
>> >
>> > -	if (fraglen < offset + sizeof(struct ffa_composite_mem_region)) {
>> > +	if (check_add_overflow(offset, sizeof(struct ffa_composite_mem_region), &checked_offset)) {
>> > +		ret = FFA_RET_INVALID_PARAMETERS;
>> > +		goto out_unlock;
>> > +	}
>
>hello Greg,
>
>>
>> I was told that a "straight" backport like this was not correct, so we
>> need a "better" one :(
>>
>> Sebastian, can you provide the correct backport for 6.6.y please?
>>
>
>I think Sasha's patch is doing the right thing. Sasha thanks for
>posting it so fast.

For the record, my patch just adjusted line numbers a bit, there were no
conflicts.

>I looked up the other faild patches on stable and the reason why the patch doesn't
>apply is because we don't have the FF-A proxy inthe following versions:
> - 5.4, 5.10, 5.15, 6.1

Right, I noticed that and assumed that this isn't needed on those older trees.

-- 
Thanks,
Sasha

