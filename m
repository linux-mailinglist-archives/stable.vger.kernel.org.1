Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E1A703312
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbjEOQcu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242662AbjEOQcs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:32:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC92C10C3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:32:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D71F62769
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F03EC4339C;
        Mon, 15 May 2023 16:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168363;
        bh=UGgqEjEj8efqEMywn/MDqgyqgronnWtnQ7Lhoz27O1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=olMTozFpcSRMP8Dfbl1CPx636WHvBIVXiUU66ykgg46+KR/KSvkxYHlfR1zNEBibF
         gLQFfSyIExtvraSNHokBYGesKzx/Kl1chbSGmRmcB7tkgKIWSDHpC2Q7m5FU/p0sdG
         /JfCw110CXACXxA6ohIQZDquqjcf40OL1Wf34SHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Fabio Estevam <festevam@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 4.14 005/116] IMA: allow/fix UML builds
Date:   Mon, 15 May 2023 18:25:02 +0200
Message-Id: <20230515161658.433624318@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
References: <20230515161658.228491273@linuxfoundation.org>
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

From: Randy Dunlap <rdunlap@infradead.org>

commit 644f17412f5acf01a19af9d04a921937a2bc86c6 upstream.

UML supports HAS_IOMEM since 0bbadafdc49d (um: allow disabling
NO_IOMEM).

Current IMA build on UML fails on allmodconfig (with TCG_TPM=m):

ld: security/integrity/ima/ima_queue.o: in function `ima_add_template_entry':
ima_queue.c:(.text+0x2d9): undefined reference to `tpm_pcr_extend'
ld: security/integrity/ima/ima_init.o: in function `ima_init':
ima_init.c:(.init.text+0x43f): undefined reference to `tpm_default_chip'
ld: security/integrity/ima/ima_crypto.o: in function `ima_calc_boot_aggregate_tfm':
ima_crypto.c:(.text+0x1044): undefined reference to `tpm_pcr_read'
ld: ima_crypto.c:(.text+0x10d8): undefined reference to `tpm_pcr_read'

Modify the IMA Kconfig entry so that it selects TCG_TPM if HAS_IOMEM
is set, regardless of the UML Kconfig setting.
This updates TCG_TPM from =m to =y and fixes the linker errors.

Fixes: f4a0391dfa91 ("ima: fix Kconfig dependencies")
Cc: Stable <stable@vger.kernel.org> # v5.14+
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/integrity/ima/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -8,7 +8,7 @@ config IMA
 	select CRYPTO_MD5
 	select CRYPTO_SHA1
 	select CRYPTO_HASH_INFO
-	select TCG_TPM if HAS_IOMEM && !UML
+	select TCG_TPM if HAS_IOMEM
 	select TCG_TIS if TCG_TPM && X86
 	select TCG_CRB if TCG_TPM && ACPI
 	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES


