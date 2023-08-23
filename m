Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D3D785C77
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 17:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbjHWPsJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 11:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjHWPsI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 11:48:08 -0400
X-Greylist: delayed 128 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Aug 2023 08:48:03 PDT
Received: from dmta0005-f.nifty.com (mta-fbsnd00006.nifty.com [106.153.226.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CCB10C8
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 08:48:03 -0700 (PDT)
Received: from HP-Z230 by dmta0014.nifty.com with ESMTP
          id <20230823154533799.CXBB.104216.HP-Z230@nifty.com>;
          Thu, 24 Aug 2023 00:45:33 +0900
Date:   Thu, 24 Aug 2023 00:45:33 +0900
From:   Takashi Yano <takashi.yano@nifty.ne.jp>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     gregkh@linuxfoundation.org, patches@lists.linux.dev,
        sashal@kernel.org, stable@vger.kernel.org, tasos@tasossah.com
Subject: Re: [PATCH 6.1 110/181] ALSA: ymfpci: Create card with
 device-managed snd_devm_card_new()
Message-Id: <20230824004533.eef5bfded08b8af05f71bee9@nifty.ne.jp>
In-Reply-To: <87h6ophml0.wl-tiwai@suse.de>
References: <20230403140418.679274299@linuxfoundation.org>
        <20230823135846.1812-1-takashi.yano@nifty.ne.jp>
        <87h6ophml0.wl-tiwai@suse.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 23 Aug 2023 16:15:07 +0200
Takashi Iwai wrote:
> On Wed, 23 Aug 2023 15:58:46 +0200,
> Takashi Yano wrote:
> > 
> > Dear Linux Kernel Team,
> > 
> > I had encountered the problem that I reported to debian kernel team:
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1050117
> > , where I was suggested to report this to upstream.
> > 
> > After a lot of struggle, I found that this issue occurs after the following
> > commit. The problem happens if a YAMAHA YMF7x4 sound card is present AND the
> > firmware is missing. Not only the shutdown/reboot problem, but the page fault,
> > whose error log is being cited following the commit, also occurs in the boot
> > process.
> (snip)
> > I looked into this problem and found the mechanism of the page fault.
> > 
> > 1) chip->reg_area_virt is mapped in sound/pci/ymfpci/ymfpci_main.c:
> >    snd_ymfpci_create() in the initialize process of snd_ymfpci.
> > 2) The initializing fails due to a lack of the firmware.
> > 3) The allocated resources are released in drivers/base/devres.c:
> >    release_nodes().
> > 4) In the release process 3), reg_area_virt is unmapped before calling
> >    sound/pci/ymfpci/ymfpci_main.c: snd_ymfpci_free().
> > 5) The first register access in sound/pci/ymfpci/ymfpci_main.c:
> >    snd_ymfpci_free() causes page fault because the reg_area_virt is
> >    already unmapped.
> > 
> > Unfortunately, I am not familiar with the linux kernel code, so I am not
> > sure of the appropriate way how the problem should be fixed.
> 
> Thanks for the report and the analysis.  Yes, it's the problem of the
> device release, and this driver was overlooked while it's been fixed in
> a few others.
> 
> Below is the fix patch.  Let me know if it works for you, then I'll
> submit to the upstream and let stable branch backporting it later.

Thank you for your amazingly quick reply. :)
I have confirmed that the following patch solves the problem.
With this patch, snd_ymfpci_free() no longer seems to be called in
the release process on error.

Thank you so much for your help.

> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: ymfpci: Fix the missing snd_card_free() call at probe
>  error
> 
> Like a few other drivers, YMFPCI driver needs to clean up with
> snd_card_free() call at an error path of the probe; otherwise the
> other devres resources are released before the card and it results in
> the UAF.
> 
> This patch uses the helper for handling the probe error gracefully.
> 
> Fixes: f33fc1576757 ("ALSA: ymfpci: Create card with device-managed snd_devm_card_new()")
> Cc: <stable@vger.kernel.org>
> Reported-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Closes: https://lore.kernel.org/r/20230823135846.1812-1-takashi.yano@nifty.ne.jp
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/ymfpci/ymfpci.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/pci/ymfpci/ymfpci.c b/sound/pci/ymfpci/ymfpci.c
> index b033bd290940..48444dda44de 100644
> --- a/sound/pci/ymfpci/ymfpci.c
> +++ b/sound/pci/ymfpci/ymfpci.c
> @@ -152,8 +152,8 @@ static inline int snd_ymfpci_create_gameport(struct snd_ymfpci *chip, int dev, i
>  void snd_ymfpci_free_gameport(struct snd_ymfpci *chip) { }
>  #endif /* SUPPORT_JOYSTICK */
>  
> -static int snd_card_ymfpci_probe(struct pci_dev *pci,
> -				 const struct pci_device_id *pci_id)
> +static int __snd_card_ymfpci_probe(struct pci_dev *pci,
> +				   const struct pci_device_id *pci_id)
>  {
>  	static int dev;
>  	struct snd_card *card;
> @@ -348,6 +348,12 @@ static int snd_card_ymfpci_probe(struct pci_dev *pci,
>  	return 0;
>  }
>  
> +static int snd_card_ymfpci_probe(struct pci_dev *pci,
> +				 const struct pci_device_id *pci_id)
> +{
> +	return snd_card_free_on_error(&pci->dev, __snd_card_ymfpci_probe(pci, pci_id));
> +}
> +
>  static struct pci_driver ymfpci_driver = {
>  	.name = KBUILD_MODNAME,
>  	.id_table = snd_ymfpci_ids,
> -- 
> 2.35.3
> 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
