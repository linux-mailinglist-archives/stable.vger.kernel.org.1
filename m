Return-Path: <stable+bounces-211381-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ApzDI14c2kfwAAAu9opvQ
	(envelope-from <stable+bounces-211381-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 14:33:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E9C76497
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 14:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CDAB3046525
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 13:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DC8324B1A;
	Fri, 23 Jan 2026 13:32:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAF73164C1;
	Fri, 23 Jan 2026 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769175137; cv=none; b=B8IsY1Wl/Yv/q2kdGJ746vxC/mw8f2ACtUMfVkl2t6gSpnb21sIv7qzmdhRwgO+yWVek+MKD7KJKXestZeGK85mwWH2TJYrq4zQkewx7ZmJmLekSf7OkfAXKr6lyOoGrQzpVQt6Hu931ymDCcCjjp9TdQVsGk+izokkJfYceHWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769175137; c=relaxed/simple;
	bh=pZJHIS1TzJr9+FiQn4WT97OcG2JDBEl64HyYP/h5m5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IOZtWWmfoeBw5/oouYRFtMF9ff8JbaTBnzIudi4UGH0uwzYJ87aqtO+XFhzcxUai4mF3I4rGQgioiZQJ/Lp6mkl+Sxu9Xziy9/G3j3mBi8HcwrjVyrun1xwsjuPhQeAtcmrGEVxsgo+We1+pvlGpGJAE5hZVz9sf40kmiVX157Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F37A1515;
	Fri, 23 Jan 2026 05:32:08 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21D643F632;
	Fri, 23 Jan 2026 05:32:12 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 23 Jan 2026 13:32:03 +0000
Subject: [PATCH v2 1/2] tools: Fix bitfield dependency failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260123-perf_fix_bitfield-h-v2-1-cc8f8752607c@arm.com>
References: <20260123-perf_fix_bitfield-h-v2-0-cc8f8752607c@arm.com>
In-Reply-To: <20260123-perf_fix_bitfield-h-v2-0-cc8f8752607c@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 coresight@lists.linaro.org, Leo Yan <leo.yan@arm.com>, 
 Thomas Voegtle <tv@lio96.de>, Greg KH <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769175130; l=2314;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=pZJHIS1TzJr9+FiQn4WT97OcG2JDBEl64HyYP/h5m5g=;
 b=BRAsB+ERbc3tr8DEU+XnlKutDrpwcmG2h2RV0UnbmO6XEyXeN7KX/OGZ6lWKYPAJ3vRw8CNlw
 LjFVEQp6zooCQl79DMubrcVieXTNJk9RYukv4nuzAUQ1Co/I5Aripwg
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211381-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leo.yan@arm.com,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:mid,arm.com:email]
X-Rspamd-Queue-Id: 55E9C76497
X-Rspamd-Action: no action

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

Fixes: 64d86c03e144 ("perf arm-spe: Extend branch operations")
Reported-by: Thomas Voegtle <tv@lio96.de>
Closes: https://lore.kernel.org/stable/3a44500b-d7c8-179f-61f6-e51cb50d3512@lio96.de/
To: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/include/linux/bitfield.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/linux/bitfield.h b/tools/include/linux/bitfield.h
index 6093fa6db2600b3246007b2236d7c0076b02343b..ddf81f24956ba069b2c1a7b096a6c9bf92fc9182 100644
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


