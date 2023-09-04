Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902C4791CD9
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242774AbjIDScR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239998AbjIDScP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:32:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72562CC8
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D0B99CE0F98
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29B1C433C7;
        Mon,  4 Sep 2023 18:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852329;
        bh=Rb3OZKM/4uN+yE2DRaEcbip6DQ/fiDi7vHlC6WOUJro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fJhKY5izXKpAthkclkIrSXVyYZDwVvQ9MdXFiaQ6KhP9j8fPYFeUtNFGxMvud/G21
         /pUn0Nr9mCxnyln0kwWboQZ/DFA//DGVQ90U+XLsMpElYv0Xx9mwkP3xSetrKFSwh8
         htcbszjuGpyVcnwpqqmjCE4VFoREpT2JjxvqJwO8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH 6.5 28/34] fsi: master-ast-cf: Add MODULE_FIRMWARE macro
Date:   Mon,  4 Sep 2023 19:30:15 +0100
Message-ID: <20230904182949.920695037@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182948.594404081@linuxfoundation.org>
References: <20230904182948.594404081@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juerg Haefliger <juerg.haefliger@canonical.com>

commit 3a1d7aff6e65ad6e285e28abe55abbfd484997ee upstream.

The module loads firmware so add a MODULE_FIRMWARE macro to provide that
information via modinfo.

Fixes: 6a794a27daca ("fsi: master-ast-cf: Add new FSI master using Aspeed ColdFire")
Cc: stable@vger.kernel.org # 4.19+
Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Link: https://lore.kernel.org/r/20230628095039.26218-1-juerg.haefliger@canonical.com
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/fsi/fsi-master-ast-cf.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -1441,3 +1441,4 @@ static struct platform_driver fsi_master
 
 module_platform_driver(fsi_master_acf);
 MODULE_LICENSE("GPL");
+MODULE_FIRMWARE(FW_FILE_NAME);


