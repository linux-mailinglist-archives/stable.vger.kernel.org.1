Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD9C761322
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbjGYLIW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbjGYLHx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:07:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963F23C2A
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:06:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0443D61682
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CF7C433C7;
        Tue, 25 Jul 2023 11:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283180;
        bh=E4K5GKOBXmBHOs/AJ1W4VoAHka+ZnYpQrYnrDzF6WkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rF613tX3I1Seqxmrn2aI87qPTCsnrKnwYSLWkKda5RI9FrdVfzVhJZPwcOo91yHw9
         0l0qnHJcnks0C0qWcgL5jVHZ6LLGqw5qy4TYm/CT8vkAj7feI9GZCMlGcCYID27F94
         wHfMYFUvnIhIQbfxWP4FdQog9dGKHu3vM7A3aIQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 6.1 168/183] kallsyms: add kallsyms_seqs_of_names to list of special symbols
Date:   Tue, 25 Jul 2023 12:46:36 +0200
Message-ID: <20230725104513.822874381@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit ced0f245ed951e2b8bd68f79c15238d7dd253662 upstream.

My randconfig build setup ran into another kallsyms warning:

Inconsistent kallsyms data
Try make KALLSYMS_EXTRA_PASS=1 as a workaround

After adding some debugging code to kallsyms.c, I saw that the recently
added kallsyms_seqs_of_names symbol can sometimes cause the second stage
table to be slightly longer than the first stage, which makes the
build inconsistent.

Add it to the exception table that contains all other kallsyms-generated
symbols.

Fixes: 60443c88f3a8 ("kallsyms: Improve the performance of kallsyms_lookup_name()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/kallsyms.c |    1 +
 1 file changed, 1 insertion(+)

--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -118,6 +118,7 @@ static bool is_ignored_symbol(const char
 		"kallsyms_markers",
 		"kallsyms_token_table",
 		"kallsyms_token_index",
+		"kallsyms_seqs_of_names",
 		/* Exclude linker generated symbols which vary between passes */
 		"_SDA_BASE_",		/* ppc */
 		"_SDA2_BASE_",		/* ppc */


