Return-Path: <stable+bounces-207062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C066D09949
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDED33068B80
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE0D35A957;
	Fri,  9 Jan 2026 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dco8ZaOQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83B535A94A
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767960983; cv=none; b=FOCfAUEpzmcSWN7njM1whloB+DfL13wJjYDy2P0zBfjPdTLp7zYA5Bd8y7BOUoo7kWfwADXxP+Phku9pE7B2wtsoU/SkRpjPX5z3baq+Lwh3OTUSexO5kMFPafW6Lv6gy2LjoiQWxooVvoJPoWxe2lY2F/qKaHKQLUtXQecrzUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767960983; c=relaxed/simple;
	bh=1DPRooS4SVaOvVOPS2Q3va4Ao9cficnxbkJydJL71Mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKkJ1YU0BV3zaSaCRVO7CD6Y9WD75ZNPVTdfz1+O0xae3V1oKdmO0Z+8JjYr89pSQYqmBBE0In1+uyo05jAMT59eVNFJav76Gotf0xPc1XpFuRba0SNhf0FS2wKWCEVHUmqUX+p6Jk0FZQsTAHZN8lj9jDmuhh/2udT4IlEafe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dco8ZaOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAE9C4CEF1
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 12:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767960983;
	bh=1DPRooS4SVaOvVOPS2Q3va4Ao9cficnxbkJydJL71Mg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dco8ZaOQwh+lg8q13kJ+bZLHm/bwBqxxI5LPEEU1T7AXw93Hatbh8Doaus/6JTivf
	 bh4/3FglQSuZoO0oWPTba0swP6gMeWNkMCnAoodCLJo2IDHlos2cCoJSujZoxfqQan
	 hkMaKYexK97qYGHyV1P7YLpWAKRYG7HxvKuKFkrS0DyJBDqfu4i8+E7KrQzSrFdVGE
	 ZcjECryb+WmWNj9ymp1gSf/fGbscrHVN3HB1w1BPzGsDXj6m6TxMbnmzItZ1dv5bD7
	 63iYWhYBmSTo18AeNJ0oiz7kxO9kJVDMKPBDZw1PWSliGrx8WPW+84nBA4dusOzJkg
	 sTra+RpB9J+aw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7cee045187so520671166b.0
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 04:16:23 -0800 (PST)
X-Gm-Message-State: AOJu0YyRUKRYISEUCLAKPk61wQ8PK0O0Mfb9060s4hxDvMLxXD5VsB0J
	eICYct2FmAgAVdBqIMysjVjDC7fJvYbq9dGXTABdR0EoF88eKz1Eiu2ADi8EdRbpov9DPAgYqfZ
	WuCa39zQFlkDhg3Hz8YCJ4pSOdw/WU2I=
X-Google-Smtp-Source: AGHT+IFpIESaPRsYpx1iiqwXrTZGzEOnCcF9g5fS8T7Vgp+Fia4soR40WhDH1PuCiBGKQBMu8pWfXAx7VDznaqvPgbM=
X-Received: by 2002:a17:906:ef0c:b0:b79:eba9:83b4 with SMTP id
 a640c23a62f3a-b8444c5a60bmr1143001966b.6.1767960981252; Fri, 09 Jan 2026
 04:16:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109103840.55252-2-fourier.thomas@gmail.com>
In-Reply-To: <20260109103840.55252-2-fourier.thomas@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 9 Jan 2026 21:16:08 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-+kB786kWGetUUJG22CWzG7GuJCYYOLmTxRsY5i93AfA@mail.gmail.com>
X-Gm-Features: AZwV_QiG8SImZKCuVBzH-znCHBBY3UmrU5jGIYcqzk8Y4klTC8446Vr08GrTQLg
Message-ID: <CAKYAXd-+kB786kWGetUUJG22CWzG7GuJCYYOLmTxRsY5i93AfA@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: smbd: fix dma_unmap_sg() nents
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	Hyunchul Lee <hyc.lee@gmail.com>, Ronnie Sahlberg <lsahlber@redhat.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 7:39=E2=80=AFPM Thomas Fourier <fourier.thomas@gmail=
.com> wrote:
>
> The dma_unmap_sg() functions should be called with the same nents as the
> dma_map_sg(), not the value the map function returned.
>
> Fixes: 0626e6641f6b ("cifsd: add server handler for central processing an=
d tranport layers")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Applied it to #ksmbd-for-next-next.
Thanks!

