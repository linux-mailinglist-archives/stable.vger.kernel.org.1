Return-Path: <stable+bounces-267991-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8FxsMda+OmrMFggAu9opvQ
	(envelope-from <stable+bounces-267991-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 19:13:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 217116B8FB7
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 19:13:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fRIB09FM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267991-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267991-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A4573038F74
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 17:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98B4389115;
	Tue, 23 Jun 2026 17:13:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B575231B828;
	Tue, 23 Jun 2026 17:13:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782234832; cv=none; b=CCRT7pUvSWDK0Qu+2snluSqZh/RXdPNrbBIyhe7FHmKe/ZGPot8TjszBfHaHkVozVwaxr4ebD/+oKSFnEOZdwItF4K3jAfEiX3PYSyXSJukFBQOvJx1vnphE4SvTM3cWg7BoxcZx0sbqEXAMLrupSsp7cW6hZRrhvyZRg00oTqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782234832; c=relaxed/simple;
	bh=24ZQIJ3KPKzZKOkPk+LWogsiedxQVRh/THtjXZagFMU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fp52t74cDboMLbgHmfECpnFmSNayU3nQgiyZEWgBHmk7/Kd0pKbDkQIlqbb6wMR3pGZbj01dyniJZTJqdXWpQyYC06xsE81rC+6EUw9QgsirTbo26VMqQ1bHEOuYOr6MGlYbLzK1H0aSG/+pAnK6x69z6mnmvoygrp9ftJfZAKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRIB09FM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521681F000E9;
	Tue, 23 Jun 2026 17:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782234831;
	bh=vhreZ8yRUlN4RuI04jkE4d/50FEPa9YAIQ2hGcx7C0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fRIB09FMr23fglUg99yzZmvQGjsqXIcTsL9pV9EfZY4fdQuK/wGCz2xViKt1CBv4g
	 UXqG3AuMTyUAUfF+EZ9qP0H7ux0UIZ6w5MzcWzdOaq8VN+04DKHfFhiAnwNLfJ8bpQ
	 JDk8hL+aZ04dBgf1qrreK7cplFwW3lL6RDzu5rQiF8OU1UMk5t/1uU0YC3frUrsdSu
	 qcjl5J1jU/Sz3h4cRY02xIoKNbWAOBgvMJAjcUotklRxw6iM6n2Yw3eF05qFYkxovw
	 3QKkXN48M+UbciyCk8Vsbv0gBGR/aw1UN5H+uOam7WN7obLls4omm453U1/emu0VtL
	 A2UVRUPyStHmw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wc4h3-0000000FMp3-0wqe;
	Tue, 23 Jun 2026 17:13:49 +0000
Date: Tue, 23 Jun 2026 18:13:48 +0100
Message-ID: <86pl1hqiwj.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Bradley Morgan <include@grrlz.net>
Cc: Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev,
	Fuad Tabba <tabba@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Quentin Perret <qperret@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: arm64: skip pKVM cache flushes for non cacheable mappings
In-Reply-To: <5925B41F-0F57-4BCB-9F93-7600878ECA27@grrlz.net>
References: <20260623160339.15143-1-include@grrlz.net>
	<20260623163756.4591-1-include@grrlz.net>
	<86qzlxqjf3.wl-maz@kernel.org>
	<5925B41F-0F57-4BCB-9F93-7600878ECA27@grrlz.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: include@grrlz.net, oupton@kernel.org, kvmarm@lists.linux.dev, tabba@google.com, joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, qperret@google.com, vdonnefort@google.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267991-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[maz@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:include@grrlz.net,m:oupton@kernel.org,m:kvmarm@lists.linux.dev,m:tabba@google.com,m:joey.gouly@arm.com,m:seiden@linux.ibm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:qperret@google.com,m:vdonnefort@google.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maz@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 217116B8FB7

On Tue, 23 Jun 2026 18:04:07 +0100,
Bradley Morgan <include@grrlz.net> wrote:
> 
> I'll go and do V3 with another sashiko suggestion. I'll fix your path too.

Before you do that, please verify that whatever Sashiko spits out
makes any sense. I'm not convinced by its reply on v1 at all.

	M.

-- 
Without deviation from the norm, progress is not possible.

