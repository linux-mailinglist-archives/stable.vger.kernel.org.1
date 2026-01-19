Return-Path: <stable+bounces-210367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2A1D3AE76
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 16:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70D0A3029553
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 15:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313A538736B;
	Mon, 19 Jan 2026 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MSV8jNPF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC76037F74E
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768835386; cv=none; b=XYWKbpo8Ei1j1kz24EAEkA88xOePQbLTIBFwZPytxaJK67LuRxZEpQVJXv+yFuHa9TEGeQsIqwVSNTpxZBxAOJ0StHpxPdOFgIQfHA4hDlMlaZ19HSYhbz0ktXa+NWr7EzMo8bEsRMi2yxgYFOL2ZBHE0m+zX2v5djkb438oLUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768835386; c=relaxed/simple;
	bh=Q2N42fg4ImBjgiXXBeBlf0z5loLMhudAfvLVUNFNSFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VzBuMketxfgOT95LHltC7RfoaedKfP27wG4lYC830UiQoUTrHwFZFFT/VNAq02i8tTCxG7vCcCX1xoW9QXUAtZpCXn50uLdOQkgbg944wFi4wkMW9YbbjrjfD4is6bZ43Nv0O34pila/nTEhIuBj5zxQpfCeEwaXAOUTAsyfHgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MSV8jNPF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768835384; x=1800371384;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q2N42fg4ImBjgiXXBeBlf0z5loLMhudAfvLVUNFNSFA=;
  b=MSV8jNPFa06+jbsyzwxBzaU/qoiwhOdXTb4aDUzeHxcAfMgENA+RAxUe
   daJSnV5rD3OzvuHUXSY7GpHdzl//t1dF5LUJc2EuCzzviRaGZMCJlS+1s
   RiV1K6iA74AYGN9hV62ePhW6cYdxtaDXohg0DjcHPI+xDaprj2TIl5jFg
   GhOqrdKgidiDVeZJDCFKsc8ru77Mua+XdlP3Hd6G+bbM2LQBybuHkk+gl
   RxdRhdYf6lXcpQj3AjufbRC3nuMWDXFU/hec3bLqp1FZfyDt3UIDMDZTn
   P92aBR5LIVSdr7b2XE5ZfmI5xsKCkMUtTLNvTJ8BLxE+6A0y52qOGL5oS
   A==;
X-CSE-ConnectionGUID: /xQvPw0aS3Sf+N3X53F2jA==
X-CSE-MsgGUID: hV4O0KpVSe+ICLhr7TH09A==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="73676046"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="73676046"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 07:09:44 -0800
X-CSE-ConnectionGUID: 4jnATGR3QkWYFcs4qy22Fg==
X-CSE-MsgGUID: 4UyngVnkSh+FG3AmTxDqWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="236562101"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO [10.245.244.99]) ([10.245.244.99])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 07:09:30 -0800
Message-ID: <8932c16e-ab31-493f-bc1a-c540f0ae5d6f@intel.com>
Date: Mon, 19 Jan 2026 15:09:26 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/xe/uapi: disallow bind queue sharing
To: "Mrozek, Michal" <michal.mrozek@intel.com>,
 "Zhang, Carl" <carl.zhang@intel.com>,
 "Brost, Matthew" <matthew.brost@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Souza, Jose" <jose.souza@intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20251120132727.575986-4-matthew.auld@intel.com>
 <20251120132727.575986-5-matthew.auld@intel.com>
 <fh6dgogrt3ibrod7qkguejy4bj3cmvlbnxksmedhvfx3ejglk2@nu3h6doh7sdx>
 <cc27ae58-b579-4332-9653-c62b38f32add@intel.com>
 <aURm1LgtNPYNxRCP@lstrano-desk.jf.intel.com>
 <PH0PR11MB55798387B824D4101E19545E87A9A@PH0PR11MB5579.namprd11.prod.outlook.com>
 <598d3899-5942-485b-8e76-61bcbdfa5cbe@intel.com>
 <DS7PR11MB6271DDAE76295D9280AB5CD7E788A@DS7PR11MB6271.namprd11.prod.outlook.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <DS7PR11MB6271DDAE76295D9280AB5CD7E788A@DS7PR11MB6271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/01/2026 14:14, Mrozek, Michal wrote:
>>> Michal, ping on this from compute POV?
> 
> Compute is not using bind queues.
> PR is ok from compute perspective, even if we started to use those queues we would create a single queue per VM.
> 
> Acked-by: Michal Mrozek <michal.mrozek@intel.com>

Thanks.


