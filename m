Return-Path: <stable+bounces-55934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 657CF91A249
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 11:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1421F2190B
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 09:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B9913A89B;
	Thu, 27 Jun 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VO6ILtDY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BACB52F6F;
	Thu, 27 Jun 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479430; cv=none; b=sExwB69Jr8tKayxiS2ZN47FZxJVnMZGJHC3FMKpHY8XYsaZhjaUuXliGM3WVhnSeLk4iphdNAV0SUpaUaJ5178TnK+Pyt0LkD6KFZTOKyxl2Vm/F9uhQGcOA2vPGme5iRNbv5I1lIxlg5lkeYLcDiKDpTOz8luFRBTwiFBf1mQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479430; c=relaxed/simple;
	bh=uDKlsUXqKAfSClHMDYBZ9Pm/y+dcK1pKjtuWafLWA6k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PmQT5T30ft0QwziFxojCLWzKK9SJDXIGsTs4iy0Ww2EodvPuBIrMOOK2umd1CFHrMkDyccYcIEG/OSCb7gGIhY0o2tYHeQRhWLm4loHqJ9mjhCeGQsC038Ir/taT5I/IjlBpKVfIvXVcq/GMOfAe3tUd2ArFC+9Dd8ER9QUAnUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VO6ILtDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0E85C2BD10;
	Thu, 27 Jun 2024 09:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719479429;
	bh=uDKlsUXqKAfSClHMDYBZ9Pm/y+dcK1pKjtuWafLWA6k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VO6ILtDY6fZVOqJrcl4Hh6kLjikk7lhPoNcVGDHVuyotglJs3VnINW4yG8sJPuGzk
	 m3LF7jziakbbd8SnE86zRL+kpSwRGvwFgt54I5P7ysESjJJaOGX9qWyXWCMwopG/Ar
	 oMRVfae5+ARtVXAUdZFqXHKr/zGp4E/dwZ0Vb3/rxuc826SiyvdVA6FD2AfnJkb2Bs
	 QyDhKWYxTnOw4XHfyWph8LNCvlH3RDk/BWiE5oaJW9N27DOEF33T2/p0sLsLJ3z2E5
	 97rCB67a6ptW702vfvPhbTJyn/rDauBTuPHIjZQvtmLeiPKJfTmnm6Rha12JzLypNz
	 1VR3nAj+NYmKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD31EC4167D;
	Thu, 27 Jun 2024 09:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] tracing/net_sched: NULL pointer dereference in
 perf_trace_qdisc_reset()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171947942983.14380.4180418351176781386.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 09:10:29 +0000
References: <20240624173320.24945-4-yskelg@gmail.com>
In-Reply-To: <20240624173320.24945-4-yskelg@gmail.com>
To: Yunseong Kim <yskelg@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 tiwai@suse.de, davem@davemloft.net, thomas.hellstrom@linux.intel.com,
 rafael@kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ap420073@gmail.com, pctammela@mojatatu.com, austindh.kim@gmail.com,
 shjy180909@gmail.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pbuk5246@gmail.com, stable@vger.kernel.org, yeoreum.yun@arm.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 25 Jun 2024 02:33:23 +0900 you wrote:
> From: Yunseong Kim <yskelg@gmail.com>
> 
> In the TRACE_EVENT(qdisc_reset) NULL dereference occurred from
> 
>  qdisc->dev_queue->dev <NULL> ->name
> 
> This situation simulated from bunch of veths and Bluetooth disconnection
> and reconnection.
> 
> [...]

Here is the summary with links:
  - [v4] tracing/net_sched: NULL pointer dereference in perf_trace_qdisc_reset()
    https://git.kernel.org/netdev/net/c/bab4923132fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



