Return-Path: <stable+bounces-254404-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BWILAraFWpYdAcAu9opvQ
	(envelope-from <stable+bounces-254404-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:36:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCE35DAC2A
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA2F7301F81C
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 17:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6537C413246;
	Tue, 26 May 2026 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qo07aQdK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC340315F;
	Tue, 26 May 2026 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779816764; cv=none; b=oWJl/d/OMDlz63tU3MAWXZ/GsVGsMBCCezN1Dt9ogT80HGpAR3quFJm1rC6o5nijqHf9pjSqSZFL5H9+6Dd7Weit3rhdfaDCRnj3Ggwzyx39wCI5GKV3FERY6/6fRt+1gxCd6aXB5rEDzAqTtjdpEPavet8MBC8/h4IqrAIv5Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779816764; c=relaxed/simple;
	bh=ScQS4cRX8JUQbBQiczSdKeSb0hvHjCcEal3k3AbE/14=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r2YQzPyc1WED482O2Oo7AYP54LOXRT0EIQK1nvhvx3bjzsEGH9i2Vt0GSTozZLh2kVg0ljpN9OmQHb75x+AQosvEu3aEwwcm6t6fjan2vSOxmRhem31qSg+XOiIsPAlZyyHY226STpF5e7aRGz9lRJdvUJayAqRZXHhQl1i/wjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qo07aQdK; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779816763; x=1811352763;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=ScQS4cRX8JUQbBQiczSdKeSb0hvHjCcEal3k3AbE/14=;
  b=Qo07aQdKFH9oVAcikrdQKiNSYihVlFYw3VIiDhVFl+wmgBsxuGg4zh99
   dOGEdeOYTGS/sWWfEpK+TP574g37e2F4Z3qXGNp0NcRTG9szSxpJ8GZUT
   YKieQgiaXNJDqHURCVOu9MRJPW4vwOc5BQQbhY/kduIugFVRCP/2IOGJf
   Gd4N/REWou8zIt3eyPnvZkTe/Xpe0CW69b0kxrcMHGsk/5gfdgoLKfedJ
   SJs/npEYokpzKWdY/6lU53zvWLtNbjd1GW/Xq3ET3m4u68Q+MKQ0ZO22K
   0zldADgRdiZzoQFZqfMLTvIJqkP6xBhj2SvR582uNVf3OMl6r+LU1xxCX
   Q==;
X-CSE-ConnectionGUID: ff4+DEeSQ5CgAB/EgWcnaw==
X-CSE-MsgGUID: N1NcByiCTFOrE+lxsefG1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="91330772"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="91330772"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 10:32:43 -0700
X-CSE-ConnectionGUID: GUKWlQUTQSq9BqQvvS+l5w==
X-CSE-MsgGUID: KDpelx+jTBi5RF8cvYTULg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="265597089"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.137])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 10:32:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com, 
 ZhaoJinming <zhaojinming@uniontech.com>
Cc: hansg@kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260521130848.2860219-1-zhaojinming@uniontech.com>
References: <20260521130848.2860219-1-zhaojinming@uniontech.com>
Subject: Re: [PATCH v4 1/2] platform/x86/intel/tpmi: use cleanup helpers in
 mem_write()
Message-Id: <177981675549.9008.10282407971755340460.b4-ty@linux.intel.com>
Date: Tue, 26 May 2026 20:32:35 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-254404-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: 6FCE35DAC2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 21:08:47 +0800, ZhaoJinming wrote:

> In mem_write(), the temporary array returned by
> parse_int_array_user() must be released on all exit paths.
> Convert the array variable to use cleanup.h scope-based
> cleanup so it is freed automatically on return.
> 
> This also moves the array declaration next to
> parse_int_array_user() as required by cleanup.h usage
> guidelines.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/x86/intel/tpmi: use cleanup helpers in mem_write()
      commit: 6b2f633dbf134e5a9db44dc45c494ba829a7686e
[2/2] platform/x86/intel/tpmi: convert mutex in mem_write() to guard
      (no commit info)

--
 i.


