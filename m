Return-Path: <stable+bounces-269259-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2gJQFFG9Pmr3KwkAu9opvQ
	(envelope-from <stable+bounces-269259-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:56:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D4B6CF82B
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:56:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=o2HkXU21;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269259-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269259-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E409E30A3147
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1923C3A8739;
	Fri, 26 Jun 2026 17:55:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778743A8FE6;
	Fri, 26 Jun 2026 17:54:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496502; cv=none; b=PpnkQxSHJOPIJlJLbSd9gBa2RCfeCb5D686F1iUaWkKhokVZ3TboyGqeMjJK8GZRelCpXsoBtfxkxsiwz1vWWo01k1on20Sk740Vnhz7oRXdZNlHtEgU1Va57wJZUoTHuYFeUFSSk+CEhbWjWHQODcGHoviEnupufFa/j1C7pM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496502; c=relaxed/simple;
	bh=MnpS/bVXBKyjAr+56/eH12Nr5innNOyULYxUUW8t0S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KH/DamHT3Y/IpGiQxve+D05Y62oJLdW1yYjcyWuVNNQwrUxolS30DM4rScu4U5DrPsYh+6eoDYMoMAdh09/m1hKFsXrUd9+joA9aAD47AlFvrYfE9B1jBJurVKDVLSbARwMzJ3HwLQfG2PTnBju1pBpuZIq87Yy9HTqalguw6vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2HkXU21; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D5D1F00A3D;
	Fri, 26 Jun 2026 17:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496492;
	bh=U+4P1nBtf+U+p+vNNa4iD1dzidAYl06kWF+nNUwkJ2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o2HkXU21KYcZmgUY3217b2WQWuSzrG5vcHtxKLcZ/VXx7l1/T1khTj/NeHPYDw1Kt
	 yHZjIa4gx/cRDeligMy4sc51Vck873KgdpTBOTaMeguCu8sbAfKBAq2v0RKSUkEF3N
	 F0q0yet648qJFH6Pmcq9lzxYNvQa1MvLecL0bhFmjrAMsF5LBDE0Bn12aFvV0LpHw3
	 7PFS+muYtoEhBAwck9uAhYkfMYHQyY/oJ2GrS0FrQzpNtDZ8y1HMMfrFZQthdxs2/x
	 +iCcRp/L1xdoGTidMvp7lLcB2ObDdU0eqfHL9NLu182LTO8XhrtvQwPQgWtB/sA0ar
	 vyfSkfVSCTmqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.6.y] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 13:54:23 -0400
Message-ID: <stable-reply-item006-role-66-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626112425.1777712-1-pbonzini@redhat.com>
References: <20260626112425.1777712-1-pbonzini@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-269259-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:imv4bel@gmail.com,m:pbonzini@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7D4B6CF82B

> KVM: x86: Fix shadow paging use-after-free due to unexpected role

Queued for 6.6, thanks.

-- 
Thanks,
Sasha

