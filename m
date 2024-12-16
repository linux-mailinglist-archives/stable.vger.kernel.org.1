Return-Path: <stable+bounces-104345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3939F317E
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 14:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 179817A0682
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 13:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299582054E6;
	Mon, 16 Dec 2024 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f0bF2xtb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E54C204C2C
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734355753; cv=none; b=h6D8pdkAE2Yz51q2Mmpl3nDd8d+Wg5AhhRkAd9XRNdSd+T7Ow5UkOA+u/mdVh2qxSv0QkptvJgcuD5HhDENydyzIXevOB4tfZiAwZtdCHxZ0VWqz2jGpMW2PdSh4tz/uWiOj1pD5xj653LdLProncYPXtj9RjHryYjeVwONBFYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734355753; c=relaxed/simple;
	bh=q0Xp83i0Ud86pg6d/0cNeNMGXiBNhuUJ93k75c3sf4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/D8jPmHjR0UlCc9kVISwTCQZhc8bEscKt68HnT1+9aB2sJocoeTH48CQNKLD8FX4+VDF1AVEQtoYtRi1ZTYXxupoy+O5o64LOi4OjlKXu4z5r8lpRfLq0NDiwZc6GI/Z5t7QMXd1h9v3dEZCUVSCZpDfpiBev6iSo672EaBelU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f0bF2xtb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734355752; x=1765891752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q0Xp83i0Ud86pg6d/0cNeNMGXiBNhuUJ93k75c3sf4E=;
  b=f0bF2xtbdyRJ1Rv6AD5cKrCYpg/HJzGauP2BmCFy4Cp+NK4UElXxdfw4
   4F6W84sq4/Uws/oM2tgvPm4/EKo1RSgZJg4uuWpRG2QVOCK1prsWxioy+
   QcGXiG4/k1IxK2BYnzq4yoK1CmWnnlTncAs6zJBCKhU3PJDfzKrvXysE+
   mzxiXh9KbXkYB6ga4I3dgEmpZGYIWUuuRYRqToN20Rq5MefjFBFhEwFiC
   NHMTBoNXF/r0FVZbZWCA5C10tYUomjKjqKkVDlScTr7kIBw7JhREEtMVg
   y2deCjdya9hE7LFzrKo5jZd7dUrTXvkQcrabV+KJn+nKhugkVoeA8sglp
   w==;
X-CSE-ConnectionGUID: XefpUGBiRI2Tt3su9XFUXg==
X-CSE-MsgGUID: +myUyaxoRy2mdpt89IoBug==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34472319"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="34472319"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 05:29:11 -0800
X-CSE-ConnectionGUID: y4xsy506S8+efpZkNS/iLg==
X-CSE-MsgGUID: 5kG0HaHLTiqtHSBjQMYnYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="97441712"
Received: from mklonows-mobl1.ger.corp.intel.com (HELO intel.com) ([10.245.246.2])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 05:29:09 -0800
Date: Mon, 16 Dec 2024 14:29:05 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: jiashengjiangcool@outlook.com, andi.shyti@linux.intel.com,
	nirmoy.das@intel.com, stable@vger.kernel.org, tursulin@ursulin.net
Subject: Re: FAILED: patch "[PATCH] drm/i915: Fix memory leak by correcting
 cache object name in" failed to apply to 5.10-stable tree
Message-ID: <Z2ArIdUSYWZofqt-@ashyti-mobl2.lan>
References: <2024121517-deserve-wharf-c2d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024121517-deserve-wharf-c2d0@gregkh>

Hi Jiasheng,

On Sun, Dec 15, 2024 at 09:33:17AM +0100, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Could you please fix the backport to 5.10 and 5.4 as they are not
applying cleanly?

Thanks,
Andi

