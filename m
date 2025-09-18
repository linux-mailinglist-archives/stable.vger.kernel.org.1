Return-Path: <stable+bounces-180574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76790B86844
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 20:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF127626924
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 18:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51A52D73BF;
	Thu, 18 Sep 2025 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJdUviO4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA00E2D29D7
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221295; cv=none; b=oMrpcxTRubSwaUCB1+3ZS/kYCyuOEtSX4I5g25J4GFjPErwlhJf9mYIwW47OJPKoLP0eiJ/bGAPXzr9vnvKtTQagb1ZDM0dG8dshf2iuDpKKwwMkyetvmYtOSPwO1yhCgon7Tiyq6AQw4DDMFz43Aeu+eBRBe/cMSD1w7s/OdLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221295; c=relaxed/simple;
	bh=3LUG8CDlFaeOAc7TmZpmAR80a/tbN4YHi+y0ePtW84I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGOU8+pf+YrDO4Dzbi6PVnZLsZrGr2hwLGo9DlWqBlw75WjuDP3O8vG7LIaZiw5oXnrnah6I3TZOphCB+JfqLwQ+CJnDzmXIYH8zaFiv6zQoo4xncKVNr1jQS1S+VveKsFJvFJwl63uxU4zLyu2n7pLcwZmqpTgqZj6YdQEyQUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GJdUviO4; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b54d23714adso1051364a12.0
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 11:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758221292; x=1758826092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LUG8CDlFaeOAc7TmZpmAR80a/tbN4YHi+y0ePtW84I=;
        b=GJdUviO4cMljecghqlZIW7CMeuCDdgmnHnycTIqsUgeS7I4Kurc0uAJznZUMpmaf8x
         I7aOIlZPmm9HPwepR5dookk6dax0vqIjt6Lj19Sw2vJLst00yzF131lUtEh7t/tH5cJA
         R6J2QTA1prI7MVpFSKo/Xn7Io2asQVQBOVFHo5sOX5tFJYyt93j8iopUfKVBf7kbm2L8
         QKjiMJNWae47REPpg7dBpzWqecqEKMAlr4ZHenvdeXWndKxKdosRrgO0hSmvyLUDMrFl
         wCcZuGxwdVWCcRcHgXuI3gKWdTcQuhZ4B/Bn3nCKuaHQgoqlmykgOmMUlsLDzSOdzXDM
         7i0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758221292; x=1758826092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LUG8CDlFaeOAc7TmZpmAR80a/tbN4YHi+y0ePtW84I=;
        b=GOhTywHaKX1c4DCTnaPYv2+KhmM4rIY8/rChnd0S/YNHnY5vAJNy3/uupeHi2I3Wu8
         Kv+KzixVPxQHbjvZNW2j6ZJLdTMCVnUY8cfik+Ky243K5tF1d8HjckpWrcP+Lm+SuNo9
         MTaeQgx0X34ufOpTOXBmSGENat1QC8wv1NLc8CRUzAFiwNw4Oq3r53HZ9NF///vMgOmQ
         4Sm1Z4Xag7avC5SHtzEMwNnEtSyLicUkDuLqDnHMAHIqywdaTypgjFbrS1aB83AvkqWm
         DDgnTy4Od1IDve7g7yX9RFxm1SJwxrPek955RM31hGXGZyD6/LJ8gG7hn1JwYKHaY0zN
         UpMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkfymUa2BA+TUlu7EVtyU/PGzZBI0Hj6H6jICD0mAQrZBdfs7fAyxxv76/DCJjR+BqXip6l7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl/2Rrmc5DNvY5cZdEqvWkCY0I8GBtwMv1+kJSCS94PKfxAFv6
	Q6g/FuwnZDOcRLGCICvQuMUapuMUvYalkLdI5shXZwAmzIZ0bCyTmI9aqP+Bs2V1vefiSUyb3or
	7Dt+kZHvpUmo2Zf/P+93EbFjF5Kv2Y9sUEP7UjUTo
X-Gm-Gg: ASbGnctJN2FznF1BSd+dlhIFZ+NeEnLgDssIsCJdKkYWb1k1KlcOGxZ8nUzsFJykzrq
	ECd+Ku3FBC8VOIfNVF7lCXGuy3mdlGw5kII+lr8n0RKx6CDslpoiCXrv/ye8GqJtwxB2zy3DOUi
	BkgibwIao2Y3nOn2zqDkVvose18BJ40XWTzCAYZhQiCu0eLX2vaW6rZsZdFLbK+Zoa2Snyu6GTg
	0jqmsZRS4j/BScNvfQU6vRsu3nzMnBuHyiWE7asU9SyO7ZeAEsOLwGvN62buHAVoQ==
X-Google-Smtp-Source: AGHT+IFChwu/WXFE/Bk1qPbNxzjVEQRH8mYRXcstr2vxeJXZTN7B4PXslngta4OJd71ruXQZuBfYRAqRPI1cCQdkWpQ=
X-Received: by 2002:a17:902:ce09:b0:267:c1ae:8f04 with SMTP id
 d9443c01a7336-269b92f5037mr8368235ad.20.1758221291602; Thu, 18 Sep 2025
 11:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918-net-next-mptcp-blackhole-reset-loopback-v1-1-bf5818326639@kernel.org>
In-Reply-To: <20250918-net-next-mptcp-blackhole-reset-loopback-v1-1-bf5818326639@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 18 Sep 2025 11:48:00 -0700
X-Gm-Features: AS18NWBIaYnWg5h64UvvqbyXa3vbYuymfJ8c7oW4xcgcAtF9AXx0O8o97REhA6I
Message-ID: <CAAVpQUCy-xurW6r9oUcDV17fS3wiJsn2QuQ1mQ4k2wXYa6L1RQ@mail.gmail.com>
Subject: Re: [PATCH net-next] mptcp: reset blackhole on success with
 non-loopback ifaces
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 1:51=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> When a first MPTCP connection gets successfully established after a
> blackhole period, 'active_disable_times' was supposed to be reset when
> this connection was done via any non-loopback interfaces.
>
> Unfortunately, the opposite condition was checked: only reset when the
> connection was established via a loopback interface. Fixing this by
> simply looking at the opposite.
>
> This is similar to what is done with TCP FastOpen, see
> tcp_fastopen_active_disable_ofo_check().
>
> This patch is a follow-up of a previous discussion linked to commit
> 893c49a78d9f ("mptcp: Use __sk_dst_get() and dst_dev_rcu() in
> mptcp_active_enable()."), see [1].
>
> Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/4209a283-8822-47bd-95b7-87e96d9b7ea3@kernel=
.org [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Note: sending this fix to net-next, similar to commits 108a86c71c93
> ("mptcp: Call dst_release() in mptcp_active_enable().") and 893c49a78d9f
> ("mptcp: Use __sk_dst_get() and dst_dev_rcu() in mptcp_active_enable().")=
.
> Also to avoid conflicts, and because we are close to the merge windows.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks for the followup!

