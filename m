Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBE37DE38E
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 16:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjKAPPb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 1 Nov 2023 11:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKAPPa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 1 Nov 2023 11:15:30 -0400
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9044102
        for <stable@vger.kernel.org>; Wed,  1 Nov 2023 08:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1698851727; x=1730387727;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=w5xQ/d4cO8gQ4yD5VnleyT3Px4A1Vf/0MqFsXHmpW8I=;
  b=greL//EPSuyAt2d0QP8BYCA0yjtqOhnN4I+IAyZAQBgi8iNXdpGadkLW
   bcNcEp/rbNJ2EPngIiE/lxfQK/jV1ac7flQR/Rdo9SIv1ZKbJheEbs7VJ
   S6b+OClHNuTyhqcbu8uBCIjb1p29kMS4m5fiA4q/bH+LYmHQ3JuQLjhRE
   s=;
X-IronPort-AV: E=Sophos;i="6.03,268,1694736000"; 
   d="scan'208";a="40246244"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 15:15:25 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
        by email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com (Postfix) with ESMTPS id C0E0540D72;
        Wed,  1 Nov 2023 15:15:25 +0000 (UTC)
Received: from EX19MTAUEC001.ant.amazon.com [10.0.0.204:14653]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.84.122:2525] with esmtp (Farcaster)
 id 8a594ed7-ef79-43ac-80bc-e01a655f1077; Wed, 1 Nov 2023 15:15:24 +0000 (UTC)
X-Farcaster-Flow-ID: 8a594ed7-ef79-43ac-80bc-e01a655f1077
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 1 Nov 2023 15:15:24 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Wed, 1 Nov 2023 15:15:24 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
        id 1C6AD2B44; Wed,  1 Nov 2023 16:15:24 +0100 (CET)
From:   Mahmoud Adam <mngyadam@amazon.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>
Subject: Re: backport "x86: change default to
 spec_store_bypass_disable=prctl spectre_v2_user=prctl"
In-Reply-To: <2023101401-boxer-grandpa-6e31@gregkh> (Greg KH's message of
        "Sat, 14 Oct 2023 11:27:42 +0200")
References: <lrkyqy1g6bnqi.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
        <2023101401-boxer-grandpa-6e31@gregkh>
Date:   Wed, 1 Nov 2023 16:15:24 +0100
Message-ID: <lrkyq4ji533oz.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> Why is this required at all?  It just changes a default option, you can
> set the "faster" option yourself if you really feel it is a good idea
> for older kernels, why can't you do that for containers you want it
> enabled on for these older kernels?

The patch has already motivations of why this is a better default, and
changing this would give performance improvements

> And what exact kernel versions did you test this on?

this was tested on 5.15 and 5.10

> And how is this not a new feature?

As you mentioned it changes the default option, Why is this considered a
new feature?

thanks,
MNAdam
