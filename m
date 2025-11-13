Return-Path: <stable+bounces-194668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A7AC5697C
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 10:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C93E3546A2
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 09:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC8F2C15BB;
	Thu, 13 Nov 2025 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkHhGr7e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41BD232785;
	Thu, 13 Nov 2025 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763025805; cv=none; b=KHZSwYHx2WMT/lB9mEyWf4dgVvkGdh7VU8W8cFx12h6NdGOhJOMDdabBN61T/uFGIP3Q3GamRS+H3j7VWtPCMl8dsBlv6egxhwFpKy2jsEmUa9HbQNJzmi4bwzTWITheyXV+sDEceBuj9DVb02ofqqLBIJZic9JOwmdr4TcU1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763025805; c=relaxed/simple;
	bh=qVovaGkTT3RmHRbLQKVq/nDJeUu2QtGE4zbD+r6UQ4w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=qtGNUN8ODKxpNmTeU9eADi/iSO42slPp6fZEMo9nXAsawzQ/pAhQzR0+l7/DbDlC8q9Obpa5hxWuENy+RmndnofUExOZXgIszCELnVCpC/LU5+qWIyj46z7FpT9Rjzx0AwUVRei8gOqd4q/hNMxy0PolcGZdXdQswaHilS/YNEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkHhGr7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBDFC113D0;
	Thu, 13 Nov 2025 09:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763025805;
	bh=qVovaGkTT3RmHRbLQKVq/nDJeUu2QtGE4zbD+r6UQ4w=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=pkHhGr7e6vMBEQww5CcrBSoNXtYBnWf0gPpJt30EV4aNZWene0FCb8XcmdxYHnS8n
	 BcZAgjWsxuyuU9FgWjwwocDNjPnWJOrrr0lKqTT1MNbZr7q6FvIgCJz6w7phH+aVzI
	 wc3zxUtBF0HHvb2I9WK/+IrW+/CNV/+tfzCBpEWuaePtd6ktbrqyFE/tXOQk8W2qK5
	 QCR3H0tJJqhUUSBOwd9g6mwWcSqW+p1poEm9FX3zmA/HMub9fkC4ZlnqHeh8SQBenw
	 twY8yIAeP0Wzprzadfx+cx7XuDug/MNBYb5oDE0slEiMSH/GaGM9hoUNenJPJyIhoz
	 osUAHx0PuBJSQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Nov 2025 20:23:12 +1100
Message-Id: <DE7GHFYIRXVK.3SZGBBQBOVDYQ@kernel.org>
Subject: Re: [PATCH v2 0/4] Rust: Fix typedefs for resource_size_t and
 phys_addr_t
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251112-resource-phys-typedefs-v2-0-538307384f82@google.com>
In-Reply-To: <20251112-resource-phys-typedefs-v2-0-538307384f82@google.com>

On Wed Nov 12, 2025 at 8:48 PM AEDT, Alice Ryhl wrote:

Applied to driver-core-testing, thanks!

(@Miguel: Thanks for adding the tags for convenience. :)

I adjusted the tags as follows:

> Alice Ryhl (4):
>       rust: io: define ResourceSize as resource_size_t

    Cc: stable@vger.kernel.org
    Fixes: 493fc33ec252 ("rust: io: add resource abstraction")

>       rust: io: move ResourceSize to top-level io module

    Cc: stable@vger.kernel.org # for v6.18 [1]
    Link: https://lore.kernel.org/all/20251112-resource-phys-typedefs-v2-0-=
538307384f82@google.com/ [1]

>       rust: scatterlist: import ResourceSize from kernel::io
>       rust: io: add typedef for phys_addr_t

    Cc: stable@vger.kernel.org # for v6.18 [1]
    Link: https://lore.kernel.org/all/20251112-resource-phys-typedefs-v2-0-=
538307384f82@google.com/ [1]

