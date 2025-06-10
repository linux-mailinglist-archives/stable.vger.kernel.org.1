Return-Path: <stable+bounces-152277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08145AD34F8
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 13:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCA317A7933
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 11:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9505828001A;
	Tue, 10 Jun 2025 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=r26.me header.i=@r26.me header.b="BkcEX9Hf"
X-Original-To: stable@vger.kernel.org
Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch [79.135.106.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC521D89E3
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749555120; cv=none; b=CWxYf4+tLTgDGMBH/JH2K0fcxkp8n5zSGyml2pUG1JbxqjmoA5mjqrrUlY1uKDb7anx4cwR/TCq2rbfyUS19q90gqydTfYkZ+RATC/ivZsQnz4FHHlQB4htbSKZcYeIJ3pamOY/z0b+eihFOWZmnD2T20LXP9Kq30lFXq/oV1bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749555120; c=relaxed/simple;
	bh=FJW79ZdMdKNL6zCgg7tfX6bDI112/LbNHYHBeDlUH9k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0zgMb4+b6lYm+QeJtrGAoRQjB2m7NEgsN7VE51eDcoIH6EaxGDt2NEmIN7j8THgk0CszWxyTlqIQAoxJ/6Cb/f/Xbq3ep0dIGenx+CbHzf89HUtCDZenN3/kPQiqxAoS7O/IGKvhr/1sFzZtdYIAQkeRDt/mtKO5nlEb9hQ6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=r26.me; spf=pass smtp.mailfrom=r26.me; dkim=pass (2048-bit key) header.d=r26.me header.i=@r26.me header.b=BkcEX9Hf; arc=none smtp.client-ip=79.135.106.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=r26.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r26.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r26.me;
	s=protonmail3; t=1749555115; x=1749814315;
	bh=FJW79ZdMdKNL6zCgg7tfX6bDI112/LbNHYHBeDlUH9k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=BkcEX9HfBNBBw0RaKi2UF5RfRYNNmdlNTd61mCJDaX0T8MfhQ1YOoZaUU4PyETJ6T
	 6EBGfxhNwFJOr21ThTGtz+DznYjEukvSal2k2U9ir0WJamdRl7KCEcBWUiFQt1lcHd
	 /3h5LAyGtOVC+bHD8+iYG8qnc6YvLQSTQSXvVavSygZ/g4ak1EbBR+4OQR8kgDxokI
	 ujhlD/HgctRKOAkQI0Azvcodu5B7iwRUyYBxa4FYWVIjaa99E1Wt7Udzqd0jZA7mMM
	 szo9ljQvZYZcjdPgEhzaEhf0sfhYpou3LnR8+QkWON04/0weB9VBALsT0XGjzvhlJO
	 ymsVUIzhsPH4g==
Date: Tue, 10 Jun 2025 11:31:49 +0000
To: =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
From: Rio Liu <rio@r26.me>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Relaxed tail alignment should never increase min_align
Message-ID: <7bbcee36-4891-4b8e-8485-54f960f73580@r26.me>
In-Reply-To: <20250610102101.6496-2-ilpo.jarvinen@linux.intel.com>
References: <20250610102101.6496-1-ilpo.jarvinen@linux.intel.com> <20250610102101.6496-2-ilpo.jarvinen@linux.intel.com>
Feedback-ID: 77429777:user:proton
X-Pm-Message-ID: b736764fe474c22b47cd5c24bc503de71c8583e1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for fixing the problem so quick!

> Reported-by: Rio <rio@r26.me>
> Tested-by: Rio <rio@r26.me>


My full name is Rio Liu if you want to include it, sorry for not mentioning=
 it earlier.

Thanks,
Rio


