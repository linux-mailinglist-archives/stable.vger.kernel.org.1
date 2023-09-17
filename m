Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9027A3939
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbjIQTql (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240008AbjIQTqP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:46:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677C8C6
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:46:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA81C433CD;
        Sun, 17 Sep 2023 19:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979970;
        bh=vHpKZ6ygbD1ryBMjCDdZK3wqDeejLqkGC3/uRtj2/+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rRY3LVwiXbRoCtjK7G5bD59PSV+ehW2wfTV1YW5hHnbrfSyhVUIe/Tg0tmVJ7f7Xq
         A2sGiq95Z+D4J3jjeVtd8VmgWPYqBVQ8u4dekpfHHv63Sp9BmbaO+TmDGmRJCx83Po
         iCiCTfP7HT33PQ2w0O7S353XLME4Q6Kp/2UqVNtU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 059/285] tpm_crb: Fix an error handling path in crb_acpi_add()
Date:   Sun, 17 Sep 2023 21:10:59 +0200
Message-ID: <20230917191053.738148784@linuxfoundation.org>
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
index a5dbebb1acfcf..ea085b14ab7c9 100644
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



