Return-Path: <stable+bounces-267398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mD2FCPk/NWpIqAYAu9opvQ
	(envelope-from <stable+bounces-267398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 15:11:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8976A5FEB
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 15:11:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=raQQXusM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267398-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267398-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92B2E3024476
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 13:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5403932C6;
	Fri, 19 Jun 2026 13:10:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74800383310;
	Fri, 19 Jun 2026 13:10:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874659; cv=none; b=OEFOzTPT+hhBGGfdISIQuefDVvf0bhow8LGRP7VeX74cBz2aLd6o+4+bdE4xpbEVe5uodUQojL51ZyqtZvyJ0JJnbLjekRukgHHqs+B8z0gSmkjUnKuNRp3vneevN2aeuvZI91lqjWeVkUnuJi19ajYt9S++EE17re5rZF/P2ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874659; c=relaxed/simple;
	bh=0X1jycyDDJxqmtpyDdqGsvAfsAmRndcVeVafJnjQbPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ps4b+YNKDtLXvNm4+q/vXgoPlpDz57Lldq+44vP1qhBYaIDOUAyqBGJlnksGv58p5aOBCt2qk8ircwKnGKnBDGBf+0gUpozL8I/5wbBzsN8uW9EnEKe34rsEUfpUAM8JsML8X27rf6++mx7FdI8RSieUHj/Vse8gatSaiCpC0kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=raQQXusM; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1781874188;
	bh=HB8w+kNLRgDlrK5vN0aqYNaykc6XjEtmpeJdfRJsSBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=raQQXusMvw4lhdPSevMt3FW60un+lmaoDvTr7Hvaq0JPqJAHUW3POzXkAxXuruFYx
	 CBYB0DIjpSGLsMpFbFeMOnQUvmBsnVgHm7wiBnQ34RG1FQzujVyTTm7DrTKO8rTOmm
	 VloR2DbXu4egwd2mmNO5HqM/NHcj17jV/jIkppUA=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4ghd7J6yCFz11N8;
	Fri, 19 Jun 2026 13:03:08 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4ghd7J0ztFz11N1;
	Fri, 19 Jun 2026 13:03:08 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>,
	stable@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] lsm: fix size queries for getselfattr with NULL buffer
Date: Fri, 19 Jun 2026 13:03:04 +0000
Message-ID: <20260619130305.27779-2-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619130305.27779-1-include@grrlz.net>
References: <20260619130305.27779-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[grrlz.net,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267398-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-security-module@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:include@grrlz.net,m:stable@vger.kernel.org,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[grrlz.net:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC8976A5FEB

The lsm_get_self_attr() syscall allows callers to pass in a NULL context
buffer to find out the size of the output needed. That path still
compared the computed entry size against the caller provided size first,
so a NULL buffer with size 0 incorrectly returned -E2BIG rather than
reporting the required size.

Only enforce the available buffer length after checking for the NULL
buffer. Cover the zero length sizing query in the self test.

Fixes: d7cf3412a9f6 ("lsm: consolidate buffer size handling into lsm_fill_user_ctx()")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 security/security.c                                  | 8 ++++----
 tools/testing/selftests/lsm/lsm_get_self_attr_test.c | 5 ++---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/security/security.c b/security/security.c
index 71aea8fdf014..fa0d7e036249 100644
--- a/security/security.c
+++ b/security/security.c
@@ -406,15 +406,15 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
 	int rc = 0;
 
 	nctx_len = ALIGN(struct_size(nctx, ctx, val_len), sizeof(void *));
+	/* no buffer - return success/0 and set @uctx_len to the req size */
+	if (!uctx)
+		goto out;
+
 	if (nctx_len > *uctx_len) {
 		rc = -E2BIG;
 		goto out;
 	}
 
-	/* no buffer - return success/0 and set @uctx_len to the req size */
-	if (!uctx)
-		goto out;
-
 	nctx = kzalloc(nctx_len, GFP_KERNEL);
 	if (nctx == NULL) {
 		rc = -ENOMEM;
diff --git a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
index 60caf8528f81..2f5ababc2b95 100644
--- a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
+++ b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
@@ -39,15 +39,14 @@ TEST(size_null_lsm_get_self_attr)
 
 TEST(ctx_null_lsm_get_self_attr)
 {
-	const long page_size = sysconf(_SC_PAGESIZE);
-	__u32 size = page_size;
+	__u32 size = 0;
 	int rc;
 
 	rc = lsm_get_self_attr(LSM_ATTR_CURRENT, NULL, &size, 0);
 
 	if (attr_lsm_count()) {
 		ASSERT_NE(-1, rc);
-		ASSERT_NE(1, size);
+		ASSERT_NE(0, size);
 	} else {
 		ASSERT_EQ(-1, rc);
 	}
-- 
2.53.0


