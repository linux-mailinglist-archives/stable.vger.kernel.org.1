Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB96D7C87DA
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 16:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjJMO2p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 10:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjJMO2o (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 10:28:44 -0400
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80AABB
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 07:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697207323; x=1728743323;
  h=from:to:subject:date:message-id:mime-version;
  bh=wcYG9TUHb2u/uStHuIfeIj4y/E3R209YfdJO0I5PanM=;
  b=bzTOYd+CvmJSANWe/+PAYM8R0nJzmW9HM0AA22i/IZOhZ36wtxFR/ccY
   g19KOvUontyDBmqVNnv92pfqv7846YQXGLHhSvN2gTUlOq9ZOAraolSfq
   jtAz4iZ0X2hV/pjsd4vB8bD29x/RBqRxKC0l/9513C2v2u9+Roz8POIIV
   M=;
X-IronPort-AV: E=Sophos;i="6.03,222,1694736000"; 
   d="scan'208";a="35668883"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 14:28:40 +0000
Received: from EX19MTAUEB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id 395A248298
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 14:28:38 +0000 (UTC)
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.108) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 13 Oct 2023 14:28:38 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Fri, 13 Oct 2023 14:28:38 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
        id 0F67B2251; Fri, 13 Oct 2023 16:28:38 +0200 (CEST)
From:   Mahmoud Adam <mngyadam@amazon.com>
To:     <stable@vger.kernel.org>
Subject: backport "x86: change default to spec_store_bypass_disable=prctl
 spectre_v2_user=prctl"
Date:   Fri, 13 Oct 2023 16:28:37 +0200
Message-ID: <lrkyqy1g6bnqi.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


Hi,

commit 2f46993d83ff upstream.

Please backport this commit to the other stable kernels, since this
patch landed on 6.1 and We've seen 30% improvement with docker
containers running heavy cpu/mem tasks


-MNAdam
