Return-Path: <stable+bounces-274105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cTjIAuKtVWqRrgAAu9opvQ
	(envelope-from <stable+bounces-274105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 05:32:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0334E750A74
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 05:32:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=ArqdH1rX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274105-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-274105-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21C153016AC4
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 03:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1E430D3E2;
	Tue, 14 Jul 2026 03:32:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC33E35675E
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 03:32:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999962; cv=none; b=Rv5sLr83yL2gwXbGoGJdkiE8p3adyLUFVTq+35UqtBUFNMgUpMMplBOn6R7AC7rgXIyk6JrbZPzczCvVT+a4TSTwFhYA7/ctjASWkgKYDiOgI9PVsoC0ac8wkcuOD2gnQQuYP90+LgUsuartYpjZHhZ2jSnIOK7UKrcGQ6rnS/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999962; c=relaxed/simple;
	bh=5l6nLVdO88+2acJsOr1UCToSieAPDX3Bwyvphb8xIls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn6IEvNl0qC84/EqVwVmUzU1gaA6J7jFgro+Kl0yj9HN8vFLsG0hOEwCg3Ee/20MDLpzPt2oWMcBATLIRaFs/jMntMkMsAIyvtZa+f+xH+m5CKUeHVFRUOA8pszFD9mpY+ad5bQfdu2D5N4WJcZiX/Ne3FNxork0ryWqinXj/+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ArqdH1rX; arc=none smtp.client-ip=209.85.208.52
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-698bf7a1a2dso5735168a12.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 20:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783999959; x=1784604759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bdiM3wGZvU9W32ITVwJWXfEY5ZH1jUwmribSUCxIuno=;
        b=ArqdH1rXOesSkDeZcyrn/gwmYeGCPfhD9ycpZxDFlq1zBr3byohbWaORK5xuqH9P+i
         Kp7BWm7ILY2LeTUxrHADGfcElxoWDlnPpBhtJ9OwCTU5hkGqqiTWQm0Ywi8VvSYSQhx4
         +Cg5J5j7gww51+d9kU01an3h1a3e4Rabush3KBhThPMvWOTRQiNcoknZwBpdgg/mzsTi
         QmsDm3aZlF/Affo/XDS+kP0YFn2VN/nccOxyxycivjBO/FYoSzCL+K9til6FtgxEq2Qd
         WLyI7qrwMz4UBX9JArXVYtfRCWB0a9sca3WoLrGIZ9Q8L8TRKbN899ZQjDFxMkn3yxz7
         Tg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783999959; x=1784604759;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bdiM3wGZvU9W32ITVwJWXfEY5ZH1jUwmribSUCxIuno=;
        b=q6G50RYWp8UyVGfkWj8dveh0C4+RPF0s26Hh0XIKrdVr/jZEzD+rL47k3wFYqBG2Ju
         7EitJHXmE7q3O2mMEBeUPfZPNzxbGrTfh9YVi1u+yfPgt4YQCTRzps95f+IQO/r3y+H3
         Z+P/wg5kUTP6syAwdxbADLcshKvQ9wMghMFEqvVOTQhmAALbLUA80F7MI1moGwHCNQmy
         2ZVRPcwIpALq+IgTvUbzBrSHR7NkBpWrR+htwO5iyc7uU3euSyD3lkafmYEftLaYlaQD
         9J28iXwSIRN4pmOBWW6i5boNQBXuKTCXpFGwvwNeGT1LWDSrkt0ClHsRBNJCiWxqQW7j
         91iA==
X-Forwarded-Encrypted: i=1; AHgh+RoDf1yuqiZTrJnSMK8QdGi27xlP5cnUgyxGaX7j49ccdVinTOvm0+r4NucMmtucmXAhXEw23IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwjqlZ1DceA8d/98N6bsSVyQ1pkLJXz6LGQ/yQu/ewsurrFqQj
	Eb7MAhB942++38qfqkrzDhMCuTQu3LILyAD/mwRRIaVHb9e1T7JeFX9Etg4j1LyEUWo=
X-Gm-Gg: AfdE7cnJMcPiLgBbeU/5fTp3HH+C6PLQhhZw1YxGFzecsbqYZILztMYIzTTJ/HcgjPf
	mIqUJwF4V08MSV4MIh6ADGPPmuMeJMXeBMEB1M81WDzQQStMsOWhAmaK54Rk8cr8kAfFt39QM2w
	fovgDu3Q9L6jIX3ZtSCdRS7eOcXTU/DFeCSG/D/O3qaW0einpAKN6dtEVNyBaPveBQ13tjYVB+6
	c9Juc52ifLSPwoKqkT87hqwbhG7acMd/0RD71Y9AMNe+LikP0CpVhNRVw0dBLBJRzWJjGvWIW9T
	DITcg43y3EtOXvj6pp5lySJc51hVmgoYlrT/0DkDS3/TC32DKNfMiZZZUY/Ps09d8/TARCIg2I+
	zs/kCskNLF0Fx7N9KJzEkFQRvdd4ac9a/xWmggskfexY4vIZP5SN1nzkpllteSHC0KhyyYuVfKj
	wHxM1Rc8sbap+ZE5fyr0hwho2Z3DNomvZ+JqiBmE/Pp/4=
X-Received: by 2002:a17:906:f587:b0:c15:e8c8:34f with SMTP id a640c23a62f3a-c161e84b4a7mr493269566b.13.1783999959174;
        Mon, 13 Jul 2026 20:32:39 -0700 (PDT)
Received: from u94a (27-51-48-151.adsl.fetnet.net. [27.51.48.151])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2b79c9sm14334466a34.22.2026.07.13.20.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 20:32:38 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:32:29 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>, 
	sun jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matt Mullins <mmullins@mmlx.us>, stable@vger.kernel.org
Subject: Re: [PATCH bpf 1/1] selftests/bpf: Enable BLK_DEV_NBD for
 raw_tp_writable_reject_nbd_invalid
Message-ID: <alWsBzShn4sgDRl-@u94a>
References: <20260713063513.215781-1-shung-hsi.yu@suse.com>
 <08508d2133284d49e1da297895c85cf854a97bf3.camel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08508d2133284d49e1da297895c85cf854a97bf3.camel@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274105-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:eddyz87@gmail.com,m:sun.jian.kdev@gmail.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mmullins@mmlx.us,m:stable@vger.kernel.org,m:sunjiankdev@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,mmlx.us];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:from_mime,suse.com:email,suse.com:dkim,u94a:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0334E750A74

