Return-Path: <stable+bounces-211404-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMNhEkGtc2nOxwAAu9opvQ
	(envelope-from <stable+bounces-211404-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 18:17:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AB878E9B
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 18:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 080FB3047E72
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 17:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E7431327F;
	Fri, 23 Jan 2026 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="goMEpGXQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026092FFF89
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188466; cv=pass; b=GZusXx/7YIMX5rj6YHNMXqS6OUo5fxqWpV2NstlT0+dB6YSmjIibwTFE6cv0xrIv8/tJ7i8NfU0oIdIxg27SO7t/OBRQI8N9RwnuiS+peLNhA9uHcV3ADRM8yyRZVNPoAywvc9mAWngNa9F/GgPC4dKwegb/I6lIUJsYVOCW+sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188466; c=relaxed/simple;
	bh=Pyus2eAL7FKDQhWIyVygHBSccAuw4WPN19E7Fh2kf3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHZj+rmcONi8YHdH+76E90x+dfE2BykSZZ6rTvVYhCLquqpQ1jlyptas8jStdwiqGRXgLLK7UpGhK6UPV8VuzPFRutPF8WfDL3nguADMdTtxVFaxtSPFXYZZb2BMPOTcTkQ/qMwL2hJys7SqzrrXK2scNdkRjwfnAYiafuIYf4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=goMEpGXQ; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1721324a12.3
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 09:14:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769188464; cv=none;
        d=google.com; s=arc-20240605;
        b=GcGRonSALSLcIUyXk5mr+GnjYvqdFDoCnG5jW07uxHGPynJ+g677SR8oMroqqhrwmw
         v0GswLSQFdLyxxSgHpn7FpbLD0tn4IAWHSPu8lKLPpvjfrfag0XTMEKbrUsPXCDhC5JR
         BP+2cYyupYzJzATw3fhVjQBWYNAienFjxUdOcloqZYwrLcaRLL293qrlW1reAr4RTUbO
         iJUA8+Im2qxM3HcCWD/h9HKj6XdtLWnXCf/xb/OZGz4ccKs9sDQPC2YLtrViMI1XFudO
         HWbyE7rWSs9lSwE1dY3Ds3cCXfcNdMUqAqvK/p8JQeTEOi9duvjeZ/wvi/n5eS61A1IC
         FyKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pyus2eAL7FKDQhWIyVygHBSccAuw4WPN19E7Fh2kf3Y=;
        fh=7hz9y4LT4WJj7qGTi3aL+jWwdMdrrWmv1yFh07NNJ74=;
        b=atKq6UYzRHYhvUKqBzaTvOQTVauuv2X1DugnrL+UP9naQllSolghCzEtDVIRzPC8tI
         vmKm0dkkjvB1zHWErlhZ4sWGvOLGLb0VW0+JTX/6fpdPcMIHzbmkGWs7U9uwqxOwfDV6
         fhWvGukHWCIt4kC3cVZcHolRsy/sZw5cAoCJnL1Q3/DfSNtejCnM8iG3I2p3ABZqA/y9
         Z6DLz32XjPLiHZz2BRZbkDNV8djxE9mb2kCVxsSELiGac+J4xUD7eFuggo+12T8hrc97
         rn+kCXWsuPsm5miVFYSwOzH6IcsM0H8jqKxnKC6/iYUml1Rsq70+zxDNe+EkKiJV7xZN
         e4Ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769188464; x=1769793264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pyus2eAL7FKDQhWIyVygHBSccAuw4WPN19E7Fh2kf3Y=;
        b=goMEpGXQ0ltUEh1rFovjpe7cP5FBSFB3lD2vEk1+TastUvG7MCdb0FPP/JptxFXwWD
         ZdQZcIPougapjAJo/6gZ97QKlzj/E8awfDr6uOaBvPbNRkC0xSA5o31zVGuQ3jheYeiL
         EXV4ni/GvfpmX07JfkRxCFGbV035lGN4rjQdWlYVpE1M01vKFInqXhuQv9nwqVwxO4AF
         P0alAAynOxmLGt7YfAVrwNcQNUwrQCApcx2VaAO9RqoYvUAZCjaiig1Ivdzwh/ovfqvA
         vHEIJHf36U7ktKj7aZrQeLkGnmP/priWdGybKSbS9BF2Jv1WQPllnFtiIdVyGtJ8vm4l
         Tkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769188464; x=1769793264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pyus2eAL7FKDQhWIyVygHBSccAuw4WPN19E7Fh2kf3Y=;
        b=LAmBr2TWCx7HUBRYLIu2PY+VOi6JhGDmoohbfJ0xkrzh4xl1w/tmGCIz7TuphNTyFu
         Bm4u2E9rcrpOR5jcZ/XUtFI3OzQVZEc2KYjgjCl+rWCOWYqrqdm7KBpb/KeTwf3M9ZPo
         zReBJVJ9CWSXWu4cL9Ftkw1DT0AE6KZwXIwGKjM3xhLBkN798xu4g3NFJ3eQRrJVs2T5
         NYIi/3ccJJdvxI/hfnVT9J3G3RUEkPOUlluNJG8JhYZ4/eZBbdUuvGs+rzdma4Hp/frA
         7LdBnLq/xiPAdiE2j65nOAX57ds/c91I5A5suRwOtdoJJqfeZwb4VSP4cYD0XxDNRPjb
         HZhg==
X-Forwarded-Encrypted: i=1; AJvYcCW0Cfn98Z4J+Qg5wiZ0+cfVm36ldPtCZvWehxGUh0CVoj+cMNEf8Q36qEh7c5/IDawclaaRyoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfFg6oyvVl6ctbzoRq0ndgRRup8xffDfzdKhbfkBGiiJUNGbjP
	bZbef1rqK7TI4SvjP2By58k7iR4eK0fnf0qab9w/Ybp4Py8m4btXraeSz/dAyUNNWMZJ511KPUy
	go3XAlZuyUiij1XgcA4EIcF3FK24xwiABnnfmdsNxrTzSs/Ux9ijbcz9Y
X-Gm-Gg: AZuq6aJgc9/yB/4h+C5rimii182I4lkCw0IXyHJEwSiBflHEYb9O54U8UMLvtL5pdzk
	p80wKMWILbQSyjAnFh18yxSNO/ZpQo0ZzQ7+Ce+udvx6EE/CAAvg8++TtKZLvhdJKheu6Gf3BWD
	x7BM5R1NBZTXdclRdUOjtyYZzaeFO7CAJXbDxWh4i6hcyiJNdHdhQToTNh2mpI5WYE7rzpu65Dn
	jD4J5lqAt44OFB5rAbdc/4pLcSzGWnuOePza8OSPBlcOCYU6QmHhSsEx4MaPQwYSy6JAOz07KG5
	Zn0Y0Txy//In1lr93R+t3ejP1A==
X-Received: by 2002:a17:90b:1348:b0:341:8ac7:39b7 with SMTP id
 98e67ed59e1d1-35368b4001dmr2872028a91.25.1769188463940; Fri, 23 Jan 2026
 09:14:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120161510.3289089-1-pimyn@google.com>
In-Reply-To: <20260120161510.3289089-1-pimyn@google.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 23 Jan 2026 18:13:42 +0100
X-Gm-Features: AZwV_Qh6jled3JZeU3ngx8ww-lKGy8zUdUXhvPlVWuqudohIm--Rh3iTGeTZBa8
Message-ID: <CAG_fn=WTEM5m7zcVO+S74JNz2t3nYY0vJNDyRrAhuHxrvHCv9Q@mail.gmail.com>
Subject: Re: [PATCH] mm/kfence: randomize the freelist on initialization
To: Pimyn Girgis <pimyn@google.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, elver@google.com, dvyukov@google.com, 
	kasan-dev@googlegroups.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211404-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[glider@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96AB878E9B
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 5:16=E2=80=AFPM Pimyn Girgis <pimyn@google.com> wro=
te:
>
> Randomize the KFENCE freelist during pool initialization to make allocati=
on
> patterns less predictable. This is achieved by shuffling the order in whi=
ch
> metadata objects are added to the freelist using get_random_u32_below().
>
> Additionally, ensure the error path correctly calculates the address rang=
e
> to be reset if initialization fails, as the address increment logic has
> been moved to a separate loop.
>
> Cc: stable@vger.kernel.org
> Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
> Signed-off-by: Pimyn Girgis <pimyn@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

