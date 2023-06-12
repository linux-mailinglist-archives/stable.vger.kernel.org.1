Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9194372C217
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbjFLLCx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbjFLLC0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:02:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339E876B1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:49:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD7E1623BC
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FF4C433D2;
        Mon, 12 Jun 2023 10:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566990;
        bh=dQ2FT+5UmXPz7aW+luSJFq+Z7G6ZvtC49l14U58xbQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l85UNikBXaHo61a2oOq8714b7h8Y3KVdVpGOnaK75XNakKarfHCnWeeEWzoc4ax9M
         n1XVbl8IMMPfh1fuPcLhCYF0wCUk0uxZtkAt8QFlRN7fxbrtYdBIX+Ria9mWhnkzZM
         WbSAOxAT7d5oW2LKWkvIdnhC1qdFeilSkVqFmuDY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sourabh Das <sourabh.das@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 6.3 108/160] tee: amdtee: Add return_origin to struct tee_cmd_load_ta
Date:   Mon, 12 Jun 2023 12:27:20 +0200
Message-ID: <20230612101719.977144271@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rijo Thomas <Rijo-john.Thomas@amd.com>

commit 436eeae0411acdfc54521ddea80ee76d4ae8a7ea upstream.

After TEE has completed processing of TEE_CMD_ID_LOAD_TA, set proper
value in 'return_origin' argument passed by open_session() call. To do
so, add 'return_origin' field to the structure tee_cmd_load_ta. The
Trusted OS shall update return_origin as part of TEE processing.

This change to 'struct tee_cmd_load_ta' interface requires a similar update
in AMD-TEE Trusted OS's TEE_CMD_ID_LOAD_TA interface.

This patch has been verified on Phoenix Birman setup. On older APUs,
return_origin value will be 0.

Cc: stable@vger.kernel.org
Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
Tested-by: Sourabh Das <sourabh.das@amd.com>
Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tee/amdtee/amdtee_if.h |   10 ++++++----
 drivers/tee/amdtee/call.c      |   28 ++++++++++++++++------------
 2 files changed, 22 insertions(+), 16 deletions(-)

--- a/drivers/tee/amdtee/amdtee_if.h
+++ b/drivers/tee/amdtee/amdtee_if.h
@@ -118,16 +118,18 @@ struct tee_cmd_unmap_shared_mem {
 
 /**
  * struct tee_cmd_load_ta - load Trusted Application (TA) binary into TEE
- * @low_addr:    [in] bits [31:0] of the physical address of the TA binary
- * @hi_addr:     [in] bits [63:32] of the physical address of the TA binary
- * @size:        [in] size of TA binary in bytes
- * @ta_handle:   [out] return handle of the loaded TA
+ * @low_addr:       [in] bits [31:0] of the physical address of the TA binary
+ * @hi_addr:        [in] bits [63:32] of the physical address of the TA binary
+ * @size:           [in] size of TA binary in bytes
+ * @ta_handle:      [out] return handle of the loaded TA
+ * @return_origin:  [out] origin of return code after TEE processing
  */
 struct tee_cmd_load_ta {
 	u32 low_addr;
 	u32 hi_addr;
 	u32 size;
 	u32 ta_handle;
+	u32 return_origin;
 };
 
 /**
--- a/drivers/tee/amdtee/call.c
+++ b/drivers/tee/amdtee/call.c
@@ -423,19 +423,23 @@ int handle_load_ta(void *data, u32 size,
 	if (ret) {
 		arg->ret_origin = TEEC_ORIGIN_COMMS;
 		arg->ret = TEEC_ERROR_COMMUNICATION;
-	} else if (arg->ret == TEEC_SUCCESS) {
-		ret = get_ta_refcount(load_cmd.ta_handle);
-		if (!ret) {
-			arg->ret_origin = TEEC_ORIGIN_COMMS;
-			arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
+	} else {
+		arg->ret_origin = load_cmd.return_origin;
 
-			/* Unload the TA on error */
-			unload_cmd.ta_handle = load_cmd.ta_handle;
-			psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
-					    (void *)&unload_cmd,
-					    sizeof(unload_cmd), &ret);
-		} else {
-			set_session_id(load_cmd.ta_handle, 0, &arg->session);
+		if (arg->ret == TEEC_SUCCESS) {
+			ret = get_ta_refcount(load_cmd.ta_handle);
+			if (!ret) {
+				arg->ret_origin = TEEC_ORIGIN_COMMS;
+				arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
+
+				/* Unload the TA on error */
+				unload_cmd.ta_handle = load_cmd.ta_handle;
+				psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
+						    (void *)&unload_cmd,
+						    sizeof(unload_cmd), &ret);
+			} else {
+				set_session_id(load_cmd.ta_handle, 0, &arg->session);
+			}
 		}
 	}
 	mutex_unlock(&ta_refcount_mutex);


