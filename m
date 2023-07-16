Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B64755410
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjGPU0K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjGPU0J (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:26:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910019F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:26:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E26D60EBC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D197C433C7;
        Sun, 16 Jul 2023 20:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539167;
        bh=C3OA2v5ud/ha42/sFE14w66+xvXvrDJs91j5mmfy5UI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2UEL/jrcKExd+HNz6nyXDxA1t0owxHtvSm/88lbkT/JGUhjxJgzrLkk75acFqzFTE
         STfLSPAjF7oQxlOqm0tw4bPrmxy7L8T5Wva3nZ+36aWQ/DA6n45DJHTqYD4YD8Ml4m
         vOqYkKhhB+sisE1abE9cUz3Hgz4rOQNljehpelL4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 711/800] apparmor: add missing failure check in compute_xmatch_perms
Date:   Sun, 16 Jul 2023 21:49:24 +0200
Message-ID: <20230716195005.634126215@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: John Johansen <john.johansen@canonical.com>

[ Upstream commit 6600e9f692e36e265ef0828f08337fa294bb330f ]

Add check for failure to allocate the permission table.

Fixes: caa9f579ca72 ("apparmor: isolate policy backwards compatibility to its own file")
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/policy_compat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/apparmor/policy_compat.c b/security/apparmor/policy_compat.c
index cc89d1e88fb74..6fa185ce8d9dc 100644
--- a/security/apparmor/policy_compat.c
+++ b/security/apparmor/policy_compat.c
@@ -179,6 +179,8 @@ static struct aa_perms *compute_xmatch_perms(struct aa_dfa *xmatch)
 	state_count = xmatch->tables[YYTD_ID_BASE]->td_lolen;
 	/* DFAs are restricted from having a state_count of less than 2 */
 	perms = kvcalloc(state_count, sizeof(struct aa_perms), GFP_KERNEL);
+	if (!perms)
+		return NULL;
 
 	/* zero init so skip the trap state (state == 0) */
 	for (state = 1; state < state_count; state++)
-- 
2.39.2



