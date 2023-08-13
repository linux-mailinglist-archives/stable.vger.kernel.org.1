Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1358377AD00
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjHMVr5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjHMVpZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:45:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB83A2D54
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:45:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A2C961468
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2B4C433C7;
        Sun, 13 Aug 2023 21:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963123;
        bh=Y7MLSsbTCYLyn45Q2tJ0UVYlAzrXAQZhL3K/5HvB9/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ebcxHt9tlhDzp4+fcBuz2O6RjfMIeVhpK13k+2ogBt34WWiuMte5yzYvGjgRbRxdB
         102gfzTHjXapZdYzfOG23J0Ke/ZxjOTMo710yLjwPlaLsqTYxbysX+RLcMaT0yZMA9
         4kJJS92205R6+GD4jr4FK2DNLCxso1vf/51mcOSg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 62/89] nexthop: Make nexthop bucket dump more efficient
Date:   Sun, 13 Aug 2023 23:19:53 +0200
Message-ID: <20230813211712.649058656@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
References: <20230813211710.787645394@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ido Schimmel <idosch@nvidia.com>

commit f10d3d9df49d9e6ee244fda6ca264f901a9c5d85 upstream.

rtm_dump_nexthop_bucket_nh() is used to dump nexthop buckets belonging
to a specific resilient nexthop group. The function returns a positive
return code (the skb length) upon both success and failure.

The above behavior is problematic. When a complete nexthop bucket dump
is requested, the function that walks the different nexthops treats the
non-zero return code as an error. This causes buckets belonging to
different resilient nexthop groups to be dumped using different buffers
even if they can all fit in the same buffer:

 # ip link add name dummy1 up type dummy
 # ip nexthop add id 1 dev dummy1
 # ip nexthop add id 10 group 1 type resilient buckets 1
 # ip nexthop add id 20 group 1 type resilient buckets 1
 # strace -e recvmsg -s 0 ip nexthop bucket
 [...]
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[...], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 64
 id 10 index 0 idle_time 10.27 nhid 1
 [...]
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[...], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 64
 id 20 index 0 idle_time 6.44 nhid 1
 [...]

Fix by only returning a non-zero return code when an error occurred and
restarting the dump from the bucket index we failed to fill in. This
allows buckets belonging to different resilient nexthop groups to be
dumped using the same buffer:

 # ip link add name dummy1 up type dummy
 # ip nexthop add id 1 dev dummy1
 # ip nexthop add id 10 group 1 type resilient buckets 1
 # ip nexthop add id 20 group 1 type resilient buckets 1
 # strace -e recvmsg -s 0 ip nexthop bucket
 [...]
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[...], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 128
 id 10 index 0 idle_time 30.21 nhid 1
 id 20 index 0 idle_time 26.7 nhid 1
 [...]

While this change is more of a performance improvement change than an
actual bug fix, it is a prerequisite for a subsequent patch that does
fix a bug.

Fixes: 8a1bbabb034d ("nexthop: Add netlink handlers for bucket dump")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20230808075233.3337922-3-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/nexthop.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3364,25 +3364,19 @@ static int rtm_dump_nexthop_bucket_nh(st
 		    dd->filter.res_bucket_nh_id != nhge->nh->id)
 			continue;
 
+		dd->ctx->bucket_index = bucket_index;
 		err = nh_fill_res_bucket(skb, nh, bucket, bucket_index,
 					 RTM_NEWNEXTHOPBUCKET, portid,
 					 cb->nlh->nlmsg_seq, NLM_F_MULTI,
 					 cb->extack);
-		if (err < 0) {
-			if (likely(skb->len))
-				goto out;
-			goto out_err;
-		}
+		if (err)
+			return err;
 	}
 
 	dd->ctx->done_nh_idx = dd->ctx->nh.idx + 1;
-	bucket_index = 0;
+	dd->ctx->bucket_index = 0;
 
-out:
-	err = skb->len;
-out_err:
-	dd->ctx->bucket_index = bucket_index;
-	return err;
+	return 0;
 }
 
 static int rtm_dump_nexthop_bucket_cb(struct sk_buff *skb,


