Return-Path: <stable+bounces-256478-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KABK3UOGWrDpwgAu9opvQ
	(envelope-from <stable+bounces-256478-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 05:56:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A245FCD8E
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 05:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 570303035BA0
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 03:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB97C36EAA6;
	Fri, 29 May 2026 03:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2OnQtge"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D23F36DA0A;
	Fri, 29 May 2026 03:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780026987; cv=none; b=uhzq2yrd3gyfZ/aRfARCKGNA3RN6iKH84Dp3376Gnu8FvhqEfj5Eq024i3iiWM8VTi/bxhB1PvfIX3pevozp2X6RXVX1XSTMTW/3sMPnOzL5gEFPhUueb3x+eJFmJzCb/fJ0sLxdMq0rxy4FPTsRsgjoK3j2KT9yBfyDWCQ7tlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780026987; c=relaxed/simple;
	bh=W3xtxXKsgM9Lc5y3Un80lyg4DCgSCTA4teRWA4BU1ag=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CGmjPOM7dRy/hBFVC3/RKDpP0MDk+2qKeWS6u/b4EZ2HePhTNMYzi4oyH/TBaIxhU8IIlew7TxFZ+3PG7xtyZ2piJu+vjcumR475LVQFayKUbpyhAh8Po12kAkygzRQdEuUWKIzjtTGbuGpxzz9D9upwTM75NGtqBN4vlnD2h6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2OnQtge; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBB21F00893;
	Fri, 29 May 2026 03:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780026986;
	bh=P2rzaqH/3OYIxG6nxMBRBIfV9MU9+ut9Wg1wpQHXILA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=J2OnQtge8HWaMOGSEbddFP9r4M582Wqs/JpXdEDt7a2AsNSGS3ABR/lwbUp/wArtI
	 pocaC0ZvZ4z+l9RZ9YNN9IBU8SCqLwLNv9A7P2z15vpyaNdmFLEZ+PWiDuoin4PI42
	 AqnFs3ZVxzJ+HdXSBPINSfCZIpS8LNQ1UFpU3NL5dsvCiaGJMHhVLQQVQ9jAs0aGVS
	 U9fX3ak9KVcT2/9Sj7JdpfmhItGZs5xRoYwpe0hQLOLNpfcbsDhRHqIWeNJqwwOOZR
	 vD/wQucpifcqFqtD+aZMTqtkzcSSdOw6i9uFjfa1nYspYyklsnhnSBF4XlCgKmjXmQ
	 z8tEWNeW/9N7g==
Content-Type: multipart/mixed; boundary="===============0884486493195273933=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <45201482368d330f6301ea4d90e29fa1585bf985c12a191d9fcd975087eb0649@mail.kernel.org>
In-Reply-To: <20260529031026.2716641-4-dawei.feng@seu.edu.cn>
References: <20260529031026.2716641-4-dawei.feng@seu.edu.cn>
Subject: Re: [PATCH v2 3/3] bpf: cgroup: restore sysctl new-value replacement
From: bot+bpf-ci@kernel.org
To: dawei.feng@seu.edu.cn,martin.lau@linux.dev
Cc: emil@etsalapatis.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,kees@kernel.org,joel.granados@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-fsdevel@vger.kernel.org,jianhao.xu@seu.edu.cn,dawei.feng@seu.edu.cn,stable@vger.kernel.org,zilin@seu.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 29 May 2026 03:56:25 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[etsalapatis.com,kernel.org,iogearbox.net,gmail.com,linux.dev,vger.kernel.org,seu.edu.cn,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-256478-lists,stable=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 45A245FCD8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============0884486493195273933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index a0b5f8cd8b10..3f06e2270f5c 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1935,7 +1935,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
>
>  	kfree(ctx.cur_val);
>
> -	if (ret == 1 && ctx.new_updated) {
> +	if (!ret && ctx.new_updated) {
>  		kvfree(*buf);
>  		*buf = ctx.new_val;
>  		*pcount = ctx.new_len;

With the success check now testing !ret, does the kerneldoc above
__cgroup_bpf_run_filter_sysctl() still describe the right convention?  It
currently reads:

 * This function will return %-EPERM if an attached program is found and
 * returned value != 1 during execution. In all other cases 0 is returned.

Since bpf_prog_run_array_cg() returns 0 on success rather than 1, should
that line say "returned value != 0" to match the new check?

This point was raised in v1 review but does not appear to have been
changed in v2.

Now for the Fixes: tag.  The commit message states:

> Fixes: 4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value helpers")

Is this the commit that actually introduced the problem?  At 4e63acdff864
the runner was BPF_PROG_RUN_ARRAY, which returned 1 on success, so the
ret == 1 check was correct at that time.

There appear to be two candidate commits that changed the return
convention to 0-on-success and left the ret == 1 check stale:

  c4dcfdd406aa ("bpf: Move getsockopt retval to struct bpf_cg_run_ctx")
  f10d05966196 ("bpf: Make BPF_PROG_RUN_ARRAY return -err instead of allow boolean")

Should the Fixes: tag point at one of these instead of 4e63acdff864?

The f10d05966196 suggestion was raised by the bpf-ci review in v1 but the
tag was unchanged in v2.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26616337824
--===============0884486493195273933==--

