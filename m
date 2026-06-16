Return-Path: <stable+bounces-263752-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kepNMRdXMWqhhAUAu9opvQ
	(envelope-from <stable+bounces-263752-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:00:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E106902E1
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:00:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Izsrh6J7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263752-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263752-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EC0732A1018
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 13:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF93F349CF0;
	Tue, 16 Jun 2026 13:55:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80A32C027C;
	Tue, 16 Jun 2026 13:55:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781618131; cv=none; b=HAOoIVPqtiX1ghnm8AV4HPtRdF/GQvL0eicRlUwXj4qAEVWyXFCfzDajDssK9D3XNLI89FsYF5F2RhDZ1b/YBI+7aYZT9esobwdFEeptUd+RgtHdNv4Spc7EW1sRBmHda9JE6IWizrx6mOxRUH71QnTo1H9fzfdx83TtygNOSKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781618131; c=relaxed/simple;
	bh=pOyXHQutqch4Q8214h6bv/5rWKI9/F2GR01kP3wzY24=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cUmPCDi0vWc2O89pDeA4iOeiFEssA8iIAAZbluV6h+gXcLIIbki8Mv1lTcM5HYQ/mBRhzWq0G+/g1LXkXxKIlQhjvK0x18+qrcQlaOQ9nbkIY14F8D95psnBBqxa4OPJeLgiCTL5zotqOTr4+JYGjM3/pxSVXBrnvHZoOMLZfcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Izsrh6J7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D431F00A3A;
	Tue, 16 Jun 2026 13:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618130;
	bh=386TELQbEHxweuigB9LLOnXetjMUnGIUnGTjr3fVOKs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Izsrh6J79mj4NNjgJRzsUchOsOD02IXpx7Wb4ZNbQQt2pyIOembAqm52TFNOlTS7D
	 fxm91gfw7l/V3mrNrONfp6spjYuaFEbDUO9KSSOJf6R3ovS+qrFVyjoOlymE4mpmK/
	 GnjolHe1kLCD3h+8A4mZc/rfsKagWzsdtmmzrFjJ1adTHqeO9AhR/Q7oow0ezE465q
	 rf4YIFx0KQFUqCfuVq4WlACpPiSbblyOoCJr4smFXYpXpCmTTC0L2qAmWZmv/0muvL
	 SL/LTbgPZ6mSsMHysts47x9yA4zDondsZd5RVDkEdG6/KRj/1ttagN/djdQfjcI3P/
	 GbM/c3Ikq5fUw==
Content-Type: multipart/mixed; boundary="===============7481909573851222579=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c3c63feba5e72738b34d50b2c614e309f0ce6a2a11ba70bae9197996a3e58020@mail.kernel.org>
In-Reply-To: <20260616164741.32252-7-adubey@linux.ibm.com>
References: <20260616164741.32252-7-adubey@linux.ibm.com>
Subject: Re: [bpf v8 6/7] selftest/bpf: Add tailcall verifier selftest for powerpc64
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 16 Jun 2026 13:55:29 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,lists.ozlabs.org,kernel.org,iogearbox.net,vger.kernel.org,gmail.com,linux.dev,meta.com];
	TAGGED_FROM(0.00)[bounces-263752-lists,stable=lfdr.de,bpf-ci];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5E106902E1

--===============7481909573851222579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftest/bpf: Add tailcall verifier selftest for powerpc64
>
> Verifier testcase result for tailcalls:
>
> # ./test_progs -t verifier_tailcall
> #618/1   verifier_tailcall/invalid map type for tail call:OK
> #618/2   verifier_tailcall/invalid map type for tail call @unpriv:OK
> #618     verifier_tailcall:OK
> #619/1   verifier_tailcall_jit/main:OK
> #619     verifier_tailcall_jit:OK
> Summary: 2/3 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>

The test output lines in the commit message could benefit from indentation
to more clearly differentiate them as command output. Consider adding a space
or two before each of the test result lines for improved readability.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27620315552
--===============7481909573851222579==--

