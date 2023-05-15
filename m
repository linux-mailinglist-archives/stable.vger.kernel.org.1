Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70BB703C42
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244200AbjEOSQo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245199AbjEOSQV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:16:21 -0400
Received: from mx1.bezdeka.de (mx1.bezdeka.de [IPv6:2a03:4000:3f:1f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689C920E36
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bezdeka.de;
        s=mail201812; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
        In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=SUPBVF8BLX/Dx2bjtqGezIjRH6ZahzHDzU1LIl7ANKI=; b=pQBhVq5CviYxdhMerMbsTgBwJd
        stqZdr7fGo9q30W28hsau5zX70hiJkj9vuO8/yp6ljxk2DKAXE0skKAIQJ3tJ9SAGJa61gC7PffL9
        vyYTgsISwoxL0VytjxD6aXuvEvKcfCG04IALL/mVRRtz9bWQ0R/skhLYz1uLX/mgkSKx17HiB7fr6
        JpU9o/0CzxkgnajDLASOkNmAc2jutjqHGcjoO1jCsxbZ63R8QgzJiAYdqh8MuVK4ZMRyXplb9Fga7
        EIPWViGo3O/t2Q/oyeISXIT6oyjuoQzm1chSqyMnPAsauRaHUC3jBH29mmfHhrcqpJk5TRu11CGM4
        MvbNlqiA==;
Received: from web2.bezdeka.de ([2a03:4000:2b:16ef::1] helo=email.bezdeka.de)
        by smtp.bezdeka.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <florian@bezdeka.de>)
        id 1pychc-00Av08-0k;
        Mon, 15 May 2023 20:13:44 +0200
MIME-Version: 1.0
Date:   Mon, 15 May 2023 20:13:43 +0200
From:   florian@bezdeka.de
To:     "Song, Yoong Siang" <yoong.siang.song@intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "Brouer, Jesper" <brouer@redhat.com>, davem@davemloft.net,
        "Keller, Jacob E" <jacob.e.keller@intel.com>, leonro@nvidia.com,
        naamax.meir@linux.intel.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] igc: read before write to SRRCTL register"
 failed to apply to 6.1-stable tree
In-Reply-To: <PH0PR11MB58305CBB67488FC9D6945208D8749@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <2023050749-deskwork-snowboard-82cf@gregkh>
 <46a3afc2-4b15-cb2d-b257-15e8928b8eec@bezdeka.de>
 <2023051115-width-squeeze-319b@gregkh>
 <PH0PR11MB58305CBB67488FC9D6945208D8749@PH0PR11MB5830.namprd11.prod.outlook.com>
Message-ID: <e0737a0b779ff06b135dd63a0f2926df@bezdeka.de>
X-Sender: florian@bezdeka.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-User: florian@bezdeka.de
X-Authenticator: login
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



Am 2023-05-11 08:56, schrieb Song, Yoong Siang:
> On Thursday, May 11, 2023 6:46 AM , Greg KH 
> <gregkh@linuxfoundation.org> wrote:
>> On Thu, May 11, 2023 at 12:01:36AM +0200, Florian Bezdeka wrote:
>>> Hi all,
>>> 
>>> On 07.05.23 08:44, gregkh@linuxfoundation.org wrote:
>>> >
>>> > The patch below does not apply to the 6.1-stable tree.
>>> > If someone wants it applied there, or to any other stable or
>>> > longterm tree, then please email the backport, including the
>>> > original git commit id to <stable@vger.kernel.org>.
>>> >
>>> > To reproduce the conflict and resubmit, you may use the following commands:
>>> >
>>> > git fetch
>>> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
>>> > linux-6.1.y git checkout FETCH_HEAD git cherry-pick -x
>>> > 3ce29c17dc847bf4245e16aad78a7617afa96297
>>> > # <resolve conflicts, build, test, etc.> git commit -s git
>>> > send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050749-
>> deskwork-snowboard-82cf@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
>>> 
>>> Is someone already working on that? I would love to see this patch in
>>> 6.1. If no further activities are planned I might have the 
>>> option/time
>>> to supply a backport as well.
>> 
>> Please supply a backport, I don't think anyone is working on it :)
> 
> Hi Florian,
> 
> I not yet got plan to backport the patch, so I am more than happy
> if you could supply a backport.
> 
> Most probably the issue is due to missing "#include 
> <linux/bitfield.h>".

Exactly.

The build failure:

In file included from drivers/net/ethernet/intel/igc/igc_hw.h:17,
                  from drivers/net/ethernet/intel/igc/igc.h:17,
                  from drivers/net/ethernet/intel/igc/igc_main.c:19:
drivers/net/ethernet/intel/igc/igc_main.c: In function 
‘igc_configure_rx_ring’:
drivers/net/ethernet/intel/igc/igc_base.h:92:41: error: implicit 
declaration of function ‘FIELD_PREP’ 
[-Werror=implicit-function-declaration]
    92 | #define IGC_SRRCTL_BSIZEHDR(x)          
FIELD_PREP(IGC_SRRCTL_BSIZEHDR_MASK, \
       |                                         ^~~~~~~~~~
drivers/net/ethernet/intel/igc/igc_main.c:647:19: note: in expansion of 
macro ‘IGC_SRRCTL_BSIZEHDR’
   647 |         srrctl |= IGC_SRRCTL_BSIZEHDR(IGC_RX_HDR_LEN);
       |


For 6.3 on-wards we have the following include chain:

In file included from ./include/net/xdp.h:11,
                  from ./include/linux/netdevice.h:43,
                  from ./include/linux/if_vlan.h:10,
                  from drivers/net/ethernet/intel/igc/igc_main.c:6:

I think <linux/bitfield.h> is available "by accident" and your mainline 
patch
is faulty. igc_base.h now depends on bitfield.h but you forgot to 
include it.

How do we deal with that? I think it should be fixed in mainline as 
well.

I fear that adding the missing include in igc_base.h within the backport
breaks any further auto-backporting for the igc driver as patches might
not apply cleanly when stable diverges from mainline.

Florian

> 
> Will you do it for 5.15 and 6.2 as well?
> 
> Thanks & Regards
> Siang
