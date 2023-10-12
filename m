Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E82D7C7398
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 19:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347307AbjJLRC3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 13:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344025AbjJLRC2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 13:02:28 -0400
X-Greylist: delayed 367 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Oct 2023 10:02:27 PDT
Received: from stg-mxout2.internetbrands.com (unknown [98.158.206.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B143090
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 10:02:27 -0700 (PDT)
Received: from po.internetbrands.com (unknown [10.161.129.5])
        by stg-mxout2.internetbrands.com (Postfix) with SMTP id 5CB7042038F1;
        Thu, 12 Oct 2023 09:56:18 -0700 (PDT)
Received: by po.internetbrands.com (sSMTP sendmail emulation); Thu, 12 Oct 2023 09:56:18 -0700
From:   "poester" <poester@internetbrands.com>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, Phil O <kernel@linuxace.com>
Subject: Re: Linux 6.1.56
Date:   Thu, 12 Oct 2023 09:54:40 -0700
Message-ID: <20231012165439.137237-2-kernel@linuxace.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023100635-pushchair-predator-9ae3@gregkh>
References: <2023100635-pushchair-predator-9ae3@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_05,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Since rolling out 6.1.56 we have been experiencing file corruption
over NFSv3.  We bisected it down to

 f16fd0b11f0f NFS: Fix error handling for O_DIRECT write scheduling

But that doesn't cleanly revert so we ended up reverting all NFS
changes from 6.1.56 and the corruption no longer occurs.  Namely:

 edd1f0614510 NFS: More fixes for nfs_direct_write_reschedule_io()
 d4729af1c73c NFS: Use the correct commit info in nfs_join_page_group()
 1f49386d6779 NFS: More O_DIRECT accounting fixes for error paths
 4d98038e5bd9 NFS: Fix O_DIRECT locking issues
 f16fd0b11f0f NFS: Fix error handling for O_DIRECT write scheduling

The test case is fairly easily reproduced for us:

 dd if=testfile of=testfile2 oflag=direct; md5sum testfile*

shows a different md5sum between the two files on 6.1.56+ kernels.
Interestingly, on 6.5.7 this problem does not occur even though it
contains the same O_DIRECT patch as f16fd0b11f0f.

We opened a bugzilla on this:

 https://bugzilla.kernel.org/show_bug.cgi?id=217999

But this seems like a critical issue to us which should likely be
addressed in 6.1.58.

Thanks,
Phil
