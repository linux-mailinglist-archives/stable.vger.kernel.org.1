Return-Path: <stable+bounces-273603-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rfrxB+miVGphogMAu9opvQ
	(envelope-from <stable+bounces-273603-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 10:33:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3405748BDA
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 10:33:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Wwk61q+H;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273603-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273603-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D372302F381
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 08:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031ED5695;
	Mon, 13 Jul 2026 08:22:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B4C1F09A8
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 08:22:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930940; cv=none; b=bR0bd/dBjfTU+GGK38GULddBJWlmn07Ll6KJGf+MbctL1ZTpG43QXHHQq9yYDpT7nlQP+ARqd04nclxrEd3HZqdPmJmTFaNSIgbnBbHXC03ni0qbE7FntYNFKtMRRd7RPEp/QdlzhsJl4n/tv5GZd1LRywjnyVRdU9L7PsXAvJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930940; c=relaxed/simple;
	bh=exD0nCyrIBd7fxxnQjMwqMRgDo3qY8S5mDQ4XuqLoWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXhVHG93YztWcNP5AChYNuFk5xrno3s9A5Eh9TOXPZX5FBCGkukpuXE+NzXCL9pfkl9mDaVRwhfG13lAmX6nULYnlvIhErvI3vxMPeB2lGkhCnZAkxNFtsccgJdukNtyUQQFmuO+N5XqDzGpEcw8onz1hr6fP+UkHFbRLa4fmJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wwk61q+H; arc=none smtp.client-ip=95.215.58.187
Message-ID: <0754e3fd-bb76-4acc-905b-17fcf59905ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783930927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TNVa47K7vdoSbFnpv6cNo/aVqY6M7TgTufOlocLZaU=;
	b=Wwk61q+HPGOhmJHKmcdw+K74KOJQ2Xdyh0NISkj45iR8RPrELsv747eyg30zf2anUKzUSL
	4ll0StniBxEAfoEyZAeya15s3XpQB2OHoRNexnQsi34Izoar8ltyY+2G9/QNC1Iptgbiau
	oN9FarpZa0p5FJe/Fw7dI/+pJopwXr4=
Date: Mon, 13 Jul 2026 16:21:14 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] mptcp: pm: fix use-after-free in
 userspace_pm_get_local_id()
To: gang.yan@linux.dev, mptcp@lists.linux.dev
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>, stable@vger.kernel.org
References: <20260713074722.47921-1-xuanqiang.luo@linux.dev>
 <b3c317fda3d8d3efa349933723e549933ffc0bf2@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <b3c317fda3d8d3efa349933723e549933ffc0bf2@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273603-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[xuanqiang.luo@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gang.yan@linux.dev,m:mptcp@lists.linux.dev,m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:luoxuanqiang@kylinos.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanqiang.luo@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3405748BDA


在 2026/7/13 16:03, gang.yan@linux.dev 写道:
> July 13, 2026 at 3:47 PM, xuanqiang.luo@linux.dev mailto:xuanqiang.luo@linux.dev  wrote:
>
>
> Hi xuanqiang,
>
> Thanks for the patch.
>
> But AFAIK, geliang has fixed this in [1], and your test verified this issues.
>
> @Matt, it seems that [1](geliang's patch) can be merged.
>
> [1]https://patchwork.kernel.org/project/mptcp/patch/4e50adfde3b80f433e13b86919596be229045edc.1782799876.git.tanggeliang@kylinos.cn/
>
> Thanks
> Gang

I see it now.
Indeed, I missed the pending patch;
Thank you for pointing it out!

Thanks
Xuanqiang


