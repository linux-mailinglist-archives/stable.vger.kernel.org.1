Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5F4754E25
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 11:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjGPJrM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 05:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGPJrL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 05:47:11 -0400
Received: from out28-68.mail.aliyun.com (out28-68.mail.aliyun.com [115.124.28.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA9410D0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 02:47:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09814519|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.00302384-0.000234228-0.996742;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Tuy7ikg_1689500819;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Tuy7ikg_1689500819)
          by smtp.aliyun-inc.com;
          Sun, 16 Jul 2023 17:47:03 +0800
Date:   Sun, 16 Jul 2023 17:47:03 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Subject: Re: one 'BUG_ON(ret < 0);' is still left in queue-6.1/btrfs-do-not-bug_on-on-tree-mod-log-failure-at-balan.patch
Cc:     stable@vger.kernel.org
In-Reply-To: <2023071634-cogwheel-handgun-7cdb@gregkh>
References: <20230715070222.55BF.409509F4@e16-tech.com> <2023071634-cogwheel-handgun-7cdb@gregkh>
Message-Id: <20230716174658.DC0B.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

> On Sat, Jul 15, 2023 at 07:02:27AM +0800, Wang Yugui wrote:
> > Hi,
> > 
> > one 'BUG_ON(ret < 0);' is still left in queue-6.1/btrfs-do-not-bug_on-on-tree-mod-log-failure-at-balan.patch 
> > 
> > so we need to rebase this patch.
> 
> Great, can you send a new version for 5.15.y and 6.1.y?

queue-5.15/btrfs-do-not-bug_on-on-tree-mod-log-failure-at-balan.patch is GOOD.
queue-6.1/btrfs-do-not-bug_on-on-tree-mod-log-failure-at-balan.patch is GOOD.

and we can 'git am' queue-5.15/btrfs-do-not-bug_on-on-tree-mod-log-failure-at-balan.patch
to 6.1.38 cleanly.

so it is OK to just copy queue-5.15/btrfs-do-not-bug_on-on-tree-mod-log-failure-at-balan.patch
as queue-6.1/btrfs-do-not-bug_on-on-tree-mod-log-failure-at-balan.patch.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/07/16

