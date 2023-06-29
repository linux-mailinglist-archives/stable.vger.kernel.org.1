Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7705E741DAB
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 03:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjF2Bfb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 21:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjF2Bfa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 21:35:30 -0400
Received: from cheetah.elm.relay.mailchannels.net (cheetah.elm.relay.mailchannels.net [23.83.212.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F001E4B
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 18:35:29 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7F558141405
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 01:35:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a212.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0DE21141E8B
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 01:35:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1688002528; a=rsa-sha256;
        cv=none;
        b=ogTjgi71Rwm0qJ+z/XZLK2Q5di+165lca6rEzzibdhdr14nJW6JHPUDf/fwUMFwotfVEID
        0inedcwBVUkDQRnmh0pmV3fi0j1vl4JGRu+KsatPulF1rz3bVGOSHgk+VJAPQurWzG4rfC
        qwqmKby1wtyxRi/pHJmP2tIHHIgkSOqvOLm6ePoOjpRqfTrz/8OGYR1k0ATUzsaTWzQnEX
        5ASy01SFyk3iM2VgrXIhvOAYD6gkHqzWo1bhAvj7yTzAVgi1mvKDFtEpVKrdyOt19IkZv3
        wUWR8XUS7YZruK1GKNM2hMI9kkAL6X7eEVRY1SBfepiUePFLHQ4iTvwB8UvRuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1688002528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=dFnzrv6aiZPQiCnyjlwkJ/c5UV0bY0knoSpXD/8sdww=;
        b=9RmAY4v+5cTfo7FJ/w9eDQd6Us/9I00PBmoL/4PFmCePPikdN58lf3sud5O8RzcU/6T0cc
        SlLbEupNfVhVTQww2UhsgBnKGaN0nNh3WdQCoqbMTZTJJM5/AqDQjqlawy1z0TP6uSeQAZ
        FC7oSd9+E2VYhf8TzJlRrbKSlvm2z3panKbEHtBmQLjr9cEY9pXe6Vftx5rQroe/9l2WD5
        UQ/ARzJbb+v4lKbYzMRHch5qmnsq9qLr7cPI3S9NBKdH06fIGzqYKHM9cRH0ml4+eDFhk9
        ZXwZiPK2Q0mSkAPU0wlBHJ3kfVhm+dWpHXe7J52l1ydroAjNkb6jNTBXA91kqA==
ARC-Authentication-Results: i=1;
        rspamd-9fcc56855-lfnmh;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Grain-Print: 7f6791fc105ef33a_1688002528308_3056925537
X-MC-Loop-Signature: 1688002528308:1508754637
X-MC-Ingress-Time: 1688002528308
Received: from pdx1-sub0-mail-a212.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.59.48 (trex/6.9.1);
        Thu, 29 Jun 2023 01:35:28 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a212.dreamhost.com (Postfix) with ESMTPSA id 4Qs1H35YBqzl7
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 18:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1688002527;
        bh=dFnzrv6aiZPQiCnyjlwkJ/c5UV0bY0knoSpXD/8sdww=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=f0rgp7PTgrSQdx241SWlhNzH6en/IeMiGygT7NiUqYT/Y8njR26vUAUSOss2lPvKW
         I7WjkrHu93FKg8sb3WrpFZ6cgOybOC8UuzTBHMGey02dVaUo3T824cZPN//BiczGfc
         DEG98lSv6/SiZRlshvnrVxb1XoTjhDQZOqK3HcjI=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e003b
        by kmjvbox (DragonFly Mail Agent v0.12);
        Wed, 28 Jun 2023 18:35:08 -0700
Date:   Wed, 28 Jun 2023 18:35:08 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     stable@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.15.y v2] bpf: ensure main program has an extable
Message-ID: <20230629013508.GF1918@templeofstupid.com>
References: <20230628230339.GB1918@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628230339.GB1918@templeofstupid.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
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
 kernel/bpf/verifier.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4f2271f27a1d..7a70595c3c15 100644
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
@@ -12615,6 +12616,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 
 	prog->jited = 1;
 	prog->bpf_func = func[0]->bpf_func;
+	prog->aux->extable = func[0]->aux->extable;
+	prog->aux->num_exentries = func[0]->aux->num_exentries;
 	prog->aux->func = func;
 	prog->aux->func_cnt = env->subprog_cnt;
 	bpf_prog_jit_attempt_done(prog);
-- 
2.25.1

