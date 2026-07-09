Return-Path: <stable+bounces-272966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nfDsOU6+T2q+ngIAu9opvQ
	(envelope-from <stable+bounces-272966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 17:29:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31158732E69
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 17:29:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fygo-io.20200929.dkim.larksuite.com header.s=s1 header.b=E54EpZ84;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=fygo.io (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272966-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272966-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9588A3045DDB
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 15:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB493672BE;
	Thu,  9 Jul 2026 15:16:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from va-2-57.ptr.blmpb.com (va-2-57.ptr.blmpb.com [209.127.231.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7083366831
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 15:16:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610208; cv=none; b=cTOOYAl8B09Fg+IcHSENt4Nfc7eRLD8ZUfZ2yAGyZBB7VZlN9AxbbMuA92P5Zub5l9ZpM3IDep9UcT5nsHqjdJYUWJTP+NXcKCCGuFtwQycdrxOjsfWob1CLBuUopQ9Uy9wLpFoQvzX5FToCnHzI/0lsYwbRwnxErAyqD3FJER4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610208; c=relaxed/simple;
	bh=v5Ns8GKJPYvWVGr4v4iYQQv2ZvitE5xVf/lTUKRkRlI=;
	h=Cc:Message-Id:Content-Type:Date:Mime-Version:References:Subject:
	 In-Reply-To:To:From:Content-Disposition; b=iSiIrUynMZWJMxiOHf5XY4NNYLRjWEBY6/adtZ2HRydpN8Ub8KVt2o5QM/W1arM9d203jLKdG/L+NHoHL0USY320lheJ/l9h/zQUSdrdlyLq1zuWxDDuWDlb3kSw96+PJMWnfRHk15MWKkyG/ok4Pus1jlBl9EIek3y7erBgBHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=E54EpZ84; arc=none smtp.client-ip=209.127.231.57
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1783610196;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=v5/1YTROofIQRbICB2AmBt3EuPPyhbngivzTeCwZ5O4=;
 b=E54EpZ846zjtDfIqG7tSc9jNphhTNWl5hA0Hrg8PU7NormqplylWjVNbXIpnc0M/NvY000
 yaaDxipxUvwuYqtbNls4X+bNvSAfk6iV3SlnTdQ/eNXO0RZ6+ZckZlqO8eJ6tqqi+h8Y+K
 dUPtOdgWE1ONTWsmPm+E+OafGuYackJUKYqygdEyU235w+yIbuvftXOSIq0lzKD+bpWG41
 5NZm5zFKWz0u8zOsFU95ggRHdHSU6lyRVjF5Tdli0Fx7vop09N+w4EUBSFqNW0aOr3ir/T
 /yYhSJitkgkE009l2QEQoUY9afCiI8YhdZlOBB3NCEg6YOmrqBXfNRGIIkuTjw==
Received: from studio.local ([120.245.64.95]) by smtp.larksuite.com with ESMTPS; Thu, 09 Jul 2026 15:16:34 +0000
Cc: <axboe@kernel.dk>, <gregkh@linuxfoundation.org>, 
	<linux-block@vger.kernel.org>, <stable@vger.kernel.org>, 
	"kernel test robot" <lkp@intel.com>
Message-Id: <ak-7HLuHJ-5vJvFN@studio.local>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Coly Li <colyli@fygo.io>
X-Lms-Return-Path: <lba+26a4fbb53+d90e7d+vger.kernel.org+colyli@fygo.io>
Date: Thu, 9 Jul 2026 23:16:32 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ak9CC591ivuQ4BP1@studio.local> <20260709131904.596684-1-adhikari.resume@gmail.com> <20260709131904.596684-2-adhikari.resume@gmail.com>
Subject: Re: [PATCH v6 1/2] badblocks: fix in-place round_up/round_down usage bug
In-Reply-To: <20260709131904.596684-2-adhikari.resume@gmail.com>
Content-Transfer-Encoding: 7bit
To: "Ramesh Adhikari" <adhikari.resume@gmail.com>
From: "Coly Li" <colyli@fygo.io>
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[fygo.io : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fygo-io.20200929.dkim.larksuite.com:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:gregkh@linuxfoundation.org,m:linux-block@vger.kernel.org,m:stable@vger.kernel.org,m:lkp@intel.com,m:adhikari.resume@gmail.com,m:adhikariresume@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-272966-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[colyli@fygo.io,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[colyli@fygo.io,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[fygo-io.20200929.dkim.larksuite.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fygo-io.20200929.dkim.larksuite.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,vger.kernel.org:from_smtp,studio.local:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31158732E69

On Thu, Jul 09, 2026 at 06:49:03PM +0800, Ramesh Adhikari wrote:
> rounddown() and roundup() do not modify their first argument in
> place; they return the rounded value. _badblocks_set(),
> _badblocks_clear() and badblocks_check() were calling them as
> bare statements and discarding the result, so 's' (and 'next'/
> 'target') were never actually rounded. Depending on the caller's
> alignment this can leave 'sectors' unchanged or, in the reported
> case, produce a range whose end never advances, causing
> _badblocks_check()/badblocks_check() to loop with a non-advancing
> cursor and stall the CPU (RCU stall) when called through the
> nvdimm ioctl path via nvdimm_clear_badblocks_region().
> 
> rounddown()/roundup() also do division/modulo on the sector_t
> (u64) operand, which requires libgcc helpers (__aeabi_uldivmod,
> __umoddi3) that are not linked into the kernel on 32-bit builds,
> breaking the build on arm/i386 (reported by kernel test robot).
> 
> Switch to round_down()/round_up() (include/linux/math.h), which
> are mask-based, assign their result back to the variable being
> rounded, and require no 64-bit division, fixing both the
> non-rounding bug and the 32-bit build breakage.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604301231.IpPh4AiH-lkp@intel.com/
> Fixes: aa511ff8218b ("badblocks: switch to the improved badblock handling code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>

It looks good to me.

Reviewed-by: Coly Li <colyli@fygo.io>

Thanks.

Coly Li

> ---
>  block/badblocks.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/block/badblocks.c b/block/badblocks.c
> index ece64e76fe8..1f786b193fb 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -857,8 +857,8 @@ static bool _badblocks_set(struct badblocks *bb, sector_t s, sector_t sectors,
>  		/* round the start down, and the end up */
>  		sector_t next = s + sectors;
>  
> -		rounddown(s, 1 << bb->shift);
> -		roundup(next, 1 << bb->shift);
> +		s = round_down(s, 1 << bb->shift);
> +		next = round_up(next, 1 << bb->shift);
>  		sectors = next - s;
>  	}
>  
> @@ -1071,8 +1071,8 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
>  		 * isn't than to think a block is not bad when it is.
>  		 */
>  		target = s + sectors;
> -		roundup(s, 1 << bb->shift);
> -		rounddown(target, 1 << bb->shift);
> +		s = round_up(s, 1 << bb->shift);
> +		target = round_down(target, 1 << bb->shift);
>  		sectors = target - s;
>  	}
>  
> @@ -1307,8 +1307,8 @@ int badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
>  		/* round the start down, and the end up */
>  		sector_t target = s + sectors;
>  
> -		rounddown(s, 1 << bb->shift);
> -		roundup(target, 1 << bb->shift);
> +		s = round_down(s, 1 << bb->shift);
> +		target = round_up(target, 1 << bb->shift);
>  		sectors = target - s;
>  	}
>  
> -- 
> 2.43.0

