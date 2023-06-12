Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FFE72C0C8
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbjFLKyj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbjFLKyQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:54:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C942127
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:39:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC86B60F87
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF87AC433EF;
        Mon, 12 Jun 2023 10:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566390;
        bh=TtY7r4OsGVj5uNRc7hyfAMDNwKPWBfxhv1/qx1kQBjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F3m+/saHVVfsjTNqx2DoVoNN9XM7cmnv60mNAxQLfB+OmALJvlaDFt4uSI36eMQXX
         NsGUXIuPMu5b+qrBlMqe7fteMXJyRMNa6jiFMNS643pDV54/RQU27ch48Bjn/PLM9J
         +UAIdoGltIiIox72JaR9/CY2VCn/NVkrMTwmnMEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rhys Rustad-Elliott <me@rhysre.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 014/132] bpf: Fix elem_size not being set for inner maps
Date:   Mon, 12 Jun 2023 12:25:48 +0200
Message-ID: <20230612101710.925465520@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

From: Rhys Rustad-Elliott <me@rhysre.net>

[ Upstream commit cba41bb78d70aad98d8e61e019fd48c561f7f396 ]

Commit d937bc3449fa ("bpf: make uniform use of array->elem_size
everywhere in arraymap.c") changed array_map_gen_lookup to use
array->elem_size instead of round_up(map->value_size, 8) as the element
size when generating code to access a value in an array map.

array->elem_size, however, is not set by bpf_map_meta_alloc when
initializing an BPF_MAP_TYPE_ARRAY_OF_MAPS or BPF_MAP_TYPE_HASH_OF_MAPS.
This results in array_map_gen_lookup incorrectly outputting code that
always accesses index 0 in the array (as the index will be calculated
via a multiplication with the element size, which is incorrectly set to
0).

Set elem_size on the bpf_array object when allocating an array or hash
of maps to fix this.

Fixes: d937bc3449fa ("bpf: make uniform use of array->elem_size everywhere in arraymap.c")
Signed-off-by: Rhys Rustad-Elliott <me@rhysre.net>
Link: https://lore.kernel.org/r/20230602190110.47068-2-me@rhysre.net
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/map_in_map.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 135205d0d5607..8e87f69aae60d 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -61,9 +61,13 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	/* Misc members not needed in bpf_map_meta_equal() check. */
 	inner_map_meta->ops = inner_map->ops;
 	if (inner_map->ops == &array_map_ops) {
+		struct bpf_array *inner_array_meta =
+			container_of(inner_map_meta, struct bpf_array, map);
+		struct bpf_array *inner_array = container_of(inner_map, struct bpf_array, map);
+
+		inner_array_meta->index_mask = inner_array->index_mask;
+		inner_array_meta->elem_size = inner_array->elem_size;
 		inner_map_meta->bypass_spec_v1 = inner_map->bypass_spec_v1;
-		container_of(inner_map_meta, struct bpf_array, map)->index_mask =
-		     container_of(inner_map, struct bpf_array, map)->index_mask;
 	}
 
 	fdput(f);
-- 
2.39.2



