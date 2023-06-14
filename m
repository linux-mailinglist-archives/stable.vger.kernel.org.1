Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFE4726C67
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjFGUdb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjFGUdZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:33:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7141735
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:33:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB6F164537
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA8AC433EF;
        Wed,  7 Jun 2023 20:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169998;
        bh=0IiHo2pEf/jXnNyOwlaN7LKVEaegHPvsZa2Bx/oLh3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=faZ0K83hZHH99WA/uvnWqX0xAD/Gdok1JN31MvDDoMRvUNv8TSd4uRVpwoL+IaCbH
         IyfUlwhPiU8JpCA7LLXJb8UhRGgy8hTMrK1WVrfw0hzKEqt94r37xXHNwKzdh2F4jz
         gCml5qDSbsXc+fePm7X5ZPEgksrSddTnXUQr6EeQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Onkarnath <onkarnath.1@samsung.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 6.3 266/286] powerpc/xmon: Use KSYM_NAME_LEN in array size
Date:   Wed,  7 Jun 2023 22:16:05 +0200
Message-ID: <20230607200931.995691857@linuxfoundation.org>
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

From: Maninder Singh <maninder1.s@samsung.com>

commit 719dfd5925e186e09a2a6f23016936ac436f3d78 upstream.

kallsyms_lookup() which in turn calls kallsyms_lookup_buildid() writes
to index "KSYM_NAME_LEN - 1".

Thus the array passed as namebuf to kallsyms_lookup() should be
KSYM_NAME_LEN in size.

In xmon.c the array was defined to be "128" bytes directly, without
using KSYM_NAME_LEN. Commit b8a94bfb3395 ("kallsyms: increase maximum
kernel symbol length to 512") changed the value to 512, but missed
updating the xmon code.

Fixes: b8a94bfb3395 ("kallsyms: increase maximum kernel symbol length to 512")
Cc: stable@vger.kernel.org # v6.1+
Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
[mpe: Tweak change log wording and fix commit reference]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230529111337.352990-2-maninder1.s@samsung.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/xmon/xmon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -88,7 +88,7 @@ static unsigned long ndump = 64;
 static unsigned long nidump = 16;
 static unsigned long ncsum = 4096;
 static int termch;
-static char tmpstr[128];
+static char tmpstr[KSYM_NAME_LEN];
 static int tracing_enabled;
 
 static long bus_error_jmp[JMP_BUF_LEN];


