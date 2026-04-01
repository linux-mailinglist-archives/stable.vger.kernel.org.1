Return-Path: <stable+bounces-232637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAAzLGNvzGnJSwYAu9opvQ
	(envelope-from <stable+bounces-232637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 03:05:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E46337359F
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 03:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1508D304759B
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 01:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDC526C3BD;
	Wed,  1 Apr 2026 01:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIVC5wxL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3E1E5018;
	Wed,  1 Apr 2026 01:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775005524; cv=none; b=VOq9z5MJcDFSkcPQXtXui3e/djdj/ixEu/BbJ7IAwQo0EOxU1B1ZgcPEYKjuwIBKMBqsbhQfcpInFe/NMimauB8woLTgrCDLZ7h5B7m7VwnBTrrsc+hZ4eFZlUEUYDKiP0h26BExGBWwvXXObCl7L1wQCWFl8HCZJjjRwhl62lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775005524; c=relaxed/simple;
	bh=ByDXKuHai140NrVm7ahWH+xM2F6/SDBLhHluQ1Ex/FY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzbfpfiNBULJpDuqcSuZYf0C/nlICtXzUHVqvqYOox81sdMtxw9at122iTg0w75XcH4A2AE1lj9ILqHqGvJg6eFMqJ5HZsU57oBFp1HVbdt+EFuMt31ftIhT9lbaQygDWJcV1sdk/GAwGi324kiL6wJnaj2Zx6u9mACU/eYXqM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIVC5wxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0B5C2BCB0;
	Wed,  1 Apr 2026 01:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775005524;
	bh=ByDXKuHai140NrVm7ahWH+xM2F6/SDBLhHluQ1Ex/FY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VIVC5wxLlIXQHrHwokUCek+jrgGpTIDiYTrs8YZnlbjpHErRPL+HqZI/uMk1YoKvY
	 cgFHixFJDW4dMiX5D1jJYgqYrULcTRRofdayL7rG1X6ABTEd1rV0mQ+rP40QB8kFoo
	 Wm9fWqSJqoYEMbHBRTYWh4Ja7aHYVErKe3kl/KnrnqfpqcR/vHHC9aULHvHy5Y9zfZ
	 vTQZiAe9m0QqN+vDlER9AFJcwt1C4Xep2/9bFURNxMd2VyV0RPMZ3lmk8U9nqjIlBf
	 94p58cPsDFClm6zqwMR545mDZOogMzQvAMPd62alkXlYOFM+faE3sJiJyilEHlRlQS
	 3+j7RcHRydCvA==
Date: Tue, 31 Mar 2026 18:05:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Srujana Challa <schalla@marvell.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
 <xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 Shiva Shankar Kommula <kshankar@marvell.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net,v5] virtio_net: clamp
 rss_max_key_size to NETDEV_RSS_KEY_LEN
Message-ID: <20260331180522.64ef9886@kernel.org>
In-Reply-To: <20260331104737-mutt-send-email-mst@kernel.org>
References: <20260326142344.1171317-1-schalla@marvell.com>
	<ba027306-e5e0-4d4d-8357-f6080441167d@redhat.com>
	<CH3PR18MB6379D39BA068565667CF2B06A053A@CH3PR18MB6379.namprd18.prod.outlook.com>
	<68ca0a8c-27f9-45f1-94cc-7e3c7936181f@redhat.com>
	<20260331104737-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232637-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E46337359F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 10:48:41 -0400 Michael S. Tsirkin wrote:
> > > Thank you for the feedback. In net-next, NETDEV_RSS_KEY_LEN is 256. This fix is
> > > also intended for stable kernels, where NETDEV_RSS_KEY_LEN is 52, and
> > > I added the message to make clamping visible in that case.
> > > I will remove the check and send the next version.    
> > 
> > I'm sorry, I haven't looked at the historical context when I wrote my
> > previous reply.
> > 
> > IMHO the additional check does not make sense in the current net tree.
> > On the flip side stable trees will need it. I suggest:
> > 
> > - dropping the check for the 'net' patch
> > - also dropping CC: stable tag
> > - explicitly sending to stable the fix variant including the size check.
> > 
> > @Michael: WDYT?
>
> I was the one who suggested it, the extra check is harmless, I'm
> inclined to always have it.  Less work than maintaining two patches.

Give us an RB tag please and lets close this one? :)

