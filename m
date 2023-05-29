Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CC37148B6
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 13:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjE2LjL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 07:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjE2LjJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 07:39:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E81F91;
        Mon, 29 May 2023 04:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685360322; x=1716896322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xp6DOmsiV051RKXvtEe9tCC5u7UbWlALrAF8xAyV7dI=;
  b=ZndI9a9F+NVmTbZTjBJh/1mM3oCrk+sz2YavOJlI32uvjJBgYJaKjrTs
   ApQnS1uCdoP6aRiBdxN50TEXDOIrThH64DuzK7T5k3SP+mbThhFCrF1Ws
   xmjr81qNv3vdtbgpwcPQ7M7jXnRC9MivdfFhXAm8Ezshvx2qvwhv8pxse
   uWtkJ7bkV3Sd+e5zVF9Za3dT/UvQ6jX9tRLj6GaDHIJUpyoETqg+lQd34
   kcsgW3b80iOISq+P05SdFswSeiLmHuqYErZw/SB6qfcgBsU+NTuCZburC
   5WrIIzDx8UwtAfIBgFNTHLNcnuUQQwi/NxJCZAxlHp4ZLCkcv6eLWBl46
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="354699069"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="354699069"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 04:38:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="1036190570"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="1036190570"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 29 May 2023 04:38:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 4A5C3350; Mon, 29 May 2023 14:38:13 +0300 (EEST)
Date:   Mon, 29 May 2023 14:38:13 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        beld zhang <beldzhang@gmail.com>, stable@vger.kernel.org,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: 6.1.30: thunderbolt: Clear registers properly when auto clear
 isn't in use cause call trace after resume
Message-ID: <20230529113813.GZ45886@black.fi.intel.com>
References: <CAG7aomXv2KV9es2RiGwguesRnUTda-XzmeE42m0=GdpJ2qMOcg@mail.gmail.com>
 <ZHKW5NeabmfhgLbY@debian.me>
 <261a70b7-a425-faed-8cd5-7fbf807bdef7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <261a70b7-a425-faed-8cd5-7fbf807bdef7@amd.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, May 28, 2023 at 07:55:39AM -0500, Mario Limonciello wrote:
> On 5/27/23 18:48, Bagas Sanjaya wrote:
> > On Sat, May 27, 2023 at 04:15:51PM -0400, beld zhang wrote:
> > > Upgrade to 6.1.30, got crash message after resume, but looks still
> > > running normally
> 
> This is specific resuming from s2idle, doesn't happen at boot?
> 
> Does it happen with hot-plugging or hot-unplugging a TBT3 or USB4 dock too?

Happens also when device is connected and do

  # rmmod thunderbolt
  # modprobe thunderbolt

I think it is because nhi_mask_interrupt() does not mask interrupt on
Intel now.

Can you try the patch below? I'm unable to try myself because my test
system has some booting issues at the moment.

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 4c9f2811d20d..a11650da40f9 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -60,9 +60,12 @@ static int ring_interrupt_index(const struct tb_ring *ring)
 
 static void nhi_mask_interrupt(struct tb_nhi *nhi, int mask, int ring)
 {
-	if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
-		return;
-	iowrite32(mask, nhi->iobase + REG_RING_INTERRUPT_MASK_CLEAR_BASE + ring);
+	if (nhi->quirks & QUIRK_AUTO_CLEAR_INT) {
+		u32 val = ioread32(nhi->iobase + REG_RING_INTERRUPT_BASE + ring);
+		iowrite32(val & ~mask, nhi->iobase + REG_RING_INTERRUPT_BASE + ring);
+	} else {
+		iowrite32(mask, nhi->iobase + REG_RING_INTERRUPT_MASK_CLEAR_BASE + ring);
+	}
 }
 
 static void nhi_clear_interrupt(struct tb_nhi *nhi, int ring)
