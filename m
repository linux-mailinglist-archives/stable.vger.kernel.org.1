Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745617CABF7
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjJPOr6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjJPOr6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:47:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE31D9
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:47:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640D6C433C8;
        Mon, 16 Oct 2023 14:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467675;
        bh=enXF8y3pkH4XLrGQo90yhnCLjxhDTUG9WadG/ovXy7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2wceqew7N6BjN88kYzCpYibZEjbsilvqRaiQGtm3VpyX4BQgRXPJ/u6hHvIm7Ciae
         KDbP3WPwSo4kYwhh1lwxH5vq9JmDny5PM+sboKUQ5Z9HZgsXBLePNkBkcXD6JTG6Qr
         nAusty7ke7P6mzanTZD/4A/1Q0gakzqllMRX1aWw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Vernet <void@manifault.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 069/191] bpf: Fix verifier log for async callback return values
Date:   Mon, 16 Oct 2023 10:40:54 +0200
Message-ID: <20231016084017.017012816@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Vernet <void@manifault.com>

[ Upstream commit 829955981c557c7fc7416581c4cd68a8a0c28620 ]

The verifier, as part of check_return_code(), verifies that async
callbacks such as from e.g. timers, will return 0. It does this by
correctly checking that R0->var_off is in tnum_const(0), which
effectively checks that it's in a range of 0. If this condition fails,
however, it prints an error message which says that the value should
have been in (0x0; 0x1). This results in possibly confusing output such
as the following in which an async callback returns 1:

  At async callback the register R0 has value (0x1; 0x0) should have been in (0x0; 0x1)

The fix is easy -- we should just pass the tnum_const(0) as the correct
range to verbose_invalid_scalar(), which will then print the following:

  At async callback the register R0 has value (0x1; 0x0) should have been in (0x0; 0x0)

Fixes: bfc6bb74e4f1 ("bpf: Implement verifier support for validation of async callbacks.")
Signed-off-by: David Vernet <void@manifault.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20231009161414.235829-1-void@manifault.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 93fd32f2957b7..104681258d24f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14255,7 +14255,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 	struct tnum enforce_attach_type_range = tnum_unknown;
 	const struct bpf_prog *prog = env->prog;
 	struct bpf_reg_state *reg;
-	struct tnum range = tnum_range(0, 1);
+	struct tnum range = tnum_range(0, 1), const_0 = tnum_const(0);
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
 	int err;
 	struct bpf_func_state *frame = env->cur_state->frame[0];
@@ -14303,8 +14303,8 @@ static int check_return_code(struct bpf_verifier_env *env)
 			return -EINVAL;
 		}
 
-		if (!tnum_in(tnum_const(0), reg->var_off)) {
-			verbose_invalid_scalar(env, reg, &range, "async callback", "R0");
+		if (!tnum_in(const_0, reg->var_off)) {
+			verbose_invalid_scalar(env, reg, &const_0, "async callback", "R0");
 			return -EINVAL;
 		}
 		return 0;
-- 
2.40.1



