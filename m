Return-Path: <stable+bounces-220155-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPsWJP0ro2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220155-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:55:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6AF1C5358
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13B5F30CCC30
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F84049252B;
	Sat, 28 Feb 2026 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3S89Drt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E85492521;
	Sat, 28 Feb 2026 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300063; cv=none; b=loocchFKkmthzH0Zsob06jf0tvk41C3ZPJ4XFpHpagXNvRKPu6vORJC5iD8U4kz7WJGdckMlKkxjQC/DDG8BHisQfYeW3eZlzPTskdNGkHdt+fpZ2+CECfn9a733SJoiwEQGeTYl09aEJDO1diDhSMA3OEpob8ku5KanovFDHUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300063; c=relaxed/simple;
	bh=pqOKYIqpNgvGVcdU0f2NquL1lyA2LhxfoqCDro18LU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Scp+2njp1gPyN+WObFgQgWs8U/+mLj9mNnrT7bbAA6dw4Zo6xObCT758JORg19JSDmbgaol88IVg/xMYlFaThUklyQ3tbtiacPd35gyE6VgC8w/mjmPsaQoCTcvaYHjUHXtGJMtDApU0IX3/KeIFmBL0FXvew/6+bS11908W6IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3S89Drt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AAAC116D0;
	Sat, 28 Feb 2026 17:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300063;
	bh=pqOKYIqpNgvGVcdU0f2NquL1lyA2LhxfoqCDro18LU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N3S89Drthuc0TEZZl5PbMTaV8vPLJ8pNK8eZG9o4GNPbwC1lYObWApAlTHtDvAnLw
	 yCuZcps7uEibQA8VYD1LcmSlP9+vwA/azLEQGT31ovV9aC6HysT9Fye89I02z5fmcf
	 TtHlUpoHrfcPQugr/IEgeeRbghIxMtF3TXsSF6LFrFZ1ls4Z+DYkrBLnRxUyZpzsBL
	 n4O7b7nLLLtEbUNGp/jDvgBE+Gv4IeLuKWHo1YQHFkXUw9eJH2lm5GHY4xc21QaedY
	 8JS0/G+lunJ7kVmiU385YWNM6Ppcz9Z1u1cEYXeFRVWo+2qqOWKSVL2LoHz8HQ1LB3
	 IV/1kSp8GdMnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 077/844] rust: cpufreq: always inline functions using build_assert with arguments
Date: Sat, 28 Feb 2026 12:19:50 -0500
Message-ID: <20260228173244.1509663-78-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220155-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: EA6AF1C5358
X-Rspamd-Action: no action

From: Alexandre Courbot <acourbot@nvidia.com>

[ Upstream commit 8c8b12a55614ea05953e8d695e700e6e1322a05d ]

`build_assert` relies on the compiler to optimize out its error path.
Functions using it with its arguments must thus always be inlined,
otherwise the error path of `build_assert` might not be optimized out,
triggering a build error.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/kernel/cpufreq.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index f968fbd228905..0879a79485f8e 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -1015,6 +1015,8 @@ impl<T: Driver> Registration<T> {
         ..pin_init::zeroed()
     };
 
+    // Always inline to optimize out error path of `build_assert`.
+    #[inline(always)]
     const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {
         let src = name.to_bytes_with_nul();
         let mut dst = [0; CPUFREQ_NAME_LEN];
-- 
2.51.0


