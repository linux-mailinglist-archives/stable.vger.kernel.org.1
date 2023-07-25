Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CEA761618
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjGYLgV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbjGYLgS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656111BC5
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:36:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02B9061654
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F81C433C9;
        Tue, 25 Jul 2023 11:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284963;
        bh=6OFFlbbJPaKPL+BTbMv2sFQikdUwl0zMZzcGLtyUtvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cX7HbFgL2Syept5QmIASdX6l02TLrCuBskc5HwAMKY1GYi1lsNzOmSqmhXTuPw34N
         qEj6qfKJIB6a2ZpoEX+UeQP/MRpv9u6IoOcOhqd0WyfDM10guQuQAZtQj0c0YMFcoB
         l77z7qAwF+sMT48dqntmHlDyYNzmFnkawHj/w+Ao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 027/313] ima: Fix build warnings
Date:   Tue, 25 Jul 2023 12:43:00 +0200
Message-ID: <20230725104522.299460572@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

[ Upstream commit 95526d13038c2bbddd567a4d8e39fac42484e182 ]

Fix build warnings (function parameters description) for
ima_collect_modsig(), ima_match_policy() and ima_parse_add_rule().

Fixes: 15588227e086 ("ima: Collect modsig") # v5.4+
Fixes: 2fe5d6def167 ("ima: integrity appraisal extension") # v5.14+
Fixes: 4af4662fa4a9 ("integrity: IMA policy") # v3.2+
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/ima/ima_modsig.c | 3 +++
 security/integrity/ima/ima_policy.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index d106885cc4955..5fb971efc6e10 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -109,6 +109,9 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 
 /**
  * ima_collect_modsig - Calculate the file hash without the appended signature.
+ * @modsig: parsed module signature
+ * @buf: data to verify the signature on
+ * @size: data size
  *
  * Since the modsig is part of the file contents, the hash used in its signature
  * isn't the same one ordinarily calculated by IMA. Therefore PKCS7 code
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 6df0436462ab7..e749403f07a8b 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -500,6 +500,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @secid: LSM secid of the task to be validated
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
+ * @flags: IMA actions to consider (e.g. IMA_MEASURE | IMA_APPRAISE)
  * @pcr: set the pcr to extend
  * @template_desc: the template that should be used for this rule
  *
@@ -1266,7 +1267,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 
 /**
  * ima_parse_add_rule - add a rule to ima_policy_rules
- * @rule - ima measurement policy rule
+ * @rule: ima measurement policy rule
  *
  * Avoid locking by allowing just one writer at a time in ima_write_policy()
  * Returns the length of the rule parsed, an error code on failure
-- 
2.39.2



