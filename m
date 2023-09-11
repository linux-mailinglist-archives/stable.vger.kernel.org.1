Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D502B79AC9D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbjIKV6i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239745AbjIKO1t (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:27:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503B3F0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:27:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90736C433C7;
        Mon, 11 Sep 2023 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442465;
        bh=nkAlRBH5S+CkGtzGR6pEskEDZLHMgQCobh5toL5Ty3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhGZpGbutIVeYWSw1H2UH6joIEHglrNtx1ixQ5DeoauL++ANn5Re6je4vgeT8Rj8f
         wD0rChpfJe+7SCrdLn4yKjexU82TPTkFxY7KjfCXKdgJvvRsXwcwy0imeIYTV2C7F0
         MZkfaTua0MoaVnjsmfpphNos5r0zcEgsOAkEqNPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wang Ming <machel@vivo.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 035/737] platform/x86: think-lmi: Use kfree_sensitive instead of kfree
Date:   Mon, 11 Sep 2023 15:38:14 +0200
Message-ID: <20230911134651.393903672@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Ming <machel@vivo.com>

[ Upstream commit 1da0893aed2e48e2bdf37c29b029f2e060d25927 ]

key might contain private part of the key, so better use
kfree_sensitive to free it.

Signed-off-by: Wang Ming <machel@vivo.com>
Link: https://lore.kernel.org/r/20230717101114.18966-1-machel@vivo.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/think-lmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index e4047ee0a7546..63eca13fd882f 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -719,12 +719,12 @@ static ssize_t cert_to_password_store(struct kobject *kobj,
 	/* Format: 'Password,Signature' */
 	auth_str = kasprintf(GFP_KERNEL, "%s,%s", passwd, setting->signature);
 	if (!auth_str) {
-		kfree(passwd);
+		kfree_sensitive(passwd);
 		return -ENOMEM;
 	}
 	ret = tlmi_simple_call(LENOVO_CERT_TO_PASSWORD_GUID, auth_str);
 	kfree(auth_str);
-	kfree(passwd);
+	kfree_sensitive(passwd);
 
 	return ret ?: count;
 }
-- 
2.40.1



