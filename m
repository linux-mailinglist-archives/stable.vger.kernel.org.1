Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5617352B7
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjFSKhf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjFSKh0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:37:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373A4102
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:37:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B961B60B51
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCDCC433C0;
        Mon, 19 Jun 2023 10:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171044;
        bh=E9oYiWRHZSdtD12KpMsuAKMosL2QCx7JRVE6Li+bl2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=meu3DGxCua6FE10YNfl+2xdK4qAILAAeaNwU/Iw3WugSHOiv24eCX4MVIcqAPOHXR
         lqhvOW4ecuDAg0aYmgjvxBrhxg3D7Q6F/MwJth9tiysXHqtEUNAYDTZ5Ta9ic5XOhN
         yYrGiUrr1TI671yUnuebo2rKWqQQUoQoDD+yK1dk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Pavan Holla <pholla@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.3 101/187] usb: typec: Fix fast_role_swap_current show function
Date:   Mon, 19 Jun 2023 12:28:39 +0200
Message-ID: <20230619102202.475648214@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Pavan Holla <pholla@chromium.org>

commit 92c9c3baad6b1fd584fbabeaa4756f9b77926cb5 upstream.

The current implementation mistakenly performs a & operation on
the output of sysfs_emit. This patch performs the & operation before
calling sysfs_emit.

Fixes: 662a60102c12 ("usb: typec: Separate USB Power Delivery from USB Type-C")
Cc: stable <stable@kernel.org>
Reported-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Pavan Holla <pholla@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Message-ID: <20230607193328.3359487-1-pholla@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/pd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/typec/pd.c
+++ b/drivers/usb/typec/pd.c
@@ -96,7 +96,7 @@ peak_current_show(struct device *dev, st
 static ssize_t
 fast_role_swap_current_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%u\n", to_pdo(dev)->pdo >> PDO_FIXED_FRS_CURR_SHIFT) & 3;
+	return sysfs_emit(buf, "%u\n", (to_pdo(dev)->pdo >> PDO_FIXED_FRS_CURR_SHIFT) & 3);
 }
 static DEVICE_ATTR_RO(fast_role_swap_current);
 


