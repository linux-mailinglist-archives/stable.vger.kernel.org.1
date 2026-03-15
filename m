Return-Path: <stable+bounces-225457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WcxuEAP8tWlN8AAAu9opvQ
	(envelope-from <stable+bounces-225457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 01:23:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8221828FA5B
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 01:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7ABF303C2B9
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 00:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFC31DE8AE;
	Sun, 15 Mar 2026 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="00G8LLBD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0C41DE3AD;
	Sun, 15 Mar 2026 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773534204; cv=none; b=jLSl5QniQOsVfW4mIofEqyQXCpNrhKeAatmNPlK5dfeBXQ9GRg7cE75sngz1Su0Uj7olH8WLciPCNy0PPdTUy5hET+/hDiW3LVy2nWmp9oLv+qFs4XppmErnVqNIdO1FGT6Css9iaM7s+8RUXy61ZZujp5dqZGbI8gPavA40gLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773534204; c=relaxed/simple;
	bh=h0sAMG+StH3IKnGuGSyIhM12sVYTUh2nJijKIIgMlDw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mRDXVR0vRa5x0RmKkks7AYckfJCiVk5laXUOKgXeC4z+FTo4IEVS89g4la02spyguRGG53dFj5CiUObkv7TSXzcVkmbG+/ElbC8xJO6bTa1fhnq1Xfe7dCIJ6fnHcV6Vihy2PFwxmLy4/o5eEEkSkhd8TG1mxqD1AXg9dfFxqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=00G8LLBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993F8C116C6;
	Sun, 15 Mar 2026 00:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773534203;
	bh=h0sAMG+StH3IKnGuGSyIhM12sVYTUh2nJijKIIgMlDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=00G8LLBDByge+9fnmNBx+Qqz6ilOPRNsD2R1H2Nw2RoFQrUsPLn/raG2j+v1saPrT
	 XlcZyHn2PRx8OM/hmJUQQc6nw+jeIbvu2OLyzWB+aOI7ZSiQxCLllQNg1+sXVUECmB
	 bVlgkTdjvyDwBp4xaD58YxCUQK2AnPopZhINDpDw=
Date: Sat, 14 Mar 2026 17:23:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>, npache@redhat.com, david@kernel.org,
 ziy@nvidia.com, willy@infradead.org, linux-mm@kvack.org,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, hannes@cmpxchg.org,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 richard.weiyang@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm: migrate: requeue destination folio on deferred
 split queue
Message-Id: <20260314172321.3ca062bb70e51fefa633a6fe@linux-foundation.org>
In-Reply-To: <20260315000555.76876-1-sj@kernel.org>
References: <20260314154042.327ba957b1a8c10f64ae0169@linux-foundation.org>
	<20260315000555.76876-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225457-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,redhat.com,kernel.org,nvidia.com,infradead.org,kvack.org,intel.com,gmail.com,cmpxchg.org,sk.com,gourry.net,linux.alibaba.com,vger.kernel.org,meta.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:dkim,linux-foundation.org:mid]
X-Rspamd-Queue-Id: 8221828FA5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 14 Mar 2026 17:05:54 -0700 SeongJae Park <sj@kernel.org> wrote:

>  Because THPs are
> removed from the deferred_list, THP shinker cannot split the underutilized THPs
> in time.  As a result, users will show less free memory than before.

That'll do, thanks ;)

Pasted, added cc:stable.  It's been there since 6.12 so I don't see a
need to rush this in, so I won't move this into mm-hotfixes - it'll go
into mainline for 7.1-rc1 after which -stable should pick it up.


