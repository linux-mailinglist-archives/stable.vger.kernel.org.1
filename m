Return-Path: <stable+bounces-179668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A36B58AE4
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 03:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270691675D9
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 01:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB13F1DE89A;
	Tue, 16 Sep 2025 01:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uO2/3J0s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09581A8F84
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 01:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757985089; cv=none; b=hl0v/2P2+UX4sLsYfDf72f5M66HJ1aIKwMmze/nOVtJh/AQqx9zeP/fqSIETJ+4H2SJHES3vKmXDCxSjz4+mS50YCaJN/Qbj1Wiw8llWvtuh01UIOKi662F6P0XhEBzLGxdXLx9FUjUaYROhb8lZGSc/L0ntTNHFwBeXGPOdQBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757985089; c=relaxed/simple;
	bh=pywoNX5Fj0ThFie7i1F+fNV/378eQvTd2KEdBeM7gXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIEu6rOLJkruG4wxVcASIfw3YtCCXeZI4wa9LErjuGyiVVEqQVGNqSyWve5nGAYfqsAtSic1LmxXzoTKhH2BpwBFeMovL2IGsTSphsN2vd8lCIYm+pXc6S/fcbY0YtyQ0VbmWJbUd+Gu8QmpmLwaWfRPDv1L+3vXcMEopZawyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uO2/3J0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BEEC4CEF1
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 01:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757985089;
	bh=pywoNX5Fj0ThFie7i1F+fNV/378eQvTd2KEdBeM7gXQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uO2/3J0sejlTx7uljyYcFXBbeycir04KbUK3Wusg06qN5AW0kt90eJw4mZAAWZFVY
	 uf1lFJyU6PtI6cLUKvIruG2a+WwdjU1cAQYuHXO6uT3hwFcPYv+BKwmlww7eRBm7t6
	 IrSapVaiLbTgDAvL2pi3X181/dcsOMXafK5sqj9KV1Tbbg+E3x8nneyk4yerP2ub28
	 uJwgJy8w+FiwqA9bjb9XaiTne8Z8OfLKNiso2o9RP+SpyVYOBVmU0+VNl/8wiCC2CI
	 DHr6I1DS1RJf/u7ZU/+3Bbb5cbfkPv2hUvEBbhdTGQvQmNcUgHyeEo/bZcxaVOXYtP
	 Zejnj6qIZJbrw==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62f28da25b9so2810534a12.1
        for <stable@vger.kernel.org>; Mon, 15 Sep 2025 18:11:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMy2AEcWInai7bZqf+Wi07Z+3K6xavH52rnW016fAXlLZ/JFhohSbaF2o0jK+0oi+pkyZXIS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrhmK/D76tT9u133sdNdHl2kEeDVZUjyNPB+SJSFiGTuwn2QnA
	A4Quos7+v3zAxkVBq+kWcf6E0cUtLoIPyAwi7EcpkhuUqGxOYSNrO0UX2/LozsQ554nPl1oYk8o
	Vu9JrJuEj60q/Luwr5gMFpk7xI//QQhk=
X-Google-Smtp-Source: AGHT+IHv/n1JN8GWUKal59MvrweGIKVpUCxC3bbV7i0oHx+AET14Dl7KMMRsAqGMDIFeX1Yo7dHDbI6e6oQsgP709IY=
X-Received: by 2002:a05:6402:2711:b0:62f:6713:1b22 with SMTP id
 4fb4d7f45d1cf-62f67131cdcmr207838a12.24.1757985087942; Mon, 15 Sep 2025
 18:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915224408.1132493-2-ysk@kzalloc.com>
In-Reply-To: <20250915224408.1132493-2-ysk@kzalloc.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 16 Sep 2025 10:11:16 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_h9otb5kfixtwAgXfeFbmsvc5xmuoBsDNovmHFwGOEEQ@mail.gmail.com>
X-Gm-Features: AS18NWDcKPBMDX2P_tfLuiBXo4aQ7qWNaXQnQMmtVrPehIGjufNwmyIx6u-D74E
Message-ID: <CAKYAXd_h9otb5kfixtwAgXfeFbmsvc5xmuoBsDNovmHFwGOEEQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: Fix race condition in RPC handle list access
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Steve French <smfrench@gmail.com>, Norbert Szetei <norbert@doyensec.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, Dawei Li <set_pte_at@outlook.com>, 
	linux-cifs@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 7:44=E2=80=AFAM Yunseong Kim <ysk@kzalloc.com> wrot=
e:
>
> The 'sess->rpc_handle_list' XArray manages RPC handles within a ksmbd
> session. Access to this list is intended to be protected by
> 'sess->rpc_lock' (an rw_semaphore). However, the locking implementation w=
as
> flawed, leading to potential race conditions.
>
> In ksmbd_session_rpc_open(), the code incorrectly acquired only a read lo=
ck
> before calling xa_store() and xa_erase(). Since these operations modify
> the XArray structure, a write lock is required to ensure exclusive access
> and prevent data corruption from concurrent modifications.
>
> Furthermore, ksmbd_session_rpc_method() accessed the list using xa_load()
> without holding any lock at all. This could lead to reading inconsistent
> data or a potential use-after-free if an entry is concurrently removed an=
d
> the pointer is dereferenced.
>
> Fix these issues by:
> 1. Using down_write() and up_write() in ksmbd_session_rpc_open()
>    to ensure exclusive access during XArray modification, and ensuring
>    the lock is correctly released on error paths.
> 2. Adding down_read() and up_read() in ksmbd_session_rpc_method()
>    to safely protect the lookup.
>
> Fixes: a1f46c99d9ea ("ksmbd: fix use-after-free in ksmbd_session_rpc_open=
")
> Fixes: b685757c7b08 ("ksmbd: Implements sess->rpc_handle_list as xarray")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
Applied it to #ksmbd-for-next-next.
Thanks!

