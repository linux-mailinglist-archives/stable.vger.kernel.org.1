Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24047EF3D7
	for <lists+stable@lfdr.de>; Fri, 17 Nov 2023 14:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjKQNtl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 17 Nov 2023 08:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQNtk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 17 Nov 2023 08:49:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4EE120;
        Fri, 17 Nov 2023 05:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700228977; x=1731764977;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=MOj61IwibiRbGMi9xm3ZBK45QtdUny1wu/WcJXN0C/0=;
  b=YL2s4nt9Sb1aAwVJ12LzpF6qRjNaiwv52GIzQTtpE7bXO3x4YlEaEl5o
   42kuXZUGbIkhpyvaL9PaVs5HUOjAIYE/LMvZ0u728fW7+C0uCLVzrMit7
   2KgQtkbgib+EgkYLCbeP1MxlhcFeq71yFF31NXaWo8AcXxTzluXnX1AZz
   gyVLicZhug9M1J4u0uQpg/E0uqjdSGc3NUduJch7LJBmT8jW3/VaSjPsV
   Tk2WfAeMWWdLQIpgW5GYqw2GlkzrMIoTM0FSZ8TvbYzYuIhLk8F/f5unU
   DFXuEDPdeX2nI9lcQJNR0NJS7aEPyxtCPA0ExDXnYqmzqGOmaLZsC3xYc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="371480585"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="371480585"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 05:49:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="831617001"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="831617001"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga008.fm.intel.com with ESMTP; 17 Nov 2023 05:49:35 -0800
Message-ID: <c77909fd-18d3-4d5f-834c-a696e2abc9c8@linux.intel.com>
Date:   Fri, 17 Nov 2023 15:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To:     Niklas Neronin <niklas.neronin@linux.intel.com>,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org
References: <20231115121325.471454-1-niklas.neronin@linux.intel.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] usb: config: fix iteration issue in
 'usb_get_bos_descriptor()'
In-Reply-To: <20231115121325.471454-1-niklas.neronin@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 15.11.2023 14.13, Niklas Neronin wrote:
> The BOS descriptor defines a root descriptor and is the base descriptor for
> accessing a family of related descriptors.
> 
> Function 'usb_get_bos_descriptor()' encounters an iteration issue when
> skipping the 'USB_DT_DEVICE_CAPABILITY' descriptor type. This results in
> the same descriptor being read repeatedly.
> 
> To address this issue, a 'goto' statement is introduced to ensure that the
> pointer and the amount read is updated correctly. This ensures that the
> function iterates to the next descriptor instead of reading the same
> descriptor repeatedly.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3dd550a2d365 ("USB: usbcore: Fix slab-out-of-bounds bug during device reset")
> Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
> ---

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>


