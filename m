Return-Path: <stable+bounces-88074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EC89AE739
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 16:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DAF21F2311D
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534BA1E378F;
	Thu, 24 Oct 2024 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k8EbJ+OJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016871D9A72;
	Thu, 24 Oct 2024 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778677; cv=none; b=ucGoNzyyxX2iwplTvPsDNY2SxxWupSuaoPr2N4AjmRMDHDo1JpFioR/3KUS2JFPkkrbCD7U1M2h0b6jv0WQyHJgjqRwIHsYumc94qQHdaG70TnYzAKsy4qK6sNZr8VT0NWeNXsZ+sIMJrT3AYaGyl5wIvexwGGV2Tn6mTvcsF+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778677; c=relaxed/simple;
	bh=PxlSbdihMOCWyqL5OYT1sFyA5dFCXHEJ923BMDFDebg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Azc2TMn5FWM2yp7f/flcUYMVYEWxs0RBqI5EyR6EO4oaJSiJQBIw48qLSplkIiX5AgIpt9JEXKKC+5og448Y4DpXG1qR46iVuzVPsY22T/kpuxsZ3ifL74hBn+U5uUNymBAmAymPFkHDTl2TZsRfvLJ07eahTUUf7ilEI+HleQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k8EbJ+OJ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729778675; x=1761314675;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PxlSbdihMOCWyqL5OYT1sFyA5dFCXHEJ923BMDFDebg=;
  b=k8EbJ+OJ6ztgdxTiqxqbXFM3bUgyVxKilhSTajjgXBctH78b3Fl8SN5c
   gcZlr7YewsMWuhXrpvdXoQxKjEyAczevjdKrouKd2NzRR9DENlmBaK6Ma
   N1HaJ7El1QZxomY72yPg91V4SRsoeBteBTDg8E7FEnyZd10eobsor+JnI
   e0w38Lh4rKx8azUt6kdyubumdWLmYm3FnAlTp5fWNf2Fyu7leRqJtoa8O
   NRvc05kKlOtxlpIsoY6KSkUalpR/0Z3BYMzV+3QvcnCaPPgOmkT53MnLj
   IHhcFQom6bL9Ssj48Ts7JCxHTigRaDkqF6or9IAuIRcedzeo8t94Hyi0u
   Q==;
X-CSE-ConnectionGUID: a7ZeMmhUQD6+qJ42AGg9iA==
X-CSE-MsgGUID: WbTBRsNcSyGp3c3xY4NPjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40801965"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="40801965"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 07:04:33 -0700
X-CSE-ConnectionGUID: Zm+uqjMLSwqqOYDlpadmEA==
X-CSE-MsgGUID: fvrBW4KfT++SHKXld5sTjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="118058291"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa001.jf.intel.com with ESMTP; 24 Oct 2024 07:04:31 -0700
Message-ID: <f9a2eb47-512e-4718-a83a-4742e09be85b@linux.intel.com>
Date: Thu, 24 Oct 2024 17:06:44 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] xhci: Fix Link TRB DMA in command ring stopped
 completion event
To: Faisal Hassan <quic_faisalh@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241022155631.1185-1-quic_faisalh@quicinc.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20241022155631.1185-1-quic_faisalh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.10.2024 18.56, Faisal Hassan wrote:
> During the aborting of a command, the software receives a command
> completion event for the command ring stopped, with the TRB pointing
> to the next TRB after the aborted command.
> 
> If the command we abort is located just before the Link TRB in the
> command ring, then during the 'command ring stopped' completion event,
> the xHC gives the Link TRB in the event's cmd DMA, which causes a
> mismatch in handling command completion event.
> 
> To address this situation, move the 'command ring stopped' completion
> event check slightly earlier, since the specific command it stopped
> on isn't of significant concern.
> 
> Fixes: 7f84eef0dafb ("USB: xhci: No-op command queueing and irq handler.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Faisal Hassan <quic_faisalh@quicinc.com>

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>

Greg, would you like to take this directly to usb-linus (6.12)?
If not I'll send it as part of series to usb-next later

Thanks
Mathias


