Return-Path: <stable+bounces-249321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UH2sCD4sC2oeEQUAu9opvQ
	(envelope-from <stable+bounces-249321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 17:11:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D7756FAA3
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 17:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF00B305663A
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CB0326939;
	Mon, 18 May 2026 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJZh1MqH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79C42F83A0;
	Mon, 18 May 2026 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116734; cv=none; b=OqJbcbqv/LDnzVQU3iqihe7Fd2ULDyj6wCj0NB80nxkh8KJ7Aj0TWLyKiqyMYKtuhAX6J05HAD4O1lp5F/D8e50v2RD9JemZG5hjvKJhHX4Yc3IvdXmdy5nOqjjVIFrEYFodby8iC42QL8sLpJwiuo1IMFmP7Obgo6BbMP7d/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116734; c=relaxed/simple;
	bh=5M12CY5LY7/jEIxQT9XnOtZig3/skeSByDZvdaYgENQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPewXW9R92AX9PvcTUHKgUMLYsQ11CuDWNsZS7MrsruwWTQv6wYrj8PtFEvcHER5YxEFZUmKjeQPCYc7NQ5eTEWIrM3GA++8lVIxFr9e72/2B4PQ2pVtwbhxCvfyRWyuWVEW2wblayjWpsdBKTy34ZssIHQjnQ63mQShTFc/9Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJZh1MqH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779116733; x=1810652733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5M12CY5LY7/jEIxQT9XnOtZig3/skeSByDZvdaYgENQ=;
  b=AJZh1MqHVLAcMAnNR57661VtrjC3qCLSnS1EjAzz3niAaVdBDPmDncsi
   N2SszAcT5guE1dKei16gOZsdOF4gF6jVEfIF+sRCnm6S8wihkHKsdl4we
   msY2wByOysZVaQJgs2D4yGtxvdlFl2zlePuTP2DpORcm0FS5myRRzn0Ij
   /Z6MF6EC3zxuAMXeVwASjoxX+MpiMRFKCtIsaPJ+anSiW8U2g2CONzaWb
   2xE/juyZvzj9pzx3jE7NpHA5PVK790J1fey4Eu03yrKDKlwErf//uESK3
   m7h/VrBsw4/Iax7YMBL6HVROpR9npx/6WkOvzPYiAGFg9XA0rvhVGh73S
   w==;
X-CSE-ConnectionGUID: fmRy5DbCSAOIVHhTGMokVw==
X-CSE-MsgGUID: hTwmsSZ4SS2j6ThgEXjMIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="90553107"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="90553107"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 08:05:32 -0700
X-CSE-ConnectionGUID: ZubOLAcJQhqTYqCKTBEK3A==
X-CSE-MsgGUID: xPndxVPHRNKa8/AOX4bL1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="269791002"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 18 May 2026 08:05:30 -0700
Date: Mon, 18 May 2026 22:42:00 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com, mdf@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 1/3] fpga: dfl: add bounds check in
 dfh_get_param_size()
Message-ID: <agslOI8ngOTuDFuS@yilunxu-OptiPlex-7050>
References: <20260512130710.933089-1-sebasjosue84@gmail.com>
 <20260512130710.933089-2-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512130710.933089-2-sebasjosue84@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249321-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yilun.xu@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 84D7756FAA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 12, 2026 at 07:07:08AM -0600, Sebastian Alba Vives wrote:
> dfh_get_param_size() can return a parameter size larger than the feature
> region because the loop bounds check is evaluated before incrementing
> size. If the EOP (End of Parameters) bit is set in the same iteration,
> the inflated size is returned without re-validation against max.
> 
> This can cause create_feature_instance() to call memcpy_fromio() with a
> size exceeding the ioremap'd region when a malicious FPGA device provides
> crafted DFHv1 parameter headers.
> 
> Add a bounds check after the size increment to ensure the accumulated
> size never exceeds the feature boundary.
> 
> Fixes: a80a4b2b2e4f ("fpga: dfl: add support for DFHv1")

No such commit. Please run checkpatch before posting.

