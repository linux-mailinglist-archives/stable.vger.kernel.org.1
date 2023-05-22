Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B695B70C8C3
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbjEVTmC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbjEVTlq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:41:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00434E5F
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:41:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 050BC629FA
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC0EC433D2;
        Mon, 22 May 2023 19:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784448;
        bh=cH0hz9aY+btRJsDOHyfCUgK9Fx/cvAgA30i54sUjn0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CrTLDAcQb56/34oNVaU8YMOx969lFvTh+ncQpGiKyBCsQo9MSeFLhmfIEwgeeKpcU
         yeTC0lyRUSO2pwUQ05+uJADZdInBM9OPk80uFZNDXHr38xs9K39eRh7wrW/snPWfGm
         7vOebki5pZYQYY/nxtjnQ86h93bsfhlErJyTdLQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Feng Jiang <jiangfeng@kylinos.cn>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 086/364] platform/x86/amd: pmc: Fix memory leak in amd_pmc_stb_debugfs_open_v2()
Date:   Mon, 22 May 2023 20:06:31 +0100
Message-Id: <20230522190414.909862496@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Feng Jiang <jiangfeng@kylinos.cn>

[ Upstream commit f6e7ac4c35a28aef0be93b32c533ae678ad0b9e7 ]

Function amd_pmc_stb_debugfs_open_v2() may be called when the STB
debug mechanism enabled.

When amd_pmc_send_cmd() fails, the 'buf' needs to be released.

Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
Link: https://lore.kernel.org/r/20230412093734.1126410-1-jiangfeng@kylinos.cn
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 69f305496643f..73dedc9950144 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -265,6 +265,7 @@ static int amd_pmc_stb_debugfs_open_v2(struct inode *inode, struct file *filp)
 	dev->msg_port = 0;
 	if (ret) {
 		dev_err(dev->dev, "error: S2D_NUM_SAMPLES not supported : %d\n", ret);
+		kfree(buf);
 		return ret;
 	}
 
-- 
2.39.2



