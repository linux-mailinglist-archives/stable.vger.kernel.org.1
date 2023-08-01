Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CBD76AE31
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjHAJgq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjHAJgS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D71E3AB7
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:34:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9571A614FE
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A011BC433C8;
        Tue,  1 Aug 2023 09:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882475;
        bh=kBBgDVDUZifAbBP8gsbhqfnQWJEadzb/7Jk/QGTido8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S4YwhamteLgFRnB2+PHEqg5KFn+c2gxr+3RRBV3ccnbCD5m0IR/iEGgkAjnS8/mBY
         hYQ6M9ACvTIhRphE+Bgz17uEVqpGBS8a6KKPIAqFnXEnqBTSAgrpEaeLpxzqj7xV4h
         eCOdahmhRky61gPQpx49JlNDob26JlNkpOeGGgRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 080/228] media: amphion: Fix firmware path to match linux-firmware
Date:   Tue,  1 Aug 2023 11:18:58 +0200
Message-ID: <20230801091925.721169736@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Nicolas Dufresne <nicolas.dufresne@collabora.com>

[ Upstream commit dcff0b56f661b6b42e828012b464d22cc2068c38 ]

The path did not match the one it was submitted into linux-firmware
which prevented generic distribution from having working CODEC.

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/amphion/vpu_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
index f9ec1753f7c86..be80410682681 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -828,7 +828,7 @@ static const struct dev_pm_ops vpu_core_pm_ops = {
 
 static struct vpu_core_resources imx8q_enc = {
 	.type = VPU_CORE_TYPE_ENC,
-	.fwname = "vpu/vpu_fw_imx8_enc.bin",
+	.fwname = "amphion/vpu/vpu_fw_imx8_enc.bin",
 	.stride = 16,
 	.max_width = 1920,
 	.max_height = 1920,
@@ -843,7 +843,7 @@ static struct vpu_core_resources imx8q_enc = {
 
 static struct vpu_core_resources imx8q_dec = {
 	.type = VPU_CORE_TYPE_DEC,
-	.fwname = "vpu/vpu_fw_imx8_dec.bin",
+	.fwname = "amphion/vpu/vpu_fw_imx8_dec.bin",
 	.stride = 256,
 	.max_width = 8188,
 	.max_height = 8188,
-- 
2.39.2



