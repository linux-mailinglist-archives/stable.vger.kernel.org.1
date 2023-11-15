Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5E47ED409
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbjKOU41 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343800AbjKOU4Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:56:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F86181
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:56:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA289C4E777;
        Wed, 15 Nov 2023 20:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081781;
        bh=QPP9Lwt0ICzZ2eO+WxO82T9f/4CE66Yb49vTXwzMECQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KCyzhzv27jOxHcxlw+jD6LDYmFc+xnENv+CaE3V9PsLW0/lPIhjhIjkmxDZnZxXUH
         FV5t0pi/oORxm2qDw0S3ektXTYoE7z9Axm2jV4U/80Lgu6JiKlHhZamB550LBVCi2c
         qnnFMa6TQwOPNRF8uqtXNUAg187whHblxQ1CuuCU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mars Cheng <marscheng@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Yen-lin Lai <yenlinlai@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        Avri Altman <avri.altman@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 104/191] scsi: ufs: core: Leave space for \0 in utf8 desc string
Date:   Wed, 15 Nov 2023 15:46:19 -0500
Message-ID: <20231115204650.821034352@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Mentz <danielmentz@google.com>

[ Upstream commit a75a16c62a2540f11eeae4f2b50e95deefb652ea ]

utf16s_to_utf8s does not NULL terminate the output string. For us to be
able to add a NULL character when utf16s_to_utf8s returns, we need to make
sure that there is space for such NULL character at the end of the output
buffer. We can achieve this by passing an output buffer size to
utf16s_to_utf8s that is one character less than what we allocated.

Other call sites of utf16s_to_utf8s appear to be using the same technique
where they artificially reduce the buffer size by one to leave space for a
NULL character or line feed character.

Fixes: 4b828fe156a6 ("scsi: ufs: revamp string descriptor reading")
Reviewed-by: Mars Cheng <marscheng@google.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Yen-lin Lai <yenlinlai@google.com>
Signed-off-by: Daniel Mentz <danielmentz@google.com>
Link: https://lore.kernel.org/r/20231017182026.2141163-1-danielmentz@google.com
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index f3389e9131794..a432aebd14be6 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3339,7 +3339,7 @@ int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
 		 */
 		ret = utf16s_to_utf8s(uc_str->uc,
 				      uc_str->len - QUERY_DESC_HDR_SIZE,
-				      UTF16_BIG_ENDIAN, str, ascii_len);
+				      UTF16_BIG_ENDIAN, str, ascii_len - 1);
 
 		/* replace non-printable or non-ASCII characters with spaces */
 		for (i = 0; i < ret; i++)
-- 
2.42.0



