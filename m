Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3AC7A392C
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239956AbjIQTqJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239919AbjIQTpg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:45:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D0D133
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:45:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40528C433C9;
        Sun, 17 Sep 2023 19:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979925;
        bh=g9HNw8zX0zOxe+tFdUMYcE1GtEzRV28Xq5lGwGEJYPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9ERpSA1YT1FLeKoT03RFzdSiQuzZGGoTHqCglufoY0aH5pZYPx4fxGsMiSoEdtdL
         jAW17xT5j9O8hg01gQtLD1rFK/M1WmokWIcWO2k/eCEyKmXqs0Xe+xeJPyVJJtOWfG
         ykOpCxAwC4gwti8zxFnf5jKFcvrCa+8Ub+ATWXms=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chris Lew <quic_clew@quicinc.com>,
        Praveenkumar I <quic_ipkumar@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.5 047/285] soc: qcom: qmi_encdec: Restrict string length in decode
Date:   Sun, 17 Sep 2023 21:10:47 +0200
Message-ID: <20230917191053.301819910@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Lew <quic_clew@quicinc.com>

commit 8d207400fd6b79c92aeb2f33bb79f62dff904ea2 upstream.

The QMI TLV value for strings in a lot of qmi element info structures
account for null terminated strings with MAX_LEN + 1. If a string is
actually MAX_LEN + 1 length, this will cause an out of bounds access
when the NULL character is appended in decoding.

Fixes: 9b8a11e82615 ("soc: qcom: Introduce QMI encoder/decoder")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Link: https://lore.kernel.org/r/20230801064712.3590128-1-quic_ipkumar@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/qcom/qmi_encdec.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/soc/qcom/qmi_encdec.c
+++ b/drivers/soc/qcom/qmi_encdec.c
@@ -534,8 +534,8 @@ static int qmi_decode_string_elem(const
 		decoded_bytes += rc;
 	}
 
-	if (string_len > temp_ei->elem_len) {
-		pr_err("%s: String len %d > Max Len %d\n",
+	if (string_len >= temp_ei->elem_len) {
+		pr_err("%s: String len %d >= Max Len %d\n",
 		       __func__, string_len, temp_ei->elem_len);
 		return -ETOOSMALL;
 	} else if (string_len > tlv_len) {


