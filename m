Return-Path: <stable+bounces-246662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKuLA7WOA2qM7QEAu9opvQ
	(envelope-from <stable+bounces-246662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:33:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A690752945F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 609EC30F188B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A593C0A0A;
	Tue, 12 May 2026 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAR1p592"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DDC357D01
	for <stable@vger.kernel.org>; Tue, 12 May 2026 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617596; cv=pass; b=q14dubAAkPnZ1jXCikMbp0BPGi8PrGTOdaNrjudqroqwmTee0Ucc0ifiBJuEiMO7SQaX+Ygq3zdQZz3mea0YBk/1jG6VJUDqIUMLXH6N0GYg92rFBmEqdnLyXK+CNeBN9udwv5zmNJDNvNmIRq5hG6+BoNolkDNsMGPDuChW7ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617596; c=relaxed/simple;
	bh=XbTwXNuP8w0c6cHkmvOGpAGHQqu6Pjafgwdj1+1EgU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmxfoOLnWmJGibC6V8MH3EED0Nuu+svcY1O5EcrFOk04p/ds0oVl74W6/ATxFBui0UZxR3zBJTw3VoOGhNdc+WwH4AtaS+3KPooIWw7qOtKf0jdLYGSQ7YCEZWPV9nJ2P/1AqiZUDF5Elsa1lRnpf4RSeL51t3YOfAtq8rqUAM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAR1p592; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f5879d63ffso298615eec.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 13:26:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778617594; cv=none;
        d=google.com; s=arc-20240605;
        b=NTpoVCLN6tDL6VKZfEr/0kLqHfME8OQr6ZyQU7Vn/B/13JT1g0YM1VUFaaBNpWObO3
         qHngRYPHOKG2JqJEkwXYYJNi0Yt8Vlx9vWl55fNf4zZ+qUCETJ+opV6BV01IvvZKmbOk
         P8Yz5tlqFWTydPEekdjd9XhGLupsqYWklQnI19miTP0xm8kY7Bw5gvNUUm8awNQjJHLJ
         NsiMz/55U1nC38v7B1ELWeJEZlh7gLBRhpBgDbZOjcgLm2gFgEbGP5DGXlYJ3nfY0tFt
         CUiA5RMNM4Cf/3Jtn+r5h+9IHzRFqCV9lYmQSU6WRYd6/0u0UUkrNVv2vxwxmIVbEVxE
         VpIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6hXVTb0pqIRZJ44Mtixdn5J/S2HeUbFpgh874wfuHTk=;
        fh=qHm86IPevQoWC4JDUfTUtPncp3mL76oF0ZUGLzovtFA=;
        b=VDJtZiRtZkUgFsEFDuToTXh2pb/NiVbtep7+JZpBtlRoExnj8F5yqq+Z5qOzqa4TqN
         Qe2yRIk4kZIKqsdsIWyC6SjzQff5fdDTyuy3kvP/o6oUwUd5Qko1jlVl7MN/4XAmCwsI
         LlcFRhY1HNIUHeU8P2L+Oo52Tp3CsL0UYxHrWEoLwV1yAzBwWld9dbNcuQqwr2U7Zp5R
         7m4lAyCeZGYul5eJf+NGodj4C6f5o4LhK7CECMZUNseO00nsukUQea72EgOys/gsALhG
         8POEX2+hMgKWcbpSdJFU+jqnfQVvFS1rW3ypTPcyjVdCEkluF97ZMW12KqqyVFKcBGfy
         INIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778617594; x=1779222394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hXVTb0pqIRZJ44Mtixdn5J/S2HeUbFpgh874wfuHTk=;
        b=fAR1p592O69BRYUwpK/u186dxgNP3B6Va8rweyGdUiNLK0ZiOtBdAhkOgS1Xnlv6MB
         emNEFGKW2V+naqab/T9tIUENLctO9NBICvk92uhiqbBmVR53HuTretA/5BcBmIOSAxlt
         JeLGpn9t7kQ6/gmvU/lwOuz+hD/rpJrAqFz+KSoRTA3mzFmcEf6EYYJt6t7lS3n0MNFl
         f8nSy6diF2HjvcvU2uLTl/qP1z1bK1qpORQ7NZPAk7Z8sP0j7JF67ChY1bg+3qahh5y/
         Nh05KFTZroYwhpfcIzyC7YlDWi0vzMokAaZd8EmkeCPLIK8Gn/vMGG3CypMTPxcsTTzo
         ADhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778617594; x=1779222394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6hXVTb0pqIRZJ44Mtixdn5J/S2HeUbFpgh874wfuHTk=;
        b=KWnYQZ8c2IQxBEGYekWQKqUhTI4g17ykzayb5G6fNiYdXc/vO6KGR5MrNLRz0uIFds
         umQwvdF3s0Q0w7oL1AMrv9geKzqLU6gnKdHc3R2CvnJpsf3zIRxrfdGCXmoyX7YpipVh
         OcPm6mHe81Ix7YjLNkYPBS39HBhZMpF+oDkujV0W1+ndlxFHwuE6fVK51ReGct7pQ7MS
         +duZ/GKSorZ5X5GzHWz/IXSZ2qhZDDN4Vty3bQ2/nAG4vwa2h1+/cg40f8yjuLtRpnsp
         x9cJiBj9+Wy13hhgE2E1pnbxE9v29CvEq86iqTGxRApRrwKYrMEOdRm30YPoKOa8IEBT
         ReCw==
X-Forwarded-Encrypted: i=1; AFNElJ8YMM9hE4iKApO0HDEB/nLQkj5SHv/ujI/6kOUtMhUC8q2XI0jSIq4KKO9fdd9Fj6guwWlPZbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWqYiNWE3Y9ljyOkvwRXY3nF8NgewxgC/k160h9+SFOc/BmJeD
	TjGTi112Vrf0ZVvOj1ePYpb+AXqYWSKM7fXqMfXLe7YE8eYQqXlia55qtnym8+wqS+8aIjH45ng
	2k87/xKpNKhncNPh+7ig7HIpKKIj+BxQQ9eFRsNA=
X-Gm-Gg: Acq92OHWuKwW2jpyHWWxC7IynRUW7oItENYMjAT6qk8SSJxb3UaVc5fp78lGdPNhg70
	AsGF0UozgnbhLpLO1ffQNZpvMgAQg0fK3wtGG+Bfsp0zum2dvCRQblBFIJdehW8Cfg1vYp0/fCy
	TG+B/ptjE8XWhBikBWhQsHIhUyJT8TJG23H+zLcWeRY4pufogdiin80u7j75dRTrAb5PMyRmSU/
	zOYWzlt0zrHZTY+l+polO3b/RgnYBYcMQRXrl6+YpRzf7Aaa+hYXwwz76ZHu0cy4Sxc5JKqwQCO
	AT+MUsk/ZbrkMnt+nmvIEMaptSy9m2qbcbieIx7O5oN/08sDNHI7h2797ChIBZ2jsnCq2QXmiiX
	Qe6PsfIEEbx+Ri20EdXWQzJo=
X-Received: by 2002:a05:693c:2b0d:b0:2c4:acef:291a with SMTP id
 5a478bee46e88-3011929d0bbmr175004eec.4.1778617593993; Tue, 12 May 2026
 13:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026051210-epic-emblaze-b4eb@gregkh>
In-Reply-To: <2026051210-epic-emblaze-b4eb@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 12 May 2026 22:26:21 +0200
X-Gm-Features: AVHnY4Idw-XUjfoyaxJoqHGCp8kfpYy00o78jQE8gQS88lY_Fiev1sSnd6OgpmA
Message-ID: <CANiq72nDoE3COXhcdU2uAuCSW_5__smjukQckWbByKT+wUHp9g@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: allow `clippy::collapsible_if`
 globally" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: ojeda@kernel.org, gary@garyguo.net, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A690752945F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246662-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 2:46=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Since otherwise there would be conflicts, I sent it as a reply to the other=
 one:

  https://lore.kernel.org/stable/20260512202439.308523-1-ojeda@kernel.org/

(I could have made them a series)

Cheers,
Miguel

