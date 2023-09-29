Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EA87B2A30
	for <lists+stable@lfdr.de>; Fri, 29 Sep 2023 03:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjI2BwW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 28 Sep 2023 21:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjI2BwW (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 28 Sep 2023 21:52:22 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C95C19C
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 18:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1695952340; x=1727488340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vS3NQzC+N63On0t9WQfYEHFIC6I4Y3r/vtI+wg1yX28=;
  b=asA8F9j5gJwsuuUeKu9Jr3WSTBGVhyO6K8o4q9e/wcCIWiHDYTkeVn0w
   npUn9kDl+sKmS+XF+D0KpMmUEAuOvGkGD0jWow8IRcW1wwVO6d7JCKhbn
   46OiEqXlUzI95HpXYcTq8TuouCO/iv8ob+a3AgDuqZTQ+fkV2M3nIcu99
   U=;
X-IronPort-AV: E=Sophos;i="6.03,185,1694736000"; 
   d="scan'208";a="361330959"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 01:52:19 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com (Postfix) with ESMTPS id 4E0F08049B;
        Fri, 29 Sep 2023 01:52:17 +0000 (UTC)
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 29 Sep 2023 01:52:17 +0000
Received: from u0acfa43c8cad58.ant.amazon.com (10.119.86.250) by
 EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 29 Sep 2023 01:52:16 +0000
From:   Munehisa Kamata <kamatam@amazon.com>
To:     <stable@vger.kernel.org>
CC:     <casey@schaufler-ca.com>, <vishal.goel@samsung.com>,
        <roberto.sassu@huawei.com>, <kamatam@amazon.com>
Subject: [PATCH for 4.19.y 0/3] Backport Smack fixes for 4.19.y
Date:   Thu, 28 Sep 2023 18:51:35 -0700
Message-ID: <20230929015138.835462-1-kamatam@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929015033.835263-1-kamatam@amazon.com>
References: <20230929015033.835263-1-kamatam@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.119.86.250]
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D010UWA004.ant.amazon.com (10.13.138.204)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This series backports the following fixes for Smack problems with overlayfs
to 4.19.y.

2c085f3a8f23 smack: Record transmuting in smk_transmuted
3a3d8fce31a4 smack: Retrieve transmuting information in smack_inode_getsecurity() 
387ef964460f Smack:- Use overlay inode label in smack_inode_copy_up()

This slightly modifies the original commits, because the commits rely on
some helper functions introduced after v4.19 by different commits that
touch more code than just Smack, require even more prerequisite commits and
also need some adjustments for 4.19.y.  Instead, this series makes minor
modifications for only the overlayfs-related fixes to not use the helper
functions rather than backporting everything.

For reference, the upstream commits listed below introduced the helper
functions.  Though, this is not a complete list for their dependencies.

ecd5f82e05dd LSM: Infrastructure management of the ipc security blob
019bcca4626a Smack: Abstract use of ipc security blobs
afb1cbe37440 LSM: Infrastructure management of the inode security
fb4021b6fb58 Smack: Abstract use of inode security blob
33bf60cabcc7 LSM: Infrastructure management of the file security
f28952ac9008 Smack: Abstract use of file security blob
bbd3662a8348 Infrastructure management of the cred security blob
b17103a8b8ae Smack: Abstract use of cred security blob

Roberto Sassu (2):
  smack: Retrieve transmuting information in smack_inode_getsecurity()
  smack: Record transmuting in smk_transmuted

Vishal Goel (1):
  Smack:- Use overlay inode label in smack_inode_copy_up()

 security/smack/smack.h     |  1 +
 security/smack/smack_lsm.c | 65 ++++++++++++++++++++++++++++----------
 2 files changed, 49 insertions(+), 17 deletions(-)

-- 
2.34.1

