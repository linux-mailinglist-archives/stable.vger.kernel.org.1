Return-Path: <stable+bounces-143025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C24AB0EB7
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 11:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350D0A02471
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 09:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6B327A463;
	Fri,  9 May 2025 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JOJr/Koi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722B527A440;
	Fri,  9 May 2025 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782180; cv=none; b=RI7IJ/l6eZm9kuMUZvTlLfscl4+rX58YF8qzoa1MwqUWTnXc8elU1VqnVHKzOqnl4aH37MpvKmuZf9q59rdfIs7AQ2lpbpdPbbPdtWRtLjo6NbOtef1nyCy1uZbPxV2gWUHY2p4GEBlP/szi9MG2o+vbMF2bOj7Qqv+eCpkv/Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782180; c=relaxed/simple;
	bh=GKY/jZpQLY+US/6VNTuAUDGj+GbpyYg9QGXXARr8MAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnH4ux5uS6fuCctyIzHenrHsGf992hZC+4p075htzeB3RTQ9h78pdEzDNetE7JAEgtGrlp92MMJ+ipvmHkUN3+ss2fwgDmFsSUfpXRAaHXFw7DgjxjF/uC4pM4ElP5paotiHR/6apQcrzXstZI1WSnLL7pEY4BkAli/CzIzyVtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JOJr/Koi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746782179; x=1778318179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GKY/jZpQLY+US/6VNTuAUDGj+GbpyYg9QGXXARr8MAo=;
  b=JOJr/Koid177201SqodWDUvvV8knOGtrX3zfHjEUGaxs5uXf4UEeYNAM
   Vvvoumfntwy5tJrxOXQFhXK+P0O264x3sWOvQ1rlLGX19NW84XuIqihk8
   YWKfCYxKb7o3lHXwc9M/oQ3jhjRaiQ116VYRQxg9Li0n6+8/ewDz3c24p
   O7xEkPhsoEcTqaqRghu/m4Sjpx3ws0ga/BIv7q0qstPW58x2iOAaNMQjw
   IhiK44j7WRAzSSY0CRk1BYw7DVXnhgR8UbaV5zoEc23X70wfbFn7Bv8Ef
   itZj26EzxQXu1Ma+gxp5qJ+WLpVwu2ua/catWUXt3sCOf07wY3JckwE6T
   w==;
X-CSE-ConnectionGUID: XczeReWmSjyyPre7xmon9Q==
X-CSE-MsgGUID: FXkeoW/NQZWNNMUO9omzSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48470791"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="48470791"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 02:16:18 -0700
X-CSE-ConnectionGUID: TC9K+ZGEQ9yYB5TqUtdVbQ==
X-CSE-MsgGUID: N+2HiaJkRSWfXuFUfbC/hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="159860354"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 09 May 2025 02:16:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 4AC2413B; Fri, 09 May 2025 12:16:14 +0300 (EEST)
Date: Fri, 9 May 2025 12:16:14 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv3] thunderbolt: do not double dequeue a request
Message-ID: <20250509091614.GB88033@black.fi.intel.com>
References: <20250327150406.138736-1-senozhatsky@chromium.org>
 <ojkrbtd2kpweo5xcfulfobdavj5ab3ysxxle4kr5oa455me77s@p2o4jdwsr3m2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ojkrbtd2kpweo5xcfulfobdavj5ab3ysxxle4kr5oa455me77s@p2o4jdwsr3m2>

On Thu, May 08, 2025 at 12:47:18PM +0900, Sergey Senozhatsky wrote:
> On (25/03/28 00:03), Sergey Senozhatsky wrote:
> > Some of our devices crash in tb_cfg_request_dequeue():
> > 
> >  general protection fault, probably for non-canonical address 0xdead000000000122
> > 
> >  CPU: 6 PID: 91007 Comm: kworker/6:2 Tainted: G U W 6.6.65
> >  RIP: 0010:tb_cfg_request_dequeue+0x2d/0xa0
> >  Call Trace:
> >  <TASK>
> >  ? tb_cfg_request_dequeue+0x2d/0xa0
> >  tb_cfg_request_work+0x33/0x80
> >  worker_thread+0x386/0x8f0
> >  kthread+0xed/0x110
> >  ret_from_fork+0x38/0x50
> >  ret_from_fork_asm+0x1b/0x30
> > 
> > The circumstances are unclear, however, the theory is that
> > tb_cfg_request_work() can be scheduled twice for a request:
> > first time via frame.callback from ring_work() and second
> > time from tb_cfg_request().  Both times kworkers will execute
> > tb_cfg_request_dequeue(), which results in double list_del()
> > from the ctl->request_queue (the list poison deference hints
> > at it: 0xdead000000000122).
> > 
> > Do not dequeue requests that don't have TB_CFG_REQUEST_ACTIVE
> > bit set.
> 
> Mika, as was discussed in [1] thread we rolled out the fix to
> our fleet and we don't see the crashes anymore.  So it's tested
> and verified.

Cool, thanks! Applied to thunderbolt.git/fixes.

