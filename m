Return-Path: <stable+bounces-233681-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDXgGFgt1Wli1wcAu9opvQ
	(envelope-from <stable+bounces-233681-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:14:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 005173B1936
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11EB4305BDD1
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 16:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C113D6CC8;
	Tue,  7 Apr 2026 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jc7LPtC2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E543D7D6A
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577861; cv=pass; b=YTshB9reKzi4fcn8n9vH0fiSh0G6aNiJ5g30D4y4dVzT/hawMpI4N++icFZHJrueNTNHQfE2y/i/iIt/2kyyUz/JMExb7RbvRvFDGPaVD1pq+XCvx3OuLMnp1+dl06n9Bk51uIer1tdtirCPWc3e5KnYA8bSNjxgceD2YSifR4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577861; c=relaxed/simple;
	bh=NSsE1e/PZi1yLaZLU1hnoYz7iY5RSS8H6bXaDmUQzYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P20tl+6u7CM4vTGfSkSIyIiSqEN1afByjUQ0AD6oG/SuQB7qHY2UHdBRLhrCKEnb9dmokwdfVUNGSCzJ8ATZzJMvlMsrpXJzsN8cIo1v8Yc79IGkym33KllbdkA/XKPMqlFNp8xzYHlINUgqbKpeoTyLuGNjGO5lLv6+DTj9vEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jc7LPtC2; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66e8cc747d8so4287469a12.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 09:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775577853; cv=none;
        d=google.com; s=arc-20240605;
        b=dMlwcn2Qt1yDrTKI2KVNF75K1x95SKecOgUC8JkTompdcXbIJZmP+avoz4e981WPhB
         kxkVqxvO1hQ29iFadePU/JnQDG6pCNhaa773NP1N9khcpQCwL1uaoCCVFUsqzsS4IdWP
         evvbsWAcPBslyrQYdxmdt4zhWxo+zIVza4kMJMXinGeg8NN0DAzpXpe8TexqKHQ4MwwN
         qWIFSRBLqhp4PIABiBaEdFgoGnF3WePSR7IehX8fyrDhvOulqLjm+kL2lWcGgclvJF4F
         kX5ekH5HZHIN3b9ZldM09+rb8/fm9Hpr9kST9NKZVbtGfLqE1Z9ezk5dEaZ/0Zh+Q1Al
         SVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NSsE1e/PZi1yLaZLU1hnoYz7iY5RSS8H6bXaDmUQzYw=;
        fh=tvhQ83HC0xeT6Yp+/abX0vWnoweCJpv0hRqovShKIG4=;
        b=flzF3zBZVLMqWc2RyIDC723IuM7vHX+RW8lWP95drcvqt7S7pL6ZwqKZeEhuneE7Cb
         7qbb43YpRHElimeD2Pu9K4BEe7LKshmQ6Otqw56Rv+2ZVmz5xliDXOkRuLDmLdA2f4XM
         Q+VB2ds+/i/gQF8guo7ahFI8vmUndrv4KHs1Hptuc3MyjfsatZdllpfN6v4vAdNCvjgM
         OKrsYF/g7k4Wz23dz7KESjBp770ZpW91jWdmAem++dYOwCRvipKNZoW2kzA+tI5qMcr1
         VEs+AvfRog62I1i5aAxM6vv4n5VJ/ktg9vY+gTR3lmJvfcZ14pDBbrkFyXkxTdN1dp+j
         Z7Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775577853; x=1776182653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSsE1e/PZi1yLaZLU1hnoYz7iY5RSS8H6bXaDmUQzYw=;
        b=jc7LPtC24qwdF92hG3E1yoyIbi6ETGZAQoBz9abpWpIG+oBDPZlqk8bKxFi6SQR+RC
         u+5U5B6rWU+yD24FkZXiFyA+xtGfLSSWlqf1NxQV33C5R6+3u9xjBe4agGpOi6qVLet1
         WhIKXfH+DdepWUeeVD617fgTFD40kb7XLzm2DdXSHbtdGCteusNFYp5fzyB9DizCLF7J
         yMB+rCe3+10L/jtFIBTvN1s92TXg0Vc+ydnGq0FhoSWuY+eCQ8YMkTdGBDKvFefY8Zzs
         fiqkVtmOdf5Dceat2ofz1iS+bNm+Ss+m03QNc1CyemjfUJ1yZ+GM9Z7Aoi1Ejk8k3lWu
         w4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775577853; x=1776182653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NSsE1e/PZi1yLaZLU1hnoYz7iY5RSS8H6bXaDmUQzYw=;
        b=AwBFzdIENMTUU9Nq6dL8BJ22iX4TjTGzYL8u6JtHkfL8ypEOF5QqMJTQt3Zl34qwnZ
         N2kXjyUbChEejrr7e41Q711Q+/EwJpK6duhFwCchn1yBOuFydQpQ7KivA2X1tP4DcmbE
         /CaGcJJakUKhhZaUquxV+Vdx71pqXLVSvX/ULVgb6Bi56Y1xJXv5uLkc5oysKEuK+oIa
         cY9zvaRUkCkfHDsPnuyFMNbmkUQtLrcqPypdYXwxETCkseGi768q7wWFZONLeJDl7W/k
         GNm2wYcsgDWiksZglRvxqd0gPjL5euvADj7hTpflREfMqTi9Yrc2DKciasAscHhZuxLV
         dQDw==
X-Gm-Message-State: AOJu0YzKkzVdFd5xS+pJslAOm7DXLGyupRMT44Nul129N16bbRZgrqAl
	xmT+JJiOrp76zT7Iesp1WCNeoEUPBHIw2fVExbUXEG+mb7twDKsvW+AeezK2B3/d3TMKls1jYuh
	JzVidszBXdjRJL4EMqOW2XmsTjDiDTq+NMg6SweYM
X-Gm-Gg: AeBDietE9G9YkOowJX44wcxYzBWzlUV4WxNr9JFL0G0nXP5TwE68QX5BEjQn2o9VfOf
	0itorsOztd6uXNSX3l6yIh/96e28JoUc+5vF3cI2d96gOBMZnVaemTQO1rN630Q01VIkxUn6MJm
	42K05OSpFH7/jjQGr/scFpDLfuh/7UWDrBeeTEbOjx/VCQovf8xNThbLBUa71/K/sgoiCc5GtUb
	gtjzWNAVWU+oWgRTLydXAUgqLxAVRNrNqe7QwlVwXIwSivRDlmKGJB4BDIHc9DrYXZ2aYdNUlih
	9+rkbYUkMJJoav8IHtY1ty2+ECjmKrXAzAmTaZc=
X-Received: by 2002:a17:907:1b0e:b0:b96:f329:e66 with SMTP id
 a640c23a62f3a-b9c67a26fc7mr844404066b.51.1775577852342; Tue, 07 Apr 2026
 09:04:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311054043.1231316-1-kuniyu@google.com> <20260407155827.GA1993342@google.com>
In-Reply-To: <20260407155827.GA1993342@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 7 Apr 2026 09:03:51 -0700
X-Gm-Features: AQROBzA6sVi7ELrBaUXh4gd4681a_tixA6QGGkVr5CTQNSBqTlyyqpNo3H3caw0
Message-ID: <CAAVpQUBnbRSUq7NDj0iEXsyKKbCUsn830iCNMvTpYTa8kNG1Zg@mail.gmail.com>
Subject: Re: [PATCH v3 net] af_unix: Give up GC if MSG_PEEK intervened.
To: Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	Linus Torvalds <torvalds@linuxfoundation.org>, netdev@vger.kernel.org, 
	Igor Ushakov <sysroot314@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-233681-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 005173B1936
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 8:58=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> INTENTIONAL TOP POST
>
> I note that this was not sent to Stable, but it should be included please=
.

It's included in 6.19.y, just a matter of time.
https://lore.kernel.org/stable/20260323134508.596880934@linuxfoundation.org=
/

