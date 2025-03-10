Return-Path: <stable+bounces-121699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFB8A59223
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 12:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82855188BF4B
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 11:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90723227B81;
	Mon, 10 Mar 2025 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXgQzXPp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC8222577C
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604413; cv=none; b=aPGopMsCs+3VHIkljH1CjpYtl7jg5DuYmi58KlD+uq3sfk6qoSLtb/QpVTPQlaDkqXmGIT8bSywg9T7xycM0DgQ1Ak++3XRyaObzfHw8vcRcHdO2JhJnjCoLi/v4JEROlg/2+sKc00ky8c9on/Fthuhorb5Ksez01pi5iNkSyZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604413; c=relaxed/simple;
	bh=XaQBs1Nr/FchWKiFTmuwev64vfYgVRJ7ab2aDhqhA1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpAxQADwWOLXx4cP0azn5FBbQyKBGJD1j135Nh052KjIsXvyWDArHyipfYmezBFQ/Nqi9RrsrL87FoBNoOjIBtPi2VNAcjOpbTE/eUBQU2l3xQN+zhxiyXF2IZ+Jsogj8f9mBIIevrwPxXT3YHqKFyOu1jnkjJugvYjnBQYP7Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXgQzXPp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741604411; x=1773140411;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=XaQBs1Nr/FchWKiFTmuwev64vfYgVRJ7ab2aDhqhA1c=;
  b=lXgQzXPpI4XOVrEuEFhgGXfObYdzt6rZp7HOAMUR0XbIgUkeH8+YXpuZ
   J3V5io5S9+bCvaDHDuAqlnx5NX2Z2sYTM/R9NfdG2kbE6tNOF+naeYrR2
   cl708TDpXTD0XUdroOmIAqYgF10edVQpDca5f9EpyX4fCNAoYbJVMwqYN
   wrsdcgE9yEJ9sz+xS++FKaLugDf7q+qHzzSA3haMxPPqYYURPcECx8ycD
   BrjNUntj3nowFnzIgFRCpEPg4li9RQpt3fnjE8xyCk27hmk9hOLEnfkSw
   bdNb1ETi5LoIpqwPa/aJYJyuE3qCfxriIEQNxkjTntkP28iRD3YOd34Qx
   Q==;
X-CSE-ConnectionGUID: 6kIAPonZT+ehER2bacY09A==
X-CSE-MsgGUID: qtxKf0xbQBG/7tQNJO1Irg==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="45388097"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="45388097"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 04:00:10 -0700
X-CSE-ConnectionGUID: +puv9aV/T96CmqylHz8mCQ==
X-CSE-MsgGUID: R6tdX17yTEC6VyKioWEyMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="120665810"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 04:00:08 -0700
Date: Mon, 10 Mar 2025 13:00:05 +0200
From: Imre Deak <imre.deak@intel.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Lyude Paul <lyude@redhat.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/dp_mst: Fix locking when skipping CSN before
 topology probing
Message-ID: <Z87GNTziGPAl6UCv@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <20250307183152.3822170-1-imre.deak@intel.com>
 <CO6PR12MB5489FF5590A559FD1B48A34EFCD62@CO6PR12MB5489.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO6PR12MB5489FF5590A559FD1B48A34EFCD62@CO6PR12MB5489.namprd12.prod.outlook.com>

On Mon, Mar 10, 2025 at 08:59:51AM +0000, Lin, Wayne wrote:
> 
> > -----Original Message-----
> > From: Imre Deak <imre.deak@intel.com>
> > Sent: Saturday, March 8, 2025 2:32 AM
> > To: intel-gfx@lists.freedesktop.org; intel-xe@lists.freedesktop.org; dri-
> > devel@lists.freedesktop.org
> > Cc: Lin, Wayne <Wayne.Lin@amd.com>; Lyude Paul <lyude@redhat.com>;
> > stable@vger.kernel.org
> > Subject: [PATCH] drm/dp_mst: Fix locking when skipping CSN before topology
> > probing
> >
> > The handling of the MST Connection Status Notify message is skipped if the probing
> > of the topology is still pending. Acquiring the drm_dp_mst_topology_mgr::probe_lock
> > for this in
> > drm_dp_mst_handle_up_req() is problematic: the task/work this function is called
> > from is also responsible for handling MST down-request replies (in
> > drm_dp_mst_handle_down_rep()). Thus drm_dp_mst_link_probe_work() - holding
> > already probe_lock - could be blocked waiting for an MST down-request reply while
> > drm_dp_mst_handle_up_req() is waiting for probe_lock while processing a CSN
> > message. This leads to the probe work's down-request message timing out.
> >
> > A scenario similar to the above leading to a down-request timeout is handling a CSN
> > message in drm_dp_mst_handle_conn_stat(), holding the probe_lock and sending
> > down-request messages while a second CSN message sent by the sink
> > subsequently is handled by drm_dp_mst_handle_up_req().
> >
> > Fix the above by moving the logic to skip the CSN handling to
> > drm_dp_mst_process_up_req(). This function is called from a work (separate from
> > the task/work handling new up/down messages), already holding probe_lock. This
> > solves the above timeout issue, since handling of down-request replies won't be
> > blocked by probe_lock.
> >
> > Fixes: ddf983488c3e ("drm/dp_mst: Skip CSN if topology probing is not done yet")
> > Cc: Wayne Lin <Wayne.Lin@amd.com>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: stable@vger.kernel.org # v6.6+
> > Signed-off-by: Imre Deak <imre.deak@intel.com>
> > ---
> >  drivers/gpu/drm/display/drm_dp_mst_topology.c | 40 +++++++++++--------
> >  1 file changed, 24 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > index 8b68bb3fbffb0..3a1f1ffc7b552 100644
> > --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > @@ -4036,6 +4036,22 @@ static int drm_dp_mst_handle_down_rep(struct
> > drm_dp_mst_topology_mgr *mgr)
> >       return 0;
> >  }
> >
> > +static bool primary_mstb_probing_is_done(struct drm_dp_mst_topology_mgr
> > +*mgr) {
> > +     bool probing_done = false;
> > +
> > +     mutex_lock(&mgr->lock);
> 
> Thanks for catching this, Imre!
>
> Here I think using mgr->lock is not sufficient for determining probing
> is done or not by mst_primary->link_address_sent. Since it might still
> be probing the rest of the topology with mst_primary probed. Use
> probe_lock instead? Thanks!

mgr->lock is taken here to guard the mgr->mst_primary access.

probe_lock is also held, taken already by the caller in
drm_dp_mst_up_req_work().

> > +
> > +     if (mgr->mst_primary && drm_dp_mst_topology_try_get_mstb(mgr-> >mst_primary)) {
> > +             probing_done = mgr->mst_primary->link_address_sent;
> > +             drm_dp_mst_topology_put_mstb(mgr->mst_primary);
> > +     }
> > +
> > +     mutex_unlock(&mgr->lock);
> > +
> > +     return probing_done;
> > +}

