Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0451713E09
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjE1TbT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjE1TbT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:31:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D03CA7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:31:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2D7161D08
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1111C433EF;
        Sun, 28 May 2023 19:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302275;
        bh=v5y/d6MFvgPaJmVRMETyzXieC/WwYStzyt+D2FnE6tA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zOW6gf/AQVbVjEg5oAXhvhztd0Sb5C3xzRuNDWflP3mC9OWh0Tfua/uoAdybjew5D
         3nKQ9jTvdcYraMzjk9y65rSs5SKq1ggBdDbohb1yH+X303/mWeqevLyDKcxGuY8sHT
         tugDZxaIbUoiGi+hbUCy8MvK+TKXZp6Eh6k4Eodg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>
Subject: [PATCH 6.3 031/127] parisc: Use num_present_cpus() in alternative patching code
Date:   Sun, 28 May 2023 20:10:07 +0100
Message-Id: <20230528190837.309019918@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Helge Deller <deller@gmx.de>

commit b6405f0829d7b1dd926ba3ca5f691cab835abfaa upstream.

When patching the kernel code some alternatives depend on SMP vs. !SMP.
Use the value of num_present_cpus() instead of num_online_cpus() to
decide, otherwise we may run into issues if and additional CPU is
enabled after having loaded a module while only one CPU was enabled.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org> # v6.1+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/kernel/alternative.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/parisc/kernel/alternative.c
+++ b/arch/parisc/kernel/alternative.c
@@ -25,7 +25,7 @@ void __init_or_module apply_alternatives
 {
 	struct alt_instr *entry;
 	int index = 0, applied = 0;
-	int num_cpus = num_online_cpus();
+	int num_cpus = num_present_cpus();
 	u16 cond_check;
 
 	cond_check = ALT_COND_ALWAYS |


