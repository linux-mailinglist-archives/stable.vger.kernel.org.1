Return-Path: <stable+bounces-260921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BGnCGGYTJWrdDAIAu9opvQ
	(envelope-from <stable+bounces-260921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 08:44:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A058964EF6E
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 08:44:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NPrdMqZv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260921-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260921-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C13E30363B0
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 06:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7382EAD1C;
	Sun,  7 Jun 2026 06:43:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E46E2E736B;
	Sun,  7 Jun 2026 06:43:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780814583; cv=none; b=jvoRDYXBWvgJE1K2nd94wlYzGJT6NBewruSy35o2pxfCwnL3XHqvvP54jZWnPZfo3vZWafnBwj1+9y3KexDz6+7nmXipo2B8R7JPhVRoxvYvVFVnV6yocMaRtFamrrSdmT3PJ37L2jsAqSgXg2BMApJmKHZAdMCs1iuhtnZWYaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780814583; c=relaxed/simple;
	bh=K298PaPxz7qYDNLk2ct3glg8mvCnu0tcDTsoTojdB1M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TA4Tl10Ea0K+oXIBmb+Gsalcu8SnNSdHRkDchi5sBDVi2+4/2+t3zNEpEI6W60tXqJeG5eB930a2t4tl5AxNEI5B9jTR1xRvc10urymDihPIK7dCemAgsyevbEarsFjqgfhcKOwJMj7kABtaHCBvWSzJlrvRXeRCzgSceASdMrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPrdMqZv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669B01F00893;
	Sun,  7 Jun 2026 06:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780814582;
	bh=L0RBItlob1/lCm2QEqFsy3L9ByS4dHuuq7PrYLHZthM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=NPrdMqZvcxVQhGRt4EBBfKFEkzzqQlXZNGWu4ls/OPkopsHtzYttxd9I1hKQas7LW
	 qoFbrWyVcmYin+8cBlYcBkTDMDozfZ4hHilmdab3DBkXn/SrblXaQ4B9lg1m199hga
	 PNWahamio2r4q9QKQrlFhn+8zk1iPDBzueNwRT4p5UXQCjR5KcfROCbNF462Nwiv7j
	 3BnQwG3qb0nQpzeVIKACQ5wOTixXnaOB4iQXXtBVCs2CHDGcEGPfYemWbWUW1Y5DqJ
	 plek6KJKcanjlnOGiGzf/m8eB+XeaaxnhD+WyQhgl9FQ7iUPxAJMrkDkUMLyDgK3jg
	 VmWCQJVfmCB6g==
Date: Sun, 7 Jun 2026 00:40:34 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Alexandre Ghiti <alex@ghiti.fr>, Alexander Potapenko <glider@google.com>, 
    Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
    Yunhui Cui <cuiyunhui@bytedance.com>, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
    Palmer Dabbelt <palmer@rivosinc.com>, stable@vger.kernel.org, 
    Yanko Kaneti <yaneti@declera.com>
Subject: Re: [PATCH v2 0/5] riscv: kfence: Handle the spurious fault after
 kfence_unprotect(), and related fixes
In-Reply-To: <20260303-handle-kfence-protect-spurious-fault-v2-0-f80d8354d79d@iscas.ac.cn>
Message-ID: <85e01c4c-6616-3ece-520f-30c6f8e53974@kernel.org>
References: <20260303-handle-kfence-protect-spurious-fault-v2-0-f80d8354d79d@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260921-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[pjw@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:wangruikang@iscas.ac.cn,m:pjw@kernel.org,m:palmer@dabbelt.com,m:alex@ghiti.fr,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:cuiyunhui@bytedance.com,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:kasan-dev@googlegroups.com,m:palmer@rivosinc.com,m:stable@vger.kernel.org,m:yaneti@declera.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pjw@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A058964EF6E

On Tue, 3 Mar 2026, Vivian Wang wrote:

> kfence_unprotect() on RISC-V doesn't flush TLBs, because we can't send
> IPIs in some contexts where kfence objects are allocated. This leads to
> spurious faults and kfence false positives.
> 
> Avoid these spurious faults using the same "new_vmalloc" mechanism,
> which I have renamed new_valid_map_cpus to avoid confusion, since the
> kfence pool comes from the linear mapping, not vmalloc.
> 
> Commit b3431a8bb336 ("riscv: Fix IPIs usage in kfence_protect_page()")
> only seemed to consider false negatives, which are indeed tolerable.
> False positives on the other hand are not okay since they waste
> developer time (or just my time somehow?) and spam kmsg making
> diagnosing other problems difficult.
> 
> Patch 2 is the implementation to poke (what was called) new_vmalloc upon
> kfence_unprotect(). Patch 1 is some refactoring that patch 2 depends on.
> Patch 3 through 5 are some additional refactoring and minor fixes.

Thanks, queued for v7.2.


- Paul

