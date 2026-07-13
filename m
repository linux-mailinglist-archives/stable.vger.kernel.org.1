Return-Path: <stable+bounces-274027-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tu1CNLlhVWr8ngAAu9opvQ
	(envelope-from <stable+bounces-274027-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 00:07:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDF474F6EF
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 00:07:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=hwboR2Gg;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274027-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274027-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59E05303A8FE
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 22:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A031385D6C;
	Mon, 13 Jul 2026 22:07:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B79241C8C
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 22:07:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980467; cv=none; b=gEvgIIsXv2wDa9ALIJ7HBBayoz+DOZqPX2TilyLnkgQBcLYQLoDNQjWOYiWSSLoaw7HWX/UI0zqKQw+Au689I6odH5JpMVycKdCm9hrVN3lLxMMsgxWmBluVyrSGB5gwnbJ9uUOd1RJtt9VkbiswbNnNAXdgUWedwqQXHx2N/V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980467; c=relaxed/simple;
	bh=AgQUtZk4JxfdrpCudYTTgIHshbNR5GKJ4Xji7gE8h5g=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=FreKUwm1Xdk41a7sOM+uDplf8hDUskVcrKQ+I5CFoqBAmdBsA6QrTb0N3PEWxs8zcNUiLIP94A7u3OAbCpBdBwFobWuSdMgLEyC8zEWrZhlZJIoUgS9Iqz0Uj6zFFkk9oPY4LrOLnjRjRmgC3CcoiEjHkF8APd872uAIIhRZsb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hwboR2Gg; arc=none smtp.client-ip=209.85.167.201
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-49aa4525b82so5272230b6e.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 15:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783980464; x=1784585264; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AgQUtZk4JxfdrpCudYTTgIHshbNR5GKJ4Xji7gE8h5g=;
        b=hwboR2GgHeNzIx1CJ/tie4OKtHneiq7J5PcN6r8WtlI573CVLpOLioWaarl80V23aq
         o4mkIAuTmoSq6yU0Pgx+/iDanojiOOs4ApbM8Q4+V+4soZSz023aNg7VylMzaMSn2bL0
         r861iiIRgC8PttsISlpI1pGoXJzaZjEqGveZkfICr3b+F7u8p9h+iDQ565qgi5sSqEe1
         XxAYJKNLsntInYEp8whkalqMCadUIqq8RzlrS0lJtIccmADZfWfoomqbF6lUZ35pg+Sr
         kMrc9Es86ZVvzw+I+lz561E9cy2Gtfsaz+/BU4cI/7KJxxilHuwwVFSu5ar/7Y1Ng6wg
         Ug4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783980464; x=1784585264;
        h=content-type:cc:to:from:subject:message-id:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AgQUtZk4JxfdrpCudYTTgIHshbNR5GKJ4Xji7gE8h5g=;
        b=kiPwHkd920DUh5jbvgBbB8dFdGpf/KYpuR2dTz6fpDsLwwaEiB+ATEPLcEOt02jDhy
         iiWXBStP42QLnhBxeLuhI7atlxqALd95u/oXnfzT87uO9YTeCyYliyQwoGEasTdxFP6q
         wMufP6fSylkO1+xyNkK9R5Ciggn8Sw7z/4bBSUKaHPKn02XN3CklJP6b8eCHYi/uwaBo
         qW2mv5Qe+lEy8f5fKb990cYIrRjKxtnSpsc05wVH/IQobGfNvW7D8vA/2DivSJ7I4Noi
         sr7Ox5sxLuj1txpdld03h3j2GuQsHg/lRfNSud3UqYpZuxYQ4MmfFgaJCLYGXF3EZj6z
         1mZg==
X-Gm-Message-State: AOJu0YyD5c6IYyPss/KpfkwQgK7WOuCoJX/Tv2l58qUFWgpHPIHY1rmi
	uwubi7eGSKMgp7ARe8OTGnmzj1Ual/led2JuxEQHo6ucqY6u2ZS9xjswMMqh8elitgyATLKonWW
	nDW7AIxEUI8pQpWOhTv9O57s7og==
X-Received: from ilzz15.prod.google.com ([2002:a05:6e02:320f:b0:503:50d1:28d])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:150e:b0:489:9e32:16f7 with SMTP id 5614622812f47-4a42afc9e89mr7832478b6e.39.1783980464501;
 Mon, 13 Jul 2026 15:07:44 -0700 (PDT)
Date: Mon, 13 Jul 2026 22:07:43 +0000
In-Reply-To: <20260710163023.agent5-0004@kernel.org> (message from Sasha Levin
 on Fri, 10 Jul 2026 17:03:00 -0400)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnth5m25ys0.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 6.6 v3 0/6] arm64: KVM: Backport VHE-only boot fixes
From: Colton Lewis <coltonlewis@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, sashal@kernel.org, oliver.upton@linux.dev, 
	gregkh@linuxfoundation.org, mizhang@google.com, catalin.marinas@arm.com, 
	will@kernel.org, maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, mark.rutland@arm.com, ahmed.genidi@arm.com, 
	leo.yan@arm.com, miguel.luis@oracle.com, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[coltonlewis@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:stable@vger.kernel.org,m:oliver.upton@linux.dev,m:gregkh@linuxfoundation.org,m:mizhang@google.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:maz@kernel.org,m:james.morse@arm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:mark.rutland@arm.com,m:ahmed.genidi@arm.com,m:leo.yan@arm.com,m:miguel.luis@oracle.com,m:kvmarm@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274027-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,coltonlewis-kvm.c.googlers.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1EDF474F6EF

Sasha Levin <sashal@kernel.org> writes:

> On Thu, Jul 09, 2026 at 10:35:57PM +0000, Colton Lewis wrote:
>> Architectural updates retroactively made FEAT_E2H0 optional, meaning
>> hardware can implement FEAT_VHE without FEAT_E2H0. On such CPUs,
>> HCR_EL2.E2H can reset to an unknown state and must be initialized early
>> so later code can reliably detect whether E2H mode is active.

>> Without these fixes, booting 6.6.y as a guest under KVM nested
>> virtualization will hang at boot.

> Queued the series for 6.6, thanks. I also picked up the follow-up
> "arm64: sysreg: Correct sign definitions for EIESB and DoubleLock"
> on top.

Thank you Sasha

