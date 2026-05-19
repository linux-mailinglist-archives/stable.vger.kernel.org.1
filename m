Return-Path: <stable+bounces-249616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLKYLuB4DGoSiQUAu9opvQ
	(envelope-from <stable+bounces-249616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:51:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52257580E8C
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3941B3054F80
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A2D4779BE;
	Tue, 19 May 2026 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJylZw4Y"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89FB3546CE;
	Tue, 19 May 2026 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201920; cv=none; b=U1Th6L6BIiScrp3/ONBQj15Z9iwJb5RpoQKAN65BM3Ts+7KEtGKjuAUjF4iqRxdIt/5oxzTLDohOe5mmh6p63c8pe+Hd1PYS2bZ6MUTWyD8yH9OSOPrevs5igcRBhrDq8fyVoYW1G2xqAMaPXz5X0ofipX/KCH0B5bym+TxwfSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201920; c=relaxed/simple;
	bh=T37qacNz+ymQVtQNEh78/FoIeDQk2pB4JtWq3F+JKbg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NpSklBZcW6gV8ii7OpQYMs9pw/1GQ2g75WE34ESi6sNHxtGKkEaADsaNJ77YSV5EcL5Hnc28/fjVJnFDN5M9nj8mCd0x+te+RiHcSikkCh0YiaNmzaEgSasKCx/gZdnOhjmMZCy+6/mz4PLPBAWtn9CvBCmOk6UH7hYBf3qhs48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJylZw4Y; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779201919; x=1810737919;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=T37qacNz+ymQVtQNEh78/FoIeDQk2pB4JtWq3F+JKbg=;
  b=ZJylZw4YfQTqCYnJSRbZMSDrT/6Rb6q+dQQUkEH7OLEAmuO6z2iq8f+n
   lFaJkzx6xOBV/0gOJAgopz3Pdczm+fahQt6zy7sssh7XlOilp64aDDRBI
   FCdJEQko89v8WSw2hS9w6Ng+HWCqCIh/lZUHLXrf3wOSk4XKZ4a9oTB+N
   yMoeejCfrX6zcM4cpxc5kPQSliUyMjC9352lA8Gh7f5+siJsyRxYyAjJM
   N6zDQMGXYkRbavhhJgQGp6IebbMa9PYxJPL3xGX0iVNMyWUl+uFF/DYKz
   SJkFy9cGA5/biXBM+o0dJ7pk4wg0XIJtu6Rv7CXfiIfWzKMLbmm6/Q9Xs
   Q==;
X-CSE-ConnectionGUID: BrcN3LSASz28QgTouW7JrA==
X-CSE-MsgGUID: Ug9etxGxSfe156MRJIypMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="91187483"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="91187483"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 07:45:16 -0700
X-CSE-ConnectionGUID: 9zH5MsuWQnm4iDn0DcCQcw==
X-CSE-MsgGUID: 9oghyOxmTVigtF+4lHsUmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="233421145"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 07:45:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?utf-8?q?=D0=9A=D0=BE=D0=BD=D0=B5=D0=BD=D0=BA=D0=BE_=D0=90=D0=BD=D0=B4=D1=80=D0=B5=D0=B9_=D0=92=D0=B8=D0=BA=D1=82=D0=BE=D1=80=D0=BE=D0=B2=D0=B8=D1=87?= <admin@aquinas.su>
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
 platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <T3DTKbKwQzOgk_0eUG-kMg@aquinas.su>
References: <T3DTKbKwQzOgk_0eUG-kMg@aquinas.su>
Subject: =?utf-8?q?Re=3A_=5BPATCH=5D_fix_support_for_thermal_profile_Omen?=
 =?utf-8?q?_16-=D1=810xxx_laptpops?=
Message-Id: <177920190913.22546.17882288615469828945.b4-ty@linux.intel.com>
Date: Tue, 19 May 2026 17:45:09 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249616-lists,stable=lfdr.de];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,linux.intel.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 52257580E8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 28 Apr 2026 15:38:25 +0700, Коненко Андрей Викторович wrote:

> The HP Omen 16-c0xxx (board ID: 8902) has the same WMI interface as
> other Victus S boards, but requires additional quirks for correctly
> switching thermal profile.
> 
> Add the DMI board name to victus_s_thermal_profile_boards[] table and map it
> to the omen_v1_legacy_thermal_params quirk.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] fix support for thermal profile Omen 16-с0xxx laptpops
      commit: 00c9753435e8a800761feeeea029a83c4c4847c4

--
 i.


