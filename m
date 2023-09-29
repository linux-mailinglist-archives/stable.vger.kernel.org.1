Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4DB7B2A2F
	for <lists+stable@lfdr.de>; Fri, 29 Sep 2023 03:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjI2Bu5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 28 Sep 2023 21:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjI2Bu4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 28 Sep 2023 21:50:56 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B95119C
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 18:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1695952255; x=1727488255;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EdaCbD7NgqW4xO77UgWb5wNfI+habl2NBix9aQN33fk=;
  b=Km4L+egamyRPXiZLLhaPIZIFZas6UV7pS9aWLff4wP59Cv8EuWIV5JSH
   GcVHjvyciM0s9CdICymH051rwzsBL9J18XuXYHauIANi7Vm7D0NALjahF
   KwRQV1G6Fe51yGy24C+z8yuxULoJcGaVU56vftTarBYcj0H42C3QncTGn
   A=;
X-IronPort-AV: E=Sophos;i="6.03,185,1694736000"; 
   d="scan'208";a="353959912"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 01:50:54 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id 96B3C80EE5;
        Fri, 29 Sep 2023 01:50:52 +0000 (UTC)
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 29 Sep 2023 01:50:45 +0000
Received: from u0acfa43c8cad58.ant.amazon.com (10.119.86.250) by
 EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 29 Sep 2023 01:50:44 +0000
From:   Munehisa Kamata <kamatam@amazon.com>
To:     <stable@vger.kernel.org>
CC:     <casey@schaufler-ca.com>, <vishal.goel@samsung.com>,
        <roberto.sassu@huawei.com>, <kamatam@amazon.com>
Subject: Request to cherry-pick a few Smack fixes
Date:   Thu, 28 Sep 2023 18:50:33 -0700
Message-ID: <20230929015033.835263-1-kamatam@amazon.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.119.86.250]
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D010UWA004.ant.amazon.com (10.13.138.204)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi stable maintainers,

The following upstream commits fix a couple of overlayfs handling problems
in Smack.  Could you please cherry-pick them for 4.19.y, 5.4.y, 5.10.y,
5.15.y and 6.1.y?

#3 2c085f3a8f23 smack: Record transmuting in smk_transmuted
#2 3a3d8fce31a4 smack: Retrieve transmuting information in smack_inode_getsecurity() 
#1 387ef964460f Smack:- Use overlay inode label in smack_inode_copy_up() # not needed for 6.1.y

Note that 4.19.y needs some adjustments. I'll send backported patches
separately. 

I'm not an author of these commits, but have been hitting the problems with
multiple kernels based on the trees and it seems worth cherry-picking.
Perhaps, it's better to add a tag in cherry-picked commits:

Fixes: d6d80cb57be4 ("Smack: Base support for overlayfs")


Regards,
Munehisa
