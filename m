Return-Path: <stable+bounces-240443-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ad+dAovf6WlemQIAu9opvQ
	(envelope-from <stable+bounces-240443-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 10:59:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5215544EE7A
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 10:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4727430B44B8
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 08:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136BB2F2914;
	Thu, 23 Apr 2026 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sf8CpHoa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAB43DEFE1
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776934643; cv=none; b=gHHBxvbm9o3OQPKrNKf2GY10R+xoUNZ5zBAFpkdadgeqvN8Qyw22BXd787JD9EfJcSSIUgkAoqU798Mh5UqdTUNsNTWwkadOVFTNwax0tisC1vkYCFr76HvlShntOgj60BNzm1DWclTKIgYhL9TU4iXaPjad4PxNMxGafPesNKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776934643; c=relaxed/simple;
	bh=s/mVlPzEebqAesHz/sLkbRMTIWafF4uV9ydlEIHsbbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5x/md4DshriPc4oKyC1G4Uzl2UgYSovuGliU0w0TQaOuWvbcB3npj5Fwsn2OKullqjn4tAmRp5Xd14uovhR6VscVPbJKYz1/Rcs8MQqpuuWUHtknfByxmY7hnR6vIrJm0SwH91GQH8HGbFoCOnQtiGbcA87/AcXu7LjykxBZJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sf8CpHoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C43CC2BCB2;
	Thu, 23 Apr 2026 08:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776934643;
	bh=s/mVlPzEebqAesHz/sLkbRMTIWafF4uV9ydlEIHsbbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sf8CpHoaL+a5k2dVuN2jmMb04nqrchsuw4gl2y9GI9Prs+cYCZ5u/yS5uyQpSegPN
	 wq80DQQ+wLnarznDUipCT/44ZhZ9ZTGIDFQAqTrb38vshI8JW2KZjBPxq7wBhSgg3i
	 yvqaBJruKbq9kM9IHMsFtJFVW5X0sVrYN+lHPQTM=
Date: Thu, 23 Apr 2026 10:57:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: stable@vger.kernel.org,
	Google Big Sleep <big-sleep-vuln-reports+bigsleep-501448199@google.com>,
	Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y] mm: call ->free_folio() directly in
 folio_unmap_invalidate()
Message-ID: <2026042345-t-shirt-december-6836@gregkh>
References: <2026042002-idealness-evade-7213@gregkh>
 <20260420145343.2046992-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420145343.2046992-1-willy@infradead.org>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240443-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,bigsleep-501448199];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email,infradead.org:email,suse.cz:email]
X-Rspamd-Queue-Id: 5215544EE7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 03:53:43PM +0100, Matthew Wilcox (Oracle) wrote:
> We can only call filemap_free_folio() if we have a reference to (or hold a
> lock on) the mapping.  Otherwise, we've already removed the folio from the
> mapping so it no longer pins the mapping and the mapping can be removed,
> causing a use-after-free when accessing mapping->a_ops.
> 
> Follow the same pattern as __remove_mapping() and load the free_folio
> function pointer before dropping the lock on the mapping.  That lets us
> make filemap_free_folio() static as this was the only caller outside
> filemap.c.
> 
> Link: https://lore.kernel.org/20260413184314.3419945-1-willy@infradead.org
> Fixes: fb7d3bc41493 ("mm/filemap: drop streaming/uncached pages when writeback completes")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reported-by: Google Big Sleep <big-sleep-vuln-reports+bigsleep-501448199@google.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Jan Kara <jack@suse.cz>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 615d9bb2ccad42f9e21d837431e401db2e471195)
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/filemap.c  | 3 ++-
>  mm/internal.h | 1 -
>  mm/truncate.c | 6 +++++-
>  3 files changed, 7 insertions(+), 3 deletions(-)

This is odd, it's applying with a ton of fuzz, which puts things in the
wrong functions and breaks the build.  Let me go fix it up by hand...

thanks,

greg k-h

