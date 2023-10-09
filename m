Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7547BDFB4
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377120AbjJINdA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377110AbjJINc7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:32:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFFF99
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:32:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93414C433C8;
        Mon,  9 Oct 2023 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858376;
        bh=98WYEotrShHKQDF3YJ6QVtOwQ/SKMYg+s7UPKoQutWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fTSAyMcDmu6k9ie64TxbtR5CfTlnzEvcoddMUTGRSOnPKFlyB2Hqq1J8Kj/2k6smc
         /wzgqdhDZdEC/dOO404R1fhIhPaDuHzPUkMSsNTaIPNjqnSnlklWjTGAiA20syhtye
         x8AJOh45qJilI6iu/IagdEPayWUfcMak0T+6trxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 5.4 076/131] ata: libata-scsi: ignore reserved bits for REPORT SUPPORTED OPERATION CODES
Date:   Mon,  9 Oct 2023 15:01:56 +0200
Message-ID: <20231009130118.646899094@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <niklas.cassel@wdc.com>

commit 3ef600923521616ebe192c893468ad0424de2afb upstream.

For REPORT SUPPORTED OPERATION CODES command, the service action field is
defined as bits 0-4 in the second byte in the CDB. Bits 5-7 in the second
byte are reserved.

Only look at the service action field in the second byte when determining
if the MAINTENANCE IN opcode is a REPORT SUPPORTED OPERATION CODES command.

This matches how we only look at the service action field in the second
byte when determining if the SERVICE ACTION IN(16) opcode is a READ
CAPACITY(16) command (reserved bits 5-7 in the second byte are ignored).

Fixes: 7b2030942859 ("libata: Add support for SCT Write Same")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-scsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4544,7 +4544,7 @@ void ata_scsi_simulate(struct ata_device
 		break;
 
 	case MAINTENANCE_IN:
-		if (scsicmd[1] == MI_REPORT_SUPPORTED_OPERATION_CODES)
+		if ((scsicmd[1] & 0x1f) == MI_REPORT_SUPPORTED_OPERATION_CODES)
 			ata_scsi_rbuf_fill(&args, ata_scsiop_maint_in);
 		else
 			ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);


