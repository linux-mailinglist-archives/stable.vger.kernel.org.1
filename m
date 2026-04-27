Return-Path: <stable+bounces-241200-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBFHFb627mlfxAAAu9opvQ
	(envelope-from <stable+bounces-241200-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 03:07:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CA646BCD9
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 03:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71B7A300C92C
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 01:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5132236F7;
	Mon, 27 Apr 2026 01:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBb5utJ5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9E11A681E
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 01:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777252023; cv=none; b=g2w4erHeGs0X2gUYvPkYe89bsZdT+mJlHWsbBUKDcFMwBINS0c1yz6y7tAhjkgA5aGRmNfsGoSazBkZRU/XBEREOSVFvlO/fQTbSFah2320B3CEbjrMMyXOgtZYJ9OZK7w4aqbXCTuqEvNSmmvEMJrfukUuDOxjD5GBhTQOsX2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777252023; c=relaxed/simple;
	bh=SP/GVYPG/eEei7gw40gtFLPAanmcFHffJN39FXiZEWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHyhjVdNjMy+aSk+wb/ztrvzZUGH9nhv+doDm9hH58aOPmTVd3iw3Cngj21QmqPdVloGIqMVfKc0pHgMKfIXE8qongGZwaWZd6pr5ZJkKPVPU3PObt1Fyy6o7YIbUcUg4ASvKfe1J0AI13XE7uSro7MnlquvxANnbsNgPdGL2qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBb5utJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E285DC2BCB8
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 01:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777252022;
	bh=SP/GVYPG/eEei7gw40gtFLPAanmcFHffJN39FXiZEWo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bBb5utJ5xKSXs/U9fmY4ORvprsLSNR4l6M4LvCH+GA0psC9pgfB+7KhLgXi5MPVjv
	 wliE3L3LsvllX96gPK/qh/oOuWz9EUJbwUK/B6PrnL/QoK6K5JBqKj+LdnWIv8RGMH
	 /gaFygt3+E+qBssKEfUy/IM2ozWBrODcT2QyldaIXDNKbN62OcdHZaQXXA1B4URNlg
	 x45TI1rnDJatUO3b9HwyCnrae6/wt6f/CkB08JTaTSKIe+ZJr8U9V0iNeKvK9jk1uO
	 RsNJ+x5ki+EC8RjnNUwPqHojI37KD6n2ASoYxkcvx4rPRw8TZ1OM15LLS9kPQRgOLF
	 S/OPMxyhlSWUw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6729c6f0ca7so11559279a12.0
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 18:07:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8mYpiF0DtEvZCA3S63yD7odfAJ9M8QMi8XJTyqVtxlXkrVYhk6mta6IhdulqmNgJap2GZFvUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5bSk9zmwU77KBK3aOGdTJsmkSb8SR00+oFC/YUWw4UMRBgy7e
	fczyUQtLiyFJT7lwythnzyK/Z2mcxO6lHvRCVC5XOSUPmBthfjOlecd3HlKEu6qY4g3SvEuGDco
	mHV7WQYvz40/IOmfcrsEQ2qY5g52lqlU=
X-Received: by 2002:a05:6402:24dc:b0:671:c31a:575a with SMTP id
 4fb4d7f45d1cf-672bfdd4dbemr13673687a12.23.1777252021463; Sun, 26 Apr 2026
 18:07:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425093829.4004785-1-charsyam@gmail.com> <20260425093829.4004785-3-charsyam@gmail.com>
In-Reply-To: <20260425093829.4004785-3-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 27 Apr 2026 10:06:48 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_1q_6jXT+A17s5Q6JgUFJvYAt4=GJ3vYG7ruz5x3PexA@mail.gmail.com>
X-Gm-Features: AVHnY4JbCsWkwfsFjUWPEBH-HaEq4c8C0MSse37IOOPABIYuuA9JbObwRN3VUoA
Message-ID: <CAKYAXd_1q_6jXT+A17s5Q6JgUFJvYAt4=GJ3vYG7ruz5x3PexA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ksmbd: centralize ksmbd_conn final release to plug
 transport leak
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Ronnie Sahlberg <lsahlber@redhat.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E9CA646BCD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,chromium.org,talpey.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-241200-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

> -
> -               if (skip(tcon, fp, sess->user) ||
> -                   !atomic_dec_and_test(&fp->refcount)) {
> +               saved_id = id;
What is the reason for backing up the id to saved_id?

> +               if (!atomic_inc_not_zero(&fp->refcount)) {
>                         id++;
>                         write_unlock(&ft->lock);
>                         continue;
>                 }

