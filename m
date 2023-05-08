Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753C96FA6E3
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjEHKZU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbjEHKY4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:24:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0582525F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:24:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3900625B4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A367AC433EF;
        Mon,  8 May 2023 10:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541462;
        bh=j1HV1S8YJYVExwIh2QmUEhKOlaXk7iGP3obXbkb+I1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/QXos9zIl1wJ0CW3TB9j5V7Q3BFZSIATxXJ7LSjHNNbKtxaiWqVWYGcSJOpxKFhG
         ze6bKCRhoszHQRSt1uHXlVFbzEA5VhM7e3+GswGduLhgQuUcq2ZM4sMpNye2U8B8LH
         vtQMew3VMuEZhwiSD8BbOU641z+q/4gZoIDYHb24=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 122/663] selinux: fix Makefile dependencies of flask.h
Date:   Mon,  8 May 2023 11:39:08 +0200
Message-Id: <20230508094432.480276448@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Ondrej Mosnacek <omosnace@redhat.com>

[ Upstream commit bcab1adeaad4b39a1e04cb98979a367d08253f03 ]

Make the flask.h target depend on the genheaders binary instead of
classmap.h to ensure that it is rebuilt if any of the dependencies of
genheaders are changed.

Notably this fixes flask.h not being rebuilt when
initial_sid_to_string.h is modified.

Fixes: 8753f6bec352 ("selinux: generate flask headers during kernel build")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 7761624448826..103c2776478a7 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -23,8 +23,8 @@ ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include
 $(addprefix $(obj)/,$(selinux-y)): $(obj)/flask.h
 
 quiet_cmd_flask = GEN     $(obj)/flask.h $(obj)/av_permissions.h
-      cmd_flask = scripts/selinux/genheaders/genheaders $(obj)/flask.h $(obj)/av_permissions.h
+      cmd_flask = $< $(obj)/flask.h $(obj)/av_permissions.h
 
 targets += flask.h av_permissions.h
-$(obj)/flask.h: $(src)/include/classmap.h FORCE
+$(obj)/flask.h: scripts/selinux/genheaders/genheaders FORCE
 	$(call if_changed,flask)
-- 
2.39.2



