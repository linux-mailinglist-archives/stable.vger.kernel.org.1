Return-Path: <stable+bounces-56330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C11C59238B9
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 10:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843F228196A
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 08:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FCB146D65;
	Tue,  2 Jul 2024 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gG5bpCkJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A552F84D39
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910090; cv=none; b=no4SDqX05JKFwNfaTa6MeHGNCRKDLOrjl8x0eB4wf40tsZNI7aSoORpijXCA/nPONQfV3YyiUe9Fu4pf+VS6gBB8ANCGJJkNMvYuxJO/1838RATTKyRkk5435WwOI0kCIMdNn094DBpXVIQsXCzPHdT2CpW9VF/Q3v0RlhNHRe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910090; c=relaxed/simple;
	bh=2DJnbyMo9zsTqEM6TqtJCym6zLKfvaxTuus5Em3iLIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orgJAZF5zZoT89rqMmfuk5Dy1ocdXUH8XTeyXs78ahdDY7B0tQSSPMhpFAlXVOz2XU1FL+ae4O6yzw2WpLesOEClrpoixN1GTsjVMrgf3h8Vnd4/QpnsTEJFskqmA5t39Bt6Hfx0gkVoddcHGIVkZs8c+7f+slN80sPrDa7Dl+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gG5bpCkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF618C116B1;
	Tue,  2 Jul 2024 08:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719910090;
	bh=2DJnbyMo9zsTqEM6TqtJCym6zLKfvaxTuus5Em3iLIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gG5bpCkJRU+lCbkL/5N5hkow7RgH1mqCaRB4vsHfjTW5hjaxAmMnnvLUfBDZif0jW
	 nUyPT8yLJREzQ9ModKTf9Grq/cfzUHb0cEcjEJmS7CgGoPDtVJOOkbMUE7ssX3WFyG
	 OffIhFb/POeUHC9FdZ8RbCqvDamAnAnfHbwVWXX8=
Date: Tue, 2 Jul 2024 10:48:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>,
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, yhs@fb.com, mykolal@fb.com,
	luizcap@amazon.com
Subject: Re: [PATCH 6.1.y v2 1/6] bpf: allow precision tracking for programs
 with subprogs
Message-ID: <2024070249-cannabis-shakily-842b@gregkh>
References: <20230724124223.1176479-1-eddyz87@gmail.com>
 <20230724124223.1176479-2-eddyz87@gmail.com>
 <tof56dmde2ykrnqy33pz7evpzlwskpxnmxf3wa4lkeinhjung6@zthg6lsnmnwf>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tof56dmde2ykrnqy33pz7evpzlwskpxnmxf3wa4lkeinhjung6@zthg6lsnmnwf>

On Tue, Jun 25, 2024 at 03:28:31PM +0800, Shung-Hsi Yu wrote:
> Hi Greg,
> 
> On Mon, Jul 24, 2023 at 03:42:18PM GMT, Eduard Zingerman wrote:
> > [ Upstream commit be2ef8161572ec1973124ebc50f56dafc2925e07 ]
> > 
> ...
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> ...
> > @@ -2670,6 +2679,11 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
> >  			 */
> >  			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL && insn->imm == 0)
> >  				return -ENOTSUPP;
> > +			/* BPF helpers that invoke callback subprogs are
> > +			 * equivalent to BPF_PSEUDO_CALL above
> > +			 */
> > +			if (insn->src_reg == 0 && is_callback_calling_function(insn->imm))
> > +				return -ENOTSUPP;
> >  			/* regular helper call sets R0 */
> >  			*reg_mask &= ~1;
> >  			if (*reg_mask & 0x3f) {
> 
> Looks like the above hunk is slightly misplaced.
> 
> In master the lines are added _before_ the BPF_PSEUDO_KFUNC_CALL check,
> resulting in deviation from upstream as well as interfering with
> backporting of commit be2ef8161572 ("bpf: allow precision tracking for
> programs with subprogs") to stable v6.1.
> 
> What would be the suggested action here?
> 1. Send a updated version of the whole be2ef8161572 patch to stable
> 2. Send a minimal refresh patch like the one found in this email to
>    stable
> 3. Adapt to this deviation in my backport of commit be2ef8161572 for
>    stable

Please send a fix-up patch for this as I can't change the existing
releases.

thanks,

greg k-h

