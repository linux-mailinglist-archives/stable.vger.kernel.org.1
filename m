Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D12E7C9376
	for <lists+stable@lfdr.de>; Sat, 14 Oct 2023 10:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjJNIau (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 14 Oct 2023 04:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjJNIau (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 14 Oct 2023 04:30:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ED9B7
        for <stable@vger.kernel.org>; Sat, 14 Oct 2023 01:30:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAF7C433C8;
        Sat, 14 Oct 2023 08:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697272248;
        bh=kFIkQHkAUZ3uMClZ43oS+n85biMfLgyyRN1pwUAENjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CoMX+pQ4/m0EUzLJQ8Wk6YFvQy7Mfv5hylQT+2Yb2xh6V5oyGWkeyJN06G5EUQFKx
         CKNVgg4JxQtUHFJb8hjNhsTl2mqCMAvVBEespv1kBMbThLAQwZ6DY2gg1tp0UdGUI7
         yet6Ehu5UlSz48wJawh06q7Cc7MU0Y9N89t97fRI=
Date:   Sat, 14 Oct 2023 10:30:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gaurav Batra <gbatra@linux.vnet.ibm.com>
Cc:     gbatra@us.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH 25/25] powerpc/pseries/iommu: enable_ddw incorrectly
 returns direct mapping for SR-IOV device
Message-ID: <2023101423-chastity-heavily-e065@gregkh>
References: <20231013142945.1956-1-gbatra@linux.vnet.ibm.com>
 <20231013142945.1956-25-gbatra@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013142945.1956-25-gbatra@linux.vnet.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 13, 2023 at 09:29:45AM -0500, Gaurav Batra wrote:
> Bugzilla Number: 202953
> 
> Upstream CommitID:
> 
> Dependency-commit: d61cd13e732c0eaa7d66b45edb2d0de8eab65a1e

What are these values for?

confused,

greg k-h
