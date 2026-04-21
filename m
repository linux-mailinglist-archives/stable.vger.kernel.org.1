Return-Path: <stable+bounces-240020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBblI1DZ5mmE1QEAu9opvQ
	(envelope-from <stable+bounces-240020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 03:56:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F086B435599
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 03:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FB1A30055AB
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 01:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E12231836;
	Tue, 21 Apr 2026 01:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="ms9zEKdh"
X-Original-To: stable@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A98D3D76;
	Tue, 21 Apr 2026 01:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776736588; cv=none; b=sLjgdEYao7ZpFjilZcXlEy8f9QFf6ntIxmgItCCiz0Ve32Ygnm3BwR42R6Lva7/CukJsGPQNvDOoglGmbD6sqefF8yDjn4FeZYPSSUxmOZ1xLt207mUrSvD0qZNbF2GkWVivEetlKdJnriZGOciMWttRvUNAsSuzqgNk8vN55TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776736588; c=relaxed/simple;
	bh=nLQHXtixbiiCSFHDVuEFUufqLl0TgEWa4Uvmy0A5jrc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGW+BZhr1VOQruQqN+v+koN84gBkoiaoLzdEpTXCPYVgnVVXvAt1KY331O9/lxXGI4ApieZ1MxxxwF+ShKuqZj9VUItBRDumPAe2c2UE4Qm1JhC7wnbcThmEFjAZJOgTrGHJckbS9nRsMl5HtMkwdZcMOr5cSjBeV8yeMAK5NGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=ms9zEKdh; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1776736583;
	bh=346+yF1poLqwHVsI0ue/vA6Zm2woM6F3tsa06yU27bQ=; l=954;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=ms9zEKdhmdDKdE150qdg0mKO+qszSl3fO9OXHj7gIx7+NqE9bkIPLoxlBcHl0E2h1
	 3rUzblBjoCyQI4v9QaMcftexMZOJ7Gg3n85YzhGl9UxBZaO2N0ZFVPHMCNusHamHCJ
	 IyQfAd4ikIlWSVTXC0DSsFCAfPxJR896b60FOyw3eAA7tMDaUlAS0fvn9PfBTk4FYi
	 lvtdP4bBANpG5uCvUcyFjvF80DUiOcRmXi1SnBqc0Rzm1CsC/cWiT3mz2WornzyuMN
	 NidZsFgaNVCJZa96lGSv2bvIIFeI3VA71jPMLS0eor55VecTWSqlCVF7IEjf1AOyrj
	 z3TfuUC7jMTFg==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(1227023:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 21 Apr 2026 09:56:07 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Tue, 21 Apr
 2026 09:56:07 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Tue, 21 Apr 2026 09:56:07 +0800
Date: Tue, 21 Apr 2026 09:56:07 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, Nuno =?iso-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Kevin Tung
	<kevin.tung.openbmc@gmail.com>, Lucas Tsai <lucas_tsai@richtek.com>,
	<kevin.tung@quantatw.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: rtq6056: Fix the manual device instantiation
 via sysfs
Message-ID: <aebZN39+vev78GHD@git-send.richtek.com>
References: <db4f5ded64ca7d2e56abfa30c6a174342c44fabb.1776735120.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <db4f5ded64ca7d2e56abfa30c6a174342c44fabb.1776735120.git.cy_huang@richtek.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[richtek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[richtek.com:s=richtek];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[baylibre.com,analog.com,kernel.org,gmail.com,richtek.com,quantatw.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[richtek.com:+];
	TAGGED_FROM(0.00)[bounces-240020-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cy_huang@richtek.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[richtek.com:dkim,richtek.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F086B435599
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 09:41:17AM +0800, cy_huang@richtek.com wrote:
> From: Kevin Tung <kevin.tung.openbmc@gmail.com>
> 
> Add i2c_device_id to support sysfs manual device instantiation.
> 
> Fixes: 89a1034cd841 ("iio: adc: rtq6056: Add support for the whole RTQ6056 family")
> Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Cc: <stable@vger.kernel.org>
> ---
> Hi, Jonathan:
> 
> For some BSP limit, still some user instantiate rtq6056 deivce via sysfs.
> Therefore, add old style i2c id to make it compatible for this kind of usage.
> 
> BR,
> ChiYuan.
Hi,

Please ignore this patch. I have seen Kevin submit the patch in the
following link.
https://lore.kernel.org/lkml/20260420-rtq6056_support_sysfs_instantiation-v1-1-483ccee27b63@gmail.com/
> ---
>  drivers/iio/adc/rtq6056.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> -- 
> 2.34.1
> 

