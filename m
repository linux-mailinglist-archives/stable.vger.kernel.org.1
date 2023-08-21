Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25917832E7
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjHUUFP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjHUUFO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:05:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E09DE4
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:05:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 260B264911
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F260C433C7;
        Mon, 21 Aug 2023 20:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648312;
        bh=zT1pPN4NJ8eIRdh8stujh7UAwsJZjQzDnUMUzKePI2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jTQI1eH9fqKN2HcslNxlIy+rfcrdktmil9S+9nzqGJ6u57q+GUAR1Rs39QRXOu/8F
         UzLI93zfWvgbjoZqPkRfjUTGljumTOcjcyMIcmvbVUXxNlAIdh1IaxqlF26unJXZnv
         XUbMHhEu554AV0XE1D+gPUy4S7g5WiRs+7KAVRCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.4 123/234] x86/srso: Explain the untraining sequences a bit more
Date:   Mon, 21 Aug 2023 21:41:26 +0200
Message-ID: <20230821194134.259712546@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Borislav Petkov (AMD) <bp@alien8.de>

commit 9dbd23e42ff0b10c9b02c9e649c76e5228241a8e upstream.

The goal is to eventually have a proper documentation about all this.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230814164447.GFZNpZ/64H4lENIe94@fat_crate.local
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/lib/retpoline.S |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -187,6 +187,25 @@ SYM_CODE_START(srso_alias_return_thunk)
 SYM_CODE_END(srso_alias_return_thunk)
 
 /*
+ * Some generic notes on the untraining sequences:
+ *
+ * They are interchangeable when it comes to flushing potentially wrong
+ * RET predictions from the BTB.
+ *
+ * The SRSO Zen1/2 (MOVABS) untraining sequence is longer than the
+ * Retbleed sequence because the return sequence done there
+ * (srso_safe_ret()) is longer and the return sequence must fully nest
+ * (end before) the untraining sequence. Therefore, the untraining
+ * sequence must fully overlap the return sequence.
+ *
+ * Regarding alignment - the instructions which need to be untrained,
+ * must all start at a cacheline boundary for Zen1/2 generations. That
+ * is, instruction sequences starting at srso_safe_ret() and
+ * the respective instruction sequences at retbleed_return_thunk()
+ * must start at a cacheline boundary.
+ */
+
+/*
  * Safety details here pertain to the AMD Zen{1,2} microarchitecture:
  * 1) The RET at retbleed_return_thunk must be on a 64 byte boundary, for
  *    alignment within the BTB.


