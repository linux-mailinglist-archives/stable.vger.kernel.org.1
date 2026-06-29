Return-Path: <stable+bounces-269793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iCJGGP2VQmq3+AkAu9opvQ
	(envelope-from <stable+bounces-269793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 17:57:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAC46DD043
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 17:57:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Rk5K7dhb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269793-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269793-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 273A73001CC4
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 15:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15B03D5235;
	Mon, 29 Jun 2026 15:40:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C963E3B42DC;
	Mon, 29 Jun 2026 15:40:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747614; cv=none; b=BOZvl31Itnda82YSiWhfu+gKAsU2XvtsOWtMyvFHSHQyWjNA91nd3liEtYewF9/yOYBN1GZ0yakyY+o6B1ljiO44l4i7RPGiaqOLeqySzvH3KVpnoYnF0loZ03gfNt+xJ6pT8/pYU3gNmc1MCiOx7hq9WKhVZQs7UNegSJZdens=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747614; c=relaxed/simple;
	bh=mNEmfpypvUNZ+gR4xPR0xDDTBTDrRcJEbt3dRM+/o1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLh5egs1iftnfVV3ajSu1YOzezMDVvcl9dtcVfjarXReRW3rf54rYYQQvN+j+z0eLVPU5f62KIOUY9JxqLbP3flqkmN5hGIF6vO4embn04loNwzHr1ruAOwFXVLhNIFYUFO+4XhYuejBtCgS9XQ0MikhbVHlbpsihGImGaZy56k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rk5K7dhb; arc=none smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782747612; x=1814283612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mNEmfpypvUNZ+gR4xPR0xDDTBTDrRcJEbt3dRM+/o1M=;
  b=Rk5K7dhb77u55s6MUkk/MYszdBbNQ5wrILqdidyuV1tMhzNxvmwuSZoi
   UnHwkUZ9HvCzLqlAhOBg/QfB9usgBPvXzumy7Ade6nZXz/a7tGxrM72ey
   FYmCm1zuAhbaeV3HjSii0RYoHpQ193b2bmdCKHZNomfW7dVbE7c6yhv7R
   LvpFTLiwG0yQFiWK0cNpQ/MczKjO+AQf/7xPc3IiGr1sF9asOEH87q4qv
   YFetEL4AB8gN1hGiQ1bbBQsTQCsFsmAKUrDo225zv8lZXtW+ud4zM+w2Q
   Mib5VpIqOBaevKZkiozEV9iiYHvizi+Y0sMuUCqiH64aT5o4Aa9lKVPBr
   g==;
X-CSE-ConnectionGUID: 6uIGsCPRTmOLDeRlTCbQ4A==
X-CSE-MsgGUID: b0T72LNnT0uXc2JZkJVl/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="108986417"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="108986417"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 08:40:11 -0700
X-CSE-ConnectionGUID: dSYOS7uKT4WN/nRMbsXWyQ==
X-CSE-MsgGUID: ZeBTgg84Q1Wb/e1V1Tutvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="256909319"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 08:40:11 -0700
Date: Mon, 29 Jun 2026 08:40:09 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Alexander Martyniuk <alexevgmart@gmail.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Airlie <airlied@redhat.com>, Sasha Levin <sashal@kernel.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 5.10/5.15/6.1/6.6/6.12] agp/amd64: Fix broken error
 propagation in agp_amd64_probe()
Message-ID: <akKR2bNYFokN43Sk@tassilo>
References: <20260629102124.252403-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629102124.252403-1-alexevgmart@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexevgmart@gmail.com,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:airlied@redhat.com,m:sashal@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:25181214217@stu.xidian.edu.cn,m:lukas@wunner.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ak@linux.intel.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269793-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ak@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.intel.com:from_mime,vger.kernel.org:from_smtp,intel.com:dkim,tassilo:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BAC46DD043

On Mon, Jun 29, 2026 at 01:21:23PM +0300, Alexander Martyniuk wrote:
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> 
> commit b08472db93b1ccff84a7adec5779d47f0e9d3a30 upstream.
> 
> A NULL pointer dereference was observed in the AMD64 AGP driver when
> running in a virtualized environment (e.g. qemu/kvm) without a physical
> AMD northbridge. The crash occurs in amd64_fetch_size() when attempting
> to dereference the pointer returned by node_to_amd_nb(0).

What is special about this virtual environment? Nobody else 
seems to have seen that in 20+ years.

Or maybe the Fixes tag is not quite correct and something else more
recent has caused it.


-Andi


