Return-Path: <stable+bounces-242532-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBrvAQQe9WlqIgIAu9opvQ
	(envelope-from <stable+bounces-242532-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 23:41:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 696EA4AFD65
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 23:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D3D8300DD62
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 21:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BBF34A77D;
	Fri,  1 May 2026 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="OTW09mMe"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5911A33E37A
	for <stable@vger.kernel.org>; Fri,  1 May 2026 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777671681; cv=none; b=KaKLXajgl16DRUxOzSorpJuKqFRHSM14IYemclRahZBDwdPlZXPRp+yDL2GBBGyF63eQvGEgGffDIuOqu+heNknLnH0vR9+Nf1i01d2NVsBL6Uq7NMu0ed6iU74fDe3XFYe7Wxv8zoegAotXXqUrSMUU0qQSP40unv96Wdi9dMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777671681; c=relaxed/simple;
	bh=+vB/YwdAdoeKwiXl4jbl7V7CVjoY4NMLQprs0wgjpxE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hcs+dDLO4odQ0CtCfueujz/mfMbSQsc0WVtYDBTiODKnTRfM2KHV17R3BxeDVYy5/jJzFyMOzNN4MdEtqfAqEkFbVkJZN9cZbxTENZgsJmc/xIcCHME2cpMsNknsxcsRmrKdCG5Q4rmfi/UuKBaA3wYrDEDsGCM+ANUiw2s9OHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=OTW09mMe; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-404254ffe8aso1981437fac.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 14:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777671678; x=1778276478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=laADkq3ZgEa+dMBziPQTVc8lPu6Hgm7fwgwLZ1xwHyI=;
        b=OTW09mMec4LklfMW0cZxXyVSJ0i7hvI2PICxnY2UsrTOIalUmH68FxI0fqVyf/GgdS
         GIKIZzm/BlkvIEgXgFjoU261qeTYM+Pkca6kO5M+155CcHoKMOc5E9pZSF+4/HVhiNAc
         +xzeHSGXtzdpAylZhseb0qzVOoEZXVcVBDJuKoT24EPayddV0T3mkdfQWoHoaTskEjAm
         Lm2TTVPWBlSp3By1Hi67Lev+M1+6fVBTxp0A1csC47abY7WiRucD76fmLmhJmd3KYnPd
         WSgz2D3pllLnqsJDidTWoIdLPfFFzqzBgv/KTlJUGQmy0Y4gXoccjulhZIE+uUopTYh0
         E4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777671678; x=1778276478;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=laADkq3ZgEa+dMBziPQTVc8lPu6Hgm7fwgwLZ1xwHyI=;
        b=WE2We8XydVgYt/wpwY1o5M0KJHTLiVoKUqUsV+oOZwc/TX3MN/AIHc51fKj1gWgX+9
         Xlm8Hj7ah9SWAd6XSQOCZ35m+CkMdJhd58mvKG5n82TXb2AARjk7HzkbEc9/LEMZ8oJW
         JA4ANUgaRjC1bxkCeOmyfvEDiVYoQ8jOIVBQRjxw0eYuCvIw0cGVjfzDHFXIVkaPSSQE
         0o1ffFo45bxhCXSrFectszJCMlAHFF0c8fefC+Q8HBFADSTxL/npGcndK6e97VJJb5/y
         jXkUmwn67kcyCc54VidUN+7NEGYX8ZGo/5TOxe8SYfLM2X4BOljC5ox+7jffYG60Z/6C
         uDvw==
X-Forwarded-Encrypted: i=1; AFNElJ//DTeH5JmUH6/trAE1IjOkMzKdnMyn7Gw9lo+ZwODa2ZDKKRdhw4nWYudGTAEvxffGUZt5Dl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbZQOo8HXgzFEeA3yAEBwlSgiMbI2IXiGiEa6YdDfsLusEwgwQ
	5NcGwNYQjQTSSNUWMg83KjU9RFQcGjlaN/ly04dTGTYGWr5xWyfL4AREsTcnt0WVwBM=
X-Gm-Gg: AeBDievGdiQqy3kqtBuLyqrR+0cD+jydE++oFYI++hBJ102TZWhy4o0MsLPqq9s3nTi
	jc7YSfpJTvIs4ckHy6C1FABjhyvHE0P4d9Guvo3BKyZilHL/viaser66x7vrRA8DM7jjtT8Q+d9
	eQHjU0M0zWW28zQd93KoBTXrpUbd/q3BJwkjMEowhTpSz0/qbUyFgwY3aGdmlXvvduTH0/D792x
	hhK11SV4DjbmYkShnEZkBK6PkYE2vKgZkRqNTfKOQE39xjgxzlHgx0QzYSAngcARfF50LrJHWJe
	3sNwmlTeKVKTOCF7Nlobobz3EI0NZOoSihfhC6n7zAxwrMQYKkQQSqHeIxi6ZFWJpM1AKmfPdhL
	o0CKXcuiS05wHjJvsXqYULrjQ+xjUMARLOkoR0bH42QBLIcPfIyTVnE3n3h/pU5q90/cmVqo/pU
	Oa4glZlzajnmSc8zq2YfeZ5rS7USLgCKVQdozEbEdhswzCwmrT1Kbchqv2X2zVhBElRE6LhdZdk
	kWOK58Ps3rOJv7+pYVACb8K5/CGMb4=
X-Received: by 2002:a05:6870:d363:b0:42f:ee6c:35f7 with SMTP id 586e51a60fabf-4343891732bmr3543231fac.1.1777671678374;
        Fri, 01 May 2026 14:41:18 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4345452237bsm3606010fac.0.2026.05.01.14.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 14:41:17 -0700 (PDT)
Message-ID: <a4146404-9b0d-4ff1-a4b1-07d883ab3237@kernel.dk>
Date: Fri, 1 May 2026 15:41:16 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 491/491] io_uring/poll: correctly handle
 io_poll_add() return value on update
From: Jens Axboe <axboe@kernel.dk>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Ben Hutchings <ben@decadent.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev,
 syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com,
 lvc-project@linuxtesting.org
References: <20260501111233-b371eac52cd006bfddfbd9e5-pchelkin@ispras>
 <58103791-4c19-441c-9d4f-7ae5f9c6151a@kernel.dk>
Content-Language: en-US
In-Reply-To: <58103791-4c19-441c-9d4f-7ae5f9c6151a@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 696EA4AFD65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	TAGGED_FROM(0.00)[bounces-242532-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,641eec6b7af1f62f2b99];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[]

On 5/1/26 3:33 PM, Jens Axboe wrote:
> This should all be handled in the fixup patch - yes this one ended up
> being broken, but that's why there's the followup fix.
> 
> Now this is all pretty broken because some patches ended up in 5.15 and
> some in 5.10 and honestly I've almost lost track at this point. Sasha
> spotted some that were dropped in some broken commit from Greg. For
> 5.15, the two attached are what I recently asked for to be added. 5.10
> should ALWAYS get the exact same patches as 5.15, because of the whole
> sale backport that was done years ago. I always ask for that explicitly
> in the emails. But looks like that wasn't always done...
> 
> 5.10 doesn't look like it ever got what is sha
> 349ef5d2e7bfb292e7000e6041a984ab56eccf28 in 5.15-stable, hence the fixup
> can be merged with queueing that backport.

That did get included for 5.10.253 - what's needed is the fixup that was
added to the 5.15 queue as well. Which I think got reverted with a bunch
of other stuff by mistake? At least it was sent in / reminded about
earlier as well.

-- 
Jens Axboe

