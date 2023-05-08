Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45176FA6E4
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbjEHKZV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbjEHKY5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:24:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7367825276
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:24:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04134625BB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E582AC433EF;
        Mon,  8 May 2023 10:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541465;
        bh=AIEDbdtkdwfgnxXgObbj/Xfv0A+aP9sTc29GPKhmA2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qWgu+SMXf9/LopWa2sd9BSyuU5L/epZkTY0I3fqdaX6OWp7GNF5BOzAgjfGB/0Lai
         /H9dox2erXeqhVvGWG8lIvCj+Diziq+oyx0MmHr0ld1sPhl4Nn3FnTVftzG++1ihxh
         lUhZW6QXQFQ/Rk56swBSX8n2qBRsqE1zugj1rIU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 123/663] selinux: ensure av_permissions.h is built when needed
Date:   Mon,  8 May 2023 11:39:09 +0200
Message-Id: <20230508094432.515133060@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paul Moore <paul@paul-moore.com>

[ Upstream commit 4ce1f694eb5d8ca607fed8542d32a33b4f1217a5 ]

The Makefile rule responsible for building flask.h and
av_permissions.h only lists flask.h as a target which means that
av_permissions.h is only generated when flask.h needs to be
generated.  This patch fixes this by adding av_permissions.h as a
target to the rule.

Fixes: 8753f6bec352 ("selinux: generate flask headers during kernel build")
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 103c2776478a7..0aecf9334ec31 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -26,5 +26,5 @@ quiet_cmd_flask = GEN     $(obj)/flask.h $(obj)/av_permissions.h
       cmd_flask = $< $(obj)/flask.h $(obj)/av_permissions.h
 
 targets += flask.h av_permissions.h
-$(obj)/flask.h: scripts/selinux/genheaders/genheaders FORCE
+$(obj)/flask.h $(obj)/av_permissions.h &: scripts/selinux/genheaders/genheaders FORCE
 	$(call if_changed,flask)
-- 
2.39.2



