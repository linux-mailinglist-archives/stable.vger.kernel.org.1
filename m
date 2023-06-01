Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0EB719757
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 11:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjFAJoP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 05:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjFAJoP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 05:44:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E3BD7
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 02:44:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AC67641D0
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 09:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2262EC433D2;
        Thu,  1 Jun 2023 09:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685612653;
        bh=KeJijn1cAP93TXRZnlnCAc6Ymw9X50flgPprbrFO9xQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FflH6MCNMF7P0pJ+j4dEp25PHInOFVC3fjDfzahtUEsJcE5fIregcEFAuYxpr/9Ma
         BTkTQES+Zr9oHdgRCFHNcnYqzWPSiERrhZ4pi3FLxSV+gjdDxfqFnsAYqXu8Xd2QAA
         sFiXya7qczrytInbw2jbZYKeCuqURsyI/jYv9XN4=
Date:   Thu, 1 Jun 2023 10:44:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Piyush Sachdeva <piyushs@linux.ibm.com>
Cc:     stable@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Tarun Sahu <tsahu@linux.ibm.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.2.16] mm/vmemmap/devdax: fix kernel crash when probing
 devdax devices
Message-ID: <2023060128-kindness-vision-7ce7@gregkh>
References: <2023050736-railway-greyhound-b246@gregkh>
 <43baafa1897127eb0e362bba3e785740017afc50.1684485577.git.piyushs@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43baafa1897127eb0e362bba3e785740017afc50.1684485577.git.piyushs@linux.ibm.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 30, 2023 at 06:51:46PM +0530, Piyush Sachdeva wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> 
> [ Upstream commit 87a7ae75d7383afa998f57656d1d14e2a730cc47 ]

6.2.y is long end-of-life, so there's nothing we can do here.  Always
remember to check the front page of kernel.org to see the list of
kernels to check if they are active or not.

thanks,

greg k-h
