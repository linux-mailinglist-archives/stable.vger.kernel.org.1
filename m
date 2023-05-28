Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03816713E2E
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjE1Tcs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjE1Tcr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:32:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B9FC7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:32:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E55061DB2
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5B6C433EF;
        Sun, 28 May 2023 19:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302365;
        bh=jZwCVYRwomB0GO/E7pd4QMROKXE4wDu48IuisVSdih4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0hgSaUmO1f0bnGuJsJpqLtiEAR2QSvJ6X9HWVFpPFyjdMDpGUQBbDcFVoM0LroGDc
         aC2f1N/gWQPGzmF3vTs2fbPko0vkkA5V+PoXbqTv1sIzESc1LqZx6hjXLPFIoQ5D3d
         uhcOEx8txuKWqrXRIxaK2UgHa+jsQkQLrIR7QBpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.3 106/127] forcedeth: Fix an error handling path in nv_probe()
Date:   Sun, 28 May 2023 20:11:22 +0100
Message-Id: <20230528190839.724954680@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 5b17a4971d3b2a073f4078dd65331efbe35baa2d upstream.

If an error occures after calling nv_mgmt_acquire_sema(), it should be
undone with a corresponding nv_mgmt_release_sema() call.

Add it in the error handling path of the probe as already done in the
remove function.

Fixes: cac1c52c3621 ("forcedeth: mgmt unit interface")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Link: https://lore.kernel.org/r/355e9a7d351b32ad897251b6f81b5886fcdc6766.1684571393.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/nvidia/forcedeth.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -6138,6 +6138,7 @@ static int nv_probe(struct pci_dev *pci_
 	return 0;
 
 out_error:
+	nv_mgmt_release_sema(dev);
 	if (phystate_orig)
 		writel(phystate|NVREG_ADAPTCTL_RUNNING, base + NvRegAdapterControl);
 out_freering:


