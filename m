Return-Path: <stable+bounces-23890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DB2868E4A
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 12:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78511C210DE
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 11:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C331386CB;
	Tue, 27 Feb 2024 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNmZQ1nB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBFE1386C9;
	Tue, 27 Feb 2024 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031869; cv=none; b=QgIMlWmyeUcRdYUSi8NTVo/j0NpGJ5QvXdA/NtyDE1KiKu9jIb58RC1r3Xt3SOsz36yn2rxrlWTzkc/uCpSfhvpF8TueYwQQO3vKVgAz/kCRU/r03R+/Vf2VlHFabjqj+VTi+v7t5nSC5NnZ6AE4YpDOzVndQQtMjIi/dxNGrSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031869; c=relaxed/simple;
	bh=+eT0W04oDcoulzCVOah98J+LgFw7VDmxlgxhssIsrow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2jwSwKEt4KhbkJdgbgA1+XubcCFofcbozIkhSa21f/DnE0cCUlG1oAVXxoUYawzd+Apx29bCtE0Y75UNBCcnnLaYy7t+9HijFWFCPMJoofca+zZk4uyr3ByBLtIOJD73BTc7e7ft5x2mp+fJmTjy2It9oC+kcptfs7oBX95/sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNmZQ1nB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C32DC433F1;
	Tue, 27 Feb 2024 11:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709031868;
	bh=+eT0W04oDcoulzCVOah98J+LgFw7VDmxlgxhssIsrow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XNmZQ1nBdCRHCCi6A9yyLoqPSexu48SJk4Kv8LswV69sqtuSFFVs93EjjlGhFDRe6
	 C7jLmP/9bGYRerDOLmHS/AI/MKNuj0wOqdLYmlBeyHzbHfo8co2nOiEMpDfxKK9RRU
	 ZCYChthYrRDCvSDIdgJIaIE9tOSR2zASawsATVmXRvnFncjHYS/dy7OhSQbXJQXmrf
	 vBIqMZe+BuaSgveVO1XIM+y+36dZ3yGl4I0FGfsyQoQVrEpj5gi2Mke+NXQp72OcK6
	 RUc18IU7jYbEMPMKonUjCviGYJQt2L+NdZb9PdzeFi+XdDyjo8/vX8HFzP8Ab9wzob
	 zLKyGPqZw+jHg==
Message-ID: <2c80d410-b480-4043-b17f-2aaa357e5d41@kernel.org>
Date: Tue, 27 Feb 2024 12:04:22 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] mptcp: add needs_id for netlink appending addr
Content-Language: en-GB, fr-BE
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
 Geliang Tang <tanggeliang@kylinos.cn>, Mat Martineau <martineau@kernel.org>,
 "David S . Miller" <davem@davemloft.net>
References: <2024022654-senate-unleaded-7ae3@gregkh>
 <20240226215620.757784-2-matttbe@kernel.org>
 <2024022723-outshoot-unkind-734f@gregkh>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2024022723-outshoot-unkind-734f@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg,

On 27/02/2024 11:22, Greg KH wrote:
> On Mon, Feb 26, 2024 at 10:56:21PM +0100, Matthieu Baerts (NGI0) wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> Just the same as userspace PM, a new parameter needs_id is added for
>> in-kernel PM mptcp_pm_nl_append_new_local_addr() too.
>>
>> Add a new helper mptcp_pm_has_addr_attr_id() to check whether an address
>> ID is set from PM or not.
>>
>> In mptcp_pm_nl_get_local_id(), needs_id is always true, but in
>> mptcp_pm_nl_add_addr_doit(), pass mptcp_pm_has_addr_attr_id() to
>> needs_it.
>>
>> Fixes: efd5a4c04e18 ("mptcp: add the address ID assignment bitmap")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> Signed-off-by: David S. Miller <davem@davemloft.net>
>> (cherry picked from commit 584f3894262634596532cf43a5e782e34a0ce374)
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Notes:
>>  - conflicts in pm_netlink.c because the new helper function expected to
>>    be on top of mptcp_pm_nl_add_addr_doit() which has been recently
>>    renamed in commit 1e07938e29c5 ("net: mptcp: rename netlink handlers
>>    to mptcp_pm_nl_<blah>_{doit,dumpit}").
>>  - use mptcp_pm_addr_policy instead of mptcp_pm_address_nl_policy, the
>>    new name after commit 1d0507f46843 ("net: mptcp: convert netlink from
>>    small_ops to ops").
>> ---
>>  net/mptcp/pm_netlink.c | 24 +++++++++++++++++++-----
>>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> Don't we also need a 5.15.y version of this commit?

Good point, yes, according to the 'Fixes' tag, we need it as well for
5.15.y.

It looks like no "FAILED: patch" notification has been sent for this
patch for the 5.15-stable tree. Is it normal?

I'm asking this because I rely on these notifications to know if I need
to help to fix conflicts. I don't regularly track if patches we sent
upstream with 'Cc: stable' & 'Fixes' tags have been backported. It is
just to know if we need to modify our way of working :)

> All of the backports you sent are now queued up, thanks!

Thank you for all the great work!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

