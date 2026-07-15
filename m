Return-Path: <stable+bounces-274789-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xcLVOv9PV2pTJAEAu9opvQ
	(envelope-from <stable+bounces-274789-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 11:16:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 875B675C57F
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 11:16:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=eyJ0F88i;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274789-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-274789-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F03D30041FD
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 09:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA85F41D656;
	Wed, 15 Jul 2026 09:16:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F86041D4F8
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 09:16:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106999; cv=none; b=cUKTsQlki4JpTcy0NeL0WFAA6xAWBX6J6Pe7yOPjpUoI7B+t0eaK7wUlgbyvyLvKKhJIaNF6Fu74Yw2RvIBlRaj3CTOtYk/riMWDwQXrU5IuOmMMP/ngCKtel+xsEEqRNCUE903FH4jquIsWSYKltYL009bU9pv/Geh7w44Rg6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106999; c=relaxed/simple;
	bh=j9GQJQzKvcMR+VCSiLR4VIzU/cQ+59f4K6xs5L/YzoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEUvnymmoSgRKepqf1Npic25Ul9uv/ampscpMNh48aO6JRBGP87El5L4xnoNJZi6dKSd/HqLkP3dEQ148RfJG0KvUA1lj9fPa8PfPWyAeAcDn1SESacxY8NPVTe37ua7dtO5k1E35P7W8+oBaVpD41EX66D0M1lc3dpimxD7lOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eyJ0F88i; arc=none smtp.client-ip=209.85.208.44
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69ccd6483acso2660253a12.3
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784106994; x=1784711794; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A1ZmhCboRG80lxcYaF433cPODXSJBxTB3W4f2Wh3+4c=;
        b=eyJ0F88ipHm7mrBSfZk5sbVGtLSJL61gfqM4lmBMfcwfbHgCK+2o0CQumTSsH7jCG2
         MhIAXtEF1t6+E0MGfjVdNOBIoSjqjqBbr3p7ZngEHg6h01XrhWlXLlvtypxmKnOdJaDm
         FUDgM08QDUiGzMuSgsg1Rh6vjTpFRmlfzmsyKSXA3mM9skH1ytlWXREnI5pX2KJ1xK2A
         baSMJRgxUenAH1cqQF+ltlf1m25ideXr1y6U2GwDutvv/u5Z3aUvEPxBkXL1W8qr4zCd
         yYNbqLuaFYOPLSd2r9hHyzp0c3NvIeiW8pZUpDN0saakUlW+FNHUC7QVVNGf/Xi0CoP2
         OtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784106994; x=1784711794;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A1ZmhCboRG80lxcYaF433cPODXSJBxTB3W4f2Wh3+4c=;
        b=WAIsltcIbvA6NGjfoRSdzfan8csaEVwLwHglEeZIuHbJnbaOe6Mw6DdwW+8KBsjqfB
         OEeJfNjc8B1QNglEjooFn/VOxrojDVCLrJr1uM1xYzXui/jIAOV70zKSQpZCeOAw/dGm
         0HMIsCOYTFWESequTRC0nI5JB8810G/0FJ3dUkapfchLqu1OzIlu/n2Q8iQpwP6jTv29
         WJxx0n/NeqFmQYeZgK3dgQyihXjIy92DHV6SKRHBd6s1dxygKdjZ2CeaemGAqVlpAgVu
         i0ebmGodRQjNTgI9X+Rcu/3VGS5PaLcdztVGFYYx/8c2frUKu/NEYKANTxeZeDk+NpjO
         vvrQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/ExG3Zt0rBPGH04JGPGxWmRZLzvUKdxQ8jwyOHRtayhuIpswtFOS40QKxMKXaSylHSd88zxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCwTztAWnt7caCh8+v1GPIl555avL6iMiKh3hmVteTX2B+/grJ
	ldJ/Tn8WtAXCqHNrkur59ae24n4cZP9LbDy6JdAY5+3pr442OXkNv1LfZ4qtdCqmCn0=
X-Gm-Gg: AfdE7cmrPz4w8JGHg0LfNEgBJyNgI4tBX3aF7sD0FhK+fevXyiEZDVqzBH3KoRdoYlg
	aHzM/VhjdfUYM9DPP5ba3KeTN9sGrnBhXIzX6MnlJg75fZs5lJDlzNOy3NKnjC506yVAXKfQ8Fz
	J+4XbLUbCF0B/cGv9JM2m3fvva6rxfuSOBF9gQaX7kuUx1FMuNMbNeRO5nW0R6jZQI9QsCIv0bn
	oRqKE0I3L9A/ja/ipkYuitzcDsFMMLDbUNbDbSdzARfcE3sIIRNzDo+iZnTfnsPY9VlrmRUzQmZ
	R2nwPqxM3SGpf/nq/76w/Xj0UX7gHGfdm/OMNDkiZy2WX+7KOkQNR1rZl9AsVrr3h0wqM4aktZA
	N9NHKYELkb9AxnTadakIQOEJ2qjXXEyhdEogPGlR6bY3abc7SQfkIqvu9pXaTp7kJBbAx1EyoHj
	aN0yFtxCHpdYOmTrN/Hr8KYCc2VRL1oLFI
X-Received: by 2002:a17:906:9c8d:b0:c16:579f:f7e2 with SMTP id a640c23a62f3a-c1667c58e81mr324023266b.64.1784106994203;
        Wed, 15 Jul 2026 02:16:34 -0700 (PDT)
Received: from u94a (27-51-89-168.adsl.fetnet.net. [27.51.89.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3c99fsm130888425ad.68.2026.07.15.02.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 02:16:32 -0700 (PDT)
Date: Wed, 15 Jul 2026 17:16:17 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: sun jian <sun.jian.kdev@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Matt Mullins <mmullins@mmlx.us>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH bpf v5 2/2] selftests/bpf: Cover negative buffer pointer
 offsets
Message-ID: <aldPkgqkV9yq9OFf@u94a>
References: <20260714093846.18159-1-sun.jian.kdev@gmail.com>
 <20260714093846.18159-3-sun.jian.kdev@gmail.com>
 <alcGgfNM94zgydlK@u94a>
 <alcKV2MXI_5dsaez@u94a>
 <CABFUUZFsJsF-C5Z2gb3FkZ7WD=vBavnGdZ7veScP_+dwZLsaMg@mail.gmail.com>
 <488c235db713648bb2f5c90e4389c96a97ebcdde.camel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <488c235db713648bb2f5c90e4389c96a97ebcdde.camel@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274789-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:eddyz87@gmail.com,m:sun.jian.kdev@gmail.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:andrii@kernel.org,m:daniel@iogearbox.net,m:emil@etsalapatis.com,m:jolsa@kernel.org,m:john.fastabend@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:shuah@kernel.org,m:song@kernel.org,m:yonghong.song@linux.dev,m:mmullins@mmlx.us,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:stable@vger.kernel.org,m:sunjiankdev@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,etsalapatis.com,linux.dev,mmlx.us];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 875B675C57F

On Wed, Jul 15, 2026 at 01:54:37AM -0700, Eduard Zingerman wrote:
> On Wed, 2026-07-15 at 13:26 +0800, sun jian wrote:
> > > Anyway, still recommend adding a regression test that test access to one
> > > byte before the start of writable context.
> > 
> > The new tracepoint_writable_reject_negative_const_offset verifier case
> > already covers an access before the start of the writable context:
> > 
> >     r6 = *(u64 *)(r1 + 0);
> >     r6 += -8;
> >     r0 = *(u64 *)(r6 + 0);
> > 
> > Its effective access range is [-8, 0), so it is rejected at load time.
> > This is the direct regression test for the negative-start case.
> 
> The existing test seem to be sufficient, why would it matter is at
> offset -8 or -1 given that the read is appropriately sized?

Right it doesn't. Let's just, pretend I haven't suggest that.

[...]

