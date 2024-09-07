Return-Path: <stable+bounces-73829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E259702A4
	for <lists+stable@lfdr.de>; Sat,  7 Sep 2024 16:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B691C21C60
	for <lists+stable@lfdr.de>; Sat,  7 Sep 2024 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A4515D5DE;
	Sat,  7 Sep 2024 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ep1ZulgP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1475514EC5D;
	Sat,  7 Sep 2024 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725718417; cv=none; b=ZKr6RV7sdrJNF3qKWd7LxlzQ6TEeMDUaJYIBuaflIwr7CSyA7vSn3fnr5sbLipge8aveOoTnFE2h4k8d2wM8HkxR50WrQ/nNzA9iz/Dk+ULhPzNrBd1yW1nMCn6OFb0BGESJJTofEGiDU0ojDwX1eqBtntwarHJasvwdiKUPfxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725718417; c=relaxed/simple;
	bh=qko2OkevnRrLYu4Aceoty+wFI+V0BJzREcrgVKbYvzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOcgyZXr1LwVpuLldkpkxjw6UKhjUXab12jDWhhDoNmYa9C7HAeuM930JO4np0NMC4S0wyOKeuI1a6Le4WzvSPZ+lnmjAlE1XVD99LNKQ7ZG3qrVNYrIAtIbT/mfDfu0pENWN9AZuBRgAwWDxcaasT+72FxJm/6b1xvOm4a8+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ep1ZulgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D202DC4CEC2;
	Sat,  7 Sep 2024 14:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725718416;
	bh=qko2OkevnRrLYu4Aceoty+wFI+V0BJzREcrgVKbYvzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ep1ZulgPBOi90upuj78yyY44kQrOiGBIvQGRExVuiIpavifk9h4CW4VN6a+VXbG5D
	 XFlIaz9pafb+t1TlK2U8d0SDtd8NPm8XjZfHkMd0odL3HgDObmFSJzuBwZyibhCvJy
	 vUe0ZeEynzzgAOETq8XSy6JYkwI2xaWpje83NRl0=
Date: Sat, 7 Sep 2024 16:13:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Gui-Dong Han <hanguidong02@outlook.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, stable@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH v2] ice: Fix improper handling of refcount in
 ice_sriov_set_msix_vec_count()
Message-ID: <2024090715-grief-uneasily-4aa6@gregkh>
References: <SY8P300MB0460D0263B2105307C444520C0932@SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM>
 <99a2d643-9004-41c8-8585-6c5c86fab599@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99a2d643-9004-41c8-8585-6c5c86fab599@web.de>

On Sat, Sep 07, 2024 at 02:40:10PM +0200, Markus Elfring wrote:
> …
> > +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> > @@ -1096,8 +1096,10 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
> >  		return -ENOENT;
> >
> >  	vsi = ice_get_vf_vsi(vf);
> > -	if (!vsi)
> > +	if (!vsi) {
> > +		ice_put_vf(vf);
> >  		return -ENOENT;
> > +	}
> >
> >  	prev_msix = vf->num_msix;
> >  	prev_queues = vf->num_vf_qs;
> > @@ -1142,8 +1144,10 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
> >  	vf->num_msix = prev_msix;
> >  	vf->num_vf_qs = prev_queues;
> >  	vf->first_vector_idx = ice_sriov_get_irqs(pf, vf->num_msix);
> > -	if (vf->first_vector_idx < 0)
> > +	if (vf->first_vector_idx < 0) {
> > +		ice_put_vf(vf);
> >  		return -EINVAL;
> > +	}
> >
> >  	if (needs_rebuild) {
> >  		ice_vf_reconfig_vsi(vf);
> 
> Would you like to collaborate with any goto chains according to
> the desired completion of exception handling?
> 
> Regards,
> Markus
> 


Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

