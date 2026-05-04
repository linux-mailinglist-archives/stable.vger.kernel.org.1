Return-Path: <stable+bounces-242994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLySAkR9+GkowAIAu9opvQ
	(envelope-from <stable+bounces-242994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 13:04:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0B54BC1EA
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 13:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6E023000FDC
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 11:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028CF34252C;
	Mon,  4 May 2026 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="bJQ3kJ7V"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69163282F2F
	for <stable@vger.kernel.org>; Mon,  4 May 2026 11:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777892671; cv=none; b=a7L5+DK7wDg/axpvXs+XQvGr3a9hIz23Swc9AFiSuyYFadj41h062JSHitcse4s48Q9xHDUkA72KHrh964gijpIA+xvSnKZ/mSvRTRWHK0Pos0FyeTuxY4BCv08nNUhRjnpxJGBXy5+Qi95pKJSE4mGyI7WiSv/t8J00nPN9eWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777892671; c=relaxed/simple;
	bh=NuMnsEx05zTkNGPdasILZG8OUxOoj/TqwGIHmYfOMmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyg8/rB/FP/zBlWt5zblSnFNSd/jHHt3fbRP2FyFvuBMZw88qiQIKqQ+HA6VqYkTqlDSKHaoc4bugDigPctQ/RxbGkw9n90YcUkUBoVn/ohxguJqY32v3g3YPCUBIoF6ljy3eAbZxe8FQfauRAg4Dfi0TTUx+C/RStLqSl2kGyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=bJQ3kJ7V; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-479dd56d016so2837024b6e.3
        for <stable@vger.kernel.org>; Mon, 04 May 2026 04:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1777892669; x=1778497469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PRnb/bhB3D3z/t38ecaZJvaJJYF+Nhcsm1blqILnUM=;
        b=bJQ3kJ7V9Xd9dQsS+jKiD0NwStwvXZEOsvWlo7+9dvxE3LXO0WHncgvaENqxXPzOi/
         Nw4za3OyJ2D7jIb62/hbULx91H97SBY6cdN0WMrv2MthA/GmZzkFgazjnP49LILOkBUd
         RkT4to407DD0qF1F4OMwRwgZmk24vVULAXUFGu6eXyh+jBVJ02M7sG8k3NPEQxPzm/LJ
         04p5cF4ZgK4x+r/BSCRYhqCk/KgI8/TGQqAxI54zWsDROEYewJ3WzPDvUWn83jdXyVe7
         Fq2vdJrI9LPqDCc3WYOvWsVFXiD0WgmgcZrQQLao1an1ltd2cb17KJ11BDHYgO4DPH9M
         wSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777892669; x=1778497469;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/PRnb/bhB3D3z/t38ecaZJvaJJYF+Nhcsm1blqILnUM=;
        b=WrjWhZpB+HaxrMzqgZM/LKHy952WY8lC0YDHN9RUOwHssLkgScc41pVth9hPVdFuRj
         gPH9xxPbQ+spouhmxWbuAi/87LENYQyZTl6u4HwAHvtX/AG+24Fqcyiv4kt5/VaXlLpv
         sHMI7l/IqFl9Gbc7tsuOFf1plsaoIjrZcreQ6u3JQB2KcVpDi96zw43rZTMlmQydLecP
         C29V6cYLyVbOL0EWJlKR3sn3/9+W7xTyFRltjCvdr6kdKdF+cBgt0yw/yPx1Fmc1qNui
         gszNWUflBy4Z7rvQyy5qeTIP+lyi0RSEBpbg1M79gIoreLucWWRfPtMJbiWqYNIFfuED
         U0Dw==
X-Forwarded-Encrypted: i=1; AFNElJ9m2EU8xjAxtGslOWTwD04qCJOG4oqU0SPiZxRojoDskc8bcoREbdaMAeFQBKqquPlcUy2YrrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKvKi9/aPJlE77ZorX6rNqxEqggrlEahSCDoT+LWqv8r/z/qx3
	Sumj+SCRadeK9nG5o8/1/FlB4q8nUkc8tSUjkBASbDEoCNjXVGTMV3i+SH63DioZlGI=
X-Gm-Gg: AeBDiesM/JU8McFEDesje84rj0IfXqFQTfl8HZSdnAaUHVOIMzZhiaAJeFSufGkNxYW
	hxiqPlHwCs6V9xho4/UV0Zo818h0GvWkuy0OyyfiDy94+B1amB5dfcsRGMusH6SfNwaPIZEFVe/
	JBa4iZC5f0uC3ut8DfsU4aYCn42TyhtyzqVauL7Y891sCc4kCwXUzXNgOYf8gbNdFi0F69rgLxu
	qABAglI4gtrlcnUH+Ku8B3H4tttLNgznH3kIH4Evn/Uzd4LfvZA5lpQCo0KQ3XLTJ2r4idA36wa
	cAmruSV+csURO1bDrkGzybIjbFzMDmFq7heuTmIQYkkXMnByM4MgkxOGngVgFiccPoGPG4OPQG5
	t1NcJT0ZAznFwO1gL18lmgyQuotBL0z5Psyc+waVV79lnB2waKnsPJGssN5DCVqx8C1k4GMYE2J
	fHI9UTEKduPBFkQhX9r1aNcwO2l0/Q+c8ekF8g+g9Lu+Vu8oEquqiH5xYcLhg77XLgA3eoWYNyJ
	bvlSSjoa7dVq1zBvm+8zLnaMw==
X-Received: by 2002:a05:6808:6f91:b0:467:4fb:f225 with SMTP id 5614622812f47-47c88e8014bmr4492254b6e.9.1777892669327;
        Mon, 04 May 2026 04:04:29 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:3eb5:240d:3d5f:b840])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76936220sm6465297b6e.10.2026.05.04.04.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 04:04:27 -0700 (PDT)
