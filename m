Return-Path: <stable+bounces-240236-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB1TLt7m52lbCgIAu9opvQ
	(envelope-from <stable+bounces-240236-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 23:06:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC8E43F9C7
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 23:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B89C300B462
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 21:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375EB35B63F;
	Tue, 21 Apr 2026 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/uXZsoP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB24B27F01E;
	Tue, 21 Apr 2026 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776805594; cv=none; b=VLmh8etly/K9R1RuxOiZklOaieCLqP5M1wxBnBSnYlPzUi6YrSAJP4NPTmqzIEHSeqRrs3AeOx0xl2ZI+iqgbw3gozr0ZiWCXnltNH68ajZ/k2+DCtjCz7gn4MS2JjOLh7ySrzxrREpWqxhRkwiBx99OM8lAa9Ml+G6Omdva8k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776805594; c=relaxed/simple;
	bh=2ysPRLmxFcc2vklTr7K+wuq9MRkG2t9eaydHlohgJMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gGbtutcQhGdBT1hgbRgWVOaVhjKH9mSUYR9zXDmkjNg7vKFI+NQ/yqQXQiPpboG3mmd6OrjQLy9+1dbc6jsXfFWH87DByxN3ogIT5BB2hgScWznMFHkK4sUDp0tHyWBw3Bo1UrX/XNEnAKZ47FbWuHy1JMgKznLzwKHJStrQ4ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/uXZsoP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38830C2BCB0;
	Tue, 21 Apr 2026 21:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776805593;
	bh=2ysPRLmxFcc2vklTr7K+wuq9MRkG2t9eaydHlohgJMc=;
	h=From:To:Cc:Subject:Date:From;
	b=K/uXZsoP8bazNHeYjmZCvvI4xYrGP1Y0Mh7LJfhw3w9MTtd/1N1vSn87rwA+HOsbq
	 8zApdSnRn3Myjbv7gjH46JvJ3CvUmpC8uSxiQnxbKxDgpldrzj8vJKwl8MGJpM9Y+/
	 UkU1nZhI9vMDs6wbKLu/ipu7X2quRO4DEZydGPUBqymPDPbVCzy27fpS5uUPe+4cdR
	 ppmCbYX4I+Fy3hUnq9fSTZfOrzZZw6IKkVlbV90SFGShWk5Og4g1VvNXOcYRc4Rnfc
	 qYqZXO2JjB8b0Hb7HAjW6lnhJVigwKPNN1NCxPvSq5pWFjHr7YhcQpbkKM/lRXxC99
	 jWBoO/qVN4piQ==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.18 0/8] Backport crypto and CRC KUnit improvements
Date: Tue, 21 Apr 2026 14:05:46 -0700
Message-ID: <20260421210554.36096-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240236-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunit.py:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5EC8E43F9C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series backports improvements to the KUnit testing for the crypto
and CRC libraries to 6.18, including:

- Finish fixing the test kconfig options to follow standard conventions
- Add kunitconfig files
- Make the tests be included in 'kunit.py run --alltests'

The crypto patches were adjusted to drop parts that pertain to tests
added in later kernels.

While stable backports are normally limited to "fixes", I think it's
worth also backporting the kunitconfig files and the all_tests.config
support, since these are safe test-only changes that are helpful for
testing 6.18.  For example, this should make KernelCI run all these
tests on 6.18, as it uses 'kunit.py run --alltests'.

Eric Biggers (8):
  lib/crc: tests: Make crc_kunit test only the enabled CRC variants
  lib/crc: tests: Add CRC_ENABLE_ALL_FOR_KUNIT
  lib/crc: tests: Add a .kunitconfig file
  kunit: configs: Enable all CRC tests in all_tests.config
  lib/crypto: tests: Add a .kunitconfig file
  lib/crypto: tests: Introduce CRYPTO_LIB_ENABLE_ALL_FOR_KUNIT
  kunit: configs: Enable all crypto library tests in all_tests.config
  lib/crypto: tests: Drop the default to CRYPTO_SELFTESTS

 lib/crc/.kunitconfig                         |  3 ++
 lib/crc/Kconfig                              | 17 ++++++++---
 lib/crc/tests/crc_kunit.c                    | 28 +++++++++++++----
 lib/crypto/.kunitconfig                      | 11 +++++++
 lib/crypto/tests/Kconfig                     | 32 +++++++++++++++-----
 tools/testing/kunit/configs/all_tests.config |  4 +++
 6 files changed, 78 insertions(+), 17 deletions(-)
 create mode 100644 lib/crc/.kunitconfig
 create mode 100644 lib/crypto/.kunitconfig


base-commit: 47a33eea6d5145d53e42315381ef28286c2218fb
-- 
2.53.0


