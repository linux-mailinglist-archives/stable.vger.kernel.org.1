Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313FB761604
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjGYLfo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbjGYLfl (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:35:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7833910C9
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:35:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EF5B616A2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E492C433C9;
        Tue, 25 Jul 2023 11:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284938;
        bh=2FBXj2wEhUVWtjzKa/0WTZS3ewchow9Uh0wf3TwtGbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AeGwI31O/WiXWjXoEtiS2/G41KTNaXnO73qZKO/CM9WXrAu65/0KQrrvuNW71s+c2
         j6img4vc6tmqlT+oMdgwEvAqEfdawpj/Fz220eNkHC2sTmoF+ltAXik8oJBkigLAU+
         1rPXGFTzOgr/4/5+JH9Tt69Jhz8IHTqGU19KRaAI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 025/313] evm: Complete description of evm_inode_setattr()
Date:   Tue, 25 Jul 2023 12:42:58 +0200
Message-ID: <20230725104522.208391950@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
index b82291d10e730..cc7e4e4439b0f 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -471,7 +471,9 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
 
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



