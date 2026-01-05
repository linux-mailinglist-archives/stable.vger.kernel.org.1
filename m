Return-Path: <stable+bounces-204815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F68CF4375
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 15:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D81D30299D1
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472673469FD;
	Mon,  5 Jan 2026 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bPwasY8C"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8221F239B
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767624432; cv=none; b=gEP4umdggM6FOV5XqqLsGMGywbSvWW4VGiOR0V/4sHwD04ujtKftZ03Hefo0UWPt4XORJ8lBe/9gFp3ePnu9trKS+zc/JYrNuEEyFZhkF1YLaPfJIKjS8jaM0xkweHC3Zht5UO/Vsnbe7c+MZJ4G30wy9oSkZwusCd5d97xEY2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767624432; c=relaxed/simple;
	bh=i1LKx8L1s4vOARK/LngU2uJj0WCN9UD0P+AVCkcPcLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVJECAbOFRFNCYszwnKdj283Xp8xGirTtUriv3bmKHF9YlrUZVCfnijhWmh/Nc6j6jHT2lV6E01+8UGR5Uh4YX6TFoc/C70hJ6vSxvqQHvbKnF8I2OTfEuRPTvP6BlYrpPbO1BHaYhx/T6K2hAn4IOfnYMVO6HJhqlU5UxNQ6mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bPwasY8C; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 95C5A1A2667;
	Mon,  5 Jan 2026 14:47:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6C07960726;
	Mon,  5 Jan 2026 14:47:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7A11103C8529;
	Mon,  5 Jan 2026 15:47:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767624423; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=i1LKx8L1s4vOARK/LngU2uJj0WCN9UD0P+AVCkcPcLo=;
	b=bPwasY8CX3db9Cw79Wip3dXHR8bj0WYvsCOa/CErDxuAblLgYPfqfeIWaApCTqvZ8rmIBj
	QDAMQcTFQFOaqZ2iBFw0yA/IcSP0hKylRYngEGcMOrouWvVcelwEuSIY2VXbHt7/3bUWBf
	2MJdLKCvyO63R1cZcDbcxl5hxmPxitFKSNmVdf/KDUcJxEl4u/jJ34FpKenSpDjMqlqIBj
	FgtwuqyfRL/hy+u07uqQP1I3Vv8Z8eH/nTnPK0WGiTZgk6TO5J2XuJXMBzr5LGCqh3VB4/
	xnUs/IKZXjj3NPanDK05PKFOVpZSSpEoDkwT/YWgxUPwNe4AnkzA3bM1opbz3Q==
Date: Mon, 5 Jan 2026 15:47:01 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: <gregkh@linuxfoundation.org>
Cc: dianders@chromium.org, luca.ceresoli@bootlin.com,
 <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] drm/tilcdc: Fix removal actions in case
 of failed probe" failed to apply to 6.12-stable tree
Message-ID: <20260105154701.5bc5d143@kmaincent-XPS-13-7390>
In-Reply-To: <2026010529-certainty-unguided-7d41@gregkh>
References: <2026010529-certainty-unguided-7d41@gregkh>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 05 Jan 2026 14:26:29 +0100
<gregkh@linuxfoundation.org> wrote:

> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>=20
> To reproduce the conflict and resubmit, you may use the following command=
s:

No conflict on my side on current linux-6.12.y.
Have you more informations?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

