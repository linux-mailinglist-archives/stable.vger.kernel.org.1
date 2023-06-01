Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCB3719066
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 04:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjFACNE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 22:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjFACND (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 22:13:03 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BC612F
        for <stable@vger.kernel.org>; Wed, 31 May 2023 19:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685585582; x=1717121582;
  h=message-id:date:mime-version:from:subject:to:cc:
   content-transfer-encoding;
  bh=pavXskyrhinWph7H7qGdEsJWwrxYj7UzH+kmlwPcS5g=;
  b=SyZb75bRB1w9sfcJ/DHl5z7sdyEdHbYBc77DJ/wRYaJ46h1xf0vAhBfj
   KgzN/gOMQWLGfMzIBjyofsvvyIPBCHY3MiOMU7stRSlvAAtRAeEOH4N0f
   Cp5mSEvGs9nDRxLeGhPSF4SpptWhNricEaVf/O0OiFodE23/AwZmORja3
   U=;
X-IronPort-AV: E=Sophos;i="6.00,207,1681171200"; 
   d="scan'208";a="337801353"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 02:12:57 +0000
Received: from EX19MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com (Postfix) with ESMTPS id 9401C60AB4;
        Thu,  1 Jun 2023 02:12:55 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 02:12:45 +0000
Received: from [192.168.2.200] (10.106.178.32) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 02:12:43 +0000
Message-ID: <8892cb92-0f30-db36-e9db-4bec5e7eb46e@amazon.com>
Date:   Wed, 31 May 2023 22:12:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
From:   Luiz Capitulino <luizcap@amazon.com>
Subject: Possible build time regression affecting stable kernels
To:     <paul@paul-moore.com>, <sashal@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.106.178.32]
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Paul,

A number of stable kernels recently backported this upstream commit:

"""
commit 4ce1f694eb5d8ca607fed8542d32a33b4f1217a5
Author: Paul Moore <paul@paul-moore.com>
Date:   Wed Apr 12 13:29:11 2023 -0400

     selinux: ensure av_permissions.h is built when needed
"""

We're seeing a build issue with this commit where the "crash" tool will fail
to start, it complains that the vmlinux image and /proc/version don't match.

A minimum reproducer would be having "make" version before 4.3 and building
the kernel with:

$ make bzImages
$ make modules

Then compare the version strings in the bzImage and vmlinux images,
we can use "strings" for this. For example, in the 5.10.181 kernel I get:

$ strings vmlinux | egrep '^Linux version'
Linux version 5.10.181 (ec2-user@ip-172-31-79-134.ec2.internal) (gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-15), GNU ld version 2.29.1-31.amzn2) #2 SMP Thu Jun 1 01:26:38 UTC 2023

$ strings ./arch/x86_64/boot/bzImage | egrep 'ld version'
5.10.181 (ec2-user@ip-172-31-79-134.ec2.internal) (gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-15), GNU ld version 2.29.1-31.amzn2) #1 SMP Thu Jun 1 01:23:59 UTC 2023

The version string in the bzImage doesn't have the "Linux version" part, but
I think this is added by the kernel when printing. If you compare the strings,
you'll see that they have a different build date and the "#1" and "#2" are
different.

This only happens with commit 4ce1f694eb5 applied and older "make", in my case I
have "make" version 3.82.

If I revert 4ce1f694eb5 or use "make" version 4.3 I get identical strings (except
for the "Linux version" part):

$ strings vmlinux | egrep '^Linux version'
Linux version 5.10.181+ (ec2-user@ip-172-31-79-134.ec2.internal) (gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-15), GNU ld version 2.29.1-31.amzn2) #1 SMP Thu Jun 1 01:29:11 UTC 2023

$ strings ./arch/x86_64/boot/bzImage | egrep 'ld version'
5.10.181+ (ec2-user@ip-172-31-79-134.ec2.internal) (gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-15), GNU ld version 2.29.1-31.amzn2) #1 SMP Thu Jun 1 01:29:11 UTC 2023

Maybe the grouped target usage in 4ce1f694eb5 with older "make" is causing a
rebuild of the vmlinux image in "make modules"? If yes, is this expected?

I'm afraid this issue could be high impact for distros with older user-space.

- Luiz
