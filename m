Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8677A7E56
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbjITMRY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjITMRX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:17:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75DD1BB
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:16:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F62C43397;
        Wed, 20 Sep 2023 12:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212215;
        bh=/Vzj87T8/s8q8JKOBJ81PZHk7bGhuWrOZwov+im03kY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SvX00CveTWsdJYwLgCfZmuHXxaQuhNyW68vboaA92EuanCKeGopSlPw02RTQWm8Kj
         wjTfK2m6KZ7GSMFBeKxplYebVU/fKok0SJJiBgwRd1kYL0xsJY0HZvRlLzxbP0bhiT
         zlTct92A2HGpUbk4lVZqfYtzdj+owml9s1V+7l6U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4.19 192/273] PCI/ATS: Add inline to pci_prg_resp_pasid_required()
Date:   Wed, 20 Sep 2023 13:30:32 +0200
Message-ID: <20230920112852.440135003@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

commit fff42928ade591969836ff49888d063b829ac888 upstream.

Fix unused function warning when compiled with CONFIG_PCI_PASID
disabled.

Fixes: e5567f5f6762 ("PCI/ATS: Add pci_prg_resp_pasid_required() interface.")
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/pci-ats.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -67,7 +67,7 @@ static inline int pci_max_pasids(struct
 	return -EINVAL;
 }
 
-static int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
 {
 	return 0;
 }


