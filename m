Return-Path: <stable+bounces-249609-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Fw2Hcl0DGqihwUAu9opvQ
	(envelope-from <stable+bounces-249609-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:33:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 711A25809C6
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4118F3028329
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3080E220F2D;
	Tue, 19 May 2026 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FATT0ro3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9204028DF;
	Tue, 19 May 2026 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200569; cv=none; b=V9TU+m/zDr5546ywqW7DNdmE1lXvsvMdH076wP65UB8gPMwdraAEe6C1M/VRT9Hk4CitzTWbd5lR3iTLyFknfqtFzJvsrOXwzcqvZIvEnCe1SQ2X2RyryVU+W49mXAIf86kke0LgE+tWQdaqfCxIDjxOwFkDnEetW7XzCSnnuzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200569; c=relaxed/simple;
	bh=ZDH2zy4OHwN7Nizpqx6y/X7j1gg7jwVXN+mCsXJeu08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3aCTPNUnC0OfAoT5nOMWgR4GyxgW/7zShRQ0btj9XdeEWsUnT8dmU1TvIW527zzIea1UarlXRpaQGx9kH+qHQlaGonTcmjOL+k7x/kwSSIWDyzTmT0mjE13vIghJVZKKgfIBBgxl8GzJ7w1DX9Ig9mEGmbNBn0+TEUpMMaRoX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FATT0ro3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779200567; x=1810736567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZDH2zy4OHwN7Nizpqx6y/X7j1gg7jwVXN+mCsXJeu08=;
  b=FATT0ro3i1/hOYLC8g9j12nyTXIiOQV09HzoMnqX72+AuWs+sfT+By7T
   XE354xKgS2s1B7HI4UyiJXgx2cKHUsRhGfXmN3wuBwYSNtdKa7Oa10483
   Hkr1G8xsQKiULaKRdqbJo+iCx5zmYFORTZhzDpDGcdm7TqQicpGMZ9gGB
   J/h+aHgkPdI4N2N9FKbnzHomdcb47lTbhjEf7TzL1kM4I/IQENkIwkoDI
   +yyBF9ogOHrnp2gbT4ARnQ+WQGuenssg/XrxwEsTmk8IEyPEWMPmqj0G9
   qkBpQ3baC0VXPTqL8GIVA+a0wSDbRdnx2WJgX+4OyGNEmEKhpGckpAtqN
   w==;
X-CSE-ConnectionGUID: 282jMXQXRcKc3n3Uwymuaw==
X-CSE-MsgGUID: g9qYPzCDTDyoQDPgV3mqOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="67607560"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="67607560"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 07:22:46 -0700
X-CSE-ConnectionGUID: kRxkeCNiRoKMTL03z5Ft5w==
X-CSE-MsgGUID: Qg9DSD8xTpGIeubzy1lHaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="243785157"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 19 May 2026 07:22:45 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id E4ED395; Tue, 19 May 2026 16:22:43 +0200 (CEST)
Date: Tue, 19 May 2026 17:22:32 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: typec: ucsi: Check if power role change
 actually happened before handling
Message-ID: <agxyKCo2YPnvZ2lf@kuha>
References: <20260519-ucsi-fix-2-v1-0-6f1239535187@qtmlabs.xyz>
 <20260519-ucsi-fix-2-v1-1-6f1239535187@qtmlabs.xyz>
 <agxwK43LRZytVxPK@kuha>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agxwK43LRZytVxPK@kuha>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249609-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:url,qtmlabs.xyz:email,intel.com:email,intel.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 711A25809C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 05:14:15PM +0300, Heikki Krogerus wrote:
> On Tue, May 19, 2026 at 06:41:39PM +0700, Myrrh Periwinkle wrote:
> > The CrOS EC may send a connector status change event with the power
> > direction changed flag set even if the power direction hasn't actually
> > changed after initiating a SET_PDR command internally [1]. In practice
> > this happens on every system suspend due to other changes performed by
> > the EC [2][3][4], causing suspend to fail.
> > 
> > Fix this by checking if the power role change actually happened before
> > handling it.
> > 
> > [1]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=1689;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
> > [2]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=3923;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
> > [3]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=5094;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
> > [4]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=2229;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 7616f006db07 ("usb: typec: ucsi: Update power_supply on power role change")
> > Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Hold on. Shouldn't this actually be fixed in that EC code?

thanks,

-- 
heikki

