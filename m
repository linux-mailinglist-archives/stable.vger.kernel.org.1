Return-Path: <stable+bounces-254405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIXgBNHeFWqCdgcAu9opvQ
	(envelope-from <stable+bounces-254405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:56:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6227E5DB052
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ED61311FFDF
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 17:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6C2413246;
	Tue, 26 May 2026 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bh0kBlis"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC5B3B776C;
	Tue, 26 May 2026 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779816787; cv=none; b=eL98GkOv6xEipzlPXGg+4HgKnzimXgEOBpWMxlUflnPrtQpEGldO0UDFP/qOwQsBXGfK7j+cP9ZPyGxkJEuukkK7zMV1YF6TPhzpQdlWO0XfWPsRRF8+VU0cTK9OT0Rj08O2rOhYWYyVnkzwWPPNORynyFZlWzwpAs31IAHBJxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779816787; c=relaxed/simple;
	bh=K1onBBGG3J1E/VPjui4zp9M63TY06SEnSzBajSl30Yg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AHzxuxp1Ds2f+D8esfLijHWsF8NaaXdoUhT3pk7SAdn+sqH4R2SE+mHWvYy+lxRPXTOrtYdB5qjYPl9gRL+UwO3zhT8fBJ2RscEHbiwzbOjGO5MGXyhT1dEVpqQ6oy7HR3YM1izK/zLw9McSa5pk7WNvY10Sbl44OEGXKRSwwZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bh0kBlis; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779816786; x=1811352786;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=K1onBBGG3J1E/VPjui4zp9M63TY06SEnSzBajSl30Yg=;
  b=bh0kBlisNc0cJRAYQm1CO78VVA9iT6bSKxlF5MA1JDdiSCgUm/pYZ6yQ
   YPgDxXyaC2sUq1P7ZUTS7/dFyvb6GqKGDfjhIp2xcaL/74Fwka48QmOsV
   Wvre8P4X/kEh0Ppf/ZlKhh7gba44u2p5YAARnexvc0Yj+QI2qqOlHZMzl
   DVs84or1w53MA89B2dNSZ6j65d+BNrSQllTkD4dEdk47XcGYYg2esAHfW
   uJR2tAgJ8gJQAuLCorDS+4lXDtGgpP5PPLa9KTnoyHkcK+eNBc+Gx35y3
   5Any85Kv+C/cHjfuXsnUNXcDWScG0E1p7uUWuQQrYQwMp70/JqH9+pqlI
   g==;
X-CSE-ConnectionGUID: KVeskmTjStCyGIFrzpbO/Q==
X-CSE-MsgGUID: qvVMciRhT+ycTegj0WrBDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80751323"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="80751323"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 10:33:06 -0700
X-CSE-ConnectionGUID: SwN76VVWSHOTFSXhN+oKEg==
X-CSE-MsgGUID: Bg4fpWDsSa6gKY2LSFOgqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="246954520"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.137])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 10:33:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hansg@kernel.org, Krishna Chomal <krishna.chomal108@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alberto_Esca=C3=B1o?= <alberto_e_88@yahoo.es>, 
 stable@vger.kernel.org
In-Reply-To: <20260525102226.56300-1-krishna.chomal108@gmail.com>
References: <20260525102226.56300-1-krishna.chomal108@gmail.com>
Subject: Re: [PATCH] platform/x86: hp-wmi: Add support for Omen 16-ap0xxx
 (8D26)
Message-Id: <177981677914.9008.16740260598924034528.b4-ty@linux.intel.com>
Date: Tue, 26 May 2026 20:32:59 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254405-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.es];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.intel.com:mid]
X-Rspamd-Queue-Id: 6227E5DB052
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 15:52:26 +0530, Krishna Chomal wrote:

> The HP Omen 16-ap0xxx (board ID: 8D26) has the same WMI interface as
> other Victus S boards, but requires quirks for correctly switching
> thermal profile.
> 
> Add the DMI board name to victus_s_thermal_profile_boards[] table and
> map it to omen_v1_legacy_thermal_params.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: hp-wmi: Add support for Omen 16-ap0xxx (8D26)
      commit: de648236278c7045c782b1d9dfb80539faf30fc9

--
 i.


