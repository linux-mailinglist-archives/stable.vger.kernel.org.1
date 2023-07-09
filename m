Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF2374C264
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjGILUI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjGILUH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:20:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4259BB5
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:20:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC75B60B86
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDBEC433C9;
        Sun,  9 Jul 2023 11:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901605;
        bh=S1bhMmEx2KHIOEtDt9bz+DrLS0IylhqsMLqlB3Kof6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hMYFNUaX1hnyMiT0Ruu8jNFG0c0/qbGFb4+lsnq1BHYgjO+p3Okgzp59Ll3XfEfYq
         leya/w4NApPBqAlP6Rd9uxi6/FmVt7xVE9eUH67f1BXddn0i5FNIAzf1+tj+1LIvz3
         F+pI9AT+L+nvKlYnPvBbi87MDpOpWoMkC9kRT+Io=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin KaFai Lau <martin.lau@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 080/431] libbpf: btf_dump_type_data_check_overflow needs to consider BTF_MEMBER_BITFIELD_SIZE
Date:   Sun,  9 Jul 2023 13:10:28 +0200
Message-ID: <20230709111453.028275715@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

[ Upstream commit c39028b333f3a3a765c5c0b9726b8e38aedf0ba1 ]

The btf_dump/struct_data selftest is failing with:

  [...]
  test_btf_dump_struct_data:FAIL:unexpected return value dumping fs_context unexpected unexpected return value dumping fs_context: actual -7 != expected 264
  [...]

The reason is in btf_dump_type_data_check_overflow(). It does not use
BTF_MEMBER_BITFIELD_SIZE from the struct's member (btf_member). Instead,
it is using the enum size which is 4. It had been working till the recent
commit 4e04143c869c ("fs_context: drop the unused lsm_flags member")
removed an integer member which also removed the 4 bytes padding at the
end of the fs_context. Missing this 4 bytes padding exposed this bug. In
particular, when btf_dump_type_data_check_overflow() reaches the member
'phase', -E2BIG is returned.

The fix is to pass bit_sz to btf_dump_type_data_check_overflow(). In
btf_dump_type_data_check_overflow(), it does a different size check when
bit_sz is not zero.

The current fs_context:

[3600] ENUM 'fs_context_purpose' encoding=UNSIGNED size=4 vlen=3
	'FS_CONTEXT_FOR_MOUNT' val=0
	'FS_CONTEXT_FOR_SUBMOUNT' val=1
	'FS_CONTEXT_FOR_RECONFIGURE' val=2
[3601] ENUM 'fs_context_phase' encoding=UNSIGNED size=4 vlen=7
	'FS_CONTEXT_CREATE_PARAMS' val=0
	'FS_CONTEXT_CREATING' val=1
	'FS_CONTEXT_AWAITING_MOUNT' val=2
	'FS_CONTEXT_AWAITING_RECONF' val=3
	'FS_CONTEXT_RECONF_PARAMS' val=4
	'FS_CONTEXT_RECONFIGURING' val=5
	'FS_CONTEXT_FAILED' val=6
[3602] STRUCT 'fs_context' size=264 vlen=21
	'ops' type_id=3603 bits_offset=0
	'uapi_mutex' type_id=235 bits_offset=64
	'fs_type' type_id=872 bits_offset=1216
	'fs_private' type_id=21 bits_offset=1280
	'sget_key' type_id=21 bits_offset=1344
	'root' type_id=781 bits_offset=1408
	'user_ns' type_id=251 bits_offset=1472
	'net_ns' type_id=984 bits_offset=1536
	'cred' type_id=1785 bits_offset=1600
	'log' type_id=3621 bits_offset=1664
	'source' type_id=42 bits_offset=1792
	'security' type_id=21 bits_offset=1856
	's_fs_info' type_id=21 bits_offset=1920
	'sb_flags' type_id=20 bits_offset=1984
	'sb_flags_mask' type_id=20 bits_offset=2016
	's_iflags' type_id=20 bits_offset=2048
	'purpose' type_id=3600 bits_offset=2080 bitfield_size=8
	'phase' type_id=3601 bits_offset=2088 bitfield_size=8
	'need_free' type_id=67 bits_offset=2096 bitfield_size=1
	'global' type_id=67 bits_offset=2097 bitfield_size=1
	'oldapi' type_id=67 bits_offset=2098 bitfield_size=1

Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20230428013638.1581263-1-martin.lau@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/btf_dump.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 580985ee55458..4d9f30bf7f014 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -2250,9 +2250,25 @@ static int btf_dump_type_data_check_overflow(struct btf_dump *d,
 					     const struct btf_type *t,
 					     __u32 id,
 					     const void *data,
-					     __u8 bits_offset)
+					     __u8 bits_offset,
+					     __u8 bit_sz)
 {
-	__s64 size = btf__resolve_size(d->btf, id);
+	__s64 size;
+
+	if (bit_sz) {
+		/* bits_offset is at most 7. bit_sz is at most 128. */
+		__u8 nr_bytes = (bits_offset + bit_sz + 7) / 8;
+
+		/* When bit_sz is non zero, it is called from
+		 * btf_dump_struct_data() where it only cares about
+		 * negative error value.
+		 * Return nr_bytes in success case to make it
+		 * consistent as the regular integer case below.
+		 */
+		return data + nr_bytes > d->typed_dump->data_end ? -E2BIG : nr_bytes;
+	}
+
+	size = btf__resolve_size(d->btf, id);
 
 	if (size < 0 || size >= INT_MAX) {
 		pr_warn("unexpected size [%zu] for id [%u]\n",
@@ -2407,7 +2423,7 @@ static int btf_dump_dump_type_data(struct btf_dump *d,
 {
 	int size, err = 0;
 
-	size = btf_dump_type_data_check_overflow(d, t, id, data, bits_offset);
+	size = btf_dump_type_data_check_overflow(d, t, id, data, bits_offset, bit_sz);
 	if (size < 0)
 		return size;
 	err = btf_dump_type_data_check_zero(d, t, id, data, bits_offset, bit_sz);
-- 
2.39.2



