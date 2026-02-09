Return-Path: <stable+bounces-215552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMehAzg5imkeIgAAu9opvQ
	(envelope-from <stable+bounces-215552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 20:44:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 726B2114380
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 20:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0AE3301585F
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 19:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D5E426698;
	Mon,  9 Feb 2026 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRIUwRnN"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3305C30AD10
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770666292; cv=pass; b=utAuN1dUmG+9GDMAzXqn8+u6AugipPSmfCWM7svltpmqkZUk9/vPhoqJkdrQx+HDrPYTQCkbmeg2FYlG56/ZdTnGZxi/Wn6FtVA7dQFyZvD6HgcjEbhKCJY0U09RVr+FZugFYjVw0fpdPV9mVDzrYpWfGsb94g5qxGDW96o7i+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770666292; c=relaxed/simple;
	bh=J3MbyPv0lCyPVi/uq2YooRkROSskRqaASkpUjrsTvug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvbQHgueMgDcqQzaj8js3en/kKIQf/NJNnz4gRD0j0hfvrQmQlXXuJkQ1iJS8t3JT0g4/3Il0V6X3mK5KLe12Su0BxlMl4o4pCGetGwPSuMR3/ngIMhfTfKbuw5SJJc7W5MFxHKi3hoEQGWIYJ75YTWvG5l1XlxxXCgAMmfIpIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRIUwRnN; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7961e04355cso33285227b3.3
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 11:44:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770666291; cv=none;
        d=google.com; s=arc-20240605;
        b=TW92fEOfSSHcDQL9Qei7LEhqcJYvp/wNAdf79Uowhptvwn+63i2sQBuFWI6zCKxg9e
         9DTgg2/wxUzkRgoeZX6j+hJMxwNFR5WyWAYMpxrw1QR0nHFfDjLtBhWQRn20hpLwu0dB
         0sa80IMsLCRsy2qaVlfG6oJCYBgKX8jb47Fbeut0JprEajL0BHBgy7A1W3y6CkTfG9iv
         C9D5YvvSQFPBcbfbxvOSMi8ksqazMpcjeGmLs6E00YncfrRcEQGJ0sc18TJNy4DiZz1z
         fsjq5iM6VHKvYDVFamQ2N2Dw+ieuLf43SCY+rPbAY6lY322rTqNBjX12gqy9aJGlcQV8
         M6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+XVopxlUjwe0ZGRyKBFk4NtFVNYbSzhBngi+dhAbvuU=;
        fh=aLYVfF+bnXT1v2LXaUz78z1+jr/7Wf1fBdl0TRf6dk4=;
        b=aWssviYXiTUygLNrALGd479X4psxHK4KU82JnHn+jh66AG29JSh2KXtZ1SystEWI0g
         8lNJuhlVo58/Dm5lJRpOaVRrqdxqyMnO8eHxDcVtmynXoMgM/WsKcuXhrNdfWLQaWhlK
         pIMuY5z1yxXHB9wCNt1NW5XPUFRyq1bQYXI5KtDhfXkjHuWrpZ+BbZ4jhdzyMmUj3gUB
         cCmRyJ57OAQ8Iphl/dwMaubYUu2klQ9gSeXwCvmX4Bmk1C63FzzHqcpeh2XcgjNVzcIX
         y0D+L08kTVvmvyAfQVWmjaWa0sghoVATP0iLhZ2E/ZQWNUMs76zC9oHGTd5EXAuMb2VA
         hPEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770666291; x=1771271091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XVopxlUjwe0ZGRyKBFk4NtFVNYbSzhBngi+dhAbvuU=;
        b=bRIUwRnN2/jmUGq8Yd89UaJNHEnOfnGal4pzs9tbxDlFTiv+AoIjxTq5PXlhYRmodo
         E6bAyVLbzxHi1DOov6GnLdLoTziLI7QqkwUqdl2Kr4CYMlLWSKloYSYy3/lt5fCQcT1o
         igVjgFWNaO7IE2vSRQEdZtudwHqZG08AVKqAPbUn6qE+LyklIcD9BefFaWFQ8xF2Euhl
         pCnPCvBLedNK3ilpHheYtszncZefQKYSV9nCIWhh7EcHG44WK5xZJzmqW4yB9b6iQUeU
         CM89udsqw3SWN8YyvJ3NI2xb6m8hfOaNfkd7I4X57CK5bA5sFZ8U1hYeyYa0lTATm3aJ
         INYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770666291; x=1771271091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+XVopxlUjwe0ZGRyKBFk4NtFVNYbSzhBngi+dhAbvuU=;
        b=AmK2s8N5EDgFsCjwPrjnulLlJKn8MHh/9DsexyuycFgyAUF7wJyF+9XG5YeZYeiPtA
         wjBlEgkZmHOYXaa7Ag7q4N7TubPn82c2yZvzU1jGPxKxJ/52RYI9rouCjQ5ufCmhMSNp
         9Fe4FyhaeqCbs7IvKc1PHCyTNzXpRgO/duptkpa9BBdI9jwW5FGUDBNio9ymP7dK7+JR
         oXilSETffa03J85v1A3TUAno8dbfsNEXqTP47t7ZGhcRj0ktW1EyRMO449ZqvcKlVijy
         oE6oJ5duhsnBWZNIH1MEZUZAxuFb/e9H0vQiFKveeZZcjBcxNouZRsRed/95jB2vv4Z7
         WEDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQS0VAy+YEkhfnuy7KGi+dxBHmnNlGINoe6z7IzYXHBepe+TKS/vFd8xLKOyacBZBb61VAcpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiodBwRLHCgH49Oz8Hcy5xzKvUjJPoeuTjLvy/xVuyHZHpy6E2
	JYF4jE7vdFPvclWKw/RQpXDzdiwby+W9+2zt2hX7BOk/snQiTasUCk3+nlkzWwqmeZ94GCeWgNl
	uL0TV01WucnuW04Eed46ay/UcKxR1KoE=
X-Gm-Gg: AZuq6aImvhObUnfYQtrFWhfPCzuL9zWS4xzFHX5gw0tzF3cYP1+khft1Pswq15O58nx
	IYtvDWnvuXCGALkohdHQgHbOsdGMSYsrHepsa9StIRkmyPvof3asJo7VocjCGLZjocAVQy2vyQM
	YbFHl9rmaC1dFuRLuyfkUs/nMNF3CwKmIZZPwUb6db93TM0++EYxpXbG7Aga2TVkDbNijs7UHzx
	hcmoQemzFuIoXNXXqSSMHV2uBIg6JzZyNT3u5JeGkY2AdHWkmirh9yxACkrKCr09CXMoxC7KqI0
	m/3OxXDZb26ct7k2Jc3J4tU8j74i+rFlUAmD3WZmwFSuUQXv4VLs2ROsOnu3wrhRI7j0
X-Received: by 2002:a05:690c:4c0f:b0:796:3fcf:7807 with SMTP id
 00721157ae682-7963fcf9cc5mr52328247b3.0.1770666291104; Mon, 09 Feb 2026
 11:44:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208081559.44983-1-maiquelpaiva@gmail.com> <20260208081559.44983-3-maiquelpaiva@gmail.com>
In-Reply-To: <20260208081559.44983-3-maiquelpaiva@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Feb 2026 14:44:40 -0500
X-Gm-Features: AZwV_QiABDPCiJ6ESRJXtgjeierW7QPvNMzPdLV0CmoUrewx8L8qzCoK0fW___8
Message-ID: <CABBYNZKqJ2pqCd+FBxjLgsezn5A-9QG8vCEUNNKU52ahSxLi9Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] Bluetooth: mgmt: Fix race conditions in mesh handling
To: Maiquel Paiva <maiquelpaiva@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org, 
	marcel@holtmann.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-215552-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 726B2114380
