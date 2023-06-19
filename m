Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE86735306
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjFSKlK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjFSKk2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:40:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA8FE76
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:40:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1A6C60B0D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5454C433C9;
        Mon, 19 Jun 2023 10:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171227;
        bh=2+N8B/NQLrP9utTMbxYa1LUZDM4rvFGPlMdOGNjBeXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vUlV6P8MZSI/C8I0hayBg/ZmV2NXtYVGZzYaxzrHvnyAB9woqq8AldSOdIyQ9IDii
         BXapYAvX4MRlukLq88UgNcdkE0S6Yhff7RgXgYUaDLCfNwMJS7Q6yb6Jjj7WWEfmIF
         zl1qixMX/G0Co8MY54BKP4OXPTjIBlIXcdC2kFZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bob Pearson <rpearsonhpe@gmail.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.3 186/187] scsi: target: core: Fix error path in target_setup_session()
Date:   Mon, 19 Jun 2023 12:30:04 +0200
Message-ID: <20230619102206.721818607@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Bob Pearson <rpearsonhpe@gmail.com>

commit 91271699228bfc66f1bc8abc0327169dc156d854 upstream.

In the error exits in target_setup_session(), if a branch is taken to
free_sess: transport_free_session() may call to target_free_cmd_counter()
and then fall through to call target_free_cmd_counter() a second time.
This can, and does, sometimes cause seg faults since the data field in
cmd_cnt->refcnt has been freed in the first call.

Fix this problem by simply returning after the call to
transport_free_session(). The second call is redundant for those cases.

Fixes: 4edba7e4a8f3 ("scsi: target: Move cmd counter allocation")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
Link: https://lore.kernel.org/r/20230613144259.12890-1-rpearsonhpe@gmail.com
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/target/target_core_transport.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -504,6 +504,8 @@ target_setup_session(struct se_portal_gr
 
 free_sess:
 	transport_free_session(sess);
+	return ERR_PTR(rc);
+
 free_cnt:
 	target_free_cmd_counter(cmd_cnt);
 	return ERR_PTR(rc);


