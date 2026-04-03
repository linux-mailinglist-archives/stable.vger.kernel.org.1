Return-Path: <stable+bounces-233223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAlkHIb5z2lT2AYAu9opvQ
	(envelope-from <stable+bounces-233223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 19:31:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5D3397038
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 19:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05B72301BA46
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A955C3D3324;
	Fri,  3 Apr 2026 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3J5uPYJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6746738A71C
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775237480; cv=pass; b=WLtn0VoZPoaAuWliTXwPONG2SfQMKOGofMc/Hw40jKxkPzsBQJCEfM/E+QpULl+a6PUJQ6CAr6fALzXnEQdi6Lk/Jp0euZCCt+UKhOBA0qOcFpK6yHrRY0xP9olkP/Reuo+cb7qGUhTnVMA92H+UreVSxJahoTitulnNMNOUNQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775237480; c=relaxed/simple;
	bh=A1TThcqxkmPRTc4liPUJFeM2RDiMHK5vI8dYvpyttFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qElxEtrrJNQ6Xofi8tocS8vQHLoqWJknnk2k10DsYRsVGDg7A2xigLUnnDHrcOrw9BND5E5MQqE4eqSHSfmfzR3P4lYXVXvSWPC6Bz2Rz/Qg64TaEgjeZ+GjAtZ4SMl4YsxnYHPINL2MlHnGTMwvkYxQVEJU3lTGJXhuMiCelTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3J5uPYJ; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3591cc98871so933148a91.3
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 10:31:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775237479; cv=none;
        d=google.com; s=arc-20240605;
        b=LgcD6q3PwykNCjiw/J2NxSI/wIDV/1JQwyS9f2Fj2JKEBDlItzxgJ1vBOCTC5DYIcb
         cjIKZxHrtlynK61jFGZUMuvVBzw2gf95IFOaP0Kc4Ib80griRKHUwBWlEnjzEY32oA09
         SZpF0DnJnyhQA5THbm5b4fXTXsI03ljRzJLrmdjdBKrQy0QpQDBE6zlotd6l6Q4LZ4lU
         ZENb0vf9F/vHPh9yWmOWEciZYnP5oRHjp5hqYAlHuQYdtRqWLRk2xtG4NGlbaHg28tvQ
         0pSZWMs6fzhDDfoivlJ93p8o0Ew4VP+4Dr9LJYl8OLckxkjRgWkSwsCQ7D9ZzXlP9pYL
         IeGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A1TThcqxkmPRTc4liPUJFeM2RDiMHK5vI8dYvpyttFs=;
        fh=iYLGYNuyn1jgST74VXY6N5LBQuCPmC7jPGH+NDkDq1g=;
        b=LXj4ghx5lZhNv3uXuDdqtEo5hUZSKv2hYAEOeztjabpETqw/QtLG5hElDoha85/qOD
         zFJZDfd12yoolaChbysbphTAvh3yisaWlOcQpwjT9LansEVt6U7nhaepyf5SV4hbnPl8
         rjwIFW69rmh6Xu/nsGPzR88pyf5Cq/Jxi41c31UoCx1dJMdDUa3X39GSw1/R6kmdb2J2
         Bz0xi/6EWXdWx5kGBD6BQAtkr5xcYcNF5VB5qYn/0gi2TapuQPCH62zNMTHJY677c2kx
         ItWmOK4ZjMWAzi0ldwBYiI2m7rIQluagA/M6NIr5Z5RUnT3e2RKCy5crv5wjyMJcnXqU
         YqeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775237479; x=1775842279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1TThcqxkmPRTc4liPUJFeM2RDiMHK5vI8dYvpyttFs=;
        b=C3J5uPYJmJawMmS6sg7uvvgM41FC1lNsbFGRX++lI8QUwCsgUtCWmkmhqt+pDbqZNR
         Y/BQ8oLqG7ml0xqm+u1ZNCqDQQ0MJI3WiSWx6Ugm8uRESBIUWvD3qQEVkq/SxLlAEIDs
         Nj0Sz+Pw2nlmJv6zmpSbKSfCCTRnKjWBdO9WfHz3h0xi0+Mv/7W7sxzBh3aGqCcqjuI0
         maRVJGSjxZU8zR+lqpWi3lGqNOZVCVA8Fun1cPr7P0QqSkB7uYId0ZCpErkNlMxxvkmj
         tDjaci0IPkXNfpN8BBdz+nxsNUhqAY6OXq1qI8lBWzg1r+dHB9JoLy2F3KDh9r/TFRiy
         6jAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775237479; x=1775842279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A1TThcqxkmPRTc4liPUJFeM2RDiMHK5vI8dYvpyttFs=;
        b=Wn2BpIQD+64Tp6i5KGw6y+tEuUv/ljm/qoAc3KXOX6Kt4PDtHtUXOGWorFa8glO6b7
         38ttkOgh6AhkwA7bgrEDtN3ssHZKSZjZ9adheAKgaHwhCBy+1FqQs2nD+sWV+jATYucK
         ySgLLs8lvrhADSwg0ZTj95t+38nPP/fNTWq0IaDRHLeOHp02OOxLs+r9a6XoPlE+B2RT
         8Vi2KLiQq3hEDDbZMHkEpIIPlyhVor4x66YZNdKixIClAwXvLNeNuqU6Iu7tqG50f+Kl
         0eQDQndg16du+V+lyXqpDbnVpsZP/BQzlGcdj5hJZ3/7uDEb5g2qhufLVZIeVe8XTeAm
         k1aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzkvDHT59VtsWFVIXFXur7zrUpQe43+UOe5nQGUesDKCj/QVIcO9L1vRIobOC0Dk3q22bwTGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YziZPzImGfjCt2mEUMN9hEkL4Il4aOu5s2TffnGKRW3mai7Dfpk
	dW1gHKVcpv8kuRB4pG9gCDC9jqpvLXQtFgJsyfP0j9vvkcz50sKHGfLxd6JbG0YpzU0EnoRuNAr
	xvTJNNmGp3xzs1LTJJBQcoRKhoHRrJ3c=
X-Gm-Gg: AeBDiet6E1DtC7KVEZ5DdYx1RjXbkgTcl75nkuE3RzHIwf2nN6LvTDL7f9pQD3olYEI
	chMtiRIhgRfdsUQUJKlpLuNfhr6f+S97W0l6Ppw8JGg2pPqKTd4kosislPN7fQmoBmEqcHVKEqn
	1DW6rl8iwlN88Z23bORVQlWYJyDhybvkgm+yDDujWNk5VpUA18uaRqkKuor/Ou2jbu3ciqqdi9W
	aX9g+JTXRkfjNh7BVc7yZlrL2XzmP3LzHwIx2i0mCy5/q9R0SpG1xmuRosfWICd4rnL5ud/3hwD
	LJtLEw==
X-Received: by 2002:a17:90b:3c06:b0:35c:cba:3453 with SMTP id
 98e67ed59e1d1-35de695812bmr3439780a91.22.1775237478766; Fri, 03 Apr 2026
 10:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402054015.38565-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260402054015.38565-1-pengpeng@iscas.ac.cn>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sat, 4 Apr 2026 02:31:07 +0900
X-Gm-Features: AQROBzBq-G3K7Iu3SdUwQAauw-NXAjNW1cKYpe7UpnGAu1jlS1PY2GUWpTnAkOg
Message-ID: <CAKbEznuqCs+4VKgyup2N4T2xf_Mz10xNE344DhmwUnic2=ofkQ@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: mhz19b: reject oversized serial replies
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233223-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gye976@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,iscas.ac.cn:email]
X-Rspamd-Queue-Id: DD5D3397038
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On Thu, Apr 2, 2026 at 2:40=E2=80=AFPM Pengpeng Hou <pengpeng@iscas.ac.cn> =
wrote:
>
> mhz19b_receive_buf() appends each serdev chunk into the fixed
> MHZ19B_CMD_SIZE receive buffer and advances buf_idx by len without
> checking that the chunk fits in the remaining space. A large callback
> can therefore overflow st->buf before the command path validates the
> reply.
>
> Reset the reply state before each command and reject oversized serial
> replies before copying them into the fixed buffer. When an oversized
> reply is detected, wake the waiter and report -EMSGSIZE instead of
> overwriting st->buf.
>

Acked-by: Gyeyoung Baek <gye976@gmail.com>

--=20
Thanks,
Gyeyoung

