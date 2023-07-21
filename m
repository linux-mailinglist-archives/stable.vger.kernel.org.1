Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142FB75D484
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjGUTV5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjGUTV5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:21:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87213189
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 273DB61D6D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B9FC433C7;
        Fri, 21 Jul 2023 19:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967315;
        bh=wtOxTZ8UwHiWCbs/cEXo98uwcpGVQJFZLYmbTyHXHww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3cjbAa/eqe0Byevru/J7h09z1e+gLgiM5NQFHrDMsGkp3SGyUBIx00iibCj3JZqZ
         S0wLF+aigyso6eTV0Rm7F8GkYSnJBjW2XDrQ8boYx5iPMiDqhT0GaxklxChjVQZm25
         ohNCIeq88ceFx9fwK7TTuC5q/sneIwU8t9xMvWRQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6.1 120/223] PCI: Release resource invalidated by coalescing
Date:   Fri, 21 Jul 2023 18:06:13 +0200
Message-ID: <20230721160525.994452202@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ross Lagerwall <ross.lagerwall@citrix.com>

commit e54223275ba1bc6f704a6bab015fcd2ae4f72572 upstream.

When contiguous windows are coalesced by pci_register_host_bridge(), the
second resource is expanded to include the first, and the first is
invalidated and consequently not added to the bus. However, it remains in
the resource hierarchy.  For example, these windows:

  fec00000-fec7ffff : PCI Bus 0000:00
  fec80000-fecbffff : PCI Bus 0000:00

are coalesced into this, where the first resource remains in the tree with
start/end zeroed out:

  00000000-00000000 : PCI Bus 0000:00
  fec00000-fecbffff : PCI Bus 0000:00

In some cases (e.g. the Xen scratch region), this causes future calls to
allocate_resource() to choose an inappropriate location which the caller
cannot handle.

Fix by releasing the zeroed-out resource and removing it from the resource
hierarchy.

[bhelgaas: commit log]
Fixes: 7c3855c423b1 ("PCI: Coalesce host bridge contiguous apertures")
Link: https://lore.kernel.org/r/20230525153248.712779-1-ross.lagerwall@citrix.com
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org	# v5.16+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/probe.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -994,8 +994,10 @@ static int pci_register_host_bridge(stru
 	resource_list_for_each_entry_safe(window, n, &resources) {
 		offset = window->offset;
 		res = window->res;
-		if (!res->flags && !res->start && !res->end)
+		if (!res->flags && !res->start && !res->end) {
+			release_resource(res);
 			continue;
+		}
 
 		list_move_tail(&window->node, &bridge->windows);
 