Date: Mon, 4 May 2026 06:04:21 -0500
From: Corey Minyard <corey@minyard.net>
To: Sasha Levin <sashal@kernel.org>
Cc: Corey Minyard <cminyard@mvista.com>, stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y/6.6.y/6.1.y/5.15.y/5.10.y 1-2/2] ipmi:ssif:
 shutdown race + kthread cleanup
Message-ID: <afh9NZx68FLcSxra@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20260501135649.672621-1-corey@minyard.net>
 <20260501140658.707484-1-corey@minyard.net>
 <20260501141953.781781-1-corey@minyard.net>
 <20260501142717.840671-1-corey@minyard.net>
 <20260501145427.900030-1-corey@minyard.net>
 <20260501161407.1106914-1-corey@minyard.net>
 <20260501162131.1165570-1-corey@minyard.net>
 <20260503143410.item009-ipmi-ssif-combined@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503143410.item009-ipmi-ssif-combined@kernel.org>
X-Rspamd-Queue-Id: 9E0B54BC1EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-242994-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[corey@minyard.net];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,minyard.net:email,minyard.net:dkim,minyard.net:replyto]

On Sun, May 03, 2026 at 02:19:56PM -0400, Sasha Levin wrote:
> Hi Corey,
> 
> I queued the 2-patch series across 6.12.y / 6.6.y / 6.1.y / 5.15.y /
> 5.10.y but had to drop them all again before pushing to stable-queue.
> 
> Patch 2/2 (cherry-pick of upstream 75c486cb1bca, "ipmi:ssif: Clean up
> kthread on errors") has a real bug in upstream itself: in ssif_probe()'s
> out: label,
> 
> 	if (ssif_info->thread)
> 		kthread_stop(ssif_info->thread);
> 
> runs even when kthread_run() failed, in which case ssif_info->thread is
> an ERR_PTR rather than NULL, so kthread_stop() ends up being called on
> an error pointer. The check needs to be IS_ERR_OR_NULL(), or
> ssif_info->thread needs to be reset to NULL on the kthread_run() error
> path before goto out.
> 
> The same upstream bug propagates to all five LTS submissions, so I had
> to drop them all rather than just the older trees. Could you send a
> fixed version (an upstream follow-up that flips through the LTS trees
> would be ideal)?

There is already a fix for this queued in the next tree that I was about
to submit.  Fixing it here would add to the confusion.

> 
> For 5.15 and 5.10 specifically, I'd also like to fold in your standalone
> "ipmi:ssif: Fix a thread shutdown issue" follow-up
> (<20260501161407.1106914-1-corey@minyard.net> for 5.15,
> <20260501162131.1165570-1-corey@minyard.net> for 5.10) when you resend.
> Those branches lack the kthread_stop ERESTARTSYS behaviour that 6.1+
> has, and your follow-up addresses exactly that. A 3-patch series for
> 5.15/5.10 (plus the 2-patch series for 6.12/6.6/6.1) with the ERR_PTR
> fix folded in would let me requeue the whole set in one pass.

Ok, I'll fold that in to 5.10 and 5.15 as you request, that makes sense.

Can you add the 6.1/6.6/6.12 ones as they are and I'll submit the queue
to fix I have to Linus?

-corey

> 
> --
> Thanks,
> Sasha

