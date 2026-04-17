Return-Path: <stable+bounces-238484-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ88Kq4s4ml22gAAu9opvQ
	(envelope-from <stable+bounces-238484-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 14:50:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F221B41B534
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 14:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 858C630AB32B
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 12:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A572B39C00E;
	Fri, 17 Apr 2026 12:46:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4613603DB;
	Fri, 17 Apr 2026 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776429964; cv=none; b=UGvbGXdin9AXkGaI/GFzZTZsjvdW8zq7RxQ0yBT8PpeLYtbyjV+E1YXWf6cG3kib4oRmPR/wEAhRjONLP/XZlXA5XXc1dwyi4MwPYmqg/BcPYPQFZuLB9O4Ny5ZltbEGDVE9XPL/MjiXZVrYyMOHQXnJY1hVU6DSu+kFRv0WSvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776429964; c=relaxed/simple;
	bh=oBQ6wgddlC5wjnSYNdFLni+25iwY2tcuuIozOYsNtjc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k733sxR4Yg/i7IUnAlh4wjmXH2ewq8gNIruYe8C707PP0IeO/aRK/QoetS92PS3Nbz/WKR7B8dD5Lm87cidpy+jzga+r2IqLd+fHlLnkhvV+i1aVdA75jVywuFipyggVsG+D+X9mdsUXVd96/VhXf12X6rCKf+XUspwsZi/pjjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fxvjY3p38zJ46Cf;
	Fri, 17 Apr 2026 20:45:05 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id EC77240577;
	Fri, 17 Apr 2026 20:45:51 +0800 (CST)
Received: from localhost (10.203.86.132) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Apr
 2026 13:45:51 +0100
Date: Fri, 17 Apr 2026 13:45:50 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
CC: "yangyicong@hisilicon.com" <yangyicong@hisilicon.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "yangyccccc@gmail.com"
	<yangyccccc@gmail.com>, Sanman Pradhan <psanman@juniper.net>, Sizhe Liu
	<liusizhe5@huawei.com>
Subject: Re: [PATCH v2 0/2] hwtracing: hisi_ptt: Fix reset timeout handling
 and clean up trace start
Message-ID: <20260417134550.0000027c@huawei.com>
In-Reply-To: <20260414172451.14331-1-sanman.pradhan@hpe.com>
References: <20260414172451.14331-1-sanman.pradhan@hpe.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[hisilicon.com,linux.intel.com,vger.kernel.org,gmail.com,juniper.net,huawei.com];
	TAGGED_FROM(0.00)[bounces-238484-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hpe.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:mid,juniper.net:email]
X-Rspamd-Queue-Id: F221B41B534
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 17:25:03 +0000
"Pradhan, Sanman" <sanman.pradhan@hpe.com> wrote:

> From: Sanman Pradhan <psanman@juniper.net>
+CC Sizhe Liu

> 
> Patch 1: Propagate the DMA reset timeout error from
>   hisi_ptt_wait_dma_reset_done() instead of discarding it. De-assert
>   the reset bit and log an error on timeout. Move ctrl->started to the
>   successful path so a failed start does not leave the trace marked as
>   active.
> 
> Patch 2: Remove the unnecessary 16 MiB memset of trace buffers in
>   hisi_ptt_trace_start(). The driver only copies data that hardware has
>   written, so the zeroing is not needed.
> 
> Changes since v1:
>   - Patch 1: Return bool from hisi_ptt_wait_dma_reset_done() for
>     consistency with the other wait helpers
>   - Patch 1: Add pci_err() on timeout
>   - Patch 1: De-assert RST before returning on timeout
>   - Patch 1: Move ctrl->started to the successful path
>   - Dropped "Use the passed buffer index in hisi_ptt_update_aux()" patch
>   - Patch 2 is unchanged
> 
> Sanman Pradhan (2):
>   hwtracing: hisi_ptt: Propagate DMA reset timeout in trace_start()
>   hwtracing: hisi_ptt: Remove unnecessary trace buffer zeroing in
>     trace_start()
> 
>  drivers/hwtracing/ptt/hisi_ptt.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 


