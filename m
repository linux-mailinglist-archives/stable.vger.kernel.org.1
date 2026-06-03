Return-Path: <stable+bounces-260053-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TujeF+sRIGq7vQAAu9opvQ
	(envelope-from <stable+bounces-260053-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 13:37:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A82B56371ED
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 13:37:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=qlaI+asY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260053-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260053-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BB143037D76
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 11:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18183C81BF;
	Wed,  3 Jun 2026 11:19:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C9C358387
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 11:19:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485594; cv=none; b=VuxSaP80a8JCvGXkpAJQ8WO07hXwHIcuGL/SbYRWhjzBuQWnuwxiu+XeSLvDLf8nNC2upPvYYpW/6C/e/NPmTgxSXqEl22hCTRCvbIJs/TnxsZkQ3uRNhS79Y03XJ9tEQLwymvtDa3JCcUqBDBWOS/LtggTxYxBt2oT1zhLu7IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485594; c=relaxed/simple;
	bh=15gLpT8vS1QO/htr/bOb8jjhFZ1hz9MyKyPEdedINkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TROatPTaffUoZdFZTptmGwij6VXNhe9hMtl2quNjdOqvfHxPaKa0l+7KI4dLgJGM7BvULfdVUorF0mNp5SlCvulc/ltCBVbkruSP7cjxxhxctxgk7FbbXsTqt9GPOmPXfCQt9L5CLcM7khBpXNHzLofDPz5U+yo8dnifPPKoMd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qlaI+asY; arc=none smtp.client-ip=91.218.175.171
Message-ID: <c57fe00a-5cb3-46dd-8c1e-a4f19567dfcb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780485590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=15gLpT8vS1QO/htr/bOb8jjhFZ1hz9MyKyPEdedINkA=;
	b=qlaI+asYNiip64z7eOjFvNnckh1QZtNuLpxSUm9zuV2TruwdWTJTy5HdKkHGnb9BNOL43K
	TT4z/rx+RhW3hEi+yf1+SQBLtKeNvtNLaOOoveB7wPfW6/gGhvJHYmesYb5QhV1WX6gT+s
	8hwWgV/Q76YEnAXo3LL9kZqwC948VaI=
Date: Wed, 3 Jun 2026 19:19:36 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/3] bpf: Restore sysctl new-value from 1 to 0
To: Dawei Feng <dawei.feng@seu.edu.cn>, martin.lau@linux.dev
Cc: emil@etsalapatis.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, kees@kernel.org,
 joel.granados@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jianhao.xu@seu.edu.cn,
 stable@vger.kernel.org, Zilin Guan <zilin@seu.edu.cn>
References: <20260603105317.944304-1-dawei.feng@seu.edu.cn>
 <20260603105317.944304-4-dawei.feng@seu.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260603105317.944304-4-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260053-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[etsalapatis.com,kernel.org,iogearbox.net,gmail.com,linux.dev,vger.kernel.org,seu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:dawei.feng@seu.edu.cn,m:martin.lau@linux.dev,m:emil@etsalapatis.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:kees@kernel.org,m:joel.granados@kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,m:zilin@seu.edu.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:mid,linux.dev:dkim,linux.dev:from_mime,linux.dev:email,seu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A82B56371ED


On 6/3/26 6:53 PM, Dawei Feng wrote:
> Commit 4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value
> helpers") changed the success return value to 0, but failed to update the
> corresponding check in __cgroup_bpf_run_filter_sysctl(). Since
> bpf_prog_run_array_cg() now returns 0 on success, the legacy ret == 1
> condition is never satisfied. As a result, the modified value is ignored,
> and bpf_sysctl_set_new_value() fails to replace the write buffer.
>
> Fix this by checking for a return value of 0 instead, so cgroup/sysctl
> programs can correctly replace the pending sysctl buffer.
>
> This bug was discovered during a manual code review. Tested via a
> cgroup/sysctl BPF reproducer overriding writes to a target sysctl.
> Pre-fix, bpf_sysctl_set_new_value("foo") was silently ignored: the write
> returned 8192 and the value remained "600". Post-fix, the BPF replacement
> buffer properly propagates: the write returns 3 and the value updates to
> "foo".
>
> Fixes: f10d05966196 ("bpf: Make BPF_PROG_RUN_ARRAY return -err instead of allow boolean")
> Cc: stable@vger.kernel.org
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


