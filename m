Return-Path: <stable+bounces-267430-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c6JVK9iLNWpuzQYAu9opvQ
	(envelope-from <stable+bounces-267430-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 20:35:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D3F6A7657
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 20:35:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HhBEhgFU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267430-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267430-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54EAE3019527
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 18:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42A03403E8;
	Fri, 19 Jun 2026 18:32:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694E333FE05
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 18:32:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781893970; cv=none; b=sgA5xK6xgW8IpVfy7IcV28skJ1QEfeAZWSH4lj3ND78RWe3hG1HQLq4hJk3XVpPHDS6Amhhw2vhDPt16GsOQ9ppadcrWq/pJ5uDLWZdJv5TVmzlX9ycp5gWjusFzG3Cxy2KN+3EpOqiYgdOE6if3cecxVirvxHFLkV2wyrWMDJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781893970; c=relaxed/simple;
	bh=MRikFyOt+Z+9KskamX/Piwxe18I7k/0vTqp7ubH2UfE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LULynplsQF1eVuyYRXhetyF8lDUhiYzDdtal5NEv+jyFKWcMrYp+oSYOmMpBvaaiCnls/5+sUP3JUAZI3umxmyfmaxYaSVVrXvJRvFVXGL0kE8yZgiEou+kongz4GkUeVT0ODBpk4bt2LLVdKJWua4WY8EvJq0wTZyGmDc2UkoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhBEhgFU; arc=none smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-842307473b5so1631378b3a.2
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 11:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781893969; x=1782498769; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cEb6cMeL9zrv839ZEgK5GghTYMMas14NtTvMWavtAx0=;
        b=HhBEhgFUovrHZODD5NRhDBt2tq1Fbcev/h9XK2X0dmpDon5q1Pq1LUZvX1v0OSUnI6
         pdMSKZlyRVF8JmTJk9UVrkElGRJKVhsL2hWU/JP3yWAj8/YbAy4m8TxRFW4PnzwDBlhA
         TJK0zohvam1ox79f5Dx3YVRL0On178FuwHpQ5r5+V4rdH5nDLCZ7rGDE12NUjjbq6bsi
         XpreIYyXsyvW+H+X+3twa0GKXEHFBrivRn22HjwuG9Ed3C9eZFKunMJzUItNDkk6hJue
         rnZkTAQ9c8/QR+F9k7n/mfX20LiKX20Flbiz5/2OXsEgE22dmYqZNqBWUFWQrjNrq1z4
         nFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781893969; x=1782498769;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEb6cMeL9zrv839ZEgK5GghTYMMas14NtTvMWavtAx0=;
        b=S4JewfSOoOOi69PU/aDoBQKC6JXNOZlRyAfyTtcbbDjDWRyiR8sS4rayi/IWVy6APX
         bAq8T5qjwS2MUmtbx45uwf4vn9I5b6+1VpK3/bF27oWRPSj2J0qqeeqP/su4c0d6P6EB
         xNfGUoHW0KtauWYkRM2+1cy68tvsueZqKJ6rvI9wS12q3eXvcd0uI6b8fnfFJzwZeVd8
         PHmnaACSnNS361OBx2Z7qafDWVKND9GLb9x7rv9N68ksKvlx3N+nyntP0qCxRSFqIYTS
         WlyEGFFd8hVYAIzCEG8liO9EC6TCuO2XMIKmhgJ1WhQrpRyO3F+BRwch0FhBbcBpTRUg
         i3bw==
X-Forwarded-Encrypted: i=1; AFNElJ/PC+IX9QJSf4ovIRGQUOYtQ+6IW18qwp+nE6MTtAOkMppAQ64jRsQZqgyeYR3O9xj6OU7tr4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1XQNj8IKaIG2kHHZZuwjxVs/x5ge3EgzqaR04D0V1kpmPSXV3
	8lo+PFDQY9asnCUdmQX8MLFYMj3Q/XPJ+juP8MMG/tyC8RmBCQKikHCv2K5bLqE7N3+mUQ==
X-Gm-Gg: AfdE7cmtQiMhUdt46bpVE9gOQ5EtSDZTov4WJS2jWn+sbzX7sOx+8geROYKuOETsBWl
	he5g0wn4mI+MeSvKszI8FbPbuToA8hx8zA5bEVLsaDU+QWk+SRtT9aHa9wgGYmxOdy4/bvzIW7g
	WXjEjWfk5yKnX0QHvl/etYgzw59Yp5SmlQr5dCqal43fXkVBDmBdab/YSODV+tapbXJTzUpxe71
	cMp/UQWQGe1AueuEpUL/rdSJ5nGPiOQj6Yk7zo0FZD+DPM2oiyvx3wlxTkvk7qkVa1lQ9VZSB+3
	MUa1JKOp5w3MewRlLU1Zw++PEBblDw2UUTvjnv5WBckEkBZ3/Zqni+U7O0GVNeQwJRBP69je6A+
	j7xceCwo6ujbLlK+2e+ol1xCBuvP+oXkPsRy/k1e6/ZMN9pHY4huPOuCPJ1eh9EaRyJGP2tsfns
	atH//4d6ICvNkGkfiGm+xI/Obo5hGEZvBWdoQQd+5fwQ==
X-Received: by 2002:a05:6a00:1816:b0:845:4f08:17eb with SMTP id d2e1a72fcca58-845561b8924mr3755898b3a.46.1781893968619;
        Fri, 19 Jun 2026 11:32:48 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8455382b766sm3776281b3a.47.2026.06.19.11.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 11:32:48 -0700 (PDT)
Message-ID: <4eae275e93d8eb165da8485a127a1fd0e7f91510.camel@gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Reset register bounds before narrowing
 retval range in check_mem_access()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tristan Madani <tristmd@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, 	andrii@kernel.org
Cc: xukuohai@huawei.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org, tristan@talencesecurity.com
Date: Fri, 19 Jun 2026 11:32:45 -0700
In-Reply-To: <20260619110251.2576334-1-tristmd@gmail.com>
References: <20260619110251.2576334-1-tristmd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267430-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tristmd@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:xukuohai@huawei.com,m:jolsa@kernel.org,m:bpf@vger.kernel.org,m:stable@vger.kernel.org,m:tristan@talencesecurity.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[eddyz87@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,talencesecurity.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20D3F6A7657

On Fri, 2026-06-19 at 11:02 +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> When the BPF verifier processes a context load of an LSM hook return
> value, it calls __mark_reg_s32_range() to narrow the register to the
> hook's valid range. However, __mark_reg_s32_range() intersects the new
> range with the register's existing bounds using max_t()/min_t() rather
> than replacing them.
>=20
> If the destination register carries stale bounds from a prior instruction
> (e.g. BPF_MOV64_IMM), the intersection can produce a range narrower than
> reality. The verifier then believes it knows the register's exact value,
> while at runtime the actual hook return value is loaded, creating a
> verifier/runtime mismatch that can be used to bypass BPF memory safety
> checks.
>=20
> The else branch already calls mark_reg_unknown() to reset register state
> before any narrowing. Apply the same reset in the is_retval path so
> stale bounds are cleared before __mark_reg_s32_range() intersects.
>=20
> Fixes: 5d99e198be27 ("bpf, lsm: Add check for BPF LSM return value")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
> Changes in v2:
>   - Use [PATCH bpf] subject prefix per Jiri Olsa review
>   - Rebased on bpf/master
>   - No code change from v1
>=20
>  kernel/bpf/verifier.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2abc79dbf281..6de9af4115dd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6196,6 +6196,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
>  			 */
>  			if (info.reg_type =3D=3D SCALAR_VALUE) {
>  				if (info.is_retval && get_func_retval_range(env->prog, &range)) {
> +					mark_reg_unknown(env, regs, value_regno);

This seem to be a real bug, could you please add a selftest
demonstrating the issue and post v3?
Something like this in the tools/testing/selftests/bpf/progs/verifier_lsm.c=
:

/* lsm bpf prog retval load must reset stale register bounds */
SEC("lsm/file_mprotect")
__failure __msg("div by zero")
__naked int retval_load_resets_bounds(void)
{
        asm volatile (
        "r6 =3D 0;"
        "r6 =3D *(u64 *)(r1 + 24);"	/* return value of the LSM_HOOK(...file=
_mprotect...) */
        "if r6 =3D=3D 0 goto +1;"           /* r6 value should not be predi=
ctable here */
        "r6 /=3D 0;"
        "r0 =3D 0;"
        "exit;"
        ::: __clobber_all);
}


>  					err =3D __mark_reg_s32_range(env, regs, value_regno,
>  								   range.minval, range.maxval);
>  					if (err)

