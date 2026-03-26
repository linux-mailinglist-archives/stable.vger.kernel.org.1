Return-Path: <stable+bounces-230521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P/SLpaIxWlc+wQAu9opvQ
	(envelope-from <stable+bounces-230521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 20:27:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F81933AE9F
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 20:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4BF6302768B
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 19:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B39234F48E;
	Thu, 26 Mar 2026 19:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brf6p5QZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB72F31ED80;
	Thu, 26 Mar 2026 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552735; cv=none; b=LQ7eb+ZVieSLE71NxVhA7wFeGJuNcA98jwTSJd9DsG8+Df5jmXiejrSYv8KBB8C+2y7IFJwdXn97Hxk1b8/kL6MRN8lrB5sw/zZk95TdtaqREYvFTrrLarFLYZFBlfp+w6wbkY5xbMGnLuwIqQCfYQbpxfUE+ukJX69DiwfKLEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552735; c=relaxed/simple;
	bh=PsrYfTmQrZHHnAcsRgaMikiSSJ3FgQWb6eTiJbFOmYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTOhcd/Qy1hM5GaPBZkQnOI9yleu/g1+jPGTpZodoZQiIp28XpVmUn5TVte1ypUaJAQYhx+Hzwmxr+zRQeiqfLY0lYh5jIfvDRtNHnS/8qcid1Jj3TwjbLEw0pFrc5zG6zTPnhwQ1/ZMQMNlDZ/mJOeqhNN4E2L7qdX8yO4H7hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brf6p5QZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774552734; x=1806088734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PsrYfTmQrZHHnAcsRgaMikiSSJ3FgQWb6eTiJbFOmYM=;
  b=brf6p5QZL9QaYGrLZzCkxclnyhwxUYJLFXqFGGgRzN7ON6i/qdsQEqMF
   qKTRX6fmGSYYsXtXSd4fA1e6lVXGfQOFu8fwza5bVgr6CGLF6TuRQXcib
   E+rzDPb1Wx6hhOfaHwtIVztr1lUwTq9GTChKC9t6ilYbIVWkf6DNjkfXk
   tejPxH8fM8QXRSiqAnxaaEwYr7wFZolVZSAFi+Zc9X99NumzTp4+r1kJm
   tnhYopXJAGTp8fHDS1xZz92hrCecbLnIJq5ZpknDUXKmwhx7TnNiU+5Cj
   PZlSE3AwPF/cKHnoSKNoyd3YO2omvFSomcqF2/IYUL9FyUC0Y71QVQKq5
   w==;
X-CSE-ConnectionGUID: mBRPdRrUST+sjNtpeD1FNw==
X-CSE-MsgGUID: p3dDX/PFR8eEUeq4Y+6VWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74806985"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="74806985"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 12:18:41 -0700
X-CSE-ConnectionGUID: 6GhBGAblRPe82ogoVeJO7A==
X-CSE-MsgGUID: nRp5t4b1SaK0TSm8RMcvbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="263005323"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 12:18:38 -0700
Date: Thu, 26 Mar 2026 21:18:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	=?iso-8859-1?Q?Jean-Fran=E7ois?= Lessard <jefflessard3@gmail.com>,
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: line-display: fix NULL dereference in
 linedisp_release
Message-ID: <acWGi1aMWrk05GLz@ashevche-desk.local>
References: <20260326171412.1109402-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326171412.1109402-1-lgs201920130244@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-m68k.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-230521-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 2F81933AE9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 01:14:12AM +0800, Guangshuo Li wrote:
> linedisp_release() currently retrieves the enclosing struct linedisp via
> to_linedisp(). That lookup depends on the attachment list, but the
> attachment may already have been removed before put_device() invokes the
> release callback. This can happen in linedisp_unregister(), and can also
> be reached from some linedisp_register() error paths.
> 
> In that case, to_linedisp() returns NULL and linedisp_release()
> dereferences it while freeing the display resources.
> 
> The struct device released here is the embedded linedisp->dev used by
> linedisp_register(), so retrieve the enclosing object directly with
> container_of() instead.

Makes sense to me. How did you find the issue?

Geert, do you agree with this change?

-- 
With Best Regards,
Andy Shevchenko



