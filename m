Return-Path: <stable+bounces-230199-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK0LNk3EwmlflgQAu9opvQ
	(envelope-from <stable+bounces-230199-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 18:05:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BD7319A64
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 18:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62FD6304D9F2
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 16:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0833D1CAA;
	Tue, 24 Mar 2026 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aNwwjNGI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CE23E0235
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370987; cv=none; b=puqJpRg6WO4bTwXLL2IE/jOGlhY1AhvQCj63JuyRKmsAvJSMsmjUvYG3ljor0gyyQk4EGzodSEFX4E1muA2lKBqhx6FVEjc3IJW3f4p1Uq4sYMfYWJcKXQIkFyOoDiaJq0h4MTgFWGH2z/4R60giVvCbIL6gMVTcGb0bedNoprE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370987; c=relaxed/simple;
	bh=41Qf05O8U1obBYOSOWvATaYc2cpdkTfjUa6W0IdTaRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pWybb4HnON2llA4JHzpyj+PDc8sJIzB5qVI8HUvRVTLT7G2ciaYH1maXFGXTj3WEMWavc7dOZ50R2aORnuKRpA+joQ4Zyhrwhg+iYGLxQ8eQsf+g3zAOAlO5BqGGNggMViPQUHbeMjeircqmXTCM1o7P0iOBl9AnMp8rZK4rJI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aNwwjNGI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774370986; x=1805906986;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=41Qf05O8U1obBYOSOWvATaYc2cpdkTfjUa6W0IdTaRs=;
  b=aNwwjNGI9vnJmHMOTZJPirjxEgT72mn8/wQSqncWKMcN7Y/xAjmeth+t
   EkQ1PHr6J04tPPm1BluS5FGUvZYgbMP7p0l8w9XKDBd9w7VqGi7xcd/z3
   oyW3wNnObUwoDROhuZHePZzyogMic0RSxrDYfCPwUsuUsXch65N7kZOov
   QPu1p92zF1sc58oUZ3OO/KQAhryU1vKpeWDxhx8se4SOSMjKP0lk4xZJI
   qfKlk9H5Q2Vb50xhhzcOK69XTNL7cCMPbi9N1QIfEbFvkU9xG23dVmepO
   3uXSn3YhcP6RK+nI3UDWZYqzuhl0KVTo85/4sT4lJHdxpIw7zlTBl1m21
   Q==;
X-CSE-ConnectionGUID: iAWWNQlXTkuwS1zj1pXO6A==
X-CSE-MsgGUID: Yr6ErXS7RZW1ksn/+thP+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="85707722"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="85707722"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 09:49:46 -0700
X-CSE-ConnectionGUID: 2l1lXzMjR9q3OcXuyNsh7g==
X-CSE-MsgGUID: y8c3fbXkRPeZsszVwV/YOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221059748"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.110.6]) ([10.125.110.6])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 09:49:44 -0700
Message-ID: <551037c4-665e-4701-9689-a75bdabe4211@intel.com>
Date: Tue, 24 Mar 2026 09:49:43 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 378/378] cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig
 tristate mismatch
To: Keith Busch <kbusch@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <20260317163006.959177102@linuxfoundation.org>
 <20260317163020.886316423@linuxfoundation.org> <acK_mxmLlvD5vQog@kbusch-mbp>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <acK_mxmLlvD5vQog@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-230199-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: D7BD7319A64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/24/26 9:45 AM, Keith Busch wrote:
> On Tue, Mar 17, 2026 at 05:35:35PM +0100, Greg Kroah-Hartman wrote:
>> 6.19-stable review patch.  If anyone has any objections, please let me know.
> 
> No objection, but a little confused how this got to stable before
> landing in Linus' tree. Does stable pull directly from downstream
> subsystems now?
> 
> Speaking of upstream, will the CXL maintainers be submitting a pull
> request for the staged fixes soon? I'm just getting new bug reports from
> people testing 7.0-rc, so wanted to check in on that.

I can send it today. Looks like I got enough days in linux-next soaking for the PR.

