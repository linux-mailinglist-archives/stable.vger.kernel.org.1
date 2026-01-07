Return-Path: <stable+bounces-206100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCA6CFC6F3
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 08:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A88B300D160
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 07:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712BE29C35A;
	Wed,  7 Jan 2026 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJv1TC3U"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31E029B8E5
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767771731; cv=none; b=nPrkEg0csAgJULbnces2mNeNDnBq3VtImZEcZXijHR7pPFkqBh03otBhhycInbyrHA8Q4WwcXeE230G9DuTsL0Qq/Sg1xCgmKwbizTpio7QwLkan6vmaJWpbFCdttzYofHvhdS7DrpDok7xwoRMwg3Mv/9gKY+Jrirf4YAE59rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767771731; c=relaxed/simple;
	bh=9QJNm5DRwKf59jnnJG5BlivpbtpgPTlbJeGEV0wdNpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7T8lUX4NgQ4zatgzt/C9wpJ6eyePEUoDJ1uoRbibO85jNymbqOxdeBhWDxHo0GkYggbvt6JbQAbWwnKJcgnm7asXIBrMHrRJuyoC8N96H5kNS9yw3RCztjljdbHnIGKc3eunhY9LxMI+CpVn9ZvJ2rT8F3ntfkkznk4yFwUbb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AJv1TC3U; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b053ec7d90so1028410eec.0
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 23:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767771729; x=1768376529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QJNm5DRwKf59jnnJG5BlivpbtpgPTlbJeGEV0wdNpo=;
        b=AJv1TC3UTsvKPwDwGGATFzCt9cfHdm2HzU78kn33DvQKcggtqolKHSd9VFZ77bOibg
         7A0vdzi4NZwTLL10gL24GCOGnxD4S3Vyos6tdTs+cBfx8Y5fSrkCwz4KkBODUt4N70DI
         I/o8dY6q16ALFfQwlq9rR+J4KCfQCigaLGbbsJnLTajWfPoP6Af0B0mcuw49tiLrhkOG
         6N3CXk90lQHPMyC0tSvfO0dHRszeagLr1S9NE+i/fXWi/Obg0p/MsFFQfk9TycLCzBKu
         EEWG5MUpXpw7QOXWSuHoh+hNvVyjgqo6RN9fQrGNJr0Fw05i3eYCy+TBZqRSVkFcdYfg
         tJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767771729; x=1768376529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9QJNm5DRwKf59jnnJG5BlivpbtpgPTlbJeGEV0wdNpo=;
        b=OzaVj6ljGwWBZpyfO2hX4mf2IKtAjLrbjr71nyj+McE4rbEpKKTT9h17y7eVFpMHdX
         SqkSqSVQ212NoASQRP672Sc6Mppso72qI6fyb61eqgCRhSdxsrwGsIsHAmsUAzSmSe6s
         qPGXh+cr9T5ruwvLN1hyHtQ4CKer9VtpHE8ezCNpaC8OTRuOc7UOFNbOkFI1PhYZeW34
         xFW2GBKy8VP3+HP5Pb4IXE/PdWW0vSVBqqHvSHb915idh+MN5C18x/Lf2fNvU/Vn7lyI
         Vu6sT+RB/d/cVxgRTDwzleUCsL2LChHhYwoQ1ee5hkYCgYChXK7mObzZHv5QfiwGzP8s
         1n4A==
X-Forwarded-Encrypted: i=1; AJvYcCU8MMd2199OhUHIjMRtvehkFkZ7h5WFmMJ40WEhto7Z9GxS5oFj+tHSTzdUKsZhp8yKOnP4m44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ZcKFFdmXVbjKjhy74/yjbqTKzJ0G3Y5xTvz9n8FPhgo+kOij
	LD+P+Yu5T9Zc72YV5Wyc1bjWm7jRdvxwMsgG54JFnroKbPNPCUdHyqDJ7xh5BTeyY4NMjjLYtDz
	k61Wqvjc6Ur69K708tgmfrntp4udy9KzjKM0yfk6D
X-Gm-Gg: AY/fxX7MGe7n9qJY1Ag/rKl+47xmO3RlHRAUBqGWGaf+2ibQdoAsTXqLS8K1csMgwnQ
	xUBXesMZsJS0clXzMh7JlU3SrHWDZrzI9fQ14gd8rz5rKECcRvJFXzsx6CdFbjeLZiNg0tqhJ5N
	rODFd0PlpELLTO4OH5nN9mKr8/WDe2taRjEDDD278OhhvxAqaHAxUsveDEBzSXSHQyKg03e041/
	kfEuwHtSuT8MjvMa3vTBXu3rv6wH5ezIVDFPuQgnza7L3i/nAxGPKwtAKGfbsKR+AB+SEdae7jm
	bZCGLhZV9p2Le/ILwtd6RXMGCKrIim/d/Le1xg==
X-Google-Smtp-Source: AGHT+IHMXLR1dSJfxcyCPbSrXs5AyyqzXdXaJh6E7kme9E9G8J/I/dysqiX5PT3nhKf5G1WZ9ncIEdRFyf1wJQpkyEQ=
X-Received: by 2002:a05:7022:60a9:b0:11d:f440:b695 with SMTP id
 a92af1059eb24-121f8b0dd2dmr1257647c88.16.1767771728310; Tue, 06 Jan 2026
 23:42:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106150626.3944363-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260106150626.3944363-1-willemdebruijn.kernel@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 6 Jan 2026 23:41:57 -0800
X-Gm-Features: AQt7F2pi6DhNd2tylE6EKsDQMV7gSCWCOw0f6mbD4f7hrHwByqv-R09v8JtQlFI
Message-ID: <CAAVpQUBRymieDppfa=QsS2Q9u9mkYoq+Rb-iCtKC7t=2bRrpbw@mail.gmail.com>
Subject: Re: [PATCH net] net: do not write to msg_get_inq in callee
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, axboe@kernel.dk, 
	Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 7:06=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> NULL pointer dereference fix.
>
> msg_get_inq is an input field from caller to callee. Don't set it in
> the callee, as the caller may not clear it on struct reuse.
>
> This is a kernel-internal variant of msghdr only, and the only user
> does reinitialize the field. So this is not critical for that reason.
> But it is more robust to avoid the write, and slightly simpler code.
> And it fixes a bug, see below.
>
> Callers set msg_get_inq to request the input queue length to be
> returned in msg_inq. This is equivalent to but independent from the
> SO_INQ request to return that same info as a cmsg (tp->recvmsg_inq).
> To reduce branching in the hot path the second also sets the msg_inq.
> That is WAI.
>
> This is a fix to commit 4d1442979e4a ("af_unix: don't post cmsg for
> SO_INQ unless explicitly asked for"), which fixed the inverse.
>
> Also avoid NULL pointer dereference in unix_stream_read_generic if
> state->msg is NULL and msg->msg_get_inq is written. A NULL state->msg
> can happen when splicing as of commit 2b514574f7e8 ("net: af_unix:
> implement splice for stream af_unix sockets").
>
> Also collapse two branches using a bitwise or.
>
> Cc: stable@vger.kernel.org
> Fixes: 4d1442979e4a ("af_unix: don't post cmsg for SO_INQ unless explicit=
ly asked for")
> Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.24d8030f7a3de@=
gmail.com/
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

