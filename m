Return-Path: <stable+bounces-244592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PaTDmyo/GkNSgAAu9opvQ
	(envelope-from <stable+bounces-244592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 16:57:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D84D14EAB0B
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 16:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03FEF3113720
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8683C6A43;
	Thu,  7 May 2026 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L4PFkqMi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156823FA5CD
	for <stable@vger.kernel.org>; Thu,  7 May 2026 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165265; cv=none; b=mlMmZdaHRyZT31oBnypGJHBWuS/JqTMR5xgZ0e3UVflg8I2sbDjPnwJJq0SYkUFXa73JKSyzUtrdCq6mlapSkCAZjVV9M+9c1pkvMWy5vDuQ5i0GoetqhEAQkmoqpQD3mHTKYVcOZrMrmiqt5kLb/+ViBTgH2mS2r8bVCbIij1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165265; c=relaxed/simple;
	bh=xquPI6QPP/hbFDTiZH9dc4zpjGQDSZQDeuwR2/3lSaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fIuBnQ5mjy4fouDfSdmllgBQGprFLOA/xB83LyGOqTSPcx175RHcL4FNAqKJmWO4sU5W62pPPFlQ9O8mWG5Ng4OQSTfbmLBqs2inqgnKvo3A46fHo2shmBYxi2Px0tLhproiXmZIsH1QTuvJz5iOfHJ4j7j/CnJvjvLlgqYfv+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L4PFkqMi; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2d83e7461so17665795ad.3
        for <stable@vger.kernel.org>; Thu, 07 May 2026 07:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778165259; x=1778770059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MuSudfTdnilh+hmaWDc0E6+rXSvYD2Cazrxvm5Ba1I=;
        b=L4PFkqMiFeFDxJM2Ft9gRcNhf+nU4U7Ydur/hxvX/59wBm+OSifOZkLpO3451Za+5W
         zFGnIKRkAJY8w5JjYKjv2Y4Td2G2UMFjNInAqnfkszHrixXE6gtmSRCufTJZxhjgVXQM
         0+bUkXYaPwY/gX6Vy3BKJB27YjiIofrZ9jTbrxMhqJ5vuZV/1g/QGwGiWzz2mPqO1pgS
         J3zAxh8g/d6ayUMiReLMJE6ULvaRepiSq5wSDQz20hQG3OuOCGS6Le51751s4Yz4Dk/O
         DdGOpmv6Ps2dfQF0oNXbbpTAMABg0hjGs4i4eluj0Z4IWwMtikQSwSQg+L6qXi+CloIe
         Xoyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778165259; x=1778770059;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6MuSudfTdnilh+hmaWDc0E6+rXSvYD2Cazrxvm5Ba1I=;
        b=RfJ1QzRnUWBoaoaDObfftNKbf/eAMpCBgheBxy1dWA2MsgQ120reLz5eeFIlUAqWPO
         e9OZGk4oaaePBUnqHGI98g1AYbc6T0GNox/fyjspB0VCGENZfH0IKuvuUfWn2quICgS0
         HxcDd8TJHFzUYo5EDkFJ6onjdjKZCsTL3Jo3Iv17K/fo27MgO7kZDsPrpvMC48eZW2Ip
         CSv+v9mL22gjDBEpMbGI0cP0ozjZd+70o6DA5U34u1F3fEjhKwfJR7EWCAUgVTivqGlD
         hKR2ju6S5v1tUXNrrHGrfjzKDtB5S/lq1vWCSuMo9wkgJX4oSsCCLEfI8TTznhJ12WwT
         1rNg==
X-Forwarded-Encrypted: i=1; AFNElJ9umSbz/lkBqYCiaElwTBR1pn6ipg7P1J/qDYqK0cgbQHqNBWKvT/GIhaq9xzQzV5GpJ924tzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwUglTqJAdsrZUj1muVDw31NSEm3m7oUxpf5UyqL95BWdLEQsC
	fqMZLGuim1RedgMYmxMaNRh9IkQKJ+JJ6MBMBH74J6xSU4y2ESbZOXBK0KWEDoYtTOYK8s89gnP
	dc0UPB4aeXPL788Qc44cRZmJ2eA==
X-Received: from plbkf16.prod.google.com ([2002:a17:903:5d0:b0:2ba:792a:18a7])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1ae5:b0:2b4:59d4:9a with SMTP id d9443c01a7336-2ba78b4a778mr93766055ad.2.1778165258795;
 Thu, 07 May 2026 07:47:38 -0700 (PDT)
Date: Thu,  7 May 2026 14:47:32 +0000
In-Reply-To: <20260507-large-wren-of-protection-93bb75@sudeepholla>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507-large-wren-of-protection-93bb75@sudeepholla>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260507144737.3343314-1-joonwonkang@google.com>
Subject: Re: [PATCH v4] mailbox: Make mbox_send_message() return error code
 when tx fails
From: Joonwon Kang <joonwonkang@google.com>
To: sudeep.holla@arm.com
Cc: akpm@linux-foundation.org, jassisinghbrar@gmail.com, 
	joonwonkang@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D84D14EAB0B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244592-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,google.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Sudeep, I appreciate your review! And I apologize that I missed some
important context about this patch.

> On Tue, Apr 21, 2026 at 10:46:52AM +0000, Joonwon Kang wrote:
> > When the mailbox controller failed transmitting message, the error code
> > was only passed to the client's tx done handler and not to
> > mbox_send_message() in blocking mode. For this reason, the function cou=
ld
> > return a false success. This commit resolves the issue by introducing t=
he
> > tx status and checking it before mbox_send_message() returns.
> >
> `tx_complete` and `tx_status` are per-channel, not per-message. Although
> `mbox_send_message()` can queue multiple messages, all blocking callers w=
ait
> on the same completion, so a completion is not associated with the thread=
 or
> message that triggered it.
>=20
> This creates two issues:
>=20
> 1. Concurrent blocking senders can consume each other=E2=80=99s completio=
ns. When
>    message A completes, `tx_tick()` may submit message B, then set
>    `chan->tx_status` and complete the shared completion. Any waiter may w=
ake,
>    including B=E2=80=99s sender, which can return while B is still in fli=
ght. It
>    happens even w/o this change but with possibly wrong return value afte=
r
>    this change.
>=20
> 2. `tx_status` can be stale or overwritten. Since it is a single channel =
field
>    written just before `complete()`, a second(possibly fast) `tx_tick()` =
can
>    update it before the first awakened sender reads it. Because `msg_subm=
it()`
>    happens before status publication, the next message can complete befor=
e the
>    previous status is observed if the controller re-enters `tx_tick()` fo=
r the
>    same channel.
>=20
> We need to see if there are other issue that needs fixing before you can
> propagate the tx error code. Let me know if I am missing something.

Yes, the current mbox_send_message() in blocking mode does not support
multi-threads. I have tried adding the multi-threads support [1] since the
first patchset and adding this patch on top of it [2], but the author was
not convinced about the necessity of the multi-threads support and instead
preferred that clients, instead of the mailbox APIs, serialize the multiple
threads' access to the channel [3].

For this reason, I went with the author's preference [4] and clarified that
multi-threads is not supported in the API doc [5] so that clients can be
clearly aware of it and serialize its threads' access to the channel.

So, this patch is based on the assumption that such multi-threads
protection is given by the clients already, i.e. mbox_send_message() in
blocking mode is called on the same channel only when the previous call has
returned.

What is your opinion on this? Should we support multi-threads in the mailbo=
x
APIs [1]? or should we go with the current decision [5]? I personally have
been thinking the former is the way to go.

[1] https://lore.kernel.org/all/20260402170641.2082547-1-joonwonkang@google=
.com
[2] https://lore.kernel.org/all/20260402170641.2082547-3-joonwonkang@google=
.com/
[3] https://lore.kernel.org/all/CABb+yY0uDQh-3cadPQONV=3DNJKjMtc4mJekgjmHYV=
aHnfHXvGZQ@mail.gmail.com/
[4] https://lore.kernel.org/all/20260404124428.3077670-1-joonwonkang@google=
.com/
[5] https://lore.kernel.org/all/20260421104652.211276-1-joonwonkang@google.=
com/

Thanks,
Joonwon Kang

