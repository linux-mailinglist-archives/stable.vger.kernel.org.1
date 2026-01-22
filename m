Return-Path: <stable+bounces-211228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKc4Ku0ncmmadwAAu9opvQ
	(envelope-from <stable+bounces-211228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 14:36:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C99F5675F2
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 14:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A804E56C97E
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B0433E363;
	Thu, 22 Jan 2026 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3fQ6Rqa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD2D338F5B
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769085135; cv=none; b=omUfmHiY1dv+maf1O2ZqAjDw0Gv0xtmmGPX2nDkC7NicIVCxNzU9rFWWuHjGD0dOTJaBdeh3mtdfNJRAE/A1cX3sW5ZPaQJLwNCPZCGq9psh0fU72sO79A6R6l5hHDEfglzVxlHA9BJxx+Jl41WOiYXa3giUiOepP7H5aox5wxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769085135; c=relaxed/simple;
	bh=d8Def9PVTqewssSlh9dZ/Q2Y8Z89O1Lw2ILvhmm6flg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuE8E9QWncHo2QBA+34hLVyNPcCoZhefLiJqQPn+7juVhKvDV2wDZ2BZ+Irk7/heGq0//uE0dhmIu73LqngJS/yJeGXHL2Mjq9FVuQSBd9ZHgWBYEqCJDgtjsVdiYK3j1xjdwTZuA0L4/VTYxFNnqBBhEmMvI5LCoLv6fROMvvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3fQ6Rqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DC6C116C6
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 12:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769085135;
	bh=d8Def9PVTqewssSlh9dZ/Q2Y8Z89O1Lw2ILvhmm6flg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n3fQ6RqaTDre0jKXjOOMrzwL2UsSQSWIOzPzmC6s+mjieiaumvykG9+F/0jmXVKi0
	 V3j/UKZgSJoLC9GQfMTO4LrWtck+sHD27nd9QqqnGGmhUA1kxH4i2Ta9bpDRAANn+Z
	 MXchKolNrH3CzgzJ2KCXDg+m7XYtDXv6JFDzKJ2v5R0jSFS/7W83O5JqKxu/M+91tY
	 NBmSzIu41/PlJIluX45pKxeFdnq3GsgjJTOVl95UFlk9crupJu0XNhke4qloqSNaD1
	 JJrfedkbJXrLetuqiqjyVSjCguYaPBNnLBI9vg3sdT0kWcZvuXdRNsz+gv7ZVxdjQw
	 fhWNikzHXOM+A==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6505d3adc3aso1255975a12.1
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 04:32:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgb2FkCrFaPw+2qKHxsPTJzrqWHe0ZssXuA3pdSlqjhDiuSk/fa62S3+RUnnamtCjIfqziugQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6jYM49YWtEWohphL0O+RIF0OBfAq9wAg+UjmknI4nirAfsKod
	coM6DeGVZ3E1AOcF4ZBc8Sd5iH0Of3gsRq1FS91xWPYkrTYlkhG2nEpphBETpDRpKa9/KnxD2hu
	c8B0Srp5pzNcKbCn1amSJGEEB7xpEsp4=
X-Received: by 2002:a05:6402:2342:b0:649:815e:3f9b with SMTP id
 4fb4d7f45d1cf-654b9364eaemr15295455a12.3.1769085133730; Thu, 22 Jan 2026
 04:32:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769024269.git.metze@samba.org> <1f60cea1eae937938070f66f1b8343107a1155fd.1769024269.git.metze@samba.org>
In-Reply-To: <1f60cea1eae937938070f66f1b8343107a1155fd.1769024269.git.metze@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 22 Jan 2026 21:32:00 +0900
X-Gmail-Original-Message-ID: <CAKYAXd96QRnjDmQRRy9BDN+4ikec1DAbT8FCESwMVL8+PJebVA@mail.gmail.com>
X-Gm-Features: AZwV_QgitcCrjyLBq2mrXyuQ8g1zGXIhjdfOfnkcuui8dGFK79XQBXvC5CAuw6E
Message-ID: <CAKYAXd96QRnjDmQRRy9BDN+4ikec1DAbT8FCESwMVL8+PJebVA@mail.gmail.com>
Subject: Re: [PATCH 01/19] smb: smbdirect: introduce smbdirect_socket.recv_io.credits.available
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	stable@vger.kernel.org, Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>, 
	Long Li <longli@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[talpey.com:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.samba.org,gmail.com,talpey.com,microsoft.com];
	TAGGED_FROM(0.00)[bounces-211228-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: C99F5675F2
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
> Fixes: 5fb9b459b368 ("smb: client: count the number of posted recv_io mes=
sages in order to calculated credits")
> Fixes: 89b021a72663 ("smb: server: manage recv credits by counting posted=
 recv_io and granted credits")
> Cc: <stable@vger.kernel.org> # 6.18.x
> Cc: Steve French <smfrench@gmail.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: Long Li <longli@microsoft.com>
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: linux-cifs@vger.kernel.org
> Cc: samba-technical@lists.samba.org
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!

