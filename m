Return-Path: <stable+bounces-272325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YDpFHwEfTGpZggEAu9opvQ
	(envelope-from <stable+bounces-272325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 23:32:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FBC715BCF
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 23:32:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=YMo8rtQk;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272325-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272325-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAC0330254CF
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 21:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC72942E8F8;
	Mon,  6 Jul 2026 21:32:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569EC3BE178
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 21:32:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783373566; cv=none; b=OLLFXhA/jcP2ZhwrAwmwneAW7N2J3nNYvoYastm/vDwNNW9404kvLA412gCtlwXNIE5+BOij+COF8pOrGD6BSwkfQHDV1Gbw2/AK0x/JSGgvr0Munj2DmDkBu3/JbzAVwwgt6TSRxTDAk8w5fHrqNenfVOYzGa7E504d5JbOCkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783373566; c=relaxed/simple;
	bh=5kGN5o/zEXQARF41Fe2bQKp8S/R/99G74XpkHYXo/DQ=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=rYErNo/mbBRELZGoQMNXjmlcPLJJGYG0K1IiEiWFTKUBSIy2u+Oe34n5fB7ypQSz/Ox1UD+aUh3o6Qj3R9QQcEev86FrDNprkhicDw1rlRi5TNvewnXZok8lQ/Dgg3R59iDaUV8gtTHzP+aGpX4g1TeT+HxsIaWGW1XRF4fnYa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMo8rtQk; arc=none smtp.client-ip=209.85.167.201
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-495b8120909so4203220b6e.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 14:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783373564; x=1783978364; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5kGN5o/zEXQARF41Fe2bQKp8S/R/99G74XpkHYXo/DQ=;
        b=YMo8rtQkizIwz6F0p8PsSfV4nRGHz7BGtx3TrW4I5c/2K3DhZ8ROKeksOnrS/7GCHp
         07ryGMRaYX9KOFd2KSNN6lr1229lxyqQdX513PbFCUVrLoYoYbz0iZehiY/a9yl7LprI
         HRPdn30wrCZNVvDmI/ZdlCn5zR7tf20CWC/jUIhNq1R7mbvOUgx4N6daHSJdieE857mC
         y/NzN+RyPyI7QkSXLgjemORPlqIA7OH+DScSDLaQSbB+4tJyKck+L3Cpz8czbIh++LMZ
         qNvQKPYqAEO7WmkS9nzpsehV90B8vTDF9+tovI56s0GtC3tu12qC3apVjTCR4m5eDfqt
         cNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783373564; x=1783978364;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5kGN5o/zEXQARF41Fe2bQKp8S/R/99G74XpkHYXo/DQ=;
        b=LODTU8vbW3pNul/NwXPM/OdajW7cm46lRNKYzRnbapnFi91RSzxEvX8TtPFQaUMY/g
         EGHvr8ohLLCrikf9xW5lTK5dQQhXcKXOfO22DUVL+i2oI0NchQLKUmIQ182A36esaYBz
         qomAJ07mzX7oHqI98cOUgdK4rC1Ks3C/h+HXpxOMCWRoMs17n4OvWxGw4T0uKBDoqtlm
         CjaKisWPFMhfHr5X9YdNqyOO0ymsxOXm5fuxeGOyor5dHwwwYhLOq1SvtBmmZDW7qO1A
         ddED73xClCsmUqXDqqwlRBy17twzBMgufROXcDkmacFfD4PIFRvUTIu1LUsnHL+sGZxG
         wgXQ==
X-Gm-Message-State: AOJu0YwNxs4P4v5QbJgYTPE3YKYa4vZvz4TLWoW3uj9REyKLIMko1jsj
	VImd1Wo30ntpQU8s08/Q9VXQ5ByFNpt/BMb5Rq/vcBQ3jDStN4InTQ+RNAet5V3PZrXojeRWkhv
	VriorZEkeZdUVzj9GbD+Ip//eKQ==
X-Received: from ilb17-n2.prod.google.com ([2002:a05:6e02:5311:20b0:503:5897:39ce])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4fea:b0:497:da7f:179e with SMTP id 5614622812f47-49fde9fed6amr1716488b6e.38.1783373564250;
 Mon, 06 Jul 2026 14:32:44 -0700 (PDT)
Date: Mon, 06 Jul 2026 21:32:43 +0000
In-Reply-To: <stable-reply-arm64-vhe-66-20260701193800@kernel.org> (message
 from Sasha Levin on Wed,  1 Jul 2026 20:38:35 -0400)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntmrw36byc.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 0/5] Backport ARM64 VHE boot fixes to 6.6.y
From: Colton Lewis <coltonlewis@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, sashal@kernel.org, catalin.marinas@arm.com, 
	will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, mizhang@google.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:stable@vger.kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:maz@kernel.org,m:oliver.upton@linux.dev,m:james.morse@arm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:mizhang@google.com,m:linux-arm-kernel@lists.infradead.org,m:kvmarm@lists.linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[coltonlewis@google.com,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-272325-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coltonlewis@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,coltonlewis-kvm.c.googlers.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3FBC715BCF

Hi Sasha, thanks for reviewing.

Sasha Levin <sashal@kernel.org> writes:

>> This series backports VHE CPU boot fixes to the 6.6.y stable branch.

>> These fixes are already present in the 6.12.y stable branch (and
>> newer), but are missing in 6.6.y. They are required to enable booting
>> L1 guests with nested virtualization enabled (kvm-arm.mode=nested).

> Ugh, yes, the sha1s don't make sense.

> While respinning, please also consider whether upstream 3855a7b91d42
> ("KVM: arm64: Initialize SCTLR_EL1 in __kvm_hyp_init_cpu()") should
> join the series.

That's a small commit so it shouldn't be any trouble to add it.


> --
> Thanks,
> Sasha

