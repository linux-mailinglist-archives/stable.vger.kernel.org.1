Return-Path: <stable+bounces-165079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6FFB14F59
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 16:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36A9172BE4
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 14:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4931474B8;
	Tue, 29 Jul 2025 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8/ngNd4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B40A482F2
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799818; cv=none; b=mMR6KK6grEJ6fn7UlvHGt3sB/yPiaKil/udy31u72n2IKihD9wasAebXCrQK36VMzByrU9FJu98x1S+vZttcwo40J5w0wrP4NJJWcE7oqlO3JXwGeCxb5DMkQOqn/zE+EH9rZopKYUSJIRsLp8oKWgPysR93jKSCP4dbfcliMcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799818; c=relaxed/simple;
	bh=L1QPu390gDZKrHJK/H4d8htqq3BzXKPLiS3xiYkMSHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcy3jdvDX+twGJS75ilbrFfbGhl3WfV1fvobyLBjjwbAgsHBdDqPFQV1sDq3drghE2pf23sN3KCkim6/iAngUZci6CbCzFdBWYSLkMYunyCNoS1E+IzrlC1xmD3z3xu5I+2JL3FD6I22l1PIyGwBipaAFuaaArEBa7+tNdbuuwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8/ngNd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D451C4CEEF;
	Tue, 29 Jul 2025 14:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753799817;
	bh=L1QPu390gDZKrHJK/H4d8htqq3BzXKPLiS3xiYkMSHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E8/ngNd4bGaJg6c/xEP9ig5es8++oZ9K1mWNJjsmmCpEd199CFarrR+pe4dAB0AGJ
	 0Zv+PZT3aFKzCXIZ32iFxhPuMW3NiFGLNg7eNWalD0aQPyH6izJvOd7xQSqBaQ6o2e
	 o47bLuTf5HgO7a4Zuznws5WJrRm0beVgcu63o5R1/wmFq5wGqR6w3atRWTNKgNM0Jt
	 Wpokt7RcP7tCjoRoqu09Pvw/Uh7X+uojM/sdPafzNf611kWjUlF5pmaV1hIY/KJW1N
	 sOXHlRo0+MIHAQrS0xO1dmN3sf1B8wNh0qP79ZMe0I/vQZ0jlLz1KcQ8USdu9UZw68
	 ykcUR5CxaSrWw==
Date: Tue, 29 Jul 2025 10:36:55 -0400
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.15.y] selftests: mptcp: connect: also cover alt modes
Message-ID: <aIjch3KtJoQFwaF-@lappy>
References: <2025072839-wildly-gala-e85f@gregkh>
 <20250729142019.2718195-1-sashal@kernel.org>
 <ce3d987f-047a-4b5d-a2e9-f924e0700b15@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ce3d987f-047a-4b5d-a2e9-f924e0700b15@kernel.org>

On Tue, Jul 29, 2025 at 04:32:21PM +0200, Matthieu Baerts wrote:
>Hi Sasha,
>
>On 29/07/2025 16:20, Sasha Levin wrote:
>> From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
>>
>> [ Upstream commit 37848a456fc38c191aedfe41f662cc24db8c23d9 ]
>>
>> The "mmap" and "sendfile" alternate modes for mptcp_connect.sh/.c are
>> available from the beginning, but only tested when mptcp_connect.sh is
>> manually launched with "-m mmap" or "-m sendfile", not via the
>> kselftests helpers.
>>
>> The MPTCP CI was manually running "mptcp_connect.sh -m mmap", but not
>> "-m sendfile". Plus other CIs, especially the ones validating the stable
>> releases, were not validating these alternate modes.
>>
>> To make sure these modes are validated by these CIs, add two new test
>> programs executing mptcp_connect.sh with the alternate modes.
>>
>> Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Geliang Tang <geliang@kernel.org>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> Link: https://patch.msgid.link/20250715-net-mptcp-sft-connect-alt-v2-1-8230ddd82454@kernel.org
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> [ Drop userspace_pm.sh from TEST_PROGS ]
>
>Thank you for having fixed the conflicts.
>
>Is it possible to hold this one for the moment? Yesterday, I was looking
>at this conflict, and when testing the same resolution as yours, I
>noticed mptcp_connect_sendfile.sh was failing on v5.15.y. I will
>investigate that.
>
>Please also note that this patch here will conflict with another you
>sent a few hours ago:
>
>  https://lore.kernel.org/20250729034856.2353329-1-sashal@kernel.org
>
>When the issues are fixed, I can send both of them again if that's OK
>for you.

Thats perfect, I'll skip backports for there. Thanks!

-- 
Thanks,
Sasha

