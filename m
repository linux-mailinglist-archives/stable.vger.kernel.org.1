Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6883D703917
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244478AbjEORiu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244325AbjEORif (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:38:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B507C100FE
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:36:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9589262D38
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A90C4339B;
        Mon, 15 May 2023 17:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172161;
        bh=XztfB7Qx+D59FHCVeF15EkOwyW2YVPvU5kTPFQJA1sI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NHsfMh7DzTvPD91SBOKcTv3X2FN6Y4ebnJ/2Gl4l5JHtzs9mFsc0twj0sNTTEB6CY
         WHWWfguxbJA8ydwpgJFjOjMaYlXUJ5qdfLOPgRu+OC8nsYyHvnKExpgBqY8dpRl27x
         eMj9jSr7xPzPL3huS2BZZLy/7tC9T1VKUNo1tHU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 063/381] selinux: fix Makefile dependencies of flask.h
Date:   Mon, 15 May 2023 18:25:14 +0200
Message-Id: <20230515161739.669855193@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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
index 4d8e0e8adf0b1..47e4aba3a868d 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -21,8 +21,8 @@ ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include
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



