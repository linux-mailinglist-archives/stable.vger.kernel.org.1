Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D837E24AD
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjKFNYN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjKFNYM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:24:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E9510A
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:24:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFCDC433C8;
        Mon,  6 Nov 2023 13:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277048;
        bh=u7syam+qpQeENowZwLcMD8WWmojEIjl8sy5DbJ57s3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MzAO8cC2iM5ma8FLP6XoNP4sKHynB5L1VLF/4OjMaA2E8ZDKSU+O0c6RsMraxOipN
         Qe69NcFBfiW8S/jb5qI/BKblkBng/nnJ9GW/MfWnEKimWxvnB5LrDsrKQZlbSFKnTA
         X5y9QPH9HXDlpjhuiKFYqneIcpYs5YQk1VaZICZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hao Ge <gehao@kylinos.cn>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 020/128] firmware/imx-dsp: Fix use_after_free in imx_dsp_setup_channels()
Date:   Mon,  6 Nov 2023 14:03:00 +0100
Message-ID: <20231106130310.051086146@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hao Ge <gehao@kylinos.cn>

[ Upstream commit 1558b1a8dd388f5fcc3abc1e24de854a295044c3 ]

dsp_chan->name and chan_name points to same block of memory,
because dev_err still needs to be used it,so we need free
it's memory after use to avoid use_after_free.

Fixes: e527adfb9b7d ("firmware: imx-dsp: Fix an error handling path in imx_dsp_setup_channels()")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/imx/imx-dsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-dsp.c b/drivers/firmware/imx/imx-dsp.c
index 1f410809d3ee4..0f656e4191d5c 100644
--- a/drivers/firmware/imx/imx-dsp.c
+++ b/drivers/firmware/imx/imx-dsp.c
@@ -115,11 +115,11 @@ static int imx_dsp_setup_channels(struct imx_dsp_ipc *dsp_ipc)
 		dsp_chan->idx = i % 2;
 		dsp_chan->ch = mbox_request_channel_byname(cl, chan_name);
 		if (IS_ERR(dsp_chan->ch)) {
-			kfree(dsp_chan->name);
 			ret = PTR_ERR(dsp_chan->ch);
 			if (ret != -EPROBE_DEFER)
 				dev_err(dev, "Failed to request mbox chan %s ret %d\n",
 					chan_name, ret);
+			kfree(dsp_chan->name);
 			goto out;
 		}
 
-- 
2.42.0



