Return-Path: <stable+bounces-211231-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJxuOEMocmmadwAAu9opvQ
	(envelope-from <stable+bounces-211231-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 14:38:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 871726763D
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 14:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25CA8769A3F
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 12:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2C8363C6E;
	Thu, 22 Jan 2026 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3zC6zRg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CDC3502A4
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769085320; cv=none; b=M4SnbMpJ8hjyVvDZM2//HV7weEce1ZwUSPpjQy4ow0QfcmCN0D+H7xygbsF8t0W3Ms127Qp2r2nyjJKfm1J5tY0OE49YwdMDBf5hAatmnnBttQi8msni+5KUsEmf3dB7W7739j+W4XDzS4xGUcOtEizIp3368VKsQMLkst3gmrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769085320; c=relaxed/simple;
	bh=boUE8pQjgwsiUXbOQjcunckhvyCOB8FiKWTL25NVljs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayj8fiL1yhXjgAW/4Pef3aeX4aM+m4/PJCxO2YV+IEUNtD1dixHBEHJt7EyqJADkP2skyZ/R92B8pdnqENRk3kg5/g6g67qRwO1YxSijUTOF1/J6PyUc1bfZRbl5zzBL1+Cy1zHyOxp19DMH3LaV4XsB8liDcbk8Eu2HIrOVhv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3zC6zRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326F6C4AF09
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 12:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769085320;
	bh=boUE8pQjgwsiUXbOQjcunckhvyCOB8FiKWTL25NVljs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b3zC6zRgVGNafpM9OXzAz5SiXPNOyghIEUjzSGetQ4lYQUJTP97GaICNKczceRAhJ
	 V+OshP/XDWbb2QvKx/XUmVaTvuDl3ZMayzcdxQSERy0eVYy3J+1ShtE1Bb8bYmVG2D
	 9g2nfPwLLdOm4/MqRLfigGHTyEthp7LkHE2pJxLb7IDizkBhK8WncuCetEkZFH7gPX
	 uQp4icbXEZ+ald0t6azs3WPyqTyxNl9eE6OX/3vlH83h7Vw3UrS5geQsaI8DQ9VTUd
	 muEFLAfzaPt7Zn2yirzaX6ckkNKzSgiO59izfoo3B+XDNH2Ckh3OETz5/BHlNlGan5
	 lM5/oESuqozXQ==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-658381b28e8so864183a12.0
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 04:35:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6wX00YUfj/Wl2TpmtpwDyXKuniFjtnVHW9WYoReFzhR7ZRq2kle2ZimRmTIK/cjPJdcoj78c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqbCv0SJ4OdSdIjCXcrJYGMZTVp421j3F+hFlisqaqOq2rpykL
	sGsQvARSxojJkuBQXN0a3ZXQa+AN98oIYyLiihYAKjwLwqKsZ1VFnofNUZYDs6v8wSa82ltKn/a
	eVU8haY/L2Og3KAwq0ylvqPKdWZwYbjg=
X-Received: by 2002:a05:6402:42cd:b0:64b:bb79:96a8 with SMTP id
 4fb4d7f45d1cf-654b93652f4mr16573514a12.3.1769085318726; Thu, 22 Jan 2026
 04:35:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769024269.git.metze@samba.org> <d70a09dfb7346e2c1a467610acda96699c91cf55.1769024269.git.metze@samba.org>
In-Reply-To: <d70a09dfb7346e2c1a467610acda96699c91cf55.1769024269.git.metze@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 22 Jan 2026 21:35:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9Qh36djuPHKhfWWwLWDKE2vPcHRruYhFUqnxEu+GLHSg@mail.gmail.com>
X-Gm-Features: AZwV_Qh5PtPM6w42YvUDbEqOcSKfAnofI7lHzP9u7rG7mxVeuZ-kYfn0v4dPT48
Message-ID: <CAKYAXd9Qh36djuPHKhfWWwLWDKE2vPcHRruYhFUqnxEu+GLHSg@mail.gmail.com>
Subject: Re: [PATCH 03/19] smb: server: make use of smbdirect_socket.recv_io.credits.available
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	stable@vger.kernel.org, Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[talpey.com:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.samba.org,gmail.com,talpey.com];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-211231-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,meta];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,samba.org:email]
X-Rspamd-Queue-Id: 871726763D
X-Rspamd-Action: add header
X-Spam: Yes

On Thu, Jan 22, 2026 at 4:51=E2=80=AFAM Stefan Metzmacher <metze@samba.org>=
 wrote:
>
> The logic off managing recv credits by counting posted recv_io and
> granted credits is racy.
>
> That's because the peer might already consumed a credit,
> but between receiving the incoming recv at the hardware
> and processing the completion in the 'recv_done' functions
> we likely have a window where we grant credits, which
> don't really exist.
>
> So we better have a decicated counter for the
> available credits, which will be incremented
> when we posted new recv buffers and drained when
> we grant the credits to the peer.
>
> This fixes regression Namjae reported with
> the 6.18 release.
>
> Fixes: 89b021a72663 ("smb: server: manage recv credits by counting posted=
 recv_io and granted credits")
> Cc: <stable@vger.kernel.org> # 6.18.x
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: Steve French <smfrench@gmail.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: linux-cifs@vger.kernel.org
> Cc: samba-technical@lists.samba.org
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!

