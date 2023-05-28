Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AC1713D12
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjE1TVf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjE1TVe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:21:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C7FC7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:21:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F385861B22
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C95EC4339B;
        Sun, 28 May 2023 19:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301692;
        bh=Axohtc6qlhgARzfDPZ01fuMozg/1xj9th/JofwlqtR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uebp082yjDP3XeCXkrmyAkJXiUIZXQWwXytKR5FKElZoHVq2SZyVuEF/RxpqskZUy
         FRWSU2iRIPDYueumMvNibVdK66mjGeoBIEujBvFFdPFIdnsez6oOGC+oSt3Kvx0I8e
         ynwzv9X61ivUkldJr+rMu9m8d4bS6+WfSUJ7I/7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.19 131/132] forcedeth: Fix an error handling path in nv_probe()
Date:   Sun, 28 May 2023 20:11:10 +0100
Message-Id: <20230528190837.899897561@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190833.565872088@linuxfoundation.org>
References: <20230528190833.565872088@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
@@ -6061,6 +6061,7 @@ static int nv_probe(struct pci_dev *pci_
 	return 0;
 
 out_error:
+	nv_mgmt_release_sema(dev);
 	if (phystate_orig)
 		writel(phystate|NVREG_ADAPTCTL_RUNNING, base + NvRegAdapterControl);
 out_freering:


