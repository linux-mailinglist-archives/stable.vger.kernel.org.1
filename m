Return-Path: <stable+bounces-269260-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id epiYNFy9Pmr9KwkAu9opvQ
	(envelope-from <stable+bounces-269260-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:56:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 636036CF83C
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:56:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=laQTvovn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269260-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269260-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2E58303BB89
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9093A9601;
	Fri, 26 Jun 2026 17:55:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E88139E190;
	Fri, 26 Jun 2026 17:54:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496503; cv=none; b=Bm+u9dhqPCidHXFzLhiKpqhHG45nImeQbSiGu0g2RItd0juAWFVCQ4OFJ2f4UU87ExadzH0zyEwc588hYaWQ3mI73ShsZZxS1S2IpUdt/nHYUtJJbAOFpCv1zAmNURpGTJQHb5YJ0mORoRg7Ag4hTXnwYE7Z8juDjdMgxwsB4vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496503; c=relaxed/simple;
	bh=06d5uVBN2Ciy3rYnnQahGW8rFiLbpJJuftkDVFAmDio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOLrm2jnih/EoBT6S0dDwMShAKEEuMCTAuRW41WW6kIdRg+XKlTCVFU2HNRAc3qZ+g2jEFoThJGD9dLGxlCFvhMIyvH+W4jaxD/tngSQz3mk9yaFW4Ofd58STKJ3XG0CZTZkm0REXZv2Esrek3oQ69XqxknvG08rpfC0ZTqSwTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laQTvovn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E538D1F00AC4;
	Fri, 26 Jun 2026 17:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496498;
	bh=v9iG/7GG+ArpDv+swKv59Tccl8BIyxRTE8loiVLJmOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=laQTvovnboIetO+z02M7o4VfZOI9fjRNP79Mg7P0ML2zh3YalhtIXiHfnfRJrVTcY
	 bVlXHalsBnzN7m42xKFnPfeS86t5mkMvs46RLIFcABWkUxEfz3FA4jx3hMOka+1iD8
	 jEQ0CsBqmtuP/7PpMVlzqQNtji+JSMFvX5Ia8HxJIFUkLY7H7grnmYuXsQulkUbzgi
	 bHzjWvp/nqFh3BDEa5Wl6kNhXxjDaBWYrA9esl+L7760VVsq+BTVRRhpoIVjPhUdjU
	 SS/brNiukF0+K8PbWbaUck2NTIc4UP7M0QfmhqGANor7VFWOHuxiLI8oDl3kkUjDn6
	 IzgvkTIqJS2jA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
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
Subject: Re: [PATCH 6.1.y] KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level
Date: Fri, 26 Jun 2026 13:54:27 -0400
Message-ID: <stable-reply-item007-hugepage-61-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626112437.1777775-2-pbonzini@redhat.com>
References: <20260626112437.1777775-2-pbonzini@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269260-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:imv4bel@gmail.com,m:seanjc@google.com,m:dmatlack@google.com,m:jthoughton@google.com,m:bkov@amazon.com,m:fgriffo@amazon.co.uk,m:graf@amazon.de,m:dwmw@amazon.co.uk,m:sironi@amazon.de,m:iorlov@amazon.co.uk,m:pbonzini@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,amazon.com,amazon.co.uk,amazon.de,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 636036CF83C

> KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level

Queued for 6.1, thanks.

-- 
Thanks,
Sasha

