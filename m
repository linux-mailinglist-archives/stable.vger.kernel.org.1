Return-Path: <stable+bounces-233088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEVSBimszml+pQYAu9opvQ
	(envelope-from <stable+bounces-233088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 19:49:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 167B538CC1C
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 19:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9D6A302FFBA
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 17:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448F83F211B;
	Thu,  2 Apr 2026 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wMk9Ltsu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDD63F210C;
	Thu,  2 Apr 2026 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152034; cv=none; b=CR9802IGt+rncmY7CsptPEn9YCCEOjAkpXXPcIdyOyUiF/J5QGxhRjEyHQGhHjsyborvtM7fC9WP2pC6T9/JEygfrcEZ4udLzSWS40CWk/O6N1JLVvRbazNWI/H1wXG8phmlHdSGVjJ7Cppb/i4hMo1h0LPDdX/KJ3wkUG3+9cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152034; c=relaxed/simple;
	bh=bvjP3KqeOQ0m0cE19vK2rRQuvmX1upwyF4DekI2dCuo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gmXXU+mVUrUexw+YSAmvKlIa0doC2p4Q8fuRhO0hsCjcxsJVFTNJHRAMbNupGnDFPLy1l+TUEWkEcpybWmwsFteAw8HSfcPK24n66WNn77fSSn1cEQGSCruV3PdCDL4WdxwvaIcwBf5kwBjyrnaNPPU/Raq1w++Ian90NBLZQnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wMk9Ltsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E778C116C6;
	Thu,  2 Apr 2026 17:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775152033;
	bh=bvjP3KqeOQ0m0cE19vK2rRQuvmX1upwyF4DekI2dCuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wMk9LtsuEagrwVqNDqWTVTZcARYkL9PcUn+YxTHXTE4c0MDmwiFm8nVIGOBMFvIp7
	 7Hz6TU4T922Bi0RjkdHP2rkqXNdlJyNiG2uJvx/RujgFUrgJ8uniukuk9O4Z0Pc4CU
	 zrE9rboFz4Nag1QkCr6wLEfS4krRTNpjtBYrPiKE=
Date: Thu, 2 Apr 2026 10:47:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Tang <tpluszz77@gmail.com>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>, David Hildenbrand
 <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Oleg Nesterov
 <oleg@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] prctl: require checkpoint_restore_ns_capable for
 PR_SET_MM_MAP
Message-Id: <20260402104712.111d87b0154260372595cadf@linux-foundation.org>
In-Reply-To: <20260402111332.55957-1-tpluszz77@gmail.com>
References: <20260402111332.55957-1-tpluszz77@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-233088-lists,stable=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux-foundation.org:dkim,linux-foundation.org:mid]
X-Rspamd-Queue-Id: 167B538CC1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu,  2 Apr 2026 19:13:32 +0800 Qi Tang <tpluszz77@gmail.com> wrote:

> prctl_set_mm_map() allows modifying all mm_struct boundaries and
> the saved auxv vector.  The individual field path (PR_SET_MM_START_CODE
> etc.) correctly requires CAP_SYS_RESOURCE, but the PR_SET_MM_MAP path
> dispatches before this check and has no capability requirement of its
> own when exe_fd is -1.
> 
> This means any unprivileged user on a CONFIG_CHECKPOINT_RESTORE kernel
> (nearly all distros) can rewrite mm boundaries including start_brk, brk,
> arg_start/end, env_start/end and saved_auxv.  Consequences include:
> 
>   - SELinux PROCESS__EXECHEAP bypass via start_brk manipulation
>   - procfs info disclosure by pointing arg/env ranges at other memory
>   - auxv poisoning (AT_SYSINFO_EHDR, AT_BASE, AT_ENTRY)
> 
> The original commit f606b77f1a9e ("prctl: PR_SET_MM -- introduce
> PR_SET_MM_MAP operation") states "we require the caller to be at least
> user-namespace root user", but this was never enforced in the code.
> 
> Add a checkpoint_restore_ns_capable() check at the top of
> prctl_set_mm_map(), after the PR_SET_MM_MAP_SIZE early return.  This
> requires CAP_CHECKPOINT_RESTORE or CAP_SYS_ADMIN in the caller's
> user namespace, matching the stated design intent and the existing
> check for exe_fd changes.

Thanks.

AI review claims to have found a couple of things:
	https://sashiko.dev/#/patchset/20260402111332.55957-1-tpluszz77@gmail.com

