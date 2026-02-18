Return-Path: <stable+bounces-217283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCChFPS1lWk/UQIAu9opvQ
	(envelope-from <stable+bounces-217283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:52:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A4E1566F9
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ADE0302BDCC
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 12:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7A931D372;
	Wed, 18 Feb 2026 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYoCx87x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E3C31B824
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771419068; cv=none; b=FH+cWTC4X0JKyMzIzhAuscy2XlL4a842zvoiV8zumrrpIMGVOS77k7mJcd7AGQj3jv0002zuEmdInK2mBdv4a9YJ/bmzs+ENY4lnn7Zn6iYelSfj6+Zowm4GhwL1dEVaLMFrO4P7owi+h9YZQtQ857Q+7MkI7BFRH+6dHGpo0EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771419068; c=relaxed/simple;
	bh=ChJGVLy5mZGoflJKURgVEZ+7nwkwJ8e/WFaKFyRUSqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5EVNHYVXVTTWGTqQxUwlr2rLtpYsMTwD4hWiD8vUPzMxCK2hcKS39mEb7PsABz5huqTDs/SKOStO0aLhi39uIqpMbdIKv9o5d28wb5FCj+cgHYB8KxizEjJLwLajUUd2OvCYJulHoR8c5J20GzV+bIl7zfDOV9mqXcX+iQA5EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYoCx87x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD9DC2BC87
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 12:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771419068;
	bh=ChJGVLy5mZGoflJKURgVEZ+7nwkwJ8e/WFaKFyRUSqI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IYoCx87xvwRzzMYi/4b6MTLAPuPP2qJI1SEaL2YnvXAEAuJmmqzV5JWlb2AjI+l0T
	 qSVzpP57FMYb9BhlDbRX10gZxUstu9t4dXGiEl+vPsD7dR6tPZEBoJJYrXKqepWgHb
	 PcyI8wQXz+K2ExRYBli935ePXjKKG0OEoY9b5dNWptPhZw1xKWQIOtitlE3RNTe3DM
	 iwWx97enA1WhfTSVGoHZr0GHFkbTazJ2iJytg71vMbDjDCWgkZXOQ0qWtrZrF0MtuT
	 RxapbbRbmUrFEivpNS5IVUcPfnTZZmZvlib/H7H8kKk8FItTM3ok42lJiKcFaOxZCh
	 ANXi/1myR93xw==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8fbe5719ceso786125166b.1
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 04:51:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQJpYKePJRX2LLh+Z+1p3y+pgNelm1eDJcVfYkGiOJbdC6EABsAJt33WEBCZzihwaCBp0E65M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygn21M21rr6UdTH7WmNT6MVHPwdfJ09hSdIxxyStkcP+S9z2qe
	gE1lf8r/Fd/2q0JqW/Pfn7gHcz6TGZtmtuN4NiwC8+cZyZW70qrkXWqRypFvhY1BpSPrwWEHqmD
	s8l6wQYDx9G+FfPmcbnSWQ09dwLJsfd8=
X-Received: by 2002:a17:907:6e87:b0:b8e:8874:8367 with SMTP id
 a640c23a62f3a-b903da4dc40mr93399466b.8.1771419066721; Wed, 18 Feb 2026
 04:51:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218042829.68334-1-ebiggers@kernel.org>
In-Reply-To: <20260218042829.68334-1-ebiggers@kernel.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 18 Feb 2026 21:50:54 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8mqN8kf0KvKTaztPntQ9pGUKsBLZ-9rmtZ2F7P0T2=tg@mail.gmail.com>
X-Gm-Features: AaiRm51zi4rh83vQtzblcIzkx9fhf2J_4Hjb1j4TFHhrwKK5xpELUnocXHIP4aw
Message-ID: <CAKYAXd8mqN8kf0KvKTaztPntQ9pGUKsBLZ-9rmtZ2F7P0T2=tg@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: Compare MACs in constant time
To: Eric Biggers <ebiggers@kernel.org>
Cc: Steve French <smfrench@gmail.com>, linux-cifs@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	Ronnie Sahlberg <lsahlber@redhat.com>, linux-crypto@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,chromium.org,talpey.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-217283-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8A4E1566F9
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 1:29=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> To prevent timing attacks, MAC comparisons need to be constant-time.
> Replace the memcmp() with the correct function, crypto_memneq().
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Applied it to #ksmbd-for-next-next.
Thanks!

