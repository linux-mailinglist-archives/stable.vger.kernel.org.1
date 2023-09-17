Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEFC7A3AA4
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240403AbjIQUHA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbjIQUGv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:06:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FACFB5
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:06:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F2EC433C7;
        Sun, 17 Sep 2023 20:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981206;
        bh=CoDla67E2KTpErJuLyOZc/REx67UTwKy4aJABHsKSN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uk+COaFAtvCGTTRcu6duxiwEwTDCfeIQU6M9bpX2g5PlNTPpeQe1+dKUaZVzTyA19
         tUbUR72A97fxIPCtYl3wj17/+ai41K/9cAZAo+iqC21ahHKUMYfRxn2YhRynCB5LSh
         1moTlyXnBkrmlqWndY61bjjHWn8i9RPZxDEQbuXc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 058/219] tpm_crb: Fix an error handling path in crb_acpi_add()
Date:   Sun, 17 Sep 2023 21:13:05 +0200
Message-ID: <20230917191043.115814523@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 9c377852ddfdc557b1370f196b0cfdf28d233460 ]

Some error paths don't call acpi_put_table() before returning.
Branch to the correct place instead of doing some direct return.

Fixes: 4d2732882703 ("tpm_crb: Add support for CRB devices based on Pluton")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Matthew Garrett <mgarrett@aurora.tech>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm_crb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index db0b774207d35..f45239e73c4ca 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -775,12 +775,13 @@ static int crb_acpi_add(struct acpi_device *device)
 				FW_BUG "TPM2 ACPI table has wrong size %u for start method type %d\n",
 				buf->header.length,
 				ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON);
-			return -EINVAL;
+			rc = -EINVAL;
+			goto out;
 		}
 		crb_pluton = ACPI_ADD_PTR(struct tpm2_crb_pluton, buf, sizeof(*buf));
 		rc = crb_map_pluton(dev, priv, buf, crb_pluton);
 		if (rc)
-			return rc;
+			goto out;
 	}
 
 	priv->sm = sm;
-- 
2.40.1



