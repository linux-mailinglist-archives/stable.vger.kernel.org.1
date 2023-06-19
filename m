Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82648735265
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjFSKeV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjFSKeL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:34:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCE8B3
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:34:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C66FA60B62
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB75FC433C0;
        Mon, 19 Jun 2023 10:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170849;
        bh=OAXPy3wpiQhM255WLShy5Vhb05cx7afxa7QjflIereA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wpQBzgCae+oYSYS4aqxA9CdMkRiMEynwTYDEDBlbINrPKXVtIbuAnPsyth95mXsx/
         v1CQ6yw4630pVq6cq53w1RVuLclX9JP2gfe+dE3qMDealjs8jmqBccYL3cMyZZVUtk
         okZsK0fMfp1CZzfxudT/Xx5EVEheBvbAPxEbOOMM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ivan Orlov <ivan.orlov0322@gmail.com>,
        Immad Mir <mirimmad17@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.3 057/187] LoongArch: Fix debugfs_create_dir() error checking
Date:   Mon, 19 Jun 2023 12:27:55 +0200
Message-ID: <20230619102200.436516706@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Immad Mir <mirimmad17@gmail.com>

commit 41efbb682de1231c3f6361039f46ad149e3ff5b9 upstream.

The debugfs_create_dir() returns ERR_PTR in case of an error and the
correct way of checking it is using the IS_ERR_OR_NULL inline function
rather than the simple null comparision. This patch fixes the issue.

Cc: stable@vger.kernel.org
Suggested-By: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Immad Mir <mirimmad17@gmail.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kernel/unaligned.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/loongarch/kernel/unaligned.c
+++ b/arch/loongarch/kernel/unaligned.c
@@ -485,7 +485,7 @@ static int __init debugfs_unaligned(void
 	struct dentry *d;
 
 	d = debugfs_create_dir("loongarch", NULL);
-	if (!d)
+	if (IS_ERR_OR_NULL(d))
 		return -ENOMEM;
 
 	debugfs_create_u32("unaligned_instructions_user",


