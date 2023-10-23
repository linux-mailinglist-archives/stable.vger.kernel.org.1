Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD097D30D4
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjJWLCi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjJWLCi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:02:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6508ED7A
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:02:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5533C433CA;
        Mon, 23 Oct 2023 11:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698058956;
        bh=ZOhgvJVu0PGo5kOKyrE05QFkRozauQS0Hus/lBAXsNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2PQMrZmQDPed9q3/QpXbQTVCVxHn+A1yQo893vE8Vw3t7a8uAtrSejlgSCMIaQ6MG
         tvawwCZaoezpQWyxX16VH9HcNk4R4AHdTDl+P9OJhyEoS6dtMByH7nHT5oEaQIOLD9
         JUrVy/V0zLftmLFyrhkDiat5CvfWpgcn0TSqQ+FU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tom Dohrmann <erbse.13@gmx.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, stable@kernel.org
Subject: [PATCH 6.5 016/241] x86/sev: Disable MMIO emulation from user mode
Date:   Mon, 23 Oct 2023 12:53:22 +0200
Message-ID: <20231023104834.311154880@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Upstream commit: a37cd2a59d0cb270b1bba568fd3a3b8668b9d3ba

A virt scenario can be constructed where MMIO memory can be user memory.
When that happens, a race condition opens between when the hardware
raises the #VC and when the #VC handler gets to emulate the instruction.

If the MOVS is replaced with a MOVS accessing kernel memory in that
small race window, then write to kernel memory happens as the access
checks are not done at emulation time.

Disable MMIO emulation in user mode temporarily until a sensible use
case appears and justifies properly handling the race window.

Fixes: 0118b604c2c9 ("x86/sev-es: Handle MMIO String Instructions")
Reported-by: Tom Dohrmann <erbse.13@gmx.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Tom Dohrmann <erbse.13@gmx.de>
Cc: <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/sev.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1508,6 +1508,9 @@ static enum es_result vc_handle_mmio(str
 			return ES_DECODE_FAILED;
 	}
 
+	if (user_mode(ctxt->regs))
+		return ES_UNSUPPORTED;
+
 	switch (mmio) {
 	case INSN_MMIO_WRITE:
 		memcpy(ghcb->shared_buffer, reg_data, bytes);


