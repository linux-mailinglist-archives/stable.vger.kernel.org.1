Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596FF7B5948
	for <lists+stable@lfdr.de>; Mon,  2 Oct 2023 19:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjJBR1H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 2 Oct 2023 13:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJBR1G (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 2 Oct 2023 13:27:06 -0400
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794BC8E
        for <stable@vger.kernel.org>; Mon,  2 Oct 2023 10:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1696267623; x=1727803623;
  h=from:to:subject:date:message-id:mime-version;
  bh=3VjhgXn2/moDx7kpytQ8M0vrRlOBMl/NzTSIeKkaakg=;
  b=Q6P5/SDM6ZMEQgst5qOvw1aENlVTmpGa6mFVGdJ2aa0F1h+dXmfcYUYW
   x1XHKrnpPPCkCdfLhgkCwPLzL627mm40QKwoE2FB6Xvceg7XpRnCchEQr
   rBWZ3XNavmTGy1Ly0SGxgnhsiaZLc6tk0rga8ANpsXi/oYQiu34r+gMs+
   U=;
X-IronPort-AV: E=Sophos;i="6.03,194,1694736000"; 
   d="scan'208";a="611126315"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 17:27:01 +0000
Received: from EX19MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com (Postfix) with ESMTPS id C121840D64
        for <stable@vger.kernel.org>; Mon,  2 Oct 2023 17:27:00 +0000 (UTC)
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 2 Oct 2023 17:26:53 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 2 Oct 2023 17:26:53 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
        id 4200120CAB; Mon,  2 Oct 2023 19:26:53 +0200 (CEST)
From:   Pratyush Yadav <ptyadav@amazon.de>
To:     <stable@vger.kernel.org>
Subject: Backport commit dad651b2a44e ("nvme-pci: do not set the NUMA node
 of device if it has none")
Date:   Mon, 2 Oct 2023 19:26:53 +0200
Message-ID: <mafs0il7porz6.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


Hi,

Please backport commit dad651b2a44e ("nvme-pci: do not set the NUMA node
of device if it has none") to stable branches 6.1, 5.15, 5.10, 5.4,
4.19, and 4.14. The commit fixes a4aea5623d4a ("NVMe: Convert to
blk-mq") which was introduced in v3.19 but I forgot to add this when
sending the patch.

-- 
Regards,
Pratyush Yadav



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



