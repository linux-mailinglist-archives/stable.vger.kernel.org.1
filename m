Return-Path: <stable+bounces-37827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C21E89CF36
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 02:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD8F1F232FF
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 00:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D18829A9;
	Tue,  9 Apr 2024 00:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LlkLyyHX"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC2E2566
	for <stable@vger.kernel.org>; Tue,  9 Apr 2024 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712621462; cv=none; b=swtJmrNR54fVS2Q41mPKc9rS6wKb4QQLq0n8soTQmQckHusUFo/cSSmnbf6ts4fBt/o6oc/CIUbZqKsXFt9jttlYCX5ViqDnAQUEIEnJQJ06O5vyjltli2zk/NbVKljdnjNK2hMg5GbSh/n9oYMjyP4h71oBPxBTLjNLr2cJ1gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712621462; c=relaxed/simple;
	bh=jHhcISfvM5hw7cGoH7GmgOSBwsHp6ACYR2aJyOjpY8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qLnBs9VY+4rZA6zMlxNDKlkjoC4h8w0WBTyoV9j7YlKiRbRfCoHgd2aWMEXnnz76E3MgDH5PD135i6UCJZYNUpUkOhsX2InNEMlJwyFyzX+7cQoRGkhIGg+iZRw9IMbx8XfbC54Dt211LNrpsLxan/EQWyCSu923w3Sw3Zz4gBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LlkLyyHX; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <737ae55d-3cd0-40fb-b3e9-3b676f1f735f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712621457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sjp5f9oGLEoLkHdn8mA9hv760wrE2Mtc0mHWY7INqz8=;
	b=LlkLyyHXayvJ2oLUWrzshr7bf5ZTEEuDnUEiflTdRU6YK2A8fJZjfrRUB941Uh3Kbm7m8d
	Mr0BddGphdRLxPPg0PvAWC5py9I3f4EJ27htGz7irp1grKnHhVR2ILg1xXbsg0rJvvjT+J
	26y6vC662TUE6I6neMclRoL6ja/jbm4=
Date: Mon, 8 Apr 2024 17:10:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: dereference of null in __cgroup_bpf_query() function
To: Mikhail Lobanov <m.lobanov@rosalinux.ru>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240406151457.4774-1-m.lobanov@rosalinux.ru>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240406151457.4774-1-m.lobanov@rosalinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/6/24 8:14 AM, Mikhail Lobanov wrote:
> In the __cgroup_bpf_query() function, it is possible to dereference
> the null pointer in the line id = prog->aux->id; since there is no
> check for a non-zero value of the variable prog.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: af6eea57437a ("bpf: Implement bpf_link-based cgroup BPF program attachment")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
> ---
>   kernel/bpf/cgroup.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 491d20038cbe..7f2db96f0c6a 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1092,6 +1092,8 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
>   			i = 0;
>   			hlist_for_each_entry(pl, progs, node) {
>   				prog = prog_list_prog(pl);
> +               	       	if (!prog_list_prog(pl))

prog cannot be null. It is under cgroup_lock().

> +				continue;
>   				id = prog->aux->id;
>   				if (copy_to_user(prog_ids + i, &id, sizeof(id)))
>   					return -EFAULT;


