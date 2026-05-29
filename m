Return-Path: <stable+bounces-256699-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCIXJNvXGWqjzQgAu9opvQ
	(envelope-from <stable+bounces-256699-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:15:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E4977607256
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E8133008094
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C003402B8A;
	Fri, 29 May 2026 18:15:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AC73BCD38;
	Fri, 29 May 2026 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780078545; cv=none; b=nZvj9XXhaJqgf5nm7qkysX7OwFAVMMiH+Su8P6aFLyxCmaGspOnFgohiC4DOj/9Gv5s8qUJdkLPC1GQ9e0Es9WOBUhcdDmgq9X4Qvyda+mtTq87IOYRDVXbkh3tID6LYMqgvrMGIfvMcD3q5B9Iy8gfbp7tKsmGvgaVV7B32asI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780078545; c=relaxed/simple;
	bh=MP+RdZEwWTL5MMgkVtCmn1SSdTTv7yexg+SmNGRcTaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Feb+xfUpHzTHi+t6MBeePWnESa3XWKD0wWCdDpeK6FrtVE3WJw0UZW1NH0xusiZzn33oQuJJOakPvzNGg9eu8J7VZuHo07GEQ3ByHUkXvLnsP3BG+xMjWO6psbK56y0Ql9wMbKHaAcvwzspD9BKIjLgSFellor6+Z2m7TmyUShM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af73d.dynamic.kabel-deutschland.de [95.90.247.61])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5E0864C2C37D5A;
	Fri, 29 May 2026 20:15:26 +0200 (CEST)
Message-ID: <a7b9c73c-0406-4a6e-9f38-93ce2cb6ba6e@molgen.mpg.de>
Date: Fri, 29 May 2026 20:15:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] Bluetooth: L2CAP: fix heap over-read in
 l2cap_get_conf_opt
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <51761fe5-2244-457b-bf60-060e43f0cbd1@molgen.mpg.de>
 <20260527051808.47220-1-meatuni001@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260527051808.47220-1-meatuni001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256699-lists,stable=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.973];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E4977607256
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Muhammad,


Am 27.05.26 um 07:18 schrieb Muhammad Bilal:

>> By any chance, do you have a reproducer?
> 
> No standalone reproducer is available. The issue can be triggered by
> a malformed L2CAP configuration request where opt->len exceeds the
> remaining buffer, i.e. a crafted packet from a remote peer.

Understood.

>> I always wonder, if Linux should log a debug message or even warning.
> 
> Existing callers generally handle malformed configuration options by
> silently aborting parsing, so I followed the same pattern. Adding a
> BT_ERR() on -EINVAL could be reasonable; I can include that in a v2
> if preferred.

Thank you for sharing the reasoning. It makes sense, and no need to add 
it then.


Kind regards,

Paul

