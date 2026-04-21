Return-Path: <stable+bounces-240240-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCZvDAfn52lbCgIAu9opvQ
	(envelope-from <stable+bounces-240240-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 23:07:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B80A043FA11
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 23:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDFAD306C95C
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 21:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205973DDDCF;
	Tue, 21 Apr 2026 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPr3jA5R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BE539A80E;
	Tue, 21 Apr 2026 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776805595; cv=none; b=T+L04TKgcIalcM+NLfhU8aA2XjdBhAm2+XWmmyGB8+UX/VouuJak4ppQ2ex+rDQD7lsHUn5SISLITE/MmKOXZmiIgYFtTQEv5M5ysz09Kq7pf7a0uiHGbQDNpybOl2FI84XcX57k9EZMyppvxsPJH3fT3L95TZWXA9KZFkdII1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776805595; c=relaxed/simple;
	bh=DC+j36Z9Nq1M5UtPHl1oeB+JG1/3v/YTNJSAk77kbrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbD7ijb63iaWW8MmFv1Ivt1ONH87etYUWgvyHCXzUqXJ8BgiKs/0tea+4mUm0bM6RQ+GYslC9cHendiqg6B+D9fr4Rm8lKhfTnwhjhLlBnw5xmirYsK6j1PokF0A3DTq+87R7DNtm/NKpdES0/WYCthUlFNhANheDgY/fbWqfJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPr3jA5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6A9C2BCB0;
	Tue, 21 Apr 2026 21:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776805595;
	bh=DC+j36Z9Nq1M5UtPHl1oeB+JG1/3v/YTNJSAk77kbrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uPr3jA5ReUgXjnrb2/6VG0RlmLBo1sgcijyuAwtYNIh8KAnwkWk1TFOqAEKGbTRTq
	 P9KEvEX50YNUaffBkdEpdfIbXjlhZG9eBUTGQ2dL+MjuQiVYC0G+2ANanArjeW6pIE
	 vjLwJVR70AwCBNsCIj8riJFsuSOWTiFiHYfT7SbApd/XBqLAjomrdOQ/d2QiOaTXcU
	 mvwPdDEphkfiWqwSJfJ6QXULXzvngUYGnbkIpSoFyTRli+Ibp7QX7vGv5dmmGeMuVB
	 7OXIYKVj46g8IZb+vB3SzTG6xoIrEumG8ltEen0PmOVDj9cfI8tBb7cfnSykAvWPZA
	 VnkobszuFK+Ag==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6.18 4/8] kunit: configs: Enable all CRC tests in all_tests.config
Date: Tue, 21 Apr 2026 14:05:50 -0700
Message-ID: <20260421210554.36096-5-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240240-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunit.py:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B80A043FA11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 44ff3791d6295f7b51dd2711aad6a03dd79aef22 upstream.

The new option CONFIG_CRC_ENABLE_ALL_FOR_KUNIT enables all the CRC code
that has KUnit tests, causing CONFIG_KUNIT_ALL_TESTS to enable all these
tests.  Add this option to all_tests.config so that kunit.py will run
them when passed the --alltests option.

Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20260314172224.15152-1-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 tools/testing/kunit/configs/all_tests.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index 422e186cf3cf1..c1d3659a41cf0 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -44,10 +44,12 @@ CONFIG_REGMAP_BUILD=y
 
 CONFIG_AUDIT=y
 
 CONFIG_PRIME_NUMBERS=y
 
+CONFIG_CRC_ENABLE_ALL_FOR_KUNIT=y
+
 CONFIG_SECURITY=y
 CONFIG_SECURITY_APPARMOR=y
 CONFIG_SECURITY_LANDLOCK=y
 
 CONFIG_SOUND=y
-- 
2.53.0


