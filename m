Return-Path: <stable+bounces-217658-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sbQfNW1immmAbAMAu9opvQ
	(envelope-from <stable+bounces-217658-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 02:57:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD9F16E665
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 02:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2061D301E216
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 01:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E4D13AA2D;
	Sun, 22 Feb 2026 01:56:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A55629CEB
	for <stable@vger.kernel.org>; Sun, 22 Feb 2026 01:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771725416; cv=none; b=Zw+SWmSXsBV27zziv9hSmJqA7KXVP0IhPNn4GcIqI4t3vFbzcxLNLl29fBIcHlAhk45FMx/IEktT8q10lmmy8+G00zPhRNsVxeOsLqksLEpKZj20oJ0RcTJ5Fdorh/Sqv/EFcJ2SwtyRWvhRItTpCrvBtsGMs2uacO+Kl0SkVBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771725416; c=relaxed/simple;
	bh=sDob0OHQiSgBi9ePTJ0dEvxui0e0P7DyrN0ON86TLi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZretbDmMDPiqHn/pDvH4xnOwntdlhSqJKp0ZvcUNE6ifTsGvjLyLNA0R2tXG2CIP0G5QCCeT/9+uB62NynQcAn45qOyQkyhCIak9eglxMfnqCVX6g6AsWlvJwQdRK9y5WXGWxnONBsUJZC5eSyV5Ua9es7m461I3PUBOrKbyYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 22 Feb 2026 10:41:50 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Sun, 22 Feb 2026 10:41:50 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Chris Mason <clm@meta.com>
Cc: akpm@linux-foundation.org, stable@kernel.org, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/swapfile: fix list iteration when next node is
 removed during discard
Message-ID: <aZpe3kD/xmz87zYH@yjaykim-PowerEdge-T330>
References: <20251127100303.783198-2-youngjun.park@lge.com>
 <20260220151338.3234934-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220151338.3234934-1-clm@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217658-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,huaweicloud.com,gmail.com,redhat.com,kvack.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: 1FD9F16E665
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 07:13:33AM -0800, Chris Mason wrote:
> On Thu, 27 Nov 2025 19:03:02 +0900 Youngjun Park <youngjun.park@lge.com> wrote:
> 
> > When the next node is removed from the plist (e.g. by swapoff),
> > plist_del() makes the node point to itself, causing the iteration to
> > loop on the same entry indefinitely.
> > 
> > Add a plist_node_empty() check to detect this case and restart
> > iteration, allowing swap_sync_discard() to continue processing
> > remaining swap devices that still have pending discard entries.
> > 
> > Additionally, switch from swap_avail_lock/swap_avail_head to
> > swap_lock/swap_active_head so that iteration is only affected by
> > swapoff operations rather than frequent availability changes,
> > reducing exceptional condition checks and lock contention.
> > 
> > Fixes: 686ea517f471 ("mm, swap: do not perform synchronous discard during allocation")
> > Suggested-by: Kairui Song <kasong@tencent.com>
> > Acked-by: Kairui Song <kasong@tencent.com>
> > Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> >
> 
> Hi everyone,
> 
> This fix landed upstream in v6.19-rc1:
> 
> commit f9e82f99b3771eef396dbf97e0f3c76e20af60dd
> Author: Youngjun Park <youngjun.park@lge.com>
> Date:   Thu Nov 27 19:03:02 2025 +0900
> Subject: mm/swapfile: fix list iteration when next node is removed during discard
> 
> Looks like the commit being fixed is actually:
> 
> commit 9fb749cd15078c7bdc46e5d45c37493f83323e33
> Author: Kairui Song <kasong@tencent.com>
> Date:   Fri Oct 24 02:34:11 2025 +0800
> Subject: mm, swap: do not perform synchronous discard during allocation
> 
> v6.18.y stable has Kairui Song's commit, but this fix hasn't made it to stable.
> Johannes noticed the Fixes: tag doesn't match, which probably explains
> the gap, but I think we should pull this fix (f9e82f99b) in.

+Cc: stable@vger.kernel.org
Thanks for catching this and pushing for the stable backport.

Acked-by: Youngjun Park youngjun.park@lge.com

