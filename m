Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869047D1126
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 16:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377429AbjJTOBY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 10:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377376AbjJTOBX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 10:01:23 -0400
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6DD93
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 07:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697810482; x=1729346482;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=R2gwz1SjJc+qTs/iUqOs3yVzXTA3xbFGIj4wEkZl+wo=;
  b=MUVLbJvcCaVHNgW36aR6w77HDG+YPm3qrUq9QNV7TWnDntPxuXrsKEKr
   ZIP+VMStEsUQ0GSrP7fTBgCxQvC9af7h0l+dX9gMezcTFyETbuqsgf6r4
   HugIgBH/YvX6xZjDJrZBz9XnuhDFSmO3twu64bwp26a7RPReb1E0ROsVh
   Y=;
X-IronPort-AV: E=Sophos;i="6.03,239,1694736000"; 
   d="scan'208";a="679018070"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 14:01:16 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
        by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id 6A2C348972;
        Fri, 20 Oct 2023 14:01:15 +0000 (UTC)
Received: from EX19MTAUEA001.ant.amazon.com [10.0.29.78:57822]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.22.195:2525] with esmtp (Farcaster)
 id f0ed6090-0968-4aa8-b33e-696735617b5d; Fri, 20 Oct 2023 14:01:14 +0000 (UTC)
X-Farcaster-Flow-ID: f0ed6090-0968-4aa8-b33e-696735617b5d
Received: from EX19EXOUEC002.ant.amazon.com (10.252.135.179) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 20 Oct 2023 14:01:14 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19EXOUEC002.ant.amazon.com (10.252.135.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Fri, 20 Oct 2023 14:01:14 +0000
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (10.15.97.110) by
 mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Fri, 20 Oct 2023 14:01:14 +0000
Received: by dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (Postfix, from userid 22993570)
        id B8F9420846; Fri, 20 Oct 2023 14:01:13 +0000 (UTC)
From:   <pjy@amazon.com>
To:     <stable@vger.kernel.org>
CC:     <lmark@codeaurora.org>
Subject: Backport commit 786dee864804 ("mm/memory_hotplug: rate limit page
 migration warnings")
Date:   Fri, 20 Oct 2023 14:01:13 +0000
Message-ID: <mb61p4jiltmty.fsf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


Please backport commit 786dee864804 ("mm/memory_hotplug: ratelimit page
migration warnings") to 5.10 stable branch.

Commit message:
"""
When offlining memory the system can attempt to migrate a lot of pages, if
there are problems with migration this can flood the logs.  Printing all
the data hogs the CPU and cause some RT threads to run for a long time,
which may have some bad consequences.

Rate limit the page migration warnings in order to avoid this.
"""

We are sometimes seeing RCU stalls while offlining memory with the 5.10
kernel due to the printing of these messages.

Applying this patch solves the problem by ratelimiting the prints.

Thanks,
Puranjay
