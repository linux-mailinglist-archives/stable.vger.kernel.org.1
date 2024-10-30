Return-Path: <stable+bounces-89319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C2D9B638F
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 13:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76DA282D3E
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 12:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945AC1EB9E3;
	Wed, 30 Oct 2024 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WeCazum8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB991E908D;
	Wed, 30 Oct 2024 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292998; cv=none; b=Ubn1YJFzTyKY/HSKk1aPoCDsmhqbFSHvwjWsH9Aa6fz0XwnMsDAP7XGgTEUOcBG2DOQP7cZDmoDI6PD8YWyZ257uc6jVK/7EdhR9SreNTXdv0an10ZLPO2uld6dsuGT9W+NbxIQ3/Ch6OQ4jWWrgDKlV5i+gX23DGrFfyMIHWCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292998; c=relaxed/simple;
	bh=/xSQm3Ad5+59O2YqtB1Q8gI6LHOFjk/qqc8juVXssSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9ZxOmpCklj2LGm74NFaHkTA64WjR9OhgcB9XbMWN5TXClA/YzH0OfoBA8/pAbR/9Iq+ov4TkPSdIX46+YUNfmwu3oDnmTa2rGhRKR0IZyfCHTY7HESC22j1dFuyNlDmFQGdFb7W1yX4eg2cs01fC2q3xasK2TOO+Xwd129YFxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WeCazum8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730292996; x=1761828996;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/xSQm3Ad5+59O2YqtB1Q8gI6LHOFjk/qqc8juVXssSQ=;
  b=WeCazum8DUmF2ODdzyueJkkY3Atcz11MLD4LBBUxj4Jk77yNximwXxL0
   Y+C7Ysyy/y/x5aAbqeNjUfX/2tGfNIviG3tATXNcgjoEQWuLoIeqXUgVi
   RYW/JpFkgNsyxysOoEkSdkvzBT4Vg8M87DCTKBh/FEfqmGG1pIPbk3PCM
   TBXYSiW07zqzUKwBEKVQoM0JCioSbSmW8mLL02/gkXTd4JwPA5RfstdDv
   AAzpJkS/XHd/q8bzABeooMRBAOcFd8eDWvZ9juW1K5JgIMvIEQi0gUFl5
   pv7kMYq9zOZIvAsxW9b3NPUq9rRSD8kw6fFHcEYDeccR5wR9M28CXkA+L
   Q==;
X-CSE-ConnectionGUID: vsD/Q23WR4C5BDKcYyiYzA==
X-CSE-MsgGUID: 0j7/DLt3RzWGKBc1XR226w==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="30205718"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="30205718"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 05:56:36 -0700
X-CSE-ConnectionGUID: sDXG5Jc7QyCsFsQD6L7aSA==
X-CSE-MsgGUID: Y1uhV1WtSP+Vr6YcfwGkZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="105620775"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa002.fm.intel.com with ESMTP; 30 Oct 2024 05:56:34 -0700
Message-ID: <e156aec9-a30a-4f90-a158-634cb0ecea98@linux.intel.com>
Date: Wed, 30 Oct 2024 14:58:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] xhci: Don't issue Reset Device command to Etron
 xHCI host
To: Kuangyi Chiang <ki.chiang65@gmail.com>, mathias.nyman@intel.com,
 gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241028025337.6372-1-ki.chiang65@gmail.com>
 <20241028025337.6372-3-ki.chiang65@gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20241028025337.6372-3-ki.chiang65@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.10.2024 4.53, Kuangyi Chiang wrote:
> Sometimes the hub driver does not recognize the USB device connected
> to the external USB2.0 hub when the system resumes from S4.
> 
> After the SetPortFeature(PORT_RESET) request is completed, the hub
> driver calls the HCD reset_device callback, which will issue a Reset
> Device command and free all structures associated with endpoints
> that were disabled.
> 
> This happens when the xHCI driver issue a Reset Device command to
> inform the Etron xHCI host that the USB device associated with a
> device slot has been reset. Seems that the Etron xHCI host can not
> perform this command correctly, affecting the USB device.
> 
> To work around this, the xHCI driver should obtain a new device slot
> with reference to commit 651aaf36a7d7 ("usb: xhci: Handle USB transaction
> error on address command"), which is another way to inform the Etron
> xHCI host that the USB device has been reset.
> 
> Add a new XHCI_ETRON_HOST quirk flag to invoke the workaround in
> xhci_discover_or_reset_device().
> 
> Fixes: 2a8f82c4ceaf ("USB: xhci: Notify the xHC when a device is reset.")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>

Ok, I see, this patch depends on previous one, that's why it had the tags

Added this as well

Thanks
Mathias



