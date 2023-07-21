Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB6F75D4F3
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjGUT0t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjGUT0p (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:26:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A962930E8
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:26:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8003B61D93
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9336BC433C8;
        Fri, 21 Jul 2023 19:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967588;
        bh=oN5+X/9Q60ifzLMZjrIgB/HOVDXrf08kbB6elr+7td0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cW45ymxM4Q0xjVdbuaSAo+Q0G8kkwQlCYjN4igpzr1Dr6IM/d1GXzArRlBRlCiNQU
         9BuxoDzJC6WgUk74OA+ahpV0QKyKrBi/FQXBEqZrwLanpDm3ssUzJE54LEtEIP619C
         s0R6dMNlYa7jG67lFnQlbL5HfMuCFMlQ544djkZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bikash Hazarika <bhazarika@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 216/223] scsi: qla2xxx: Correct the index of array
Date:   Fri, 21 Jul 2023 18:07:49 +0200
Message-ID: <20230721160530.082515731@linuxfoundation.org>
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

From: Bikash Hazarika <bhazarika@marvell.com>

commit b1b9d3825df4c757d653d0b1df66f084835db9c3 upstream.

Klocwork reported array 'port_dstate_str' of size 10 may use index value(s)
10..15.

Add a fix to correct the index of array.

Cc: stable@vger.kernel.org
Signed-off-by: Bikash Hazarika <bhazarika@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230607113843.37185-8-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_inline.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -109,11 +109,13 @@ qla2x00_set_fcport_disc_state(fc_port_t
 {
 	int old_val;
 	uint8_t shiftbits, mask;
+	uint8_t port_dstate_str_sz;
 
 	/* This will have to change when the max no. of states > 16 */
 	shiftbits = 4;
 	mask = (1 << shiftbits) - 1;
 
+	port_dstate_str_sz = sizeof(port_dstate_str) / sizeof(char *);
 	fcport->disc_state = state;
 	while (1) {
 		old_val = atomic_read(&fcport->shadow_disc_state);
@@ -121,7 +123,8 @@ qla2x00_set_fcport_disc_state(fc_port_t
 		    old_val, (old_val << shiftbits) | state)) {
 			ql_dbg(ql_dbg_disc, fcport->vha, 0x2134,
 			    "FCPort %8phC disc_state transition: %s to %s - portid=%06x.\n",
-			    fcport->port_name, port_dstate_str[old_val & mask],
+			    fcport->port_name, (old_val & mask) < port_dstate_str_sz ?
+				    port_dstate_str[old_val & mask] : "Unknown",
 			    port_dstate_str[state], fcport->d_id.b24);
 			return;
 		}


