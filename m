Return-Path: <stable+bounces-231426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOhxEtbOy2mILwYAu9opvQ
	(envelope-from <stable+bounces-231426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:40:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7000D36A653
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE77830ADD70
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B097E19D89E;
	Tue, 31 Mar 2026 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuCMOZnC"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628433DFC73
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774964235; cv=pass; b=MVs3piPOjTB2lf1gzsJHL4Kclm9koSQqFfpb40YAU9UAqK9GmojEKrW9xjlz/W9uGB6fOAvL1g4LOPUZZI1uRq65V8Gmkv41NSx85pr0QKi41NUjoGwn05gVWQMVQYp6QKrMT4+GBwN1tkk1Qbd7vOVhj4iC2JGIXqqlkE+T2dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774964235; c=relaxed/simple;
	bh=YzUdJ8s51EVo8h04NjczD2Of7rwCACK4ORr3lOV6onw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eejy4nxm6ef47u6khP1LAxeZ0rSWfMq3diKs+g8Eg4MQ3laMHroZNkOB0l+jqDu0o0sW+jBjc+wOhsRx2wftj54gKl1FYrdiuX+RDgGIS9CCCazmZpA3vndVzdlB+nQ6nvmBvn/LTyI1Q6aIgDZISC3iAxmG8dSwFS+7y6xwQFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuCMOZnC; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-649278a69c5so7586012d50.3
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 06:37:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774964231; cv=none;
        d=google.com; s=arc-20240605;
        b=fII14W+8Gos8EvQ76aHCGFlhZBLmJ/2ahHf0SEbPj3X9uolejizy2WndG07QHiiEbJ
         Oq0eDVk4Nn+w1l2nPOxsu034inD6TB0rL46BJF7cGHxxy7VKzsXdlm+1J5Guyy/eLGRm
         ddZTLT+L4MaGU1bo8v5W7h5rR/lA+Ma1AnTm4ayouyEBjJhkPVXPNFshvyF/WgCOo+E/
         pO5D8CvVSUoxsD5t3QhiuCINh0CgVZw3Pc0g2BKrrMmkIacfUF/qY0qO73II6w8RbGCt
         izqCQtx68EDqcQ2YEpt83eq8uKKmFewxl8xs20+pON3ucmaTFeniMbC3VBc/XOTsfNUA
         E0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OL5MbFIQIM+t92yp+O2PTJMYEG6GU15NK8hnNdvQ8NQ=;
        fh=wDqLj0fbs6/NXsCnJ5GBxvcm0yUwLgdXLU/p7E+zPBo=;
        b=iMsEVVB+tbZNqn3qZiVhTAJYrBojaSLkmA3eB1/VCwqAwFYIibQxKasqzp0WbDvTHS
         6T6nGU2VvGx2dENFLbbTSnnHIZPNtHZAFZq2tR+y3904H7xjsLOXddDDYBQ2B64bJi3s
         NCFy5M+2575tRls7q1k62mx4Udv/wErTsOTulMuqN/BVcnbv28nhUdCAt+1lhWNWgxkZ
         Bh6dRggpyeey5z6tW2CW5nR6BhsnXLhMSlWkNZ4ui5+RNMwfBuA0ClOms+fsWipMgUFR
         5lSYLM5SobhYOXwtWWEdFt3OHr6ivvQfctaJs2M/I/ON7eMOMzQZrMe+rCcbNbL57gpB
         vycQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774964231; x=1775569031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OL5MbFIQIM+t92yp+O2PTJMYEG6GU15NK8hnNdvQ8NQ=;
        b=IuCMOZnC2gRgrmfp2Emf9qfCliLYC16YwzdVEDIKdgr4SN2PSvu3APcRVhEUoNzeks
         fFNiMJ+F1/WXYFODo9pxGpmR4azAk9SIAwh513GMVyVcqULiuT0WqCd8cqZ3sns4FN3J
         f1yUwNMWFBXE9Fo7Q5nhMM93/M8WlUs06eV3n+VWpGnXKGp6VLeVNBdcXG4Kw5Uf2ZG1
         1iKQZVKsV6ERifRMrAAc0LpaZvWQzQ81jPEdcTZZQR7LsqDP5fpw7XmenCMn88gXNd7A
         1sk5pXMqanGoYR8AxEYAPASHFHUHw5BoUbDY3XKeEHohaiuQ1YvjV7qWVyeFTpsqVO/6
         5wLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774964231; x=1775569031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OL5MbFIQIM+t92yp+O2PTJMYEG6GU15NK8hnNdvQ8NQ=;
        b=LebANPmW40VTe9OAMktmAFOhmF7gbDHUc8XD5RoFlBi/HrDlyno3em05tNoRCwOn5f
         Urg0Ayr182m0RgZp+Odg4m8fvpdPz64Q/5ls+cpWYQcJvvOdQEbloIRm9Ye0quPKBuc4
         ORAAtN2zwnjihkdy/kq/57ek7rMn3N/dIbd0spoH/9WBSkTrVVbAOrbAxKOZs99gxOlS
         iRZ6Mz49aeYVYHNG4DVgCcVWyM3LMAbdUiTbwr7ep6tqeIMX2awZw0ZuVs9EGhWJFbMq
         mSbn/O1YQeyr2H0kN63lZ+a2OOv0h3v1qv2JLIoBqUfkMxUH3mo+6OWM115tdh+5mLyS
         ATaw==
X-Forwarded-Encrypted: i=1; AJvYcCUMy7mPvT3F8okxelwYZS2Ic75Ubf9vS9sKRQvcrVd6beKkwR9GwERHnwh68+mdmu84Nt7IDWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1wD1huqeAjOrTvdqnF1bWo3KxqVCujRZzaN/vkdWoU13H3QyM
	1t4GPoPU10XtVQGjrWAuICNPRJnPHZT8C6xDcgX2I9CDt65Yq8xf87H5qcHw1CivltJ5DuNxBVt
	+uK0iV/RNLoCyq1sBWOSvMNtHTf3ygdU=
X-Gm-Gg: ATEYQzw+j5y8FUjaSxCzUxXd0FdQRCreLNzih2xS5xtR9nAgylI76x3/IHsFxLjp+O0
	4cIx12E9neR3AbvMtWvMZvuXvYrT07jos/wC5AIL6XAivwMKMTNXbwrqAD5EiJZiTHREiZPU7zK
	l7AKe6gQX90T4CGaEhQDmy8OJgKa5EZm6XjKHqGNLWH627lDZji+4ax0D7xdshZoxP1If14iK6c
	Yx5Ue7BXQPYK/35lBEEEh/GIneGCpbKvVPAN4Vm8eZMv6wg0ockoKliDEjjc5+WDyT9ar3tz5g4
	E2QKnkjl5zYmDSMek3OSeAxRnQdAoDZs3v+YQH+s1c4OpqfiIVWsXani/EebNjv8avLAfA==
X-Received: by 2002:a05:690e:b44:b0:64f:fed9:caaf with SMTP id
 956f58d0204a3-64ffed9cc90mr16082097d50.31.1774964231033; Tue, 31 Mar 2026
 06:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331055032.1883139-1-hkbinbinbin@gmail.com>
In-Reply-To: <20260331055032.1883139-1-hkbinbinbin@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 31 Mar 2026 09:36:59 -0400
X-Gm-Features: AQROBzCQzpWBjVjJ90mJZrYY1knxOxVJmSPxSH4bRdq_cvrVbzO32WZ3J7Bc05o
Message-ID: <CABBYNZJTEGuMJzKfpO5ZsKhsJYAqrh43JYtt+58ui83umMPY5g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: fix OOB read and infinite loop in hci_le_create_big_complete_evt
To: hkbinbin <hkbinbinbin@gmail.com>
Cc: marcel@holtmann.org, gregkh@linuxfoundation.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231426-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: 7000D36A653
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Hkbinbin,

On Tue, Mar 31, 2026 at 1:50=E2=80=AFAM hkbinbin <hkbinbinbin@gmail.com> wr=
ote:
>
> hci_le_create_big_complete_evt() iterates over BT_BOUND connections
> for a BIG handle using a while loop, accessing ev->bis_handle[i++]
> on each iteration.  However, there is no check that i < ev->num_bis
> before the array access.
>
> When a controller sends a LE_Create_BIG_Complete event with num_bis=3D0
> while BT_BOUND connections exist for that BIG handle, the loop reads
> beyond the valid bis_handle[] entries into adjacent heap memory.
> Since the out-of-bounds values typically exceed HCI_CONN_HANDLE_MAX
> (0x0EFF), hci_conn_set_handle() rejects them and the connection
> remains in BT_BOUND state.  The same connection is then found again
> by hci_conn_hash_lookup_big_state(), creating an infinite loop with
> hci_dev_lock held that blocks all Bluetooth operations:
>
>   Bluetooth: hci0: Invalid handle: 0x6b6b > 0x0eff
>   Bluetooth: hci0: Invalid handle: 0x6b6b > 0x0eff
>   ... (repeats ~177 times)
>   Bluetooth: hci0: Opcode 0x2040 failed: -110
>   Bluetooth: hci0: command 0x2040 tx timeout
>
> The value 0x6b6b is the KASAN slab free poison byte (0x6b),
> confirming reads of freed/uninitialized heap memory.
>
> Fix this by adding a bounds check on i against ev->num_bis before
> accessing the array.  Connections beyond the reported count are
> cleaned up with HCI_ERROR_UNSPECIFIED to prevent the infinite loop.
>
> Fixes: a0bfde167b50 ("Bluetooth: ISO: Add support for connecting multiple=
 BISes")
> Cc: stable@vger.kernel.org
> Signed-off-by: hkbinbin <hkbinbinbin@gmail.com>
> ---
>  net/bluetooth/hci_event.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 286529d2e554..ebd7ae75b133 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -7085,6 +7085,12 @@ static void hci_le_create_big_complete_evt(struct =
hci_dev *hdev, void *data,
>                         continue;
>                 }
>
> +               if (i >=3D ev->num_bis) {
> +                       hci_connect_cfm(conn, HCI_ERROR_UNSPECIFIED);
> +                       hci_conn_del(conn);
> +                       continue;
> +               }

https://sashiko.dev/#/patchset/20260331055032.1883139-1-hkbinbinbin%40gmail=
.com

Actually we might want to consider that all BISes failed if something
like this happens, so perhaps we should break and terminate if i !=3D
ev->num_bis


>                 if (hci_conn_set_handle(conn,
>                                         __le16_to_cpu(ev->bis_handle[i++]=
)))
>                         continue;
> --
> 2.51.0
>


--=20
Luiz Augusto von Dentz

