Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F0D6FA9CB
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbjEHK4Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbjEHKzH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:55:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21DA2C3EE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:54:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37FF762986
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B217C433D2;
        Mon,  8 May 2023 10:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543263;
        bh=h/ZZrZjIbcp/u86Xg+7tLyYUAglheWMJobuIUAFJ/ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ygOedoEHri4SoAI7KIGYP/3zGiQ/CpbNL+wqOABmefgICysytF2SNIXH+IhWMiYFq
         br4+OeR6S31IzlHXRLk8BfOAtFG9iqtaHlGxuHtgSotrhhrS0zGKFiDnnfB4vGjkFN
         p/R16kPMSQrQssE2CNXhTYmaKYN3RI1S/XOc1GhI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 6.3 034/694] MIPS: fw: Allow firmware to pass a empty env
Date:   Mon,  8 May 2023 11:37:49 +0200
Message-Id: <20230508094433.745264461@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

commit ee1809ed7bc456a72dc8410b475b73021a3a68d5 upstream.

fw_getenv will use env entry to determine style of env,
however it is legal for firmware to just pass a empty list.

Check if first entry exist before running strchr to avoid
null pointer dereference.

Cc: stable@vger.kernel.org
Link: https://github.com/clbr/n64bootloader/issues/5
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/fw/lib/cmdline.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/fw/lib/cmdline.c
+++ b/arch/mips/fw/lib/cmdline.c
@@ -53,7 +53,7 @@ char *fw_getenv(char *envname)
 {
 	char *result = NULL;
 
-	if (_fw_envp != NULL) {
+	if (_fw_envp != NULL && fw_envp(0) != NULL) {
 		/*
 		 * Return a pointer to the given environment variable.
 		 * YAMON uses "name", "value" pairs, while U-Boot uses


