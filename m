Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34B07ED0FD
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343950AbjKOT6o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343954AbjKOT6n (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:58:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AE41A5
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:58:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F34AC433C9;
        Wed, 15 Nov 2023 19:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078319;
        bh=pdqFqV43i7a1VzWvrrjmXNo3nctE27yNLbbVdQhDqic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GBg9aoqTNPfEljh1I4/ONrX/uxTpS5H0ranG9/KK8TGoIm+MVi8+6ZrOJp6TaBjkO
         9JSD/NCNkOcZDS+8kPghkxe+1roc4hgE7ijrVxo08jSW9ZyNLN+4vzFriQIaxXS0jA
         UJsoUT/XBslBVFxUeYAbxz5PF5pQF0yEzU9YrGNk=
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
Subject: [PATCH 6.1 225/379] scsi: ufs: core: Leave space for \0 in utf8 desc string
Date:   Wed, 15 Nov 2023 14:25:00 -0500
Message-ID: <20231115192658.429723002@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/ufs/core/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 6ba4ef2c3949e..dc38d1fa77874 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3579,7 +3579,7 @@ int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
 		 */
 		ret = utf16s_to_utf8s(uc_str->uc,
 				      uc_str->len - QUERY_DESC_HDR_SIZE,
-				      UTF16_BIG_ENDIAN, str, ascii_len);
+				      UTF16_BIG_ENDIAN, str, ascii_len - 1);
 
 		/* replace non-printable or non-ASCII characters with spaces */
 		for (i = 0; i < ret; i++)
-- 
2.42.0



