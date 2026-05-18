Return-Path: <stable+bounces-249334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNoaGBA8C2oJFAUAu9opvQ
	(envelope-from <stable+bounces-249334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:19:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67443570C28
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D02D3007B29
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16BD480DCB;
	Mon, 18 May 2026 16:19:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8100940DFA3;
	Mon, 18 May 2026 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121150; cv=none; b=aJtC3J+XRrBoT0kMqlxYuSiKpnRZuIphEdo5bHff9wb36YgbqPwXe2x6aQvPcrFk56MfYen7SWIPxksmb6BYtjPMhkYPom0wXCjhjoubNwOIAMvSwrGL5lLuT9X3tedUfoLn0rTBKdGPGZ+cRZ4jrZ4ppKkLQJHx8jlVuWTLr0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121150; c=relaxed/simple;
	bh=QXOe6snGHgdgnGJp3ZkSbp3AHOt4fgXfzTzWLnXiLA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqcODoa+UatN6mzpvJVNLJwry4u6zeMuFHCbswSlkSS1Q0lBvktNz1Bzyi4I/sa6aGs0Nt7g8m2hpggPn69HvOgNVo+Iw9CbUBNe7dPUoLbeRxpJSaDRc+Dw0XlxRGcSna9Cmx/xEwZ31dftoxFHtlLAI2+9d3smx936M51lLa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 441EB1C1FBC;
	Mon, 18 May 2026 16:18:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 6DDB920028;
	Mon, 18 May 2026 16:18:53 +0000 (UTC)
Date: Mon, 18 May 2026 12:19:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Kuchmenko <capyenglishlite@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jiri Olsa
 <jolsa@kernel.org>
Subject: Re: [PATCH] ftrace: fix race in __modify_ftrace_direct() between
 tmp_ops registration and direct_functions update
Message-ID: <20260518121906.4eebad77@gandalf.local.home>
In-Reply-To: <20260517110155.21706-1-capyenglishlite@gmail.com>
References: <20260517110155.21706-1-capyenglishlite@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 7475nq6abdfq3z4jdpinuxnnqu4obzha
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18qzFd+SMwPAxg7uknzCaPo64VnjDt9WEg=
X-HE-Tag: 1779121133-302350
X-HE-Meta: U2FsdGVkX19s4pTNGOLCOqaFHty2QAGT3IrNkCzug/0/ivf5UnXxhuBD5QT7emIDTTXySdQj4tiH0l1LPX3mRMLiRvm6yvUz1dMqcgVqR1N0n8x55WlLOqjujswIrZKZmWYc4dFoizO5uBloIOhoJcxTuX64lcJaVdr7NbMlGuleQ7YJHU2eBA9aeoMZeyCsuP+cZmr0P9CZOCsBLc5ZZYZkuf8fmuQyLZtkxfYaOo+fkZngGS66FlNSn4gWrL2E3RkIaT8H96v0LHmYpoWJskMX2LRO00f+Dl6qZwaSIm90eSpWgnz4VU5Kb6UciV/yNnYwh3Q/lXA+9tsJ3hIjnQ8Bdtt24DKqgJcYjftlhMsoi02Om0K83arljoMSWPKk8QstqASH3LyoO20uXMOR7SV5GI+RieJUGaQ0YYQmheU9C1FgxtDfrSfE7M/Czzns0U+BRU1ysLo=
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249334-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,goodmis.org:email]
X-Rspamd-Queue-Id: 67443570C28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 17 May 2026 14:01:53 +0300
Andrii Kuchmenko <capyenglishlite@gmail.com> wrote:

> In __modify_ftrace_direct(), register_ftrace_function_nolock() makes
> tmp_ops visible in ftrace_ops_list before entry->direct is updated
> under ftrace_lock. During this window any CPU entering the traced
> function calls call_direct_funcs(), reads the old address from
> direct_functions via RCU, and jumps to it via
> arch_ftrace_set_direct_caller(). If the caller freed or invalidated
> the old trampoline before calling modify_ftrace_direct(), this is a
> use-after-free in executable code context.
>=20
> The race window:
>=20
>   CPU 0 (__modify_ftrace_direct)       CPU 1 (executing traced func)
>   =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80       =E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80
>   register_ftrace_function_nolock()
>     -> tmp_ops visible in ops_list =20
>                                         call_direct_funcs()
>                                           ftrace_find_rec_direct() -> old=
_addr
>                                           arch_ftrace_set_direct_caller(o=
ld_addr)
>                                           jump to old_addr  <- UAF if fre=
ed

