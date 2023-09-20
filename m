Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E487A7B74
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbjITLwU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbjITLwT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:52:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA82B9
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:52:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDB0C433C9;
        Wed, 20 Sep 2023 11:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210733;
        bh=RQDNqqSPjEVrWVypEfmLuk/PPxk6jNcR82KJyH6h8gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NMSjSK9L1CxpcGwGHCS2NGAyoDyCIGM3bdjo9GZ61bzLGT+MRSzCMa0KXMjaJATcp
         75WT/nZkR7BypCkX2YDbXBKYF3uhgL+Qro22P2kwtoMpFA1hZm7et/Df8V+i5LMcwN
         jpLP/WV1E0FNJ5dTQuSJ3oAXdqJe5Dcdk762o1t4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 159/211] ata: libata-core: fetch sense data for successful commands iff CDL enabled
Date:   Wed, 20 Sep 2023 13:30:03 +0200
Message-ID: <20230920112850.812529282@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <niklas.cassel@wdc.com>

[ Upstream commit 5e35a9ac3fe3a0d571b899a16ca84253e53dc70c ]

Currently, we fetch sense data for a _successful_ command if either:
1) Command was NCQ and ATA_DFLAG_CDL_ENABLED flag set (flag
   ATA_DFLAG_CDL_ENABLED will only be set if the Successful NCQ command
   sense data supported bit is set); or
2) Command was non-NCQ and regular sense data reporting is enabled.

This means that case 2) will trigger for a non-NCQ command which has
ATA_SENSE bit set, regardless if CDL is enabled or not.

This decision was by design. If the device reports that it has sense data
available, it makes sense to fetch that sense data, since the sk/asc/ascq
could be important information regardless if CDL is enabled or not.

However, the fetching of sense data for a successful command is done via
ATA EH. Considering how intricate the ATA EH is, we really do not want to
invoke ATA EH unless absolutely needed.

Before commit 18bd7718b5c4 ("scsi: ata: libata: Handle completion of CDL
commands using policy 0xD") we never fetched sense data for successful
commands.

In order to not invoke the ATA EH unless absolutely necessary, even if the
device claims support for sense data reporting, only fetch sense data for
successful (NCQ and non-NCQ commands) commands that are using CDL.

[Damien] Modified the check to test the qc flag ATA_QCFLAG_HAS_CDL
instead of the device support for CDL, which is implied for commands
using CDL.

Fixes: 3ac873c76d79 ("ata: libata-core: fix when to fetch sense data for successful commands")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c7a29c3ac6701..291e128f4d2b4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4919,11 +4919,8 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 	 * been aborted by the device due to a limit timeout using the policy
 	 * 0xD. For these commands, invoke EH to get the command sense data.
 	 */
-	if (qc->result_tf.status & ATA_SENSE &&
-	    ((ata_is_ncq(qc->tf.protocol) &&
-	      dev->flags & ATA_DFLAG_CDL_ENABLED) ||
-	     (!ata_is_ncq(qc->tf.protocol) &&
-	      ata_id_sense_reporting_enabled(dev->id)))) {
+	if (qc->flags & ATA_QCFLAG_HAS_CDL &&
+	    qc->result_tf.status & ATA_SENSE) {
 		/*
 		 * Tell SCSI EH to not overwrite scmd->result even if this
 		 * command is finished with result SAM_STAT_GOOD.
-- 
2.40.1



