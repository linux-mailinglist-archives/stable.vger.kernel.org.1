Return-Path: <stable+bounces-40418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FE58AD95D
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 01:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1821F215AF
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 23:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991C44776E;
	Mon, 22 Apr 2024 23:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="luwKqjTh"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FB84653A
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 23:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829961; cv=none; b=gH0zi04mzTyYpQjHroV7vSbrWjrjnaOfY8aSq2Ty+Vhgmvxyg4z0nbxePjvtopMHMNgKbMvSmdPUexJfoJ1wdP/UAD4ldT8vRJ60DT6aYiNgbDv71MlDqPELJH2IvgrYHFt4orCif07sc1lNxcGNkPSmVdzFdf6GW7+Yj2m326o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829961; c=relaxed/simple;
	bh=HCos0K+i+5RXb5PiJarcva8R8QtYBJwW3vScJm07fZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POb7u40DgmLXPwUGHBUVFUtdUpNJnrYWZLNocWUhaWdNTyT7B+809PA+oQ4XG9DeqmbhNrTn+WbgMkD6tRRU7ES4G5/q3uGwYjgDlZ/eQjWPR7dRdTlVg7WhBUp82hSbr8lsRSJ3DCOz7k/kWFbIThBr1tU0oF/2eIQXxKgtsOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=luwKqjTh; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5af27a0dde1so878393eaf.3
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 16:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713829958; x=1714434758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YK1IULy+gt9h3QAWRMC7n0H7pNm41l4ocPRhnJtOinw=;
        b=luwKqjThq2dVPhNvaRCx/r0V+7xp1DtacYT6fwgXZOpoZCaYuk+ME3UC4+0XQsJUVL
         VyGpEwwryqU9A+VTw36bKegk8KC+4+ZiuUJxekUKlaWUIzIsQ/xXI3V8Sz2g7YFhfH6+
         OrYR+Uo3wszyup/WJSCzNBQY0/RA6yNlIpZ04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713829958; x=1714434758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YK1IULy+gt9h3QAWRMC7n0H7pNm41l4ocPRhnJtOinw=;
        b=peuvSB4I40yDtyfGbTj25qDfyymR8X6ja85HahZjlNPpQLo7KNY6Gv4w/cvHY80ni8
         Ix/IStWX85zAkqVnpVeGTSmxrt3PbRm9+KIeAHREZuds/KTcJPCFg+pNJ4oRITtR9/QG
         Am+0fDV0PLnvrYycx8JBhG3w90+i3KJushyc+GH3Bq5ka5Kl4PSSByrl4sHXtJyWW5N5
         eB+M0MP36MnOOrKWhiO4qTH5jmPvVGJbtr5c9fc4d+pOsngDnouNNyRrL+y2AbNVhyRD
         eYaU0CwPvBTMEU6cviM1LBO8uz4u4q5Hv/5lLgGGiyq1irM7sTKzdD6hFrbS/e1PewQ3
         S35A==
X-Forwarded-Encrypted: i=1; AJvYcCXVOpL68mUropb2ogIlbgi94zORycoNLQog++KVvHVv9dLtY1vkMyjDPG2y60wt3w72UB72j7uoHwsIyAXnQFrXkerhGVVh
X-Gm-Message-State: AOJu0Yyg1Q4QML3FxLrC+pKuVsSgWVHgogMBjpo3wOTR2Yzvg2ROHmXQ
	0inMqD4UwGO/hElmVJPtUt7m7pIkIreOyCWcQclDxo1C9udYP0xMdX5cf+8VskazbErxAHKKe6M
	3vUOC
X-Google-Smtp-Source: AGHT+IGySu/zDvotNCCK7a5A+TCAU4FBgPIAl6NJbhvPLyOOPOOzRUz2r1RlqT66ittxjFO1/KlPYg==
X-Received: by 2002:a05:6358:ca4:b0:181:601f:d8f with SMTP id o36-20020a0563580ca400b00181601f0d8fmr13780896rwj.2.1713829958290;
        Mon, 22 Apr 2024 16:52:38 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id h5-20020ac85485000000b00439cccb91b2sm848688qtq.73.2024.04.22.16.52.37
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 16:52:37 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43989e6ca42so139861cf.0
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 16:52:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhtsXJXbeDkIveUp3ZXahmlYT5piQ7wbQaqBTpDukpVsk8l0mzya2/zBtPy17CzfPymx3Cm6xJE26XeXkRTGeYkrCNT1H4
X-Received: by 2002:a05:622a:810b:b0:437:74fd:bd26 with SMTP id
 jx11-20020a05622a810b00b0043774fdbd26mr119139qtb.14.1713829957071; Mon, 22
 Apr 2024 16:52:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org> <20240422-kgdb_read_refactor-v2-4-ed51f7d145fe@linaro.org>
In-Reply-To: <20240422-kgdb_read_refactor-v2-4-ed51f7d145fe@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 16:52:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UnvAxOmbM50yADmzE7qgCZXW-Y+-jAQ3ngO=01=m1fsA@mail.gmail.com>
Message-ID: <CAD=FV=UnvAxOmbM50yADmzE7qgCZXW-Y+-jAQ3ngO=01=m1fsA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] kdb: Merge identical case statements in kdb_read()
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 22, 2024 at 9:38=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> The code that handles case 14 (down) and case 16 (up) has been copy and
> pasted despite being byte-for-byte identical. Combine them.
>
> Cc: stable@vger.kernel.org # Not a bug fix but it is needed for later bug=
 fixes
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

