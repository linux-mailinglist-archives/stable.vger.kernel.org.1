Return-Path: <stable+bounces-260206-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JlgYLcy0IGrd6wAAu9opvQ
	(envelope-from <stable+bounces-260206-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 01:12:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A55E263BC9B
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 01:12:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DW5uNPvy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260206-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260206-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DAA0A30535F5
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 23:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB11357D1F;
	Wed,  3 Jun 2026 23:07:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCFC374E66;
	Wed,  3 Jun 2026 23:07:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528073; cv=none; b=fmE+0JzQCbj+N09zNPHcTJBYupm2aLzybxTEsDULnbPJafxbs4in+5J/WBRpj4MBd7y9dUYyIGeO2+yRbHdoe1PuaoJdkj8ZGeIKDmxkzNsN/LcclT7mnJoph/XZddx2rSJG6XBNC4Kq1SIQWWZCNwuoc/CCNP8Q/Y6oWGAlMZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528073; c=relaxed/simple;
	bh=3IKC4WfDBL7PuypJ/cK+RzIQJqFPQCs+k2glHaWyuMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kv2kQ8kUhgcDInr9sRNqgikT5QY9XNVjnjhWv0nIoWzHdYQKCZMDTdUwl58HcYLfFIrdgW+6hN2EuderIi5kS2IvT7H/yyUWTwAWHdyNzDvvak4zFxe+jSLVeRBopwHwz8S90ljZMk4BiIoTyNc09ep7k4EkwvnURprGfWYPa14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DW5uNPvy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1132E1F00893;
	Wed,  3 Jun 2026 23:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780528072;
	bh=63lWd/7ABwncvEN5kcTFLVuVMpSwlY9NkS59RGzcqao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DW5uNPvyZjZ3q6AmHxFScbM9FiVEry5AAQP4Fh4Ks3HzceTFm+/lg74OMFoPOI6vn
	 jDLWZWbwBdMspHtldQMuH0+/L0ToqXNHUxdD5XmNLG56KmR6t1V+fSAo5doTLW25re
	 3E8ucZhFVZqWJUe4IVHBBMf0ICkLw4qZq+y9pfl8bHICWw4fpC/nEwCxZa3WwB298h
	 AhoOWO+IzMCBXrXGhISsLOjtM2YW7cUWQme/XxVgLd5dD9S69u19o8188+kjeIwb9A
	 6pWuR8OeDQ8QrZYzLoe0D6RvJzRfYpL4CeeuEMuvnH0NRh/GyKIvurQbKVADzJSZTb
	 xdkqibzBjLoNA==
Date: Wed, 3 Jun 2026 16:07:50 -0700
From: Oliver Upton <oupton@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: maz@kernel.org, joey.gouly@arm.com, seiden@linux.ibm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] KVM: arm64: Take the SRCU lock for page table walks
 in fault injection and AT emulation
Message-ID: <aiCzxtzmx1BIw3RE@kernel.org>
References: <aiAZfdeyanIvP8SD@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiAZfdeyanIvP8SD@v4bel>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260206-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imv4bel@gmail.com,m:maz@kernel.org,m:joey.gouly@arm.com,m:seiden@linux.ibm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:kvmarm@lists.linux.dev,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[oupton@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oupton@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A55E263BC9B

On Wed, Jun 03, 2026 at 09:09:33PM +0900, Hyunwoo Kim wrote:
> walk_s1() and kvm_walk_nested_s2() expect to be called while holding
> kvm->srcu to guard against memslot changes. While this is generally
> the case, __kvm_at_s12() and __kvm_find_s1_desc_level() call into the
> respective walkers without taking kvm->srcu.
> 
> Fix by acquiring kvm->srcu prior to the table walk in both instances.
> 
> Cc: stable@vger.kernel.org
> Fixes: 50f77dc87f13 ("KVM: arm64: Populate level on S1PTW SEA injection")
> Fixes: be04cebf3e78 ("KVM: arm64: nv: Add emulation of AT S12E{0,1}{R,W}")
> Suggested-by: Oliver Upton <oupton@kernel.org>
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

Reviewed-by: Oliver Upton <oupton@kernel.org>

-- 
Thanks,
Oliver

