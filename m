Return-Path: <stable+bounces-233740-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HznAU6y1WlF8wcAu9opvQ
	(envelope-from <stable+bounces-233740-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 03:41:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 596B03B6004
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 03:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44ECF304741A
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 01:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B485E33D506;
	Wed,  8 Apr 2026 01:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="yEk6K34v"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC25734028D
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 01:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775612388; cv=none; b=tyPLS2UzY1oo9UZrLphCc5hB7wui/noLebQ6ZyU/4ixsX9VGw3Ru+UFWIizdBaXosIZjGk8Rz44sAw0cv1PO+idpeUacEhViqQ9cdZHIudJuqTqV0fn7NUrjHRbLAGZ3CWf/VPucjQ7C+1M/tZTo6tw7DH5aldX86EaowuQBDeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775612388; c=relaxed/simple;
	bh=pCbjMKYdrCJ7fCh1p8SwHc/gm9AcnwgN8MBe1+aRcqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxY3+K6B95WnscoMbl59BG9iM2CcB8gWLaQukmbbjD/adXMAsipUCAb7eacFO7qqTuHsKRYTqoPUVNrv5H48NdEkMCOWkHM1ebRrvDjd4VaiNeWJA8aG5E65NKzJexvvxP/GUPAGzXgPEDLq0GAG4fmPc5tmHNVTYZc85Za9NMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=yEk6K34v; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d9e22176a7so2846894a34.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 18:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775612384; x=1776217184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gk9Gn7UIjWaFrp8SHEWFhN3PuY8GDxF4o5MoBlsR9Ng=;
        b=yEk6K34vG1sF2uJMO+PeQi1hCu2E7Kbg8G+NtR7WJC/Q2+BidVjXH6d7QDIYnt40vh
         tjNZdX7Ye8Ag6jXOMd3AED1QcyF0ZMSETQo8Zje44La+L8nbWaluNFF08t03U1Wv9AAF
         eZxSznRKjDHZjxWqZWNMf5w05+KOPqrhRDoOxirjckWkB6JrhMt8rQiRQw11FwkkVi44
         PNBEYTx8Z31bXizXBvVLcm84jbtcIL3wLmu2+JtLpHKLFD4vfDHKfZVjpAzqHyMDc8de
         hQMId5eINfb+MYEo/CzARONJUSrW6aJX+UdosGJ8vOmVa+Y2wRyTFn2Dip6kJBUTypAD
         SygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775612384; x=1776217184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gk9Gn7UIjWaFrp8SHEWFhN3PuY8GDxF4o5MoBlsR9Ng=;
        b=VlcTiE2uOxFwxzdlLjwfl8lx2+/JEp+wbuVa/g/Adi7W8qEj1wo/xUi8kIgDKvUv4y
         D6+YMSpKmnwOWRxd24//nAGkyAIRQ/LyfpwXP6WsSiD763X+1FqweUvdngpChiZB8VZi
         2+G+684CU8PQjZUP67SrnrNoBOeq4cvmrpvOhSbe+fKCM5GqymvMxBUSWO9kaZvy9dCM
         mQDggLka1qtfdiWPWZrmtGsjxoYv+YOQw51xVtRNPK9gzL3veh6hdvuuSekA3U43FSbw
         KQuliQeSDjGGCSbM9EgQV4ARlqn2g53O6JSh8eq3uraFVKkV6mUW3xNBKD/Q82dvWE4W
         75Jg==
X-Gm-Message-State: AOJu0YzXwN16ea9q3enT9HzUgGIEnLTriBP0OehmD+etLqQufHQNOLhy
	Awkxo4Lj1iffnJ0GJsIWwFROMjY883LI1kEKStnJ7tfN3vVbRyvrkAHiz86eJzcTG7Q5VyzWb8h
	JEtXSYRk=
X-Gm-Gg: AeBDietVnOYs5RDYG/JCn9fH4TlJI3bPcWBL0QCo3n0GJD7iDHmHV5aGjwMuSENFeeP
	hO+9muC7gA5UtRtqG/w54yeapP7/58cfOd7yiqhSLvln6xnLF6NEHCfS7ozp5oLCQtjqa7ISYgB
	Bj5oso1gVefI60XQk4eULsUmRIImdaexZq0K1H+5y066KBaupm2iwPe5oy3SnInJbk7HV3SHGJn
	09VxUvUjIOmUIo4qjx4HZJxwM0UgmAe1LIMXuy/sUy7B9b4GdzYsBOPXPD0lRtDKhkhEgAiIZH/
	z3yC47yxCoLUahlmewtFXEjtjEXgSsEBk8Kbm7pHfqJnMS4vUme5acjlcN/Ewsmx8uXoiiZUWiH
	LSHySe3F+us7qfdIIHDQgGXDLQ3nj7qHyK5wvdk+49weqU4sq8c+rZS8G9JeBkYRVeKr5ctHFX/
	UMGYhubasfBgbu5K810P24LSWiBgUUiX9wQMTqzjeUq9PPGeTLvxkT7Ku1bawsLBZspbapwYazs
	BJgoGqZUw==
X-Received: by 2002:a9d:4c95:0:b0:7db:d229:d51e with SMTP id 46e09a7af769-7dbd229da7cmr6373239a34.12.1775612384292;
        Tue, 07 Apr 2026 18:39:44 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbc54ba910sm9312609a34.14.2026.04.07.18.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 18:39:43 -0700 (PDT)
Message-ID: <5aed4647-14cf-4b0b-affe-a3552962605c@kernel.dk>
Date: Tue, 7 Apr 2026 19:39:43 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: protect remaining lockless
 ctx->rings accesses with" failed to apply to 6.19-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org
References: <da5de9dc-d554-41fc-a8a0-680fa38952cb@kernel.dk>
 <20260408010216.746289-1-sashal@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260408010216.746289-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-233740-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:mid,kernel-dk.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 596B03B6004
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 7:02 PM, Sasha Levin wrote:
> On Tue, Apr 07, 2026 at 09:55:19AM -0600, Jens Axboe wrote:
>> Some code got moved, this one applies to both 6.18-stable and 6.19-stable.
> 
> Applied to both 6.19 and 6.18, thanks.

Great, thanks Sasha.

-- 
Jens Axboe


