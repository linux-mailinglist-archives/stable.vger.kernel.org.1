Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC8A73E855
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjFZSYW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjFZSYE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:24:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2F710D5
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:23:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB1B660F70
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FB8C433C8;
        Mon, 26 Jun 2023 18:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803732;
        bh=xFBDtI0eJXV50Of5xfPsY4FxA5omc/+439vJ3gAfG+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/uJColqYS/gUy2ezpXql+G3yQ2XaiXGEMAP9VGl8tNoFssApOLqdhiznJl5llBn9
         GfXSP4vI3DZLZAbPqBdy3CXBI8dYr10zMoQyKrs+/ggkOAme8up9UbQ2x7H4J/r3lj
         /kXxJXbjtJ7LMeiqo58hrvQbT388mSmmzPVSW3nQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maurizio Lombardi <mlombard@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 151/199] scsi: target: iscsi: Remove unused transport_timer
Date:   Mon, 26 Jun 2023 20:10:57 +0200
Message-ID: <20230626180812.247257311@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 98a8c2bf938a5973716f280da618077a3d255976 ]

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Link: https://lore.kernel.org/r/20230508162219.1731964-3-mlombard@redhat.com
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/target/iscsi/iscsi_target_core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
index 42f4a4c0c1003..4c15420e8965d 100644
--- a/include/target/iscsi/iscsi_target_core.h
+++ b/include/target/iscsi/iscsi_target_core.h
@@ -568,7 +568,6 @@ struct iscsit_conn {
 	struct iscsi_login	*login;
 	struct timer_list	nopin_timer;
 	struct timer_list	nopin_response_timer;
-	struct timer_list	transport_timer;
 	struct timer_list	login_timer;
 	struct task_struct	*login_kworker;
 	/* Spinlock used for add/deleting cmd's from conn_cmd_list */
-- 
2.39.2



