Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9327612D5
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbjGYLFz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjGYLFf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:05:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342213A90
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C649761656
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA056C433C8;
        Tue, 25 Jul 2023 11:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283016;
        bh=t/uFFNNO04XDV2zUVQF4Xlrly4F/nbwXnS7Av0vkMis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fcrm1oJ8pAcCeGadQmNPvoTD7Baz1uBd6nujSE3XZw4EyZK/7M8kF6pWZO72tBnKK
         /sqpbg1pVJNWf1ikDCjrhTH0j/JqXXZWxe0mpaDVv0xni7NL0L6erKHLNqIBPXhR4Z
         qDvMEYjkue+V84pOkZMlHGk9VPAdWR2z4zq1INbs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 109/183] ASoC: SOF: ipc3-dtrace: uninitialized data in dfsentry_trace_filter_write()
Date:   Tue, 25 Jul 2023 12:45:37 +0200
Message-ID: <20230725104511.882751927@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 469e2f28c2cbee2430058c1c9bb6d1675d7195fb ]

This doesn't check how many bytes the simple_write_to_buffer() writes to
the buffer.  The only thing that we know is that the first byte is
initialized and the last byte of the buffer is set to NUL.  However
the middle bytes could be uninitialized.

There is no need to use simple_write_to_buffer().  This code does not
support partial writes but instead passes "pos = 0" as the starting
offset regardless of what the user passed as "*ppos".  Just use the
copy_from_user() function and initialize the whole buffer.

Fixes: 671e0b90051e ("ASoC: SOF: Clone the trace code to ipc3-dtrace as fw_tracing implementation")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/74148292-ce4d-4e01-a1a7-921e6767da14@moroto.mountain
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc3-dtrace.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/ipc3-dtrace.c b/sound/soc/sof/ipc3-dtrace.c
index b815b0244d9e4..8cf421577378c 100644
--- a/sound/soc/sof/ipc3-dtrace.c
+++ b/sound/soc/sof/ipc3-dtrace.c
@@ -187,7 +187,6 @@ static ssize_t dfsentry_trace_filter_write(struct file *file, const char __user
 	struct snd_sof_dfsentry *dfse = file->private_data;
 	struct sof_ipc_trace_filter_elem *elems = NULL;
 	struct snd_sof_dev *sdev = dfse->sdev;
-	loff_t pos = 0;
 	int num_elems;
 	char *string;
 	int ret;
@@ -202,11 +201,11 @@ static ssize_t dfsentry_trace_filter_write(struct file *file, const char __user
 	if (!string)
 		return -ENOMEM;
 
-	/* assert null termination */
-	string[count] = 0;
-	ret = simple_write_to_buffer(string, count, &pos, from, count);
-	if (ret < 0)
+	if (copy_from_user(string, from, count)) {
+		ret = -EFAULT;
 		goto error;
+	}
+	string[count] = '\0';
 
 	ret = trace_filter_parse(sdev, string, &num_elems, &elems);
 	if (ret < 0)
-- 
2.39.2



