Return-Path: <stable+bounces-242605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uruHNI8D9mlPRgIAu9opvQ
	(envelope-from <stable+bounces-242605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 16:00:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 622F24B23BE
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 16:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F24E30039B4
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 14:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22921217723;
	Sat,  2 May 2026 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="P9Of51uv"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A9840DFB4
	for <stable@vger.kernel.org>; Sat,  2 May 2026 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777730442; cv=none; b=X66G49Fd2IEIx2dyumzmpueZCZfMSN3TwGoKwVOYpIgHQ4mslDldokNFOHb2NSargk07hoLNXYO32M58381Yxx4FiMh24yv6CeI+zJYBZku3WofUJiv9dM/1G4y75Fbq0kXvSMJcDK5Y1iYmqnjRZwmaoCbE6lbnxurD7skRPBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777730442; c=relaxed/simple;
	bh=lu35PpcmO6OJD1AiJnFgx/0PeQkOrQTUxpNyEMiwvY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPHBVZISKRjKjGLHWZevM9ohS70JcFhZ26esHeeNU/HcZZPX/XBSLuZx4KEukJkGq/AVIoWSSta6aSs3nI0Ipsz/dFbvdVtK0CK3WbLN+LjsWvX2ApYqgCE5zSt1yNbOev7hlgFh5/sO80S2yyAqjIxIQL6JeIxuVm5s2T17bUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=P9Of51uv; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4094b31a037so1731539fac.1
        for <stable@vger.kernel.org>; Sat, 02 May 2026 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777730439; x=1778335239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQ9Qx53XXlXs8ygjRu8DmTITr1DjOhIcVPhEqWxH7pk=;
        b=P9Of51uvyIFHV2cRg1s93EpdzkjsPKsK3GcBwhIt/arHqNULBn1CYCIl1d8twRO2T2
         4U5Yo/QGYAo77hKSVbrE41FedS8RUPrIMFWiB9V5XFwL0Ovnr9RWGgekERK3PWWrRPrb
         Hd0VoTYlYTosZKHuecP+3n8q+XZJ9YRS3pVh723Re3YcJ80Xh8JYqLmfr5uEHEqwkGOT
         GsJf2idW+BZsncQdX1/nZzzmQ0mfHVvl2n12nGl4je7G0OE8O3gAIwAp8vh6eEXWsxZI
         uMoQolHQrlFsltXQyaHSwuMWX3vc06RxLRh5yTBAwHtBMB2+3/3wBeTaeJbw+wck8wbs
         7PUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777730439; x=1778335239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQ9Qx53XXlXs8ygjRu8DmTITr1DjOhIcVPhEqWxH7pk=;
        b=bJOmkAIFBn92CFvbbtvu7PF4s2Zl5qnhOhoNV/StPxSAuHF14CFWO9YOd3FRPy9Nxo
         KNl6KZSS+Y0WqaRHaF8cUFXTQIm1I4i9jn+bfw51I9qYLNvJylcnI6zsTh6OO9sotIro
         7KSynfGeo09IpkE89yHTtuDMRtmIY6w5dIUGyZshHvTkc6jEj25Wtm4f25My4vNCdhY5
         cr/9BMoRFuT2SQ37AAVZ0sfjg4+5A6ojEmhXaB9+JlgprN64DwSelVu+A7+TvMEj6W6T
         /HtgMhxEq+FoT7kcFNB1WJZRS02JA5qJtXDBLsQFwd1ai0aOhqbikzLlmNoR0lqpXCpz
         91Zg==
X-Forwarded-Encrypted: i=1; AFNElJ8tBuCOiO6V4xD4BMFYxi0+PBoHy1vELiQhk8Dt/1T0qDy02T5lqWub3txAfIZtoMYsLoKAw7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5TWLvAD9RPklQORl7nIQOVYg98++GFMfaZwZcFNgJ4oByN8cq
	O1aDZs4EOraLxZjzkcllwRtU1a1I3EGvXeIig97HPfaL6mMA5toknOsr3apW7mMiO62NOuqHm0s
	337WX
X-Gm-Gg: AeBDiesXKs5O5CtaTbjbO97mDO7gzfgmhwGWQnPoeYitMVdn4n9Gs/g2ko9KVpMIq6G
	fZdVE6JxELJOzQuVlRKJlvEDS7VqwmV6dfsfhR20XGypXM5kb6eXi0KKDc4Pm71vLPjTtT7lSq5
	+bf8/+5tJKDqVPG4SEFUhm0LTzr6kKhMv9gB+r5wQQfjct3TC28NpJ1lomHVy5Nj1SXIkBp/tA6
	zKeP5yfDwY6p7IHhdMbXz+4Y1AakJR6+L3QC7sliQDpLa/N+4gIj1QLi8tG0KvkENFauoPBP1SR
	UXE++u26r4tsqefqmumpwfIAu9xNz8lLrbP5MSqaMsfcgOCUOiXC4J1oHUfHBgdHIrMO/ZOUztE
	6gLfudHYRJ1bhLlLrPx67QHlbGMqSbsc1tU3mMFaCXuOThvO+nwPqwll6/GEy76Cw3hbFJuTlLu
	5yvcEVaVJxTg5MKp9gIDLtJgBdA0lQkJdYxHd5uqre4hzOM43aeMaMKoQxAuxtEnSTaFiofrA/d
	kZmKktkF20N0gmzOx4g
X-Received: by 2002:a05:6870:2e04:b0:417:3441:6c54 with SMTP id 586e51a60fabf-4347628094emr1771454fac.27.1777730438880;
        Sat, 02 May 2026 07:00:38 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43454942dc1sm4952558fac.5.2026.05.02.07.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2026 07:00:37 -0700 (PDT)
Message-ID: <6b05774b-9a59-434a-b006-9edaa704b857@kernel.dk>
Date: Sat, 2 May 2026 08:00:36 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/poll: ensure EPOLL_ONESHOT is
 propagated for" failed to apply to 5.15-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: azizcan.d@mileniumsec.com, stable@vger.kernel.org
References: <2026050100-washday-snowdrift-2968@gregkh>
 <a1b41674-0593-422b-93bb-edc3993d829c@kernel.dk>
 <2026050207-dirtiness-reapply-f841@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026050207-dirtiness-reapply-f841@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 622F24B23BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-242605-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On 5/2/26 12:27 AM, Greg KH wrote:
> On Fri, May 01, 2026 at 08:40:31PM -0600, Jens Axboe wrote:
>> On 5/1/26 5:09 AM, gregkh@linuxfoundation.org wrote:
>>>
>>> The patch below does not apply to the 5.15-stable tree.
>>> If someone wants it applied there, or to any other stable or longterm
>>> tree, then please email the backport, including the original git commit
>>> id to <stable@vger.kernel.org>.
>>>
>>> To reproduce the conflict and resubmit, you may use the following commands:
>>>
>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
>>> git checkout FETCH_HEAD
>>> git cherry-pick -x 1967f0b1cafdde37aa9e08e6021c14bcc484b7a5
>>> # <resolve conflicts, build, test, etc.>
>>> git commit -s
>>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050100-washday-snowdrift-2968@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
>>
>> Not needed.
> 
> Note that the Fixes: line implies that it is needed:
> 	Fixes: 4464853277d0 ("io_uring: pass in EPOLL_URING_WAKE for eventfd signaling and wakeups")
> as that has been in the following releases:
> 	5.10.162 5.15.90 6.1.3 6.2
> 
> which is why this, and the 5.10.y FAILED email was sen

May be incorrect, 5.10/15 do not have the ->apoll_events cache that
newer kernels do. So likely just mistagged, which is why I'm saying it's
not needed for 5.10/15.

-- 
Jens Axboe


