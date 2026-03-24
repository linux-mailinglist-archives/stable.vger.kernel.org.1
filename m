Return-Path: <stable+bounces-230114-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAvgCRlywmmncwQAu9opvQ
	(envelope-from <stable+bounces-230114-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:14:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C0F3071A7
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8B3B306D114
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0788A3E5578;
	Tue, 24 Mar 2026 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hW/muoDz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9321D241665;
	Tue, 24 Mar 2026 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774350092; cv=none; b=p2RnH7KGfHaExvzYI1Y6iSZnaJbUVt1L44s8/g27XPQj3fZqPlgjhASWVl3znSfCioi7SCTP3Igt+URE9RaGymGKLNUsp2mWiqedniwdzEkO3Qa4W93tYbd2ubAj5yz6fyBn2qq1iZIMZRpQ1PB4IofbdsSQFxsWAq8vHDtApPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774350092; c=relaxed/simple;
	bh=81Qkjpc6IbC54ykBywCu93u5JWnbfbosDGHSWk5Tyns=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kMtc80DYo7Lvc9kUje3OjLH8rkEsWha48LGnKWf41zwLRDFZ5qrhgVJYAcO5/wBDgxLpLdhwx4WQNFS91UNZ2j3Zr4ZnYEN4ZtP8+NWMKK4UMkwzA1V2D2o6tokjdl8WsBIvE9zz3fmQZfa/dzood9wy4PCHCdEcfvPO4LC6D9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hW/muoDz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774350092; x=1805886092;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=81Qkjpc6IbC54ykBywCu93u5JWnbfbosDGHSWk5Tyns=;
  b=hW/muoDzBJ23rXdlwzbFKAvygu+uK5DTw8J41pQ77xFr8pLJ4HMxR7oN
   ExZJHDNeCPQc07o3xvkENnHd4lrhminwaiz827GR4UfZJUnMs3TJOvIct
   y+98TVXllJMg2nexUcand98JIORSat+GbUjEgfC4R212v+ZEJwKbHwBxz
   RUzezeylt8GWVSnsiGo+Vh3eKNOHwrgwWTUjXsOfVdHtwYCh2MkNDkVMO
   RbTKgi7osGP1PsbBvEfNiTqQgoQwig3o2WP1zgZ+RegDiTgg/1YAE1S+k
   JZyH23EgeVQPlw1ERKzY+VyyBRb8wNDJMuxxRrS/PknH6x+H2yG0Dsbln
   w==;
X-CSE-ConnectionGUID: cuVed4tsQd2fZSkQHCbGOA==
X-CSE-MsgGUID: fpgn7KHUS+W5nZ1wS2iMfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75247062"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75247062"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 04:01:31 -0700
X-CSE-ConnectionGUID: kM1yd7dcS7a+wY8KyNxruQ==
X-CSE-MsgGUID: 5SgNt8dXRpCPO15kMGZP/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="228799999"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 04:01:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hansg@kernel.org, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260323153635.3263828-1-srinivas.pandruvada@linux.intel.com>
References: <20260323153635.3263828-1-srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2] platform/x86: ISST: Correct locked bit width
Message-Id: <177435008376.6571.2449558027467443175.b4-ty@linux.intel.com>
Date: Tue, 24 Mar 2026 13:01:23 +0200
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230114-lists,stable=lfdr.de];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 31C0F3071A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 08:36:35 -0700, Srinivas Pandruvada wrote:

> SST-PP locked bit width is set to three bits. It should be only one bit.
> Use SST_PP_LOCK_WIDTH define instead of SST_PP_LEVEL_WIDTH.
> 
> 


Thank you for your contribution, it has been applied to my local
fixes branch. Note it will show up in the public
platform-drivers-x86/fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: ISST: Correct locked bit width
      commit: fbddf68d7b4e1e6da7a78dd7fbd8ec376536584a

--
 i.


