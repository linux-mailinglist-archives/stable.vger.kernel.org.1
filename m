Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2119A726B6C
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjFGUZT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbjFGUZA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:25:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5890B2118
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:24:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3452B64410
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4710AC433D2;
        Wed,  7 Jun 2023 20:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169477;
        bh=KkYjgmZrDx0+x484SYQKRr1+kRqvSeM1yMRuJuOSUAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=slQTsirp2UDR8iI18XPL3MjL6skCaNs5ThSFh1nvhmay7HQ9fp7yVBa+XYhNE2UVX
         pZEjwTvC+z5+BTaxjBf6MHX8r29BXTUrJxu9cliaHyGp5zLtkMrW353gC78ssn9Tb9
         +IQjIsPLsyrLbRlF1Y0HqiMxCPzLo7bDaFeaba9E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bert Karwatzki <spasswolf@web.de>,
        Simon Horman <simon.horman@corigine.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 068/286] net: ipa: Use correct value for IPA_STATUS_SIZE
Date:   Wed,  7 Jun 2023 22:12:47 +0200
Message-ID: <20230607200925.294009624@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bert Karwatzki <spasswolf@web.de>

[ Upstream commit be7f8012a513f5099916ee2da28420156cbb8cf3 ]

IPA_STATUS_SIZE was introduced in commit b8dc7d0eea5a as a replacement
for the size of the removed struct ipa_status which had size
sizeof(__le32[8]). Use this value as IPA_STATUS_SIZE.

Fixes: b8dc7d0eea5a ("net: ipa: stop using sizeof(status)")
Signed-off-by: Bert Karwatzki <spasswolf@web.de>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230531103618.102608-1-spasswolf@web.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ipa/ipa_endpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 2ee80ed140b72..afa1d56d9095c 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -119,7 +119,7 @@ enum ipa_status_field_id {
 };
 
 /* Size in bytes of an IPA packet status structure */
-#define IPA_STATUS_SIZE			sizeof(__le32[4])
+#define IPA_STATUS_SIZE			sizeof(__le32[8])
 
 /* IPA status structure decoder; looks up field values for a structure */
 static u32 ipa_status_extract(struct ipa *ipa, const void *data,
-- 
2.39.2



