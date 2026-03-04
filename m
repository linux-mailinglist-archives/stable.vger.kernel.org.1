Return-Path: <stable+bounces-223075-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHsBBCs7qGkTqgAAu9opvQ
	(envelope-from <stable+bounces-223075-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 15:01:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7716A200E2A
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 15:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F092F302D0B7
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 14:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FAB15E5DC;
	Wed,  4 Mar 2026 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="H9xgPrAE"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A4374E65
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632850; cv=none; b=Fr5rVv4N+h13aqs0alKoXu2Dki+1BXIYMz7PStp4f9n1DC1xoW52hFtA72AktOawEzF9Xdo+NLv7oTFiStohcVJNxxU2pf76iG7k0+Exi17ounSr2sMzvFhHOCzdY8fzFHRqf4PTYVPM90B1/89Qenjb0yu3EcMA3xrBoH1Cikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632850; c=relaxed/simple;
	bh=xyguKu7z//BY77YKs22nfEGGVpXcuyaqKE5Yw58xiZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgaWq3HCGvRYYzilk55h3s6q9i01+2ZFnGzduCYukI85NsN4Efa4ENgVRY4I8n8AfOXElaZbq6evVjj8TgrMYzQVboopQiL/kFodxkKwx+77ox+LRg0peBmoar3jiLkcNUO2fCl57SAcv8KbOiF+6m9XSG2vzFGeR9q4xgzYFiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=H9xgPrAE; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4138136f02eso1601500fac.2
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 06:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772632848; x=1773237648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H//S5xtNAR1QEi+Xm0qsXdAi1/1nJ7dHJA1UBRTwpc0=;
        b=H9xgPrAEBQcKqXKOd2XubrU5V3vJ65VdEOPHrnieeLhcwtResMMZVEyv406g243LVM
         I5OfyjJ/j1dPpMvyT2NRlJEb8Po+a4/OGwxl3ZZXxoTlE+DkELYrp8Ckii9UbgXat7vf
         iWklxSTX5niipcwbYwa9ZQbpDVUt54uj3X5Iy/WWZ985gtinD83fRapS6BIPTZnBEDBi
         f8bUXO8AFc+Qg1NM2H8P0lW3hhErbjpBgAc5yfbC5B38QAOULuF57+kL2l07zFbPjj4R
         VvnTbWm9JuYhO++e25uwhrXNw+eN0XbEDQbiqZGyf5Q0O/pl6tAdAGe5Fp4PjHUjDkjL
         IEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772632848; x=1773237648;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H//S5xtNAR1QEi+Xm0qsXdAi1/1nJ7dHJA1UBRTwpc0=;
        b=Fr6/8KvEBUhQQpbP6e3NF4ckGbECBFsOhVpKEGZlhNzHnE2yGWEs1OSjAlhjaD3SUy
         WPmCElgl7HdfWhqYIs4cwMeyFgNkNrQQ+UYhFrUfCsz+NbHrEzZvnaN9F0U3R0feEq4f
         6GWKf48/qttRkPmPlD+yYb1O553te9Gb8IKtmnUNyPuK/5GKQ0xxA3U2jNsrKbR4PS3m
         7sAFImSK7/VkeeWLqBSeAKmvKJ7qFDTeQ8mC8ZoNiqzb+OoVc+JgUc8D0Mru6d7QB60P
         kuq2YFLlI0Nt7Eev6IwTEA/knyWvfKsScRS1Ia3C27mIc7wRoIuUgCt/VeP8hC1FU6uA
         otEQ==
X-Gm-Message-State: AOJu0YyuR+D4Tjc1gqjXW9JMggXr+OptJpAXmiYDWkbNcgwxJouFDFLY
	BtJLSkO+mHg5Vr0uK3Yi4wb8twHKLeaRiY4AOUYyiiBdzvxLFEJkMupSB2mKuSq322s=
X-Gm-Gg: ATEYQzw/aKxw84rPhCEqCiK/B+Wwe0jSyco9GOGqGuyIFWwpeBE0HLqjlW9Uvzi2Nk8
	uGHNAQIg5B4IZZSO3oJLWRpj+CoathhM4vgGKcvPaO2pfa6eQw8mSjL8eitMKDrRuDy+W7AcstE
	cZpD0gIlmjgfXFW5EVdgXN3arwk9FRPVgjfvq/gbCLJbPjudQHDO0srEVri2eGbcuBu+FVZoP9x
	9mpJt2j44QnPvUa6BrewMYoFnpkyyFGxcMttJmOw5DiOTPrtSqeo8WnxzA0lr4wJWNpmTTassK/
	SkzVZKTnx0rh+MgAtyAuLOhlr4RI30oP2ME1gLdvk9WoaCKkDzPiKVM7wwcPuyZ3tkrkkTV5LQE
	hRYe06+HvEYR0dl7mszNAYe3VumEVJC8ZHPiJd9AKjZF+SMiw90hMgh4kerWEuIkT3NgDUHhryn
	TwjAT8gAkFlYRzgj0oVI3ccR+C36+KrO4nr1LYKIK7K3uOup+t4enNCCm+ueVRlW8E/WD2Wlejo
	uJ/EQZ33z2i/97/Kyf6
X-Received: by 2002:a05:6870:16f5:b0:3ec:52d4:bd49 with SMTP id 586e51a60fabf-416abb9ade9mr1060083fac.48.1772632847670;
        Wed, 04 Mar 2026 06:00:47 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d277316sm17536922fac.17.2026.03.04.06.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 06:00:47 -0800 (PST)
Message-ID: <ff161a14-85e3-46c8-93ac-091f84e23807@kernel.dk>
Date: Wed, 4 Mar 2026 07:00:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Reporting a Linux Kernel Vulnerability and Requesting a CVE ID
To: =?UTF-8?B?5YiY5Lyv56a5?= <liuboyu2024@iscas.ac.cn>, security@kernel.org
Cc: stable@vger.kernel.org, regressions@lists.linux.dev
References: <7002e9a4.4e95f.19cb7fe6fb7.Coremail.liuboyu2024@iscas.ac.cn>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <7002e9a4.4e95f.19cb7fe6fb7.Coremail.liuboyu2024@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7716A200E2A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-223075-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kernel.dk:mid]
X-Rspamd-Action: no action

Hi,

Does this still reproduce in current -git? 6.12 is quite old. If it
does, send the report to linux-block@vger.kernel.org. You need to be
root to hit any of this, there's no security vulnerability here.

-- 
Jens Axboe

