Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374CB754540
	for <lists+stable@lfdr.de>; Sat, 15 Jul 2023 01:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjGNXCc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 14 Jul 2023 19:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjGNXCb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 14 Jul 2023 19:02:31 -0400
Received: from out28-85.mail.aliyun.com (out28-85.mail.aliyun.com [115.124.28.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAA235A4
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 16:02:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2492189|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.00448792-0.000482892-0.995029;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.Tu7kmHm_1689375742;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Tu7kmHm_1689375742)
          by smtp.aliyun-inc.com;
          Sat, 15 Jul 2023 07:02:26 +0800
Date:   Sat, 15 Jul 2023 07:02:27 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     stable@vger.kernel.org
Subject: one 'BUG_ON(ret < 0);' is still left in queue-6.1/btrfs-do-not-bug_on-on-tree-mod-log-failure-at-balan.patch 
Message-Id: <20230715070222.55BF.409509F4@e16-tech.com>
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

one 'BUG_ON(ret < 0);' is still left in queue-6.1/btrfs-do-not-bug_on-on-tree-mod-log-failure-at-balan.patch 

so we need to rebase this patch.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/07/15


