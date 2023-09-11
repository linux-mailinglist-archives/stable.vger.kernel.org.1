Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF5179B93B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241764AbjIKWYK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242320AbjIKP1m (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:27:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E21E4
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:27:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB6FC433C8;
        Mon, 11 Sep 2023 15:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694446057;
        bh=w01WcnMTM3nb8SzvA+gVYZrorUt7dbiJrHAGOQXZvys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T5tzDQhmp6N6r3tCH29M2AElfIPZabV/GOXfnvZiBOzjEgdL1ls8dPchFWjT2zS5d
         1mvVUEaH6D9xAXkKLVxZM0WbekCxu18XYryYRZQrkT1EHJJZ0gChzKgyxnl1Yrlc6Y
         D1hIUW8+dfdd1wnPnW6I67XSMI4llCso6fq2UbA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thore Sommer <public@thson.de>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.1 567/600] X.509: if signature is unsupported skip validation
Date:   Mon, 11 Sep 2023 15:50:00 +0200
Message-ID: <20230911134650.346005346@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thore Sommer <public@thson.de>

commit ef5b52a631f8c18353e80ccab8408b963305510c upstream.

When the hash algorithm for the signature is not available the digest size
is 0 and the signature in the certificate is marked as unsupported.

When validating a self-signed certificate, this needs to be checked,
because otherwise trying to validate the signature will fail with an
warning:

Loading compiled-in X.509 certificates
WARNING: CPU: 0 PID: 1 at crypto/rsa-pkcs1pad.c:537 \
pkcs1pad_verify+0x46/0x12c
...
Problem loading in-kernel X.509 certificate (-22)

Signed-off-by: Thore Sommer <public@thson.de>
Cc: stable@vger.kernel.org # v4.7+
Fixes: 6c2dc5ae4ab7 ("X.509: Extract signature digest and make self-signed cert checks earlier")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/asymmetric_keys/x509_public_key.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -117,6 +117,11 @@ int x509_check_for_self_signed(struct x5
 			goto out;
 	}
 
+	if (cert->unsupported_sig) {
+		ret = 0;
+		goto out;
+	}
+
 	ret = public_key_verify_signature(cert->pub, cert->sig);
 	if (ret < 0) {
 		if (ret == -ENOPKG) {


