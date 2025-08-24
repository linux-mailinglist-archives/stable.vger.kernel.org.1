Return-Path: <stable+bounces-172696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957FCB32E05
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 09:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734803BC64E
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 07:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9837C24DCE3;
	Sun, 24 Aug 2025 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFSSjRfN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5537114F70
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756021515; cv=none; b=gs2b6CXXO7KWeAfDW5053S/3Ew93T/FxDC+yRIPj1do88gLq1+WdfnAFncYqdipFoGM9/MwpFGQ7q9sYgIpb6FosLHc1xsi4Z7xt2QDyAXxvwt8M211F+8Wos+wNjdM0kOfIJzCyuhmOwTwYK8WjV7nzruG6G8Ih+n5q13faq2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756021515; c=relaxed/simple;
	bh=VUvfjAu7bzHCBEbybRBS0mtkVsciWBQ/Z1rJYPlYaB4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=WsEW61ruSgw8wg5VqBSBz4rJGGIhOseAlcz1XoziJE+JxHdxvhlVpux4m8f48QDZjbFHx/iszxzbOxo1h+QaWOQM1U5xhya5os/klZfQSmiv0oNlB3z9HT/zooRiiTIYeBQ7HIJ1p+3l3qT3XjT3gg1ilOwGVwCQprGf8Yt6hiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFSSjRfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F07FC4CEEB;
	Sun, 24 Aug 2025 07:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756021514;
	bh=VUvfjAu7bzHCBEbybRBS0mtkVsciWBQ/Z1rJYPlYaB4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=TFSSjRfNiL2x7NJj/vU+AFfAsUmkN6OKyBykairFsgaPwKA6u93pBMDWHYwFsmHoo
	 Z5YSLnVjwt/LLQYKCr0LDfVc+wImACifDoPBKbpB/tY04Bmlw6JO7YYntku3dYNmyR
	 NaVS9vcAQCeWGUWztSQYS0NH9ewonvSg1AFNK/XjJFcOZxXuPY5Uxy5Mkq7iPrymQT
	 EHEbLSLST0wUpfsO8u6mKPoer3ztMRSl9M5TWVzFlDxkQPj8zDoS8WtQFcIBx2cuaY
	 nU1fs2Iwm1PownZKnA/y+NmOEnT/6rimjdLOsCcZ1ZJd5sOtv4oqWoF0BSx4s0f/H3
	 3zs04YvO85JdQ==
Date: Sun, 24 Aug 2025 09:45:09 +0200 (GMT+02:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Jakub Kicinski <kuba@kernel.org>
Message-ID: <49616650-6430-480b-99ee-0adf5cc30c77@kernel.org>
In-Reply-To: <2025082408-ascent-transfer-2883@gregkh>
References: <2025082230-overlay-latitude-1a75@gregkh> <20250823143406.2247894-1-sashal@kernel.org> <2025082442-relatable-obstinate-7f10@gregkh> <e39b9a56-90c5-4379-bc6a-22a719c67848@kernel.org> <2025082408-ascent-transfer-2883@gregkh>
Subject: Re: [PATCH 6.1.y] mptcp: remove duplicate sk_reset_timer call
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <49616650-6430-480b-99ee-0adf5cc30c77@kernel.org>

Hi Greg,

24 Aug 2025 09:15:22 Greg KH <gregkh@linuxfoundation.org>:

> On Sun, Aug 24, 2025 at 09:08:06AM +0200, Matthieu Baerts wrote:
>> Hi Greg, Sasha,
>>
>> 24 Aug 2025 09:02:56 Greg KH <gregkh@linuxfoundation.org>:
>>
>>> On Sat, Aug 23, 2025 at 10:34:06AM -0400, Sasha Levin wrote:
>>>> From: Geliang Tang <geliang@kernel.org>
>>>>
>>>> [ Upstream commit 5d13349472ac8abcbcb94407969aa0fdc2e1f1be ]
>>>>
>>>> sk_reset_timer() was called twice in mptcp_pm_alloc_anno_list.
>>>>
>>>> Simplify the code by using a 'goto' statement to eliminate the
>>>> duplication.
>>>>
>>>> Note that this is not a fix, but it will help backporting the following
>>>> patch. The same "Fixes" tag has been added for this reason.
>>>>
>>>> Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>> Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-4-521fe9957892@kernel.org
>>>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>>>> [ adjusted function location from pm.c to pm_netlink.c ]
>>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>>> ---
>>>> net/mptcp/pm_netlink.c | 5 ++---
>>>> 1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> Didn't apply cleanly :(
>>
>> I don't know if it is the reason, but I sent the same patches on Friday:
>>
>> https://lore.kernel.org/20250822141124.49727-5-matttbe@kernel.org/T
>
> And it didn't apply either?
>
> I'm confused...

It looks like you first applied this other patch from Sasha for 6.1.y:

https://lore.kernel.org/20250823145534.2259284-1-sashal@kernel.org

But this patch includes the one here you are trying to apply, instead of
depending on it.

In terms of code, the result is the same, but there is now one commit
instead of 2. (Which is fine for me)

Cheers,
Matt

