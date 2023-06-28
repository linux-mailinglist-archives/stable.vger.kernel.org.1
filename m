Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20779741C37
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 01:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjF1XLC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 19:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjF1XLB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 19:11:01 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D954B268F
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 16:10:59 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E08EE801101
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 23:03:50 +0000 (UTC)
Received: from pdx1-sub0-mail-a212.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 40BAF800FD4
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 23:03:50 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1687993430; a=rsa-sha256;
        cv=none;
        b=PazpMZT3NfWKeKrEIjW7+W3PvqwoeUFqfgHLt2Z07tgGj1jI21G35HUfgAifQRNgGD/IjT
        DR5shL0W0vzdewq30M4Wb8gCZILnbq4FlUUJhQWtN33xRI6Y5IoTgjDm2rwc9LujVsUlEL
        lTVTJYN12IpYc+rj5wXpwaTCU3pLgnby9lg0FvOgJ90OYZxWzky6CR76KdpJ5KvbzSoBe8
        qfv09PVkhjYXOguPWCh0WASaj+y3vo7t4mvIC3fZP4GA+o/r0MDYObTcL8TViTf2xFKmNA
        P/bbnrFEAYbW/8pWovsWXcDP4UJ9UUG6nkFmYdYf3eyYZzvtO8j7Mq05p1SGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1687993430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=5Pd262mNW9Q0VAnP3ExPfWIVwkad/9V6I6rrPLxF16o=;
        b=EL44uGJ7M7bFgd6JKUrpxCZAc8Dd6s6DVFMNRarGtCeJ8n29WQ/mIkzxn2YbhUo3tbNecD
        inZhuN8cuAXqJ1rdW8gVWYeeCf3GfThR55/V9wqU5qH/Be4dOmgEkkOcGKenTs3bCeIo5W
        9rWeEkExVJrhwGBMEY67RCCC+LlZHngLwKC6J8tUyDvyKHGN7WJi9g/rLjUqkbm7AX+uQb
        Bmo/7l99Eey1n+EZC5/mLVXM9mMTAjTdr+Dyn6TyCus9LKQ3lv9cLG6kf3qgFeLltYsxeZ
        Lijo+P/9u4gIWoD+isTxDLxMr7CJgSlQXNRAF/yyYUXilzpU+47H9WcbhqmfSA==
ARC-Authentication-Results: i=1;
        rspamd-7ccd4b867f-kjj98;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Illegal-Absorbed: 67e81360635cd1ad_1687993430759_819254647
X-MC-Loop-Signature: 1687993430759:1563987525
X-MC-Ingress-Time: 1687993430758
Received: from pdx1-sub0-mail-a212.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.209.211 (trex/6.9.1);
        Wed, 28 Jun 2023 23:03:50 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a212.dreamhost.com (Postfix) with ESMTPSA id 4Qrxw60NfFzl7
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 16:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1687993430;
        bh=5Pd262mNW9Q0VAnP3ExPfWIVwkad/9V6I6rrPLxF16o=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=ByHmlhNfQr5/0clulOnzfIe2ctP/LCPWOvHEyCFp1jIFoPoXUCbN/WK88fvdIKupf
         1wuK5VVjpyPXAoYCLZtYjhIDpPhZ9zFm+z0afbbZOvywOju8aOd/BP9KR5omYTK48/
         hHJ1U1T1k0tWt67kv4XCrHp2oOR+tsYRcSjqUq4E=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e003b
        by kmjvbox (DragonFly Mail Agent v0.12);
        Wed, 28 Jun 2023 16:03:39 -0700
Date:   Wed, 28 Jun 2023 16:03:39 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     stable@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.15.y] bpf: ensure main program has an extable
Message-ID: <20230628230339.GB1918@templeofstupid.com>
References: <2023062341-reunite-senior-f0c0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023062341-reunite-senior-f0c0@gregkh>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 0108a4e9f3584a7a2c026d1601b0682ff7335d95 upstream.

When subprograms are in use, the main program is not jit'd after the
subprograms because jit_subprogs sets a value for prog->bpf_func upon
success.  Subsequent calls to the JIT are bypassed when this value is
non-NULL.  This leads to a situation where the main program and its
func[0] counterpart are both in the bpf kallsyms tree, but only func[0]
has an extable.  Extables are only created during JIT.  Now there are
two nearly identical program ksym entries in the tree, but only one has
an extable.  Depending upon how the entries are placed, there's a chance
that a fault will call search_extable on the aux with the NULL entry.

Since jit_subprogs already copies state from func[0] to the main
program, include the extable pointer in this state duplication.
Additionally, ensure that the copy of the main program in func[0] is not
added to the bpf_prog_kallsyms table. Instead, let the main program get
added later in bpf_prog_load().  This ensures there is only a single
copy of the main program in the kallsyms table, and that its tag matches
the tag observed by tooling like bpftool.

Cc: stable@vger.kernel.org
Fixes: 1c2a088a6626 ("bpf: x64: add JIT support for multi-function programs")
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Link: https://lore.kernel.org/r/6de9b2f4b4724ef56efbb0339daaa66c8b68b1e7.1686616663.git.kjlx@templeofstupid.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 kernel/bpf/verifier.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4f2271f27a1d..a89cd34eb5d4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12588,9 +12588,10 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	}
 
 	/* finally lock prog and jit images for all functions and
-	 * populate kallsysm
+	 * populate kallsysm. Begin at the first subprogram, since
+	 * bpf_prog_load will add the kallsyms for the main program.
 	 */
-	for (i = 0; i < env->subprog_cnt; i++) {
+	for (i = 1; i < env->subprog_cnt; i++) {
 		bpf_prog_lock_ro(func[i]);
 		bpf_prog_kallsyms_add(func[i]);
 	}
@@ -12615,6 +12616,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 
 	prog->jited = 1;
 	prog->bpf_func = func[0]->bpf_func;
+	prog->jited_len = func[0]->jited_len;
+	prog->aux->extable = func[0]->aux->extable;
+	prog->aux->num_exentries = func[0]->aux->num_exentries;
 	prog->aux->func = func;
 	prog->aux->func_cnt = env->subprog_cnt;
 	bpf_prog_jit_attempt_done(prog);
-- 
2.25.1

