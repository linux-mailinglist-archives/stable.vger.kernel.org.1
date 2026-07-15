Return-Path: <stable+bounces-274718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HiU1Gl4JV2oCEgEAu9opvQ
	(envelope-from <stable+bounces-274718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 06:15:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E12375A6C0
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 06:15:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=WZkTsYJQ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274718-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274718-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E32E302294F
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 04:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E3E3812E9;
	Wed, 15 Jul 2026 04:15:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E31C2459D1
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 04:15:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784088920; cv=none; b=OW4VWe66aSKt3pwKk8C8AU30kiMBflLl3tVFg/t86gW+bYLlbQFx0+oCtZ6q6ZDX/xs1Kybg6iGKFUwSKQNhRkaiPkZrjc8Mzm3crwHVg1WV0ACfTcajaPTzgL5aqZ6uhEwpNksr/LURTwDtnm63ufJyg6cw30B9NhUdfKg25AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784088920; c=relaxed/simple;
	bh=16DHuToYWDY48zhMFmSTuIb8xl3je5jZqI8M9KYbD6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRtFAMD+d2gvOCiTt9j1DD4lPfAbo6Et4hcEfupDaiSLKqUahv5CN82YfYYXE3x3l7sm6gM7cngWkzHRfOA5f+OYcuadEVUL6tZ/KjJ+TV48Juw/02VDTJpBE7w9G1eIatC0LXJXfu4VmV7tnsOO6CBS1n/uJ45boxmlZmiV+yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WZkTsYJQ; arc=none smtp.client-ip=209.85.218.51
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so170417666b.0
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 21:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784088917; x=1784693717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f5HqzaGK1TaHR8NVrhGDd/lA3x1fxnTO8aG7VNVpk8s=;
        b=WZkTsYJQvvAdyF7lRNbHfK2PJ8PUqYJBllwwU9sVToozvYWYR10L8UH4S7Jt5Ea9fc
         AVeGNGMLMwvDYP38QNvzH3aDwCaoAiYv7cyb+7lbdbQ1RGaRvE6zje7ce1xe+/9oYoa8
         COy4shESM3SbP9ybL2fhuTVAKRbEMVP0CELZ6HOzXiTOkNUo2tgSaiZiPCyLQF8eEAox
         9m4DrLSQ/u5EDLoieBLYheX+YlUFgoM2Wtfxyz6WCLpIG88AL4K7EOBjN1kS1UkYNV19
         lztQKadKV72YWVnL0KoO5VNy/YygwQN9hhZTi5Af+mhcsa5PIbrZxCcBvqKwFIEwEfbb
         ok1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784088917; x=1784693717;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f5HqzaGK1TaHR8NVrhGDd/lA3x1fxnTO8aG7VNVpk8s=;
        b=KnKbep0dfcOiw4rOtQd82D3XcqIFPaCy5xqet9vQkS6BH1dL1dLAQ8ASo14Fx2wtdO
         Hbg5pHhQ823xQgEuHYxfDB3ydu9D/HpeYVaAew6TrAYAYz2DlfWF41uSlxfTI4HAhcic
         OvFUCsXeEyLYYSJGoQKZFmOBnTg0zA8lKO4cHN+GVG4Mb5H11TipYX/Brv+UW7z4fJJU
         Jds+0AuB0Rb6hUFObKKExA3ZLT5q2huDBYMuygC/fELSHNauTBPc4ilKzGy4o2AVJ8PM
         AiGBqCRKnlH43ck9qF8hseISZaf9Gdi1p2Mt4nHkBK6jQotsstKAWisXS7BQ2uH/hdD+
         sgnw==
X-Forwarded-Encrypted: i=1; AHgh+RpS7qQMp3k44Pl9vKzcWuWkQlTflkLkULWqje3PDTJRZxl8pcIdlNlqoenvjG6fVdS1RMkDtEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuxHAE131r+UQ29ofs7sSU3cnmmv2IucY4FRgMKf1K1eH7bcjD
	y10UyTfmoFL0L3PRGUg1M81YdiJICKLN37E5TCK0rnX3rymMQDJJoud6kkuqO9Ej7iI=
X-Gm-Gg: AfdE7cmTKXpkAaXINuwK+na4VLU8eEGqDNPMxMildpO6bAR3x6yg/71sNxh3Na9vKVc
	0e4oR3vWFGO8PdvhUU6rxbm7n4Uht58xtTfr2rJQVpdoNmkNTC15THWuEf8N6I4KPDTSELizI4i
	xK1dhT9eUpT9rV2NvdI9WUNl9mc2Fg/Yl5ynHqnhPM9bOtibSYHP32Xt6T18HAOn/TXFv2vwopY
	lWTz2t4CQIzXEN2sbmDQ2g/6s6KGSWxq4eQU6s5ZiRrln4wk13Vv8FQVQKqrmTznD/wF9BEU16Q
	Ajj8bZBBsCcU/hwzXpD1rs4SDh6zZg5Z7KyXXbvWryrk69E7kp56OeJ8rkwQcbNLg+18SkknU2w
	j5ES1sDgKu3oLf8HIcMksroXZSaoeMX1e4u6cQFfuApDA1Zgu+EUJDb8MqIP1sCouROWlpq3qSS
	iFGdPUfQEkd1pWsdOmKvufkU8ffmhjXFkA
X-Received: by 2002:a17:907:3f91:b0:c16:67d8:7a0f with SMTP id a640c23a62f3a-c1667d87c1cmr391012266b.28.1784088916647;
        Tue, 14 Jul 2026 21:15:16 -0700 (PDT)
Received: from u94a (27-51-89-168.adsl.fetnet.net. [27.51.89.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f238f75sm2427757b3a.9.2026.07.14.21.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 21:15:15 -0700 (PDT)
Date: Wed, 15 Jul 2026 12:15:07 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Matt Mullins <mmullins@mmlx.us>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH bpf v5 2/2] selftests/bpf: Cover negative buffer pointer
 offsets
Message-ID: <alcGgfNM94zgydlK@u94a>
References: <20260714093846.18159-1-sun.jian.kdev@gmail.com>
 <20260714093846.18159-3-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714093846.18159-3-sun.jian.kdev@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274718-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:sun.jian.kdev@gmail.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:emil@etsalapatis.com,m:jolsa@kernel.org,m:john.fastabend@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:shuah@kernel.org,m:song@kernel.org,m:yonghong.song@linux.dev,m:mmullins@mmlx.us,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:stable@vger.kernel.org,m:sunjiankdev@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,etsalapatis.com,linux.dev,mmlx.us];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,u94a:mid,suse.com:from_mime,suse.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E12375A6C0

On Tue, Jul 14, 2026 at 02:38:46AM -0700, Sun Jian wrote:
> Add verifier coverage for constant negative offsets on PTR_TO_TP_BUFFER
> and PTR_TO_BUF pointers. Both programs adjust the buffer pointer by -8
> and access it at offset zero, so the negative effective start must be
> rejected at load time.
[...]
> +	const struct bpf_insn negative_var_off_program[] = {
> +		BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
> +		/* make var_off negative, but keep the effective access offset non-negative */
> +		BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
> +		/* one byte beyond the end of the writable context */
> +		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_6,
> +			    sizeof(struct bpf_testmod_test_writable_ctx) + 8),
> +		BPF_EXIT_INSN(),
> +	};

Come to think of it, perhaps we can add another one that test one byte
*before* the start of the writable context?

I understand that it won't even reach the attachment phase because after
your 1st patch is applied, access to effective negative offset of will
be rejected at load time, but the one that tried to access one byte
before the start of writable context was what that triggered KASAN, and
would be useful to have it as a regression test.

Or alternatively simply change negative_var_off_program[] to be the one
that test access *before* the start of context. I am not even sure if
the compiler generate such pattern; if it doesn't, then this test would
make future refactoring harder without much benefit.

[...]

