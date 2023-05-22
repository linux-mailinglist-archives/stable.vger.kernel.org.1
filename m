Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CB970C942
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbjEVTqU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbjEVTqG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:46:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F1B102
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:46:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 329A862A94
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435E9C4339B;
        Mon, 22 May 2023 19:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784764;
        bh=u0ete4/L9qEG1j1eaFaM6cfkD+hUhRBYlzGermRhDww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHlDAqEmrb9aL699fD9uqMRvRIFp1qZtFtIjVd+7lTrJrWyYSQVqMBRJ3ih/4Hnpo
         U6unP0C40quWRGydN9LePMAnOlwQiEpG2vfQ2JC10ffw9gbWgPVmc5s7DgaHTANYzL
         L9+5xappmiO5RSWrLEhkY2Xs/DEXQZU/LzpUIT1Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qiang Ning <qning0106@126.com>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 195/364] mfd: dln2: Fix memory leak in dln2_probe()
Date:   Mon, 22 May 2023 20:08:20 +0100
Message-Id: <20230522190417.610503945@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Qiang Ning <qning0106@126.com>

[ Upstream commit 96da8f148396329ba769246cb8ceaa35f1ddfc48 ]

When dln2_setup_rx_urbs() in dln2_probe() fails, error out_free forgets
to call usb_put_dev() to decrease the refcount of dln2->usb_dev.

Fix this by adding usb_put_dev() in the error handling code of
dln2_probe().

Signed-off-by: Qiang Ning <qning0106@126.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20230330024353.4503-1-qning0106@126.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/dln2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 6cd0b0c752d6e..c3149729cec2e 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -827,6 +827,7 @@ static int dln2_probe(struct usb_interface *interface,
 	dln2_stop_rx_urbs(dln2);
 
 out_free:
+	usb_put_dev(dln2->usb_dev);
 	dln2_free(dln2);
 
 	return ret;
-- 
2.39.2



