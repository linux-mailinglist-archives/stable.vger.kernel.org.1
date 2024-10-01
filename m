Return-Path: <stable+bounces-78338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA21698B69B
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B6A282712
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 08:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4DF16A92E;
	Tue,  1 Oct 2024 08:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B8L/Z+NC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CF938396;
	Tue,  1 Oct 2024 08:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770537; cv=none; b=W2tkC3fyp81A1U134yOUYIrmek4ov6PtZR3sCUc39kY+l4Xi27aLwuX7zGFLSin9fR9P4RoWfN2l0+e6H563BcL+3Ol8pYAoQyN1Vz46YwgRh6V7cJKTjz5Lw8nmgx7cMPvZqcon+3J63z3I5zdwuaVpSHbD+rOMdHvVlG7L3D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770537; c=relaxed/simple;
	bh=4Ed9G+ChgWSTEp/1IZz0ro9eTZq9QiI52P83aGDo4Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7bVr8msr6DwTeBhzd+YIorRs2h47zqelP7Gt+LjQ3YAAqpd0Z7vLSOVeKohPI+akmjuICtHDGws23ZHms82F9N5AUWhxOjFbnOkphVDSW9xc9TRsKuP4Mwuww8rAF3StM2piw1rWoVPZAe3sb29zrt9FPhDK2Bk8OJtlwAXrfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B8L/Z+NC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2055C4CEC6;
	Tue,  1 Oct 2024 08:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727770537;
	bh=4Ed9G+ChgWSTEp/1IZz0ro9eTZq9QiI52P83aGDo4Yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B8L/Z+NCi/Y18GTIMtBWiIKdYWp/cm+cvdd/xgqWml3iOoKBwnmcX50nuPT3D8HSK
	 ElIG3j6xv3hQuapwGmRsTBaPBuLH02zRzu0d1aza0y5ACAL+WT6ueAVkekEofyALFL
	 ajIriCO+sqkzb2JPJGo+Epryr8AizH5Cs0XAdQXI=
Date: Tue, 1 Oct 2024 10:15:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 5.10.y] mptcp: fix sometimes-uninitialized warning
Message-ID: <2024100124-conflict-tipped-f0b8@gregkh>
References: <20240930162345.3938790-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930162345.3938790-2-matttbe@kernel.org>

On Mon, Sep 30, 2024 at 06:23:46PM +0200, Matthieu Baerts (NGI0) wrote:
> Nathan reported this issue:
> 
>   $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 LLVM_IAS=1 mrproper allmodconfig net/mptcp/subflow.o
>   net/mptcp/subflow.c:877:6: warning: variable 'incr' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>     877 |         if (WARN_ON_ONCE(offset > skb->len))
>         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   include/asm-generic/bug.h:101:33: note: expanded from macro 'WARN_ON_ONCE'
>     101 | #define WARN_ON_ONCE(condition) ({                              \
>         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     102 |         int __ret_warn_on = !!(condition);                      \
>         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     103 |         if (unlikely(__ret_warn_on))                            \
>         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     104 |                 __WARN_FLAGS(BUGFLAG_ONCE |                     \
>         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     105 |                              BUGFLAG_TAINT(TAINT_WARN));        \
>         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     106 |         unlikely(__ret_warn_on);                                \
>         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     107 | })
>         | ~~
>   net/mptcp/subflow.c:893:6: note: uninitialized use occurs here
>     893 |         if (incr)
>         |             ^~~~
>   net/mptcp/subflow.c:877:2: note: remove the 'if' if its condition is always false
>     877 |         if (WARN_ON_ONCE(offset > skb->len))
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     878 |                 goto out;
>         |                 ~~~~~~~~
>   net/mptcp/subflow.c:874:18: note: initialize the variable 'incr' to silence this warning
>     874 |         u32 offset, incr, avail_len;
>         |                         ^
>         |                          = 0
>   1 warning generated.
> 
> As mentioned by Nathan, this issue is present because 5.10 does not
> include commit ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling"),
> which removed the use of 'incr' in the error path added by this change.
> This other commit does not really look suitable for stable, hence this
> dedicated patch for 5.10.
> 
> Fixes: e93fa44f0714 ("mptcp: fix duplicate data handling")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/20240928175524.GA1713144@thelio-3990X
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/subflow.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Now applied, thanks!

greg k-h

