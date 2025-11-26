Return-Path: <stable+bounces-196951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD69C8820B
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 06:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3919A3B22DF
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 05:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503A3309EEA;
	Wed, 26 Nov 2025 05:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IOB8bPAV"
X-Original-To: stable@vger.kernel.org
Received: from mail-24429.protonmail.ch (mail-24429.protonmail.ch [109.224.244.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F622F1FD2
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 05:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764134069; cv=none; b=FkZXUAjzL7d326BhIqhQ3QI6WxNvUhXYlc51XKafKxloy9+5t9STs4ziyXdkEofqOLyNUD7wpVc2/56RIrSlOup9Oe733wRQvDCUnq9qVhMwh4m8pLZAimvnH5ddl5pyRv+5tRhxsJIiidwhrW0d4P8t8Z1b8K0tOoIZIq4nfKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764134069; c=relaxed/simple;
	bh=a2ZEkZkLcZWDJmXzkPVhby0HbdUzvMAwmQ7gl/YYfW4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQHiGifUwN6uCrRIRY0WZthgOJWpq29aVW5BLUkKYEfK8uswKpOGi3yRyrbFfdYcpphwMTONBeUpvL2tRqziuRbEvM9HkSr7YFTSN8COm0pdua+WrgEKZk32AIuT7OvjSBXsaBa1iqQYt6IVvdX4rvvFX8ZZN040N9YsDOb5MqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IOB8bPAV; arc=none smtp.client-ip=109.224.244.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1764134058; x=1764393258;
	bh=lqPBiub9YnM5ZlppPyyaW8AmCwAqg7HdGEp6h/Th4xk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IOB8bPAVEdHLY+mCRPcHNt5ZrI4GM+JpjLj4LajdqXqOSFUUxb9QrqCGRPN5ZysAY
	 szekhG9E1L8K9HuQpM9F3wZs2w36Xkzm7Xsys1lAbbbMHjX6imZtdUAO6L6PsEE9H7
	 9Iii8bVUv3LMf6l7CRqOFSOSriIi0hWeKhRYINz2GHRA5rfUgTXjb6lNhnSsEzkW00
	 Dhw0V+T1irb9OJIxMEVrn0L72Zf+grBDNwAzHXxfPa1+R/VA8ZCBcL4E0eoxt51jYF
	 7xtmhQKtVVMXfr6p69QH8TLhI4v7PwWri5YihPcQp9Y4NAXRz73+hTsaafB4/qMydO
	 rrkcEl5f4uC/g==
Date: Wed, 26 Nov 2025 05:14:15 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: incogcyberpunk@proton.me
Cc: patchwork-bot+bluetooth@kernel.org, Doug Anderson <dianders@chromium.org>, marcel@holtmann.org, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, regressions@leemhuis.info, regressions@lists.linux.dev, johan.hedberg@gmail.com, sean.wang@mediatek.com, stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso_intf() NULL deref
Message-ID: <GFrqLPSzlfDdtFVUTPC7SJgyvzo5-3iiu9t3nN0uxRe4hDjFtHvYlYolo4Y3uqGlcOgyj3xT8hCch66lBLVmiG-li3rzC8G0xvqqSRTeJbo=@proton.me>
In-Reply-To: <CABBYNZ+LrMOr-Bb-Sfk--FAHjMWxzeUCdDoGLuRqhF99xaGE3A@mail.gmail.com>
References: <20251120081227.v3.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid> <176366460701.1748676.511972373877694762.git-patchwork-notify@kernel.org> <fcMPe6V9vMYxkXRMnKXiaeTnOwAMBNRTmF1mgLePTpz3Q4hPqpb0WVQ5aXZljqkOtZ2W_47PVL1Q4lnf7kZJhFS4aGwP8_4QiqJl2ScKSi4=@proton.me> <CABBYNZ+LrMOr-Bb-Sfk--FAHjMWxzeUCdDoGLuRqhF99xaGE3A@mail.gmail.com>
Feedback-ID: 139104781:user:proton
X-Pm-Message-ID: 59420ca908e796d525920d09c3f8d014648bb468
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,=20

Don't want to add trouble, just out of curiosity.

What is normally the route for patches to get into the mainline kernel?=20

Isn't it as follows , as suggested in the documentations ?=20
subsystem -> -next -> mainline -> stable ?=20

What's this net tree , and how are the patches cherrypicked onto the  mainl=
ine kernel? is there a certain process?=20

Regards,=20
IncogCyberpunk
 

