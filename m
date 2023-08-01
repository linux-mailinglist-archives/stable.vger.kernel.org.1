Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC07C76AEA2
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjHAJkb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjHAJkD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:40:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2C6CF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:37:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7097461511
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B57C433CC;
        Tue,  1 Aug 2023 09:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882671;
        bh=M2ADGH8y1eFZsJZHKWgKMvnjauSSTTseTqainU8f23E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0o5gw4FqDm/U9Tug/kSRp4BWiYdqxd1Rm7Q82aYA/GkXEpImF5Page2b4du80puR/
         PMKfPID6Fe0c+D9XCBZDBmnnq1XBUwEdPX9Z4qsLGTuoG/ccZW7feKeRb/C2QyCXLB
         HtY4q9+ZBpMcLiC1sFHbFU9BBsldQ3GQXqMkdm4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 6.1 190/228] tpm_tis: Explicitly check for error code
Date:   Tue,  1 Aug 2023 11:20:48 +0200
Message-ID: <20230801091929.721991261@linuxfoundation.org>
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

From: Alexander Steffen <Alexander.Steffen@infineon.com>

commit 513253f8c293c0c8bd46d09d337fc892bf8f9f48 upstream.

recv_data either returns the number of received bytes, or a negative value
representing an error code. Adding the return value directly to the total
number of received bytes therefore looks a little weird, since it might add
a negative error code to a sum of bytes.

The following check for size < expected usually makes the function return
ETIME in that case, so it does not cause too many problems in practice. But
to make the code look cleaner and because the caller might still be
interested in the original error code, explicitly check for the presence of
an error code and pass that through.

Cc: stable@vger.kernel.org
Fixes: cb5354253af2 ("[PATCH] tpm: spacing cleanups 2")
Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm_tis_core.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -356,8 +356,13 @@ static int tpm_tis_recv(struct tpm_chip
 		goto out;
 	}
 
-	size += recv_data(chip, &buf[TPM_HEADER_SIZE],
-			  expected - TPM_HEADER_SIZE);
+	rc = recv_data(chip, &buf[TPM_HEADER_SIZE],
+		       expected - TPM_HEADER_SIZE);
+	if (rc < 0) {
+		size = rc;
+		goto out;
+	}
+	size += rc;
 	if (size < expected) {
 		dev_err(&chip->dev, "Unable to read remainder of result\n");
 		size = -ETIME;


