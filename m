Return-Path: <stable+bounces-268019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MQnzIJrnOmpYKwgAu9opvQ
	(envelope-from <stable+bounces-268019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 22:07:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C7E6B9DB6
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 22:07:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BAaQXCqe;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268019-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268019-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A74D3097347
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 20:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14785395DAA;
	Tue, 23 Jun 2026 20:07:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67273932FF;
	Tue, 23 Jun 2026 20:07:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245261; cv=none; b=MRgpyBIV5TahyzSmfUWoRXYkicLi3Gi8xer1UU364CscKDiwCwlBSfrmkH4n6m7qi9C4bE+nr8g1wzvLrlLdzsYbFl49EI6pTfB2RV0hT+0Ki60QD9EHZkc9nAeDtdRy3p1Sa3TZTc0Cx9rc23xAWa5/S7CcNM18uLD1KjiZuto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245261; c=relaxed/simple;
	bh=8QIsMnJbf4Lbi5vO5rZNPxESsinFfltveRyhQQl9rGU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=D5KbzpfwU2rgJT2XvEt/6PhJVG3crDVaEF04oRA+CH0Im4MgcxG9pyWlY0nxFMX/9q625ounaZRSSVj55fLmWMmfNPeDGGHUT2+Aw826z5ZWNh3DRS1FGDcA1QTA9URc6hn7dq0Zhvkl64COB6ly/J7N1ZG7KyPlXz0b7xKsef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAaQXCqe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B021F000E9;
	Tue, 23 Jun 2026 20:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782245260;
	bh=XWHa62l/YiCsFLEmqWnO1R3ebE4heGP/6x4UVAPjgds=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BAaQXCqe+0gOROgwKims9hjNuTtcOYeu7FT7Os3GgzLHUg+O75W1gGIM6rgN6ZHTA
	 rs7wYg61r+qBb9cJMUdf2sg/BHAqlrJ0tXJu/cXWEWLpPUIv8+PaUIu67FgF3tkCGR
	 dCKHvlSCcgfmYTUrGNb79dvBY9DHXz2D55Az3HtK5r/xSpq717G/3mMUgk2BvENkjt
	 i/XgGfhw8RJH5awZgoy59w7Z/M/uNzGyDzjwyPrSL7zFMl6luNvIb5+OsnJMEK+bD2
	 AIGSxcqpIDPt76p9fLNwRxYPhgc4gQoNOJVHuBU3lK7YKTWqkFcqQsgHeXQEpneyl4
	 ZBnElVhS0Rwzg==
Content-Type: multipart/mixed; boundary="===============0809908519728760187=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aaba19274fbd51ba6014af6f1a9928eb202775b6278c2fbac3d0be9f26863d01@mail.kernel.org>
In-Reply-To: <20260623231411.6216-3-adubey@linux.ibm.com>
References: <20260623231411.6216-3-adubey@linux.ibm.com>
Subject: Re: [PATCH bpf v9 2/8] powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 23 Jun 2026 20:07:40 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,lists.ozlabs.org,kernel.org,iogearbox.net,vger.kernel.org,gmail.com,linux.dev,meta.com];
	TAGGED_FROM(0.00)[bounces-268019-lists,stable=lfdr.de,bpf-ci];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:adubey@linux.ibm.com,m:bpf@vger.kernel.org,m:hbathini@linux.ibm.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:ast@kernel.org,m:andrii@kernel.org,m:daniel@iogearbox.net,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:stable@vger.kernel.org,m:martin.lau@kernel.org,m:eddyz87@gmail.com,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17C7E6B9DB6

--===============0809908519728760187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Move the long branch address field to the bottom of the long
> branch stub. This allows uninterrupted disassembly until the
> last 8 bytes. The last bytes exclusion is logically necessary to
> prevent disassembly failure, otherwise the actual program layout
> is never altered. Hence no effect on overall program size.
> Also, align dummy_tramp_addr field with 8-byte boundary.

The commit message describes fixing a disassembly issue and updating
offset calculations for bpf_arch_text_poke(). The change modifies how
dummy_tramp_addr is positioned and how its offset is calculated.

Looking at the diff, the offset calculation in bpf_arch_text_poke()
changes from:

> -		ret = patch_ulong((void *)(bpf_func_end - bpf_jit_long_branch_stub - SZL),
> +		ret = patch_ulong((void *)(bpf_func_end - SZL), /* SZL: dummy_tramp_addr offset */

This corrects a calculation that was introduced when long branch stubs
were added. The original implementation placed dummy_tramp_addr at the
top of the stub and calculated its location using the stub size. This
commit moves it to the bottom and simplifies the calculation.

Should this include a Fixes tag for the commit that introduced the
original placement and offset calculation?

  Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28051760380
--===============0809908519728760187==--

