Return-Path: <stable+bounces-201061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A20EFCBE8A9
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 16:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82A17300252B
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 15:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54268145355;
	Mon, 15 Dec 2025 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjmThYzW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E22F18859B;
	Mon, 15 Dec 2025 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765810945; cv=none; b=Mch+KsyX4l8Y0hYXPU6eq4H8PUn6LPDrVoLkerx3YA2TjcF6o1qjXZ/985QKjdRYwXwqW8Cim8SSv1OReF/QJZlvZjSQJrEXH/Lib1IgpWw94ebJFLfd9f5e7niz4ck1vpjPF/43GjLPe7Y9T8XuxcoY65mNbgiFVxuahRN8NAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765810945; c=relaxed/simple;
	bh=yzBGWhlfCgbfqJjmS6rmGVZtm5XY4PO04yHcw33AvvA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNvLjOFbmJ0HiXzOQH5HLb8jf8Tl9u6svrEjbqR0+4XFcX+nVFPFEamItvBs5WGu0UIrQqH9fIuMWXsc6ZZf9+wpY6K9i/Ds8ykRyeg1GBhqx7d4Ff+CReMKAaoSge9QMZGfta17aarVPrNOhwMmX9sdPFcZ8M/e4jC8PrLyI2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjmThYzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1503C4CEF5;
	Mon, 15 Dec 2025 15:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765810944;
	bh=yzBGWhlfCgbfqJjmS6rmGVZtm5XY4PO04yHcw33AvvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RjmThYzWDVCn4Dz3hlg8qD8CKeCW52CghSJtC0qXTyPQdtbibYm5L40HT8qTUpaK1
	 veX49DqUy397XU3E+ek4Sch+oizT8xr9PZlA9v8YD+YwiQTsKqvRI0ceKhbK/xauCT
	 bUHbtGKYEgOZf1lSK3cqv2sJPpekj7u9twoZe4Q5kvZvLn5f0bG5YnRKmIAPn43h55
	 9Q2g06I7Qcd4n5N6hta6UVxDAjUi7fZ+OS3cla3mGMhWhzjncu2djUyUo4mE0/gAJD
	 i0qzpOr3VOsg0s7JH4sB3c8g/xuP5tEuWtIkmYGZlF2Vdv9oKnVurSIxpVhCeXSPpn
	 oz/KkzwezBuWA==
Date: Mon, 15 Dec 2025 16:02:20 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org
Subject: Re: Patch "efi/cper: Add a new helper function to print bitmasks"
 has been added to the 6.18-stable tree
Message-ID: <20251215160220.50f5d00b@foz.lan>
In-Reply-To: <CAMj1kXHwuNaY-Z=K2othSEYSQJQUeBdbbmYJs2q6tc_SHUU2JQ@mail.gmail.com>
References: <20251215110819.3458104-1-sashal@kernel.org>
	<CAMj1kXHwuNaY-Z=K2othSEYSQJQUeBdbbmYJs2q6tc_SHUU2JQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ard,

Em Mon, 15 Dec 2025 12:10:36 +0100
Ard Biesheuvel <ardb@kernel.org> escreveu:

> Why are these patches being backported?

Those two patches are requirements for this fix:

    96b010536ee0 ("efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs")

as it uses the helper code added on them.

Thanks,
Mauro

