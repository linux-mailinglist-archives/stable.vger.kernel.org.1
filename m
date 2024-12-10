Return-Path: <stable+bounces-100451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E02189EB5BE
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 17:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F8418835AA
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 16:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736111BD9EA;
	Tue, 10 Dec 2024 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sD1sQ5NL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44EB1BAEF8
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847172; cv=none; b=fcvpe6HjcVc3iFazHpw7WFVcapQKvdFFbFAQCZr1DJsXYdBsQG5Su3P9nJHjDpuXV1n8zKVoZdzzo4/s9h6N38sVhHAEVKKQ0ASmVhlTAI3u11eFPPCh/vm1FduG84KmxD3cN2FM2KVDXFbFdROyFocqipJ4Nr/kJlNg5fs2R+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847172; c=relaxed/simple;
	bh=IEEi6Rs914XyJs+OK5nkfUNZ57Kyhb85U4z8bcFbL2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svK2VSQMspFxpCXSq8JwkinIi5x/DrY76LOZyzg+qBhJmrjnHsOJfVqXaIcPtn+9jL9hQEm9tGaMx3IIsz2j3QDiQAm5FUqwpEzE072wpXkGxq5mchztPxN10BvyQEo6HKcGMRqxUqFJfXcd/Tu4fKin/iCm8+U4ujAQnjOYvbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sD1sQ5NL; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cf6f367f97so8439988a12.0
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 08:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733847169; x=1734451969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEEi6Rs914XyJs+OK5nkfUNZ57Kyhb85U4z8bcFbL2o=;
        b=sD1sQ5NLqBqIHikLU1Jxpgt5cxV/2vSow+crbeVGudUxrSIppwpDDugwUdWm4dAXr2
         BRmQZgRePiaoPTBwN7lrMMu60aR8Yl/PSPTQJkizhJDQYrMUZaqGlQKWfrgiUHYk96cU
         yV7Scumy2/jGwUMmQAJDKppYsCXDMSYcKBt+QBfkDgKVJPraF0Jroux0o4McnEEbx8WF
         hDx+C7UIZndQ009CTGICrxdig1N1XUiudj15HRcovqAuklY8EG+3IGGIyw9bSZFajqj1
         xV0Tv+cesK3VIW/VKGQBaRVf02UMd2sabcMXlZ2w8aALbx9hBKy52iSZ+BUeZGAnwdcX
         2niQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847169; x=1734451969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEEi6Rs914XyJs+OK5nkfUNZ57Kyhb85U4z8bcFbL2o=;
        b=P8adaX3hK42u4LqLu7HlS8/RF9Od/HWKvxY7jkRH8Abl0Q1g1UN1VLm5/ZvyLFQd8z
         FvoCFmJNquAFXSoQDg551vZT79mnBDyzYaVyGbrgVx2KVEAfesiBeU/ZK/9qLt7JcoT/
         hPoaSEnUugAsIPaCfWDHexKuEfWIat7sfGnwiqIhyBH6Ggtyy3e0RfP0Kfh/ArsZ5pXf
         bwX/3YKSfIyD0e6/CDaGYlO+g1KFb5SiIj/456k2EQUZSYFjLn+SMOlRZqbhlHEzLzBI
         Y8BTwGjQO08maXsby/WJ3eGyMcycO6JVXt3xm6uTqSYOafN1bTg9GMxkJ32xFUKZa0e7
         7u8w==
X-Forwarded-Encrypted: i=1; AJvYcCXv6WOg5x/IUq/8pCANtRefThc6b4V328Tdpbx/KvqmR7YcQm+nNPX0++puk3+o92SjZM2+ZbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9UXd9QiYVEYhsSUD4NwoM/5b3Zcsfv8dTN5wN+uNl6PbaEl6m
	9AT8bOtyMSpv/MboZvtmwDvBLmts9idtHrtVIY6qDt2TcRc3F0kyhQ9xuC5LLy4H7i+KCIVcder
	lVw6a9NJyE+LAmClRe1Rv+2xR1hI5/VTZEGnw
X-Gm-Gg: ASbGncuWF4bX7qPyhlqYIs6IXbaKgBoLhcavYwpEw4bamjdDZCM+jfogyZojcVYkNph
	fJoXZDb9/BeCV9D0zCDtDPGSm3t0GsKds02U=
X-Google-Smtp-Source: AGHT+IFC/KNyJLyHI2/ye5Ac84Q8Z6BtOd46kGclCv+WlL7f+aQgPRnclsq5M6vaWLh6SgB/Z9DJNBgT1+mVN6Bg9Lc=
X-Received: by 2002:a05:6402:1e90:b0:5d0:d610:caa2 with SMTP id
 4fb4d7f45d1cf-5d4185fe2aamr6068148a12.26.1733847168800; Tue, 10 Dec 2024
 08:12:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z1fMaHkRf8cfubuE@xiberoa>
In-Reply-To: <Z1fMaHkRf8cfubuE@xiberoa>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Dec 2024 17:12:37 +0100
Message-ID: <CANn89iLgWc6vZZo0tD0XVg0zY-T-eUjKj4r=O_B3QARjFB755Q@mail.gmail.com>
Subject: Re: [PATCH v2 net] splice: do not checksum AF_UNIX sockets
To: Frederik Deweerdt <deweerdt.lkml@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Michal Luczaj <mhal@rbox.co>, David Howells <dhowells@redhat.com>, 
	linux-kernel@vger.kernel.org, xiyou.wangcong@gmail.com, 
	David.Laight@aculab.com, jdamato@fastly.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 6:06=E2=80=AFAM Frederik Deweerdt
<deweerdt.lkml@gmail.com> wrote:
>
> When `skb_splice_from_iter` was introduced, it inadvertently added
> checksumming for AF_UNIX sockets. This resulted in significant
> slowdowns, for example when using sendfile over unix sockets.
>
> Using the test code in [1] in my test setup (2G single core qemu),
> the client receives a 1000M file in:
> - without the patch: 1482ms (+/- 36ms)
> - with the patch: 652.5ms (+/- 22.9ms)
>
> This commit addresses the issue by marking checksumming as unnecessary in
> `unix_stream_sendmsg`
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Frederik Deweerdt <deweerdt.lkml@gmail.com>
> Fixes: 2e910b95329c ("net: Add a function to splice pages into an skbuff =
for MSG_SPLICE_PAGES")
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

