Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC0B77AD51
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjHMVs0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjHMVsH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:48:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063551BE9
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:41:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EFF460B9D
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3409C433C9;
        Sun, 13 Aug 2023 21:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962915;
        bh=fdcXeXRWJyJDF02tP8DTmtxOIjkYmWa8oiWYmqT+qFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=174eIu2oqg4glqbjo14Ji/Z1ChTVrCJ8sJFcfR+VbQ1tYkSDhqZq9Vb6hEKrfr5Fa
         Ov4PX4yqMC8PZ4+sfoFCvK7NziBf+R85ELET2hf7T0dSbPPzCNUzqm1xHtWomKRlGY
         rX8LJ8RSJL0u4d/bSO/FQorWcydLsIJ5nmiKz9eA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 5.10 26/68] x86/cpu/amd: Enable Zenbleed fix for AMD Custom APU 0405
Date:   Sun, 13 Aug 2023 23:19:27 +0200
Message-ID: <20230813211708.953515083@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211708.149630011@linuxfoundation.org>
References: <20230813211708.149630011@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

commit 6dbef74aeb090d6bee7d64ef3fa82ae6fa53f271 upstream.

Commit

  522b1d69219d ("x86/cpu/amd: Add a Zenbleed fix")

provided a fix for the Zen2 VZEROUPPER data corruption bug affecting
a range of CPU models, but the AMD Custom APU 0405 found on SteamDeck
was not listed, although it is clearly affected by the vulnerability.

Add this CPU variant to the Zenbleed erratum list, in order to
unconditionally enable the fallback fix until a proper microcode update
is available.

Fixes: 522b1d69219d ("x86/cpu/amd: Add a Zenbleed fix")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230811203705.1699914-1-cristian.ciocaltea@collabora.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/amd.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -74,6 +74,7 @@ static const int amd_erratum_1054[] =
 static const int amd_zenbleed[] =
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x30, 0x0, 0x4f, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0x60, 0x0, 0x7f, 0xf),
+			   AMD_MODEL_RANGE(0x17, 0x90, 0x0, 0x91, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0xa0, 0x0, 0xaf, 0xf));
 
 static const int amd_div0[] =


