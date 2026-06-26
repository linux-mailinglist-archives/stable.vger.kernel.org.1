Return-Path: <stable+bounces-269255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zxdKCxS9PmroKwkAu9opvQ
	(envelope-from <stable+bounces-269255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:55:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1B86CF7FD
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:55:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZWNZWhjL;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269255-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269255-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 592983042E5E
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE20D3A7F4C;
	Fri, 26 Jun 2026 17:54:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCCF2C11E6;
	Fri, 26 Jun 2026 17:54:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496489; cv=none; b=aMMJbjVvfz+wQXMgQqLhQ8ttm8SW+Y24GN1YL9kCTCNv1Hms8FMs4Zn7F6TCidSdXoOgIN8Tb4wXB2H+ZL6gztl0hbd0uf4dE0IMRp4NEJy1igpUaUoyFJhTyjJvFIeVtHrcHaA6cprD7Ytbu6AczUW1ZIC9PRZLQTLYwpR8Irs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496489; c=relaxed/simple;
	bh=fWY1L5E33ij1sq5JxjvtTVeurGVe+ZpJw13KZ4lYOPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=topr5nhFFaAacGBVcp+wOyWwO820KoluRVg/ifk5Xx4YQ4TnvIX7aewIo5Fur0Lbfm0TnW8fLwnz64cf37WRcGRopNk67k+Qa6ND8r1MUjsT7tOKfGOaZX5NQD1q4jOMqd3qfL2LnxVBz+JRhQzHRbKxoF/VC0nZd1GA1+JJwwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWNZWhjL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946DA1F000E9;
	Fri, 26 Jun 2026 17:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496488;
	bh=naDAuYqy4XkbKqdknCBSlvNc82h32BG2nbEtcBo1JHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZWNZWhjLqtskbLn6Tj8yNTc1CeGzMRI9L3yF80ILe3/h1mwx+nvXxMqAGvPCazInP
	 mqtl2h8V+SyJs2H3x0oCoLPD6SfkgiAmya+LikXadEEgcgFSpmZU9ymLos+EBPyyIe
	 JQc+2kLKpzrVIR1dgajdemDs00hLoFXyhPtekn7pY8+VjkfhFRbgQLC4f5v3/pI4W2
	 zZSuCL9UKLV/0lKxzYdSghjfdW9u27idU0orvfy7Zm1ws8GH/94Gw3282N15W55w9X
	 KB83vOp7/woOcFB1QS71bzU26bQnqPN/r2eYvybzrz9/9PNBwySkaUKvOKjJtpJ+Pg
	 +32r5EFs7Evug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 7.1.y] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 13:54:19 -0400
Message-ID: <stable-reply-item006-role-71-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626112232.1776865-1-pbonzini@redhat.com>
References: <20260626112232.1776865-1-pbonzini@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-269255-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC1B86CF7FD

> KVM: x86: Fix shadow paging use-after-free due to unexpected role

Queued for 7.1, thanks.

-- 
Thanks,
Sasha

