Return-Path: <stable+bounces-154790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17419AE0365
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 13:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8F6188C919
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88602264DD;
	Thu, 19 Jun 2025 11:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQx2NCjI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DACA22756A
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332133; cv=none; b=mkjP9eDzdIbdKLTRNg2zVTcvOM1gNJB6RRxZw0Zp9ZH7wv1BUF5pxtO2q8bTHjfTDfCxpI5KaeWNy+FttfLEY133JknJJWmKrno3zXrJq2JrbYpJ80oigBRu3zU+oSu381bHZpYpYjyGgxRGm2SIW1WB+9F4hEzulkvJD/TPwys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332133; c=relaxed/simple;
	bh=zQ7QbBYQ4p+hc4GNqjEFFcNoSUmjNFjdg9ntczHf9Ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsL/rX/7WmJou41kKXsercF0694ldZmCoPHlzCfprscwWqAAfNyTJ/0v+m2ovGg4T/kGQIXyRsth3MXK5nItsTLWD2e/fygSSh3m3/7cvlo8p45yZ8h2RtqTmcCttdjciNbQ8WEm/zxcN4QQlROxu/1w3V7n5InJMLBGCYt2RbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQx2NCjI; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-313fab41fd5so82261a91.1
        for <stable@vger.kernel.org>; Thu, 19 Jun 2025 04:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750332130; x=1750936930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Hga0NcVwO82H5ckjdgFZA+lU3OjJWovCb7l6w//SLU=;
        b=EQx2NCjICOWy/uRuLS3AXg9gjQ+qwL+djES7NQJNDw4zAkiiGxIZRgA3RNkG6yc651
         PEIgDsZxKjRgaFc7dKiJyKP3nYAZNmrwNUhY815hGhIyj+ziOEIPfNJTWdCiX4X0Tnu7
         1vKOvh4IGDndEwDxNZCuQTVD8IABxL2EBucXTbD9Iq7sCPyHx//Z3U9LoApIFud/8eY0
         980ZWdi2xo+5cuvmz7M1IIBx0HObUs0NXNpp+EkktATt9FbkqFQPx9qgeGEZ+ULpq8jg
         fbo0tbh/4JQbNyZQy4IRFt/0YoKOtqqcaNzjaip3eAmgJlZubAqPaoE6pPb8vRsNaaDq
         aTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750332130; x=1750936930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Hga0NcVwO82H5ckjdgFZA+lU3OjJWovCb7l6w//SLU=;
        b=nCFOZEbik7DCJvhZVsZmjBSiC2s28bQkUDlEzeKlDM0jWO+yGw+y12lx2HR6wstHD5
         Gv95V0wMJ013wKDO01di+CYXqmplmuXWYVWCZdTsHCPAEbl+mMjWPv84q+iX/Q5zRUxg
         CXg/wOVf+pAIUnrjnqn2QfvFQkhVr/kwENGPAWE7385TkQ669r7I/pzaP+BHnehfl7Py
         RSi/UgNDYsgaqxHpTJxbAaTYbdadOVOlByxNcYETidd1V8nwOTCNt8CjXmCKValr/Zfk
         SJ0ySCOTnAcXrysq4x1RwT3dk2rm7uvSr/1yhNhmQOewEX7d+O/9zjuMKAGcWrxxBJuO
         4hVw==
X-Gm-Message-State: AOJu0Yz4PYMzoTdjEEbNdRJ8csAWWzj6YtfjBWFySPKi72B8WY7EjyGt
	V6WoDLlfpKX3NDBsJNNdOhnCzZwHjxsxMC+S1orw0z/3SVZhNNBxNnLqqQxoChOcrMubNRj1vOk
	NH6p9DSwwFEfW4sqgx1a963s7NqfjVl4=
X-Gm-Gg: ASbGnctzYOGqmmrMPoJRhP0K+e05I9V52JnN9YYWymBTyrFuifL1TI1HdgN7tko8Tv9
	wuHfIpjQzw1kYI9k7jbAbz7RA2hmUvT5RNRZKyJG4boVkpz3ZwYEkbtG2E0oR6vAD5qzYuD8teW
	aULJxe88v+9gJDvImKEMMHnneY+Ohjo9JQdxkQWvBP4ic=
X-Google-Smtp-Source: AGHT+IFwChdqFFcQJXX8ZjOB3WV5uzY9cm41kVgEkcI9w2fM7AHxdNmu3LQ4ICtjsz7HQq1U+d9s9Am49Lch1PsOOZo=
X-Received: by 2002:a17:90b:3bcd:b0:311:c1da:3858 with SMTP id
 98e67ed59e1d1-3158b6e4b68mr1646772a91.0.1750332130487; Thu, 19 Jun 2025
 04:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA76j91szQKmyNgjvtRVeKOMUvmTH9qdDFoY-QRJWSOTnKap5Q@mail.gmail.com>
In-Reply-To: <CAA76j91szQKmyNgjvtRVeKOMUvmTH9qdDFoY-QRJWSOTnKap5Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 19 Jun 2025 13:21:58 +0200
X-Gm-Features: Ac12FXxQF7cFqBr569CpKfp1s5EgaJ6uo8cyY1T5rL-PYsl1axYxkjoFyrr52oc
Message-ID: <CANiq72mRB7cbEpKdWm_k2EPf5zdHL8K=JT2Y+4XGwywN5AX9-Q@mail.gmail.com>
Subject: Re: [PATCH v2 6.12.y] Kunit to check the longest symbol length
To: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Cc: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 12:00=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
<sergio.collado@gmail.com> wrote:
>
>     54338750578f ("x86/tools: Drop duplicate unlikely() definition in
> insn_decoder_test.c")

This hash appears to be incorrect, or at least I don't have it locally.

Should it be

    f710202b2a45addea3dcdcd862770ecbaf6597ef

instead? Could you please double-check?

Thanks!

Cheers,
Miguel

