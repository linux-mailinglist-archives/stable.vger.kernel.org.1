Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B9370C8B5
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbjEVTkz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjEVTkV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A378DBB
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 391E1629F5
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E09C433D2;
        Mon, 22 May 2023 19:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784417;
        bh=dQbVqA1YkJLQlewsOZXS1PmS/s3AOFjUEbVyfpZ3rCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M5iQI5b9NDZ/znXsfuzoUEKJ1vjjTnm6xmDD5hNcWu5UDZAIiR7SWQub/gJ5RRchB
         0JkUO/Tky7ETyRmczw+c6kbxmFN87xLOrF/ZrWz2/xFr7T/Q5Wlb7unu58bdFqeVDA
         EDvXnnhrHLvwTP0ags28LWofrTX6aB9VKrJ+TS5U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 076/364] arm64: dts: qcom: sm6115-j606f: Add ramoops node
Date:   Mon, 22 May 2023 20:06:21 +0100
Message-Id: <20230522190414.670380369@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 8b0ac59c2da69aaf8e65c6bd648a06b755975302 ]

Add a ramoops node to enable retrieving crash logs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230406-topic-lenovo_features-v2-1-625d7cb4a944@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
index 4ce2d905d70e1..42d89bab5d04b 100644
--- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
@@ -52,6 +52,17 @@
 			gpio-key,wakeup;
 		};
 	};
+
+	reserved-memory {
+		ramoops@ffc00000 {
+			compatible = "ramoops";
+			reg = <0x0 0xffc00000 0x0 0x100000>;
+			record-size = <0x1000>;
+			console-size = <0x40000>;
+			ftrace-size = <0x20000>;
+			ecc-size = <16>;
+		};
+	};
 };
 
 &dispcc {
-- 
2.39.2



