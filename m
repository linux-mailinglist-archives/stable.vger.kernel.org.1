Return-Path: <stable+bounces-171953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 450FFB2EF3C
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 09:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFF11C86DCE
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 07:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A31287275;
	Thu, 21 Aug 2025 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VhfQ1M1v"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F1FEAE7;
	Thu, 21 Aug 2025 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760554; cv=none; b=WxDbCYaZAVuG1SUOZvysv1V/dLpGbzWCLQnkRYGTXiqZqomJeflKFIh3COIxGgMO++bQgctyfJfUMk8JgAhkzuRJRpezf21Cf56QJuHuGZ7i1u1OhuGg9Wg7QcqYTm0wpyt0WpapF3EYM0r78Cor6IoFrWHKUohpwwNabbUjdYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760554; c=relaxed/simple;
	bh=cLFv8+LOAbM3Lujy5L93CpKEqcIa4IhgwpBl6zi05R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHtftje+T1utxsWxF2iAaMVsLiiYZozSP/iyOCbxC3syB5ywe6OejObTKkXi5vCgr+jHr4dSAfXqGarUjUIptjHpXfaS7d37dgYfPYK12xh3f32cWqkM92XmzOj9z3Bqm4qGe6SDrjFpd3zVhFDr1BB/OQ8Bmw3dhUGFWj8k358=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VhfQ1M1v; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755760552; x=1787296552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cLFv8+LOAbM3Lujy5L93CpKEqcIa4IhgwpBl6zi05R4=;
  b=VhfQ1M1vH2Risb5dD9SRscwQk/5LjvKQ9OH2Wyddu/WUsB/9ziJABN4I
   xItaAx9+DOnMol7tgJzevhB5Tg/aj1UpRBxMHkYwuqMS8KB+3QNlu7H24
   0hSIwpxs7X9S9BE3TeMDTnNDs2XhRB7r0ePX2zTzBmgLvBG/9QMasMzEM
   pRU/qfMeH4LLTzw63L31+ESlHyqvRaTHjGiU91bNBZom6QBPU1zB2tRhy
   26LbDg3euzg/zaU7nukBT5zNhAgHTv8dbIDfR7Qs3IpOpFjQ1VTTuQm5j
   ZIxCofyFQQmKXIJEpO1sAOaE09zqfkJisyaHN07mt4i1Tf+Qlc3ZgyNoQ
   w==;
X-CSE-ConnectionGUID: SMS1zKlKRpuvAGL/eH4+cA==
X-CSE-MsgGUID: oJUwOAHXTR+3ysb6rTRauA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="68744031"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="68744031"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 00:15:51 -0700
X-CSE-ConnectionGUID: s5PLa+MjSaaE+m/6XkEifg==
X-CSE-MsgGUID: BERzrKRASEuU4w1DktciKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="169131106"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa010.fm.intel.com with SMTP; 21 Aug 2025 00:15:47 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 21 Aug 2025 10:15:46 +0300
Date: Thu, 21 Aug 2025 10:15:46 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: amitsd@google.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: [PATCH v2 2/2] usb: typec: maxim_contaminant: re-enable cc
 toggle if cc is open and port is clean
Message-ID: <aKbHoiYlznpkWS4N@kuha.fi.intel.com>
References: <20250815-fix-upstream-contaminant-v2-0-6c8d6c3adafb@google.com>
 <20250815-fix-upstream-contaminant-v2-2-6c8d6c3adafb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-fix-upstream-contaminant-v2-2-6c8d6c3adafb@google.com>

One nitpick...

> @@ -345,6 +378,12 @@ bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect
>  	if (ret < 0)
>  		return false;
>  
> +	if (cc_status & TCPC_CC_STATUS_TOGGLING) {
> +		if (chip->contaminant_state == DETECTED)
> +			return true;
> +		return false;
> +	}

	if (cc_status & TCPC_CC_STATUS_TOGGLING) {
		return chip->contaminant_state == DETECTED;

>  	if (chip->contaminant_state == NOT_DETECTED || chip->contaminant_state == SINK) {
>  		if (!disconnect_while_debounce)
>  			msleep(100);

thanks,

-- 
heikki

