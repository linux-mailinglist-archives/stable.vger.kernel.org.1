Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D82761323
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbjGYLIX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjGYLHy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:07:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089633C3A
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:06:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE9F761648
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC89C433C7;
        Tue, 25 Jul 2023 11:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283183;
        bh=gAI8hI2wC0NJRAjT5qWBDsYQEBGkDtR5xZ4D0Mj64D0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jKE+EHDtLAIDu1zxAvwMkjFemDGxTN7TRzmpOCjlMRiqpmYft2hSGP1T6KBNj8hLW
         MYKOQqYxSSXoY52QYp1MPlADooCa1v7S9hPJeRGNixJ0WVE/iXluuQsIC5Pi9OO9N8
         fZAN+Xh62CrgGFjRSnTCyAKuArKWBLx0RWKjmkmI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuma Ueda <cyan@0x00a1e9.dev>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.1 169/183] scripts/kallsyms.c Make the comment up-to-date with current implementation
Date:   Tue, 25 Jul 2023 12:46:37 +0200
Message-ID: <20230725104513.851301667@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
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

From: Yuma Ueda <cyan@0x00a1e9.dev>

commit adc40221bf676f3e722d135889a7b913b4162dc2 upstream.

The comment in scripts/kallsyms.c describing the usage of
scripts/kallsyms does not reflect the latest implementation.
Fix the comment to be equivalent to what the usage() function prints.

Signed-off-by: Yuma Ueda <cyan@0x00a1e9.dev>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://lore.kernel.org/r/20221118133631.4554-1-cyan@0x00a1e9.dev
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/kallsyms.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -5,7 +5,8 @@
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
  *
- * Usage: nm -n vmlinux | scripts/kallsyms [--all-symbols] > symbols.S
+ * Usage: kallsyms [--all-symbols] [--absolute-percpu]
+ *                         [--base-relative] in.map > out.S
  *
  *      Table compression uses all the unused char codes on the symbols and
  *  maps these to the most used substrings (tokens). For instance, it might


