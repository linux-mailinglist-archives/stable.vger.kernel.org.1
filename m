Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE15974C381
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjGILdM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjGILdI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:33:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B3318C
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F05F060BA4
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F27C433C8;
        Sun,  9 Jul 2023 11:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902386;
        bh=ZsuUWhs1D+Fz7NKBk20knsSasGiYPfyNUp1SJ18t6m8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O6kIuVB1EONEDhLeMyOMCoUfwQHl11dlWfUclHivCRgAAg3h9Yw0as1FUH6pdyqZA
         VbIVfthNpFSJddVCl8Co7ARmo6bS3TherwmZjUEW0pwmj955gkFHadKRda5KA/OuYI
         AVWklaWUSrTakawmLFp2nCdTQr1FJuMUlyuoiM70=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Justin Tee <justin.tee@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 357/431] scsi: lpfc: Revise NPIV ELS unsol rcv cmpl logic to drop ndlp based on nlp_state
Date:   Sun,  9 Jul 2023 13:15:05 +0200
Message-ID: <20230709111459.534506593@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit 9914a3d033d3e1d836a43e93e9738e7dd44a096a ]

When NPIV ports are zoned to devices that support both initiator and target
mode, a remote device's initiated PRLI results in unintended final kref
clean up of the device's ndlp structure.  This disrupts NPIV ports'
discovery for target devices that support both initiator and target mode.

Modify the NPIV lpfc_drop_node clause such that we allow the ndlp to live
so long as it was in NLP_STE_PLOGI_ISSUE, NLP_STE_REG_LOGIN_ISSUE, or
NLP_STE_PRLI_ISSUE nlp_state.  This allows lpfc's issued PRLI completion
routine to determine if the final kref clean up should execute rather than
a remote device's issued PRLI.

Fixes: db651ec22524 ("scsi: lpfc: Correct used_rpi count when devloss tmo fires with no recovery")
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20230523183206.7728-5-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_els.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 62d2ca688cd14..e07242ac0f014 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -5466,9 +5466,19 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 				ndlp->nlp_flag &= ~NLP_RELEASE_RPI;
 				spin_unlock_irq(&ndlp->lock);
 			}
+			lpfc_drop_node(vport, ndlp);
+		} else if (ndlp->nlp_state != NLP_STE_PLOGI_ISSUE &&
+			   ndlp->nlp_state != NLP_STE_REG_LOGIN_ISSUE &&
+			   ndlp->nlp_state != NLP_STE_PRLI_ISSUE) {
+			/* Drop ndlp if there is no planned or outstanding
+			 * issued PRLI.
+			 *
+			 * In cases when the ndlp is acting as both an initiator
+			 * and target function, let our issued PRLI determine
+			 * the final ndlp kref drop.
+			 */
+			lpfc_drop_node(vport, ndlp);
 		}
-
-		lpfc_drop_node(vport, ndlp);
 	}
 
 	/* Release the originating I/O reference. */
-- 
2.39.2



