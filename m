Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD97775A4B
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjHILHJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjHILHI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:07:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD71ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:07:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A026D63142
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B326BC433C8;
        Wed,  9 Aug 2023 11:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579227;
        bh=FjGM2ycg/tW4fkppafv/UKDkOgWU6Dbnpk12aaQfOzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=briHEWC/cvLVL9aN5drV6c3iDNb3B6RjlmP3zS/6VB63VKEDrHUlL7YqjyU7pU2Qj
         HbsXDOBMxtnDOY3UQUvxadCriyXr4fri2z3R1/kdh6VhRjb4Ft+IfuR6lmLDJpG8bq
         AQSj/bbrNgGDLjBJtXbypXN36oOmcWnJitKQlW24=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 121/204] scsi: qla2xxx: Check valid rport returned by fc_bsg_to_rport()
Date:   Wed,  9 Aug 2023 12:40:59 +0200
Message-ID: <20230809103646.660264403@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nilesh Javali <njavali@marvell.com>

commit af73f23a27206ffb3c477cac75b5fcf03410556e upstream.

Klocwork reported warning of rport maybe NULL and will be dereferenced.
rport returned by call to fc_bsg_to_rport() could be NULL and dereferenced.

Check valid rport returned by fc_bsg_to_rport().

Cc: stable@vger.kernel.org
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230607113843.37185-5-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_bsg.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -264,6 +264,10 @@ qla2x00_process_els(struct bsg_job *bsg_
 
 	if (bsg_request->msgcode == FC_BSG_RPT_ELS) {
 		rport = fc_bsg_to_rport(bsg_job);
+		if (!rport) {
+			rval = -ENOMEM;
+			goto done;
+		}
 		fcport = *(fc_port_t **) rport->dd_data;
 		host = rport_to_shost(rport);
 		vha = shost_priv(host);


