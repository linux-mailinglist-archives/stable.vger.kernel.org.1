Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0197B761593
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjGYLai (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbjGYLag (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:30:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEA3FB
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:30:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1E136168F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC559C433C8;
        Tue, 25 Jul 2023 11:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284635;
        bh=npFpegyrrwuj/MaFWb++Y4O9yLqjcLeLYDoUmAW2YqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fyPPz3NEHydQEu5h25X3eWvkjpK5z78rfmyKPusWyRonviR//hY7dgsUHQpatkg2A
         3+2li9KWqx2xn83aaVs9tIzkN8GGJhPaIHQEx/fD9Mp7NETX1rm/tUb2OFYdwxyQUV
         mrPgjAG8EuSs31D38/WWjFJsLFUWmBcdboVc9w2w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 5.10 426/509] xtensa: ISS: fix call to split_if_spec
Date:   Tue, 25 Jul 2023 12:46:05 +0200
Message-ID: <20230725104613.196772921@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

commit bc8d5916541fa19ca5bc598eb51a5f78eb891a36 upstream.

split_if_spec expects a NULL-pointer as an end marker for the argument
list, but tuntap_probe never supplied that terminating NULL. As a result
incorrectly formatted interface specification string may cause a crash
because of the random memory access. Fix that by adding NULL terminator
to the split_if_spec argument list.

Cc: stable@vger.kernel.org
Fixes: 7282bee78798 ("[PATCH] xtensa: Architecture support for Tensilica Xtensa Part 8")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/xtensa/platforms/iss/network.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -231,7 +231,7 @@ static int tuntap_probe(struct iss_net_p
 
 	init += sizeof(TRANSPORT_TUNTAP_NAME) - 1;
 	if (*init == ',') {
-		rem = split_if_spec(init + 1, &mac_str, &dev_name);
+		rem = split_if_spec(init + 1, &mac_str, &dev_name, NULL);
 		if (rem != NULL) {
 			pr_err("%s: extra garbage on specification : '%s'\n",
 			       dev->name, rem);


