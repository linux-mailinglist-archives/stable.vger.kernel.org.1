Return-Path: <stable+bounces-233288-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFqkLhAg0WnGFgcAu9opvQ
	(envelope-from <stable+bounces-233288-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 16:28:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D13C39B5ED
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 16:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D4EC300621C
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 14:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF5627A47F;
	Sat,  4 Apr 2026 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHn8yRTa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868CE2BE053
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775312906; cv=none; b=ZeW7TAfOL+6e3rv/GZaTJPLB9/HWB0UfSQXcri5HeJe4/N2kouRF6BIA6Nyq6MN2jvSetaHVx+Wsxwl2q+JsOEEiud1PrklxehJyQKeVQCwjz8EKQGL/QppnV1y/l6B2z6WIEB09HLIwAc8b5L50hYH1rBrxPKWcKtUbCsstCCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775312906; c=relaxed/simple;
	bh=OUskXKzbth7ggJphATMPraSMFrxkBsGJGt1vZJpuYsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4ygi7174bGegobQBF+e/+eeqyke6lfYF6Dp4y80qADiPHRNM5luIFXoMfuEINvOMC5OMJpu4DHcDfq3Wye93GNOfHANpg0LVzMd8kprh+JgwhFEUNPW3eD2YlxhkatDcKGwgX4tP1usqnSV+rg8AWhw7H7GmkLuN+Qcp2RSLvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHn8yRTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E9BC19421
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 14:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775312906;
	bh=OUskXKzbth7ggJphATMPraSMFrxkBsGJGt1vZJpuYsE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lHn8yRTazkanj8XCubilvX701IGuS/ROzTEPPKSr/iU7yZl+OKaPpvj/hXPSOlDOk
	 1OQ27oQu8FtunopQ4ENg4S7gxcrjhhz3VPjbJxrLTRJ3poE9mGrIVJlWj0QDISF1wV
	 VKVliYQbob8xd8zs0yJH94vQRyBCYjmhQbhjCEeeiBAjNJ/tyg5hug9QTYosy76nqE
	 +xY2f1zED4Xd5B0wqhgak47GqkKU89EaumQ2VErHKXgQMuz+qRaqzd/cCK54rRN4Sy
	 /vJMfJnATzVleh8c612OqpSYQrLcvof4w7AQWwVUXcjMrYjvCZT5J5r2URfZy8vrjm
	 jpQZf3OrBBzcA==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66d65646c65so1925883a12.1
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 07:28:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVo1SPdzDIFDeKQcPZXhRwONH9dr7Jby/1lkd5+28NDCSGtLQIapUA8diXqX0f1vCiWKtaKiAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy10Cm/32fUQ/cJILNvWqJhow7KiONJCsKHYBzsRRVAqcb8ozjb
	CTbdVeKae4Nl+Uj8mUAZXBNT/3gSVsOaddIg2XPJ4L0wpIc0nua4jb65f8yN+RiCL4XrRiRPju0
	IlTKkbdvu2R4NrYCoLEBQMTJgaIpPqww=
X-Received: by 2002:a05:6402:5254:b0:66e:192c:e5bf with SMTP id
 4fb4d7f45d1cf-66e3e3f39ebmr3148063a12.7.1775312904616; Sat, 04 Apr 2026
 07:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402083912.457676-1-munanevil@gmail.com> <CAKYAXd9Qnq6YgTfbS-59YATBvnbtKrX3w+D+WNk=izZVvQOoVQ@mail.gmail.com>
 <904cb9a8-2ff5-4725-8ce2-f70c4f98791e@chenxiaosong.com>
In-Reply-To: <904cb9a8-2ff5-4725-8ce2-f70c4f98791e@chenxiaosong.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 4 Apr 2026 23:28:12 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-izPxXKFuzEPYPknwUFG_jQ37yW90D1zCpO_zWxCNJQg@mail.gmail.com>
X-Gm-Features: AQROBzBXu3I4dM9IGZndTZBC4_7GX2bYTtUDu3bcdXjsg9He7krPwsJZgvx-Q_Q
Message-ID: <CAKYAXd-izPxXKFuzEPYPknwUFG_jQ37yW90D1zCpO_zWxCNJQg@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fix use-after-free in __ksmbd_close_fd() lock cleanup
To: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Cc: munan Huang <munanevil@gmail.com>, smfrench@gmail.com, senozhatsky@chromium.org, 
	tom@talpey.com, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[gmail.com,chromium.org,talpey.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233288-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9D13C39B5ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 4, 2026 at 2:03=E2=80=AFPM ChenXiaoSong
<chenxiaosong@chenxiaosong.com> wrote:
>
> Hi Namjae and munan,
>
> In `ksmbd_reopen_durable_fd()`, when -EBADF is returned, should
> `list_del(&smb_lock->clist)` be called?
>
> If my understanding is incorrect, please let me know.
I have updated the patch. Please check it.
https://github.com/smfrench/smb3-kernel/commit/38bf2f4ac44b0848677fd4d53940=
4b8c0de15b98

Thanks for the review!

