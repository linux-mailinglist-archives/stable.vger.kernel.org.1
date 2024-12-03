Return-Path: <stable+bounces-96306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE6C9E1CCA
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 13:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53287163671
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 12:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8921EC00D;
	Tue,  3 Dec 2024 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OzlRpZvq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5D813B2A8;
	Tue,  3 Dec 2024 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230290; cv=none; b=VUrbN+P3CnwZeWFHfjl9f43pqBbg+f+/xh1PsEZgjFABxiGCXFu12NkZ3oBVu9GPaaBIwR7n5whLeKkKO4r8vqW7cQHkCp9GrG20+1z4ekHoalBkEBXQZ7Ygij/SJeCBaPV5mDTMxtFD+UxQvlAWFpjt25b0d8VPtUxO0FyFUdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230290; c=relaxed/simple;
	bh=iON74EFVuYShWuCU4Hc0uabP6VINWtZjfjzBmCHVrP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQxOrKh5zldCUqU9yWGMDrnM98t+wiGfrZssuOj96xmaKKo+FCvgI+wydMx7BhGnaxVGIpbHE5lZFmSwqC/ushKXSwxdkHzwLwdwegQj8/5UU2MEfug7zkd2fQB70TIGmvgNir44+r+iKqyDZAdYK9pTd2W8fk4u0Q7huE7SlmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OzlRpZvq; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733230288; x=1764766288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iON74EFVuYShWuCU4Hc0uabP6VINWtZjfjzBmCHVrP8=;
  b=OzlRpZvq+rdme/FsF3iWPWH46p0qXqfGwjUTuZQZk7r/mnUuXFb+4rcA
   lgf0ESrwtq3PQOAJozr6DzXzdm4kKHHKzygFfnBRaV/FRHFmd6Gpb2Fjq
   wj6UbqaObnGrYIJQIjJjsXqL2un4q/Lb0Bw0rfb0NXz0QtIHaiNfXGb+E
   T1pj9mMk4bgLOkzYf8MEBSGItj+4Gl09M5vQW4oqsjtrHkCYVCA+Nd4Nb
   i4H0hseoXfLVbcNT8Mfe2PETfbrNyvKx/4ES2yXcsRvdDq6VbPHZSSMed
   va+F8HW5mHpYeFLjdrKW8ZP+YeOKx4yiku2yXGyv1f5Ie8C26/zWmKdGG
   A==;
X-CSE-ConnectionGUID: VtZavNFnT6Oa1QlDvbNAnQ==
X-CSE-MsgGUID: TgWT2FLUR9yHac3h6MQftQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="36293531"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="36293531"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 04:51:27 -0800
X-CSE-ConnectionGUID: Z0ycV6u/R8yflqnVhVXMgQ==
X-CSE-MsgGUID: PumL3ywlTrKVg6jfmUjniw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98435565"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa003.jf.intel.com with SMTP; 03 Dec 2024 04:51:24 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 03 Dec 2024 14:51:22 +0200
Date: Tue, 3 Dec 2024 14:51:22 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: Fix completion notifications
Message-ID: <Z07-yh4HhLKKLJNQ@kuha.fi.intel.com>
References: <20241203102318.3386345-1-ukaszb@chromium.org>
 <Z07-NoXOTO0yJNKk@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z07-NoXOTO0yJNKk@kuha.fi.intel.com>

On Tue, Dec 03, 2024 at 02:48:59PM +0200, Heikki Krogerus wrote:
> On Tue, Dec 03, 2024 at 10:23:18AM +0000, Łukasz Bartosik wrote:
> > OPM                         PPM                         LPM
> >  |        1.send cmd         |                           |
> >  |-------------------------->|                           |
> >  |                           |--                         |
> >  |                           |  | 2.set busy bit in CCI  |
> >  |                           |<-                         |
> >  |      3.notify the OPM     |                           |
> >  |<--------------------------|                           |
> >  |                           | 4.send cmd to be executed |
> >  |                           |-------------------------->|
> >  |                           |                           |
> >  |                           |      5.cmd completed      |
> >  |                           |<--------------------------|
> >  |                           |                           |
> >  |                           |--                         |
> >  |                           |  | 6.set cmd completed    |
> >  |                           |<-       bit in CCI        |
> >  |                           |                           |
> >  |     7.notify the OPM      |                           |
> >  |<--------------------------|                           |
> >  |                           |                           |
> >  |   8.handle notification   |                           |
> >  |   from point 3, read CCI  |                           |
> >  |<--------------------------|                           |
> >  |                           |                           |
> > 
> > When the PPM receives command from the OPM (p.1) it sets the busy bit
> > in the CCI (p.2), sends notification to the OPM (p.3) and forwards the
> > command to be executed by the LPM (p.4). When the PPM receives command
> > completion from the LPM (p.5) it sets command completion bit in the CCI
> > (p.6) and sends notification to the OPM (p.7). If command execution by
> > the LPM is fast enough then when the OPM starts handling the notification
> > from p.3 in p.8 and reads the CCI value it will see command completion bit
> > set and will call complete(). Then complete() might be called again when
> > the OPM handles notification from p.7.
> > 
> > This fix replaces test_bit() with test_and_clear_bit()
> > in ucsi_notify_common() in order to call complete() only
> > once per request.
> > 
> > This fix also reinitializes completion variable in
> > ucsi_sync_control_common() before a command is sent.
> > 
> > Fixes: 584e8df58942 ("usb: typec: ucsi: extract common code for command handling")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Sorry about that typo.

-- 
heikki

