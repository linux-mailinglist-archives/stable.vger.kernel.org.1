Return-Path: <stable+bounces-206384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 449A9D0486E
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 17:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1F0D307CF3C
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 16:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB138279DC3;
	Thu,  8 Jan 2026 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4dBgIzs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14952D6E5C;
	Thu,  8 Jan 2026 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767889894; cv=none; b=J3swJQexdLlMlCFyvwwPXNYjIq9M8JzFQA30zr6LzZJD7K3n8R7y/qopaNEDdJoofFxYt8LG2MjuFr2k2sHy7GzsRGPV0k7q9nb0o0bExTg3Y2WmpdhUr8L13W6Eeu2jJmy/q4bgsaPI7LdB/Ag8dgyfKU+lIoxBD+QE0eciR6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767889894; c=relaxed/simple;
	bh=OKbOz5X6AkPAnx8KYzWSY3erzfMgj/8GczL3yBWrCBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHlCdJnRfcMbZB8j25rWurqP5Vdjd5MLX8xc+yEDWzc7Xrfu3kwXvZMpWkJkMIt5RBIVoBuFHNWrNO/dxL/u+30++X5bucscegD/6lyrF62HmfoQqC/mlH0T2pk80GPAHhaKrLFGVPVH116/fsRpz63YzkQdwRE9nqyeVln5gyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4dBgIzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9987BC116C6;
	Thu,  8 Jan 2026 16:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767889893;
	bh=OKbOz5X6AkPAnx8KYzWSY3erzfMgj/8GczL3yBWrCBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b4dBgIzsoHiHUVQEH7RE+cisjoSymIAC32bzOZD1SbsMiI08Be9BPY3RvfCiKuYgc
	 O8b2PJoCiZU7jgzF+3j7s34y/5xOwKN+QfGHDL5zUvuNod2ZMV8+Dru+zwbmvgOP+S
	 qGNl7Y72Ucek6iGn0RXcNmPAD8E2U0218SRVgeax77C1c88jULsrTwYsrUE992a8Gj
	 XEWxDO2Z1pAgE+JUGeliuAcLzhF5dACQeRuvqdzsNMl6d6OsMrOGksQPn11HKusMWS
	 tHe5QbnVgrV8aXrcDxMN+8UuaEHf6eppjdcibTyJgqI1637XUOlrpNv9P0QJ3YGHd7
	 euGrtOFCD2mZw==
Date: Thu, 8 Jan 2026 08:31:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ankit Garg <nktgrg@google.com>
Cc: Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org,
 Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de
 Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Catherine Sullivan <csully@google.com>, Luigi Rizzo <lrizzo@google.com>,
 Jon Olson <jonolson@google.com>, Sagi Shahar <sagis@google.com>, Bailey
 Forrest <bcf@google.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net 0/2] gve: fix crashes on invalid TX queue indices
Message-ID: <20260108083131.6e090e86@kernel.org>
In-Reply-To: <CAJcM6BGWGLrS=7b5Hq6RVZTD9ZHn7HyFssU6FDW4=-U8HD0+bw@mail.gmail.com>
References: <20260105232504.3791806-1-joshwash@google.com>
	<20260106182244.7188a8f6@kernel.org>
	<CAJcM6BGWGLrS=7b5Hq6RVZTD9ZHn7HyFssU6FDW4=-U8HD0+bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Jan 2026 07:35:59 -0800 Ankit Garg wrote:
> On Tue, Jan 6, 2026 at 6:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> > On Mon,  5 Jan 2026 15:25:02 -0800 Joshua Washington wrote: =20
> > > This series fixes a kernel panic in the GVE driver caused by
> > > out-of-bounds array access when the network stack provides an invalid
> > > TX queue index. =20
> >
> > Do you know how? I seem to recall we had such issues due to bugs
> > in the qdisc layer, most of which were fixed.
> >
> > Fixing this at the source, if possible, would be far preferable
> > to sprinkling this condition to all the drivers. =20
>=20
> That matches our observation=E2=80=94we have encountered this panic on ol=
der
> kernels (specifically Rocky Linux 8) but have not been able to
> reproduce it on recent upstream kernels.
>=20
> Could you point us to the specific qdisc fixes you recall? We'd like
> to verify if the issue we are seeing on the older kernel is indeed one
> of those known/fixed bugs.

Very old - ac5b70198adc25

> If it turns out this is fully resolved in the core network stack
> upstream, we can drop this patch for the mainline driver. However, if
> there is ambiguity, do you think there is value in keeping this check
> to prevent the driver from crashing on invalid input?

The API contract is that the stack does not send frames for queues
which don't exist (> real_num_tx_queues) down to the drivers.
There's no ambiguity, IMO, if the stack sends such frames its a bug
in the stack.

