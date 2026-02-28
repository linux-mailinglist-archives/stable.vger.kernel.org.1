Return-Path: <stable+bounces-220068-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2uXZM1n4omn18QQAu9opvQ
	(envelope-from <stable+bounces-220068-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 15:14:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B79471C375C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 15:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6989E307A3C6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 14:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92B83E9F86;
	Sat, 28 Feb 2026 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYv5GfAY"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253432B9BC
	for <stable@vger.kernel.org>; Sat, 28 Feb 2026 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772287929; cv=pass; b=U/jnOH9SKF5kAeZS2B4vRHftXX7yPqBRvd7XOUzgrAFc/4evOIOaiNxB/zu2B/ljTWKT01u4UUZTwhIWG4xevmGa1mLkA7ZN+be6p88UJIfMqPMHb1XRoD+3p2/+ESIG3YPqaXaSkMq1vmWMrgEemSejK2eJB6MjqhXRt+XA+uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772287929; c=relaxed/simple;
	bh=eYvunH5f5GZ/tmvzK/aIBiD2hOhAPgJXF7MbD9moziY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnEKUhD/Uw/lh0M50qjb20q9TDwxt+LhFC4b6W/RqZb/BUo7sqcmd6KdEIuG6ZT7zN7/Tqua+txz3EGzbeUw45WqF4iy4FOfZadKTUsR7yawjbjWMLevIgTvamV3gHj+GhY74ugz9UCDAKvwc32JUuKxuLpTD+VV5SkfqDiyQrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYv5GfAY; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-124713e4244so150820c88.2
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 06:12:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772287927; cv=none;
        d=google.com; s=arc-20240605;
        b=gujFMtlh9tFK6qAXI//o2qXmjvZh0K1YmjsbZ7U2IUUoganOZJalWbVgdKMUPrmMSD
         ZF7HD1scYxyXbf7cC1QYuD15k3Jhx4FzAtIpzZgBc+r/BNbps8Bpdk0EdX7WPQimVhDJ
         VUQYd2H/o0jfQ5mMv0Lp7eTJiOCkzrCq8d+h9HJ2BErAj/QGXYQdj8OzaaxOc4tRU6tL
         nenH90tYfagp9S+Bc27M3iX3l8JcSgLrZFmYx/YkHGgJj+zEtYHZZ+LO4VAvmfzj4o3z
         262TICwq4sdNzhfvJaNQsNiv5MCOXRXtFAWWIOp/33gyff4P8TILFrY9iBWUGkYkxPnY
         YTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eYvunH5f5GZ/tmvzK/aIBiD2hOhAPgJXF7MbD9moziY=;
        fh=X0e0Ghgo7My3okOkCT3yL04KLnXvUYU6tMU0KRlcG+A=;
        b=WN66jJCPCPY1KGPzGDbtOUwkmrHXn7UjsvsuwgcJ8XFAygL5QS75BlQU5JO3mUV11b
         Yt6ifQpQ5+PJAtVjWl0v3h+kosMw1mvg41O0bofcQfhUq7SkfaaCpYNSJWaGXZNtkU5a
         D239J8Aqe1dDYXqumAlwLcY/iQGw8xpmUKlUEjup/axX6A5t97gcWNQebWulGOnDKYT7
         I1rs9yhXL+/o7WtNOw+53/nnA5vfiG8T+30434s4JhxaX0sy0UsxFFcGrlPM5Gol/fTw
         2y/VcWhou99zFO9MfoCMHdYXBAGtMiuSeZ9zkvyxe7s+8V/xNps+TlvHkkzcp8n5p9hV
         aCfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772287927; x=1772892727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYvunH5f5GZ/tmvzK/aIBiD2hOhAPgJXF7MbD9moziY=;
        b=cYv5GfAYLO4cUZo1XMm5bsijFwq2xodYdwsKUeza5ahghDbh01cpgSuY2OrDa1m36R
         ZMb1IUnMHtUBVc7hwi7PTB2TrnNc4nn7nvoLdJUZS03S+IWaJoZb5wJjFnQolZOHgXCp
         1VShjS2A8SaqCpVO24/TnzMyibrOWw+TDXHho6CrVter1Cj7+agTKQ5ws9n83y4cPZSU
         BUTTyy/Yq4JEzaXt0z+PJOMX1FqTL/ztw6wN778TumpRBnEwejDgk42L+s8lZWpdv2E9
         ONXdxf84ZUHHL+6tk8aBTKEHcbUrAzd8fel+DzakcyM4POOxVunRMtgVQg+Lk+0V9SRc
         bnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772287927; x=1772892727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eYvunH5f5GZ/tmvzK/aIBiD2hOhAPgJXF7MbD9moziY=;
        b=hQ9hc91UoUvZccYZnE3nkTQxp68UPWLkbLtwjFbCqayaNmJpcgISyH0FiHmluqHTQe
         SfxJGvzoAMbMEXnxrCiKWwnDLjW9kQKSVsv4d/8FqrHqAIhHbk9Lw7hP7/JO+Wnna4wT
         n8/K4x++MLv+9ZGHsAUiX+6KbRFPgA6drsd9g22ROUE7o4y7URpHXdFjrFYVtcM/sLQ9
         zcSbcMpIINrFe9CAkghd3ODe15ARnKY2W0WnD1xJ7DYY19tLwRacKoCMsJcOKq2CyzCI
         kPt+5Diy6snSEq8ryJV1/nmVAb9/UzFVCZ5oAoX4Vw+NBfFzpSvfToJHd/HIsA7kRgpZ
         ttQw==
X-Forwarded-Encrypted: i=1; AJvYcCXv1lGRr56mMobCIaiDTQKCC2EJ3ykPqqpJ6NZHPjJ7dUiLTeyBprEErFJnc4+Wq3AuD5fSeSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8M93U3RMfW4zMZ/pb+3YDRhI5HVaWkcNT5VLsCK6OZG1PztvZ
	+Z0fPNqc81/kNJ21q5xfgedBWdHK8II4x7CxwwSpQc7Try2M0PVmX9S2CkWbQc6HejXLVot6Uos
	auuGhmm3rIGZJ780GmvW+kVv99EIyq4c=
X-Gm-Gg: ATEYQzydMGwRqJtErDRTevebYh3UDkrXW0rgKqaTBDqA6QkNppdmVNxgCkk0K8wveCt
	B6acKzP/dFrW3TCqG4S1pfT5Cwdnuuu0nlG4Rk+KxWXgifkDlqHxr25q+TgPLQpzhBglr4GbzzC
	11YFH0p+nEVTDu4YqGkfSlLHJCe//dI/uXS4WVRvyYMlAOHgJj2807ADuj6j4/jNEA5mH/mkmYH
	C+jWYQDLcLiXSIgLQzmUfzPK80y/HZvtpp8N7CNBfx8Iem6S12fgD7zMAKILrXHLymDUt5Ui05S
	Z/kgOmveA8XOyxFQhMyglw2a8b2D/Z3be/f9qxsStb3LduVHQDlIfyPjdn781BBtxLixX0hzb4/
	J2hyHz4aMxts8SEK9jBxMqxXiZmyk
X-Received: by 2002:a05:7022:23a7:b0:127:3480:7ca9 with SMTP id
 a92af1059eb24-1278fc28784mr1437005c88.2.1772287927451; Sat, 28 Feb 2026
 06:12:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228113713.1402110-1-lossin@kernel.org> <20260228113713.1402110-2-lossin@kernel.org>
In-Reply-To: <20260228113713.1402110-2-lossin@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 28 Feb 2026 15:11:55 +0100
X-Gm-Features: AaiRm50bdpCw4DQrGEpja2W7LIdiWCMX_uVEhlKL8J7eLvWCaya9K17Rqrn4d6M
Message-ID: <CANiq72kRjJj=sOke+PWwu7uphL0AsJAi1UL53AYrDzJ=4Z=0Mw@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: pin-init: internal: init: document load-bearing
 fact of field accessors
To: Benno Lossin <lossin@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, stable@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220068-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[garyguo.net,kernel.org,protonmail.com,google.com,umich.edu,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B79471C375C
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 12:37=E2=80=AFPM Benno Lossin <lossin@kernel.org> w=
rote:
>
> The affected stable trees that are still
> maintained are: 6.17, 6.16, 6.12, and 6.6.

Same here, i.e. 6.17 and 6.16 are not maintained anymore, so these can
be skipped.

Cheers,
Miguel

