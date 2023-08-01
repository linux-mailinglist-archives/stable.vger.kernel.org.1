Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5361D76AAC4
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 10:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjHAIVN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 04:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjHAIVM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 04:21:12 -0400
Received: from out28-223.mail.aliyun.com (out28-223.mail.aliyun.com [115.124.28.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED43A0
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 01:21:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3188804|-1;BR=01201311R141S82rulernew998_84748_200221;CH=blue;DM=|CONTINUE|false|;DS=EDM|edm_business_exp|0.849012-0.00219044-0.148798;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.U5n5OEK_1690878059;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.U5n5OEK_1690878059)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 16:21:03 +0800
Date:   Tue, 01 Aug 2023 16:21:05 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     stable@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: should stable 6.1.y include 6c21e066f925 mm/mempolicy: Take VMA lock before replacing policy?
Message-Id: <20230801162059.899D.409509F4@e16-tech.com>
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

should stable 6.1.y include 
6c21e066f925 mm/mempolicy: Take VMA lock before replacing policy
?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/08/01


