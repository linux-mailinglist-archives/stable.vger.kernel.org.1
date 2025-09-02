Return-Path: <stable+bounces-176932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0805B3F583
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 08:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276A5483AFD
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 06:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6893B2E11B5;
	Tue,  2 Sep 2025 06:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hG+mOfFN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9651DFFD;
	Tue,  2 Sep 2025 06:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794726; cv=none; b=uu4/aOVK/eBaz6xf2I4Vrgcp99REKP+73vth6lwGNOLKOZ8B6CQ15XI5bfWHLHmN74mEtcLUsbV4LVDb+rhGpsQOWZsOZTVrawZZ81q0McD2ChUvoxF2is5BBT8pncAznKQ+wNgQQpiHdWFdZzmJWr8DlRf0IJN+NtJyRMpxb3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794726; c=relaxed/simple;
	bh=0K6055PHXE/8jpbgIbjn3eV+nivoRabvJYjZLeU5JiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKZ53muokpuChYMh5K4DbVz4i4p/JX7k+nqtAEz2AnoO7648/tgYmaVptEq2lQ8CAFQJN5c2c5ChNBnBDPI/GV7W8liCcAtXOXPnPSfOlviVTDwYzYk9DCbMMVfsmlpI3PkKFw+FrJUoFvREMnxdj0kjmsBZsaBu0QDzUthBquc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hG+mOfFN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756794724; x=1788330724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0K6055PHXE/8jpbgIbjn3eV+nivoRabvJYjZLeU5JiY=;
  b=hG+mOfFNBhogRdv8yC5qDy2Hr/XKYcmL2ltSJj4gQyrlT6mEyLQBtb0D
   OvkGu+zFxpSZE+S83+XRE3HJrH59kspdOuKQVjWRzDT0EUdDinL6yn0zd
   wShBZE9oHVjTndWoOPOxXWa2bsTkss0tKyZLRqLxcjfBY1d7MSkLATPFd
   FYFIZxENV0AT/Qah6BPCriuJAq7wDXyIeyBYdMjgGT4yEz9t/mVMHharU
   +fL+TTu6rOW55HtD7vv4rACU/3xIe3zHYrMTnbudJcqVg+ohyO6+qltWM
   sVu+EAHIOVMPTPSv/FU7u0zmE21U3B1PtlgxXeL99dvCmfn7MhR1Vivvv
   A==;
X-CSE-ConnectionGUID: jmdDp2pBT6GV0zxfrLRU3g==
X-CSE-MsgGUID: 3FK7J/b2Q96eGfcxJHttsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="69316539"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="69316539"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 23:32:03 -0700
X-CSE-ConnectionGUID: ZHh4evWsTwWP0/nVFYI3Og==
X-CSE-MsgGUID: BVEpmdlzR2ap4dewY+/Psg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="176515345"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 01 Sep 2025 23:32:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 1281294; Tue, 02 Sep 2025 08:32:00 +0200 (CEST)
Date: Tue, 2 Sep 2025 08:32:00 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: debugfs: Fix dentry reference leaks in
 margining_port_init
Message-ID: <20250902063200.GG476609@black.igk.intel.com>
References: <20250901080438.2278730-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250901080438.2278730-1-linmq006@gmail.com>

On Mon, Sep 01, 2025 at 04:04:37PM +0800, Miaoqian Lin wrote:
> The debugfs_lookup() function returns a dentry with an increased
> reference count that must be released by calling dput().

Don't we need the same for margining_port_remove() too?

> 
> Fixes: d0f1e0c2a699 ("thunderbolt: Add support for receiver lane margining")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/thunderbolt/debugfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thunderbolt/debugfs.c b/drivers/thunderbolt/debugfs.c
> index f8328ca7e22e..2aadbec9a3e5 100644
> --- a/drivers/thunderbolt/debugfs.c
> +++ b/drivers/thunderbolt/debugfs.c
> @@ -1770,6 +1770,7 @@ static void margining_port_init(struct tb_port *port)
>  	port->usb4->margining = margining_alloc(port, &port->usb4->dev,
>  						USB4_SB_TARGET_ROUTER, 0,
>  						parent);
> +	dput(parent);
>  }
>  
>  static void margining_port_remove(struct tb_port *port)
> -- 
> 2.35.1

