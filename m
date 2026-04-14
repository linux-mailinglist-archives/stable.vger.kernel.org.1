Return-Path: <stable+bounces-237765-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHlQOF4B3mkRmAkAu9opvQ
	(envelope-from <stable+bounces-237765-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:57:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 828463F7910
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D18B2300A320
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 08:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8F43B774F;
	Tue, 14 Apr 2026 08:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgOkcyWG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B9935DA4F
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157020; cv=none; b=SRp1CbLz0GPtvvEOms40VV0x6ZZpgsZCEutKlYYKxREGK+79g2t8+AcScle/b7wLarbO1SntXmFFKK6FfBb93K9q0f3N3RLTEZio/kDFn12kbRBEwc+xRqQamEXdGNA90K1ajx5aun6t/se6rU6WFN1OTMscjAi7C4l2FxK0ZcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157020; c=relaxed/simple;
	bh=IAYEMAAcDhJXEJZiFeEzud0D4z3cUhDlsTxVv63RHhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFwKuZ2vzY+cP1sPt9DOUJgIgAO4gQAr0nhxAk4ldYck+WkcQjj4+9j1PAJj/kPc8XAHZTRdPJJrdfy/hJzSjd6W1E2lpvx2qN//e9TCittYCoHNjJmvGI+AMcuXJfVuWo4LoNCbbXV3d5ePCugIHkYzyEZbQtce0StbBcB5z2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cgOkcyWG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776157019; x=1807693019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IAYEMAAcDhJXEJZiFeEzud0D4z3cUhDlsTxVv63RHhg=;
  b=cgOkcyWGN2Y19B6sTAachqJgoyqKihJ3dNDyLIpI2VX3743xUX4kBvr8
   MEZuuj6saP2x0WvvkE2o6q/Ngt0ePsifTgFg04ih3FmH/Osh+nMFs/1yN
   arvAzIVuWfHws6EShUkci+paelE1LvyL4cJttFkZXlHKVB3//ta8mi28g
   sI8IQ+WKAEFjVlvakhRxs1CPe133pNsXcBB0sQAHuyQmoxjfFXGq4mJia
   MQGAMQESSacDoReWYQAb0ACnu0EShmAKGz+iioSqd0bTaW03eurid3pEX
   MvTaWtYesGI2iU2vcnq3suJXAub0GLZsGxU9Z30dqJCWG25vSKBquv9d6
   Q==;
X-CSE-ConnectionGUID: WhiNtj/bTJiZQHo28HEPmw==
X-CSE-MsgGUID: XdBRt3GOT0esaQMnd1VOWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="76272285"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="76272285"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 01:56:58 -0700
X-CSE-ConnectionGUID: rMdBiQpFRCmhi2e/Bublhg==
X-CSE-MsgGUID: WsDy3yaAQ4CMyzUPFCiy4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="260461845"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 01:56:55 -0700
Date: Tue, 14 Apr 2026 10:56:52 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Jouni =?iso-8859-15?Q?H=F6gander?= <jouni.hogander@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] drm/i915/psr: Init variable to avoid early exit from et
 alignment loop
Message-ID: <ad4BVIxoxQXS5lFt@ashyti-mobl2.lan>
References: <20260413112345.88853-1-jouni.hogander@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413112345.88853-1-jouni.hogander@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237765-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andi.shyti@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ashyti-mobl2.lan:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 828463F7910
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jouni,

On Mon, Apr 13, 2026 at 02:23:45PM +0300, Jouni Högander wrote:
> Uninitialized boolean variable may cause unwanted exit from et alignment
> loop. Fix this by initializing it as false.
> 
> Fixes: 681e12440d8b ("drm/i915/psr: Repeat Selective Update area alignment")
> Cc: <stable@vger.kernel.org> # v6.9+
> Signed-off-by: Jouni Högander <jouni.hogander@intel.com>

Reported-by: Dan Carpenter <error27@gmail.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi

