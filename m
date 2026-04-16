Return-Path: <stable+bounces-238376-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id V929A+Nz4Wn4tQAAu9opvQ
	(envelope-from <stable+bounces-238376-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 01:42:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7008C415B15
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 01:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F44A31333C9
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 23:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDE939A07E;
	Thu, 16 Apr 2026 23:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHSY6H4H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD67383C7E
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 23:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382618; cv=none; b=tHWkXkG/XtdLva2ey7wCO+jreH5moRIY+AlCCfZ41FwMipwG3v/p2axgxesuuIDtOZMXBUSem9hsbl+l+9yjIxVb6+dKt173WJoGEnXWqIWYp43ygPV0Jxn+AQKwEiQxAHtmVlhcZafpMSfmgJY7NbmzGCKomkAe5RiuZeFl7DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382618; c=relaxed/simple;
	bh=Ia4Z1gW6inXqBnNjZ5tfjmiMCPXDFFfczDlGe0Y3rA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H722NOZgnboxsH1ngHmh9wY82WY0+7iWAPBLn5EfeLHv7cveCr5TZo1SsmNvCKNXMbPJLnzWJdVz79rFv169dazJRAbfHWKmrzN8IlP2m62NepnzNvo6oHypERPhr9EsmjFtcB2+K29Egl71ecrD7ScZ9By9GG0lZIMAl1KIlUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHSY6H4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98DAC2BCB8
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 23:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776382617;
	bh=Ia4Z1gW6inXqBnNjZ5tfjmiMCPXDFFfczDlGe0Y3rA4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nHSY6H4HzrjG1B7ncgE10nhlBQ7WknRrHPKmbUNXlcwrnhGRl5eVmTSHviyuJXp8k
	 /G+r62TmWTB0kXX+HVImcHx1VusvuKkQjUrKW58VayWTwUGBOKGc4uwzodgJsqA7wf
	 LI/WAQ8QejwDcnGhm6duFABlx4t89+R3CJtbq8PSOJTJEsE4QSDvConlxbRu7JAD6B
	 Xq+MNiG/6yTPLX8Kfm4j4pwHOLUfFVpqLPsygAl7Jp6Nkr3QkP7LQlHNUjDJ4TeI9V
	 KSs46Xda+FSfm7ENDBrbKt/VbnqaNPuTO3x8YjIe77otNHZHtEVj/bq7l7QJgnFGgu
	 IB7INjhGlrZ/w==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-672bd8d2400so108403a12.1
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 16:36:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/IsE4rMi8QB9/DGXxiuYzm1zXRQinB1+7fLUmBbxNyTuHVS4ri5vFxyJVUyinlbx73fKzNY4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGb+r+bMBRXCkF83A33XdmwFIhlHdYPWvOWGiu6Pn//UXMHBmn
	CzkqH7ifkfOwzKf8TBdbNxDaYCBMk061clQVw/+W+lX2/C9XqD6Qsyufou9UOndgKLxeEUU9u0F
	OT1tIhJfio62Nfkj/+jIx2r+mf+AsNqU=
X-Received: by 2002:a05:6402:24cd:b0:66b:aa56:ee5c with SMTP id
 4fb4d7f45d1cf-672bffd3a22mr237465a12.28.1776382616452; Thu, 16 Apr 2026
 16:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416211735.3558718-1-charsyam@gmail.com>
In-Reply-To: <20260416211735.3558718-1-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 17 Apr 2026 08:36:44 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-P=E+bc+3W4DffU4SRtBDysJ+0yhmsxX7LvNB_8vR=sQ@mail.gmail.com>
X-Gm-Features: AQROBzB66y9CrUgy1WHZWYxRh_RXy7Qc-7PMcqfpOvkbqt64rMF7nxAIdWWdei4
Message-ID: <CAKYAXd-P=E+bc+3W4DffU4SRtBDysJ+0yhmsxX7LvNB_8vR=sQ@mail.gmail.com>
Subject: Re: [PATCH] smb: server: fix max_connections off-by-one in tcp accept path
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,chromium.org,talpey.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238376-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7008C415B15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 6:17=E2=80=AFAM DaeMyung Kang <charsyam@gmail.com> =
wrote:
>
> The global max_connections check in ksmbd's TCP accept path counts
> the newly accepted connection with atomic_inc_return(), but then
> rejects the connection when the result is greater than or equal to
> server_conf.max_connections.
>
> That makes the effective limit one smaller than configured. For
> example:
>
> - max_connections=3D1 rejects the first connection
> - max_connections=3D2 allows only one connection
>
> The per-IP limit in the same function uses <=3D correctly because it
> counts only pre-existing connections. The global limit instead checks
> the post-increment total, so it should reject only when that total
> exceeds the configured maximum.
>
> Fix this by changing the comparison from >=3D to >, so exactly
> max_connections simultaneous connections are allowed and the next one
> is rejected. This matches the documented meaning of max_connections
> in fs/smb/server/ksmbd_netlink.h as the "Number of maximum simultaneous
> connections".
>
> Fixes: 0d0d4680db22 ("ksmbd: add max connections parameter")
> Cc: stable@vger.kernel.org
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Applied it to #ksmbd-for-next-next.
Thanks!

