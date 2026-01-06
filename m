Return-Path: <stable+bounces-205104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A409FCF906C
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 16:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38637305CD25
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 15:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9DE337B8B;
	Tue,  6 Jan 2026 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i2QmD0pw"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568C8338906
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712429; cv=none; b=Eo65Wk4lIn7QoYbTCkv5mQRBobXgHgvxST7bdrU8ggT2t9lPpAD4qSKceanMY5rSWbPIaKqojhVoK03YYrMitTzdSo9cLpnoNZ9NzURU9YdiHZ7Kv1tO4qnQYR/Sdm7HGGDJ2HU8yraLW738xq6oRO9U/XtE9qAB+dy7JlFON+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712429; c=relaxed/simple;
	bh=8YMPPQK2AEC01ATxaI6pFFBCk/F1VR9hTkIqMFIOc1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBL7Ef+ihf/9T5MMM9walwkMdaQwAPgnhuigeWCsEhGLuk0a58OzM1f80xYW7OnqulCdothtDGSsG3AUtZZPWmoVvbwndi/OkkjmMuQrkNcNN3XecPq7DBRTNKGlnLyvxhGBacpp5DiXYWZpzXVdVyleYZkyb100DjR7xkUfH/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i2QmD0pw; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88a2f2e5445so11336966d6.1
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 07:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767712424; x=1768317224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YMPPQK2AEC01ATxaI6pFFBCk/F1VR9hTkIqMFIOc1E=;
        b=i2QmD0pwz2vHPkMyFvS10c/93FGlGHebmXiy8IKSAuH2uBcy8dS1Nn3yR/oaM/p1Fw
         g3DBn8l+ta9NiuJn2CqOXgdpgi6vamKGIRS4v8AawcO6p27vO1Mh+wDTL+1KThcISnls
         s3qSlDXydaQgeXPKAah0OkfmHjPHkEJbcDV9rBeTqFXib4dUO9wEE9ul9yZglvtxQyZp
         2YWAfatYy5r0SFqtWl4GCmdlUfTGm7nArhKmR6QmJsZf71qRkUZKjHhcOQLzKaowwgRf
         49GHQSJ73DBt1Eyi3cxNsTJnE5A1/tfeOxZd74/9U5rvLd53JVmYKRgHLpuxUcp63E92
         UDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767712424; x=1768317224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8YMPPQK2AEC01ATxaI6pFFBCk/F1VR9hTkIqMFIOc1E=;
        b=JUIIgPpWRWmCD9J+8pOmBwfi087T/Mdz+SMIIhgesYoCj4hC5cJWUPMOFAMZBBIOyf
         952utJeMxyDrOgy3NV7IegP8SW1gxr7rZmbHMYurrKU+kbTQIuwzzpo/C0GMWLB/ZA8J
         To+WBAkgVJhuSSxibTFmijkOu0jhv7IlXaWZ/hc4AiBCkxcxBkmv6GOw0PX9Maepsgg2
         c7YpV9vDcXT2mNYNaReV13ve7bOLspfwHaV0LPjTO3W9t3xOYFjmBAK/SxujHxuN4Mic
         e19Aemw8ot2Fzgl9f3wgptzyYdPIpQO9b23Gz8N0TCdT/G0BnljGsLvPK4VmJ3hij5wG
         Bi6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUH/QR8mI5d3V4gwXfGNl/hBq+9fbNz4pwX71NrB/greqNS4YW/XEpVOhJev6QG3pJaXakbMoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4HW+RASRBW0IMeHoSv6uHxgNoWDRXZb46fohYDAZSCLsyhHUc
	f/Is29YTUCPdVbj6g3wBCDa81k6IFi4teMXfNg1Kn6cUski05puCE71VRGhdWDkuC3fIvl2cDaF
	y49sRS/Y4ap1e7GjyCgfl/XA2CvWg42RlzET73gaB
X-Gm-Gg: AY/fxX6VACv+ZcPz466sNWTlGrVtoCShG0qmqMlkeGJ6N6Hyr4zZ/58Lcuw6jx81IZ8
	/71LEt0FQcON4SuV6JREPFmq9SH3zybI4nwdMQ7Kg66ArlMplE3Ba0Ldf9MzJdiqLNGf+1jbLPh
	7s444hbpeH69OTN8OWHay15lOEd1UmK+r8xEHnxUusO54ffmJUBbNZftxF6Jq5MglUiWb/Xszjm
	42fqcTh9H6zR7zpy3GJ/ycoQsFZuCBFK9Cs4yOS44I1c6N1jVEMmYQYXdh7uMVH2g+q7zKyDe5M
	U/hosQ==
X-Google-Smtp-Source: AGHT+IE5QJWD0yG0ephPKKctX/puC0yoA5N51JXbqQYsDIojgOXAhxFqK8fY0Nkvcx6A/4Rhbe39rz6vlWpzls2UUsk=
X-Received: by 2002:a05:6214:29cc:b0:890:36ef:80fa with SMTP id
 6a1803df08f44-89075d21945mr43086406d6.6.1767712424258; Tue, 06 Jan 2026
 07:13:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106150626.3944363-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260106150626.3944363-1-willemdebruijn.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 6 Jan 2026 16:13:32 +0100
X-Gm-Features: AQt7F2qURt1-m0ouxrE3Rh_tUReZ8VILy-eEM52X9KAXc1236eunh7MazELiohA
Message-ID: <CANn89i+dqPTJSfqWFSXs=-79mmyhPeE1JTWFaJgdQvnvp5RDxQ@mail.gmail.com>
Subject: Re: [PATCH net] net: do not write to msg_get_inq in callee
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, axboe@kernel.dk, kuniyu@google.com, 
	Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 4:06=E2=80=AFPM Willem de Bruijn
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

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks Willem.

