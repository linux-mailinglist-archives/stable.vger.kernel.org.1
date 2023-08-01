Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695CB76ACEC
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjHAJY3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjHAJYL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:24:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD411BCF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:23:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C73B9613E2
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F20C433C8;
        Tue,  1 Aug 2023 09:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881779;
        bh=MMaxMew6TxnEmlQh21Et921H/nCAgy1CIQL4Wwiu+mI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lG6u5ydDsc5iXdIV8f7/tSx4dKOEjmq4pD3HJg7KM2sbXKLHbb8pj73Fb86rQejfN
         YI7iS4PEslU9iWwSHZwUQiPVymuX8ydRQa2m3VM1UoenXnbhFUtrc2IQFBEvbPAQ02
         oubGowNd2zk8uoQms3LXlZ9Ozwoa6StTaGX8srus=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Paulo Alcantara (SUSE)" <pc@cjr.nz>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 027/155] cifs: missing directory in MAINTAINERS file
Date:   Tue,  1 Aug 2023 11:18:59 +0200
Message-ID: <20230801091911.176249037@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
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

From: Steve French <stfrench@microsoft.com>

[ Upstream commit 5dd8ce24667a70bb9f7808f5eec0354bd37290c6 ]

The include/uapi/linux/cifs directory (not just fs/cifs and
fs/smbfs_common) should be included in cifs entry in the
MAINTAINERS file.

Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: df9d70c18616 ("cifs: if deferred close is disabled then close files immediately")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2bf1ad0fb2a6f..e6b53e76651be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4666,6 +4666,7 @@ T:	git git://git.samba.org/sfrench/cifs-2.6.git
 F:	Documentation/admin-guide/cifs/
 F:	fs/cifs/
 F:	fs/smbfs_common/
+F:	include/uapi/linux/cifs
 
 COMPACTPCI HOTPLUG CORE
 M:	Scott Murray <scott@spiteful.org>
-- 
2.39.2



