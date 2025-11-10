Return-Path: <stable+bounces-192929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BA037C4634B
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43551347D64
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 11:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56604221542;
	Mon, 10 Nov 2025 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kuC9k1D+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1132E173B
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773705; cv=none; b=cWtuoqJgLvpJfwva+q2Maoh6M+IVSo/M9WKEx79LUglISSsgAyW7gsynt3gV6suQAxU20s53QDDih0CBfZlEfwZLPKA5JP+N54ccHXaBYj+l7Mp1xL15eyt2DbmgLK6/AyGSAw4E9rlpca1wYb4MVkbsGpHYzMQ1ZeS6hNdGvEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773705; c=relaxed/simple;
	bh=t6ccO4ifrE6sfbNDvqxCrclmAc6f6e8lVI75X1vdeeg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MZoFRSfpd3kUUEVO5NK9SfBE2N/t2Jqk3eqbaLp36gb0wYAmZ+FUvQvhUg3DCEZn+C0BhQT7wtDFg/Csi8SJle9u7TNEebLqq4Tr+GTjdCTzHWrD3eNH2X7L4DQxF4uuhFhLTDw05ecO79/nHIvRetyPysgkjwjjUhr31mK7pVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kuC9k1D+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762773704; x=1794309704;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=t6ccO4ifrE6sfbNDvqxCrclmAc6f6e8lVI75X1vdeeg=;
  b=kuC9k1D+rKsm0JmMo2cV1nm5aXvFXnBqgGHScTK9aZ1Ci1wq82P6sioG
   0hs2TWDGH1azuHyfxbcTTZWp1pCDZkzAqkqI4WHL++26jCD3f3dgMQbPz
   aEkzwZbspHrT8uIcoA5Tgn4CaKT4GkRq6R+J65nErSpI7wjsCehzKWRkx
   0fPNNjFEW7v6M/DzGr0X2nW37ldJB/ZH74JG/fZnfz7OP/az3pGWdmeu1
   8XaydRX2wGildTpxRj2eIL//qporXrA62aLGlMhP+uJ74YusI+F1E56PS
   uouCnKM/LhJzJilKcxuJ5mz1oA++CFcfCPK7qZ+mzaqxqcR3j3hVzZEtv
   g==;
X-CSE-ConnectionGUID: EQVBuEaMQfuxENpieXPKJw==
X-CSE-MsgGUID: BcLHrOcGRyGGt3HiDHWZTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="67428018"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="67428018"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:21:43 -0800
X-CSE-ConnectionGUID: zCOyesVARdS0TuiuZSFFCw==
X-CSE-MsgGUID: EAyeI7y+TnKJnekPRvyBmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="189368973"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.202])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:21:41 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: "Hogander, Jouni" <jouni.hogander@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/i915/psr: fix pipe to vblank conversion
In-Reply-To: <df54e434d95553c02fe9e7a8607cbc25652ef107.camel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20251106200000.1455164-1-jani.nikula@intel.com>
 <df54e434d95553c02fe9e7a8607cbc25652ef107.camel@intel.com>
Date: Mon, 10 Nov 2025 13:21:38 +0200
Message-ID: <8e51dd88918a9986049d4cbc29b219ab82bb1b9b@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 07 Nov 2025, "Hogander, Jouni" <jouni.hogander@intel.com> wrote:
> On Thu, 2025-11-06 at 22:00 +0200, Jani Nikula wrote:
>> First, we can't assume pipe =3D=3D crtc index. If a pipe is fused off in
>> between, it no longer holds. intel_crtc_for_pipe() is the only proper
>> way to get from a pipe to the corresponding crtc.
>>=20
>> Second, drivers aren't supposed to access or index drm->vblank[]
>> directly. There's drm_crtc_vblank_crtc() for this.
>>=20
>> Use both functions to fix the pipe to vblank conversion.
>
> Reviewed-by: Jouni H=C3=B6gander <jouni.hogander@intel.com>

Thanks, pushed to din.

BR,
Jani.


--=20
Jani Nikula, Intel

