Return-Path: <stable+bounces-238026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLsdEHwS32nYOQAAu9opvQ
	(envelope-from <stable+bounces-238026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 06:22:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E26400351
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 06:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D902E3017799
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 04:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4D4330B0B;
	Wed, 15 Apr 2026 04:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkD+DT8a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA8C326D45
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 04:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776226934; cv=none; b=cAAc6XgtqUcR7BZr/RgP0yWg/2by15n5DYnPuYd2nXepqh/bkFK/3JxT0ceh5nvIL9nEbXqr2HcocXLmiA5ikHjzw6U2w5Q0qQBGJ7NB/5Mq2e8O446omBGL6Tb0X3jGyZirfmlgqJsF2GvYE0ljkh2s+ijEQQxsaxpt8Q8OhVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776226934; c=relaxed/simple;
	bh=GUf5PKrIKfvd7WbyO0ssoN/5lZB9VybElqF957DkXPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uef1BUzTdBVzHJaTc3LyqX8+ILid7cGeOKHmWHuTKZNLN+6cdM8rO/Zt6cy1Ydn1reghrZM+nAvk3xdibBz02vzpeANbTKsJWO1pPx9iloyV8oyAISHQQNeYnTA496/9L70EpAFgMkFHr1F6d6TEBRm+LJAloGhSkCSB8Xg1Lmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkD+DT8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA50C2BCB4
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 04:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776226934;
	bh=GUf5PKrIKfvd7WbyO0ssoN/5lZB9VybElqF957DkXPU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lkD+DT8ao6jpaNNDifeMZ5ZGVPZBPVMD2/nCDFw3JFjABC2p4/I1dmM+aeDs42Qui
	 AwvY5N9j9tg2mNXxylKaFZSEfVbFp1bpW8hG40YRsN9Sxb0x5btnylwOkwgGxW5jRJ
	 1mG18pjFLZdc9j3XJ3ylGxANYjmP8vVeQkjGl1gfTB1O/W6B0INYp4aE+2kmUBnEDr
	 s40mzCXN+9F+zvXS7ymQjydP4XhPIpRlwwGavCtoe271h1/RxuPNXTyFxOmBV6aKGN
	 TwdIjCSpeoYuwZ21per2NC2eqvHugoFsWPS9rWqJc31DH7jFl3VE8xe0vsEOrWcfhU
	 +JL6p6Cmdz5ZA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6708cc2d6f6so7606154a12.0
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 21:22:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9k65dXDE0iMJNpWRVkLVaOPmq/7T4cXsaLLeeDbkKd9WGzfy/4Gj6DWAOPn1dXoiQro92jxU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQ4U0P8Hnci4k4PC+1SHvHobzIVasWFgZMIONJfSXU/ztTJM7
	jf5iBhQbCWx71eZSBKCxh6YpHr/Ssziy13uDvBmz1Pt45URRNOkjnd/v9mkdOyiN4nlBJXOJYyk
	i0AwtqJJ+7j8kC8QLxxp0BVfSkQVw8bk=
X-Received: by 2002:a05:6402:518f:b0:671:4f9c:f664 with SMTP id
 4fb4d7f45d1cf-6714f9cf751mr5750069a12.27.1776226932741; Tue, 14 Apr 2026
 21:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414191533.1467353-1-michael.bommarito@gmail.com>
 <20260414191533.1467353-2-michael.bommarito@gmail.com> <CAKYAXd-zwPuES8PdV+XQjuQUemVKejayqY_0aYS=88uZ=FG9+w@mail.gmail.com>
 <20260415023510.2659606-1-michael.bommarito@gmail.com>
In-Reply-To: <20260415023510.2659606-1-michael.bommarito@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 15 Apr 2026 13:22:00 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9EBFBcy9bJ3=sJiYVYHAYjKYqOqD53UCJ8zWKXF0sAeg@mail.gmail.com>
X-Gm-Features: AQROBzDnH204ozHkVxvQouLdZlt6lGsvRUy8zmBUdbe3nfoM3E9c6j6xUR5QtpA
Message-ID: <CAKYAXd9EBFBcy9bJ3=sJiYVYHAYjKYqOqD53UCJ8zWKXF0sAeg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ksmbd: cap response sizes in ipc_validate_msg()
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238026-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,chromium.org,talpey.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: E0E26400351
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 11:35=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> On Wed, Apr 15, 2026 at 11:00:58AM +0900, Namjae Jeon wrote:
> > However, on the userspace side (ksmbd-tools/mountd/rpc.c), the DCE/RPC
> > response builder (try_realloc_payload() and ndr_write_bytes())
> > dynamically grows the payload by 4096 bytes using g_try_realloc() when
> > preparing responses for calls such as NetShareEnumAll, etc..
> > This can cause share enumeration failures on servers with many shares.
>
> OK, thanks for explaining.  Sorry for missing that context.  If you
> are OK with it, I will send a v2 that drops the cap on RPC_REQUEST
> and SHARE_CONFIG_REQUEST and uses check_add_overflow() to just
> prevent msg_sz from wrapping.  The [0, NGROUPS_MAX] bound stays on
> LOGIN_REQUEST_EXT.
OK, sounds good.
>
> > You don't add the check for KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST case.
> > We don't need to check resp->session_key_len and resp->spnego_blob_len?
>
> They're both __u16 so the sum can't wrap the unsigned int msg_sz,
> which is why I skipped them.  Happy to add check_add_overflow() there
> too for symmetry and clarity in case anyone refactors.  Just let me
> know which you prefer.
Ah, Okay, no need to add the check for this if so.
Thanks.
>
> Thanks,
> Mike

