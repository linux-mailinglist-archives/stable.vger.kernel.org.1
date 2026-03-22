Return-Path: <stable+bounces-227800-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COqjLQwzv2mtygMAu9opvQ
	(envelope-from <stable+bounces-227800-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 01:08:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2532E7B55
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 01:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB6763007482
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 00:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEB32233A;
	Sun, 22 Mar 2026 00:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HoAhORBv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5B01C28E;
	Sun, 22 Mar 2026 00:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774138122; cv=none; b=n/ebnCllVTJRtupe3qg9EVdQ6puwMZBg2VIKi6168/Lu8mNCgucVX3JfkF2NHZM8MXS3asdO0HFGuMJRxHucg6N2/53EplWlgkbPIIEpjVawwDADgREfgTVb7Qml5F2D839hDqM/SEX624bYEFV6//XTbElsJiAIPRH6N9+B21s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774138122; c=relaxed/simple;
	bh=NHN1+nUIOnHVMGQTNHaHd8fw2B29TR+WiIsn3gMNKC4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ca4cgq86HctsaxufreN+ZgZHuqjgNRurAJT/hOxOO5Q1h9DrKM1c6Muwpmju8sw2ggpab/sZtWhTYazMtoQh5VfosvapUaWduPAAgBKk/7c2tyi30Y2hcah+vcnJgmeEBaYThoc+4evpyl3WiuaQLQ7MzEvuiPKeXlF080elWPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HoAhORBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30A5C19421;
	Sun, 22 Mar 2026 00:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774138122;
	bh=NHN1+nUIOnHVMGQTNHaHd8fw2B29TR+WiIsn3gMNKC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HoAhORBvzI5/+QYS4SrI+EC+ImuqBKlq4+oE9Fw7dsa/je0trTKKGf+DLx9AKdxyK
	 I3EvvDs24Lp8CV+fS+g03wMSahZUHHNcS9FrIuKJMHbfzOTlaBQT1GMhD735H+Gw21
	 kvIHX+WsKT3UaTS88fl1J4pkkIxkd8dzq5ZhuN5c=
Date: Sat, 21 Mar 2026 17:08:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: bp@alien8.de, tglx@kernel.org, mingo@redhat.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, dvyukov@google.com,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/kexec: Disable KCOV instrumentation after
 load_segments()
Message-Id: <20260321170841.179ceada68dc55bb22064fda@linux-foundation.org>
In-Reply-To: <20260317220319.788561-1-nogikh@google.com>
References: <20260317220319.788561-1-nogikh@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227800-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E2532E7B55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 23:03:19 +0100 Aleksandr Nogikh <nogikh@google.com> wrote:

> The load_segments() function changes segment registers, invalidating
> GS base (which KCOV relies on for per-cpu data). When CONFIG_KCOV is
> enabled, any subsequent instrumented C code call (e.g.
> native_gdt_invalidate()) begins crashing the kernel in an endless
> loop.
> 
> ...
> 
> Disabling instrumentation for the individual functions would be too
> fragile, so let's fix the bug by disabling KCOV instrumentation for
> the entire machine_kexec_64.c and physaddr.c. If coverage-guided
> fuzzing ever needs these components in the future, we should consider
> other approaches.
> 

AI review has questions:
	https://sashiko.dev/#/patchset/20260317220319.788561-1-nogikh@google.com

