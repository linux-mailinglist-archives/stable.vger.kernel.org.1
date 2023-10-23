Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36BA7D3112
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjJWLFN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbjJWLFM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:05:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88EBD7B
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:05:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AEEC433C8;
        Mon, 23 Oct 2023 11:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059109;
        bh=lbwn1lhoJdGnjAKY1VSeimgfGsCwIsiRcCZeMVzonVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RkDfXB0YLHKSKQzDAtJ42c4qZ7Hrdm7fvHXqfvd2ynx12JNxBC8ZzmSlT0n8IBJGl
         0Ley/SHIh9fOB9yPHjJycKH35EE4TnB80GqWCMzNcjEhpQY7IaE9nP3Y+sujCD1HC+
         LRY6F0kI10PmPlUwhqYJjL8QiMfIhwG/VOnf6oIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.5 067/241] docs: fix info about representor identification
Date:   Mon, 23 Oct 2023 12:54:13 +0200
Message-ID: <20231023104835.535781379@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

commit a258c804aa8742763dce694b5e992d7ccf4294f2 upstream.

Update the "How are representors identified?" documentation
subchapter. For newer kernels driver should use
SET_NETDEV_DEVLINK_PORT instead of ndo_get_devlink_port()
callback.

Fixes: 7712b3e966ea ("Merge branch 'net-fix-netdev-to-devlink_port-linkage-and-expose-to-user'")
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
Link: https://lore.kernel.org/r/20231012123144.15768-1-mateusz.polchlopek@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/networking/representors.rst | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/representors.rst b/Documentation/networking/representors.rst
index ee1f5cd54496..decb39c19b9e 100644
--- a/Documentation/networking/representors.rst
+++ b/Documentation/networking/representors.rst
@@ -162,9 +162,11 @@ How are representors identified?
 The representor netdevice should *not* directly refer to a PCIe device (e.g.
 through ``net_dev->dev.parent`` / ``SET_NETDEV_DEV()``), either of the
 representee or of the switchdev function.
-Instead, it should implement the ``ndo_get_devlink_port()`` netdevice op, which
-the kernel uses to provide the ``phys_switch_id`` and ``phys_port_name`` sysfs
-nodes.  (Some legacy drivers implement ``ndo_get_port_parent_id()`` and
+Instead, the driver should use the ``SET_NETDEV_DEVLINK_PORT`` macro to
+assign a devlink port instance to the netdevice before registering the
+netdevice; the kernel uses the devlink port to provide the ``phys_switch_id``
+and ``phys_port_name`` sysfs nodes.
+(Some legacy drivers implement ``ndo_get_port_parent_id()`` and
 ``ndo_get_phys_port_name()`` directly, but this is deprecated.)  See
 :ref:`Documentation/networking/devlink/devlink-port.rst <devlink_port>` for the
 details of this API.
-- 
2.42.0



