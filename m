Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A9D7BE077
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377257AbjJINkd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377341AbjJINkZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:40:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F12C9D
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:40:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE1CC433C7;
        Mon,  9 Oct 2023 13:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858822;
        bh=YDJ9sLu0ZNXXBvuOf7dGx8NaeF/2GvXVTM4DlQdxOR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jGCpPb8fm2KYepcw0YyDCkqXgix7k+XDfZtKgfIYsJ1cyojQgsWIgp6s4Kim9dZZ1
         uD6wS4PxQTfJnZKBQ+IT+auDM6KjNX1j5Y8FdHfFkl3Flh7EMhUhSJvcS5LSg7KShk
         n/kfDk6El/25c+BGITdVapOLGOz4bdQpZ6t9f3Uo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 111/226] parisc: drivers: Fix sparse warning
Date:   Mon,  9 Oct 2023 15:01:12 +0200
Message-ID: <20231009130129.683067716@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

[ Upstream commit b137b9d60b8add5620a06c687a71ce18776730b0 ]

Fix "warning: directive in macro's argument list" warning.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/kernel/drivers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/drivers.c b/arch/parisc/kernel/drivers.c
index d95157488832a..d11a3123f3dc4 100644
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -925,9 +925,9 @@ static __init void qemu_header(void)
 	pr_info("#define PARISC_MODEL \"%s\"\n\n",
 			boot_cpu_data.pdc.sys_model_name);
 
+	#define p ((unsigned long *)&boot_cpu_data.pdc.model)
 	pr_info("#define PARISC_PDC_MODEL 0x%lx, 0x%lx, 0x%lx, "
 		"0x%lx, 0x%lx, 0x%lx, 0x%lx, 0x%lx, 0x%lx\n\n",
-	#define p ((unsigned long *)&boot_cpu_data.pdc.model)
 		p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8]);
 	#undef p
 
-- 
2.40.1



