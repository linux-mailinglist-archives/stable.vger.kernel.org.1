Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95E37BE116
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376865AbjJINrD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377593AbjJINqv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:46:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859E9E4
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:46:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1631C433C8;
        Mon,  9 Oct 2023 13:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859207;
        bh=nTF4M+U7sZ8FesEaN9hBwJ/RJBMEwCZnJbIpFKYbGS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y7Wau+cfawq4Tez70fTEjZSwsDGriUUCV1svy6axarXrmQcDCS27buUkr/HbGGpiL
         539L+RbQZmtKw26dXbO0YQIiT1EHPEePEkzIvJyCpGZhuU+2p9iEOxJ4LNf1d1lc1q
         nUFnqtFPUJ82NhkkN529j0RG7TqUR2c+9cX8ZlQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 5.10 216/226] IB/mlx4: Fix the size of a buffer in add_port_entries()
Date:   Mon,  9 Oct 2023 15:02:57 +0200
Message-ID: <20231009130132.182484130@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -221,7 +221,7 @@ void del_sysfs_port_mcg_attr(struct mlx4
 static int add_port_entries(struct mlx4_ib_dev *device, int port_num)
 {
 	int i;
-	char buff[11];
+	char buff[12];
 	struct mlx4_ib_iov_port *port = NULL;
 	int ret = 0 ;
 	struct ib_port_attr attr;


