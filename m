Return-Path: <stable+bounces-40419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 412AD8AD960
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 01:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBC0287C8C
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 23:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA3E46444;
	Mon, 22 Apr 2024 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NmOAB25G"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8097C45BE6
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 23:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829967; cv=none; b=R6GiFFM3UG2mzyLkDoyFlJ09DJ3HOR/f7EU5HMLgTtZ+Gs0e2hltyt2nzkLtwhSpQa+PHyHB+4JOp/IS7JPURhXEkZkWpB45T4EinwdsVYROg5hewyP/UXMSaVyL8dLVZs4VBqBPlus/ogOyGmsg18kmXhnJ2yMHqk6G7K+DtMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829967; c=relaxed/simple;
	bh=Jc5aknRuDoomxHjp8opKPk+0rkF4Bv+5R6HHAmccbDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VreS8ncKi5J+x9aUgZMy3S1VIQkH8m1QWaUCjh+B45+lPMWH9V08v6LzQ4CnZxXLJEkysnTT8NAATcFqgGGhYpYSL3gVpg6VueR8zcjRmYv/YVOLSnNDH539e1OvLnnUZNNnWAuUKpV++YR2IHXV9EuSx693Fmw+aPWgBxh4Wb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NmOAB25G; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78f04924a96so395605785a.0
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 16:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713829964; x=1714434764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZL2SDfOIVdnh5qofXf2kW8VQZSFUt39QV7Ink+MGMfQ=;
        b=NmOAB25G52oTf2q5nCuj0VZyV2cQenixsI1QP/BFVmKmNnQxsP8Kjfw8c/TO3ExXBm
         ailL+3JIYtQ8/CU6L6zpOJN1o7ID7TwuztGxR/JqrYlpdav3WDQIy9N8JAkKdtf77D5n
         BOpsy/T1rTNXPmKEAED4RXP9+vz0Rb3dDuTog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713829964; x=1714434764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZL2SDfOIVdnh5qofXf2kW8VQZSFUt39QV7Ink+MGMfQ=;
        b=i6n4mFDTU6jJuLz3a87gdT9O6/2l73aNvGOyet3MQOY8aR+oovIWrCr1PLy/zaGo1Z
         eEjDEKWrIfDNKgx2BN76qeDR4wvHJn3+g+9RLdU9IruSRmEIguG7VHcNc7yrgvnhDoCR
         8u+8hLELcvPE8+R18A18xykuzhiLNWrj2ijTqwKy0XWCUIJ1CrRJxTJKlb6M2cy/Ldf5
         qVIefxC6hZuX7qyEBDFXJLbzglTx57b0idgby4sBrqeVUWupEICGjWeOY7FMHoZSejrw
         2GkhVMouhk+9mzzfwS1QkBSfKiDD0f8IvGg4olnqdLxYOPXV2jD8DaClDHb/RNm2CY6f
         Cocg==
X-Forwarded-Encrypted: i=1; AJvYcCXNgGmhsMTvaf8Ry/XR7tw6+VDrj+zHCBUbJtQ9IXAlzus7PbAd0BkufkVFgYQ8DK1gXQ1P6DGu/6vUjjxJl9Huxfs+QYar
X-Gm-Message-State: AOJu0Yyn6C3J4Q/cvxnzhp+q6Xsfkjy9GTkgAAQ/gbXbtTwRrigjnoaY
	aYG4kO5/trP5KF1JYIuI+x6wdyeWbI60nIMt4wxxsuTMSKCtW2WA1WtW6X8LCVFWnJf7pvwr2iv
	fqvHc
X-Google-Smtp-Source: AGHT+IGoQUP9NY3d+ogDLccUDamG0zAccbIptmeAgWETDhfd7Lklvwrkc73VvInhkTgsCsPzPTnfIQ==
X-Received: by 2002:a05:620a:b0a:b0:78a:5fd9:46d7 with SMTP id t10-20020a05620a0b0a00b0078a5fd946d7mr13753114qkg.67.1713829963859;
        Mon, 22 Apr 2024 16:52:43 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id vz6-20020a05620a494600b0078d6349aa03sm4760126qkn.103.2024.04.22.16.52.43
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 16:52:43 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-434ffc2b520so79141cf.0
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 16:52:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhmrhI+jWdfD1DBcTGuDg7DXb6/c8qZWmEnyv8jYvahaXJeOkRv4JSFDTw3Em2gBY8vsRBzkn7gmejLs5HgzrRXXlUe/jw
X-Received: by 2002:ac8:550d:0:b0:439:9aa4:41ed with SMTP id
 j13-20020ac8550d000000b004399aa441edmr126829qtq.16.1713829962719; Mon, 22 Apr
 2024 16:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org> <20240422-kgdb_read_refactor-v2-5-ed51f7d145fe@linaro.org>
In-Reply-To: <20240422-kgdb_read_refactor-v2-5-ed51f7d145fe@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 16:52:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VcND6vBd4X6QkKESh-N8xB9L_Dbwi1nmOOfF9FDoSZEQ@mail.gmail.com>
Message-ID: <CAD=FV=VcND6vBd4X6QkKESh-N8xB9L_Dbwi1nmOOfF9FDoSZEQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] kdb: Use format-specifiers rather than memset()
 for padding in kdb_read()
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 22, 2024 at 9:38=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently when the current line should be removed from the display
> kdb_read() uses memset() to fill a temporary buffer with spaces.
> The problem is not that this could be trivially implemented using a
> format string rather than open coding it. The real problem is that
> it is possible, on systems with a long kdb_prompt_str, to write pas

nit: s/pas/past

> the end of the tmpbuffer.
>
> Happily, as mentioned above, this can be trivially implemented using a
> format string. Make it so!
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

