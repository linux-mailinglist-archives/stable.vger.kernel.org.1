Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1067B7173
	for <lists+stable@lfdr.de>; Tue,  3 Oct 2023 21:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjJCTCh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 3 Oct 2023 15:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjJCTCg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Oct 2023 15:02:36 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC24AB
        for <stable@vger.kernel.org>; Tue,  3 Oct 2023 12:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696359752; x=1727895752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cNw4XMLJcZ7mM9NZjfypiKg3VY+aSDaTH/GtvGkySfc=;
  b=HO5ps3ldtJKYPoVvu2TF7D/ETpXHZ+rACU+DzCJFI30Rgdz/q8FAM82Q
   KgQGmNLYZyQgTRc8y4e9sTKxUPIgpgYHVVImSwjHN2v5w8O9cbcZknWh/
   7usIZjRzjj22d+utdCdNUY0aBPOz0M74M6Qs/qIAIOVuFxO4im/+Blhkk
   U=;
X-IronPort-AV: E=Sophos;i="6.03,198,1694736000"; 
   d="scan'208";a="362080372"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-93c3b254.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 19:02:31 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-iad-1a-m6i4x-93c3b254.us-east-1.amazon.com (Postfix) with ESMTPS id E9EE3E18E3;
        Tue,  3 Oct 2023 19:02:29 +0000 (UTC)
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 3 Oct 2023 19:02:29 +0000
Received: from u0acfa43c8cad58.ant.amazon.com (10.187.171.33) by
 EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 3 Oct 2023 19:02:29 +0000
From:   Munehisa Kamata <kamatam@amazon.com>
To:     <sashal@kernel.org>
CC:     <casey@schaufler-ca.com>, <kamatam@amazon.com>,
        <roberto.sassu@huawei.com>, <stable@vger.kernel.org>,
        <vishal.goel@samsung.com>
Subject: Re: [PATCH for 4.19.y 0/3] Backport Smack fixes for 4.19.y
Date:   Tue, 3 Oct 2023 12:02:17 -0700
Message-ID: <20231003190217.35669-1-kamatam@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZRv6gaFF0hPrhj+D@sashalap>
References: <ZRv6gaFF0hPrhj+D@sashalap>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.33]
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D010UWA004.ant.amazon.com (10.13.138.204)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Sasha,

On Tue, 2023-10-03 11:26:57 +0000, Sasha Levin wrote:
>
> On Thu, Sep 28, 2023 at 06:51:35PM -0700, Munehisa Kamata wrote:
> >This series backports the following fixes for Smack problems with overlayfs
> >to 4.19.y.
> >
> >2c085f3a8f23 smack: Record transmuting in smk_transmuted
> >3a3d8fce31a4 smack: Retrieve transmuting information in smack_inode_getsecurity()
> >387ef964460f Smack:- Use overlay inode label in smack_inode_copy_up()
> >
> >This slightly modifies the original commits, because the commits rely on
> >some helper functions introduced after v4.19 by different commits that
> >touch more code than just Smack, require even more prerequisite commits and
> >also need some adjustments for 4.19.y.  Instead, this series makes minor
> >modifications for only the overlayfs-related fixes to not use the helper
> >functions rather than backporting everything.
> 
> What about newer trees? We can't take fixes for 4.19 if the fixes don't
> exist in 5.4+.

Sorry if it was not clear enough in the first post[1]. For 5.4+, please just
cherry-pick the 3 commits. Those should apply cleanly.

[1] https://lore.kernel.org/stable/20230929015033.835263-1-kamatam@amazon.com/

Thanks,
Munehisa
 
> -- 
> Thanks,
> Sasha
> 
