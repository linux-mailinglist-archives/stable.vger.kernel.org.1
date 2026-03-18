Return-Path: <stable+bounces-227039-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOy9HfuSumnSXgIAu9opvQ
	(envelope-from <stable+bounces-227039-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:56:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC452BB27D
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74639313FF21
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4D33CEB88;
	Wed, 18 Mar 2026 11:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EHZIdvYq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDA33D332C;
	Wed, 18 Mar 2026 11:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773834819; cv=none; b=uUcjO3qdZ9VnIvyrEpePx4tPjG42p7K3XbkFeo79upZ3fhqm+FB01JCGVhuDGLAfLj3rnrIWVrCn/Ovav3qpXyAHJQkCpSUWdNpmfxi5JCcoxRaWGLpMNvnGJk7Ts61xzSkOyQUqmeXKqUi+ql6hQc8Vl0RJNaYVviN2A20n9+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773834819; c=relaxed/simple;
	bh=z//2kPC9Rz51VaoDeS63jWuS/mqaaZ9jj7sDJMlZ5VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHtrDG/Vxax8yxmBJf6SLp4xJumArPSi5WhS5mudueTFmkJl4LJ06BUk9evjESy66C9h5hDbXWUNQYW2YnxYyfL6gFIzyAI/CncUBx5nZ/J2Mmtn5uHgd1es2vFp4dB6onYuFmKEkMDcXjbS3Prjba3HQiEej1qxJ7nS2bC8YGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EHZIdvYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF293C19421;
	Wed, 18 Mar 2026 11:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773834819;
	bh=z//2kPC9Rz51VaoDeS63jWuS/mqaaZ9jj7sDJMlZ5VM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EHZIdvYqUuLjJBEt0+LsU7GmeM9n814GDE0+Joxhd/jzMT+73QrjO++QgF/NGesvb
	 B0Y957gpP1BIymys+l7wJFLVPcJIn8AfyLXpq5dd1XnfE/dudzbjdXdXclEzT66pE7
	 IPNigswsbojdrxYVV/Wj+4jyShP9PY3HGpT1R4II=
Date: Wed, 18 Mar 2026 12:53:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: brauner@kernel.org, broonie@kernel.org, davidgow@google.com,
	gtucker@gtucker.io, patches@lists.linux.dev, stable@vger.kernel.org
Subject: Re: kthread: consolidate kthread exit paths to prevent use-after-free
Message-ID: <2026031827-pruning-spindle-74fb@gregkh>
References: <20260317163006.067634764@linuxfoundation.org>
 <20260317175812.707723-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317175812.707723-1-guanwentao@uniontech.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-227039-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCC452BB27D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 01:58:12AM +0800, Wentao Guan wrote:
> Hello,
> 
> I want you know that need backport ("bpf: drop kthread_exit from noreturn_deny"),
> which commit 7fe44c4388146bdbb3c5932d81a26d9fa0fd3ec9 upstream,
> or will met "WARN: resolve_btfids: unresolved symbol kthread_exit" to cause build fail,
> I test v6.18.19-rc1 with the patch build ok for me.
> 
> BRs
> Wentao Guan
> 
> Log:
>  AR      drivers/gpu/built-in.a
>   AR      drivers/built-in.a
>   AR      built-in.a
>   AR      vmlinux.a
>   LD      vmlinux.o
>   GEN     .vmlinux.objs
>   MODPOST Module.symvers
>   CC      .vmlinux.export.o
>   UPD     include/generated/utsversion.h
>   CC      init/version-timestamp.o
>   KSYMS   .tmp_vmlinux0.kallsyms.S
>   AS      .tmp_vmlinux0.kallsyms.o
>   LD      .tmp_vmlinux1
>   BTF     .tmp_vmlinux1.btf.o
>   NM      .tmp_vmlinux1.syms
>   KSYMS   .tmp_vmlinux1.kallsyms.S
>   AS      .tmp_vmlinux1.kallsyms.o
>   LD      .tmp_vmlinux2
>   NM      .tmp_vmlinux2.syms
>   KSYMS   .tmp_vmlinux2.kallsyms.S
>   AS      .tmp_vmlinux2.kallsyms.o
>   LD      vmlinux.unstripped
>   BTFIDS  vmlinux.unstripped
> WARN: resolve_btfids: unresolved symbol kthread_exit

Thanks, I've now queued this up.

greg k-h

