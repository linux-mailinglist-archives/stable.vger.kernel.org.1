Return-Path: <stable+bounces-126862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B98AA73377
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 14:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED332178F3C
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 13:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83488216E2A;
	Thu, 27 Mar 2025 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gigqDCzd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0292628D;
	Thu, 27 Mar 2025 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743082683; cv=none; b=IEPTcQGNog3N+PpoXgpD+pfi2fQdgTbQefQdZ6mqxBBGDFrv7zC7nQp9myiJz1BUj8A1zXGi34e/nV//xPNqL9XvOeidWe22z+Tbb7mLHZEDUNAVxEdX/9sLvgalUzrplGFOr58HXDaqOIOkuz+zq6kKm+HTDGtN4NfSSJoiSzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743082683; c=relaxed/simple;
	bh=evCPU66MCh/bwq1B1yhuT2t43RG2f/1GbPnojOYjMjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DC6i+kebXbjPmvX+GWX44zIQ7RJS70TWqPoRgcR0OAhJ2Ttja5bAHnqfKAjT4AczyaO7h903323pcCjiqSmUk/GDOr7dkZhVZD+hOY3dKUS8tIEiuLzzV3BaALCfkg54Z9jBsGobMOUiH9+37Q6rrG8+VRqK40vwxX8Mp1O+vO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gigqDCzd; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743082682; x=1774618682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=evCPU66MCh/bwq1B1yhuT2t43RG2f/1GbPnojOYjMjI=;
  b=gigqDCzdxeRexX9jNyP4D0GiCS4ducc2IrrkYMu6CpitKUrSb/pfIwdR
   qzgDT02M80fzW+xFX9Y4QJ2Yc6bIG+DUG9osUFvn/NY/w9sXCrV9PgD/g
   dQhZGgnDm0qzIArlA5j6c8yubKtQnE4TgWSJU6fa2sFgYJOZo8Ldi1sD8
   1xofQeK2qdqHCZd4hv3ro+UWT5yYoz/sn1COwBXhFozEVeh1NP2QGLgTu
   Wkp2B7d1L+djhyDjmzvIIJY3BHoTkPYQcVpHuB9f+yKTkldzRYnK6Trfc
   OEM6+AbLqgzbt7TmUqK/KuC+mZgYmjxwR7dwTVFjKtEChpm57DNr+bcJj
   w==;
X-CSE-ConnectionGUID: 9ppp10PfQLCnbutUMs89fw==
X-CSE-MsgGUID: Iomj7LpcR2m0qvcIFB9Bxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44287700"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="44287700"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 06:38:01 -0700
X-CSE-ConnectionGUID: InlPhFe+Soe7LClEHLCLRw==
X-CSE-MsgGUID: /4JUZVgaQK+T6euogmlXkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="129292328"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 27 Mar 2025 06:37:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 2352C1D9; Thu, 27 Mar 2025 15:37:57 +0200 (EET)
Date: Thu, 27 Mar 2025 15:37:56 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv2] thunderbolt: do not double dequeue a request
Message-ID: <20250327133756.GA3152277@black.fi.intel.com>
References: <20250327114222.100293-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250327114222.100293-1-senozhatsky@chromium.org>

Hi,

On Thu, Mar 27, 2025 at 08:41:21PM +0900, Sergey Senozhatsky wrote:
> Some of our devices crash in tb_cfg_request_dequeue():
> 
>  general protection fault, probably for non-canonical address 0xdead000000000122
> 
>  CPU: 6 PID: 91007 Comm: kworker/6:2 Tainted: G U W 6.6.65)
>  RIP: 0010:tb_cfg_request_dequeue+0x2d/0xa0
>  Call Trace:
>  <TASK>
>  ? tb_cfg_request_dequeue+0x2d/0xa0
>  tb_cfg_request_work+0x33/0x80
>  worker_thread+0x386/0x8f0
>  kthread+0xed/0x110
>  ret_from_fork+0x38/0x50
>  ret_from_fork_asm+0x1b/0x30
> 
> The circumstances are unclear, however, the theory is that
> tb_cfg_request_work() can be scheduled twice for a request:
> first time via frame.callback from ring_work() and second
> time from tb_cfg_request().  Both times kworkers will execute
> tb_cfg_request_dequeue(), which results in double list_del()
> from the ctl->request_queue (the list poison deference hints
> at it: 0xdead000000000122).
> 
> Another possibility can be tb_cfg_request_sync():
> 
> tb_cfg_request_sync()
>  tb_cfg_request()
>   schedule_work(&req->work) -> tb_cfg_request_dequeue()
>  tb_cfg_request_cancel()
>   schedule_work(&req->work) -> tb_cfg_request_dequeue()

Not sure about this one because &req->work will only be scheduled once the
second schedule_work() should not queue it again (as far as I can tell).

> To address the issue, do not dequeue requests that don't
> have TB_CFG_REQUEST_ACTIVE bit set.

Just to be sure. After this change you have not seen the issue anymore
with your testing?

> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: stable@vger.kernel.org
> ---
> 
> v2: updated commit message, kept list_del()
> 
>  drivers/thunderbolt/ctl.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
> index cd15e84c47f4..1db2e951b53f 100644
> --- a/drivers/thunderbolt/ctl.c
> +++ b/drivers/thunderbolt/ctl.c
> @@ -151,6 +151,11 @@ static void tb_cfg_request_dequeue(struct tb_cfg_request *req)
>  	struct tb_ctl *ctl = req->ctl;
>  
>  	mutex_lock(&ctl->request_queue_lock);
> +	if (!test_bit(TB_CFG_REQUEST_ACTIVE, &req->flags)) {
> +		mutex_unlock(&ctl->request_queue_lock);
> +		return;
> +	}
> +
>  	list_del(&req->list);
>  	clear_bit(TB_CFG_REQUEST_ACTIVE, &req->flags);
>  	if (test_bit(TB_CFG_REQUEST_CANCELED, &req->flags))
> -- 
> 2.49.0.395.g12beb8f557-goog

