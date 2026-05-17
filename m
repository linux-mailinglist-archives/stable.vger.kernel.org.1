Return-Path: <stable+bounces-249142-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uO5fF2UJCmrqwAQAu9opvQ
	(envelope-from <stable+bounces-249142-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 20:31:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B382D56323D
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 20:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E00BD3026763
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 18:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B39C3CC306;
	Sun, 17 May 2026 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJaAOyKE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BFB35DA6A;
	Sun, 17 May 2026 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779042624; cv=none; b=tw87h2dQnT2jdT5oLz/nbVCfh/O7A4/L/QoaJN+7Vcaq51snBcZ9XbBm+oX/J2M+FLv8bQ4wP3TtmGGiv8HU+KE8aiyj19cx31reER6VInyQpJE/yn4yP7DKZmBbwBPS8SHcrLbPPzFNAsIe6kRIBdWN+g3M5B2YYhckTXNoIzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779042624; c=relaxed/simple;
	bh=nDFX9uuRrmdDrCwTCTS95orRvf1rp8grxvP/ByCFZvM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uKrA6/FHmWnGvwmJhhBfOEdVLzkizh7auDUBDR3LnPoITgjoBfjKl2vhsNxFu/OsKwiBw0nRsJQ397gV2hJWEX+d0QOOVRpXIXnxmGzGEjXG6zUw+7l+Lg61c519j4EeNuwyFx0a6AtTsSxZTA1kcU2TZnAUriVkA6E4ehoABrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJaAOyKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F44BC2BCB0;
	Sun, 17 May 2026 18:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779042623;
	bh=nDFX9uuRrmdDrCwTCTS95orRvf1rp8grxvP/ByCFZvM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=BJaAOyKEKlX19EPYOWJOIShJm1MKuTQtDGtXFdTYh6MtNYCZTjrqb4xVR9cZ6AjJJ
	 0kVs9q4gMnIzfV0p2+qerot1pNnXNZI7c7VCHu6cQ8AF0l/3mY9mUGIJ5bva6e548y
	 g2wPkppvB5Eb1CVbvFO0J6g/gBQ5l4BJ+ij2CyBKtel9l5qJoL4NKKPyy3IW61DhDk
	 jz9XXezocHHT2qCmgfnY7RU95+o1odWuGhylIAjdleprIHEupbua1B3AKkjIfsD9mf
	 6w3lhbLPiNwSHNpD9DCbXtHpXIVlL3RuMw2eT6etFZwnYpiaLE1utuBGobcqJfsC3Q
	 fnv6rG9CPiZfw==
Content-Type: multipart/mixed; boundary="===============8511337753608120594=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f99f99be312bfe17d6421c7b2ec14306d859f36825d653d9a6736ca1887a39de@mail.kernel.org>
In-Reply-To: <20260517214043.12975-3-adubey@linux.ibm.com>
References: <20260517214043.12975-3-adubey@linux.ibm.com>
Subject: Re: [PATCH v4 2/5] powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 17 May 2026 18:30:23 +0000 (UTC)
X-Rspamd-Queue-Id: B382D56323D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,lists.ozlabs.org,kernel.org,iogearbox.net,vger.kernel.org,gmail.com,linux.dev,meta.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-249142-lists,stable=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[20];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

--===============8511337753608120594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit c1b9d3c3e6cf6547bc01395bd0576b1ea8dbd1d2
> Author: Abhishek Dubey <adubey@linux.ibm.com>
> Date:   Sun May 17 17:40:40 2026 -0400
>
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

This looks like a bug fix for the alignment issue introduced in the
previous commit. Should this include:

  Fixes: 1fac3cfb82ab ("powerpc/bpf: fix alignment of long branch trampoline address")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25998434343
--===============8511337753608120594==--