On Mon, Jul 13, 2026 at 01:47:18PM -0700, Eduard Zingerman wrote:
> On Mon, 2026-07-13 at 14:35 +0800, Shung-Hsi Yu wrote:
> > The raw_tp_writable_reject_nbd_invalid test relies on availability of the
> > nbd_send_request tracepoint, which is only present if the selftest kernel is
> > built with CONFIG_BLK_DEV_NBD=y and the kernel built from current BPF selftests
> > config lacks.
> > 
> > Without it, the bpf_raw_tracepoint_open() call always returns with -2, leaving
> > raw_tp_writable_reject_nbd_invalid test always passing without exercising the
> > checks bpf_probe_register().
> > 
> > Cc: <stable@vger.kernel.org> # 5.2.0
> > Link: https://lore.kernel.org/bpf/alRtilWhKw4zzMkI@u94a
> > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > ---
> > Not sure if fixes tag is the right thing to use here, so use the cc
> > stable tag instead to get this config change propogated to other stable
> > branches to make stable BPF CI's job easier.
> 
> Shung-Hsi,
> 
> Thank you for figuring this out.
> I'd suggest we switch to bpf_testmod_test_writable_bare_tp() [1]
> from the test module to avoid the config dependency and let
> Sun pack all of this as a single patch-set to simplify backports
> (if such are necessary). Wdyt?

Make sense, that's probably for the better.

pw-bot: changes-requested

@Sun can you make sure to include the follow tag for [1] when you send
it? Should give a better guarantee that is will be picked up by AUTOSEL.
Thanks!

  Cc: <stable@vger.kernel.org> # 5.2.0

