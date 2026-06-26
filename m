Return-Path: <stable+bounces-269263-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +f0LOtW9PmogLAkAu9opvQ
	(envelope-from <stable+bounces-269263-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:58:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6415E6CF8A4
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:58:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EXsICJXM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269263-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269263-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 614D63114CCF
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF613AB28E;
	Fri, 26 Jun 2026 17:55:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9473A7F66;
	Fri, 26 Jun 2026 17:54:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496503; cv=none; b=WHFoUYU6IaKcVWxBEV/Ctyd3Ybc4AjSONKVieFX1cAfbeKdyHIbyMqgaDV/EsT7L3lG83xTKYsmiY7BlvGMa822nADMCypWdZqcKUVEq76amZHxwcv0km1ZkFJxjXNtFQDZO1YgDZKL/W+cF7RQkz7PHQYSjFtuMlN+37Ds4iS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496503; c=relaxed/simple;
	bh=LuJz7qmlTF1YJ2xgiYxnz5Dv/hWesqiDlDVM2K3h6HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvAJ22WqpFaw6/g73z2LYxMjOcHkJPPaIH6IwFuqdeahH+lNbzWF1wnYXkqQItVpahAqUotUE2pQQcQynZw4IKo/0dDaKZEFIAvltf3RGo5dfxiZseDWeqPUlsy5iHP0puNTKB+BOealbgQpz+ayliyA3DJT9rr4CtqUAW81mAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXsICJXM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744951F00A3A;
	Fri, 26 Jun 2026 17:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496494;
	bh=kCQGmQCiPt8POPSO8VVlYjKlurk3/QBY1u2pmsWTY7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EXsICJXMMFRJOyh2ft348yKY5OlcxsssI2rseOwWYc1CCL2kNtttih/e8/uFl3U9h
	 zk/xfD/T/noozZZFD6CjLmTJWI7yln1etnM70i8E4DR/bDWscPUkVGXPVJUGGpD6uH
	 WpGLKC4pZKkvDJa1mvGiX9u/6vZZXhaUPOcQXHLLvdJ95RKRrvEwXJlKyiK4L5x/T2
	 N/COqrGnXjGsBwaaJ88d266TBEasN3x6pCetQKNe0VOKkc8yIblsj/kHVnJiMRenls
	 1vI5dkddOTpSHrjPtFmMAWF3aICPJ7ESlSokR1YTlu9+2MZcnqapLYHr8eIK/L05xD
	 xn4lbTGdoc9RA==
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
Subject: Re: [PATCH 6.12.y] KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level
Date: Fri, 26 Jun 2026 13:54:25 -0400
Message-ID: <stable-reply-item007-hugepage-612-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626112405.1777340-2-pbonzini@redhat.com>
References: <20260626112405.1777340-2-pbonzini@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269263-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:imv4bel@gmail.com,m:seanjc@google.com,m:dmatlack@google.com,m:jthoughton@google.com,m:bkov@amazon.com,m:fgriffo@amazon.co.uk,m:graf@amazon.de,m:dwmw@amazon.co.uk,m:sironi@amazon.de,m:iorlov@amazon.co.uk,m:pbonzini@redhat.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6415E6CF8A4

> KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level

Queued for 6.12, thanks.

-- 
Thanks,
Sasha

