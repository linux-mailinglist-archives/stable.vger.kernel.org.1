Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC6975D4EB
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjGUT02 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGUT02 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:26:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6612C35AB
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:26:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0563F61D6D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16875C433C8;
        Fri, 21 Jul 2023 19:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967577;
        bh=XvClX4yZTvnZ9ZOLA6zltWsGWlPvEwqF3CPqWjyqBqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y0PZVqCbW1v9J8J4NWFrHAiwoiW1VghonSIcS5vnmzve09OYqJbNy8YoDTi/lRIQm
         Uor3ZKlr9hjX5iZn5MMhQO0mXHSUF+SoO7+sFFAPpw2Lo/lHVgUkTOc39LttL7sCUL
         9y8ckXwGHk0r+d4cRkG0ECg0L5sSGaJODGvAuwOo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 212/223] scsi: qla2xxx: Avoid fcport pointer dereference
Date:   Fri, 21 Jul 2023 18:07:45 +0200
Message-ID: <20230721160529.910035184@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nilesh Javali <njavali@marvell.com>

commit 6b504d06976fe4a61cc05dedc68b84fadb397f77 upstream.

Klocwork reported warning of NULL pointer may be dereferenced.  The routine
exits when sa_ctl is NULL and fcport is allocated after the exit call thus
causing NULL fcport pointer to dereference at the time of exit.

To avoid fcport pointer dereference, exit the routine when sa_ctl is NULL.

Cc: stable@vger.kernel.org
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230607113843.37185-4-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_edif.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -2319,8 +2319,8 @@ qla24xx_issue_sa_replace_iocb(scsi_qla_h
 	if (!sa_ctl) {
 		ql_dbg(ql_dbg_edif, vha, 0x70e6,
 		    "sa_ctl allocation failed\n");
-		rval =  -ENOMEM;
-		goto done;
+		rval = -ENOMEM;
+		return rval;
 	}
 
 	fcport = sa_ctl->fcport;


