Return-Path: <stable+bounces-100288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 744369EA4A6
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 03:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68DB9166E19
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 02:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5275171E7C;
	Tue, 10 Dec 2024 02:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFmPi0cx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556CF143895
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 02:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796245; cv=none; b=UKgTGZToXrgFmW062tXS1Vy63Db+JSOe51TgwmaK0NzYznohwaF9yKI/f2xcfZ2mSblCNSKXjP0q9IcD9o3ybQqeoM7NJ1i/OeIdPbMYQJQWgHZ76NpKvWwuPb3//+XUe9HaOvT1JX8moR5iUjXayNQI37f+7sNJoHbMYav/Cj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796245; c=relaxed/simple;
	bh=Jakerh7RE60/Ndlj0OBgx0MOg4rjyrFm/As2cV8FFxQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qJ6mHN+L5mMaraOgt+e9YmherEWr0gWjR39BK7O3qEkYHLJP30fL++byvvp6Hd23g9X8if5gdEAanEiq/ngeNKAdOA+Ec5n1+x3kK0qE4bj4sEaB7Dvi37V9LG8gXR3UXNdMsRubK3S26weiKCeC4y1QXWoN+wRCPdY/ecNYKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFmPi0cx; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ef7733a1dcso587497a91.3
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 18:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733796243; x=1734401043; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jakerh7RE60/Ndlj0OBgx0MOg4rjyrFm/As2cV8FFxQ=;
        b=cFmPi0cxyxbeZ3/zmQqn/gGgzsoTQi/5RbwHu+EsYXzNZyHOiYxedMqdQQ6mr0f41P
         Ug5VLZVC/HdMOeXhvmzN357iDA00KTIfh/RXZuehPB2dvGzkrm2eUAB60lapF0Gjbfaj
         gf3BGQkgjYp+CUyYrW0xWs6i2Rnj0eYj/0U2+W7BpaH5tUvk2p+1OVlNHPWmDL3Zr2iU
         tAyhQMnAjHCxTAsoTHHW8NV4Xj4DLD6P0Ew9TClJIyYXfa6koNkfIzptKQKojXSJVPZ8
         dN2ITw3MoiJKiRBFj9udc+vt69gQkNkPTsGnvG8XDh1R83042Y8TW/i0cd6OD65F+vyj
         LuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733796243; x=1734401043;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jakerh7RE60/Ndlj0OBgx0MOg4rjyrFm/As2cV8FFxQ=;
        b=SEZN9meMS5xzt5OK48GuH4YlD0MoIDjj2UhOKMQqarFCMD9age1xHIa0cajJf8xIIn
         VsiBVN+i++5S51dV6P+FE53JoMFQNDmIHepO4kxE+ftXVU+UJ2otM9cFbW5XOg9q0k2a
         J85XPLihmpdfYr2LBD3HHjyBmUQN3B2QKbBuVv+yNZr2W7yQYsrKyZjBstb5i0ZfQ5m8
         O5F9Q8zyKefOB4Mo1zIh+Sl2icVrTiz+sbyc2dGlbQYvAV0yp6hG3PA2dwrmKL53uNVk
         I3O31+RmDbFmaLf6Y4SXRPanIhZ1qQgDpcg8Ik0iGAiENi58cXPZM0cHPrStHGconKzc
         TbJQ==
X-Gm-Message-State: AOJu0Yzvpe+Ju7/XhmBISrSt/GGB0l1dZrqCilVSL/F3K1Pr5VHihH+Q
	tziGELlDU+C56ShOmCLlEKC1GJ8h8EhUUFdeqoQccmDA6aBYKJD77juMuPSekw6JASVqM15b6zD
	ZkSsu1oJZktdfGnqdX3T+a9BUug6LXGnRiGU=
X-Gm-Gg: ASbGncvsKIaqSEoZ5CBBlDxHPHf4kZ5hBPFxA4yhQuYCHvMy9iVsxzzsKPOrWcOj13F
	dUWXsdw3CjSsv+SXRPeX7smmccIIMV3pnO6M=
X-Google-Smtp-Source: AGHT+IHit7GGpk9KiSmgdM2dHI+nSUutPlYwCw2NJLAMvi+kZiV6RnsWx9G+5o1y4b3od21DtTJknZzlOWg/ze5lYAA=
X-Received: by 2002:a17:90b:1e53:b0:2ee:b665:12ce with SMTP id
 98e67ed59e1d1-2efd48267d9mr1015388a91.1.1733796243372; Mon, 09 Dec 2024
 18:04:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Dec 2024 03:03:50 +0100
Message-ID: <CANiq72=ryzv+5UT2jXALNebpYjxm_guSsU-XXm-0BM4WULPYhw@mail.gmail.com>
Subject: Apply c95bbb59a9b2 to 6.12.y
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg, Sasha,

Please consider applying commit c95bbb59a9b2 ("rust: enable
arbitrary_self_types and remove `Receiver`") to 6.12.y.

It is meant to support the upcoming Rust 1.84.0 compiler (to be
released in a month), since 6.12 LTS is the first stable kernel that
supports a minimum Rust version, thus users may use newer compilers.
Older LTSs do not need it, for that reason.

It applies almost cleanly (there is a simple conflict).

Thanks!

Cheers,
Miguel

