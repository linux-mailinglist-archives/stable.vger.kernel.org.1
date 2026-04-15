Return-Path: <stable+bounces-238032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KPDOkob32myOwAAu9opvQ
	(envelope-from <stable+bounces-238032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 06:59:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 576FF400486
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 06:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50978302E799
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 04:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBE1344025;
	Wed, 15 Apr 2026 04:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i40I64Xd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415B428DB54
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 04:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776229178; cv=none; b=kITKRIVX7gkL1zctYIbcFAO1DqDSlrJePdmuKeoTW9lOque1HFW+h+OMU7OqGTNbokhXx8rELGa6bdzDmUXYTxUTqVnrp7JYheTvmgtN7LSMRVsez+38lcFkfrH626HGwTB30T/AkGWbg0uFcLaM6cSpheoL9ONsVjOITWGDoLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776229178; c=relaxed/simple;
	bh=nm74J6zMW7Jm24cYJPZnGzZskMzr49BNL48S2Dz7OXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOGhJdpnnL70ZWicxTnSKT+14Fw2NEJBstCTtLciJZx5sLgxV6raoYH9eo4yY9y9ILZkPXbwzM/GnbgevNGyATsJsLRICIiSpf6HySMDN8Toh9frYJC3/OSGFVVS42cjKFXLuT8HMnzkmNi8JLEvKL4g2DyPP+C8rdRt7GlByn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i40I64Xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6998C4AF09
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 04:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776229177;
	bh=nm74J6zMW7Jm24cYJPZnGzZskMzr49BNL48S2Dz7OXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i40I64XdybPx2VnbwIcKE/AXUZKk79yVUL+eCwDIRJzk8Vd+Aq37IaRsRSJV1ADa2
	 dmuHvGDgI4bc4UqW9XoSDMixl+nL+OfbpdW1Sr8UPA+9Yin8J4HmoKH1Y4HPyW7vE1
	 35Bawtz5kx/cBzTWU36KK3t2lcYrF8lOuBQzXRsM6+uZoZngau++IjVckg6j/NNwDK
	 cjRdbkRBtKLvIHfQjiVwyGZIkslJYJo2W4vspLZS3+KDas/wmRPDeOE3OCBAk+kQbN
	 NZpUSltLgsJVZFA+kDNXNc7NglABLMjE/06eSEyk0QO+ynC7QDdMZOXXJY1uTxRGHr
	 YB6iR7hKKLM1g==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b941762394aso773043466b.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 21:59:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9W+mOogvoqXt8GolGjq2Yw/VlQk+HPukp0bfuZ1uW+u4F1GMGY33zeNjcfGjkx5pINk9bn2MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwMETZWtv4Fade2G8vOApxcMeGUh2aJ6jJiZpDKipH/uVrYhaR
	MyIq/fg/ox6nk5RbM4MhhoK70RxwWwPt72tStU262ThjRRZjFJaqnSNJN97rlRXSdUxR7eYi699
	NfeJDEjLylyXRNjRfyfcR500LJ/KCHDo=
X-Received: by 2002:a17:907:3f9c:b0:b9d:ee01:6bbf with SMTP id
 a640c23a62f3a-b9dee016bdcmr620159166b.49.1776229176393; Tue, 14 Apr 2026
 21:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414225438.2210243-1-michael.bommarito@gmail.com>
In-Reply-To: <20260414225438.2210243-1-michael.bommarito@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 15 Apr 2026 13:59:23 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_HjR=jTt7C9R3RZOSsD-C-OXG3xKv8aB7D5AsG+DeUjA@mail.gmail.com>
X-Gm-Features: AQROBzCSrNjyDBMPlhMEzBU4ImLJbaM4RLke-JPomqQAkZOzl8IEUCMKZIhSMgQ
Message-ID: <CAKYAXd_HjR=jTt7C9R3RZOSsD-C-OXG3xKv8aB7D5AsG+DeUjA@mail.gmail.com>
Subject: Re: [PATCH] smb: server: fix active_num_conn leak on transport
 allocation failure
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>, 
	Henrique Carvalho <henrique.carvalho@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,suse.com,chromium.org,talpey.com];
	TAGGED_FROM(0.00)[bounces-238032-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 576FF400486
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 7:54=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> Commit 77ffbcac4e56 ("smb: server: fix leak of active_num_conn in
> ksmbd_tcp_new_connection()") addressed the kthread_run() failure
> path.  The earlier alloc_transport() =3D=3D NULL path in the same
> function has the same leak, is reachable pre-authentication via any
> TCP connect to port 445, and was empirically reproduced on UML
> (ARCH=3Dum, v7.0-rc7): a small number of forced allocation failures
> were sufficient to put ksmbd into a state where every subsequent
> connection attempt was rejected for the remainder of the boot.
>
> ksmbd_kthread_fn() increments active_num_conn before calling
> ksmbd_tcp_new_connection() and discards the return value, so when
> alloc_transport() returns NULL the socket is released and -ENOMEM
> returned without decrementing the counter.  Each such failure
> permanently consumes one slot from the max_connections pool; once
> cumulative failures reach the cap, atomic_inc_return() hits the
> threshold on every subsequent accept and every new connection is
> rejected.  The counter is only reset by module reload.
>
> An unauthenticated remote attacker can drive the server toward the
> memory pressure that makes alloc_transport() fail by holding open
> connections with large RFC1002 lengths up to MAX_STREAM_PROT_LEN
> (0x00FFFFFF); natural transient allocation failures on a loaded
> host produce the same drift more slowly.
>
> Mirror the existing rollback pattern in ksmbd_kthread_fn(): on the
> alloc_transport() failure path, decrement active_num_conn gated on
> server_conf.max_connections.
>
> Repro details: with the patch reverted, forced alloc_transport()
> NULL returns leaked counter slots and subsequent connection
> attempts -- including legitimate connects issued after the
> forced-fail window had closed -- were all rejected with "Limit the
> maximum number of connections".  With this patch applied, the same
> connect sequence produces no rejections and the counter cycles
> cleanly between zero and one on every accept.
>
> Fixes: 0d0d4680db22 ("ksmbd: add max connections parameter")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: Codex:gpt-5-4
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Applied it to #ksmbd-for-next-next.
Thanks!

