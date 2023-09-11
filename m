Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9CD79BD35
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377786AbjIKW2i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242284AbjIKP0y (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:26:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB64E4
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:26:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA61C433C8;
        Mon, 11 Sep 2023 15:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694446010;
        bh=BlOc4KhmNRV9DhpC91WHSxCtgRwNbzic7mUGECHXxtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TQCEgjtqUqPfeLyUMfxO32D/0Uzy16uAPKhicDwGCx+Z40WJW6K3S0TCcVyPn1sfx
         Ox7WntuO9IrYZiGQ+WAYgMoAqPYjwwgAXd90FWKkscl890FtpcyQOdzLjZaOFSs4yK
         e+PNPbSkcKczx4kvsIfcayzpboeLwf/ZWA6unnjk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kalle Valo <kvalo@kernel.org>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6.1 551/600] PCI: Free released resource after coalescing
Date:   Mon, 11 Sep 2023 15:49:44 +0200
Message-ID: <20230911134649.882097130@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ross Lagerwall <ross.lagerwall@citrix.com>

commit 8ec9c1d5d0a5a4744516adb483b97a238892f9d5 upstream.

release_resource() doesn't actually free the resource or resource list
entry so free the resource list entry to avoid a leak.

Closes: https://lore.kernel.org/r/878r9sga1t.fsf@kernel.org/
Fixes: e54223275ba1 ("PCI: Release resource invalidated by coalescing")
Link: https://lore.kernel.org/r/20230906110846.225369-1-ross.lagerwall@citrix.com
Reported-by: Kalle Valo <kvalo@kernel.org>
Tested-by: Kalle Valo <kvalo@kernel.org>
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org      # v5.16+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/probe.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -996,6 +996,7 @@ static int pci_register_host_bridge(stru
 		res = window->res;
 		if (!res->flags && !res->start && !res->end) {
 			release_resource(res);
+			resource_list_destroy_entry(window);
 			continue;
 		}
 


