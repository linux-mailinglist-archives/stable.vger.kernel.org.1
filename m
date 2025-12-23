Return-Path: <stable+bounces-203346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D129CDAAFF
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 22:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB0E930133BC
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 21:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3015E30B50B;
	Tue, 23 Dec 2025 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4ozchTt"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1222D6E4B
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766525814; cv=none; b=BhDxJ6k+W9XO7d8XIsopC2daOqad4EFg0QUrygFs6B3fN481aMBMSlRl4UuHoONHgNXaTgNs/Z0toj2qiRQMngRZ+DX3A3fpDLxbRU8COQgt7vMrhfpfrHyhzAePcsD52SJliWXHRoSWM4SI6V9qnB4fWwgsrIqITIh9vd2joVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766525814; c=relaxed/simple;
	bh=gUdUk2X7+RSxU+5LaToWss7k5SP9k1Z4vEiO6zzXczE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jghIOsrawhmiFIUsHjAPLP/Zfrt5uXYCm0aTB809N9lO9WLWLtMvX28n2Odn4LSuhVwn5pPehlr0qJLV2gsPT6/E80xIwjCbjuzvK6X8PWasXVXJQCy860x1oB0QhW1dABaXp3tA9ymO4jkzafyZmxZao0Kf5xQzrOD+1mTWxgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4ozchTt; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b79e7112398so908937566b.3
        for <stable@vger.kernel.org>; Tue, 23 Dec 2025 13:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766525811; x=1767130611; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gUdUk2X7+RSxU+5LaToWss7k5SP9k1Z4vEiO6zzXczE=;
        b=O4ozchTttih9GCU1snHjabcaDiEUb9TtfOv01/dE+xCXOq+cQ7mZ9LdfVrdcyj+D+L
         zTuzm3TTSyNspQ0ZnsW/55jUL0lHkg9A3d6Q5R/luivwbkYxkDPr+ZwocwvHV6kX4mYj
         CYULAWoUU8Kiv4VQ+hl00ZMZpjmpnVXgDHIP8O7e4bqFDB0a2gI9xorV4n4FvnjeAm01
         uAuRGTlXyvs9+CDv0y3wAeO3BwpbKVzt5MeGsVRaW621uKR0Cu8r1DGy9/yPxgS/7Sm4
         ej5mvGZK/vPNBk4VCiUyPa3bEoq33zNXoiHNukodU4ujkpj8ceP1VCQQBLqiqvNET46b
         7XnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766525811; x=1767130611;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gUdUk2X7+RSxU+5LaToWss7k5SP9k1Z4vEiO6zzXczE=;
        b=OVa+W+hxKloZQKeIuKuYdlfbtthqLnNNgSDY9Q/7XUqS5JNjg6LYUGAoVCeHM2Q2cn
         CPAq01cnsDli2lGuRIR/YvkjbWwTNs2z6D0BcGPPiodN2UuVNnXJq2b+ay86O+ZfxpbL
         JQDi87KzNk5/nPVyXOta3raNOFAGPkHRix5kvJvuMEOvACaSMPu2m4/hGNQd8GBGgaTt
         LuLX3jzXyDtV3h5qnrNY7TghVybZ18D400NTPK1dJBR5dquvA1PymkXTtXhR/x5iZAWM
         jT80cpUnv9p9At5ICpt8olSZHKcEpyJHD7tpE1o63GvI3zJkCQLERcs+IVlU73K6mnZv
         UEDQ==
X-Gm-Message-State: AOJu0YzmsyqAxVtZdtmOor8BLeLJUKnwmic66z9QlJTznX41Yy4cXPk8
	FmhIQoITIV7n4F+jZj6jVP4zN87jzW8Scc1TD0jYULHhKwOjH5ev3+XxUSBehA==
X-Gm-Gg: AY/fxX71moGchbDWSjMLg6Pfsqzg6jtLZbmac/MvWLlKs79TxsXWLm89O9vFCYdZm72
	mdTlkXnYox/wf0TNfshAR/3vDrtb59aE0R/cW4qf0wViOtn2nEqk9Jo+Ypo9D246qCrGHw3hsEv
	IIXWMdzm4tOXxL3F3glH5YLV1xqmovaj8dITt6u4jhGeCj708Jf14nbr3Q+82i3Qb+lbknh8svW
	dWm3gLoR8vUdkqKgpGtdabKG0v6a67QssmFvhWE3nzSAAfptvN0L0KjNVM3uIoEOm9/ebB6H4cf
	XI5U4tCMYpWCX8jyeKjdShRZBHjceJf+0wPNKAiHWhyDNogyqcuYy5ZEf9z4Gm8uq2FwQEHDcFQ
	UwlHkIGloLrnOrAmAEMLl7nTAmbiGgb+RWSHFmv8UhHhMK3BY9wuQZBuU2rcnzp1H7AW0JoB/+7
	4zghmyJ2xi5+C1cgbo86bXFaQXAA1i7WqVsxcyGq0c6vXh7g==
X-Google-Smtp-Source: AGHT+IEOKCU+ecErprVHNUinzwMQMU/A+Vj2HrOU9NUH54HaNAaJTE17Fm5T0tT6yY58oECtSAB36A==
X-Received: by 2002:a17:907:3f20:b0:b71:cec2:d54 with SMTP id a640c23a62f3a-b80371f6e11mr1575022866b.57.1766525810413;
        Tue, 23 Dec 2025 13:36:50 -0800 (PST)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de004fsm1551254666b.45.2025.12.23.13.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 13:36:49 -0800 (PST)
Message-ID: <b905018d5ac8a852759e8483ccf8d396eac4380b.camel@gmail.com>
Subject: Re: Backport request for commit 5326ab737a47 ("virtio_console: fix
 order of fields cols and rows")
From: Filip Hejsek <filip.hejsek@gmail.com>
To: stable@vger.kernel.org
Cc: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, "Michael S.
 Tsirkin"	 <mst@redhat.com>, Daniel Verkamp <dverkamp@chromium.org>, Amit
 Shah	 <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	virtualization@lists.linux.dev
Date: Tue, 23 Dec 2025 22:36:48 +0100
In-Reply-To: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
References: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

I would like to once again request backporting 5326ab737a47
("virtio_console: fix order of fields cols and rows") to LTS kernels
(6.12.x, 6.6.x, 6.1.x, 5.15.x and 5.10.x). The patch fixes a
discrepancy between the Virtio spec and the Linux implementation.

Previously, we were considering changing the spec instead, however, a
decision has been made [1] to keep the spec and backport the kernel
fix.

[1]: https://lore.kernel.org/virtio-comment/20251013035826-mutt-send-email-=
mst@kernel.org/

Thanks,
Filip Hejsek

On Thu, 2025-09-18 at 01:13 +0200, Filip Hejsek wrote:
> Hi,
>=20
> I would like to request backporting 5326ab737a47 ("virtio_console: fix
> order of fields cols and rows") to all LTS kernels.
>=20
> I'm working on QEMU patches that add virtio console size support.
> Without the fix, rows and columns will be swapped.
>=20
> As far as I know, there are no device implementations that use the
> wrong order and would by broken by the fix.
>=20
> Note: A previous version [1] of the patch contained "Cc: stable" and
> "Fixes:" tags, but they seem to have been accidentally left out from
> the final version.
>=20
> [1]: https://lore.kernel.org/all/20250320172654.624657-1-maxbr@linux.ibm.=
com/
>=20
> Thanks,
> Filip Hejsek

