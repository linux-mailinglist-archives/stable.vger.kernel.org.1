Return-Path: <stable+bounces-73828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2B4970287
	for <lists+stable@lfdr.de>; Sat,  7 Sep 2024 15:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112981C21644
	for <lists+stable@lfdr.de>; Sat,  7 Sep 2024 13:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C8C15C151;
	Sat,  7 Sep 2024 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRshFzzi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A35615C13C;
	Sat,  7 Sep 2024 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725717128; cv=none; b=dWanJJJgOVmYtTcq2PAP/6gcsWx4suM5q/nPBUU2WU5DWTu1036MZv5dr2AIc7psSmzqAfdpfZu5k1ScYhIV1LIp3UuYf05UhfzWP3MZY3G1SSdPOZmSjppsWDmmEt31XCp7shBAf+oMC3Dirpq6V2NNitHEpM6dY11P1uKZDvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725717128; c=relaxed/simple;
	bh=MYrO/3eKljHyoKJjSw8BBububPsJc6vLPebzXA5ILLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfqT7rxb6xnsLZBYDVgyatDk/etsZHpegKy186HWYn/SRMJDq+iIMSyBB/k8iyZPZw8c6D5HcuXdkkuXNNBr1x1saU1RfCgyT8U4ACdxCktFNDi/j5dicz+dtRcg5mEAAU4k8UkkOHQh3aRiHiQnCAALTSg6QAPaYa6usF3T0so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRshFzzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9089AC4CEC2;
	Sat,  7 Sep 2024 13:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725717128;
	bh=MYrO/3eKljHyoKJjSw8BBububPsJc6vLPebzXA5ILLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bRshFzzihKz7KcoG149wshja98LfJ2ZGlpiI96+3s2DvdHyw6EeJiCLWqjhfJo8oq
	 wjtkprMaMTouRtQTTTIMBSH3qnJeSK+PnANQat9T3C0FKPuAmLfX0snkJ+OcWwDYJa
	 dxuV3baL39uwwsocxhbDXzN4z87U+h2KF6U8vCddICIx8CbZrzsT5Y9vC7mU5N+EeJ
	 uYYeQZe4oMj1N976JWokknF7Rm0ilKPneEjWo8Y/4js0rqutlpFgHDPZ/Z11QnvTKr
	 fpNgN43LC/H6Hn0hSDUxLX/IoSSCbev6FmrEnqXXlqwfVXJ4/Rv0nkUqJCfzr+fiy3
	 RvVXgZSjMHN2Q==
Date: Sat, 7 Sep 2024 14:52:03 +0100
From: Simon Horman <horms@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Gui-Dong Han <hanguidong02@outlook.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, stable@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH v2] ice: Fix improper handling of refcount in
 ice_sriov_set_msix_vec_count()
Message-ID: <20240907135203.GQ2097826@kernel.org>
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

Yes, I agree that might be nice. But the changes made by this patch are
consistent with the exiting error handling in this function. And as a fix,
this minimal approach seems appropriate to me. IOW, I believe clean-up
should be separated from fixes in this case.

