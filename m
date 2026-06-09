Return-Path: <stable+bounces-262361-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6BTzArFYKGogCgMAu9opvQ
	(envelope-from <stable+bounces-262361-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 20:17:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D5B6633CF
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 20:17:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WjfeRmBS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262361-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-262361-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C718306A15D
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 18:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C05048B385;
	Tue,  9 Jun 2026 18:08:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712E348B36F
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 18:08:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028492; cv=none; b=NxJkYu2AGsYTRJWMEZo5xnkyvdJaBu5piKqBJGgaPoTaVJQZV14PCkjFpLbOvoECuWh3KeLMJFYSfo/FdbLlE38Nu4c2FHZ8RmPnATwSaCRETQx4PN19Q87HTwuSiy1O92LYmxDrVesqIsa2cd8kuuBmu0ZezeZn71wcf7s1TwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028492; c=relaxed/simple;
	bh=Gv80fVqWANIxq7l0YC2ixWxD6mTMoOIRWTXH5qo9db8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=T4L37jrjhbTW92X+s15AYg+LGuj7B84aPFUdSeJmrO4/txvihX0rNlRV7ZItbMINIweTRAVld3ytIpYktDjiCZm/B/TeIGrdUMxnNoADIQNkCLMhHs7jo1OcSdfgeggFAeNWHqBeX1JjcHw7mLPNY/OyIutGIxIE5nPq7FgcvWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjfeRmBS; arc=none smtp.client-ip=209.85.160.54
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-43f5927e70aso2395569fac.1
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 11:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781028488; x=1781633288; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gv80fVqWANIxq7l0YC2ixWxD6mTMoOIRWTXH5qo9db8=;
        b=WjfeRmBScytQ3/XGA+uEp5gGleIrf9mA6YT9zXK5ifIv7kMi/Z0AFGO7A4W0Ix7MoK
         FhwZIDBwgitxzGvj+fCE2Aoc5QHrFwqoPV9cf26L0YrZuyekKLaqSf5gYBkThJFyxqIW
         9dd/km+20W/0SyYVWVcf2P+0R/NzZeCB74BstfCr1TA/csXIbH9Ly4i6cKzMgimx/9do
         ACgOsJgSPr1CiOjmbQWtG9cUIXsz4ofZ/BJhCzzPAn1lhULSsK9F/ZYy2luBJuzSIApH
         tpXA7gjpza5yaNmuW9dny/rhdI9xaX2MQmERyS6qmyNiNPx7i0kNmH3uROfpdxivv2Wv
         jQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781028488; x=1781633288;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gv80fVqWANIxq7l0YC2ixWxD6mTMoOIRWTXH5qo9db8=;
        b=jRLX3S5qM7tdC0E/Dja9N53wkdhn7zIeZBwe2/wllV9dXQVZufv06pjKb3Ah93w9lA
         Tip+0/6Q5b2msKjQTle5OFmcUkW8HNZZdLj2UxDC+imt0FOpObU7T7kzh4z6ieqdgANY
         z+KkTLYnU6VJhwJYyVws6L37/eGfUUgSSRr2CGy4VtS53hLrrWsUTBXjzsOdfeiTdT8X
         5B6hpy6Pvr7OsiZ/x4K8D1RYfAAga/E9sqYkQIGQMrM5p43pHuFqdXgnyE9ODn50POds
         8Qv06prIjOebAZdoyA421k6/faERmusip9/3u1vz1F8h9GOScdbaLkMUG4pkvTOMsYCF
         TP1g==
X-Forwarded-Encrypted: i=1; AFNElJ+1fsU1FZ6rXYEop4p2KVIr/AaEQyUVN4DjqzmZgXMxZE0FKvqoL8T2gCnTbv0XQNZy26+T1w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQc13DiFHlFw0a9wjl6GF5VbFXgsll5WpfSjSK4Vh4UHQAdkTs
	yJuwRwnLqaUojuEbsClLslCie66fornuDp99WvAWfh0iFVqALn/c1Gm5
X-Gm-Gg: Acq92OG82PHaIArzHsJfbJly6QlIZ0wFvLd321Gvl6/XZp+TDH99OF50cyl//UfTUaf
	biObk3+mDaSLK3SKF6efmWjztBjXFWUExnL2qC6B+vgLsL2YMSwRiflruJxVB80YSPbCpEdJl1B
	neQTGZOpMt90Dk2+lWexG8B9fOT2JnohoVzTFSfR0ZEG5pxtGm8ZAeYj2MV0aX09iEEdnITvNra
	cD2RslnlFQBLRGEHLhFrTmyNQy5EwES4WuKOPXLwXK8vgu2znUkAdY2y5YMCq80sWwddAws8DYi
	/VoTSFAGarXVhvDAMk0EToAxTSkloo+5VNRWoxW8KBYt8SGQSezGGPhCDQFGN6wh2OM5Om+JAxj
	+BQ0JGpn5zJx9CvX1B5V0hByc711ptH2Ipy4Tu8oyLwpXiyUtlvMmHr6yoEzvsLoJyPBITsL3sE
	9hTDichhhmJ0Qy4JlOspoHcKy+u2DxJWWqA1QoDRmPtoSzsx9dXzUizCVGWFYCua35HodYNxy0E
	n0+CpKFcg8pgup+mrbiQJrLmM5F
X-Received: by 2002:a05:6870:c69d:b0:41c:3225:f98e with SMTP id 586e51a60fabf-4413d6b0988mr11892044fac.2.1781028488224;
        Tue, 09 Jun 2026 11:08:08 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:58::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8465e00sm16402950fac.15.2026.06.09.11.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 11:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 11:08:06 -0700
Message-Id: <DJ4PWNJMKALZ.DY46EM9P97GA@gmail.com>
Cc: <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <houtao1@huawei.com>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH bpf] selftests/bpf: Add BTF repeated field count
 overflow test
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Paul Moses" <p@1g4.org>,
 <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <SzebdWqm2zREZBf8Tc5Kc-JDWbh9nBztnk4PUu5kRSD1OOdr_ESVTt__2Hd3-lClr47jIjJCXfOH0RHsMpjjpEUh_R2v30nh3T1IXNT6Pbo=@1g4.org> <c51441fb2fa48d604818dffa59b7009f396fa0d3.camel@gmail.com>
