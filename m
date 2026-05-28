Return-Path: <stable+bounces-255337-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDCGMtOfGGpvlggAu9opvQ
	(envelope-from <stable+bounces-255337-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:04:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AF85F7C50
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E92AE30207CB
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25ED2F260C;
	Thu, 28 May 2026 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fMfTtkFt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9325724677F;
	Thu, 28 May 2026 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998627; cv=none; b=gdVBf70uiucCOg0fQxckxKAQG0m1VC1VUz813Fwbu5GGxXq0Y1Bd/6FsEmtdJpZ0fehCz2JAMlxpY2T8dMqyHeD7RPTCOfgzXK68lUhjig2/5eh5xy2uBiicyUr49PWTtiVziNnqLflFlT/FETBXLeNBABdGSq5NL+SIr3bzKPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998627; c=relaxed/simple;
	bh=99JC67z3cuglC5qmGIbK9lgF2meyhUmBxhCYoTMvuHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oci1D0l0blapFQqDS23ndcQLyxGq4yYEBv4IOnEuEvSpX1yqjWha/vi2OxIhdBbbd/kpuyZnBduagf5kUHe71M1DNbhO6zCK4TCmTPNqGwVxlpbpRP0lQVSakUIba0SBy75JXfxqzMcANpZw0xS+0kjcr983wzEplGWn52jT3EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fMfTtkFt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3761F00A3A;
	Thu, 28 May 2026 20:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998626;
	bh=UTc+GU2W+vm/NssqOD47R97PeMucewp94BUPiJ2263k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fMfTtkFt1KVIIhKd2ocY1QyYe0AXucH+HpHl/RwZeKC1lrzg0Qnl8WmqYcl2qNUX6
	 vv/8rxcJY9NSE2pQQ+pALrFCCaywHxtqqWBkucgrrM3zRjh71w5tFUYTic3Wu6jtPR
	 tjERRy8a80xmQTxUnou6V9k8c1Ltv8XDSue1Lst8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Gow <david@davidgow.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 194/461] kunit: config: Enable KUNIT_DEBUGFS by default
Date: Thu, 28 May 2026 21:45:23 +0200
Message-ID: <20260528194652.698714777@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255337-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E2AF85F7C50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index 498cc51e493dc..f80ca3aeedb05 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -16,8 +16,8 @@ menuconfig KUNIT
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




