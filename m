Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D56F7B895B
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244167AbjJDSZM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243743AbjJDSZM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:25:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1DE9E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:25:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B002C433C7;
        Wed,  4 Oct 2023 18:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443908;
        bh=k+bsq5049TarUxRba2rBF9u2mHlX7U4FgXtfxxMqaGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ue84HxIKQSYTVBGuP52IsYNN7a3sWy8nvfpx+slQHoAg3N+RHc5kCuw7OQpEkb/A/
         yPQduvhaDmqmICt3vuB/AZGdxzE61wGgsGUUIl/XrHTc2Q3RB854+03KYwcKWGi9vE
         HXrwQPKsH3foZ8A2SQp96UWiEfb+hAyY0c5nkcsg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ilya Leoshkevich <iii@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florian Westphal <fw@strlen.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 063/321] netfilter, bpf: Adjust timeouts of non-confirmed CTs in bpf_ct_insert_entry()
Date:   Wed,  4 Oct 2023 19:53:28 +0200
Message-ID: <20231004175232.095008544@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Leoshkevich <iii@linux.ibm.com>

[ Upstream commit 837723b22a63cfbff584655b009b9d488d0e9087 ]

bpf_nf testcase fails on s390x: bpf_skb_ct_lookup() cannot find the entry
that was added by bpf_ct_insert_entry() within the same BPF function.

The reason is that this entry is deleted by nf_ct_gc_expired().

The CT timeout starts ticking after the CT confirmation; therefore
nf_conn.timeout is initially set to the timeout value, and
__nf_conntrack_confirm() sets it to the deadline value.

bpf_ct_insert_entry() sets IPS_CONFIRMED_BIT, but does not adjust the
timeout, making its value meaningless and causing false positives.

Fix the problem by making bpf_ct_insert_entry() adjust the timeout,
like __nf_conntrack_confirm().

Fixes: 2cdaa3eefed8 ("netfilter: conntrack: restore IPS_CONFIRMED out of nf_conntrack_hash_check_insert()")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Florian Westphal <fw@strlen.de>
Link: https://lore.kernel.org/bpf/20230830011128.1415752-3-iii@linux.ibm.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_bpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index 0d36d7285e3f0..747dc22655018 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -380,6 +380,8 @@ __bpf_kfunc struct nf_conn *bpf_ct_insert_entry(struct nf_conn___init *nfct_i)
 	struct nf_conn *nfct = (struct nf_conn *)nfct_i;
 	int err;
 
+	if (!nf_ct_is_confirmed(nfct))
+		nfct->timeout += nfct_time_stamp;
 	nfct->status |= IPS_CONFIRMED;
 	err = nf_conntrack_hash_check_insert(nfct);
 	if (err < 0) {
-- 
2.40.1



