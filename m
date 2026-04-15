Return-Path: <stable+bounces-238007-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKFGKuLy3mmIMwAAu9opvQ
	(envelope-from <stable+bounces-238007-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 04:07:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 284A63FFAFA
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 04:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9439308398B
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 02:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A55A28850D;
	Wed, 15 Apr 2026 02:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyLiJ5re"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD9D3A1DB
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 02:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776218759; cv=none; b=Y4Nw2zbiiwIRy4SkuIoWlJ6TL7HlbdhGMPepCXseJO7GR8uJzZCrCW4JIP8g19NGyBgBAVP9LmslhU8kPo0aAjDpTYoQPluXsCUKqiB2VY1xVD/CzmTplEGH/uT4kabLb+5oNioyk0hNGuGj2jCNQ35G/66Q6xx2WSbFCmEvOVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776218759; c=relaxed/simple;
	bh=ZRAPSS779XlvSrcDbAnAYpBjhtSu2NTgxiO1w/TXAbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpSlROQUf1q76sctHNHC1whrMpLvWrYULYNQxLYs5+EG0Pp1oLVN2FiYQv6eMX5XQGKUi3YBOF38qE1eKJVwtH8TDKGZpEQvxSEdFUATi86N6JbZMWPVEyuBLLFPfHB7wSTTkN3a2kkU48w3TiiuSPeUeDrjPtMjjXDqswUHLrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyLiJ5re; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24C4C2BCB7
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 02:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776218758;
	bh=ZRAPSS779XlvSrcDbAnAYpBjhtSu2NTgxiO1w/TXAbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gyLiJ5re7ez32jpagsSGWzStuD1Mg2TwIDQcMsrQtroQCpdgLRghns5SClBDP8k7L
	 y4MoZLkk+GIuLkNbLKFiHbzp8MGhkuk3F60ruy4ivlO4BIEkQJEpEyaBtH3gl6tCpY
	 99AZQypuPzb2o9yeFJW3cKOUX2fvvd+kehZWn9qgPMU37z95Qo3Eq7l3l6rCf7oOh/
	 qQVKH9YWEM46M0B/dUk5OPfEcVFH43xexIaEKiE/cc3h0wTx5TPulDL2OSJyfttcOs
	 s9jgBS+HWrnI1XwXKRLp8DjQLGv6JLX9Xyp1U79tFiJ9cDKnnGjjncGMy/FJUIYD1G
	 2mrPp4zRmnDbw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-671ab90fc1fso4045045a12.0
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 19:05:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/io79WhE90fcrI4iRTQzzh7RBQCkDcBMLZVSC1ZuY64gAPbuPa9hq3xZ6fzyyoPrbM78L0lCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOQW98gixMDNjFaf94v87M2DnVu/x8ipUU9a6b3NzY4ThUPBfJ
	XuwFH0/ufIPXGatEtVirXzPZdCyEXTsqoBvoAmLRUoEh/+gAN7ceUM40gYfz5CCAjm11pn67Lj1
	s9h8pVs7fYUhNqSPQl31KInrgr5bAXfE=
X-Received: by 2002:a05:6402:613:b0:671:8ba1:e8ab with SMTP id
 4fb4d7f45d1cf-6718ba1e9a7mr3948658a12.1.1776218757351; Tue, 14 Apr 2026
 19:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414191533.1467353-1-michael.bommarito@gmail.com> <20260414191533.1467353-3-michael.bommarito@gmail.com>
In-Reply-To: <20260414191533.1467353-3-michael.bommarito@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 15 Apr 2026 11:05:45 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-pXiJy4S05C_s6sqz6FtnCeCh6Q2c4B7tPuHseA94mkQ@mail.gmail.com>
X-Gm-Features: AQROBzDVcTh38pxAIFoU8LssRoT-lh6vuP27HlEXphQNJLuEscIkchrpbrrRx9s
Message-ID: <CAKYAXd-pXiJy4S05C_s6sqz6FtnCeCh6Q2c4B7tPuHseA94mkQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ksmbd: reject negative ngroups in ksmbd_alloc_user()
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238007-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 284A63FFAFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> diff --git a/fs/smb/server/mgmt/user_config.c b/fs/smb/server/mgmt/user_config.c
> index a3183fe5c536..c62e2bf0ebef 100644
> --- a/fs/smb/server/mgmt/user_config.c
> +++ b/fs/smb/server/mgmt/user_config.c
> @@ -56,8 +56,8 @@ struct ksmbd_user *ksmbd_alloc_user(struct ksmbd_login_response *resp,
>                 goto err_free;
>
>         if (resp_ext) {
> -               if (resp_ext->ngroups > NGROUPS_MAX) {
> -                       pr_err("ngroups(%u) from login response exceeds max groups(%d)\n",
> +               if (resp_ext->ngroups < 0 || resp_ext->ngroups > NGROUPS_MAX) {
> +                       pr_err("ngroups(%d) from login response exceeds max groups(%d)\n",
With the previous patch ("ksmbd: cap response sizes in
ipc_validate_msg()"), negative ngroups is now rejected early in IPC
validation.
However, ksmbd_alloc_user() still needs an explicit negative check ?

>                                         resp_ext->ngroups, NGROUPS_MAX);
>                         goto err_free;
>                 }
> --
> 2.53.0

