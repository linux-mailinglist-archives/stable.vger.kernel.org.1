Return-Path: <stable+bounces-272796-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W08eArckT2qDbAIAu9opvQ
	(envelope-from <stable+bounces-272796-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 06:33:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA6E72C8F9
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 06:33:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mUZ9PTmk;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272796-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-272796-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D43C1300F448
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 04:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6592D394783;
	Thu,  9 Jul 2026 04:33:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A702701D9;
	Thu,  9 Jul 2026 04:33:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783571634; cv=none; b=bwKSitQRnlAcfn/VpXFaNtAUoXGslNDp3YcQwBGnYPlEUDuCRmLDXQzxIThWq91eFmJOdHncNdyXTcGVYGNHK3W/0ST/1nGDT0Ajk5jhyM2WBdmAUNdiPO0ci5x67GPruZWRAdPgbOatEZrf52r6njlw7TGkoQhsCtASToW/tN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783571634; c=relaxed/simple;
	bh=47wEBBUdo7gpuSZhKo7qmRxniKCLo2OUyGtItDb0vKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zrhee7QW/oM2YnR331yFIK4Mo//qr3QRAkXvh2HKLb3fFD2qPjGmcB7Nzf+MQ8cEVTiXUrdmioC2q/gFlTUXX5tZNCWLcjT95Pa4ZpdGw0Kihan9Lhgac5Hco7lTGX8qsFe1TThHERJtDLqAHoVVYj/Yg3Mc16h07sjDDFQqr0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUZ9PTmk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C611F000E9;
	Thu,  9 Jul 2026 04:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783571633;
	bh=w4vo2ZIFIR98NmV6byBtB02jCiXbmPKfL7h5SaaBlyw=;
	h=From:To:Cc:Subject:Date;
	b=mUZ9PTmkP+gxqTOiEooff1Jrs9ubinN957y9kkolL3ZLoC2PvHu0Yr6jgWBycx41t
	 y6rAFstWJMA7JCCzoCs57dKjQ5BmiYi9aBh9p9nqE1RDkn+V5rDVqIQeS1AaxNZbGC
	 bV7AtZNMcrNaGvb2sVB8nTzgQ0+gs0KQ36T7sWTJdUJQegJS2n1R0O0INrlQZojIB4
	 xtkjHHBpOAiYiWIKbU8N61a4OGhK2tWLp0lTRBtTMbnJcYbwQnOxOwvsVNcM8src0M
	 Qn0rQ8Oq+a17ELJmMp91Ie51apkrws47fd6XR4Cmj9+9Zb6aVarbOMghbsKGTX/lCp
	 XcnpMjkcUCLFQ==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.18 0/4] Backport the one-arg k*alloc_obj() APIs
Date: Thu,  9 Jul 2026 00:32:57 -0400
Message-ID: <20260709043301.142931-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:kees@kernel.org,m:ebiggers@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-272796-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BA6E72C8F9

Two of my recent commits failed to build when cherry-picked to 6.18
solely because of their use of kzalloc_obj(size).  The two-argument
kzalloc_obj(size, gfp) was already backported to 6.18, but not the
one-argument "overload".

It seems likely that this is a very common issue.  These are core kernel
APIs that almost everyone uses.

Thus, this series adds the single-argument version to 6.18, in a
backport-friendly way by omitting the flex counter support.

After this is applied, dd015b566d50 and 696c030e1e34 will be clean
cherry-picks, so please cherry-pick those afterwards.

Kees Cook (1):
  slab: Introduce kmalloc_flex() and family

Linus Torvalds (2):
  add default_gfp() helper macro and use it in the new *alloc_obj()
    helpers
  default_gfp(): avoid using the "newfangled" __VA_OPT__ trick

Randy Dunlap (1):
  slab: recognize @GFP parameter as optional in kernel-doc

 Documentation/process/deprecated.rst |  7 +++
 include/linux/gfp.h                  |  4 ++
 include/linux/slab.h                 | 78 +++++++++++++++++++++-------
 3 files changed, 71 insertions(+), 18 deletions(-)


base-commit: e46dc0adfe39724bcf52cea47b8f9c9aed86a394
-- 
2.55.0


