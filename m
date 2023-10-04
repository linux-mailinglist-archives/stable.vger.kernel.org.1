Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA017B87CF
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243898AbjJDSJg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243875AbjJDSJg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:09:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FEAC6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:09:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE1DC433C7;
        Wed,  4 Oct 2023 18:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442972;
        bh=teH68bR3y3XdIFqIRX3PGnCCJQuRnxh00udFVKXoBB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z2rWD4MdACnlP+fO1L9/HFU8TwA4iK1nc90Z/LcMbr5/4L85Vhtb41+D23uBKMZ5I
         ETEhoRAvwnmGeOzoGvylrxQvws+HRyn7CCT8dPbevW99DrIPPu9LBKxFlhKQFahK8i
         A9A+MAXzoyAFeIzPo47wheS6y7rclHLsGA9f5Hgs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Marcus Seyfarth <m.seyfarth@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 5.15 174/183] bpf: Fix BTF_ID symbol generation collision
Date:   Wed,  4 Oct 2023 19:56:45 +0200
Message-ID: <20231004175211.353478011@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit 8f908db77782630c45ba29dac35c434b5ce0b730 upstream.

Marcus and Satya reported an issue where BTF_ID macro generates same
symbol in separate objects and that breaks final vmlinux link.

ld.lld: error: ld-temp.o <inline asm>:14577:1: symbol
'__BTF_ID__struct__cgroup__624' is already defined

This can be triggered under specific configs when __COUNTER__ happens to
be the same for the same symbol in two different translation units,
which is already quite unlikely to happen.

Add __LINE__ number suffix to make BTF_ID symbol more unique, which is
not a complete fix, but it would help for now and meanwhile we can work
on better solution as suggested by Andrii.

Cc: stable@vger.kernel.org
Reported-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Reported-by: Marcus Seyfarth <m.seyfarth@gmail.com>
Closes: https://github.com/ClangBuiltLinux/linux/issues/1913
Debugged-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/bpf/CAEf4Bzb5KQ2_LmhN769ifMeSJaWfebccUasQOfQKaOd0nQ51tw@mail.gmail.com/
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20230915-bpf_collision-v3-1-263fc519c21f@google.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/btf_ids.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -38,7 +38,7 @@ asm(							\
 	____BTF_ID(symbol)
 
 #define __ID(prefix) \
-	__PASTE(prefix, __COUNTER__)
+	__PASTE(__PASTE(prefix, __COUNTER__), __LINE__)
 
 /*
  * The BTF_ID defines unique symbol for each ID pointing


