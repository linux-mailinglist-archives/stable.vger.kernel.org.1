Return-Path: <stable+bounces-259254-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEyFOPcxG2qkAAkAu9opvQ
	(envelope-from <stable+bounces-259254-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:52:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A78EE612B0A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88AD83038575
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1211DFF0;
	Sat, 30 May 2026 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dDG//H98"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C318C137750;
	Sat, 30 May 2026 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780167124; cv=none; b=PQP7eoIEkarn4LpPGWpNnL527zs8yfv8pqSr7cCoe79iD7OSAItGG1qujj9WHwwu2KOZNDdDiYJMGSQoMhjQoegq3O6KGwfl4p2FWc4YZ4dzhI3woPQeEz3jVJyThHdFap8/BkmuBDH6+wXwrDiVRX69Ki4IHNYek5HGqLwSo+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780167124; c=relaxed/simple;
	bh=M151g43a0Xxal9++zQAF2alyLRFhmuWJG2s+EmDHCp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnypYq7HImjm2HOxAECdg9lxdvck+tTOs4NT+NwURz1yYr1VieqT/tMiiD/dMrRaW1qxGqeoB1mhLAAHSchfvVs21bDTyj5Eu3bTMv488mO4qrlgUPrqwPycZGO5+94n7GZm/unS5Vo/MHGw4pOML0BPv5uvz1xknrAKIA+hkWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dDG//H98; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1546F1F00893;
	Sat, 30 May 2026 18:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780167123;
	bh=s1Scfd+vtMzR6macG/oZji4uApusxvQWL+FfL2WVUCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dDG//H98znowjkRjZJvRnFNKE1tBnNikzJGDWCoKH7IMOAzg59ktmlxducklXzKYm
	 j4DiAf8MJ0Vjt/HOQPUqS21B2pCU7CRrg3R0dAqkOfUwShu4GNQ+iK7ZwObeAISol5
	 5hGnPQDcsiVv+8cITtI4rgMHgyvKH8318GCihZlc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Gow <david@davidgow.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 569/589] kunit: config: Enable KUNIT_DEBUGFS by default
Date: Sat, 30 May 2026 18:07:30 +0200
Message-ID: <20260530160239.579573848@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259254-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,davidgow.net:email]
X-Rspamd-Queue-Id: A78EE612B0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Gow <david@davidgow.net>

[ Upstream commit 17e4c68ff35090d8cb743e3c82c09f92fda1ebda ]

The KUNIT_DEBUGFS option is currently enabled based on the value of
KUNIT_ALL_TESTS, but it really doesn't have anything to do with the set of
enabled tests, so just enable it by default anyway. In particular, this
shouldn't be only visible if KUNIT_ALL_TESTS is set, which is quite
confusing.

Link: https://lore.kernel.org/r/20260425034155.53913-1-david@davidgow.net
Fixes: beaed42c427d ("kunit: default KUNIT_* fragments to KUNIT_ALL_TESTS")
Signed-off-by: David Gow <david@davidgow.net>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/kunit/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 00909e6a24438..9eb78ea5e90fc 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -15,8 +15,8 @@ menuconfig KUNIT
 if KUNIT
 
 config KUNIT_DEBUGFS
-	bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation" if !KUNIT_ALL_TESTS
-	default KUNIT_ALL_TESTS
+	bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation"
+	default y
 	help
 	  Enable debugfs representation for kunit.  Currently this consists
 	  of /sys/kernel/debug/kunit/<test_suite>/results files for each
-- 
2.53.0




