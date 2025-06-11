Return-Path: <stable+bounces-152411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBD2AD5405
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 13:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2E817C736
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 11:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47664248F75;
	Wed, 11 Jun 2025 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P40SRLOH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA9321FF2B;
	Wed, 11 Jun 2025 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641409; cv=none; b=ic2EahfHBzgtkKSOY44EXphNIKnB4LpCz7sPI3GXeClxLf/tyUUlfymW1DvoOMc5egBWA0Q+dTUDo8Z0mDNi1Q+78OsUYHOxkmKP0pChTFpfDG8UdNY9x8L0KJDbt1feBnuGVqCELtgBThbNNBfN69iJ79aw/7xlmgxMEy98n+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641409; c=relaxed/simple;
	bh=VB8JmS6BkzO33e6buulQO1O8Ftm+eUk6uCK5i1h+3bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UI8FigpGC0Qwie+AK3EhfXHhcrvuJGIvn5g0favwyfPM+SYkxmMnESlJsC3zWTSa0AZF8JXtyC5Su8I0BNBsd9+vJz/9L62edusbEh96ft/sViDxnk9wSxd06qYObWUAJVn6WXLH8wk8XVmcqXLLUkIZ7RzTZUD30Uj/6nxrhHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P40SRLOH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749641408; x=1781177408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VB8JmS6BkzO33e6buulQO1O8Ftm+eUk6uCK5i1h+3bo=;
  b=P40SRLOH2iEqmjLvqRzPZmf8fV4el6Utf9USQgcemVuReR2pbKfdxd9h
   8DRN39IJPFq6zY5k+NGQYK+Y9wYq4MFCtKGbsZuuj3lYw3lhv2Q4iXLhm
   uYTbkh3em4A7e4ibfWRHKpqqbLumQMvQvRNvCkKuJKgNt+NZuf6MRE7zd
   Op66uCqPDUKdg4MWvpumwkECMDL9nPXMkwS15zWza8Tg1eIS2Rg0R+mLE
   EtZE0TRqqgaff7DfatYf0DlGwPR5QqcBKEX8SDbiUei/o6zVllVSzcp/q
   pb9o0QZrElztfwS2toO+4tK7cuZaMy+Mz4vQtHyt40tch/fmnX3BSwusz
   Q==;
X-CSE-ConnectionGUID: Ll9r3PVMT+Wo4Bg7ym9npw==
X-CSE-MsgGUID: TgdhKGx0TCiff3o6X/599A==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51773157"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="51773157"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:30:07 -0700
X-CSE-ConnectionGUID: uBK6fAPPRzK7dr7ewiRNHQ==
X-CSE-MsgGUID: gjpTy9KXSYqg376srKwAqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="150972729"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 11 Jun 2025 04:30:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 7D97F1CF; Wed, 11 Jun 2025 14:30:03 +0300 (EEST)
Date: Wed, 11 Jun 2025 14:30:03 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Harry Wentland <harry.wentland@amd.com>, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: acpi: fix device link removal
Message-ID: <20250611113003.GG2063270@black.fi.intel.com>
References: <20250611111415.2707865-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250611111415.2707865-1-heikki.krogerus@linux.intel.com>

On Wed, Jun 11, 2025 at 02:14:15PM +0300, Heikki Krogerus wrote:
> The device link to the USB4 host interface has to be removed
> manually since it's no longer auto removed.
> 
> Fixes: 623dae3e7084 ("usb: acpi: fix boot hang due to early incorrect 'tunneled' USB3 device links")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

