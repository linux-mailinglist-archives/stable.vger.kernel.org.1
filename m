Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CAA7759B9
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjHILC6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjHILC6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:02:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80951FFE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:02:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7891561FA9
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AE0C433C7;
        Wed,  9 Aug 2023 11:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578975;
        bh=Gw3ueeG8xgQsFn26viLDJJvO6y6+E1nOpEnokn4qqm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mi3r5W4dxnz7Esv31uyj0BY/CQI4RW6/y8J8COTBcOGtAoiwkC+UmqFkSnvm5Km0d
         7TRfvRZOo0c27Bc7gvTIAHt94FRmh7iDbbbo/zqaAVjmGFUuN8A9sND89nPTLkRrJ6
         VSZ3crb5rxQ8Ga2AVks3un+ama4eVNiIgtZWO+0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 013/204] evm: Complete description of evm_inode_setattr()
Date:   Wed,  9 Aug 2023 12:39:11 +0200
Message-ID: <20230809103643.029150193@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

[ Upstream commit b1de86d4248b273cb12c4cd7d20c08d459519f7d ]

Add the description for missing parameters of evm_inode_setattr() to
avoid the warning arising with W=n compile option.

Fixes: 817b54aa45db ("evm: add evm_inode_setattr to prevent updating an invalid security.evm") # v3.2+
Fixes: c1632a0f1120 ("fs: port ->setattr() to pass mnt_idmap") # v6.3+
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/evm/evm_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 6e761b07cb3f0..9b75166619236 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -427,7 +427,9 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
 
 /**
  * evm_inode_setattr - prevent updating an invalid EVM extended attribute
+ * @idmap: idmap of the mount
  * @dentry: pointer to the affected dentry
+ * @attr: iattr structure containing the new file attributes
  *
  * Permit update of file attributes when files have a valid EVM signature,
  * except in the case of them having an immutable portable signature.
-- 
2.39.2



