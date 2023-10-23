Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0B97D31DA
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjJWLOC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbjJWLOB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:14:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26F7C1
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:13:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13774C433C7;
        Mon, 23 Oct 2023 11:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059639;
        bh=gh7Rq6RrNcFf3WKffDDEf2yRKSBmXoUaGkP/W6ed088=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KNisWxmv8iE25sx5xRYdNos6yW4S+NM57JejSx5+fULAiX/s+NAgKJFvOwgrAzyKm
         q69LjpRpVbvXPcghlZ5oHujjiAJ29LYtiNtvOTtLMK0M+TaPb9LDrz3S/LEY/4njt5
         2M5PKNRLpxwvbzfPTIhD5PCFl+nnutynfNprS0XE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.5 237/241] docs: rust: update Rust docs output path
Date:   Mon, 23 Oct 2023 12:57:03 +0200
Message-ID: <20231023104839.651450780@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miguel Ojeda <ojeda@kernel.org>

commit bd9e54a42ce26026d67963c21b3fdfe8c7e68430 upstream.

The Rust code documentation output path moved from `rust/doc` to
`Documentation/output/rust/rustdoc`, thus update the old reference.

Fixes: 48fadf440075 ("docs: Move rustdoc output, cross-reference it")
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
Link: https://lore.kernel.org/r/20231018160145.1017340-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/rust/general-information.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/rust/general-information.rst
+++ b/Documentation/rust/general-information.rst
@@ -29,7 +29,7 @@ target with the same invocation used for
 
 To read the docs locally in your web browser, run e.g.::
 
-	xdg-open rust/doc/kernel/index.html
+	xdg-open Documentation/output/rust/rustdoc/kernel/index.html
 
 To learn about how to write the documentation, please see coding-guidelines.rst.
 


