Return-Path: <stable+bounces-249695-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKs/FJbHDGrAlwUAu9opvQ
	(envelope-from <stable+bounces-249695-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 22:27:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF33B584AA9
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 22:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 625953050027
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 20:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EE73BB668;
	Tue, 19 May 2026 20:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSCezyE6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BC42874E3;
	Tue, 19 May 2026 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222419; cv=none; b=ZZJpLKlxYptR0PgihAA/s0rmL4MMLFYR7NyQjsQ+GjB4NnJdQEKq9h3gqWotnSTAsqCyfpet9NQyg91aYy44bSWOqIFu5p3ql9YqL/GwO30p89LEq0+xA3OiY03oAwU3BSOpDRHyUaRVE8XlFPPTbtNCnDzoHMpcLyzTuThoyqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222419; c=relaxed/simple;
	bh=W87Ncg5sK70elKtoSJlUPVxgaIjggXxk1gFUJsVeK1U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ECuk1uAYMFZ7GrxlbOau96mMWeHfp+4Mvpiy31wDZ8lg4hESEmYkbmfoNQKtG0OQV6bhzenHvNXnC6NygzIBJVxVFWf7QiLZQzsfCMmgm13E2RpXvo64jmIUaqE8NFXRkiP+vzfqPbB8Gmw5kY3Dm+zUoQ6u305y1VAMRE8SOYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSCezyE6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427231F000E9;
	Tue, 19 May 2026 20:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779222418;
	bh=12aBSvojo05afpnBg6VM7sWoJBKuZQ5iYoXpWWaZoTw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZSCezyE6OE5QP9x1+Mrz//sLQUIRHpRMeoSCruEB2NB+dygaVzEjm6gMSZcA4QjZ7
	 pZeOhxu87Z46oi4MJMIiwY9ZVEdHw9Z29iG1/fy14DVTkukKsaiRAYZAzawUqysAlL
	 ngJipQtN0jVENoG65wMyi/uM0N/pIiZ9Hkdyc9NBDUxKVi7BR87omtGJ0YUd0KqPcw
	 Q3cFXLa8AjPqA2R+nX37kTTo3Xfb582dM0AynrWfQdmVt9GpAKABrqsasmrr92AHLc
	 2NOMHcrqmQfW51ZSXC6v1a2maJG1HcjR57zekGYXx9nTb7K3Y8iKHkdrqmI9p6Jd1n
	 7epqQHlY2C7XQ==
Content-Type: multipart/mixed; boundary="===============1006306579911665399=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8038d2d4d6cbe44e018d1d2201fc10bc550994d05be6aeee83f6baed0964bac8@mail.kernel.org>
In-Reply-To: <20260519233812.18787-3-adubey@linux.ibm.com>
References: <20260519233812.18787-3-adubey@linux.ibm.com>
Subject: Re: [PATCH v5 2/6] powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 19 May 2026 20:26:58 +0000 (UTC)
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,lists.ozlabs.org,kernel.org,iogearbox.net,vger.kernel.org,gmail.com,linux.dev,meta.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-249695-lists,stable=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[20];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Queue-Id: EF33B584AA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============1006306579911665399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
>
>     Move the long branch address space to the bottom of the long
>     branch stub. This allows uninterrupted disassembly until the
>     last 8 bytes. Exclude these last bytes from the overall
>     program length to prevent failure in assembly generation.
>     Also, align dummy_tramp_addr field with 8-byte boundary.
>
>     Following is disassembler output for test program with moved down
>     dummy_tramp_addr field:
>     .....
>     .....
>     pc:68    left:44     a6 03 08 7c  :  mtlr 0
>     pc:72    left:40     bc ff ff 4b  :  b .-68
>     pc:76    left:36     a6 02 68 7d  :  mflr 11
>     pc:80    left:32     05 00 9f 42  :  bcl 20, 31, .+4
>     pc:84    left:28     a6 02 88 7d  :  mflr 12
>     pc:88    left:24     14 00 8c e9  :  ld 12, 20(12)
>     pc:92    left:20     a6 03 89 7d  :  mtctr 12
>     pc:96    left:16     a6 03 68 7d  :  mtlr 11
>     pc:100   left:12     20 04 80 4e  :  bctr
>     pc:104   left:8      c0 34 1d 00  :
>
>     Failure log:
>     Can't disasm instruction at offset 104: c0 34 1d 00 00 00 00 c0
>     Disassembly logic can truncate at 104, ignoring last 8 bytes.
>
>     Update the dummy_tramp_addr field offset calculation from the end
>     of the program to reflect its new location, for bpf_arch_text_poke()
>     to update the actual trampoline's address in this field.
>
>     All BPF trampoline selftests continue to pass with this patch applied.
>
>     Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>

This looks like a bug fix for the bpf trampoline implementation on
powerpc64. Should this include a Fixes tag?

The bug was introduced in commit d243b62b7bd3 which added support for bpf
trampolines on powerpc64. That commit placed the dummy_tramp_addr field at
the beginning of the long branch stub, causing the disassembly failures and
incorrect offset calculations that this patch fixes.

Suggested:

  Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26121409898
--===============1006306579911665399==--

