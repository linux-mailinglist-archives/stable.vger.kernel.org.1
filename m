Return-Path: <stable+bounces-216753-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFjiNFONk2mK6QEAu9opvQ
	(envelope-from <stable+bounces-216753-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 22:34:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 341BA147C65
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 22:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC408301D6A8
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 21:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472D1234964;
	Mon, 16 Feb 2026 21:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pg4lzm1v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0B1221FBD
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771277649; cv=none; b=tuTnfoIXcZNyDPg4lxQ0RX65imYKVo05t6EVulsR9ZQcQnuV/WI4FPSUB/SUp3cXWAM/OErUObyCcnPIoieP6Jn68yd+YlQapF3X0ZQhxYcr+6Vm9QoyPAg6PQdjfgmQUZKxa/y5aXgMEaL/BTNyH5bTzEArXyzhNRLt+0dd7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771277649; c=relaxed/simple;
	bh=4Jhi0Vr3WXvd41rWnA4mEWtsa/pMMuB6bKxFzG1Y6MM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgE2/GvSAagO/y6sft8NCEN8KMqz4BOC7J77IoUwqgdfz2jTdblCZ6dSQbo81WsIzC58GPGWnnUlPeNcMHx61gYZSofcgiSlQ5bsUzmY2saWoYwiODZIWO7s7DpDFbB7nspf7SYxqb7JhRcNDKTJDcDD/QDh7TiMRQgWwL2nAoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=pg4lzm1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C9FC19424
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 21:34:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pg4lzm1v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1771277645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Jhi0Vr3WXvd41rWnA4mEWtsa/pMMuB6bKxFzG1Y6MM=;
	b=pg4lzm1vGCmu3Lu10RGonaCTVeTzyusq3restCYrd/AEXLzYE8PfHFjVd3+jZ3uOoLLmI4
	VPvkGDF9hoHbRHyncFTN9uUqaepKkrJXo5+5QnpEMX+I3sHfkvGwdWm90fRt0cnd3kN8P3
	ep0/rRtvafVpdJnQOOizS8N/2gUFxgk=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0dbb423e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <stable@vger.kernel.org>;
	Mon, 16 Feb 2026 21:34:05 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d1890f7ee4so2116999a34.0
        for <stable@vger.kernel.org>; Mon, 16 Feb 2026 13:34:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJHmFBimy2VPkWNBvWtRC4uLn/ms+r/bCEr98HXONqlzpBRMEyFcaEIEjcusSGdr0f2PZ2u20=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOZ/XO7/wCHPT+3ZjVvlf7fWfXL4FSP3Cu0aW4eO/Z/tmHBI5J
	w5fFSiebr77QHd7kIUyRoPwZAEzgbOf/8AbiRJuyEMGeX85FLoWYu0g9ERnLeztciRxXCo2gJHE
	edv85r/3961wQRf1EE0n3cRPX5+KwFZM=
X-Received: by 2002:a05:6830:378d:b0:7d4:96c3:3f96 with SMTP id
 46e09a7af769-7d4c2fe5e18mr8466173a34.6.1771277644702; Mon, 16 Feb 2026
 13:34:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c05f3968fa63b630ce22d65aa03e6dcef4bf4e83.1771277247.git.daniel@iogearbox.net>
In-Reply-To: <c05f3968fa63b630ce22d65aa03e6dcef4bf4e83.1771277247.git.daniel@iogearbox.net>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 16 Feb 2026 22:33:53 +0100
X-Gmail-Original-Message-ID: <CAHmME9rsvaargjbZO8SkswOToUATuWpkQDVykEUty-kWPyu7gA@mail.gmail.com>
X-Gm-Features: AaiRm50xU5jthBlVzEVvTQWKub0ovtPSQ-UjS9U-vZNQZmb0qL-2F9sAcjUof5k
Message-ID: <CAHmME9rsvaargjbZO8SkswOToUATuWpkQDVykEUty-kWPyu7gA@mail.gmail.com>
Subject: Re: [PATCH stable v5.15,v6.1] Revert "wireguard: device: enable
 threaded NAPI"
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, netdev@vger.kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zx2c4.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[zx2c4.com:s=20210105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216753-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[zx2c4.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jason@zx2c4.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,zx2c4.com:email,zx2c4.com:dkim]
X-Rspamd-Queue-Id: 341BA147C65
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 10:31=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
> Technically, the backport of commit db9ae3b6b43c ("wireguard: device:
> enable threaded NAPI") to stable should not have happened since it is
> more of an optimization rather than a pure fix and addresses a NAPI
> situation with utilizing many WireGuard tunnel devices in parallel.

Indeed.

> Revert it from stable given the backport triggers a regression for
> mentioned kernels.

Thanks.

Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>

If that helps with Greg queueing this up.

Jason

