Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9EE76AC98
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjHAJQE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjHAJPv (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:15:51 -0400
Received: from out198-152.us.a.mail.aliyun.com (out198-152.us.a.mail.aliyun.com [47.90.198.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DDF19BD
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:13:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1085581|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0758882-0.00203324-0.922078;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.U5qNDLB_1690881145;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.U5qNDLB_1690881145)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 17:12:30 +0800
Date:   Tue, 01 Aug 2023 17:12:31 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Subject: Re: should stable 6.1.y include 6c21e066f925 mm/mempolicy: Take VMA lock before replacing policy?
Cc:     stable@vger.kernel.org, Jann Horn <jannh@google.com>
In-Reply-To: <2023080144-coasting-decathlon-74f1@gregkh>
References: <20230801162059.899D.409509F4@e16-tech.com> <2023080144-coasting-decathlon-74f1@gregkh>
Message-Id: <20230801171226.1330.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

> On Tue, Aug 01, 2023 at 04:21:05PM +0800, Wang Yugui wrote:
> > Hi,
> > 
> > should stable 6.1.y include 
> > 6c21e066f925 mm/mempolicy: Take VMA lock before replacing policy
> > ?
> 
> Did you test it and see if it works?  Why do you think it is needed in
> 6.1.y when the "Fixes:" tag references a commit that is in 6.4 only?
> Is the tag incorrect?

Sorry that it should not be included in stable 6.1.y.

I checked all mm-patches of 6.1.36-6.1.42 again.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/08/01