In-Reply-To: <c51441fb2fa48d604818dffa59b7009f396fa0d3.camel@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.65 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:houtao1@huawei.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:eddyz87@gmail.com,m:p@1g4.org,m:martin.lau@linux.dev,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:memxor@gmail.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,1g4.org,linux.dev,kernel.org,iogearbox.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262361-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,1g4.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00D5B6633CF

On Tue Jun 9, 2026 at 9:47 AM PDT, Eduard Zingerman wrote:
> On Tue, 2026-06-09 at 11:37 +0000, Paul Moses wrote:
>> From 7129e266643883a4f83e65fce3ce20c7f7269fb3 Mon Sep 17 00:00:00 2001
>> From: Paul Moses <p@1g4.org>
>> Date: Tue, 9 Jun 2026 05:08:54 -0500
>> Subject: [PATCH bpf] selftests/bpf: Add BTF repeated field count overflo=
w test
>>=20
>> Add a raw BTF test that exercises repeated special-field expansion with =
a
>> large array count. The compact element layout keeps the array byte size
>> representable while the repeated field count overflows the old u32 capac=
ity
>> calculation in btf_repeat_fields().
>>=20
>> Signed-off-by: Paul Moses <p@1g4.org>
>> ---
>
> Note that this selftest is depending on a fix:
> https://lore.kernel.org/bpf/DJ4DWMO4HXCM.3NVLDGNT2704E@gmail.com/T/#t
> W/o the fix KASAN warning is reported when executing the test.
>
> Tested-by: Eduard Zingerman <eddyz87@gmail.com>

Pls resubmit both together.

pw-bot: cr


