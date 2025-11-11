Return-Path: <stable+bounces-194443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2767FC4BBE1
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 07:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D601892BB6
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 06:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A4F3314D4;
	Tue, 11 Nov 2025 06:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xAFMq6S5"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE2A330D26;
	Tue, 11 Nov 2025 06:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843964; cv=none; b=o/YKPq3twpxY8/mG5kckivweTcZj2WSvXwobOJNasIN5YCItrRyjPS2jlhXQIBNxULPySU6vCmPJSi35aaQqpXoo9/lhePI8xX8iHiNLm0zA88YwI26ul3KmyVIgMBeXKjGCtIWqpjfT9L/sovwbCIhl+zKGOoOf5JqtjdV1Kcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843964; c=relaxed/simple;
	bh=fy7+wkF0oQv3oCtjE+5B16eRZULzNqc8FDFTQSP8DsI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tnl5ArZFCRHgGZkue2Z5SavymCPMZ54QyLpYX5GLGq4UlPfV385vaNvvS9rVIu1cwhaWnN0MrcpIYjmNGqi67g+hrb5FbICtflQtecRoiw2qMfOyTlrKDYyDsaMnD+DOCGVGPzcYUtrUUrnA3Lb5Nsg87CpxZuesgqjyiWZRQ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xAFMq6S5; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d5HKK1fsjz9sVh;
	Tue, 11 Nov 2025 07:52:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762843957; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fy7+wkF0oQv3oCtjE+5B16eRZULzNqc8FDFTQSP8DsI=;
	b=xAFMq6S5K91Awn1CzwfbwM6gkDU8YecjxplnJ9+RK2FygFCof5IcSlmtVESDLw9RAxXHfQ
	Qj2vM+YhHhr0zIAVq5KO9IESZ7PnWaM78uhx7HCOe2yn5HSk2l+EFNjNXvLOIH+ZnCy/PH
	1WtWJotKx2Maly+UnonpmY/wjKNJfrEOYp0ex20ctpbIHrfC4JKYcqD0tVEX0UYurBZRZY
	zzp6a61rsTXnYZ5KnHZRH3k1ZJq23xjQeW9ifCXIbuAHlRIsCVS1tNkUyR/bNHZVI8O0C4
	2fzN9tR3mo3eXnHAOP4gosItViM0whSi4IFCjFR3COgUsRWgFv+9iR+LORvxdw==
Message-ID: <9e74c7a8614591c1f7c08bac1460f7043173c856.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Fix UB in spsc_queue
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 phasta@kernel.org, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Andrey
 Grodzovsky <Andrey.Grodzovsky@amd.com>, dakr@kernel.org, Matthew Brost
 <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Tue, 11 Nov 2025 07:52:32 +0100
In-Reply-To: <a3eefc87-2678-4a4d-82c8-f6aedf74be75@amd.com>
References: <20251110081903.11539-2-phasta@kernel.org>
	 <ee63ca7d-77d2-44d8-973b-7276f8c4d4a5@amd.com>
	 <ee9fe54f3764bc0ee4ebafe5c10ad4afe748ef19.camel@mailbox.org>
	 <2c72eb6e-7792-4212-b06f-5300bc9a42f9@amd.com>
	 <987527ead1fe93877139a9ee8b6d2ee55eefa1ee.camel@mailbox.org>
	 <05603d39-0aeb-493e-a1ed-8051a99dfc41@amd.com>
	 <589a1be140f3c8623a2647b107a1130289eb00ba.camel@mailbox.org>
	 <a3eefc87-2678-4a4d-82c8-f6aedf74be75@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 1effdb85b9b9436c5dd
X-MBO-RS-META: fcjbgqxjfgnpt3kh36rkzrjh4wufkjus

On Mon, 2025-11-10 at 17:08 +0100, Christian K=C3=B6nig wrote:
> On 11/10/25 16:55, Philipp Stanner wrote:
> > Lock + head (same cache line) + head->next
> > head->next->next
> >=20
> > when popping:
> >=20
> > Lock + head + head->previous
> > head->previous->previous
> >=20
> > I don't see why you need a "current" element when you're always only
> > touching head or tail.
>=20
> The current element is the one you insert or remove.

That won't cause a cache miss because you have just created that
element in the submitting CPU, owning it exclusively.

>=20
> >=20
> > Now we're speaking mostly the same language :]
> >=20
> > If you could RB my DRM TODO patches we'd have a section for drm/sched,
> > and there we could then soonish add an item for getting rid of spsc.
> >=20
> > https://lore.kernel.org/dri-devel/20251107135701.244659-2-phasta@kernel=
.org/
>=20
> I can't find that in my inbox anywhere. Can you send it out one more with=
 my AMD mail address on explicit CC? Thanks in advance.

I can see to it. But can't you download the mbox file on the link and
import it in your mail client?

> > Lockless magic should always be justified by real world use cases.
> >=20
> > By the way, back when spsc_queue was implemented, how large were the
> > real world performance gains you meassured by saving that 1 cache line?
>=20
> That was actually quite a bit. If you want a real world test case use glM=
ark2 on any modern HW.
>=20
> And yeah I know how ridicules that is, the problem is that we still have =
people using this as indicator for the command submission overhead.

If we were living in a world were you'd always need 5 cache lines than
that would just be the reality. And 5 would already be better than 8.
So what's the deal? It seems this was not about "too slow" but about
"faster than".

There's two topics which often make us pay the high price of buggyness
and low maintainability. One of them being limitless performance
optimizations.

I think that correctness always trumps speed. How happy does it make
your customer if your driver delivers 5 fps more, but the game crashes
2 times per hour? (which btw happens to me with Steam on my amd card.
Sometimes there are even hangs without a reset happening, which is
strange. I'll open a ticket next time I see it happen).


P.

