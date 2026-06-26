Return-Path: <stable+bounces-269268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aMcYOOS9PmonLAkAu9opvQ
	(envelope-from <stable+bounces-269268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:59:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8937F6CF8B9
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:59:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NMhjP2IM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269268-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269268-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35015305FB31
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A4A3AFD10;
	Fri, 26 Jun 2026 17:55:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B1C3AE6E2;
	Fri, 26 Jun 2026 17:55:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496509; cv=none; b=JEa6VpUuWTF6B/6IYp664GF/2bKeIq+K7wsddd6Uu5MpN8BZacJJJnn7Iw16eZAsb9a0l65V3By1j2QufgfUkKvBMhL+HPqWH23N7NCBZMzk7MhNkkZVkuoomc0Owp7T4e+C0AWPB7GDdr/+zomeQvu6vpVJQw5dIPugDFa9iWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496509; c=relaxed/simple;
	bh=6wKDU8kni+D8gUhr0PCGpJlV7eGVnjMqrAGLV42zaLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnARjhBk7Rdu8bNLJS9k0hJ4LyWVoIbMZbY/YTgxD8wVKzd/CI3HxHb2EPFBTS/yWuZ/lJI1TFDuzyj63xN5IblAuQrqUlPKnl7iRmUVVIhnlbwEVfS4pD1yMKeABCpwatSTAWKSUKxn9+md6RHX9s31nyotKuB37Ov4YXiJdbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMhjP2IM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A271F00A3A;
	Fri, 26 Jun 2026 17:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496506;
	bh=utEY7dFJCHv4+42jYfaqUfCjumDWcSH8XwSXFZdUCrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NMhjP2IMzQcegqX8LP490RlHbBBBDJeTeHUQnyMWl/7Kvwy4WWFoSuk1CoQPrfv6n
	 jd2mtEE7zfSIwOgugnIlJvVo5BVDP2ZrdNhCkyWpRvDH5DNNLy1ZFjiJV8Qw8ctg9y
	 yGAyrDR1LkrwTQDQGBcWQb47X5mjGcU2JGLivnL83Z6NjF1ma2LQ5iKwRGLNvXhSOS
	 SJz2xrtMyseU63OQxvfyQ3KTAHwsVaDWHlzColLXrpF9CiXVZ8nXf8bhzyyhrjzo/e
	 1Hyd/Hr3Smayhntxxeo2lvzCKmFmw4JMARfnSt/AkewLylNazjg6cIIDkzIYY7OU0L
	 mJ7xlwZN0Bm8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	David Matlack <dmatlack@google.com>,
	James Houghton <jthoughton@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	Alexander Graf <graf@amazon.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Filippo Sironi <sironi@amazon.de>,
	Ivan Orlov <iorlov@amazon.co.uk>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5.15.y 8/8] KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level
Date: Fri, 26 Jun 2026 13:54:32 -0400
Message-ID: <stable-reply-item008-kvm-515-respfn-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626112606.1778248-9-pbonzini@redhat.com>
References: <20260626112606.1778248-9-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:seanjc@google.com,m:dmatlack@google.com,m:jthoughton@google.com,m:bkov@amazon.com,m:fgriffo@amazon.co.uk,m:graf@amazon.de,m:dwmw@amazon.co.uk,m:sironi@amazon.de,m:iorlov@amazon.co.uk,m:pbonzini@redhat.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269268-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8937F6CF8B9

>  -	if (sp->role.direct && !kvm_is_reserved_pfn(pfn) &&
>  +	if (sp->role.direct && is_gfn_in_memslot(slot, sp->gfn) &&

This drops the !kvm_is_reserved_pfn(pfn) guard instead of adding
is_gfn_in_memslot() alongside it. I think upstream could drop it only because
a8ac499bb6ab ("KVM: x86/mmu: Don't require refcounted "struct page" to create
huge SPTEs") rewrote host_pfn_mapping_level() to stop touching the struct page
but that commit isn't in 5.15. Does it make sense?

-- 
Thanks,
Sasha

