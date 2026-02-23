Return-Path: <stable+bounces-217793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN1tEo2DnGlwIwQAu9opvQ
	(envelope-from <stable+bounces-217793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 17:42:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F9117A053
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 17:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55F5D316142B
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 16:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78291319851;
	Mon, 23 Feb 2026 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZhgy14c"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278FC30AD10;
	Mon, 23 Feb 2026 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864512; cv=none; b=bsZvct++faF8fEB2e1/BmTGPhuxa23rgd3CydrpqVpgAC7SBBmR5ymypcrxP0o/DN5iyEHpqdj3jGXytg/xqiqVpWK29jzD2DqDvPW1m/r8d/U3GyAbKmS2tmIDg2EM4b/9ntASPqAy5LuXDPpVKN5MNeKfvr7DZlsbbfSCjeC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864512; c=relaxed/simple;
	bh=VKycUi0vs/uiQYxECjLXw5ph+ljedd26PcRiXFfUueQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o/45JUd8zdy1bwDuUWn70sqS0VSkZQRhpROkpy/tW8vR1jvHPCIZMh3ynNMJDiG8NHvZoBBwg+evA5lcfpInoO175hdxIKn31wrEo8Y5zXZtd4ot6W6BYu1n0dipyYDA/vemDpzUprfUQFqei4M2Nq6iVJFt3DW0sNnG4xhHHw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZhgy14c; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771864510; x=1803400510;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=VKycUi0vs/uiQYxECjLXw5ph+ljedd26PcRiXFfUueQ=;
  b=iZhgy14c0ixlzs++/2xi/hG0JYgChSAfA962MWrEFDb1obzw5jdZODqW
   Sk/KDeYznULnb6ty9URui+6dt4powEkSZZb07hO+gyLdT1y1U1XGZ5QBC
   QnWdAJ4VsKJdHAFyLPkFhMnpw9+t2Rg10HvGgfseIkveQQsPkBH/lGwSI
   GOx+pnbtqhNHE9+kT1s1R759yD7/gTcf5a6FxLEybQfScJUhu+Q5PV5rw
   En/jO6oxc27o8T3uRo/c01UlzZfGiM87DDT/vksXwrVs+whi3EnND7pLK
   /G0bOB5v+1lu4JcfTGdzIfwJeldtN1vqBsm3XvTp0auHNgK6gmkJkapIe
   Q==;
X-CSE-ConnectionGUID: Gm1SheMVRZqOD5qPTU/4uA==
X-CSE-MsgGUID: mp6fJCa+QL+9tm+ZaPHdpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="84315864"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="84315864"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 08:35:09 -0800
X-CSE-ConnectionGUID: TWYZ6ektTeuPTthHdsk0yg==
X-CSE-MsgGUID: AzVBrIClQxiehjtK3ODysQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="220163333"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 08:35:07 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, Kurt Borja <kuurtb@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Olexa Bilaniuk <obilaniu@gmail.com>
In-Reply-To: <20260129-m18-gmode-v1-1-48be521487b9@gmail.com>
References: <20260129-m18-gmode-v1-1-48be521487b9@gmail.com>
Subject: Re: [PATCH] platform/x86: alienware-wmi-wmax: Add G-Mode support
 to m18 laptops
Message-Id: <177186450028.17917.9838253751296011583.b4-ty@linux.intel.com>
Date: Mon, 23 Feb 2026 18:35:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,dell.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-217793-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: B6F9117A053
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 12:19:24 -0500, Kurt Borja wrote:

> Alienware m18 laptops support G-Mode. Therefore, match them with
> G-Series quirks.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: alienware-wmi-wmax: Add G-Mode support to m18 laptops
      commit: bd5914caeb4b2de233992c31babccda88041b035

--
 i.


