Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC59761755
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjGYLrU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjGYLrN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:47:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA2E1FC4
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:47:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38E5061654
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4888EC433C7;
        Tue, 25 Jul 2023 11:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285623;
        bh=qL9Uyi9pDKrhsv0aiOU4si2VGrBEwrbmoVX1Pq1w2/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aBRUaLPdCkQ2kQMA8LXBQS727jW6/l090kxOn2kNmFB0M+vhNo3vO2xhVLD6AVn5R
         DczqSaxLHHm9zoGtiGpxJjLBwKXFpJ6b9CSHZrUfQLy+Wnin02ImZB1P6nVDi6HCzE
         ipsX4Ng0eKjgLV+QYgy7aMeJbwQAf28EHfqcipUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.4 271/313] scsi: qla2xxx: Check valid rport returned by fc_bsg_to_rport()
Date:   Tue, 25 Jul 2023 12:47:04 +0200
Message-ID: <20230725104532.790789256@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
@@ -259,6 +259,10 @@ qla2x00_process_els(struct bsg_job *bsg_
 
 	if (bsg_request->msgcode == FC_BSG_RPT_ELS) {
 		rport = fc_bsg_to_rport(bsg_job);
+		if (!rport) {
+			rval = -ENOMEM;
+			goto done;
+		}
 		fcport = *(fc_port_t **) rport->dd_data;
 		host = rport_to_shost(rport);
 		vha = shost_priv(host);


