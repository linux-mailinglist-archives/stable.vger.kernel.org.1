Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5125C75CF15
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjGUQ1W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjGUQ1F (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:27:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAF46594
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:23:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06EB96108F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19633C433C8;
        Fri, 21 Jul 2023 16:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956615;
        bh=XhjwwU0wiMuLFM/sEWtgdKu+P0pI/5gfo51tGMAsON8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nhI4qIVcDPkUZBZPVTqn3NttMGcIZPvRG+Psjefd8GK3QVR4ZRC3/ngruj4vMrfZ/
         fnLJ9fxs5BioOn90bayqeV4VcoBVWkJOxMVGPlhBxt0o1mz5z2vDkGjUmd4GrZTiYb
         zPtRYs73JjS9WvYs2809DxYARU4rKvzgvanb0jSw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 6.4 239/292] nvme: dont reject probe due to duplicate IDs for single-ported PCIe devices
Date:   Fri, 21 Jul 2023 18:05:48 +0200
Message-ID: <20230721160539.156897251@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

commit ac522fc6c3165fd0daa2f8da7e07d5f800586daa upstream.

While duplicate IDs are still very harmful, including the potential to easily
see changing devices in /dev/disk/by-id, it turn out they are extremely
common for cheap end user NVMe devices.

Relax our check for them for so that it doesn't reject the probe on
single-ported PCIe devices, but prints a big warning instead.  In doubt
we'd still like to see quirk entries to disable the potential for
changing supposed stable device identifier links, but this will at least
allow users how have two (or more) of these devices to use them without
having to manually add a new PCI ID entry with the quirk through sysfs or
by patching the kernel.

Fixes: 2079f41ec6ff ("nvme: check that EUI/GUID/UUID are globally unique")
Cc: stable@vger.kernel.org # 6.0+
Co-developed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/core.c |   36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4226,10 +4226,40 @@ static int nvme_init_ns_head(struct nvme
 
 	ret = nvme_global_check_duplicate_ids(ctrl->subsys, &info->ids);
 	if (ret) {
-		dev_err(ctrl->device,
-			"globally duplicate IDs for nsid %d\n", info->nsid);
+		/*
+		 * We've found two different namespaces on two different
+		 * subsystems that report the same ID.  This is pretty nasty
+		 * for anything that actually requires unique device
+		 * identification.  In the kernel we need this for multipathing,
+		 * and in user space the /dev/disk/by-id/ links rely on it.
+		 *
+		 * If the device also claims to be multi-path capable back off
+		 * here now and refuse the probe the second device as this is a
+		 * recipe for data corruption.  If not this is probably a
+		 * cheap consumer device if on the PCIe bus, so let the user
+		 * proceed and use the shiny toy, but warn that with changing
+		 * probing order (which due to our async probing could just be
+		 * device taking longer to startup) the other device could show
+		 * up at any time.
+		 */
 		nvme_print_device_info(ctrl);
-		return ret;
+		if ((ns->ctrl->ops->flags & NVME_F_FABRICS) || /* !PCIe */
+		    ((ns->ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) &&
+		     info->is_shared)) {
+			dev_err(ctrl->device,
+				"ignoring nsid %d because of duplicate IDs\n",
+				info->nsid);
+			return ret;
+		}
+
+		dev_err(ctrl->device,
+			"clearing duplicate IDs for nsid %d\n", info->nsid);
+		dev_err(ctrl->device,
+			"use of /dev/disk/by-id/ may cause data corruption\n");
+		memset(&info->ids.nguid, 0, sizeof(info->ids.nguid));
+		memset(&info->ids.uuid, 0, sizeof(info->ids.uuid));
+		memset(&info->ids.eui64, 0, sizeof(info->ids.eui64));
+		ctrl->quirks |= NVME_QUIRK_BOGUS_NID;
 	}
 
 	mutex_lock(&ctrl->subsys->lock);


