Return-Path: <stable+bounces-135285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEFBA98B96
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B3A176596
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB501A3167;
	Wed, 23 Apr 2025 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXF0HiMD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA80F19F48D;
	Wed, 23 Apr 2025 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745415794; cv=none; b=BLrmiTQjPubLUHENB4pJpWiIvWHADuSXwYOluGaPKRCimuqb2XZ00GuMs0c16El1EBf7Z0p9nVe8Wa5Pqg2BTKTt1wepaizkDs/xmc46DxPfhfX/xDSq2GEVgd+JXJMu7qfVpc084fnFL0/6ayyhQL3weo2N3fuuM3gXs22rBJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745415794; c=relaxed/simple;
	bh=sdSO4vtsyCgKCiuvtLa7sZ+BGvUG/9woFfGbGd3g5bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ushm6cbGX4lpuxpaU0RNRoCCQDuq2VwxB+yrM3JC4P8u2wt9OI3BsgqzxcLbTDJziii0MXe9CVAkLaqRsCeXGd4dyoVI/noSBZgJwWE6VTzZw2fxenprobuvlxBhMpDu+ZgzXxA/cXOEYHl9OfhWFmPlDMtng5ZJGiBzrDIj/vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXF0HiMD; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745415793; x=1776951793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sdSO4vtsyCgKCiuvtLa7sZ+BGvUG/9woFfGbGd3g5bQ=;
  b=aXF0HiMDG8aokgs2pUXUgmVKpAXWaTqmr1miWTryTsPmWgtSrKMQliwY
   CYJNabgflCH38W0oBdMiCzY6ZI4VSV933+QTuYOKW5S4bNrzXoXHU1QM+
   rtcLKIhLnEAMLPSjVfs+t19Gm9vURj/80AOvt9WUb+qOg9Aq7Wb4JCjJ3
   yVU/yUOtYh5sz5NkqGIf6xmuHmPBb8ekjETio7q4LQ/LgrPapn+GkDoDa
   mPcaTaQDzKYcCmcU5zU7A6P6JacJwYFn1x3vPB4jTZLt7KoUtrcBx1ume
   XyeFglpQTGUUKhW1dhXCeC+zNBhfnCKxaIbP59aUGVUBoDC2KDAvrgQTv
   A==;
X-CSE-ConnectionGUID: BwfN/wC0S+iYbyhxVAV4tw==
X-CSE-MsgGUID: b/91ykZeQeimDnhn0T6KPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47190576"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="47190576"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 06:43:12 -0700
X-CSE-ConnectionGUID: 1WWXhu/HSWKk3VQE5qeX7A==
X-CSE-MsgGUID: J53B5CQbTdKylLhvMnSWAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132164514"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa006.fm.intel.com with SMTP; 23 Apr 2025 06:43:08 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 23 Apr 2025 16:43:07 +0300
Date: Wed, 23 Apr 2025 16:43:07 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: gregkh@linuxfoundation.org, lumag@kernel.org, pooja.katiyar@intel.com,
	diogo.ivo@tecnico.ulisboa.pt, madhu.m@intel.com,
	saranya.gopal@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: fix Clang -Wsign-conversion warning
Message-ID: <aAjua0rWkHO4H6Rj@kuha.fi.intel.com>
References: <20250422134717.66218-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422134717.66218-1-qasdev00@gmail.com>

On Tue, Apr 22, 2025 at 02:47:17PM +0100, Qasim Ijaz wrote:
> debugfs.c emits the following warnings when compiling with the -Wsign-conversion flag with clang 15:
> 
> drivers/usb/typec/ucsi/debugfs.c:58:27: warning: implicit conversion changes signedness: 'int' to 'u32' (aka 'unsigned int') [-Wsign-conversion]
>                 ucsi->debugfs->status = ret;
>                                       ~ ^~~
> drivers/usb/typec/ucsi/debugfs.c:71:25: warning: implicit conversion changes signedness: 'u32' (aka 'unsigned int') to 'int' [-Wsign-conversion]
>                 return ucsi->debugfs->status;
>                 ~~~~~~ ~~~~~~~~~~~~~~~^~~~~~
>                 
> During ucsi_cmd() we see:
> 
> 	if (ret < 0) {
> 		ucsi->debugfs->status = ret;
> 		return ret;
> 	}
> 	
> But "status" is u32 meaning unsigned wrap-around occurs when assigning a value which is < 0 to it, this obscures the real status.
> 
> To fix this make the "status" of type int since ret is also of type int.
> 
> Fixes: df0383ffad64 ("usb: typec: ucsi: Add debugfs for ucsi commands")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index 3a2c1762bec1..525d28160413 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -432,7 +432,7 @@ struct ucsi_debugfs_entry {
>  		u64 low;
>  		u64 high;
>  	} response;
> -	u32 status;
> +	int status;
>  	struct dentry *dentry;
>  };
>  
> -- 
> 2.39.5

-- 
heikki

