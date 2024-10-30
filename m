Return-Path: <stable+bounces-89337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E72B9B6648
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 15:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C68281935
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 14:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC28C1F12F5;
	Wed, 30 Oct 2024 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6tiHAYG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D17A26AD4;
	Wed, 30 Oct 2024 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299510; cv=none; b=T/gsmomAdlOe5d2Ev+pIkBN05KSiY5O97h8QYu3PXvJ7qyC9B5PN3EorOoV8QSXxMmFeckACzHEsLJ/KV1O5JJIA6syXBC9fX82dc3fp/RIm+Ex2CDtF/sWc4JR7SW84hcRKHDKnv+RMZ0HILzv/VLXYCFfq8ar6dxjcdIOoRIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299510; c=relaxed/simple;
	bh=z8WrrbogaEylcqJjgys2QWCe65qdGnEJNaFj0WpQtd0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=HHVlqgrt6948qeP/9UxnCrnNYPpZfU93K7E1FL/dNNScpbmHFivi/SzJSjEQo2hQDSmw9aW0c9mtDHt7h9noCeaI2bXqze6ziKjGFAhadAJ4gYERMxTcTTExhQUIy1H/9KWP7T8Ih+7+JbMbRpnfFVk7tgLq/Pdh3wBfo9FlrhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6tiHAYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA43EC4CECE;
	Wed, 30 Oct 2024 14:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730299510;
	bh=z8WrrbogaEylcqJjgys2QWCe65qdGnEJNaFj0WpQtd0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=I6tiHAYGMTTFaAd5Au3dFvpmaqCTdxU2qYSYjlQiTkQsdVRaDtlxIWOc/Xm4XvJ+9
	 xq9opcdJNNH6OFXtjQ2lI5t90VAnI/rsVUaLaN1HcvAxT9svBgAWbgPI/kqhPnrjQD
	 7cXb4Ru+qaxZCk+FtC4vLXBqnU6rusNfhmVZs/KQuXxu2YdGbNXEFdyAatVsgInk4x
	 kKLF5WMDXP9IvpQvOPE5rA1+LSEaVvDowBCBKqWUnbHE/Q3y6eolsYI6UKQ3KP2cm/
	 xr/s0sSOKXuKtBbmjfuiPJYQQcaIjQ2Vd8PPn/TCEp/Y6uhNOYVVvnQk8hEvWxbYr/
	 DWKFZv48I1lvg==
Date: Wed, 30 Oct 2024 15:45:02 +0100 (GMT+01:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, horms@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, vlad.wing@gmail.com, max@kutsevol.com,
	kernel-team@meta.com, aehkn@xenhub.one, stable@vger.kernel.org,
	"open list:NETWORKING [MPTCP]" <mptcp@lists.linux.dev>
Message-ID: <e891f590-7dd5-4207-adef-d90b90172aeb@kernel.org>
In-Reply-To: <20241030140224.972565-1-leitao@debian.org>
References: <20241030140224.972565-1-leitao@debian.org>
Subject: Re: [PATCH net] mptcp: Ensure RCU read lock is held when calling
 mptcp_sched_find()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <e891f590-7dd5-4207-adef-d90b90172aeb@kernel.org>

Hi Breno

30 Oct 2024 15:02:45 Breno Leitao <leitao@debian.org>:

> The mptcp_sched_find() function must be called with the RCU read lock
> held, as it accesses RCU-protected data structures. This requirement was
> not properly enforced in the mptcp_init_sock() function, leading to a
> RCU list traversal in a non-reader section error when
> CONFIG_PROVE_RCU_LIST is enabled.
>
> =C2=A0=C2=A0=C2=A0 net/mptcp/sched.c:44 RCU-list traversed in non-reader =
section!!
>
> Fix it by acquiring the RCU read lock before calling the
> mptcp_sched_find() function. This ensures that the function is invoked
> with the necessary RCU protection in place, as it accesses RCU-protected
> data structures.

Thank you for having looked at that, but there is already a fix:

https://lore.kernel.org/netdev/20241021-net-mptcp-sched-lock-v1-1-637759cf0=
61c@kernel.org/

This fix has even been applied in the net tree already:

https://git.kernel.org/netdev/net/c/3deb12c788c3

Did you not get conflicts when rebasing your branch on top of the
latest version?

> Additionally, the patch breaks down the mptcp_init_sched() call into
> smaller parts, with the RCU read lock only covering the specific call to
> mptcp_sched_find(). This helps minimize the critical section, reducing
> the time during which RCU grace periods are blocked.

I agree with Eric (thank you for the review!): this creates other issues.

> The mptcp_sched_list_lock is not held in this case, and it is not clear
> if it is necessary.

It is not needed, the list is not modified, only read with RCU.

Cheers,
Matt

