Return-Path: <stable+bounces-262346-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id avCTHp9GKGrqBQMAu9opvQ
	(envelope-from <stable+bounces-262346-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 19:00:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C98662B5D
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 19:00:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=g+UUsVQl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262346-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262346-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A12A23015D28
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 16:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9544A1389;
	Tue,  9 Jun 2026 16:47:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568BE47ECD3
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 16:47:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023667; cv=none; b=Lx9ISzVPNUSHNmKcXlwkjzjI9aKXsASiZI0xUoTfX1H4np765pruDVpok8H/Yixoubr+R09nOIwujhuPV2AwJaPed4U3Fz7bKWTDJZhxqdUqI+DA0Alqm6wJKdTQq17UHoBzPnjlj+EwLVuYLCem6K0qT1SQyVeHsPK2SRrtzVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023667; c=relaxed/simple;
	bh=8tfPgrZ5njwmpOJtSnueMm9pFl26DajhtsqxQdPZBho=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NFHRp7arUQ2P56xbxpY4uQd+6/ucwi5CaOBY7RoHuZOUJnaJlYiwUQPbCWMmuUF7aWUNgAsjHBv6B3vnP7Ywi56rP6vcgCGUhA3ucqtXf+IzW4OEiYMLLiw9akgwZPbNB6lOvQXJNSbclTPtEnUL5OUcfjtpMmPaoLbvjV7ya3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+UUsVQl; arc=none smtp.client-ip=74.125.82.48
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-13721dfd471so7567586c88.1
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 09:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781023664; x=1781628464; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8tfPgrZ5njwmpOJtSnueMm9pFl26DajhtsqxQdPZBho=;
        b=g+UUsVQlOBTpDMk+OabNam55ZBM9vrq1xEKWCft+aUs0+F989KaB5Ai+62pLRWg17U
         4x+hezgfs9n7+La/v+Arpuo88g0Q2ApY6JVzmhCzAUCg1XCef07gP+LBGRE4cacTHYU4
         /05SmcLddo++RRHT0WGwnlTEjhMxFDV4wJHyWIGTNtjRUvK+ECWGuIdYzjN4oOT5aP7G
         tVdJtBuy9Qs7Zz+mAzCpTxz7AgEVgAvQKbq8qfg7/wtk9VrN2YrBzZk8KlcxU6rNeO3f
         zf2DeoULvEpVrlQrVzulSYtRwykpoEROezkCcilpbKE1Ro0KBequ0O2eMLt+eCurgi4J
         IsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023664; x=1781628464;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tfPgrZ5njwmpOJtSnueMm9pFl26DajhtsqxQdPZBho=;
        b=pMq2qBoydRxB8Kd6YPk5OKw+tbghdESStvuRhVSbwJAWWaC0d3/sNXuCdnv4G3y3uw
         1lL2IJaJjF7A1641PVOXg4IHE7ez1RuwyTjUvW5lJNSz5CC5gVR/yLIxWUnLhxlY4ee9
         ik9S2Zj9Ov8wlbbArRe1286lLkppjQIgVzot5oNeMu8DFPYR3oyP8gMlnD5DyxWWKgYe
         s/2AZ50oKe349slBS60VIZ05wlbr2RV1C4NeEff/7eSBQzCj9anQLRPRlNiJp+q7m79u
         A81SZyoSfZEMTfwvEcRimfSIflL1GK2Ylgi+fWOHuOVuyIP5eU4bABFYWPbFIiuR0gbW
         +DLw==
X-Forwarded-Encrypted: i=1; AFNElJ+w5PhbtYKEgh0w4k54Qfu57jc3zmhShGudpC9lxVQH1nApb2LrZaI58OflfF/Zk0+firCIiW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Ap48Tq73nieQhZXFAMhHC37aQ/CmtFMeYmZAT7oCE3Cj7dEc
	WYNnDAe24YAwEqxqMIUdQZ4te4Mf9d6j9LhpwovwPyf/WBGlqOIPM2fl
X-Gm-Gg: Acq92OEv/S9kyITJioZxuHp+8jOExywv9IwZhwErqiWPR+KMORLg6DK9LYq8z1F/pQu
	V1fRxQAh4dK3vsFSdB4NYM4XRq8lY68Nq77SaoDyQ4xeUqx0Y0LYuSwf+mQQLTUUgy2kN9GoD84
	zcQjGcZLT7C7b+J9IxyQk+7t5VSzhhvZLad3hrvKety/B2ueK/lRSejgOTEr6G3hPYQq2pEB6MG
	NrKorn5KdrdnIJv4v0GR08ue/HaR1VIhZnhz6VWdCJen37J0gl7UO1gm7Ku8LnE+0xFoGP+V1pB
	SMHLyqMy1CmaQ9uFXyYQrtd2HRel+GA7ekeQ6prWzVq9TBwJrQQ11RHKM0vucRSObhlGHq0GHQn
	nRl7mPh/yntYeJwWQ8aqR7IoDhP1OaH+PAsQU89C+gQNLtSBHQfYvqTKtmVmXMKX4v8BIKTWu7+
	yHqhlT5L20j1M/6KmZUMaI3l9NnYXvRza6Qf5MqwBFTm7j8txTD8CjAPUJF7ZR+MOlKin7wpRi7
	IFsvijqVrXDQA4HLsw=
X-Received: by 2002:a05:7022:211:b0:128:d967:4673 with SMTP id a92af1059eb24-138066a8020mr11624934c88.16.1781023664342;
        Tue, 09 Jun 2026 09:47:44 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:bc91:a683:c279:a106? ([2620:10d:c090:500::3:1322])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f553ab33sm15118442c88.10.2026.06.09.09.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:47:44 -0700 (PDT)
Message-ID: <c51441fb2fa48d604818dffa59b7009f396fa0d3.camel@gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Add BTF repeated field count
 overflow test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Moses <p@1g4.org>, martin.lau@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 bpf@vger.kernel.org
Cc: song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	houtao1@huawei.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 09 Jun 2026 09:47:41 -0700
In-Reply-To: <SzebdWqm2zREZBf8Tc5Kc-JDWbh9nBztnk4PUu5kRSD1OOdr_ESVTt__2Hd3-lClr47jIjJCXfOH0RHsMpjjpEUh_R2v30nh3T1IXNT6Pbo=@1g4.org>
References: 
	<SzebdWqm2zREZBf8Tc5Kc-JDWbh9nBztnk4PUu5kRSD1OOdr_ESVTt__2Hd3-lClr47jIjJCXfOH0RHsMpjjpEUh_R2v30nh3T1IXNT6Pbo=@1g4.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:p@1g4.org,m:martin.lau@linux.dev,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:houtao1@huawei.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[eddyz87@gmail.com,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[1g4.org,linux.dev,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262346-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2C98662B5D

On Tue, 2026-06-09 at 11:37 +0000, Paul Moses wrote:
> From 7129e266643883a4f83e65fce3ce20c7f7269fb3 Mon Sep 17 00:00:00 2001
> From: Paul Moses <p@1g4.org>
> Date: Tue, 9 Jun 2026 05:08:54 -0500
> Subject: [PATCH bpf] selftests/bpf: Add BTF repeated field count overflow=
 test
>=20
> Add a raw BTF test that exercises repeated special-field expansion with a
> large array count. The compact element layout keeps the array byte size
> representable while the repeated field count overflows the old u32 capaci=
ty
> calculation in btf_repeat_fields().
>=20
> Signed-off-by: Paul Moses <p@1g4.org>
> ---

Note that this selftest is depending on a fix:
https://lore.kernel.org/bpf/DJ4DWMO4HXCM.3NVLDGNT2704E@gmail.com/T/#t
W/o the fix KASAN warning is reported when executing the test.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>
[...]

