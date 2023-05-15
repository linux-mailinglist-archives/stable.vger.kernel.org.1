Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC53B702CF1
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 14:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241932AbjEOMmH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 08:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbjEOMlt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 08:41:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D54E53
        for <stable@vger.kernel.org>; Mon, 15 May 2023 05:40:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56AC662369
        for <stable@vger.kernel.org>; Mon, 15 May 2023 12:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BCDC433D2;
        Mon, 15 May 2023 12:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684154457;
        bh=Xvw8refQnUIGmLzdqLtiTWV2uw1Yg5/q1hCejjXmxSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWhlR1P9BbKkZ30LkaZ/LnMd3HVEK+DJkMZ9OsmnxjOYatbZ5gQDDc2vuGVncdGd2
         gVkphsQqf9WjNUZHX4NBRNf5QjaSmN31gJerdHaTBOWcHn+XmG8JQZdNUq4oHUmafy
         XpIrf3z6poEHpGpk1as8S1DfVBHjusngD09ASJmY=
Date:   Mon, 15 May 2023 14:40:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     stable@vger.kernel.org, Anatoli.Antonovitch@amd.com,
        alex.williamson@redhat.com, amichon@kalrayinc.com,
        andrey2805@gmail.com, ashok.raj@intel.com, bhelgaas@google.com,
        dstein@hpe.com, ian.may@canonical.com, michael.haeuptle@hpe.com,
        mika.westerberg@linux.intel.com, rahul.kumar1@amd.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        wangxiongfeng2@huawei.com, zhangjialin11@huawei.com
Subject: Re: [PATCH 5.4.y 1/2] PCI: pciehp: Use
 down_read/write_nested(reset_lock) to fix lockdep errors
Message-ID: <2023051543-serotonin-fester-78f2@gregkh>
References: <0296a234ed04adfec0f256b24fae929f6a268509.1683628574.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0296a234ed04adfec0f256b24fae929f6a268509.1683628574.git.lukas@wunner.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 09, 2023 at 12:41:09PM +0200, Lukas Wunner wrote:
> From: Hans de Goede <hdegoede@redhat.com>
> 
> commit 085a9f43433f30cbe8a1ade62d9d7827c3217f4d upstream.

All now queued up, thanks.

greg k-h
