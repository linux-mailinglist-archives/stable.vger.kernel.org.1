Return-Path: <stable+bounces-240238-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOD2Lezm52lbCgIAu9opvQ
	(envelope-from <stable+bounces-240238-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 23:06:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF73843F9DD
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 23:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98BEB3019380
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 21:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F121B39DBF0;
	Tue, 21 Apr 2026 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkRUaD+X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E3C39EF39;
	Tue, 21 Apr 2026 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776805594; cv=none; b=ZrJniDkbIMLBLYa979keibgOd6Pn+WHqemU1JEnUFx/wNNeQSzbWWrPxvCPi3pyuBCZQ1U3aPKOOiMuNKLJcmmTbb1GAc1iouJY369TNpqm4Gj92L5MJlGpBAw4S9o67LqGkRfRZPiEWu/L/dcoUYEw3nGjtbj/ODxqq7MYYYIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776805594; c=relaxed/simple;
	bh=oR2pQYMoh/dbUTrPsET33NxZnuuBzc+Rk6hFWu5w994=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxSyGHUAAZdTjTgHJoq1u99G9TxpMCuQ5kB0D5uDQfL5QDh2Oqxln38XTF9DkcsvjbRpnPPfsgPW/HXc7kz4zGO1eFTGP0Ap5RIzVkAqIPYROKejWtS/kC9P/JCNon91Q4BAMuYQYqt/oRjXEKpKZ9ErX0c6dx9ZdMJKGMaF/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkRUaD+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACB7C2BCB0;
	Tue, 21 Apr 2026 21:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776805594;
	bh=oR2pQYMoh/dbUTrPsET33NxZnuuBzc+Rk6hFWu5w994=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UkRUaD+XKJPIsDtQjb+T95GueqnJz4akeC2d2/2oePEIwBkDaKmjN1aV0bm+NkwKF
	 yuIvTOYEsQiusD7tlRInGAjAe9M7sFEAuGy8WcM0by/oonYR+BqPIAvMBEshnphLo6
	 My2AWFZ4+h9zyajTz9dz2ZtrScjLgCKntIahLly63r23BQBCGqTVajScwVYsTz8YbQ
	 8Ebf+1ZOBUXH1gXLOoDmtMGh/wI7HnmVi1Ea5PMGJE+9n+hBUjCpoMc4p9FcWGEcO4
	 hVtMVjFr+EE0CIDFJ9zVrezkdjlWbma0+EaQXDv1ktsYVIQF0KLFtPWMfAOa1Nyllm
	 Xhu0XGmYEHOsw==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.18 2/8] lib/crc: tests: Add CRC_ENABLE_ALL_FOR_KUNIT
Date: Tue, 21 Apr 2026 14:05:48 -0700
Message-ID: <20260421210554.36096-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421210554.36096-1-ebiggers@kernel.org>
References: <20260421210554.36096-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240238-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF73843F9DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit cdf22aeaad8430905c3aa3b3d0f2686c65395c22 upstream.

Now that crc_kunit uses the standard "depends on" pattern, enabling the
full set of CRC tests is a bit difficult, mainly due to CRC7 being
rarely used.  Add a kconfig option to make it easier.  It is visible
only when KUNIT, so hopefully the extra prompt won't be too annoying.

Link: https://lore.kernel.org/r/20260306033557.250499-3-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/crc/Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/crc/Kconfig b/lib/crc/Kconfig
index 9ddfd1a297576..cca228879bb5a 100644
--- a/lib/crc/Kconfig
+++ b/lib/crc/Kconfig
@@ -105,10 +105,24 @@ config CRC_KUNIT_TEST
 	  Unit tests for the CRC library functions.
 
 	  This is intended to help people writing architecture-specific
 	  optimized versions.  If unsure, say N.
 
+config CRC_ENABLE_ALL_FOR_KUNIT
+	tristate "Enable all CRC functions for KUnit test"
+	depends on KUNIT
+	select CRC7
+	select CRC16
+	select CRC_T10DIF
+	select CRC32
+	select CRC64
+	help
+	  Enable all CRC functions that have test code in CRC_KUNIT_TEST.
+
+	  Enable this only if you'd like the CRC KUnit test suite to test all
+	  the CRC variants, even ones that wouldn't otherwise need to be built.
+
 config CRC_BENCHMARK
 	bool "Benchmark for the CRC functions"
 	depends on CRC_KUNIT_TEST
 	help
 	  Include benchmarks in the KUnit test suite for the CRC functions.
-- 
2.53.0


