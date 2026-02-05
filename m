Return-Path: <stable+bounces-214538-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOpgDNfYhGlo5gMAu9opvQ
	(envelope-from <stable+bounces-214538-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 18:52:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A00F0F6348
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 18:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 988D5304B81D
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 17:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBC719E968;
	Thu,  5 Feb 2026 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="gJpSwzkM"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B90F2FFDE3
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313815; cv=none; b=gAi65XegZDc5Bb5qmqqH84LDLXC0Qtdy/oLVudOHaYQgZw2dvSUQGCTaHjQyPF2yO9E9HintjXsq7/Yt+TYQyzEVAeKOInY1Cdp36rm8lrV8o2J+kSezprBgR3h2e2N1c2tNVGO0GeOikoIcIXR8IZX73oI79f171zb3565dQTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313815; c=relaxed/simple;
	bh=mT8AJsb/ccUqXLXAYLLeknnTpxiuw+yqEuK1mfFGHa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqwu1M2Yr+HDn9BiCkXuIY5iP1C0wqMvTkv91qWZwe2bJY2d3AVQpMmXRX+9f+It25gOpxCsePavsbx7UQpQEp9CH5+qweHp9lFCO/lSbS0VyeQR7d+Z4ZlI7vUm+1pYUrS1FRLF+4MKb42OzigZ4YypQtm1t7hdXLhOPZoYGRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=gJpSwzkM; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d18a9d2b1aso996823a34.2
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 09:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1770313814; x=1770918614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xG5JhUoaexE0C64Mm8Uw5KiIGD8Iz9i2gDDX0Fbs0Lo=;
        b=gJpSwzkMX748Yh5CK2je3LqSJ6kTRzHOrz5eFTImHJD8bdMfR1CvM3j7o0G+BLYXZg
         +SEGS6ZznGYUnlHSrTzb+g5KHIPCG8cF+oJ1MI28nd2fNY4KcGXxP5RcSIRnvGliLmwD
         /WsWg2HlGDBybfApVak8IFK7oa8cB86m1keSgSyRpB+caPa1QIIkjlMLeKWGwl7SCkuu
         6G46FPj//JH1VRJNnPzYi4IDHJurhX1FSi+SdxeZ2UqXKxjWecy5dRetXu5I+ya3ssIO
         68XKK7UHVHduAnDuAwrsWJkzqVKFDo/PfCWL1tVkRILJ1tTYerp4gKN9E2RTpSHjtizF
         xbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770313814; x=1770918614;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xG5JhUoaexE0C64Mm8Uw5KiIGD8Iz9i2gDDX0Fbs0Lo=;
        b=s7ylJbbA08pAkqF5hL7jvKOsInPWLIBxQVMiyljOhaNWWpVmoP+WFmXlVnUY2bd39l
         vlMozCi15dwoY40Hj4XYfBQZULbR1b3ejkITb1YtY5ZJcdrF+5SPMZ8rqp2pP7qX9YfO
         AUTpNuZUefT9x6x24mDiUF5e+oLZL5fyvoudz0Nwbw3GGYOxYMJ4HhaSFOL/RQbTOzvq
         CQuz86v/5u7KqGPxOq1v7J7nkSVSP4abq9yEOvG/9H+wohMvevsmyqbxPH/nnRzVgrTD
         4KzR1hsaEbanBGuQIRbsSH1q2BuGNYziSy8ahCM2h/f7lmI534poRL9tXh7sOA++XSFq
         PXiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9wcZXiNLyhbsHe/adMc8szEct5pNVUtSl11Cn8uSSmpjppceV1rpc9j541olKQdnCerGwNs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdxFJAT/P3WIm2K5F0GstRtF5BEX885DQODz2lS3dwewSLy3vC
	T9vhHVR7XhA6uPUJKOZh3kvyJusNCmVJ7iAh3SsaMxlGWzFrsqvh96aJI9iaAWyjCFrQxKigAmL
	ax8s6YK0=
X-Gm-Gg: AZuq6aJ16EROuIoDxJbS3ndkq39X5+cE9H/n/EhwPiLKYbKAO9M+DcDo1m3IkC/ZPlm
	QL4yENy4d7d1c2ChmWFdgepjP+aI6Ga/nPF71xK5m3/DSjhquUROJ2Y56PRpHONq7tvOorGTLrt
	UreUweZprOXCKCABVbzy2WR44HFXHmnGpXRm9xwhcowTJU6Xl4OfWIjoOy2s9Zh6AyykQHQH/Jz
	wBLU10H1DMaCB5Nby39RJ5PSjv7WuMe7Ag/97wkyiv/h/YyxOG8pEHps9c/zRQ70tyEAvbcKUeM
	Qw6bcPGe5RvUl2lmSq8fhU2hb7O2sixixKYfqF5hzoVETvh75McNwnsWERMntsp5oV3+P2RG8iK
	KSGesuyrJkJQ9Y+V88tEodakU5beJZd5i3e2hD/CQqnrNdnxU62aq2DXme7hV1Q1Zt/gr0NdAia
	QW6nCopcuTTN2hXV8LIOCU9Y77dt66QWwl4BdymHhx2fZQeDRz8fXZvCDjXBWzNQIbt1HWmp30Z
	GY=
X-Received: by 2002:a05:6830:6ac8:b0:7cf:da7d:539d with SMTP id 46e09a7af769-7d448b104demr4271603a34.37.1770313813807;
        Thu, 05 Feb 2026 09:50:13 -0800 (PST)
Received: from mail.minyard.net ([2001:470:b8f6:1b:9c8e:6dc7:3b53:b0b8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4499a49c9sm3827348a34.0.2026.02.05.09.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 09:50:13 -0800 (PST)
Date: Thu, 5 Feb 2026 11:50:09 -0600
From: Corey Minyard <corey@minyard.net>
To: Kenta Akagi <k@mgml.me>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RFC 0/1] ipmi: Fix double list_add when sender returns an
 error
Message-ID: <aYTYUZXJjQV1BBAk@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20260205144739.116409-1-k@mgml.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205144739.116409-1-k@mgml.me>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-214538-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[corey@minyard.net];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,minyard.net:replyto,minyard.net:dkim,mail.minyard.net:mid]
X-Rspamd-Queue-Id: A00F0F6348
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 11:47:38PM +0900, Kenta Akagi wrote:
> In kernel 6.18.7, we encountered the following panic.
> 
>     [164050.860241] list_add double add: new=ffff8a5833cd0000, prev=ffff8a5833cd0000, next=ffff8a387b2491b0.
>     [164050.869744] ------------[ cut here ]------------
>     [164050.874698] kernel BUG at lib/list_debug.c:35!
>     [164050.879435] Oops: invalid opcode: 0000 [#1] SMP NOPTI
>     [164050.884742] CPU: 5 UID: 0 PID: 99228 Comm: kworker/5:2 Kdump: loaded Tainted: G S          E       6.18.7-20260127.el9.x86_64 #1 PREEMPT(voluntary)
>     [164050.899481] Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
>     [164050.905470] Hardware name: Dell Inc. PowerEdge R640/0X45NX, BIOS 2.15.1 06/15/2022
>     [164050.913285] Workqueue: events smi_work [ipmi_msghandler]
>     [164050.918865] RIP: 0010:__list_add_valid_or_report+0xb6/0xc0
>     [164050.924609] Code: c7 e8 b1 c3 89 48 8b 16 48 89 f1 4c 89 e6 e8 e1 16 a9 ff 0f 0b 48 89 f2 4c 89 e1 48 89 fe 48 c7 c7 40 b2 c3 89 e8 ca 16 a9 ff <0f> 0b 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90
>     [164050.943787] RSP: 0018:ffffceacac91fdc0 EFLAGS: 00010246
>     [164050.949271] RAX: 0000000000000058 RBX: ffff8a5833cd0000 RCX: 0000000000000000
>     [164050.956665] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8a773f89c1c0
>     [164050.964054] RBP: ffff8a5833cd0000 R08: 0000000000000000 R09: ffffceacac91fc78
>     [164050.971441] R10: ffffceacac91fc70 R11: ffffffff8a7e10c8 R12: ffff8a387b2491b0
>     [164050.978837] R13: 0000000000000000 R14: ffff8a387b249190 R15: ffff8a387b2491b0
>     [164050.986229] FS:  0000000000000000(0000) GS:ffff8a77b459d000(0000) knlGS:0000000000000000
>     [164050.994581] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     [164051.000597] CR2: 00007ff95841be6c CR3: 000000063b022001 CR4: 00000000007726f0
>     [164051.007997] PKRU: 55555554
>     [164051.010970] Call Trace:
>     [164051.013690]  <TASK>
>     [164051.016055]  ? mutex_lock+0xe/0x30
>     [164051.019724]  deliver_response+0x59/0x100 [ipmi_msghandler]
>     [164051.025495]  smi_work+0xa0/0x370 [ipmi_msghandler]
>     [164051.030563]  process_one_work+0x19d/0x3d0
>     [164051.034844]  worker_thread+0x23e/0x360
>     [164051.038873]  ? __pfx_worker_thread+0x10/0x10
>     [164051.043423]  kthread+0xfb/0x230
>     [164051.046850]  ? __pfx_kthread+0x10/0x10
>     [164051.050872]  ? __pfx_kthread+0x10/0x10
>     [164051.054894]  ret_from_fork+0xe9/0x100
>     [164051.058826]  ? __pfx_kthread+0x10/0x10
>     [164051.062852]  ret_from_fork_asm+0x1a/0x30
>     [164051.067065]  </TASK>
> 
> Because kdump was not properly configured, I was unable to inspect the
> vmcore, but based on the oops and the current implementation, I infer
> that the issue occurred via the following mechanism.

A fix for this is already queued in the next tree.  I should have it
out soon.

-corey

> 
> - The BMC becomes unstable
> - Some kind of msg is queued in (hp_)xmit_msgs and smi_work runs
> - (Because the BMC is unstable) intf->handlers->sender returns an error
> - deliver_err_response() queues newmsg into intf->user_msg
> - goto restart, but since intf->curr_msg is naturally non-NULL, no
>   dequeue is performed from (hp_)xmit_msgs
> - The same newmsg as before the restart goes through the same flow and
>   deliver_err_response is executed, leading to a double add
> 
> I took a quick look at the BMC logs and there was a watchdog BMC reset
> around the time of the panic, so I'm pretty sure the BMC was unstable.
> 
> I'm not sure if this is the correct approach, but I submit a RFC PATCH
> in the spirit of a bug report. I would appreciate your feedback. You
> can completely discard mine and fix it as a separate patch if you
> prefer.
> 
> Thanks.
> 
>  
> Kenta Akagi (1):
>   ipmi: Fix double list_add when sender returns an error
> 
>  drivers/char/ipmi/ipmi_msghandler.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> -- 
> 2.50.1
> 

