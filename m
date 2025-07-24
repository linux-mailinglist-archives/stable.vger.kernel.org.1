Return-Path: <stable+bounces-164596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F07FB1094D
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 13:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FE61C875A2
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 11:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D6B2777E2;
	Thu, 24 Jul 2025 11:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Lhi4KC0j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oJcOTe0r"
X-Original-To: stable@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6BA1339A4;
	Thu, 24 Jul 2025 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753356894; cv=none; b=WSl8LtaW9YuxnGJ3wC3qq8Kpnf7mVLuCm36FhiCPCx7g8SCE7ssTTV9NXJ/jPpeqNO6WxUfp7eBSnPsmcLwAnwxxly8XIijc1eYvX+1ZjvrCYQbQaYHykJHdbqoB6eeMkaae/r8RPby6V46FSJ7+cVCJcLNAR0CkoodueAW8ELE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753356894; c=relaxed/simple;
	bh=SoMhZ76vgVDSFxSBf5IMdj3LjxZmenzhbkKzcjKrPjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxtC+Mqegfb1VfDLiurve5wTxBDR2WHbUgiDXDWHlDJx6bNSMbth0JW1fUn6bMrkTZOd7/h1a7ZQ0oUWb2lqWEjGNtU5uaYzyW2+4MY7lixcFLeEutMzgoLzV+2vP+bMzhNxzUVqGiR8xwxsGWd1v46IcC7eF1lYXsG94ynMgvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Lhi4KC0j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oJcOTe0r; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 3EFF2130208F;
	Thu, 24 Jul 2025 07:34:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 24 Jul 2025 07:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753356890; x=1753364090; bh=ayZPjTbnqa
	GMIbyiNla0DcfzBuX0r5Ej8CoWt6fQIes=; b=Lhi4KC0jV5xluRUm3bB4L3qaNU
	vOo5/p9eXlVCqRsHi7pOaVZp+J5CgVYVZAa488ZVbJf/yQ4IpD9WWnztUooPNGdw
	MHdsJ7wWBvbMVI/lvJWdCn4EFmP0lHitMHBZr+CXC1MsgOl8dLetnTkoSBzfL1Gg
	vrYPl6IYJxoMromhpQLNMlEARyfV+Po9EyI1S4Y/UPLVl0CfDa9kBpPqFYkQ4aEe
	SNHu5sQ+cpK133mSdxh66I+wtgMLuTYEzPB1ee61LY/N151BPvmNlYpH2VL9AB6S
	Xii8nDOonqwxIlyWQn8GKUnDwDASXGN05ptZrYJqb5SeeiCcg9wcDz95Tpkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753356890; x=1753364090; bh=ayZPjTbnqaGMIbyiNla0DcfzBuX0r5Ej8Co
	Wt6fQIes=; b=oJcOTe0rddHdGy0Enco7O1vQm2Qa5J+HfVZoBqhLJ/XIo19uNPU
	GTItOr7WHfyrsrvUr0zJ1OjrDtDqgOnJ78uO/EsZgSbUd95A57gYOZix1X9yewQG
	PbNtUfX6UoYPokh+EGYJi7zPLeKG8WFPB4zMm2p6RwZfgCcV/1Dy6r8lMn1cYI9J
	3cXaCyhAHDvAj+rcD/4Rha1/+6wJTxaBYBooAhu9FSoI+SdqWKNWdrT4jtCVLs5/
	hp+c8Sr2/CODJWqzN2Sg5ednC+JBvIRPuj+ko5HTMJhm5uZu3PhXHvDTzPYyZ1up
	cRrTqs7KrXwNW3+31tcLCfEXN/YhTAC5Zeg==
X-ME-Sender: <xms:WBqCaBP2qsMkAA92ATxwMcYgrjgzSkE6JkcSglknOOJ6Zq3g6OlCbA>
    <xme:WBqCaBHu2EYcBG3hh7VSbE8PGLrbQwBRj8IX5eeNcaemg9EQORSUgz8uXmL6judlm
    cmTUqqCf3MvtA>
X-ME-Received: <xmr:WBqCaAuLXeT3NqKlh_vzdPi4qrKKcp-vX1D_8oYhfG_vzhnFS1LQc4sTpGTU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdektdehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvvedvle
    ejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtg
    homhdpnhgspghrtghpthhtohepfedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmrggtihgvjhdrfihivggtiihorhdqrhgvthhmrghnsehinhhtvghlrdgtohhmpdhrtg
    hpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepmhhinhhg
    ohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtg
    hpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgt
    phhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhphgrseiihihtoh
    hrrdgtohhmpdhrtghpthhtoheprhhitggrrhguohdrnhgvrhhiqdgtrghluggvrhhonhes
    lhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehtohhnhidrlhhutghksehinh
    htvghlrdgtohhm
X-ME-Proxy: <xmx:WRqCaOuWvZo97rBqo12hiVnjqFcJfYmT9jZihR7Fuc0jSTgo6Ypw0g>
    <xmx:WRqCaBEflHAII7P-tohTvuxl6k4evOFix52LYGP3HUW0SmCXLCemHA>
    <xmx:WRqCaBIS3zPB8RHHBIes3Th1MyhPtOxsuXZs-yDc1tAYBeqimgO4QQ>
    <xmx:WRqCaBaq9paiRHvwv4sgKjrXjxDn_ZKUsFUdzKCBnSWF7VsekJ3pUQ>
    <xmx:WhqCaPEMluCYz4aD5oAFgb0LZvnBBK48apnGq4UJD2QUd_fNzc2WOT96>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 07:34:48 -0400 (EDT)
Date: Thu, 24 Jul 2025 13:34:44 +0200
From: Greg KH <greg@kroah.com>
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Kyung Min Park <kyung.min.park@intel.com>, xin3.li@intel.com,
	maciej.wieczor-retman@intel.com,
	Farrah Chen <farrah.chen@intel.com>, stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3] x86: Clear feature bits disabled at
 compile-time
Message-ID: <2025072440-prepaid-resilient-9603@gregkh>
References: <20250724104539.2416468-1-maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724104539.2416468-1-maciej.wieczor-retman@intel.com>

Your reply-to is messed up :(

On Thu, Jul 24, 2025 at 12:45:35PM +0200, Maciej Wieczor-Retman wrote:
> If some config options are disabled during compile time, they still are
> enumerated in macros that use the x86_capability bitmask - cpu_has() or
> this_cpu_has().
> 
> The features are also visible in /proc/cpuinfo even though they are not
> enabled - which is contrary to what the documentation states about the
> file. Examples of such feature flags are lam, fred, sgx, ibrs_enhanced,
> split_lock_detect, user_shstk, avx_vnni and enqcmd.
> 
> Add a DISABLED_MASK_INITIALIZER macro that creates an initializer list
> filled with DISABLED_MASKx bitmasks.
> 
> Initialize the cpu_caps_cleared array with the autogenerated disabled
> bitmask.
> 
> Fixes: ea4e3bef4c94 ("Documentation/x86: Add documentation for /proc/cpuinfo feature flags")
> Reported-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Cc: <stable@vger.kernel.org>
> ---
> Resend:
> - Fix macro name to match with the patch message.

That's a v4, not a RESEND.

Doesn't Intel have a "Here is how to submit a patch to the kernel"
training program you have to go through?

confused,

greg k-h

