Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B5A6FA5A7
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjEHKLl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbjEHKLk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:11:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C083A286
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:11:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07722623E2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17082C433EF;
        Mon,  8 May 2023 10:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540697;
        bh=bfYjoB3bAymDFYI4bEjabX22OdnWDFPlpWoSaRs6spw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MFRwrubtRdWAraKEUFvcuFOdt0vb08bbFCFWKuLLBuk/lrTS9kSMeVz2Wh+vlca2B
         FkI5TqBeOm0+d3XQ5f7oeaQjp+EhmXHoWPYvSOrHNVI2r7boBy0UjCwBsAEpW7qe4j
         28l4i8cyUVHn+TZifEOiivN+yEN+E988+24RFpSo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nathan Lynch <nathanl@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 464/611] powerpc/rtas: use memmove for potentially overlapping buffer copy
Date:   Mon,  8 May 2023 11:45:06 +0200
Message-Id: <20230508094437.218599906@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Nathan Lynch <nathanl@linux.ibm.com>

[ Upstream commit 271208ee5e335cb1ad280d22784940daf7ddf820 ]

Using memcpy() isn't safe when buf is identical to rtas_err_buf, which
can happen during boot before slab is up. Full context which may not
be obvious from the diff:

	if (altbuf) {
		buf = altbuf;
	} else {
		buf = rtas_err_buf;
		if (slab_is_available())
			buf = kmalloc(RTAS_ERROR_LOG_MAX, GFP_ATOMIC);
	}
	if (buf)
		memcpy(buf, rtas_err_buf, RTAS_ERROR_LOG_MAX);

This was found by inspection and I'm not aware of it causing problems
in practice. It appears to have been introduced by commit
033ef338b6e0 ("powerpc: Merge rtas.c into arch/powerpc/kernel"); the
old ppc64 version of this code did not have this problem.

Use memmove() instead.

Fixes: 033ef338b6e0 ("powerpc: Merge rtas.c into arch/powerpc/kernel")
Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230220-rtas-queue-for-6-4-v1-2-010e4416f13f@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/rtas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 767ab166933ba..f8d3caad4cf39 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -421,7 +421,7 @@ static char *__fetch_rtas_last_error(char *altbuf)
 				buf = kmalloc(RTAS_ERROR_LOG_MAX, GFP_ATOMIC);
 		}
 		if (buf)
-			memcpy(buf, rtas_err_buf, RTAS_ERROR_LOG_MAX);
+			memmove(buf, rtas_err_buf, RTAS_ERROR_LOG_MAX);
 	}
 
 	return buf;
-- 
2.39.2



