Return-Path: <stable+bounces-214840-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLszKO6vh2nDbwQAu9opvQ
	(envelope-from <stable+bounces-214840-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 22:34:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEB41072AB
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 22:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23DC43003814
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 21:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B515A2FD69A;
	Sat,  7 Feb 2026 21:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8MF9Bc9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D79145348
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 21:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770500071; cv=none; b=AicT3EsUBgAioPwfT/fF433g/YE7BAl18aABBmdilw2Xt/d1JdxoBfktQTjaCFPcVgnE/DbygXl36w+siSwPt410mRyLaiyC5t5smwYAzypszTj2VgLEi99FQlIrE7OSxUIct1b2rQ9FoRog+tNybfZPRd1b/yRMKBLLb6DBXx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770500071; c=relaxed/simple;
	bh=NLdJKsRWrzNmpsKTvRy1Q2qqq8q6vclU6ZVRgZClpLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNOge80n1Xr0kRQubkgdSdCv1N4B7SJiHU5WvkCiHkroCmtHamPJNJapbz5H3HOkfLHMwu2BTXBh6Mu3bDkhNinKIiGB92/p3wIkHq8J00AGBwpCwW05ylscgTQhX/XSnYn+tvpGf7QkjyrwD4Fe06Q0icF7H0CdoGBlyWUI79g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8MF9Bc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90ED4C116D0;
	Sat,  7 Feb 2026 21:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770500071;
	bh=NLdJKsRWrzNmpsKTvRy1Q2qqq8q6vclU6ZVRgZClpLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N8MF9Bc9FANisK+r8QOGZwD6mVqLb+M9w8vZp17mcUQuroe6+oYGRG4F0q4g4Ly2u
	 0lL6CaYBMwWX1B1b1dqhYmUp2cGUC0AmSgIRDhiLZ12TJjsUImkmiiO6lpglj4vCxs
	 dGR5A1/PITI0cFMLSUo9IFwDifly1UhECDpVsx0Iq/7LdMBdwChi4ry6yaelRf97Fu
	 6lMEmoBT0uEkGEpFs4mCTBsu1zbc/N2fa47pBj1YbWHZiAB1UiW6ApIugSih9ARp2H
	 R2pk8F84Ezy3RVkWbqw83iC/xIoUZv+5OlBVcr9g9aMFLgl2WgDwhBaCcmxUD4ng46
	 g2mWl/vbFpEpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiquan Li <zhiquan_li@163.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] KVM: selftests: Add -U_FORTIFY_SOURCE to avoid some unpredictable test failures
Date: Sat,  7 Feb 2026 16:34:29 -0500
Message-ID: <20260207213429.568001-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020756-ventricle-automated-f5f0@gregkh>
References: <2026020756-ventricle-automated-f5f0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[163.com,google.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214840-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[plt:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEEB41072AB
X-Rspamd-Action: no action

From: Zhiquan Li <zhiquan_li@163.com>

[ Upstream commit e396a74222654486d6ab45dca5d0c54c408b8b91 ]

Some distributions (such as Ubuntu) configure GCC so that
_FORTIFY_SOURCE is automatically enabled at -O1 or above.  This results
in some fortified version of definitions of standard library functions
are included.  While linker resolves the symbols, the fortified versions
might override the definitions in lib/string_override.c and reference to
those PLT entries in GLIBC.  This is not a problem for the code in host,
but it is a disaster for the guest code.  E.g., if build and run
x86/nested_emulation_test on Ubuntu 24.04 will encounter a L1 #PF due to
memset() reference to __memset_chk@plt.

The option -fno-builtin-memset is not helpful here, because those
fortified versions are not built-in but some definitions which are
included by header, they are for different intentions.

In order to eliminate the unpredictable behaviors may vary depending on
the linker and platform, add the "-U_FORTIFY_SOURCE" into CFLAGS to
prevent from introducing the fortified definitions.

Signed-off-by: Zhiquan Li <zhiquan_li@163.com>
Link: https://patch.msgid.link/20260122053551.548229-1-zhiquan_li@163.com
Fixes: 6b6f71484bf4 ("KVM: selftests: Implement memcmp(), memcpy(), and memset() for guest use")
Cc: stable@vger.kernel.org
[sean: tag for stable]
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ Makefile.kvm -> Makefile ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kvm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 4a2caef2c9396..9b9250b953375 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -202,6 +202,7 @@ else
 LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
 endif
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
+	-U_FORTIFY_SOURCE \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
 	-I$(<D) -Iinclude/$(UNAME_M) -I ../rseq -I.. $(EXTRA_CFLAGS) \
-- 
2.51.0


