Return-Path: <stable+bounces-17619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E11D6845E4A
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 18:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CB3EB2BC16
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 17:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5509160896;
	Thu,  1 Feb 2024 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AdT7v9HE"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22135779E8
	for <stable@vger.kernel.org>; Thu,  1 Feb 2024 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807734; cv=none; b=Hm7SR+5acgXzWcOgLCR7Qg9KisSaXblwD51AaICZlO/vteG6sM0/69a4oijyocUqJGav7c2Ygr3O09+ztMKkMF+LENJX/o5nueOUPvFSK8fxexFBXRDmJTUiVfNeKKAAU57bXxWu4M02Ym5WAw3gzjSLBTDAdgDs2HLV3zfUBd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807734; c=relaxed/simple;
	bh=d+s8Z2Xvuo1mePi6I76H8e2OvaAsjnwaTz6fYYJ56E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWqWIl2/96udMstfDmJJFzGieBWcKUaBLSFkat3xeLoHCTSaetIr2W6j1VN97/4HumUOf9t9AIROZGmlg5ESnPfSSz51/EnhgMIPXk6igezApF9ojXOZnE/vJzXybXxFQjcM5cb2VIH1lgIFH7VFRB7pKkQmvWOeQeBKz1ssegc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AdT7v9HE; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso877798276.3
        for <stable@vger.kernel.org>; Thu, 01 Feb 2024 09:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706807732; x=1707412532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Domnr1s3aQyDnhRWlOXt4dlZdSFyO/cFk4v4hES3xxs=;
        b=AdT7v9HE6ROvgoLanJWCQ6Dv8uJFV2ZIVLK4cNPgTYSvLeyW+XA0YEhliSB35XXis8
         v8ad4bvUU7lmjP56UKduxGxwUrkBU3sk06ZMuQc07043h5cQMcp2hUE7oaM20Ziul63J
         VEDPIyUX8oMcOTBQisLgcbnkOUhfpNpUZF/K+dRqaKHOQJ33x5ZADTYl1zumv9BQ2cES
         QluoN8tj+etlYIGWbGweb5QTJrZSCFDNKfKuF4gwjk8yMd2DMG5dV83WQUO1ABvqBg3P
         p9CzspF/N8XCGanVj4IShTcW86EhRZqxmY77b7T9nwPwzwQ1H3GacF+/HKsXllxD5Jj6
         Uwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807732; x=1707412532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Domnr1s3aQyDnhRWlOXt4dlZdSFyO/cFk4v4hES3xxs=;
        b=MN17y5RKoASjBRkszzaZ2urqccGA8yYvLi1xjKrkn0bPii7dBuwh2VXYamuaTGRJHR
         NEWbSBbw5vUBdXmkjjyiU1OR9HhvmXJcsSv6i7sfIrnsLRBFaEU0u3rdPw88anQttDXH
         t2YK3SlI7cW0WmjlfMFoO/CF/lFe3myuXWJBVOZquv9KVlAQS0FTpIaAzHSCN908ZIny
         ohTBZxSc8rJvD1eokrb6p6QM/KmyzSH68DFVaRLyDft+btK4hUBzyUB+vcVrUHC6xsNc
         aW8u7SNTpWMbAPxUqN3cwrlbUbixAaQact5v6U7/TuXieAt/Xb6Vp81a0nXC1sOgectg
         SPfQ==
X-Gm-Message-State: AOJu0Yxjdz9XFP17/6JdODosYy88zXMHW01rst6OzXp18ig0EIpawA8U
	2xudjJRScgNL+pgj86Z41BBq8/1IC1y9jWrfdzwhjgyj5v73fWvgkih0z2HJJwjn1jq6UVeBHHB
	91vDsU+5bJ9MlZikcSfQFJwuGXjEBkx6G11ir8Q==
X-Google-Smtp-Source: AGHT+IGQ6vYwsM4Y12EAsH+g4PfenUxelsupPyyWkskeJvQ4zuZHkDjHDH6INrjpKC9gtGxvaroUKAe0IvEDNYr8LeM=
X-Received: by 2002:a25:8608:0:b0:dc2:232d:7fde with SMTP id
 y8-20020a258608000000b00dc2232d7fdemr5583512ybk.13.1706807730545; Thu, 01 Feb
 2024 09:15:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201171048.77687-1-sashal@kernel.org>
In-Reply-To: <20240201171048.77687-1-sashal@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Feb 2024 18:15:19 +0100
Message-ID: <CACRpkdYUtGrkJDp-NzHbB373rJtk-D8-AFOd0Sae74sH3oxFDw@mail.gmail.com>
Subject: Re: Patch "Hexagon: Make pfn accessors statics inlines" has been
 added to the 6.6-stable tree
To: Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>
Cc: stable-commits@vger.kernel.org, Brian Cain <bcain@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 6:10=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:

> This is a note to let you know that I've just added the patch titled
>
>     Hexagon: Make pfn accessors statics inlines
>
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      hexagon-make-pfn-accessors-statics-inlines.patch
> and it can be found in the queue-6.6 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please drop this patch from the stable queue.

Yours,
Linus Walleij

