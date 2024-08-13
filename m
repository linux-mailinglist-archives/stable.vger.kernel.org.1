Return-Path: <stable+bounces-67541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2495C950D3A
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 21:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575B01C23D07
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 19:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB3019CD13;
	Tue, 13 Aug 2024 19:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bb7Qs0aO"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619AD44C64
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723577871; cv=none; b=A2cZMRWhKYqVSN9Cr8mJVyWoN4/VvnUpH718rnTkpHyjbJ0bfdh43stkVPtK1PCzD37mYsdO9PfStSI+fx5qQBQK8PF16YcIaoqRIJK2TcigQ2ap7AYhnWWoTLwAHIcDpRkFBo+u9na8j7FYPhU54iGz5VjMAqUaWhO/O1vqBMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723577871; c=relaxed/simple;
	bh=8nbTxG6ul06gdddM2ThE6ol60wyu8mt4eeOF2miuNOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7gGjxqXEBaQ+xBJHtMyq2jNzsNSJnBODzX4dn7ccmsPWNskxQTJcxfa05VGNf8+4IW37pSznL2aQAiLJofkRmagwn72GaOS1lwDea3CRmf6/EnBkWfaP+l5XHadtctNctoxeOi4+yElkwHSQ4x52PHXSq7s+QrMsDaeYyEEjMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bb7Qs0aO; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-682ff2f0e67so54526667b3.1
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 12:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723577869; x=1724182669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nbTxG6ul06gdddM2ThE6ol60wyu8mt4eeOF2miuNOQ=;
        b=Bb7Qs0aOrVgDj3ljMVp3FXYJlOoWSZk4eB3iIKbNnlvBqvYYrxB/s1RNgq7fJxaCWC
         cZavch1lfl2KwgbhK65Hy9JajGsTqU3RQ7bI686GzZb+95W6Dq3/br+fCos4Saaq1nac
         ntjlU1ddN+DrYhIG/Rrizn0JyXSO17Rko8qBZd7YstK1tiCTaE60biEqzzivtt2I8D3g
         xMmoX+KJ2NSk1gmpMVe99LnIUeXK95MldW2f6jofrYVG+ezss0/PwjN1gzsNc5Ocd56l
         AHoUEiTiempy2lFgkKTJTHtnFFDVM6ZAsyhZXnH1y9dtvh7NT9JBcW1cnbaK0CCaWdMR
         2NlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723577869; x=1724182669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nbTxG6ul06gdddM2ThE6ol60wyu8mt4eeOF2miuNOQ=;
        b=pcCEDck+QuiAKRSDyiGzy3u+P531e5Pzt7XGKMwO7/KaXyzMru4avcaB7f6+5Cnzgs
         58uk9nBeO3Nlze5OtYxpOC/Cgm1QKwE83Zwhaf9AmmlVxNQf7Ia18WuoGQv2Dir/5pyy
         WyOemRe24ltCO4VCPRlfKfFu20lTGse6t2P6gM+ngnaVwxa3Ks7+dunTe83GCxl3jGSo
         aSEVFCDHq3qmz/sso56HiSDi2iG4XBBTWCV8uzxcUHd/IhOLQnZGPt/u3lML+lsy869v
         QvGPUS75y45FFQ8peKrv5bmwpc/lIbzGTKSrHRcTbfoe1psx7Kif6aPOFXM6n4wydBu4
         Fh6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCOxmeKqfmyG/R+OX3kvq0MygH+VO1tYIdx36Ttr6Yb87He84kbHN019hV2CINzGAPr363GGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnOlpGPRegMreYG3KySgsRTXL4mdpqaz4y35yyNGJa2eJCyhee
	EHCmtjuE3gwaC2Vh8R+mlkknTY4+pQLApV9BAROrQwf+Pzz+sAo+7d0DAs/P3Te/YShHFS5E6A9
	kTEiaFiDYWIhsjJJGlBagWLKwdmIweJudXn73
X-Google-Smtp-Source: AGHT+IGXWf6bK0UPQNxfbUkUm4mLIEiaCdojIpQ/f9obpg9wxGZqXQr8EA1JYIoCvM0/YAI5Rbuf7XqfsSCF6zRaZ78=
X-Received: by 2002:a05:690c:3088:b0:664:8646:4cf8 with SMTP id
 00721157ae682-6ac9af0d395mr5485127b3.33.1723577868965; Tue, 13 Aug 2024
 12:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813150758.855881-1-surenb@google.com> <20240813150758.855881-2-surenb@google.com>
 <20240813114029.4bc61d6fe731a533eb88ba64@linux-foundation.org>
In-Reply-To: <20240813114029.4bc61d6fe731a533eb88ba64@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Aug 2024 12:37:35 -0700
Message-ID: <CAJuCfpHX_QYBUrbWPLx3c5_Dh1+VdH_GcYs1v=Q7yriLHyvvqg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] alloc_tag: mark pages reserved during CMA
 activation as not tagged
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kent.overstreet@linux.dev, david@redhat.com, vbabka@suse.cz, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 11:40=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 13 Aug 2024 08:07:57 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > Fixes: d224eb0287fb ("codetag: debug: mark codetags for reserved pages =
as empty")
>
> I copied this into [1/2] so everything lands nicely.

Yeah, technically this does not "fix" that patch but since it's needed
for the next patch I think that's fine.

