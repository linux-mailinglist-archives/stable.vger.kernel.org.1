Return-Path: <stable+bounces-192372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BC9C30D81
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 12:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E27146043E
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D9B2E9721;
	Tue,  4 Nov 2025 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzNUNwLC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3143D1A76D4;
	Tue,  4 Nov 2025 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257469; cv=none; b=MtO+2WyWEIa2QchhmleXzKOyofbP6nhQG2E26Y1CMbfxrnG70iL2viQ7XqP2V7Jvkq+YKunIqKdv9z3ik3GuiOcn9KySyb106rh8cZihNMi9H7SpsTeYX2a9V7/Y1vLuuTf/aA4nRay2HJKCuacrFH71el8QeXrJo53Yb3DjXRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257469; c=relaxed/simple;
	bh=Oz8omsLitZQmSSR4Y9bFJeaA6ZlBFlMJ8H5e0zMr6JU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUXtQDHdA9HeHlZYkH1Bps5BFcWP3VBmt29Y+lKKAwjUtJBEzI+zecpWz3RzELvU67qO0zR3pO6e3nHyNV8hPoN22DxkMXIeUjnGwf5sgFwwFgofHNqBeDUreicut3QfxUVFNLMCAVP6LGW9Sa47VBEng05EeWuZ8QFrtziRL0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzNUNwLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55485C116C6;
	Tue,  4 Nov 2025 11:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762257467;
	bh=Oz8omsLitZQmSSR4Y9bFJeaA6ZlBFlMJ8H5e0zMr6JU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UzNUNwLCqBBx0hc5yLBnUjDZJD42m+8kue6jXprPCE0Ii/Y0pFQ60TTO0nfBlbVgv
	 25y1hF3sHnAqAIJH0Mkfa6dBAmX1LSLHzs+B2zOF/T1eer/wFEGq9juSdRvf+EkrOs
	 uCMlpXv2hI4RNr7+SbPGg+X2GystOrVxOSwE4aSh3yDJdNsmGn6HLtH7+HrHKJ+nVH
	 G7uYCVSsxldElm21gt6JnhUsYOUTmtcR9eQGmsPuT0+RbUoEpjjeicwtGZOo1lLvjt
	 DUV+UoK8Xb08/cCDW7zZDLj4nTzhJvH0JrrChTByBnpoxmxPSBjSovcZO1L/5kmAuH
	 cYgZcB+AumjCA==
Message-ID: <8fb50fe3-e958-4bfa-ba70-ada659a208a9@kernel.org>
Date: Tue, 4 Nov 2025 12:57:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 6.12.y-5.10.y] selftests: mptcp: connect modes: re-add
 exec mode
Content-Language: en-GB, fr-BE
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, sashal@kernel.org,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <20251103165433.6396-2-matttbe@kernel.org>
 <2025110410-cake-tasty-1a16@gregkh>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2025110410-cake-tasty-1a16@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg,

On 04/11/2025 00:54, Greg KH wrote:
> On Mon, Nov 03, 2025 at 05:54:34PM +0100, Matthieu Baerts (NGI0) wrote:
>> It looks like the execution permissions (+x) got lost during the
>> backports of these new files.
>>
>> The issue is that some CIs don't execute these tests without that.
>>
>> Fixes: 37848a456fc3 ("selftests: mptcp: connect: also cover alt modes")
>> Fixes: fdf0f60a2bb0 ("selftests: mptcp: connect: also cover checksum")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> I'm not sure why they got lost, maybe Quilt doesn't support that? But
>> then, can this patch still be applied?
>> The same patch can be applied up to v5.10. In v5.10, only
>> mptcp_connect_mmap.sh file is present, but I can send a dedicated patch
>> for v5.10.
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh | 0
>>  tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh     | 0
>>  tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh | 0
>>  3 files changed, 0 insertions(+), 0 deletions(-)
>>  mode change 100644 => 100755 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh
>>  mode change 100644 => 100755 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
>>  mode change 100644 => 100755 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh
>> old mode 100644
>> new mode 100755
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
>> old mode 100644
>> new mode 100755
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh
>> old mode 100644
>> new mode 100755
>> -- 
>> 2.51.0
>>
>>
> 
> This is going to be a pain to apply, given that we use quilt, and that
> does not handle modes well, if at all.
> 
> So yes, that is why these files are not marked executable, but I thought
> we were moving away from that anyway, most scripts should not be marked
> that way.

I see. I should be able to find a solution:

- some CIs use kselftest's runner.sh script, and kernels >= 5.10 have a
fix thanks to 303f8e2d0200 ("selftests/kselftest/runner/run_one(): allow
running non-executable files"): it prints a warning, so I thought I had
to fix it, but fine to keep the warning and drop the fix.

- Others try to execute the scripts directly, but I should be able to
fix those.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