X-Rspamd-Action: no action

Hi Maiquel,

On Sun, Feb 8, 2026 at 3:17=E2=80=AFAM Maiquel Paiva <maiquelpaiva@gmail.co=
m> wrote:
>
> The functions mgmt_mesh_add and mgmt_mesh_find modify or traverse the
> mesh_pending list without locking, leading to potential race conditions
> and list corruption.
>
> Use guard(spinlock) with hdev->lock to protect the critical sections.
> This ensures atomic access to the list and reference counter, preventing
> race conditions and avoiding sleeping in atomic context (which fixes CI
> failures).
>
> Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maiquel Paiva <maiquelpaiva@gmail.com>
> ---
>  net/bluetooth/mgmt_util.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
> index bdce52363332..af9194e44943 100644
> --- a/net/bluetooth/mgmt_util.c
> +++ b/net/bluetooth/mgmt_util.c
> @@ -397,8 +397,7 @@ struct mgmt_mesh_tx *mgmt_mesh_find(struct hci_dev *h=
dev, u8 handle)
>  {
>         struct mgmt_mesh_tx *mesh_tx;
>
> -       if (list_empty(&hdev->mesh_pending))
> -               return NULL;
> +       guard(spinlock)(&hdev->lock);

Not sure why you switched to use hdev->lock and not mgmt_pending_lock?
And that is a mutex still, not a spinlock.

>
>         list_for_each_entry(mesh_tx, &hdev->mesh_pending, list) {
>                 if (mesh_tx->handle =3D=3D handle)
> @@ -420,6 +419,8 @@ struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, s=
truct hci_dev *hdev,
>         if (!mesh_tx)
>                 return NULL;
>
> +       guard(spinlock)(&hdev->lock);
> +
>         hdev->mesh_send_ref++;
>         if (!hdev->mesh_send_ref)
>                 hdev->mesh_send_ref++;
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz

