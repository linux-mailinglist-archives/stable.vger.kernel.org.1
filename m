Return-Path: <stable+bounces-214382-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WO0SDMwKhGl5xQMAu9opvQ
	(envelope-from <stable+bounces-214382-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 04:13:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9977FEE397
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 04:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 850143013EE0
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 03:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E16246788;
	Thu,  5 Feb 2026 03:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="n7SeFapV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622172D46D6
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 03:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770261191; cv=none; b=mB/rfNrhxTFCCARP6RtFH/M8iQ3pYA7Nxz0/zBSahMibu1+ZLyZkCeFBGP6+dHB2IRZqy5B1y/P2B+l9lThYSfbhCpDa7afSQH6rHYUy54Oajwkit0vqvxsVmS7tj+SNn+I2MInR1IoH9LHAAR2EntupQ1ktreKGnMX0fixGiHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770261191; c=relaxed/simple;
	bh=HDN75FDUo5Qy2KldHx4LIkZkOb9M+7wUHDms5Y7mFs0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=e/L5lEBBTRdV/NYb8eumzNc0d0bG6BhiyOuTNFyB5OJOMry+lYzvT5KBTBTxrxAVIzucdsZyU/JsaEtIWgdQJXYVFwllo3pebsvoQWf0Ybu7fFrpTXyIVwz3CYtfv2zgJYy047KFm3B7j5ZbIJkwFmMQbBjmkbfENFa0fnhluO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=n7SeFapV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C94EC4CEF7;
	Thu,  5 Feb 2026 03:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1770261190;
	bh=HDN75FDUo5Qy2KldHx4LIkZkOb9M+7wUHDms5Y7mFs0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n7SeFapVpA0FVa0rBcWMRcqmtGXhKF4SUKqa6WYkxg3xN0Hzhk+bD4Sky5jqyzz8i
	 XrqwGPUGg1xCPw7eLbUS5wdpQeBTknZ8sef8am4JZu5wQad/bJvSThYaWvVQWHBHZn
	 onA9ZqZCPSsmKqrx5TWnRVy7wi9D6Ji2AbfoUcYM=
Date: Wed, 4 Feb 2026 19:13:09 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: david@kernel.org, lorenzo.stoakes@oracle.com, riel@surriel.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
 jannh@google.com, ziy@nvidia.com, gavinguo@igalia.com,
 baolin.wang@linux.alibaba.com, linux-mm@kvack.org, Lance Yang
 <lance.yang@linux.dev>, stable@vger.kernel.org
Subject: Re: [Patch v2] mm/huge_memory: fix early failure try_to_migrate()
 when split huge pmd for shared thp
Message-Id: <20260204191309.5c61a11ddfbb71f6a1672c12@linux-foundation.org>
In-Reply-To: <20260205030421.zz72iie5bwvgxlsj@master>
References: <20260204004219.6524-1-richard.weiyang@gmail.com>
	<20260204114217.6da3e05ee5fbfac3a5f4c16a@linux-foundation.org>
	<20260205030421.zz72iie5bwvgxlsj@master>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-214382-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,alibaba.com:email,linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,linux-foundation.org:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 9977FEE397
X-Rspamd-Action: no action

On Thu, 5 Feb 2026 03:04:21 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> >> Cc: Gavin Guo <gavinguo@igalia.com>
> >> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
> >> Cc: Zi Yan <ziy@nvidia.com>
> >> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> Cc: Lance Yang <lance.yang@linux.dev>
> >> Cc: <stable@vger.kernel.org>
> >
> >Why cc:stable?  In other words, what is the userspace-visible runtime
> >effect of this bug?
> 
> On memory pressure or failure, we would try to split folio to reclaim or limit
> bad memory. If failed to split it, we will leave some memory unusable.
> 
> I would put this in change log, if it looks good to you.
> 
> As David mentioned some change in comment and change log, do you prefer a v3?

v3 would be good please.  If the patch(set) was large and had been
under test for significant time then I think a delta is preferable. 
But that isn't the case here.


