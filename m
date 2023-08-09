Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444B277597F
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjHILBE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjHILBD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:01:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B93ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:01:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5F2A619FA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B448BC433C8;
        Wed,  9 Aug 2023 11:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578862;
        bh=Ik+ghPQqkPSmjaiWevm6ZqF0nzHDk4Xm0ex2O5u8ZzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N1aFOi2+V/NGF4XXBUfIb238K5Sryw8f7TipDmU10ZZ+HukDYkkvdRP3Vl60t2LIV
         mxK3+yWw0kSX+CE8fPbXALROTGbxUi2ORFT3qRDuVf88XAqZRZFnmqHP3ZL8h6Z6lg
         CGRh1bOFIMLgYNoGTTsOYv3KCXaGdbd0uk1a6xnQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Kelley <mikelley@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.15 55/92] scsi: storvsc: Limit max_sectors for virtual Fibre Channel devices
Date:   Wed,  9 Aug 2023 12:41:31 +0200
Message-ID: <20230809103635.515666805@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
References: <20230809103633.485906560@linuxfoundation.org>
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

From: Michael Kelley <mikelley@microsoft.com>

commit 010c1e1c5741365dbbf44a5a5bb9f30192875c4c upstream.

The Hyper-V host is queried to get the max transfer size that it supports,
and this value is used to set max_sectors for the synthetic SCSI
controller.  However, this max transfer size may be too large for virtual
Fibre Channel devices, which are limited to 512 Kbytes.  If a larger
transfer size is used with a vFC device, Hyper-V always returns an error,
and storvsc logs a message like this where the SRB status and SCSI status
are both zero:

hv_storvsc <GUID>: tag#197 cmd 0x8a status: scsi 0x0 srb 0x0 hv 0xc0000001

Add logic to limit the max transfer size to 512 Kbytes for vFC devices.

Fixes: 1d3e0980782f ("scsi: storvsc: Correct reporting of Hyper-V I/O size limits")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/1689887102-32806-1-git-send-email-mikelley@microsoft.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/storvsc_drv.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -406,6 +406,7 @@ static void storvsc_on_channel_callback(
 #define STORVSC_FC_MAX_LUNS_PER_TARGET			255
 #define STORVSC_FC_MAX_TARGETS				128
 #define STORVSC_FC_MAX_CHANNELS				8
+#define STORVSC_FC_MAX_XFER_SIZE			((u32)(512 * 1024))
 
 #define STORVSC_IDE_MAX_LUNS_PER_TARGET			64
 #define STORVSC_IDE_MAX_TARGETS				1
@@ -2071,6 +2072,9 @@ static int storvsc_probe(struct hv_devic
 	 * protecting it from any weird value.
 	 */
 	max_xfer_bytes = round_down(stor_device->max_transfer_bytes, HV_HYP_PAGE_SIZE);
+	if (is_fc)
+		max_xfer_bytes = min(max_xfer_bytes, STORVSC_FC_MAX_XFER_SIZE);
+
 	/* max_hw_sectors_kb */
 	host->max_sectors = max_xfer_bytes >> 9;
 	/*


