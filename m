Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A30974F8B9
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 22:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjGKUGn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 16:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjGKUGm (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 16:06:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2773912E
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 13:06:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF6E7615D4
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 20:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B81C433C7;
        Tue, 11 Jul 2023 20:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689106000;
        bh=9xUT6m13YnsMAdErIwavCkFAgY7p0ojY+fPz8jfcN/w=;
        h=Subject:To:Cc:From:Date:From;
        b=0q6vpJ4TSCleb9UCRXsnDzbLtuhFO1lpYNjKJQcnoxtsHg8hUxOMqNFKsYtQuBTiQ
         VfYoAdRQo8n2b8YnBGQzYT30ev2tcUv9X0LqM7j1cEyBN/iSMsYCX7uorur9oNatQS
         HLQDWiJfxfuLMzPbTQbaEHVk5aYfbLEQTYyRobB8=
Subject: FAILED: patch "[PATCH] extcon: usbc-tusb320: Unregister typec port on driver removal" failed to apply to 5.15-stable tree
To:     alsi@bang-olufsen.dk, cw00.choi@samsung.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 11 Jul 2023 22:06:28 +0200
Message-ID: <2023071128-dramatic-batch-039e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 3adbaa30d973093a4f37927baf9596cca51b593d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071128-dramatic-batch-039e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3adbaa30d973093a4f37927baf9596cca51b593d Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Date: Wed, 15 Mar 2023 15:15:47 +0100
Subject: [PATCH] extcon: usbc-tusb320: Unregister typec port on driver removal
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The driver can register a typec port if suitable firmware properties are
present. But if the driver is removed through sysfs unbind, rmmod or
similar, then it does not clean up after itself and the typec port
device remains registered. This can be seen in sysfs, where stale typec
ports get left over in /sys/class/typec.

In order to fix this we have to add an i2c_driver remove function and
call typec_unregister_port(), which is a no-op in the case where no
typec port is created and the pointer remains NULL.

In the process we should also put the fwnode_handle when the typec port
isn't registered anymore, including if an error occurs during probe. The
typec subsystem does not increase or decrease the reference counter for
us, so we track it in the driver's private data.

Note that the conditional check on TYPEC_PWR_MODE_PD was removed in the
probe path because a call to tusb320_set_adv_pwr_mode() will perform an
even more robust validation immediately after, hence there is no
functional change here.

Fixes: bf7571c00dca ("extcon: usbc-tusb320: Add USB TYPE-C support")
Cc: stable@vger.kernel.org
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
index b408ce989c22..10dff1c512c4 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -78,6 +78,7 @@ struct tusb320_priv {
 	struct typec_capability	cap;
 	enum typec_port_type port_type;
 	enum typec_pwr_opmode pwr_opmode;
+	struct fwnode_handle *connector_fwnode;
 };
 
 static const char * const tusb_attached_states[] = {
@@ -391,27 +392,25 @@ static int tusb320_typec_probe(struct i2c_client *client,
 	/* Type-C connector found. */
 	ret = typec_get_fw_cap(&priv->cap, connector);
 	if (ret)
-		return ret;
+		goto err_put;
 
 	priv->port_type = priv->cap.type;
 
 	/* This goes into register 0x8 field CURRENT_MODE_ADVERTISE */
 	ret = fwnode_property_read_string(connector, "typec-power-opmode", &cap_str);
 	if (ret)
-		return ret;
+		goto err_put;
 
 	ret = typec_find_pwr_opmode(cap_str);
 	if (ret < 0)
-		return ret;
-	if (ret == TYPEC_PWR_MODE_PD)
-		return -EINVAL;
+		goto err_put;
 
 	priv->pwr_opmode = ret;
 
 	/* Initialize the hardware with the devicetree settings. */
 	ret = tusb320_set_adv_pwr_mode(priv);
 	if (ret)
-		return ret;
+		goto err_put;
 
 	priv->cap.revision		= USB_TYPEC_REV_1_1;
 	priv->cap.accessory[0]		= TYPEC_ACCESSORY_AUDIO;
@@ -422,10 +421,25 @@ static int tusb320_typec_probe(struct i2c_client *client,
 	priv->cap.fwnode		= connector;
 
 	priv->port = typec_register_port(&client->dev, &priv->cap);
-	if (IS_ERR(priv->port))
-		return PTR_ERR(priv->port);
+	if (IS_ERR(priv->port)) {
+		ret = PTR_ERR(priv->port);
+		goto err_put;
+	}
+
+	priv->connector_fwnode = connector;
 
 	return 0;
+
+err_put:
+	fwnode_handle_put(connector);
+
+	return ret;
+}
+
+static void tusb320_typec_remove(struct tusb320_priv *priv)
+{
+	typec_unregister_port(priv->port);
+	fwnode_handle_put(priv->connector_fwnode);
 }
 
 static int tusb320_probe(struct i2c_client *client)
@@ -438,7 +452,9 @@ static int tusb320_probe(struct i2c_client *client)
 	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
+
 	priv->dev = &client->dev;
+	i2c_set_clientdata(client, priv);
 
 	priv->regmap = devm_regmap_init_i2c(client, &tusb320_regmap_config);
 	if (IS_ERR(priv->regmap))
@@ -489,10 +505,19 @@ static int tusb320_probe(struct i2c_client *client)
 					tusb320_irq_handler,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					client->name, priv);
+	if (ret)
+		tusb320_typec_remove(priv);
 
 	return ret;
 }
 
+static void tusb320_remove(struct i2c_client *client)
+{
+	struct tusb320_priv *priv = i2c_get_clientdata(client);
+
+	tusb320_typec_remove(priv);
+}
+
 static const struct of_device_id tusb320_extcon_dt_match[] = {
 	{ .compatible = "ti,tusb320", .data = &tusb320_ops, },
 	{ .compatible = "ti,tusb320l", .data = &tusb320l_ops, },
@@ -502,6 +527,7 @@ MODULE_DEVICE_TABLE(of, tusb320_extcon_dt_match);
 
 static struct i2c_driver tusb320_extcon_driver = {
 	.probe_new	= tusb320_probe,
+	.remove		= tusb320_remove,
 	.driver		= {
 		.name	= "extcon-tusb320",
 		.of_match_table = tusb320_extcon_dt_match,

