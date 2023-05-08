Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8696FA7EA
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjEHKgK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbjEHKfj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:35:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7D428A9B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:35:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9507C6275B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8951BC433D2;
        Mon,  8 May 2023 10:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542110;
        bh=fBFL9+PIfeCp40C6QPglbMpLJe06EUgkt5DoA5AXVI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1tJ6SUhdeFVbycD5epNKU4RYcvhCTRK8DCoqIIIXd4v6n0kmH072JbY1XRvjDs7i
         YdkRyAQ5L3wFfsYguyLE4R/vWi4XKF5Bj2caoauyhJRVy/m7UT6mt9To9bjvvj4VXl
         X4bsTgKLpLxgtBAnGzVWyaZ2PBz/Q0IXk/PSImyQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Vernet <void@manifault.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 330/663] bpf: Add __bpf_kfunc tag for marking kernel functions as kfuncs
Date:   Mon,  8 May 2023 11:42:36 +0200
Message-Id: <20230508094438.888182698@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: David Vernet <void@manifault.com>

[ Upstream commit 57e7c169cd6afa093d858b8edfb9bceaf2e1c93b ]

kfuncs are functions defined in the kernel, which may be invoked by BPF
programs. They may or may not also be used as regular kernel functions,
implying that they may be static (in which case the compiler could e.g.
inline it away, or elide one or more arguments), or it could have
external linkage, but potentially be elided in an LTO build if a
function is observed to never be used, and is stripped from the final
kernel binary.

This has already resulted in some issues, such as those discussed in [0]
wherein changes in DWARF that identify when a parameter has been
optimized out can break BTF encodings (and in general break the kfunc).

[0]: https://lore.kernel.org/all/1675088985-20300-2-git-send-email-alan.maguire@oracle.com/

We therefore require some convenience macro that kfunc developers can
use just add to their kfuncs, and which will prevent all of the above
issues from happening. This is in contrast with what we have today,
where some kfunc definitions have "noinline", some have "__used", and
others are static and have neither.

Note that longer term, this mechanism may be replaced by a macro that
more closely resembles EXPORT_SYMBOL_GPL(), as described in [1]. For
now, we're going with this shorter-term approach to fix existing issues
in kfuncs.

[1]: https://lore.kernel.org/lkml/Y9AFT4pTydKh+PD3@maniforge.lan/

Note as well that checkpatch complains about this patch with the
following:

ERROR: Macros with complex values should be enclosed in parentheses
+#define __bpf_kfunc __used noinline

There seems to be a precedent for using this pattern in other places
such as compiler_types.h (see e.g. __randomize_layout and noinstr), so
it seems appropriate.

Signed-off-by: David Vernet <void@manifault.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Stanislav Fomichev <sdf@google.com>
Link: https://lore.kernel.org/bpf/20230201173016.342758-2-void@manifault.com
Stable-dep-of: f6a6a5a97628 ("bpf: Fix struct_meta lookup for bpf_obj_free_fields kfunc call")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/btf.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 5f628f323442a..ff62fa63dc197 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -72,6 +72,14 @@
 #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
 #define KF_RCU          (1 << 7) /* kfunc only takes rcu pointer arguments */
 
+/*
+ * Tag marking a kernel function as a kfunc. This is meant to minimize the
+ * amount of copy-paste that kfunc authors have to include for correctness so
+ * as to avoid issues such as the compiler inlining or eliding either a static
+ * kfunc, or a global kfunc in an LTO build.
+ */
+#define __bpf_kfunc __used noinline
+
 /*
  * Return the name of the passed struct, if exists, or halt the build if for
  * example the structure gets renamed. In this way, developers have to revisit
-- 
2.39.2