You do not state where old_addr is freed.

>   mutex_lock(&ftrace_lock)
>   entry->direct =3D addr   <- too late
>   mutex_unlock(&ftrace_lock)
>=20
> Fix: update entry->direct under ftrace_lock BEFORE registering tmp_ops.
> Any CPU that observes tmp_ops in ftrace_ops_list after this point will
> already see the new address when it calls ftrace_find_rec_direct().
> Add smp_wmb() between the store and the registration to ensure the
> write is visible on weakly-ordered architectures before tmp_ops
> becomes observable via ftrace_ops_list.
>=20
> On error from register_ftrace_function_nolock(), restore entry->direct
> to old_addr since tmp_ops never became visible to other CPUs.

The above statement is incorrect. The tmp_ops hash entries are also
*shared* with the ops that is being updated. That is, by changing the entry=
->direct, you=20

>=20
> This affects all callers of __modify_ftrace_direct(), including:
>   - modify_ftrace_direct() used by kernel modules and live patching
>   - modify_ftrace_direct_nolock() used by BPF trampolines
>     (kernel/bpf/trampoline.c) reachable with CAP_BPF + CAP_PERFMON
>=20
> Fixes: 0567d6809440 ("ftrace: Add modify_ftrace_direct()")
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrii Kuchmenko <capyenglishlite@gmail.com>
> ---
>  kernel/trace/ftrace.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
>=20
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index a1b2c3d4e5f6..b7c8d9e0f1a2 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5950,6 +5950,7 @@ static int __modify_ftrace_direct(struct ftrace_ops=
 *ops, unsigned long addr)
>  	struct ftrace_func_entry *entry;
>  	struct ftrace_ops tmp_ops;
> +	unsigned long old_addr;
>  	int err;
> =20
>  	lockdep_assert_held(&direct_mutex);
> @@ -5960,22 +5961,36 @@ static int __modify_ftrace_direct(struct ftrace_o=
ps *ops, unsigned long addr)
>  	if (!entry)
>  		return -ENODEV;
> =20
> -	/*
> -	 * tmp_ops is registered into ftrace_ops_list here, making it
> -	 * visible to all CPUs executing the traced function. However,
> -	 * entry->direct is not updated until after this call returns,
> -	 * leaving a window where CPUs read the stale (possibly freed)
> -	 * direct call address via ftrace_find_rec_direct().
> -	 */

Are you posting patches on top of your own patches that are not public?

> -	err =3D register_ftrace_function_nolock(&tmp_ops);
> -	if (err)
> -		return err;
> -
> +	/* Save old address in case we need to roll back on error. */
> +	old_addr =3D entry->direct;
> +
> +	/*
> +	 * Update entry->direct BEFORE registering tmp_ops into
> +	 * ftrace_ops_list. This closes the race window where a CPU
> +	 * executing the traced function could read the old (potentially
> +	 * freed) direct call address between tmp_ops becoming visible
> +	 * and entry->direct being updated.
> +	 *
> +	 * Any CPU that observes tmp_ops in ftrace_ops_list after the
> +	 * smp_wmb() below is guaranteed to see the new address when
> +	 * it calls ftrace_find_rec_direct().
> +	 */
>  	mutex_lock(&ftrace_lock);
>  	entry->direct =3D addr;
>  	mutex_unlock(&ftrace_lock);
> =20
> +	/*
> +	 * Ensure entry->direct store is ordered before tmp_ops
> +	 * becomes visible via ftrace_ops_list on weakly-ordered archs.
> +	 */
> +	smp_wmb();

You do realize that register_ftrace_function_nolock() is itself a full
memory barrier? It's doing code modification which requires lots of
barriers to work.

Still, the only bug I see that is possible is that the caller may need to
do some synchronize RCU calls before freeing an old trampoline.

Can you show a path that doesn't do that?

-- Steve


> +
> +	err =3D register_ftrace_function_nolock(&tmp_ops);
> +	if (err) {
> +		/* tmp_ops never became visible; safe to restore old_addr. */
> +		mutex_lock(&ftrace_lock);
> +		entry->direct =3D old_addr;
> +		mutex_unlock(&ftrace_lock);
> +		return err;
> +	}
> +
>  	/*
>  	 * Now that tmp_ops is registered and entry->direct is updated,
>  	 * unregister the original ops and clean up.


