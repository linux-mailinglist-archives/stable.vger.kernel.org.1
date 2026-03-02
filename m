Return-Path: <stable+bounces-222622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB2KAnGrpWmpDgAAu9opvQ
	(envelope-from <stable+bounces-222622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 16:23:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D861DBBE9
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 16:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5909F312629F
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 15:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC6328469B;
	Mon,  2 Mar 2026 15:14:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0289D387597
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464472; cv=none; b=YsWwkULB2dDYvZhdcrHDFG0AGlATPTZ/bF8D4C9Z17MX8Epv9tkvJvUlhxS+FiNaoMgAhiAY+/tW00aIaKyPEAGie9PJqiayDvm6QUzZjsxR8sGdJTm7b120jwOtm9hKaFEQ76OdCk17pP6v0jtA34ojVqHdv1MsjtK3F6zD4+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464472; c=relaxed/simple;
	bh=j0t6kgC1SdoudVvZBdgBl8sKsDP/Jdmop9TA+OkHRsE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IFWcZkXaoRQlzb3DDtX26C8i2e9ykLCUAuNmeoX2dhmpRYZsspQkK7ZoL0bBHxQ16wH4D70Ui2R/x+pyC90s77I17YrUU+pCfrD4KMvdkHQZ2u17iloUAdTBYt6CsXZGmcqKDrnDKxFgwim1E7WJw/Zp81s/7UBjzVWKVt35Kb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EA951477;
	Mon,  2 Mar 2026 07:14:24 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 005E23F73B;
	Mon,  2 Mar 2026 07:14:28 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: stable@vger.kernel.org,
	sashal@kernel.org,
	hamzamahfooz@linux.microsoft.com,
	tv@lio96.de,
	gregkh@linuxfoundation.org,
	irogers@google.com,
	james.clark@linaro.org,
	namhyung@kernel.org,
	acme@redhat.com
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH 6.6.y] tools: Fix bitfield dependency failure
Date: Mon,  2 Mar 2026 15:13:47 +0000
Message-Id: <20260302151347.2833066-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 58D861DBBE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222622-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leo.yan@arm.com,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.877];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:mid,arm.com:email,linuxfoundation.org:email,linaro.org:email,lio96.de:email]
X-Rspamd-Action: no action

[ Upstream commit a537c0da168a08b0b6a7f7bd9e75f4cc8d45ff57 ]

A perf build failure was reported by Thomas Voegtle on stable kernel
v6.6.120:

    CC      tests/sample-parsing.o
    CC      util/intel-pt-decoder/intel-pt-pkt-decoder.o
    CC      util/perf-regs-arch/perf_regs_csky.o
    CC      util/arm-spe-decoder/arm-spe-pkt-decoder.o
    CC      util/perf-regs-arch/perf_regs_loongarch.o
  In file included from util/arm-spe-decoder/arm-spe-pkt-decoder.h:10,
                   from util/arm-spe-decoder/arm-spe-pkt-decoder.c:14:
  /local/git/linux-stable-rc/tools/include/linux/bitfield.h: In function ‘le16_encode_bits’:
  /local/git/linux-stable-rc/tools/include/linux/bitfield.h:166:31: error: implicit declaration of
  function ‘cpu_to_le16’; did you mean ‘htole16’? [-Werror=implicit-function-declaration]
    ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
                                 ^~~~~~~~~
  /local/git/linux-stable-rc/tools/include/linux/bitfield.h:149:9: note: in definition of macro
  ‘____MAKE_OP’
    return to((v & field_mask(field)) * field_multiplier(field)); \
           ^~
  /local/git/linux-stable-rc/tools/include/linux/bitfield.h:170:1: note: in expansion of macro
  ‘__MAKE_OP’
   __MAKE_OP(16)

Fix this by including linux/kernel.h, which provides the required
definitions.

The issue was not found on the mainline due to the relevant C files have
included kernel.h.  It'd be good to merge this change on mainline
as well for robustness.

Closes: https://lore.kernel.org/stable/3a44500b-d7c8-179f-61f6-e51cb50d3512@lio96.de/
Fixes: 64d86c03e1441742 ("perf arm-spe: Extend branch operations")
Reported-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Reported-by: Thomas Voegtle <tv@lio96.de>
Signed-off-by: Leo Yan <leo.yan@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/bitfield.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/linux/bitfield.h b/tools/include/linux/bitfield.h
index 6093fa6db260..ddf81f24956b 100644
--- a/tools/include/linux/bitfield.h
+++ b/tools/include/linux/bitfield.h
@@ -8,6 +8,7 @@
 #define _LINUX_BITFIELD_H
 
 #include <linux/build_bug.h>
+#include <linux/kernel.h>
 #include <asm/byteorder.h>
 
 /*
-- 
2.34.1


