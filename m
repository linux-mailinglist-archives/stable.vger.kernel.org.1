Return-Path: <stable+bounces-269332-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GG1KKilCP2oAQgkAu9opvQ
	(envelope-from <stable+bounces-269332-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 05:23:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E806D0D7E
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 05:23:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bytedance.com header.s=2212171451 header.b=a7l1dtQF;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269332-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269332-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=bytedance.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A65F3302D4F0
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 03:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26110349AFF;
	Sat, 27 Jun 2026 03:23:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A321F2459EA
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 03:23:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782530592; cv=none; b=Jfgljxzso1lCdJloaeUxpiwQlzern9OZuGc/hcq1iaSMF8/h0zBOFaw8PPifZ4NCx2tk6q8HlRbuOenXgQVfsUbw8ElelfqmBKkF6X7sASGI2KiMw24VBBWYKy/4mq23iT8YBRjN72kqzZ3jxvxGIru8b5lfDBjdP0Gs9Cpwr1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782530592; c=relaxed/simple;
	bh=SV6EY6XCUwkEMMddd2iO2o2cI8JPUmgYKWu3JcsREQM=;
	h=Mime-Version:Cc:Message-Id:From:References:Content-Type:To:
	 Subject:Date:In-Reply-To; b=rJuFRjn9xhj4nrBGrC08UvVWHcTK/5WKX7O/sAHMGM5w6BD0SNr3e/ZjZlnMhpGwZO02Zb5Ivi1gMOJW0B5kKZ8jLZ5l+idfgF39lfc+9W0oLRCGUcl3xZGPL82jyrTBNQzmY3gkYcNBTsdQn+MOuJj+lD8J3zxxjtSkkOyj2as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=a7l1dtQF; arc=none smtp.client-ip=209.127.230.112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1782530584; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=JaDRtHNksBp8HzdSWMeH/ZqouUwL9AyNRTvyVWjch9k=;
 b=a7l1dtQFFIdUJGTYAu0dWZ8R7wwFtJZLDqXJlzQJhnqoCLuBQ9X6S4bqjNXFeqB8ywvlRT
 IQEX9IfeDpRCJMVTYn35ZzuNCq4AQfW+wFB3wUetRkmZ/lvtJsu1td/SXgFrA7oVeQpKst
 mnhDTUN3e5yBQGyAIDAMFs2ZIXqooWyi4UzAnMmsdthx/T7DKx4K+T7i7FIqvhuVS9YFup
 N5RxpRVsZY8jRormmRDRUNX/flfAiN3uR/Lmiek14w61yiWuX+2s0grbPuQhs4ttrSjGf3
 E3xD2piuQIJFDkj9JVfkuY3deIvuAHw9km22Va5Vf8EvzPgsBjjcTphnNJM+GA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Cc: <andre.przywara@arm.com>, <linux-kernel@vger.kernel.org>, 
	<cristian.marussi@arm.com>, <will@kernel.org>, <catalin.marinas@arm.com>, 
	<broonie@kernel.org>, <shuah@kernel.org>, 
	<linux-arm-kernel@lists.infradead.org>, 
	<linux-kselftest@vger.kernel.org>, 
	"Yijia Wang" <wangyijia.yeah@bytedance.com>
Message-Id: <20260627032259.2086191-1-wangyijia.yeah@bytedance.com>
X-Mailer: git-send-email 2.43.0
X-Lms-Return-Path: <lba+26a3f4216+081747+vger.kernel.org+wangyijia.yeah@bytedance.com>
From: "Yijia Wang" <wangyijia.yeah@bytedance.com>
References: <stable-reply-item017-arm64-sve-resend-20260626@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
To: <stable@vger.kernel.org>, <sashal@kernel.org>, 
	<gregkh@linuxfoundation.org>
Subject: [PATCH v2 5.15.y] kselftest/arm64: signal: Skip SVE signal test if not enough VLs supported
Date: Sat, 27 Jun 2026 11:22:59 +0800
In-Reply-To: <stable-reply-item017-arm64-sve-resend-20260626@kernel.org>
X-Original-From: Yijia Wang <wangyijia.yeah@bytedance.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andre.przywara@arm.com,m:linux-kernel@vger.kernel.org,m:cristian.marussi@arm.com,m:will@kernel.org,m:catalin.marinas@arm.com,m:broonie@kernel.org,m:shuah@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kselftest@vger.kernel.org,m:wangyijia.yeah@bytedance.com,m:stable@vger.kernel.org,m:sashal@kernel.org,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[wangyijia.yeah@bytedance.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-269332-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangyijia.yeah@bytedance.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bytedance.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,vger.kernel.org:from_smtp,bytedance.com:dkim,bytedance.com:email,bytedance.com:mid,bytedance.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08E806D0D7E

[ Upstream commit 78c09c0f4df89fabdcfb3e5e53d3196cf67f64ef ]

On platform where SVE is supported but there are less than 2 VLs available
the signal SVE change test should be skipped instead of failing.

Reported-by: Andre Przywara <andre.przywara@arm.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20220524103149.2802-1-cristian.marussi@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Yijia Wang <wangyijia.yeah@bytedance.com>
---
Changes in v2:
- Keep the commit message aligned with the upstream commit, as requested by
  Sasha.
- Link to v1:
  https://lore.kernel.org/r/20260626-b4-arm64-515-preview-clean-v1-1-ad19e286e322@bytedance.com

 .../arm64/signal/testcases/fake_sigreturn_sve_change_vl.c       | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c
index bb50b5adb..915821375 100644
--- a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c
+++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c
@@ -6,6 +6,7 @@
  * supported and is expected to segfault.
  */
 
+#include <kselftest.h>
 #include <signal.h>
 #include <ucontext.h>
 #include <sys/prctl.h>
@@ -40,6 +41,7 @@ static bool sve_get_vls(struct tdescr *td)
 	/* We need at least two VLs */
 	if (nvls < 2) {
 		fprintf(stderr, "Only %d VL supported\n", nvls);
+		td->result = KSFT_SKIP;
 		return false;
 	}
 
-- 
2.43.0

