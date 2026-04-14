Return-Path: <stable+bounces-237974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKSnAg+03mlZHgAAu9opvQ
	(envelope-from <stable+bounces-237974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 23:39:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D133FEA26
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 23:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1142F302479B
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 21:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AB538643E;
	Tue, 14 Apr 2026 21:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8GtCqsT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E226F386569
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776202763; cv=none; b=W3ysvZzC5OB4DVJNYcQByeMkqPnrCfVfXtyjjVUrv8DSxZgSS7WaNJb1aalARqQVCVdlx+ot/QkUOQEtORZ7uHVrSt5cnnUISsWE7qHpwfp70drd2KqNT3nktPp74n+RN1AktVGegLMYEmNaEWeQTZXcBQOjAdCFTsz7ugVfaRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776202763; c=relaxed/simple;
	bh=4DmhPHk1STnR3Zxdsne2/8cUaFJP8gPptbtYBh2R7ww=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=GdBTrrJTEX1F6X0fPJFrBirgSOxUQEeUNwfU2XLHz6zDQtxgqMooCueVVM7GFq1InwxaYbFn1oPsI4NWVr1uwVTrke+4dhFcodjsdEhYAy2L9sAzSRrU3Nox28ksuk/UmjAa8nXP0Ab8fIXr5Z7IfE+EMXVXNZa+tEuhVZU0Mhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8GtCqsT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d03db7f87so3781917f8f.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 14:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776202760; x=1776807560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4DmhPHk1STnR3Zxdsne2/8cUaFJP8gPptbtYBh2R7ww=;
        b=H8GtCqsT7jMIU3OA+ZrXPKxwsZZko2AvUrcM1SR5s9xhIvqdGgCo8A4C7Ap+7RuuuA
         xu7UmGG8SZNujmnnTJ9p9pHxO/qwumceL7josIDiZCMx5Naqb/rRY4DkF8jhh0WnMnTU
         bSN/xSgc2jYtD64O/aLX2nwt801oZsx0zZc4HDc1MZlLP1LTzSm8ijzMsvJum8LVvXc6
         QpJq9idBTfarOkuZASWNREkyn93SGVYqTYyiBlz0ix53rAuEblAiWptDT7gpw3tcN5vy
         VcvrKWV/YPHfVWh8/Ib6rJLCZhtfXNmrWQ1n1Yx8utunQl15nVeFbEbm51rGPOITMp5U
         kevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776202760; x=1776807560;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DmhPHk1STnR3Zxdsne2/8cUaFJP8gPptbtYBh2R7ww=;
        b=iZd7RcmGIpTdpcMWjRcXz2JZJX1ESD5AaZ5ChjsR7sONX6dLnA3WGaxXEWkEV2QU+8
         ux2n+5CrB8v0KVfVovW8h53HL4YxVd43DONfk/mAfqtjAwp4t2Aa0iFmXaRoH2jXVHQN
         g8KQiErsoFUsfFKIT08BarLHgkD3G4X0lM3LMQv1UjitgLljOlXOLSce9PBSyhb/cxt1
         rAxwoH3BFr/8657VukBFrRDK7uxJQpA6bDvWw54ylFkXcDDpx1UYqFoHyj99HqlT76GJ
         CuZ2Vwy7jEXJd5MPSAn7k8vdHUCPBcoxjMeO0hI22MxWxC7R6UfLJEGFJKvhHtNvqxcK
         qBWA==
X-Forwarded-Encrypted: i=1; AFNElJ/DKBsstV+lhSWoT4tQRAlBcV0yQGDExRKRte0p1/2vbZF+NoFSUNiqEei2op5k+QTXBJkSj6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeekYhQjEnVunEnL7Ee4tEkVLKhAMR8wpEDkBjhXrQHvsijQi5
	B3CBu6RwWBigHvQk9k2Tr+kTcktbwwDEp7WFYqUpZLi1sAGBoJV0KpMmYVZwPUALw//rAQ==
X-Gm-Gg: AeBDiet9E6gzzL+jS/+NVSOEgLbi5sq74GpeisaE1wzpwt3GpsC2dtgY5A6rqDhtq4y
	/gZUPx+Z/E2NV55GgKCXW04ZfpLpDuCSnIUa92JUDKPCbGxdckFIhJKVIhF+nUsEO3M/LW42DKR
	AYYctNnKBuf7waHIc9YxKZSWEMH6MGWATg2MVFaZmZLbDSe0AUpFZarriISLs+9SXkfqoXpKrC4
	zVwODSmRkB/ckN2YQSvxr6ytul9xySLfXEgd/tSPE1T0RpcYmWNvPN0jp9cDe2LTQ+PPS+s6iki
	cIlFbwRcfaTKZW13ITWApoVl5N6tE26ycuB9tQIk1tOuM1kWK2BFO533Rv/YjrTDSG2pnZGZS9V
	LHZmqYMgNlXnrEmSXg+IXIrN3ZLUbxoqmoHNwHAuvgoX8Ta2epl8u6HoGdHoPngINca1xeOgLYU
	MNq2toSoCBhUy27LaIOR2EpkElZn4FI6nLniaKnlHk
X-Received: by 2002:a05:6000:605:b0:43d:7c4e:1ff6 with SMTP id ffacd0b85a97d-43d7c4e20b8mr11296567f8f.1.1776202760086;
        Tue, 14 Apr 2026 14:39:20 -0700 (PDT)
Received: from ehlo.thunderbird.net ([86.1.69.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a53sm42970687f8f.5.2026.04.14.14.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 14:39:19 -0700 (PDT)
Date: Tue, 14 Apr 2026 22:39:20 +0100
From: Josh Law <joshlaw48@gmail.com>
To: broonie@kernel.org
CC: achill@achill.org, akpm@linux-foundation.org, conor@kernel.org,
 f.fainelli@gmail.com, gregkh@linuxfoundation.org, hargar@microsoft.com,
 jonathanh@nvidia.com, linux-kernel@vger.kernel.org, linux@roeck-us.net,
 lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev,
 pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com,
 stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
 torvalds@linux-foundation.org
Subject: Re: [PATCH 5.10 000/491] 5.10.253-rc1 review
In-Reply-To: <9564f562-df5e-42e9-a9e0-f0e605a6e441@sirena.org.uk>
Message-ID: <5278F4C4-45D7-457B-98BF-16ABFD334B9D@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,linuxfoundation.org,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-237974-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshlaw48@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2D133FEA26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

(Compiled and tested on my qemu arm and my qemu x86 machines, no dmesg
oddities or issues that should be acknowledged)

Take my

Tested-by: Josh Law <joshlaw48@gmail.com>

