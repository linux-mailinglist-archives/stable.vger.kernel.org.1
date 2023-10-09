Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CEB7BDF38
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376815AbjJIN1u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376813AbjJIN1u (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:27:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F0A99
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:27:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2230C433C7;
        Mon,  9 Oct 2023 13:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858068;
        bh=O0JuPoJp7wvbu7ZQNU6HHlKMNmhFDiH+dnPCfqheCMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hjivJKLLcHFWuXicG/Te6qPzSSvR6HDgsojfJqKN+toPGyJhA5Pd3pqfMtCmqRUdM
         1GgD1UPsyqjeU8zxUmdECSZ+L+e8NMMqUZ2hgER8vm5+moXaLWNBAwRH6DHXBm93UT
         vKhIzgkhqJAX/DBrLzPoXYvzH57oWEcyil/Y10Dc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 5.15 66/75] IB/mlx4: Fix the size of a buffer in add_port_entries()
Date:   Mon,  9 Oct 2023 15:02:28 +0200
Message-ID: <20231009130113.569771382@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
References: <20231009130111.200710898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit d7f393430a17c2bfcdf805462a5aa80be4285b27 upstream.

In order to be sure that 'buff' is never truncated, its size should be
12, not 11.

When building with W=1, this fixes the following warnings:

  drivers/infiniband/hw/mlx4/sysfs.c: In function ‘add_port_entries’:
  drivers/infiniband/hw/mlx4/sysfs.c:268:34: error: ‘sprintf’ may write a terminating nul past the end of the destination [-Werror=format-overflow=]
    268 |                 sprintf(buff, "%d", i);
        |                                  ^
  drivers/infiniband/hw/mlx4/sysfs.c:268:17: note: ‘sprintf’ output between 2 and 12 bytes into a destination of size 11
    268 |                 sprintf(buff, "%d", i);
        |                 ^~~~~~~~~~~~~~~~~~~~~~
  drivers/infiniband/hw/mlx4/sysfs.c:286:34: error: ‘sprintf’ may write a terminating nul past the end of the destination [-Werror=format-overflow=]
    286 |                 sprintf(buff, "%d", i);
        |                                  ^
  drivers/infiniband/hw/mlx4/sysfs.c:286:17: note: ‘sprintf’ output between 2 and 12 bytes into a destination of size 11
    286 |                 sprintf(buff, "%d", i);
        |                 ^~~~~~~~~~~~~~~~~~~~~~

Fixes: c1e7e466120b ("IB/mlx4: Add iov directory in sysfs under the ib device")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/0bb1443eb47308bc9be30232cc23004c4d4cf43e.1695448530.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx4/sysfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx4/sysfs.c
+++ b/drivers/infiniband/hw/mlx4/sysfs.c
@@ -223,7 +223,7 @@ void del_sysfs_port_mcg_attr(struct mlx4
 static int add_port_entries(struct mlx4_ib_dev *device, int port_num)
 {
 	int i;
-	char buff[11];
+	char buff[12];
 	struct mlx4_ib_iov_port *port = NULL;
 	int ret = 0 ;
 	struct ib_port_attr attr;


