Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E137A7F00
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbjITMWv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbjITMWv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:22:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9251A93
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:22:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8EAC433C7;
        Wed, 20 Sep 2023 12:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212565;
        bh=6G9xwxvPbXmM+InQ4XWlsOYfxjrM7PClSWnwRhbv2Kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MPWqTuaeU9h98hx+gGF344SdcLlrE+dHaTOLWnd7k+6QuuKXnB8Ah3FvcxWwY1GVk
         /Lnf8ICiAzBOX/HuvOKsx7EFCcAPGm6YB2sr0qb2H/esiX0vEyIAbzRG2BVdMEmfCK
         KG84VU9N3BgaKLnJlTgirYtIhvUpIsn/M1T3BF3U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhen Lei <thunder.leizhen@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 48/83] kobject: Add sanity check for kset->kobj.ktype in kset_register()
Date:   Wed, 20 Sep 2023 13:31:38 +0200
Message-ID: <20230920112828.571357815@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
References: <20230920112826.634178162@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhen Lei <thunder.leizhen@huawei.com>

[ Upstream commit 4d0fe8c52bb3029d83e323c961221156ab98680b ]

When I register a kset in the following way:
	static struct kset my_kset;
	kobject_set_name(&my_kset.kobj, "my_kset");
        ret = kset_register(&my_kset);

A null pointer dereference exception is occurred:
[ 4453.568337] Unable to handle kernel NULL pointer dereference at \
virtual address 0000000000000028
... ...
[ 4453.810361] Call trace:
[ 4453.813062]  kobject_get_ownership+0xc/0x34
[ 4453.817493]  kobject_add_internal+0x98/0x274
[ 4453.822005]  kset_register+0x5c/0xb4
[ 4453.825820]  my_kobj_init+0x44/0x1000 [my_kset]
... ...

Because I didn't initialize my_kset.kobj.ktype.

According to the description in Documentation/core-api/kobject.rst:
 - A ktype is the type of object that embeds a kobject.  Every structure
   that embeds a kobject needs a corresponding ktype.

So add sanity check to make sure kset->kobj.ktype is not NULL.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/r/20230805084114.1298-2-thunder.leizhen@huaweicloud.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/kobject.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/kobject.c b/lib/kobject.c
index ea53b30cf4837..cd3e1a98eff9e 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -874,6 +874,11 @@ int kset_register(struct kset *k)
 	if (!k)
 		return -EINVAL;
 
+	if (!k->kobj.ktype) {
+		pr_err("must have a ktype to be initialized properly!\n");
+		return -EINVAL;
+	}
+
 	kset_init(k);
 	err = kobject_add_internal(&k->kobj);
 	if (err)
-- 
2.40.1



