Return-Path: <stable+bounces-233048-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLRlKCWRzmkbogYAu9opvQ
	(envelope-from <stable+bounces-233048-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 17:54:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F87238B827
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 17:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01C133028346
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 15:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B6D3D6484;
	Thu,  2 Apr 2026 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=p2p.industries header.i=@p2p.industries header.b="ldnRa4Fz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF33F3570DF
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145225; cv=none; b=RzswTxjppYZIsl52Pz+WQuFL+2bXmuta87eiuWujHDfoRDIall+1idLGiaxqHVKjCqbu9YH+BYLItonqh4ueD773Tvpn18/er0MwAI1cHAliDguodAwcqEK74BXnRuIyt7V8ETTie9OoFc+wDZ3x4xwW3jRnzHXT9cK+v3EA2aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145225; c=relaxed/simple;
	bh=KYoX6gKN6gt3nY8hNo/FfNtKjn/EfpgeJwnbJ6NulPE=;
	h=From:Content-Type:Mime-Version:Subject:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=K5y38gPv6++fPk5E2+itFyMSHRHRMBZHUVd4jZAYCnIOSaiflg4Zw3Rb9qVweLBmV4XHm3rDegX405m7R4wvglxmPOPAM1/3cB2/y8MT7btUSYaq7ycbWW+IYpf6IGMXvijmZt3O/VqS8stth/GPFu/nCea/yEQR3+tai6qAE5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=p2p.industries; spf=pass smtp.mailfrom=p2p.industries; dkim=pass (2048-bit key) header.d=p2p.industries header.i=@p2p.industries header.b=ldnRa4Fz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=p2p.industries
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=p2p.industries
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48541edecf9so12378775e9.1
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=p2p.industries; s=google; t=1775145221; x=1775750021; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5SEopH7qoOVm2O4AeVWA5YO/SyHxUnzqAKH92QpDAU=;
        b=ldnRa4FzLKlCGCtxlZzrL4XkXisDYJzYd04thKOZLnRb78SaTFsialiV0v4tBZjdvP
         qlZBz8uAb1EPsil0UYunEw6WLQDFB3ORwma629u9dJntrCllkRcKaaxqnGzhSRFXmzZa
         xp10hYYXto9kHrkbubiEwdHAwVnuvKnFth+CsckWEkJ9fSxinn0P4K1UFcHL3RQbeUtQ
         INbaLq3k5ZgEQ+8hXkt5Z534eO8L8IMocB+zDCOW5ll1aiJj3Y6qq46hmfSrIe7geTns
         DUUWK7LX3OchCSLya27PCig5n3C8e4hA8M9z7OFe6id3sifj/gAvg7iBXUvguzNyhkEs
         X4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775145221; x=1775750021;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5SEopH7qoOVm2O4AeVWA5YO/SyHxUnzqAKH92QpDAU=;
        b=NCl60g0QeOHMuv5lAiMeZ3s3pvlM5S2if/UjIo8wAcsrsd2BnxIqen9GjuWZXqXxRY
         YChB8zJUcYaosavKyZbvIqn043IXgN07686gPU7hBY26VGT2JLKDVta7gAu6ZKQhQkxz
         xl8SJSE/cocoPom2rwHEEoUpVZ5zbwvqkuiT4VOm7OrrG92G5qNClOzxqllVqeRMKUf8
         UHoWKTkKM9gZd1mlQk3gj5HEa6d3qsTZM+MqsNEXxxEi/5r643D3+L3w4BDM4CCrhXqn
         +YcR6bAB87g/Ocns1jDOixs93pH/AJf0fhf/5VSTkuHeKxcuqV9Jg5R88EvnsEdtyAHL
         4Mpg==
X-Forwarded-Encrypted: i=1; AJvYcCUshGAnP9TGFkFEJnP1FjKkP1EnNMvnLzOYyOq4RDSpuLKnAW8CWnEZKBStWdaMQexy/EmsmRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHnH7/Wu5rRhPmUq8UmPicjOjtTTGTyXM2Tqf7nDJOv1ceJX0J
	cWyulxG+buhYP87Ao2InwyERkd7rb5GBtnDKm4qGc+pAor5zMVdDq10+KoGMknT2T7DkONIUgCS
	67Ppe1F0=
X-Gm-Gg: ATEYQzwrNoM95hjFDSYoQdzaQjNtTAh6/7gSi6UqkHnz0hwbNhwSrv45jdXuzgy7OM5
	qEbfZni1yGWifCPPV0gsvsfX8UVc5KogvWMLwbD7AWxVQ2hOpb/JSpzuNbht1qi+aiBOXQv+mGO
	SMZ1ya5NDn/oLpMUe2aAXDhnfJkDI/XejGrdew3A2SLljJOsRhFyhCdSOqr6O92Gt0Aqrp8vdhL
	5yWSDD6ucqa83gyYx+lcilgrYUGsYbbNzI4hL7ct0wfzUSbsTJU7vOpBSVQRHftCRL4brytK2Hh
	nOI8v8z3eLWTngDfPJSd88MXeKgCuV7RKFNeXNEfVcuIAth78qJjWpkA/dsZZpCpPa9huhCVBFV
	8IlviizS3XK9bsqOLTMCRADshAPgUzFW3kKVXXqxXYxiC1YgFnilagXsSapPJUFgLUYgXtOM0/5
	NsomYNsgNMPngQ/JJ+jm0XGD6zGQOoZPku2URrKdoEm3y+X4KtYkqLMZl6Kw2sG/S5udLQSHVTp
	ZlFV42xoaxclznWNWxhhG87
X-Received: by 2002:a05:600c:3e87:b0:486:fba7:b150 with SMTP id 5b1f17b1804b1-4888359cfc8mr148410665e9.15.1775145221141;
        Thu, 02 Apr 2026 08:53:41 -0700 (PDT)
Received: from smtpclient.apple (mob-194-230-144-149.cgn.sunrise.net. [194.230.144.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887eb5aff3sm285397555e9.15.2026.04.02.08.53.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2026 08:53:40 -0700 (PDT)
From: Hannes Furmans <hannes@p2p.industries>
X-Google-Original-From: Hannes Furmans <hannes@stillwind.ai>
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2] io_uring/net: don't check MSG_CTRUNC for
 IORING_OP_RECV
In-Reply-To: <20260227162730.79355-1-hannes@stillwind.ai>
Date: Thu, 2 Apr 2026 17:53:27 +0200
Cc: Stefan Metzmacher <metze@samba.org>,
 io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9651A09E-97B6-4EF2-806C-4EAAF96C9C93@stillwind.ai>
References: <20260226220310.758404-1-hannes@stillwind.ai>
 <20260227162730.79355-1-hannes@stillwind.ai>
To: Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3864.500.181)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[p2p.industries,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[p2p.industries:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-233048-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[p2p.industries:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@p2p.industries,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	APPLE_MAILER_COMMON(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[p2p.industries:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,stillwind.ai:email,stillwind.ai:mid]
X-Rspamd-Queue-Id: 1F87238B827
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Gentle ping on this. This is a one-line fix for a real bug where =
IORING_OP_RECV on kTLS sockets spuriously fails linked ops due to =
MSG_CTRUNC being sent by put_cmsg() when no cmsg buffer is provided.
Stefan indicated the approach looks correct. Would be great to get this =
into 7.0 if possible, as we=E2=80=99re in the RC window and this is a =
straightforward bug fix.

> On 27. Feb 2026, at 17:27, Hannes Furmans <hannes@stillwind.ai> wrote:
>=20
> IORING_OP_RECV sets up the msghdr with msg_control=3DNULL and
> msg_controllen=3D0, as it has no cmsg support. Any socket layer that
> calls put_cmsg() will find no buffer space and set MSG_CTRUNC in
> msg_flags. This is expected =E2=80=94 the caller didn't ask for =
control data.
>=20
> However, io_recv checks:
>=20
>    if ((flags & MSG_WAITALL) && (msg_flags & (MSG_TRUNC | =
MSG_CTRUNC)))
>        req_set_fail(req);
>=20
> This sets REQ_F_FAIL on a fully successful recv (ret >=3D min_ret) =
when
> MSG_CTRUNC is set, which causes io_disarm_next() to cancel all linked
> operations with -ECANCELED. The recv CQE shows the full requested byte
> count, yet linked operations are cancelled.
>=20
> This is triggered by kTLS, which calls put_cmsg(SOL_TLS,
> TLS_GET_RECORD_TYPE) for every record in tls_record_content_type()
> (tls_sw.c), but it affects any protocol that delivers cmsg data on
> the kernel side.
>=20
> The MSG_CTRUNC check was introduced by commit 0031275d119e ("io_uring:
> call req_set_fail_links() on short send[msg]()/recv[msg]() with
> MSG_WAITALL") whose commit message states "For IORING_OP_RECVMSG we
> also check for the MSG_TRUNC and MSG_CTRUNC flags", but the code
> applied the check to IORING_OP_RECV as well. MSG_CTRUNC is meaningful
> for IORING_OP_RECVMSG where the user provides a cmsg buffer =E2=80=94
> truncation there means lost metadata. It is meaningless for
> IORING_OP_RECV which never provides a cmsg buffer.
>=20
> Remove MSG_CTRUNC from the io_recv check. The io_recvmsg check is
> left unchanged as MSG_CTRUNC is meaningful there.
>=20
> Fixes: 0031275d119e ("io_uring: call req_set_fail_links() on short =
send[msg]()/recv[msg]() with MSG_WAITALL")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hannes Furmans <hannes@stillwind.ai>
> ---
> v2: v1 incorrectly guarded req_set_fail() for all done_io > 0 cases.
>    Stefan Metzmacher correctly pointed out that short MSG_WAITALL
>    reads should still sever the link chain.
>=20
>    Root-caused via ftrace + msg_flags inspection on a real kTLS
>    connection (TLS 1.3, AES-128-GCM, S3 download):
>=20
>    ftrace shows io_uring_fail_link firing immediately after
>    io_uring_complete with result=3D67108864 (full 64MB), from io-wq:
>=20
>      iou-wrk-52242 io_uring_complete: req ..., result 67108864
>      iou-wrk-52242 io_uring_fail_link: opcode RECV, link ...
>=20
>    A debug recvmsg on the same kTLS socket shows:
>=20
>      recvmsg: ret=3D67108864 msg_flags=3D0x88 (MSG_EOR | MSG_CTRUNC)
>=20
>    MSG_CTRUNC is always set because kTLS calls put_cmsg() but
>    IORING_OP_RECV provides no cmsg buffer.
>=20
> io_uring/net.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/io_uring/net.c b/io_uring/net.c
> index 8576c6cb2236..8baaf74e8f8d 100644
> --- a/io_uring/net.c
> +++ b/io_uring/net.c
> @@ -1221,7 +1221,7 @@ int io_recv(struct io_kiocb *req, unsigned int =
issue_flags)
> if (ret =3D=3D -ERESTARTSYS)
> ret =3D -EINTR;
> req_set_fail(req);
> - } else if ((flags & MSG_WAITALL) && (kmsg->msg.msg_flags & =
(MSG_TRUNC | MSG_CTRUNC))) {
> + } else if ((flags & MSG_WAITALL) && (kmsg->msg.msg_flags & =
MSG_TRUNC)) {
> out_free:
> req_set_fail(req);
> }
> --=20
> 2.53.0
>=20


