Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718446FA626
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbjEHKQu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbjEHKQr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:16:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709E84BBEC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:16:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE488624B3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084E0C433EF;
        Mon,  8 May 2023 10:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541003;
        bh=CyDBFum3k5fhB7xdBpF7gOzL+cnwZel4DnTNzYYhLtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UNoz/adfi3UIxKyyslmBzZITThCaBmAGptUwYkYIecuN18Qfli/xnDsgQkGVnpNk6
         c5SsmwvcnTxMD9SwxjdOCZikWSviBNKpAYyOB/pJv2RmYj/kbPF34B4A5/opoHGNfE
         eGQYiZHCbyWKt3RYP/LdlcEKGbPKth04gQF61yH4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tanmay Shah <tanmay.shah@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 6.1 579/611] mailbox: zynqmp: Fix typo in IPI documentation
Date:   Mon,  8 May 2023 11:47:01 +0200
Message-Id: <20230508094440.754891220@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Tanmay Shah <tanmay.shah@amd.com>

commit 79963fbfc233759bd8a43462f120d15a1bd4f4fa upstream.

Xilinx IPI message buffers allows 32-byte data transfer.
Fix documentation that says 12 bytes

Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
Acked-by: Michal Simek <michal.simek@amd.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230311012407.1292118-4-tanmay.shah@amd.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mailbox/zynqmp-ipi-message.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/mailbox/zynqmp-ipi-message.h
+++ b/include/linux/mailbox/zynqmp-ipi-message.h
@@ -9,7 +9,7 @@
  * @data: message payload
  *
  * This is the structure for data used in mbox_send_message
- * the maximum length of data buffer is fixed to 12 bytes.
+ * the maximum length of data buffer is fixed to 32 bytes.
  * Client is supposed to be aware of this.
  */
 struct zynqmp_ipi_message {


