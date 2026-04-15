Return-Path: <stable+bounces-238061-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0G8uLXNG32mFRQAAu9opvQ
	(envelope-from <stable+bounces-238061-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 10:04:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC0E401A96
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 10:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B4D730D2C32
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 07:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFE93CAE9E;
	Wed, 15 Apr 2026 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNAaI6x2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606623B27D4
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776239969; cv=none; b=W3SurAqxlTPWbMVrYEe1/tBbeWjK9XcRxwgyo4U1U1Giuz9MyXsq9EBGzQP1o79UqadqXvVNlwUvsVAnSBIXsGM4769hmdHRK4KVkepoygVZFPAgYHv5YRHAZvRqZHxtJyoVUZ+j4pTl8IsIvKtmfV05RbX5L7SRGbM6XUW19s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776239969; c=relaxed/simple;
	bh=v4txLFrjF8x+4vhEHg9wpHXC7HaZVp8pc1Zv6dPSMoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AduhSLRH4Kqej/O9F9IuAfORlCiUHYS+0uRyqlLhysLPZFE6dwFovBYgKl1ZdsZl01Fuw+paY0nbBE2bP4fLC7b0SmdetsNiZxvZCLcGgUdg21tOCHvCNbGDIp2AUe05PbksolKqazrr2cuD/OyBToaFdo3tckEwiTj43pv++Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNAaI6x2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cfac48bc7so4464514f8f.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 00:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776239964; x=1776844764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnGUNqAPhun2LmWwo++iWXcTG1XwZ7/9oz20GAfV1pE=;
        b=iNAaI6x2O2Q2sQ6cBd+EgthxSPzePJ4VMMIbt//6SVP06nN7PFtF0nLkXyEEM4tS8M
         wwcfAP/y0OZXX5TAnrqJmKRy5wkQGI7JLSHkz/8G5+HaH8bBIRfDmzMYO7ly9TnxUULP
         UTMVQ2kjylYfcyHkGBXk9fpIZEQkZhvHNw4jh7l/4sl6+37RsYDM7YkSGm6aWfqnxy0l
         YCTge2axoOKL3yeqTfGfAGg2ZNNeE1cRZmAxMjiwyVZ232xhM1+m1VmfX/1LpEFxiube
         oP3KMWTLuia2iEPzZk5+k9Oyij35EGQuNXuoIlAtkRRyg4Sm36r7XTMgZAq16DCwFi8H
         RcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776239964; x=1776844764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fnGUNqAPhun2LmWwo++iWXcTG1XwZ7/9oz20GAfV1pE=;
        b=GvJjqcYJmgYBxYDrmrnlLd83HiqUy4Gg3nTlTSiVbw9U19d44CeN3ErQJ08M+Cpe8B
         tGeMR+dC0tWSLNeOddWukL35illP3BSvIkmlih6EyelZotm89oUcHtk83IpOilTDUay0
         6r60ookrcT6MEbdnw6Qr/IYxiFI44coCMAaAx684sAfrN+Qs1AMA6O5eMTs13qyFHdGD
         iHwB0UCTYDCSdObiWanv8IYUPn+kcolo8WyQ/ljVa/GGVUHzM3oycZwWp/7trWRmlAGJ
         PMW122hu7iQ0+a9QH+NbwC/uqnMSKU9aiSf4Cy/cZHNRtmw3QKjFBzVcjEEPSBzkAs1W
         2G0A==
X-Forwarded-Encrypted: i=1; AFNElJ8z7nK91g+1c9YyFd01z4oWvp3SjUP430tGxltsdT0I7xBjxyZ5CugLMI0spF3Wo0zfQZA6jhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcWbAfRVoRHTP9S5TsuPyUu6/1H7t4X3+V8VscYg6OX34hAaJN
	eBi5CE1KEUWqklpyw4kGZriJqZT8elluRr6Y4pJ5CQIYeipblR5YE248
X-Gm-Gg: AeBDiesCPvzd8cKJeeicEpIBSOMbf5MlQd0NeQ6WwyfYnnJlSonTcdduYsHdCeJPGzk
	0ZOTNZnzwbCxRQgRZkVCpeyhwUOClkty2txoQ+Yr9cvSvrluno2IjxD+EA2207AZAQVifihMYZ7
	FLT8zVezzsorzrQR3ZRIbAelhiklFylevC2Xn3RzG8Kw+Ytm1wZUPoV1XA098sex8o+XEXlh/h7
	nKljI5l54PCFvGoxfXuYFYFmGK91eMDYdycLEKMxmKjc1j3mEK7Ms+frQgF4qeJbv+D6PZ/pECS
	2KFFspk/tBcxRbyl9AWKzFDYGHXNuf8MDhbC7mnIqdFbNvxHp9pE+VzniN/ZDapxwHQQVME4EPw
	ecHSi1qzxiZOS6o4/S0qtexMvB/Cmtnm+/WvqrIXoXq2CAe8LmLeeExa/do/1IHsnVU/PGar4pW
	BkcJiHjgwdv4hL4o1b2C2P/fWZgdwEHa4nH16jWnN2bMrbdyEOdp6wNC9hsaX/703X
X-Received: by 2002:a05:6000:22c6:b0:43d:7e11:1b72 with SMTP id ffacd0b85a97d-43d7e111c1emr12453323f8f.9.1776239963143;
        Wed, 15 Apr 2026 00:59:23 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3ebaf1sm2843108f8f.33.2026.04.15.00.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 00:59:22 -0700 (PDT)
Date: Wed, 15 Apr 2026 08:59:21 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: netdev@vger.kernel.org, linux-hams@vger.kernel.org, jreuter@yaina.de,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net] ax25: fix OOB read after address header strip in
 ax25_rcv()
Message-ID: <20260415085921.757b48a0@pumpkin>
In-Reply-To: <20260415063654.3831353-1-ashutoshdesai993@gmail.com>
References: <20260415063654.3831353-1-ashutoshdesai993@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238061-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3DC0E401A96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 15 Apr 2026 06:36:54 +0000
Ashutosh Desai <ashutoshdesai993@gmail.com> wrote:

> A remote station can send a crafted KISS frame that is just long enough
> to pass ax25_addr_parse() (minimum 14 address bytes) but carries no
> control or PID bytes. After ax25_kiss_rcv() strips the KISS framing
> byte and ax25_rcv() strips the address header with skb_pull(), skb->len
> drops to zero. The subsequent reads of skb->data[0] (control byte) and
> skb->data[1] (PID byte) are then out of bounds, which can crash the
> kernel or leak heap memory to a remote attacker.
> 
> Use pskb_may_pull(skb, 2) after the skb_pull() to ensure both bytes
> are in the linear area before reading them. Discard malformed frames
> that carry no control/PID pair.

Is it just worth linearising the skb on entry to all this code?
I believe all the frames are relatively short and low frequency.
So the actual overhead is insignificant, but it makes all the sanity
checks trivial.
It is even likely (hand waving) that the extra copy for non-linear data
is faster than all the checks for non-linear data.

	David


