Return-Path: <stable+bounces-73717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11E096EDE6
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810D7287438
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 08:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEE415748F;
	Fri,  6 Sep 2024 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dD7+4aEb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361CD15749A;
	Fri,  6 Sep 2024 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611145; cv=none; b=sALmRlFceOB88xRzEgdXouLO9+kZN76hhZdoVIAJUfWk8CWxLLRZ2qXqPX1+j4tetGeOZX0tUIUnfRECEdhYoD6xFCeB6rl200sPraQ9+c3O0FIsJ2SKOCyu+Irxm61oqZWsbYQ1TUmuC/lrezvtjSS1zdcWwaDhreS6YKpjNi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611145; c=relaxed/simple;
	bh=ZmPaVjLELtnhxpW3wpz5AsZ4Xd6hRA8J3SFowNgRP8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toDoTM7UbvatUOuwr1EJrp1ATKdX5ltfu8H006nkzCb1QIhTT8zpx1u6e9htxMmXBhRy+qDuEo/SjW2yRJO1ti24IfsXN94neH6s6arjFpHC+QcE2tnqL29M83GEkJWdjYN96i9/eM/oYhc5ERQ5kIhJY7wrdpiAR0SHstSm2fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dD7+4aEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B340CC4CEC4;
	Fri,  6 Sep 2024 08:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725611144;
	bh=ZmPaVjLELtnhxpW3wpz5AsZ4Xd6hRA8J3SFowNgRP8Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dD7+4aEbjXcXXVxWOWuAx73xlT5aSFf5oYRYZrH2ACdK8tkUEBxdFymSlVGp5YPO/
	 DE80MHdrX95dyTE6Auy3Y0ZPmhHSxGblIzZ0fBl+BfgQuVsESXUnTVhFhG8+s5+WAR
	 iyBeUMkX/sX8+eaRDZO/9slfEiN3kJrKNNLT0O2IbBuEfyek3xyPxfxhm481u/C8Ok
	 0D4tQwxcABpVDR2jSOZ2A3CPWsQIGqCfOD1ebfpjKweHcDz1S2kP2/aPjARmrlWAn7
	 zLHs0HndEyit/RoKMbUVKNvp67S3Y5Cwz3DjUQY7lOu2rJqiiZTGYkFa0DQjOFlPND
	 RNovUamNXAoAQ==
Message-ID: <60b65618-e025-444b-bb72-67db4592b60a@kernel.org>
Date: Fri, 6 Sep 2024 10:25:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: FAILED: patch "[PATCH] mptcp: pm: only mark 'subflow' endp as
 available" failed to apply to 5.15-stable tree
Content-Language: en-GB
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, kuba@kernel.org, martineau@kernel.org,
 MPTCP Linux <mptcp@lists.linux.dev>
References: <2024082627-devotion-chewer-87af@gregkh>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2024082627-devotion-chewer-87af@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg,

On 26/08/2024 14:06, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Thank you for the notification!

(...)

> ------------------ original commit in Linus's tree ------------------
> 
> From 322ea3778965da72862cca2a0c50253aacf65fe6 Mon Sep 17 00:00:00 2001
> From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
> Date: Mon, 19 Aug 2024 21:45:26 +0200
> Subject: [PATCH] mptcp: pm: only mark 'subflow' endp as available
> 
> Adding the following warning ...
> 
>   WARN_ON_ONCE(msk->pm.local_addr_used == 0)
> 
> ... before decrementing the local_addr_used counter helped to find a bug
> when running the "remove single address" subtest from the mptcp_join.sh
> selftests.
> 
> Removing a 'signal' endpoint will trigger the removal of all subflows
> linked to this endpoint via mptcp_pm_nl_rm_addr_or_subflow() with
> rm_type == MPTCP_MIB_RMSUBFLOW. This will decrement the local_addr_used
> counter, which is wrong in this case because this counter is linked to
> 'subflow' endpoints, and here it is a 'signal' endpoint that is being
> removed.
> 
> Now, the counter is decremented, only if the ID is being used outside
> of mptcp_pm_nl_rm_addr_or_subflow(), only for 'subflow' endpoints, and
> if the ID is not 0 -- local_addr_used is not taking into account these
> ones. This marking of the ID as being available, and the decrement is
> done no matter if a subflow using this ID is currently available,
> because the subflow could have been closed before.
> 
> Fixes: 06faa2271034 ("mptcp: remove multi addresses and subflows in PM")

Similar to my previous message linked to the backport of "mptcp: pm:
re-using ID of unused removed ADD_ADDR" where this patch depends on
86e39e04482b ("mptcp: keep track of local endpoint still available for
each msk"), I don't think we need to backport this patch to v5.15.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


