Return-Path: <stable+bounces-128772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4730A7EF32
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 22:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCAD9446300
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503A1221D98;
	Mon,  7 Apr 2025 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="AwGA268g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBDF22172C;
	Mon,  7 Apr 2025 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056839; cv=none; b=f3qGllSClafHBVZrwCG9AwGHOzBtXOyX4kdHVsgU+gtN3wFaasiZ9mK5Q62ASkLn71cF3+L0O/OeWzIgFmPLOJsD2n53qLtbqxgQ4oa/9mdtWV9q4sTJEYBrsBYohEs/tqTxwHugeVKRQhHwn4rtsYEmit65Mknx2IAVW/YsDQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056839; c=relaxed/simple;
	bh=iS4xA7Ok13FSDlYWpCD7UzFDObbxp1JKpWxtQpsbUEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uY0Pu7XC9RGfL0yjZeIVAi2AezEtH/Lxudi2Hf0Eo+Rs6Uy2CmWPH9iTFwuV21nvV57IrrQNnPnXQ12NAPijzoBi+TM5j7s6VtkpCwMSnWBXpKS5KADZ4cxB7ScAP/OI9BM3onbRfH+UPyqQChhcXbKTSERFY1KCdlM/9yN5x6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=AwGA268g; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 1spiuwsF4bbeQ1spluTjHk; Mon, 07 Apr 2025 22:12:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1744056768;
	bh=LFVcj0T1trNXjFbnCqrDa083o0dcdDVTzV9eg2c08Zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=AwGA268gQIyWGySRXm2Xncly723fHjw7JQFoKd8zT+mKg52OBBmqeLGz4ZjXWNFVh
	 oJ7C1g9Gk6XGt62VNmAFgr8XkAj3qMXOQkZ2h02mFq/GXt2auJz70XcrrWQZZGYIy9
	 MJy6ROfYM6OMFPpog/mT1TVhbMRmKp8dNFYCepUoH3r+oRTexft2/l8NOJoJm2cuUk
	 T+kwcyIguSsMgc8uMHMab0z0Uy5ap08OpxrR0SmONOAim6ANmVXD8KM9syUKD+W5/+
	 dXY9gTt8M61RvusSbvdrRAUTAnf2NL7KyyKw/DFVr2FWTn/hcgCzmI8nfvDx77LYNe
	 OpNrCsttR/xJQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 07 Apr 2025 22:12:48 +0200
X-ME-IP: 90.11.132.44
Message-ID: <1bbc9abf-2554-4e30-9aee-f8485d732ba1@wanadoo.fr>
Date: Mon, 7 Apr 2025 22:12:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: Use kvzalloc for large exit_dump allocation
To: Breno Leitao <leitao@debian.org>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org, Rik van Riel <riel@surriel.com>
References: <20250407-scx-v1-1-774ba74a2c17@debian.org>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250407-scx-v1-1-774ba74a2c17@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 07/04/2025 à 21:50, Breno Leitao a écrit :
> Replace kzalloc with kvzalloc for the exit_dump buffer allocation, which
> can require large contiguous memory (up to order=9) depending on the
> implementation. This change prevents allocation failures by allowing the
> system to fall back to vmalloc when contiguous memory allocation fails.
> 
> Since this buffer is only used for debugging purposes, physical memory
> contiguity is not required, making vmalloc a suitable alternative.
> 
> Cc: stable@vger.kernel.org
> Fixes: 07814a9439a3b0 ("sched_ext: Print debug dump after an error exit")
> Suggested-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   kernel/sched/ext.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 66bcd40a28ca1..c82725f9b0559 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4639,7 +4639,7 @@ static struct scx_exit_info *alloc_exit_info(size_t exit_dump_len)
>   
>   	ei->bt = kcalloc(SCX_EXIT_BT_LEN, sizeof(ei->bt[0]), GFP_KERNEL);
>   	ei->msg = kzalloc(SCX_EXIT_MSG_LEN, GFP_KERNEL);
> -	ei->dump = kzalloc(exit_dump_len, GFP_KERNEL);
> +	ei->dump = kvzalloc(exit_dump_len, GFP_KERNEL);

Needs kvfree() in free_exit_info()?

CJ

>   
>   	if (!ei->bt || !ei->msg || !ei->dump) {
>   		free_exit_info(ei);
> 
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20250407-scx-11dbf94803c3
> 
> Best regards,



