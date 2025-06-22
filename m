Return-Path: <stable+bounces-155262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E24DAE31E0
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 22:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D311188FF8E
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 20:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF6D1E5716;
	Sun, 22 Jun 2025 20:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEcWQQzE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325482EB1D;
	Sun, 22 Jun 2025 20:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750622544; cv=none; b=QqYJnlqA4BXJ0YLXcvAkwbRRCUcKH6kN/BsgWURXgygnKrr0xD/B4VmJAnf2965hO2J252EGA3qyIfTkLN3l2mHEV7KbO9Y0aZFHkRJeJNFKHKiROUrG3v1xyJ3YPt3jeXyQkQB8ZeF0TSc87Pp2Zr3O51egKra/FidkOrws5g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750622544; c=relaxed/simple;
	bh=mlsPtZtDvvLfFHPW6PA8GuAhqv8ci6PlXF+mqDo4ajA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=nrUHFLdT3Pra5LmYZ9ss5aWv+Bm3h9HWcKo1tMRW2ZfklxpUl5vIAEGfs1wbGsVofXAHrbmwVNMchpm3myhcJBOrVM2XqeGfdyQ16aG732BJkAtRM3DARnySjcaNbFSH+Q3beTMvRV2K/JtN5U+zNda/ljgZrMvBOjQ1jPKu9Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEcWQQzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759DFC4CEE3;
	Sun, 22 Jun 2025 20:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750622544;
	bh=mlsPtZtDvvLfFHPW6PA8GuAhqv8ci6PlXF+mqDo4ajA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=fEcWQQzEH0T3nFzMMZMZuclqQanDyrukImCInMj/vYXmaSg/DOMnl5m5fXOzsSLfL
	 lwLpAoXcjVxs9o01x34GWUIKg0YLnKexJUW6foIHpcbUMXlDVJsztTra/BnbZO0ibV
	 jvYOI4QgNPoEGQJNWu9poUmLZASJKi/GZrKb1ljdspBNvjB5vv5sDDj7GOooWNcyED
	 QR4iplEWhE7kWflUpKAgUj5UKVCEYr5+4NwCCozR3mmsDLh6ZB0DxQpo0Q/Jse2XpY
	 kIRJxNmrWWgXg1Wo5ZFrJ3aVhro8FJsbmUG3MnLSAxTm1HkFPRRMbS74u4U2aLBAdd
	 hbCchhLNzIY0Q==
Date: Sun, 22 Jun 2025 13:02:20 -0700
From: Kees Cook <kees@kernel.org>
To: asmadeus@codewreck.org,
 Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Grzeschik <m.grzeschik@pengutronix.de>
CC: stable@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 security@kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH v3] net/9p: Fix buffer overflow in USB transport layer
User-Agent: K-9 Mail for Android
In-Reply-To: <20250622-9p-usb_overflow-v3-1-ab172691b946@codewreck.org>
References: <20250622-9p-usb_overflow-v3-1-ab172691b946@codewreck.org>
Message-ID: <659844BA-48EF-47E1-8D66-D4CA98359BBF@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On June 22, 2025 6:39:56 AM PDT, Dominique Martinet via B4 Relay <devnull+=
asmadeus=2Ecodewreck=2Eorg@kernel=2Eorg> wrote:
> [=2E=2E=2E]
>Add validation in usb9pfs_rx_complete() to ensure req->actual does not
>exceed the buffer capacity before copying data=2E
> [=2E=2E=2E]
>+	if (req_size > p9_rx_req->rc=2Ecapacity) {
>+		dev_err(&cdev->gadget->dev,
>+			"%s received data size %u exceeds buffer capacity %zu\n",
>+			ep->name, req_size, p9_rx_req->rc=2Ecapacity);
>+		req_size =3D 0;
>+		status =3D REQ_STATUS_ERROR;
>+	}
>=20
>-	p9_rx_req->rc=2Esize =3D req->actual;
>+	memcpy(p9_rx_req->rc=2Esdata, req->buf, req_size);

Is rc=2Esdata always rc=2Ecapacity sized? If so, this world be a good firs=
t adopter of the __counted_by annotation for pointer struct members, availa=
ble in Clang trunk and soon in GCC:
https://gcc=2Egnu=2Eorg/pipermail/gcc-patches/2025-May/683696=2Ehtml

-Kees

=20

--=20
Kees Cook

