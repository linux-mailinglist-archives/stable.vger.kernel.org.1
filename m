Return-Path: <stable+bounces-146439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79C9AC4FFB
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 15:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759C73A8D35
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 13:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E691A27467B;
	Tue, 27 May 2025 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGXSlPRN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00A02749C2
	for <stable@vger.kernel.org>; Tue, 27 May 2025 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353008; cv=none; b=TD/21toKibvblPMs6w8fYbZVXY70hxIwhJai/EVh1yJFIABjajyS9HN0a6DsYTY3wLioMT48532KZ2D+D3TZgpRLZFS+7ZDbNCd9Uik7tJmQFDZQh3xEPIj5Pi7nAz+OcTaZDNVuHPC0WhGYTKUO9Z0t0Qm/INbeqtoF2cUk79Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353008; c=relaxed/simple;
	bh=wnDZNP/VqISqFUhh4aYXJg4mVSrtJqKmnlOOSXNb5aM=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=eTQCW2XwXakyvVhy4cw9CXr+vG+D22UU9jStBpwtXDiUYRDv8UIy6z/FV3hBNVeZb7xujR69MrKnK15ThkYpcyTGdO4XkVLUspGvCUNPCFGohfMiFZ75CmUjVu6zRNLHtz21xOTzhYqmjwz6xw3rDovAJZNxpSESmNWUj/HcjXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGXSlPRN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748353007; x=1779889007;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:from:cc:to:date:message-id;
  bh=wnDZNP/VqISqFUhh4aYXJg4mVSrtJqKmnlOOSXNb5aM=;
  b=HGXSlPRNBGEEpkQODMqhXpaoyXB1LaT775Bxhn7SxXcek3mZmdcRNvdT
   uA+9pMWLMyhh9oz6/U4UeuNZPEPGL99ANfcWWeBPq44xnPoUgK+Q7kW5L
   FQsKmCzjwdI6HcEeRJHNkB4MmejN30vUZKRLhpbT9+CbJLoAHqum1Hzt8
   R0NbgBmhuw/cOOC2KW5GBX8rtzDvgqsFngmK3mgB7YU0LTaCQGrB4HuaZ
   APFjYHRxPdJZ1ha8xZuhgOn1A9jQ63ItpeWRTC4fSOQxeWgBmpw0hMwk4
   PVfoYxOfG4aTbKJwFposOIMJFWbEynBuIZ/Of6QjPkJlchFwp1+zIou86
   g==;
X-CSE-ConnectionGUID: F7BTP69kQleeC9LThonFlw==
X-CSE-MsgGUID: aJuvV1ybTgmbBhdJ59K5tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="61003232"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; 
   d="scan'208";a="61003232"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 06:36:45 -0700
X-CSE-ConnectionGUID: iguYMnMcQk62wUY+qxStqw==
X-CSE-MsgGUID: umkBNxMtQCqKq28iOgth1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; 
   d="scan'208";a="148084591"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.74])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 06:36:43 -0700
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250522064127.24293-1-joonas.lahtinen@linux.intel.com>
References: <20250522064127.24293-1-joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH] Revert "drm/i915/gem: Allow EXEC_CAPTURE on recoverable contexts on DG1"
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: stable@vger.kernel.org, Ville =?utf-8?b?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>, Matthew Auld <matthew.auld@intel.com>, Thomas =?utf-8?q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>
To: Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>
Date: Tue, 27 May 2025 16:36:39 +0300
Message-ID: <174835299995.49751.5169215904306434016@jlahtine-mobl>
User-Agent: alot/0.12.dev7+g16b50e5f

Applied this as there were no further objections now that the userspace
fix is merged.

Thanks for the reviews.

Regards, Joonas

