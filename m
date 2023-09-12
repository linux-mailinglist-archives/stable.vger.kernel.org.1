Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B7D79AE56
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379472AbjIKWoW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238361AbjIKNye (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:54:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232BCFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:54:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FE7C433C8;
        Mon, 11 Sep 2023 13:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440469;
        bh=AKsZOj9sqWZiB+o0OSfdOYCpVJsBDwYYiNoBRI9R3Zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mfCLqlLJfmJ4fo6qHsUg/mpn01J+cB318uqTr+5car4qz/aGciMvO9J8FdWx+VDrs
         nOG+ta7oBfoPXANN+0O63Ugx44px9tgUqEehGESws8hfwp/hZKS+pAjBZarHXSSPBw
         WFsYa56Rw5MtmTmRE5N/DE87Lc0Rr5bIzfFZ8tsQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 072/739] bpf: Fix an error in verifying a field in a union
Date:   Mon, 11 Sep 2023 15:37:51 +0200
Message-ID: <20230911134653.131298454@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yafang Shao <laoar.shao@gmail.com>

[ Upstream commit 33937607efa050d9e237e0c4ac4ada02d961c466 ]

We are utilizing BPF LSM to monitor BPF operations within our container
environment. When we add support for raw_tracepoint, it hits below
error.

; (const void *)attr->raw_tracepoint.name);
27: (79) r3 = *(u64 *)(r2 +0)
access beyond the end of member map_type (mend:4) in struct (anon) with off 0 size 8

It can be reproduced with below BPF prog.

SEC("lsm/bpf")
int BPF_PROG(bpf_audit, int cmd, union bpf_attr *attr, unsigned int size)
{
	switch (cmd) {
	case BPF_RAW_TRACEPOINT_OPEN:
		bpf_printk("raw_tracepoint is %s", attr->raw_tracepoint.name);
		break;
	default:
		break;
	}
	return 0;
}

The reason is that when accessing a field in a union, such as bpf_attr,
if the field is located within a nested struct that is not the first
member of the union, it can result in incorrect field verification.

  union bpf_attr {
      struct {
          __u32 map_type; <<<< Actually it will find that field.
          __u32 key_size;
          __u32 value_size;
         ...
      };
      ...
      struct {
          __u64 name;    <<<< We want to verify this field.
          __u32 prog_fd;
      } raw_tracepoint;
  };

Considering the potential deep nesting levels, finding a perfect
solution to address this issue has proven challenging. Therefore, I
propose a solution where we simply skip the verification process if the
field in question is located within a union.

Fixes: 7e3617a72df3 ("bpf: Add array support to btf_struct_access")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Link: https://lore.kernel.org/r/20230713025642.27477-4-laoar.shao@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7ed82a8d117b7..4b38c97990872 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6366,7 +6366,7 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 		 * that also allows using an array of int as a scratch
 		 * space. e.g. skb->cb[].
 		 */
-		if (off + size > mtrue_end) {
+		if (off + size > mtrue_end && !(*flag & PTR_UNTRUSTED)) {
 			bpf_log(log,
 				"access beyond the end of member %s (mend:%u) in struct %s with off %u size %u\n",
 				mname, mtrue_end, tname, off, size);
-- 
2.40.1



