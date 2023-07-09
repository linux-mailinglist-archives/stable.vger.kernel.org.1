Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3DE74C25E
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjGILTw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjGILTu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:19:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B4A199
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:19:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF2C760B86
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8EBC433C7;
        Sun,  9 Jul 2023 11:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901588;
        bh=fekGvpQ/2u+tnVuymr1snu9EJEvMWNiks5HAZcaYNEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aAor01XTfUV9DJqTzr53Q6rkMVAZgtiIr6UcDQWCIzM9ijntd4FqIwhQxYjNNJo5b
         uiXDXXF5F511YcZ4Pp4F5xrFv1Bxr4VK1g8pbzBm6Jb76q37yO7rtM24pVMxIOmMCc
         89B2VdrH/LzmQHWflO3GSjfjPcPYovwYNyOEMP6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 074/431] ima: Fix build warnings
Date:   Sun,  9 Jul 2023 13:10:22 +0200
Message-ID: <20230709111452.888930462@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
index fb25723c65bc4..3e7bee30080f2 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -89,6 +89,9 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 
 /**
  * ima_collect_modsig - Calculate the file hash without the appended signature.
+ * @modsig: parsed module signature
+ * @buf: data to verify the signature on
+ * @size: data size
  *
  * Since the modsig is part of the file contents, the hash used in its signature
  * isn't the same one ordinarily calculated by IMA. Therefore PKCS7 code
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 3ca8b7348c2e4..c9b3bd8f1bb9c 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -721,6 +721,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @secid: LSM secid of the task to be validated
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
+ * @flags: IMA actions to consider (e.g. IMA_MEASURE | IMA_APPRAISE)
  * @pcr: set the pcr to extend
  * @template_desc: the template that should be used for this rule
  * @func_data: func specific data, may be NULL
@@ -1915,7 +1916,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 
 /**
  * ima_parse_add_rule - add a rule to ima_policy_rules
- * @rule - ima measurement policy rule
+ * @rule: ima measurement policy rule
  *
  * Avoid locking by allowing just one writer at a time in ima_write_policy()
  * Returns the length of the rule parsed, an error code on failure
-- 
2.39.2



