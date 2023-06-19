Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABB9735304
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjFSKlE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjFSKkS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:40:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497BD106
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9F8460B33
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB77C433C8;
        Mon, 19 Jun 2023 10:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171216;
        bh=O6RYYlVwXXYj/HuWmYtTzIP5NXx3z0ZGT25etE+QaYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FruSBzirCZuNrZFEk3LK1BNmrA8tesaVssCgoyKtepb9tUT4kFr2l2+v7odUVcF6a
         Zq8n1fO5mJpbA22GXtYU/i/K4aBItq5sE9Qpxgy6vDD6ywqVEAcn34qZlm+FNBt4FC
         f1b+EgNCmZM5k3c1MTaSXV4KOLBa0MH6AWSaDQqg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>,
        linux-afs@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 182/187] afs: Fix vlserver probe RTT handling
Date:   Mon, 19 Jun 2023 12:30:00 +0200
Message-ID: <20230619102206.513259937@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit ba00b190670809c1a89326d80de96d714f6004f2 ]

In the same spirit as commit ca57f02295f1 ("afs: Fix fileserver probe
RTT handling"), don't rule out using a vlserver just because there
haven't been enough packets yet to calculate a real rtt.  Always set the
server's probe rtt from the estimate provided by rxrpc_kernel_get_srtt,
which is capped at 1 second.

This could lead to EDESTADDRREQ errors when accessing a cell for the
first time, even though the vl servers are known and have responded to a
probe.

Fixes: 1d4adfaf6574 ("rxrpc: Make rxrpc_kernel_get_srtt() indicate validity")
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
Link: http://lists.infradead.org/pipermail/linux-afs/2023-June/006746.html
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/vl_probe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/vl_probe.c b/fs/afs/vl_probe.c
index d1c7068b4346f..58452b86e6727 100644
--- a/fs/afs/vl_probe.c
+++ b/fs/afs/vl_probe.c
@@ -115,8 +115,8 @@ void afs_vlserver_probe_result(struct afs_call *call)
 		}
 	}
 
-	if (rxrpc_kernel_get_srtt(call->net->socket, call->rxcall, &rtt_us) &&
-	    rtt_us < server->probe.rtt) {
+	rxrpc_kernel_get_srtt(call->net->socket, call->rxcall, &rtt_us);
+	if (rtt_us < server->probe.rtt) {
 		server->probe.rtt = rtt_us;
 		server->rtt = rtt_us;
 		alist->preferred = index;
-- 
2.39.2



