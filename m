Return-Path: <stable+bounces-91986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 739D99C2C44
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 12:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7D3282B06
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 11:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862181465B1;
	Sat,  9 Nov 2024 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLEAawyY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40025433BB;
	Sat,  9 Nov 2024 11:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731153040; cv=none; b=gKqgkJBOStrxuvc4LM9Y9O3sNKSj1cor15YuLoSxc2fYmn925cHjSwjecb5FjSN0yqOXmfeFQniaqnie+KhTucjyKaTAGbXmMJpeRl7KDcUdVCvQe/bOSbI/AjS1OD76s+WLMWPZn9gfsaucfnI2HyN1yA36TDgbd9Ngh6sY8Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731153040; c=relaxed/simple;
	bh=eaxmgObWLM6CdEAKEpPmHeyMuOW5lMJyIr1SWJK8la0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBA+9bh6TxIvwQR0RSnLZhuF2L1iCJ2yDvpaJe8CgdIsO9lwvgPgmSlPMDtOPGQJZ9wXXsyfUrrOzpE1qswOxq7T+238b+emopIi8a80f2JWC4iIS0IzEg4+Fv3hCV7UHexO6advk/rQWx/nFMmfn3000tRZFAiAAkDrdWf5tmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLEAawyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4C5C4CECE;
	Sat,  9 Nov 2024 11:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731153039;
	bh=eaxmgObWLM6CdEAKEpPmHeyMuOW5lMJyIr1SWJK8la0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLEAawyYweiFFmPBJ/isbowd+alEARgKHdnO6f8H8Q9apyrva3cNrGxzH1wVXS0nU
	 wTx+KJ0t4rdyTyp+hIosqkCGCFkx1rYwP20xt+b1d940AxaFV8P7TGbR4di9Eqiljz
	 HaWFbIz5FoGbhivivtbUwvTf9LCc4J9/Z29c2uGcdNwQsyLVeDOu7kKl3P+GyOamdJ
	 2YrZNGYaHbXeLPrMa/Jfpfgod0dgf1MGgkYJCpx7IFZH/0U05Ry2e1ru/90j3LjtzM
	 6imvwfh4Z7d89gGAuLSQAkW+KMx7BpXrUoGHJ3qz9BDueb9/JL+m8jI9BmxugPs2vl
	 QeX0Qidm3W3tQ==
Date: Sat, 9 Nov 2024 06:50:39 -0500
From: Sasha Levin <sashal@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: stable@vger.kernel.org, bsegall@google.com,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "posix-cpu-timers: Clear TICK_DEP_BIT_POSIX_TIMER
 on clone" failed to apply to v6.1-stable tree
Message-ID: <Zy9Mj3-aapIyw8Nu@sashalap>
References: <20241106021018.179970-1-sashal@kernel.org>
 <ZyyTHGkchGzeHBx3@pavilion.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyyTHGkchGzeHBx3@pavilion.home>

On Thu, Nov 07, 2024 at 11:14:52AM +0100, Frederic Weisbecker wrote:
>Hi,
>
>Le Tue, Nov 05, 2024 at 09:10:17PM -0500, Sasha Levin a écrit :
>> The patch below does not apply to the v6.1-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.
>
>
>Can you try with this updated version on the failing trees?

Queued up, thanks!

-- 
Thanks,
Sasha

