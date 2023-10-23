Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9AA7D3530
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbjJWLqI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbjJWLpm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:45:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EF3173C
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:45:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB35CC433C9;
        Mon, 23 Oct 2023 11:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061537;
        bh=aKn9cj9eJdw7WmEbeWewMBGSSSdhBDLVskRNXj4F4iU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UPyRvS7omvgccu5jHeNjMJJ82nX5lxIbuBLOc/qw+PPezfWhy9X+ivaBwh5a0sdTv
         304xix+GcSmUDXd/tZCCZdpj6UPudc9uMZAGpMedOMRgMggpbx8AWJo3ZhEwhXgsRI
         uQLpYPC8FM2m6MBdEbJJ0+fbqE5T23TFH/IVSLCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 5.10 081/202] dev_forward_skb: do not scrub skb mark within the same name space
Date:   Mon, 23 Oct 2023 12:56:28 +0200
Message-ID: <20231023104828.912986697@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>

commit ff70202b2d1ad522275c6aadc8c53519b6a22c57 upstream.

The goal is to keep the mark during a bpf_redirect(), like it is done for
legacy encapsulation / decapsulation, when there is no x-netns.
This was initially done in commit 213dd74aee76 ("skbuff: Do not scrub skb
mark within the same name space").

When the call to skb_scrub_packet() was added in dev_forward_skb() (commit
8b27f27797ca ("skb: allow skb_scrub_packet() to be used by tunnels")), the
second argument (xnet) was set to true to force a call to skb_orphan(). At
this time, the mark was always cleanned up by skb_scrub_packet(), whatever
xnet value was.
This call to skb_orphan() was removed later in commit
9c4c325252c5 ("skbuff: preserve sock reference when scrubbing the skb.").
But this 'true' stayed here without any real reason.

Let's correctly set xnet in ____dev_forward_skb(), this function has access
to the previous interface and to the new interface.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/netdevice.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3972,7 +3972,7 @@ static __always_inline int ____dev_forwa
 		return NET_RX_DROP;
 	}
 
-	skb_scrub_packet(skb, true);
+	skb_scrub_packet(skb, !net_eq(dev_net(dev), dev_net(skb->dev)));
 	skb->priority = 0;
 	return 0;
 }


