Return-Path: <stable+bounces-204489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F2ACEEE66
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 16:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCA543011F88
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 15:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58E627E7DA;
	Fri,  2 Jan 2026 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="DhXt/xB3"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E227D786;
	Fri,  2 Jan 2026 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767368612; cv=none; b=EEvRnZcGRwdSQMHdsssn11CwaJIM/IS9WXKTl488nBR9qZIUQ36GtiypU2uzsbr67Ew8SJUcLy6dZQuBh0wIhmR3ncPlZf9fzWMcp/jZjfsn8iLexbCc9I8umyOmOdjeR3AItmLH/HcEun4u0qXCkAnO6np8aIFUs/O+xpYRuAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767368612; c=relaxed/simple;
	bh=LUAbwzwebUPLNRmd7O1YDQA4ve1R2wFu1VV/nEiRio8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOt0ghfKWQNSlshrIpM8Tpp1PIwoTIVNwJVFtaCdv9Y5ZsFOwAhX5UScAV4Xnf+4x1h3HEBarG1BQDI/ag0u5kVeSAlhOTQJt84msBLgPnG8rx9bZpMODn/MSnNMpGH1eKLXH99sqffMnErRoe5vv0oppZLLCM8IqynTTOYe87w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=DhXt/xB3; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=0t9mnhJSHOECX4KKppwdSKbhkFJo/W7qfjc5l3Ril5k=; b=DhXt/xB3ETIg6Y6xEBN2I1ztJz
	11XWIjk3f5y5f8cw7qR99jIPofQo39yuaWKZLN8GFgrMIETGLuzkhf8M01TUfLu/kErSuHiQ2im3P
	y4eGcFnKm+ANnnoDxN4UqJvlPtZWqqaB5HiOPW3+VAWC0K6o9jY4ICV9H/EEwmkj4cZkfRhljQkNI
	zDTG+FGN8MxXK6OrIm415D3w9HhvtYGyKjS1tK9hQjSSNKHvI3fX2v0PQ3oWLQsfBlEm5cPSgp7mL
	WNIuBEhnzliwDJTbPJFKJ2C6DFD4anTA2WWI5wT38kaxBhwGKOjN3DGieNkb2/K4rQWamstuxNLG8
	EDO6DU1Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vbhJ2-00EYVY-87; Fri, 02 Jan 2026 15:43:12 +0000
Date: Fri, 2 Jan 2026 07:43:07 -0800
From: Breno Leitao <leitao@debian.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Michael Chan <michael.chan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH net] bnxt_en: Fix NULL pointer crash in bnxt_ptp_enable
 during error cleanup
Message-ID: <nejlqwxc4ekfhmpodjm63cfob4o5uf2z7qukk3daofykegnwvs@sksxy4lmxrnd>
References: <20251231-bnxt-v1-1-8f9cde6698b4@debian.org>
 <CALs4sv2qQuL0trq3ZB6SczPK5BmFMF6p2Ki-3q+4Xqc_qzauoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs4sv2qQuL0trq3ZB6SczPK5BmFMF6p2Ki-3q+4Xqc_qzauoQ@mail.gmail.com>
X-Debian-User: leitao

Hello Pavan,

On Wed, Dec 31, 2025 at 09:30:57PM +0530, Pavan Chebbi wrote:
> On Wed, Dec 31, 2025 at 6:35 PM Breno Leitao <leitao@debian.org> wrote:
> > Fix this by checking if bp->hwrm_dma_pool is NULL at the start of
> > bnxt_ptp_enable(). During error/cleanup paths when HWRM resources have
> > been freed, return success without attempting to send commands since the
> > hardware is being torn down anyway.
> >
> > During normal operation, the DMA pool is always valid so PTP
> > functionality is unaffected.
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Fixes: a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable events")
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> > index a8a74f07bb54..a749bbfa398e 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> > @@ -482,6 +482,13 @@ static int bnxt_ptp_enable(struct ptp_clock_info *ptp_info,
> >         int pin_id;
> >         int rc;
> >
> > +       /* Return success if HWRM resources are not available.
> > +        * This can happen during error/cleanup paths when DMA pool has been
> > +        * freed.
> > +        */
> > +       if (!bp->hwrm_dma_pool)
> 
> Thanks for the fix. While it's valid, just that to me, this check here
> looks a bit odd.
> Why not call bnxt_ptp_clear() before bnxt_free_hwrm_resources() in the
> unwind path?

I thought about it, but, I didn't understand all the implication of
changing the unwind order. 

Anyway, I've have tested the current patch and it worked fine. Do you
think we should move kfree(bp->ptp_cfg) closer to bnxt_ptp_clear()?

Thanks for the review,
--breno


commit d07c08889f75966d6829b93304de5030cf4e66aa
Author: Breno Leitao <leitao@debian.org>
Date:   Wed Dec 31 04:00:57 2025 -0800

    bnxt_en: Fix NULL pointer crash in bnxt_ptp_enable during error cleanup
    
    When bnxt_init_one() fails during initialization (e.g.,
    bnxt_init_int_mode returns -ENODEV), the error path calls
    bnxt_free_hwrm_resources() which destroys the DMA pool and sets
    bp->hwrm_dma_pool to NULL. Subsequently, bnxt_ptp_clear() is called,
    which invokes ptp_clock_unregister().
    
    Since commit a60fc3294a37 ("ptp: rework ptp_clock_unregister() to
    disable events"), ptp_clock_unregister() now calls
    ptp_disable_all_events(), which in turn invokes the driver's .enable()
    callback (bnxt_ptp_enable()) to disable PTP events before completing the
    unregistration.
    
    bnxt_ptp_enable() attempts to send HWRM commands via bnxt_ptp_cfg_pin()
    and bnxt_ptp_cfg_event(), both of which call hwrm_req_init(). This
    function tries to allocate from bp->hwrm_dma_pool, causing a NULL
    pointer dereference:
    
      bnxt_en 0000:01:00.0 (unnamed net_device) (uninitialized): bnxt_init_int_mode err: ffffffed
      KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
      Call Trace:
       __hwrm_req_init (drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c:72)
       bnxt_ptp_enable (drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:323 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:517)
       ptp_disable_all_events (drivers/ptp/ptp_chardev.c:66)
       ptp_clock_unregister (drivers/ptp/ptp_clock.c:518)
       bnxt_ptp_clear (drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:1134)
       bnxt_init_one (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16889)
    
    Lines are against commit f8f9c1f4d0c7 ("Linux 6.19-rc3")
    
    Fix this by clearing and unregistering ptp (bnxt_ptp_clear()) before
    freeing HWRM resources.
    
    Suggested-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
    Signed-off-by: Breno Leitao <leitao@debian.org>
    Fixes: a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable events")
    Cc: stable@vger.kernel.org

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d17d0ea89c36..68fc9977b375 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16882,10 +16882,10 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 init_err_pci_clean:
 	bnxt_hwrm_func_drv_unrgtr(bp);
+	bnxt_ptp_clear(bp);
 	bnxt_free_hwrm_resources(bp);
 	bnxt_hwmon_uninit(bp);
 	bnxt_ethtool_free(bp);
-	bnxt_ptp_clear(bp);
 	kfree(bp->ptp_cfg);
 	bp->ptp_cfg = NULL;
 	kfree(bp->fw_health);

