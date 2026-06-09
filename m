Return-Path: <stable+bounces-262296-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tp8pGFgkKGrn+wIAu9opvQ
	(envelope-from <stable+bounces-262296-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 16:34:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E345466127C
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 16:33:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=WGn9s51g;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262296-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262296-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A7D9306FF21
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 14:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BA8340281;
	Tue,  9 Jun 2026 14:24:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FEA2E040E;
	Tue,  9 Jun 2026 14:24:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015090; cv=none; b=QQuymCVRKey4A6aG/yU7eXg0vXp6+ojvoSM/jzGvtokcN55p7QCqfpBtHpleb6R44FZM1F0te9rjZLaR4UfxCsXIOqvUelKn2yc391EOICfrZ3MV7i8yXHgQOSCarYQhpugpU8zJPsfoJ/ilgU04EVMmuEatY4XzAKfhaRUrp1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015090; c=relaxed/simple;
	bh=gnwR7wZ+5RCRuZrbsQitVhLW18mHrGZ8vhJM5UJcYH0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jnLbnExd7bvPvkmtolSu2lW7gfHpqAntxnHQw1yeyaxgkvgK+Hl499OnEn+hfZZvTS8IndXlMtEBXzvoTAxyyiOqpGnzfBjocJ3zSFbLMJd+bfMkSFfM6eRJOf2sDMACozpm0ZuUiaV33xC+nSx56vAnCVf0x8CEQD9IK6pbXk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WGn9s51g; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781015090; x=1812551090;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=gnwR7wZ+5RCRuZrbsQitVhLW18mHrGZ8vhJM5UJcYH0=;
  b=WGn9s51g9XDZquYasW0rg6wNqlm1YEcQvTx0MaywefI3rgjM2Dd1j8nN
   xZUhIUB6XWL0t8TUQCiu/aXwo0+5OOA6ygcDamVvdmOhc2a3TP2txT3lt
   KY0Pj7c4SmAZ55j+0ng8NhxpFQxFcuamaX85RSAwmreiD27Z6/fuu7a99
   wTt2y3TOyGIkfPEJEG3keAFGShicy0HsS+hoKKw3XWM3kCajvByTgSC1r
   tmdjKXlrmvwzHN0awsi0WSI5sphdGn5OLdmrYqXc7NDcgZXdYSnFwNEVl
   TPpOvEruWRLaB5vIJpcuava7FYyizrDPF/kJLwLJHwy9/nbbqooGrAZWv
   A==;
X-CSE-ConnectionGUID: UarcAUP5TzKQqmtl+iElHA==
X-CSE-MsgGUID: C6i7iVICTZyM/+nN5lZ1Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81962198"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81962198"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:24:49 -0700
X-CSE-ConnectionGUID: WxGD4JxCRIy+DoWujlOmww==
X-CSE-MsgGUID: iTCD9epYTiqLtpYQn6bpkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245024799"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.81])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:24:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hansg@kernel.org, Krishna Chomal <krishna.chomal108@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ahmet_=C3=96zt=C3=BCrk?= <sivasli-ahmet@gmx.de>, 
 stable@vger.kernel.org
In-Reply-To: <20260608134255.36280-1-krishna.chomal108@gmail.com>
References: <20260608134255.36280-1-krishna.chomal108@gmail.com>
Subject: Re: [PATCH] platform/x86: hp-wmi: Add support for Omen 16-ap0xxx
 (8E35)
Message-Id: <178101508117.11417.5011316528727663268.b4-ty@b4>
Date: Tue, 09 Jun 2026 17:24:41 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hansg@kernel.org,m:krishna.chomal108@gmail.com,m:platform-driver-x86@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sivasli-ahmet@gmx.de,m:stable@vger.kernel.org,m:krishnachomal108@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-262296-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.intel.com:from_mime,vger.kernel.org:from_smtp,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E345466127C

On Mon, 08 Jun 2026 19:12:55 +0530, Krishna Chomal wrote:

> The HP Omen 16-ap0xxx (board ID: 8E35) has the same WMI interface as
> other Victus S boards, but requires quirks for correctly switching
> thermal profile.
> 
> Add the DMI board name to victus_s_thermal_profile_boards[] table and
> map it to omen_v1_legacy_thermal_params.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: hp-wmi: Add support for Omen 16-ap0xxx (8E35)
      commit: 56b7981c6f21670c0a1a62e6d2f9afb380e2596d

--
 i.


