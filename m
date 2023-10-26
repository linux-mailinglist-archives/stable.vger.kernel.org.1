Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465D37D860C
	for <lists+stable@lfdr.de>; Thu, 26 Oct 2023 17:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbjJZPdK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 26 Oct 2023 11:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjJZPdJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Oct 2023 11:33:09 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 08:33:08 PDT
Received: from fgw22-4.mail.saunalahti.fi (fgw22-4.mail.saunalahti.fi [62.142.5.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE29187
        for <stable@vger.kernel.org>; Thu, 26 Oct 2023 08:33:08 -0700 (PDT)
Received: from [192.168.1.15] (81-175-205-118.bb.dnainternet.fi [81.175.205.118])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTPSA
        id cf9cb88a-7414-11ee-a9de-005056bdf889;
        Thu, 26 Oct 2023 18:32:03 +0300 (EEST)
Message-ID: <7bfd4f9e-9f8d-4102-ab03-7d0401f00513@gmail.com>
Date:   Thu, 26 Oct 2023 18:32:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   LihaSika <lihasika@gmail.com>
Subject: Linux kernel 6.1 - drivers/usb/storage/unusual_cypress.h "Super Top"
 minimum bcdDevice too high
To:     stable@vger.kernel.org
Cc:     regressions@lists.linux.dev
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,	

in kernel 6.1 (maybe 5.x - 6.x) there's an ATACB setting for "Super Top 
USB 2.0 SATA Bridge" -devices, where the minimum bcdDevice version to 
match has been set to 1.60. It's in the file 
drivers/usb/storage/unusual_cypress.h:

"""
UNUSUAL_DEV( 0x14cd, 0x6116, 0x0160, 0x0160,
  		"Super Top",
  		"USB 2.0  SATA BRIDGE",
  		USB_SC_CYP_ATACB, USB_PR_DEVICE, NULL, 0),
"""

My old USB HDD with a "Super Top" bridge has bcdDevice version 1.50, 
thus the setting won't match and it will not mount.

I'm not sure when this changed (after kernel 4.x?), but it used to work 
before. Reading some earlier bug reports, it seems that the max version 
used to be 0x9999, which then caused corruption in "Super Top" devices 
with version >=2.20. So that's a reason for lowering the maximum value, 
but I wonder why the minimum value has also been set to 0x0160.


I created a patch, changing 0x0160 to 0x0150 (though I should've left 
the max version as it was...):

"""
UNUSUAL_DEV( 0x14cd, 0x6116, 0x0150, 0x0150,
"""

Built, installed and rebooted; now the USB HDD can be mounted and works 
perfectly again. I did some write & read tests, checked with diff, cmp 
and md5sum - no corruption, everything OK 👍


Best regards,
LihaS
