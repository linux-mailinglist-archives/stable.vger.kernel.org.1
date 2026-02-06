Return-Path: <stable+bounces-214631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGoEFTq9hWmpFwQAu9opvQ
	(envelope-from <stable+bounces-214631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 11:06:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EA1FC72C
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 11:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10EF530327E4
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 10:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74CC36405C;
	Fri,  6 Feb 2026 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="on47QQVW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D0D35CB71
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372384; cv=none; b=HjokKbQAuNZNcCGlbbTyX0lXoaoVPjZHdowI/ZH3Wp4lmuC5+MyLax58DCflPsMhWiG0CE7xL7pWTRhuRtSvPxxQ0A4ywE6FDs51xz10qNjdWWumquyhCgUqLBw5XFkRlhPuO2PNtoiEMmRvY3LVp0rVDG6Etb6haeqqpIUrohA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372384; c=relaxed/simple;
	bh=XwRCkcfM+4+oYjL+NXA+SsT26tupvieIfp7i+FX7i28=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UtFLHh6GfL/il7Inr+LvvwOkXH8BAVXDEaNhUw/+5fBETyPgBSOKyTW1C4qZNunoXwXZuscARnTYllaW+s+1QFi0A/cZu1iQMpun8tRnhIdCdv42vzEiQjo9j+UJ5Fv7UAaO1EqvUFEYUaC4Toc4iXE+Ekko6765cjMlyIa+X+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=on47QQVW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a944e6336eso49807865ad.0
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 02:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770372384; x=1770977184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XwRCkcfM+4+oYjL+NXA+SsT26tupvieIfp7i+FX7i28=;
        b=on47QQVWOO9/rKbzyoubHrTUHF/2N0svA9/oqNxo9qOJXdXzuEWRNVhwx/OH9rq8KG
         rqNAdoNfKEQeUeC1ve8JnGFdhgiZ/xb79lCZhtl5Vws/ms605bm7a/ohf9tXiuhBMIJL
         omjNlGqIfOJG6F/17IXyioHtMJYRJP4IkE3i0uvklifhOxSSnKAuvaLUNlfeMbSXN6m+
         Sjt1Nf7FSGJ3SqlsdyHk13hXFQ8h6GddfbeV7RGpbWSj+F9cjeYrT6vrwwTMV4lafM9W
         MGPyTRp+1LHpYFsm239uW0/fwVo2PqTHlmktup2J6uObPXW/1tfN5kBghJcq62KQQkwL
         ShkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770372384; x=1770977184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XwRCkcfM+4+oYjL+NXA+SsT26tupvieIfp7i+FX7i28=;
        b=dXDaHzoa+Je8MoHenFqGg6ysMEsyItug5FD8ZYPxRwiwMaxi1XyhqkCW0YDdyPPKzL
         GyMaASkS0kWKnsP2Hbo2n896SeyC5CYauqL0jtpxp7nNWudkCt5cEy9MYn5eRnKscMqI
         1/HPgNZiLnSR1iooaG8gpNT6pvpXy/bt9sft8pScVKnbCRzC0xk2jniOh2b2f44FriA2
         n1NYfh5UgWdty1tUcPa7zktJwYlpWmVVyW+J9vOFVki24/erwJRP5peCJZJ9brfKU76a
         nMGHhk6M2wQO6Nsu2sDTtewCiqjLp5ENQlg2mo8QTd4Xm6G1Z2Dv4w5UBcvzLnroKJiB
         2HcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSg+UfKLMFHqv9DlyKysc/oQbAArJfuWdMZv7vDp6+kIVeP61eXxuglQhDa+pXVXUh5JrcGts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrVNYXJKzfPSQve2ZP6B+7BaXQadxdc3/jYMqtJelYUo82ql4v
	GhA232I57qBV1e9K+z/yvsjVCoMez/Ggx1dWfBu3nZQiy/387ZkeeVFEEK13p09FAgiwqO+mJoF
	y2IfE7885GGdsvJntRR8NZzERgQ==
X-Received: from plbja17.prod.google.com ([2002:a17:902:efd1:b0:29f:1bbb:de14])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2448:b0:298:2afa:796d with SMTP id d9443c01a7336-2a951a02e0fmr22236495ad.61.1770372383805;
 Fri, 06 Feb 2026 02:06:23 -0800 (PST)
Date: Fri,  6 Feb 2026 10:06:22 +0000
In-Reply-To: <CABb+yY2ucPfFhDq3hK6UR3QmqyA+950vkDx0QFtJB+_Yzw66SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CABb+yY2ucPfFhDq3hK6UR3QmqyA+950vkDx0QFtJB+_Yzw66SQ@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260206100622.4166528-1-joonwonkang@google.com>
Subject: Re: [PATCH 2/2 RESEND] mailbox: Make mbox_send_message() return error
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com
Cc: joonwonkang@google.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, lee@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-214631-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C5EA1FC72C
X-Rspamd-Action: no action

> > Previously, when the mailbox controller failed transmitting message, the
> > error code was only passed to the client's tx done handler and not to
> > mbox_send_message(). For this reason, the function could return a false
> > success. This commit resolves the issue by introducing the tx status and
> > checking it before mbox_send_message() returns.
> >
> A client submitted the message, and that client gets the actual
> status. mbox_send_message does not (can not) tell if the message was
> successfully sent or not. For example, consider non-blocking mode when
> mbox_send_message() immediately returns after simply placing the
> message in the fifo. It returns 0, but still the message transmission
> may fail when its turn comes. So I think it is fine as is.

When it comes to non-blocking send function, the common expectation is that
users of the function do not expect the final send result in its return value
of the non-blocking function. And it makes sense for users to register a
callback to collect the final send result. It is a common practice for non-
blocking function.

For blocking send function, however, it will be quite unexpected behavior if
the blocking send function returns no error code but it actually has failed.
Also, it will be uncommon if users of the blocking send function have to
register additional callback just to collect the final send result. If that is
the case, the blocking function requires of users both blocking and callback,
which is redundant.

Overall, I think it will be better if we return error code in blocking mode if
it has actually failed transmiting the request. How do you think?

