Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F389778337A
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjHUUDs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjHUUDr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:03:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1197711C
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:03:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C3FF64880
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF93C433C7;
        Mon, 21 Aug 2023 20:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648225;
        bh=Jc0F6imRx6iuhSuwPHk2gJscSUX/TTHPAs2uzOeVCO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Bj3pZ+G6QOTN08Dp7hXM8bICzzydVM8/QCufgddHodWQQieQkNSPuiS6h7G3bUlS
         DVgxkzWxZBnj/YKsMbgf7ZDJVG890fM/IFsvw5i7Q46EWRqy09CA98oky/UkYOqazl
         9YfU9hCP2brghCNVEoi2LcByWSABy1DL/z1iL13k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Qingsong Chen <changxian.cqs@antgroup.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= 
        <sergio.collado@gmail.com>, Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.4 092/234] rust: macros: vtable: fix `HAS_*` redefinition (`gen_const_name`)
Date:   Mon, 21 Aug 2023 21:40:55 +0200
Message-ID: <20230821194132.869666160@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Qingsong Chen <changxian.cqs@antgroup.com>

commit 3fa7187eceee11998f756481e45ce8c4f9d9dc48 upstream.

If we define the same function name twice in a trait (using `#[cfg]`),
the `vtable` macro will redefine its `gen_const_name`, e.g. this will
define `HAS_BAR` twice:

    #[vtable]
    pub trait Foo {
        #[cfg(CONFIG_X)]
        fn bar();

        #[cfg(not(CONFIG_X))]
        fn bar(x: usize);
    }

Fixes: b44becc5ee80 ("rust: macros: add `#[vtable]` proc macro")
Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Sergio González Collado <sergio.collado@gmail.com>
Link: https://lore.kernel.org/r/20230808025404.2053471-1-changxian.cqs@antgroup.com
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/macros/vtable.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/macros/vtable.rs b/rust/macros/vtable.rs
index 34d5e7fb5768..ee06044fcd4f 100644
--- a/rust/macros/vtable.rs
+++ b/rust/macros/vtable.rs
@@ -74,6 +74,7 @@ pub(crate) fn vtable(_attr: TokenStream, ts: TokenStream) -> TokenStream {
                 const {gen_const_name}: bool = false;",
             )
             .unwrap();
+            consts.insert(gen_const_name);
         }
     } else {
         const_items = "const USE_VTABLE_ATTR: () = ();".to_owned();
-- 
2.41.0



