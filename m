Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF4277AC69
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjHMVcs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjHMVcr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:32:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24B710D7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:32:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F74962BFA
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AB6C433C7;
        Sun, 13 Aug 2023 21:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962368;
        bh=xRYkjk2nqLzKMCzrDDwvi8PDqHF7BbEhR7r63ocb7mQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pV7LlIGwer8ms+9z6JY5FrzgDzJfu7iClwnY7wIF1hUbnpG+zRBTrfKrh/11r+gjK
         7HRvit0AUFRza7Tl0ZhB6AS4V+ZSg/MZu/35VzVVG2a+KM5pvWG4X40zpKAsTmYA1g
         pyqKtHbs0QFt+BiaSpw91x/azprSXosegLM9TDeI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.4 191/206] scsi: ufs: renesas: Fix private allocation
Date:   Sun, 13 Aug 2023 23:19:21 +0200
Message-ID: <20230813211730.486736167@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit b6d128f89a85771433a004e8656090ccbe1fb969 upstream.

Should use devm_kzalloc() for struct ufs_renesas_priv because the
.initialized should be false as default.

Fixes: d69520288efd ("scsi: ufs: ufs-renesas: Add support for Renesas R-Car UFS controller")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20230803081812.1446282-1-yoshihiro.shimoda.uh@renesas.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ufs/host/ufs-renesas.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ufs/host/ufs-renesas.c
+++ b/drivers/ufs/host/ufs-renesas.c
@@ -359,7 +359,7 @@ static int ufs_renesas_init(struct ufs_h
 {
 	struct ufs_renesas_priv *priv;
 
-	priv = devm_kmalloc(hba->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(hba->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 	ufshcd_set_variant(hba, priv);


