Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423CD7A38AB
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbjIQTin (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239430AbjIQTi2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:38:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F33D9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:38:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0E3C433C9;
        Sun, 17 Sep 2023 19:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979503;
        bh=JWKPQUvjGNVyfR8IJ7n9xrp8vrhirDK7nJwz8FNrMA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lV1mC92l3R17C+AUpI/jKriIuzY0ZDyuTN7r7+wCt0F+WTXCL/l7Q8+DTaMxQ5i3F
         Mkmimvl1vUIBMwH0V4DEu0qGL6AKQd9GbSTGjeLMARZDb2WY+ZAwPhpxUJ53zEfMRv
         J1y9f3UrlsMQU/CaqOsdtj2GK4L265cDReKbRIBk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chris Lew <quic_clew@quicinc.com>,
        Praveenkumar I <quic_ipkumar@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 5.10 331/406] soc: qcom: qmi_encdec: Restrict string length in decode
Date:   Sun, 17 Sep 2023 21:13:05 +0200
Message-ID: <20230917191110.028199919@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -534,8 +534,8 @@ static int qmi_decode_string_elem(struct
 		decoded_bytes += rc;
 	}
 
-	if (string_len > temp_ei->elem_len) {
-		pr_err("%s: String len %d > Max Len %d\n",
+	if (string_len >= temp_ei->elem_len) {
+		pr_err("%s: String len %d >= Max Len %d\n",
 		       __func__, string_len, temp_ei->elem_len);
 		return -ETOOSMALL;
 	} else if (string_len > tlv_len) {


