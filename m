Return-Path: <stable+bounces-225252-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Mi1WKFSls2mPZQAAu9opvQ
	(envelope-from <stable+bounces-225252-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 06:49:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E40F27D7C2
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 06:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 784093025700
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 05:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2602282F34;
	Fri, 13 Mar 2026 05:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B5c2KTMQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iUk0Xhww"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E36E17A2FB
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 05:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773380941; cv=none; b=cKelbpSEq/RIGjysVOP0dZAk9P+tdjYchwVTY3euA4pWGpJ1zzf9fsYxNMFdm6Zf3KrFZd+BugoflY1W4FtdCAXh6EXi7/ZQpABfN7OqA2lWJqhbJ07lRSMjpnpEw8cF0/FcPaUm9grFDWs9Mc47ywDGbGDGiR8iCjQDvQVZ5qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773380941; c=relaxed/simple;
	bh=MhADgZLiFPiSNlAWct/eoeXww34LQnX5uPNWa/ki4hs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p+UwyUOCNilRNsWc9f3nU7ywzesO0zCNYp0Y21VMpSpZvZ8mXMo2UNb6UaEX7jtYDUwIeB8DP1ZCdWr6XdMf/vLnAUEJ2FweMlnwLKNpoGBNTuRJ/oq7h662ilu3U9TYI/+ju5oZO4BSjt6Q53e5FoxIx5nXSBaIv3UJjYaNw6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B5c2KTMQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iUk0Xhww; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773380938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MhADgZLiFPiSNlAWct/eoeXww34LQnX5uPNWa/ki4hs=;
	b=B5c2KTMQB6Oh5UTVuF4FNUL4+PXfRxy2fnfIlueuR9Yjq6CZr5qWUbokZ1XCZ/mbORF6cT
	ZJbr4dJpiDB2kqkSVRqiHHrELpX2w9H7SXcHElczNd+JDMxCJG/9dVzI5NQVeGRlLYlufC
	TnfMdP7i8i+9+SJfzHT0DINm+OtaP7ys2YrfeuLtqxerQzTLLAOxIQyDX/gsg59gduXdDQ
	2bYev8+0W3u3ivEaMZ1RVovhQHT2zGMW36gcCVg9PRYxFby8xYpJzaWz7IT57nuCqCq8tN
	YWrMn4Fca8iM6E8Hhn1qQ67D0A9Sl7yOG9kaiDwvas85y2YCg62g5c7kNwLw1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773380938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MhADgZLiFPiSNlAWct/eoeXww34LQnX5uPNWa/ki4hs=;
	b=iUk0Xhww78MdUFXG3+93pLIFfV8DCGb/3KL/x1YFT3dQ6QYu811xnA2ff7ziqkoOELiRw+
	BAlBN05TjGjqGmDA==
To: Nilay Shroff <nilay@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, tglx@linutronix.de, maz@kernel.org,
 ritesh.list@gmail.com, gautam@linux.ibm.com, Nilay Shroff
 <nilay@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/xive: fix kmemleak caused by incorrect
 chip_data lookup
In-Reply-To: <20260311134336.326996-1-nilay@linux.ibm.com>
References: <20260311134336.326996-1-nilay@linux.ibm.com>
Date: Fri, 13 Mar 2026 06:48:56 +0100
Message-ID: <878qbw5lfb.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,linutronix.de,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-225252-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namcao@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:email]
X-Rspamd-Queue-Id: 9E40F27D7C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nilay Shroff <nilay@linux.ibm.com> writes:
> The kmemleak reports the following memory leak:
...
> Fix this by retrieving the irq_data from the correct domain using
> irq_domain_get_irq_data() and then accessing the chip_data via
> irq_data_get_irq_chip_data().
>
> Cc: stable@vger.kernel.org
> Fixes: cc0cc23babc9 ("powerpc/xive: Untangle xive from child interrupt controller drivers")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>

