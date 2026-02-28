Return-Path: <stable+bounces-220805-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M3jGjFYo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220805-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:03:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9000B1C8BD8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1673334A08B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8EA410791;
	Sat, 28 Feb 2026 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mgx4akoK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38C4410786;
	Sat, 28 Feb 2026 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300690; cv=none; b=lLuU5W58mu9/Tq06rs0g6/8f9Jl2TaCnzLYf8sJKzYjFOUCm0C9VTLG1UDvlnZzbnH0dxeSkj4lWceyOgIO+e1N7lMxiK21qMHZslUXVy0T+vtzm8wd6yjgLFxg0NS1dzXrsJ6GmraIgTocENLNouD2J3fwyBH4QdXG5HMObkBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300690; c=relaxed/simple;
	bh=GJIHd4BqxosNssM6wtIsh7cuiuhdr2Ql99CV3MDksGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffMLoeSgGgXmr1uggfvhcDt34fTgBmRrT2jIp/3aC01ZVeMWu7TF0hENcn+MsbGZ1QKMqSQwx8eXWchszFw5A+fyR6Vp+8Dbi/lCVIpFTaHHxwYbOS37RLleB7/PsuP4ExDhokseFTLRDIwPtFS/F8h8YE0j/SqRRtaYKVGGSMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mgx4akoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B29C19423;
	Sat, 28 Feb 2026 17:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300690;
	bh=GJIHd4BqxosNssM6wtIsh7cuiuhdr2Ql99CV3MDksGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mgx4akoKyo7KHn7PHbOVTvg1nd0Ybyb9129sySv/zeLbjeAnFWpQqSdE9C33AWGY0
	 7zAsv0Wh1UroxjERacvjb5KO9asg6zMc2CM4/mpP0kyftojVuIQ1yFbVxnSFodWTuy
	 MX94zjjs4rVZFIIBu1jlUcAYMRGvhNmfuj+e+ujycNGl4+uHz+abOH8lfoCGX7wA7u
	 jvweyMZny/nZGg1TCA5vymNgzZF86LcTIF5SBlqigNB4la8RusghjBQlMFATlDqUQW
	 0rlduwQTE8T2oI8OuNxyaOV4fFPlUSQAoRhLP0HfbgiBvoU6jN/2xu0kNEy2k07IlA
	 ZUTdXj8+GPZbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marco Elver <elver@google.com>,
	Boqun Feng <boqun@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 726/844] arm64: Fix non-atomic __READ_ONCE() with CONFIG_LTO=y
Date: Sat, 28 Feb 2026 12:30:39 -0500
Message-ID: <20260228173244.1509663-727-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220805-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9000B1C8BD8
X-Rspamd-Action: no action

From: Marco Elver <elver@google.com>

[ Upstream commit bb0c99e08ab9aa6d04b40cb63c72db9950d51749 ]

The implementation of __READ_ONCE() under CONFIG_LTO=y incorrectly
qualified the fallback "once" access for types larger than 8 bytes,
which are not atomic but should still happen "once" and suppress common
compiler optimizations.

The cast `volatile typeof(__x)` applied the volatile qualifier to the
pointer type itself rather than the pointee. This created a volatile
pointer to a non-volatile type, which violated __READ_ONCE() semantics.

Fix this by casting to `volatile typeof(*__x) *`.

With a defconfig + LTO + debug options build, we see the following
functions to be affected:

	xen_manage_runstate_time (884 -> 944 bytes)
	xen_steal_clock (248 -> 340 bytes)
	  ^-- use __READ_ONCE() to load vcpu_runstate_info structs

Fixes: e35123d83ee3 ("arm64: lto: Strengthen READ_ONCE() to acquire when CONFIG_LTO=y")
Cc: stable@vger.kernel.org
Reviewed-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
Tested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/rwonce.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/rwonce.h b/arch/arm64/include/asm/rwonce.h
index 78beceec10cda..fc0fb42b0b641 100644
--- a/arch/arm64/include/asm/rwonce.h
+++ b/arch/arm64/include/asm/rwonce.h
@@ -58,7 +58,7 @@
 	default:							\
 		atomic = 0;						\
 	}								\
-	atomic ? (typeof(*__x))__u.__val : (*(volatile typeof(__x))__x);\
+	atomic ? (typeof(*__x))__u.__val : (*(volatile typeof(*__x) *)__x);\
 })
 
 #endif	/* !BUILD_VDSO */
-- 
2.51.0


