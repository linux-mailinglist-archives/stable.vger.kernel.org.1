Return-Path: <stable+bounces-249196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOqGGLW3CmoB6QQAu9opvQ
	(envelope-from <stable+bounces-249196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 08:54:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC38567007
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 08:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9C8E3008D1F
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 06:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949AB3DDDA8;
	Mon, 18 May 2026 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZyZtz00e"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D3F3D2FE6;
	Mon, 18 May 2026 06:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779087276; cv=none; b=s6SbuD8sn3UWc0rpX7atn9yeOUvWVeX8eKvwsQWMYjQk/YmXH3UoJ6/kmzGxCPVkErPSjzN0RaN3WmxucZ/tlosXhljNi4CdlewZBuUE8QLEE3Eky0TYbrSE0q7N6xAC2sEeYMcWIVqlDehns3LaXDd1CHDvSKFiZtHWbD9kxHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779087276; c=relaxed/simple;
	bh=rdAsuZiCvxcZ09Bt2zGiIGc5NHi+s+JTOV0rMqAvE3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIqKx3faCUGENO0rjAzZBhX3hjefavnD6OqG7fGDxOqEgVjuLUYQkFfsCNRbZTUTM0GBAICYdzxjUxVkB/uYJF8eGgsuMgIfu9hDjYKqU8sIlY9NoqsdDMHe9wyZXWI8wP5aXnOtpN+/h+7BSthqZqVGWJx2gFaEyPw+KMUHbdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZyZtz00e; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779087275; x=1810623275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rdAsuZiCvxcZ09Bt2zGiIGc5NHi+s+JTOV0rMqAvE3Y=;
  b=ZyZtz00eIa8EaUpI3IqYxRgpxu/dF/irJ8yEBK3uiMvMMgLgoZRNdb7C
   PqnK/4nTF9/FrpJDV1iCZOsf0MlpeMU1xG/ubvN5/f8m9lFfZqu2jt+GC
   nKgKobh9soJtuMnnRiNwebYlepPjk0S1AnYABTlafl0dmrWxaDI34sl2F
   9COpL6LMnnz2ofcAH4m3G+Pinq5xcuGzWgk/LtcbxBWLQ3sDaPiTe5HNb
   hzmXEj6BpQ8U5kQwt2s/yJK7BlR06QljGgjgTE16Oaqx8DgXsQ21KFnKy
   q8YXSmBVmC6+c1DjQj9+pXwGcp7M2Zju3vhImZQkW07hw1YbQUAWmLqvH
   w==;
X-CSE-ConnectionGUID: +4mzePgtR6CU2AhDwtPBbw==
X-CSE-MsgGUID: fYezIeiIQQK2NzJFIYmbRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79963598"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79963598"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 23:54:33 -0700
X-CSE-ConnectionGUID: iqKnlqrOR1mqllmcOFmG8A==
X-CSE-MsgGUID: oP+gx5PkRKCItoQBSV0/Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="239205359"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 23:54:31 -0700
Date: Mon, 18 May 2026 09:54:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: mazziesaccount@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: rohm-bm1390: notify trigger on all error
 paths
Message-ID: <agq3pIpiWm-0fqFa@ashevche-desk.local>
References: <20260517160801.269-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517160801.269-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: BCC38567007
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,baylibre.com,analog.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-249196-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Action: no action

On Sun, May 17, 2026 at 09:08:01PM +0500, Stepan Ionichev wrote:
> bm1390_trigger_handler() has three error returns:

...

> +	irqreturn_t result = IRQ_HANDLED;

Make result boolean and use IRQ_RETVAL() macro once.

-- 
With Best Regards,
Andy Shevchenko



