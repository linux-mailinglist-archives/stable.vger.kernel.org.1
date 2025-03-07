Return-Path: <stable+bounces-121516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D5CA57576
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 23:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE07179442
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 22:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60142580CE;
	Fri,  7 Mar 2025 22:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8AeTHag"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3529418BC36
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 22:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741388100; cv=none; b=cThTvgpylduugCmiUr/3YG4PKecWQwdrv0OVHznj04ZrCTs53tS1naBmt2lVvmIDdLodbQmTEZ/xRPsG6pAZ6ir5XyQ3jCmZ7lr2Pg4OzwMMp8SfdHlECSPABxpYQyzbvYOKxLteBjHJanKGUQym/7pdavNIejivlcA18ocV2gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741388100; c=relaxed/simple;
	bh=DYOWBzBcYaby8Cy79cwU1ArmGlQ4QzEMeUg/pK9ZWzI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NHtREG1S1f3uJDWJsU0T3G7Ormrgiv2HMrVyn2NrfdaDa5rjV4JVZvBT3G2wQkP0ZcRqGvYDhIXiv6P16s76qraa0Bz12ab+jgS1d2SwKscKGjGQuJZ8/lQ9yZFF4IMmgPnF7MiC6bWVxZUI+AJgtHcxAadFkfpxtwFSRmvXTok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8AeTHag; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2241c95619eso5903525ad.0
        for <stable@vger.kernel.org>; Fri, 07 Mar 2025 14:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741388098; x=1741992898; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pP0NAAChfp/EtONmENI4A4lCB7m3F0YoSMUnpDayk1g=;
        b=Q8AeTHag89rm2zz+wrq4AupoqeZ5sVkV4huPvL+Fg3jBcGy4wtMxYfZKjNsfPm0G26
         4W46uOksS56Q8cQHPi+ojvopFcFNzwukGreIVZfQewxjxciTGpag86Sgx+PprUU1wLvP
         fnhiX1ou3mo9dSved6biORgD90NuoZUyh6TlpD7z6m+7jMsUjS+oeepfyACxTflOZBBi
         w1YIfYLFtXcEmVly8czlhcYnYhuCZNJg/tVd3oprjFcaSur2RDNYTRJnqYuXGKOmpiOK
         VXTs92rYy80XS4g5ppHM9sARCyzGjqfZuW/6vuj+xQ0irbFuyM7oiav7BQPtyKLhUe1w
         xOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741388098; x=1741992898;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pP0NAAChfp/EtONmENI4A4lCB7m3F0YoSMUnpDayk1g=;
        b=C3sLOld5QtypeEQfxcQvM/8YHyGqhRPy5XJrPc4v2zd8siDzThmyWdB7+HXYUb+out
         +3Vzj1RWGYBQ62uaXGysfsvTfkjlV7lMFjkPo83Yq23MzlpCRtfeMmMtSMp4jyLRL8lB
         U2BsBEpT0Vl8+C8Uu97c8XerICmAEVQEsGw510N7G++ihmh90/LZ44QbpaeF3wpSEjMH
         eSuKPzUeUWZOr13LNLC3YV6rhJI+f94c0dg6VcL+szGdtDOFbctqwIBuxcctWy2T4wSq
         aBAqDzGclSQyAZjasoW3gvia9sdW+GEQJulflW9n1EUrLSuC6WAaUZ/mqBjmqHSnqCie
         QuRw==
X-Forwarded-Encrypted: i=1; AJvYcCUdn5HQzju7Ehc5RWnTxAZV3F/inYF0TvnA67B5zIQqgv3n6Gs3gWpNUi/XSVKm84RfSvPTG5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMlFGedXQ/7XQ/LAN6zmGpKFeGojl/XlmZPechlbjhEkIojYYP
	2cBLZ3bn+uwb1O4Aamc6iRdrROwD3O/Ea2qUwbAXq3seiYVODe/C6pzZhhDkl46aaQjRaXbXbc5
	BuBMTT9VEIFg/lLhWxbxU2YFZwoI=
X-Gm-Gg: ASbGncsIZXCCW5axcUDYoFNjM5bL1Cu79/7slZMtduvNYCiQqsCZc46o6aCl14GpWv+
	q8Bnz2/K4P0tKVcbcKLfl+MR21JvNDA7HDMvJJsk3Ar5W5fLl/4m98c4T/W/T6VXh9tmDy6Pcyg
	vKrmUd+34VorBGWhlyGfWWUnPRhg==
X-Google-Smtp-Source: AGHT+IHZQfHUFoc4CuJ9MdPvdZ2wi2/gA/z2OkjmZFm/etoyq7qGjTx2n9h4JAknfy+q60nSYFH5Ifg7TG/g6iZXQwU=
X-Received: by 2002:a17:902:cf04:b0:224:18fd:6e09 with SMTP id
 d9443c01a7336-22541626418mr4353085ad.0.1741388098484; Fri, 07 Mar 2025
 14:54:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Mar 2025 23:54:45 +0100
X-Gm-Features: AQ5f1Jr3FULDQGa3IBGlFJXukLTOK1t5_A31cWtMbaT5BrHLGD0vAmT3wpO3Pf0
Message-ID: <CANiq72=SXs+N3Fn1OD-Sj=h_HfEtaEBFgcNETNzVRuPbtwFtxA@mail.gmail.com>
Subject: Apply 0c5928deada1 for 6.12.y and 6.13.y
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	stable@vger.kernel.org
Cc: Andreas Hindborg <nmi@metaspace.dk>
Content-Type: text/plain; charset="UTF-8"

Hi Greg, Sasha,

Please consider applying the following commits for 6.12.y and 6.13.y:

    0c5928deada1 ("rust: block: fix formatting in GenDisk doc")

It is trivial, and should apply cleanly.

This avoids a Clippy warning in the upcoming Rust 1.86.0 release (to
be released in a few weeks).

Thanks!

Cheers,
Miguel

