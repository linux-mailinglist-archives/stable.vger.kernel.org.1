Return-Path: <stable+bounces-25876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA25386FE65
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 11:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7491C21EFD
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 10:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB302574D;
	Mon,  4 Mar 2024 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGXYevRC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CEC2511E
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546825; cv=none; b=iX6swM3SW/zj8wyumRHm7/6Q3XRFaxclae74jpSJXrJv1j5/hAmjyXx7y/DBACHxMuhKeJEu3zoPpe0sx9zrOZrFRClmkRzabJEtyssnqrx9FLCeZ1Eox1QrjTSn67f7z6FF2HHGzZIN3Yx0b0xTSypq1BNNaqjhoMgxfwq+mAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546825; c=relaxed/simple;
	bh=p6GSb9bW7OJO7kCEYNzsURvHuAGgxrcUix6wGe7xD1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5vAFO2DvHeuBpBqa1gL2FtghfdRs2IvllQJlUeSYWCZ4QL90qzcaqoomxRNxL+f8PxZ+lQgVXM/iXo311T05UxzOh+XtyuT0Qjs1seViYrSgw40w+qE6mtNtwVeO1f8tdKeKEhYWcPFPuqblm/OeysNJK01Na85k4gtmC4XUEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGXYevRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4198EC43390;
	Mon,  4 Mar 2024 10:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709546824;
	bh=p6GSb9bW7OJO7kCEYNzsURvHuAGgxrcUix6wGe7xD1c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UGXYevRC6sE90Y5KwhmbOvWjGibL2jBokxtUHNt1co5i+m1uKnK95FygArfyEgfXS
	 ynMOghrgG9XgXU/DTxhalL4gqCqH1Tkzyz04Tg7P0aLJ7VltsJtqtrUAMcieNOwpF/
	 k15L+HmzOfvNUZpV4QY8K+/eiSaFOWxcmUJf5Geesr1yauqbpdpgL+q6M2iqvnO8WW
	 n3aIx0HSSF8cBzVswuAKvUMwZOpG71wzh4ggHQh15Jgx88U+DDWTvsQitwytlzs4ir
	 pTKvoIm9CEFDPo/6HlUkss8P6e1BTLES357tBWXQiQQcL0P+C3ya5VVDSO4ifvOtE/
	 /pbgHMw9Jnq8A==
Message-ID: <0991a6b7-2d74-4f26-9959-68d745086902@kernel.org>
Date: Mon, 4 Mar 2024 11:07:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] selftests: mptcp: rm subflow with
 v4/v4mapped addr" failed to apply to 6.1-stable tree
Content-Language: en-GB, fr-BE
To: gregkh@linuxfoundation.org, tanggeliang@kylinos.cn, kuba@kernel.org,
 martineau@kernel.org
Cc: stable@vger.kernel.org
References: <2024030422-dinner-rotten-5ef3@gregkh>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2024030422-dinner-rotten-5ef3@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg,

On 04/03/2024 09:30, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 6.1-stable tree.

Thank you for the notification!

(...)

> Possible dependencies:
> 
> 7092dbee2328 ("selftests: mptcp: rm subflow with v4/v4mapped addr")
> b850f2c7dd85 ("selftests: mptcp: add mptcp_lib_is_v6")
> bdbef0a6ff10 ("selftests: mptcp: add mptcp_lib_kill_wait")
> 757c828ce949 ("selftests: mptcp: update userspace pm test helpers")
> 80775412882e ("selftests: mptcp: add chk_subflows_total helper")
> 06848c0f341e ("selftests: mptcp: add evts_get_info helper")
> 9168ea02b898 ("selftests: mptcp: fix wait_rm_addr/sf parameters")
> f4a75e9d1100 ("selftests: mptcp: run userspace pm tests slower")
> 03668c65d153 ("selftests: mptcp: join: rework detailed report")
> 9e86a297796b ("selftests: mptcp: sockopt: format subtests results in TAP")
> 7f117cd37c61 ("selftests: mptcp: join: format subtests results in TAP")
> c4192967e62f ("selftests: mptcp: lib: format subtests results in TAP")
> e198ad759273 ("selftests: mptcp: userspace_pm: uniform results printing")
> 8320b1387a15 ("selftests: mptcp: userspace_pm: fix shellcheck warnings")
> e141c1e8e4c1 ("selftests: mptcp: userspace pm: don't stop if error")
> e571fb09c893 ("selftests: mptcp: add speed env var")
> 4aadde088a58 ("selftests: mptcp: add fullmesh env var")
> 080b7f5733fd ("selftests: mptcp: add fastclose env var")
> 662aa22d7dcd ("selftests: mptcp: set all env vars as local ones")
> 966c6c3adfb1 ("selftests: mptcp: userspace_pm: report errors with 'remove' tests")

(...)

> ------------------ original commit in Linus's tree ------------------
> 
> From 7092dbee23282b6fcf1313fc64e2b92649ee16e8 Mon Sep 17 00:00:00 2001
> From: Geliang Tang <tanggeliang@kylinos.cn>
> Date: Fri, 23 Feb 2024 17:14:12 +0100
> Subject: [PATCH] selftests: mptcp: rm subflow with v4/v4mapped addr
> 
> Now both a v4 address and a v4-mapped address are supported when
> destroying a userspace pm subflow, this patch adds a second subflow
> to "userspace pm add & remove address" test, and two subflows could
> be removed two different ways, one with the v4mapped and one with v4.
I don't think it is worth having this patch backported to v6.1: there
are a lot of conflicts because this patch depends on many others. Also,
many CIs validating stable trees will use the selftests from the last
stable version, I suppose. So this new test will be validated on older
versions.

For v6.6 and v6.7, I can help to fix conflicts. I will just wait for the
"queue/6.6" and "queue/6.7" branches to be updated with the latest
patches :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

