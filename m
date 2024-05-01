Return-Path: <stable+bounces-42884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36D48B8BD4
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 16:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C321C2106D
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 14:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348BA12F375;
	Wed,  1 May 2024 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLfR2gWg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5AD12E1D5
	for <stable@vger.kernel.org>; Wed,  1 May 2024 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714573562; cv=none; b=ZXXUYuUT8wPjQAwmJsnPqJs6N2EfzBFBsZLZkwTZ6NT81PcOgB9tPbUyjrmrednj7YZAuTH70/als2V/9f6gd63ABqOIxfXqH3FGNWhiWtVcOo3MkeTNopjnZ1z+xeZ5mgGCxWH8wV7anY1awnwwHgAn4cOeD1STIYCY5UiOK+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714573562; c=relaxed/simple;
	bh=fcHvufFFXZ+akEkYboV9zst5m9ZUEIVky4/bpfz81Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eN+YS5Z9lnGa3LhE7pDgoh/pVRfYZxLt06k1cmo6j30REK1kwDpYjkar0yGa1rs7Th6s3/1NFiefN9XfcT/Iq3xI7j7/cxAy4luh2BTKLDa12p4ATRHr0zUMs645UUUuhUxgvjP1jE08nMaoXUR1bWiHl9/ou+Eq3gXRdH5uHMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLfR2gWg; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6001399f22bso4716838a12.0
        for <stable@vger.kernel.org>; Wed, 01 May 2024 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714573560; x=1715178360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcHvufFFXZ+akEkYboV9zst5m9ZUEIVky4/bpfz81Og=;
        b=mLfR2gWgAWOIWF9enMufl0YDXk56zi66prT12N1wBCBVm/wkQKiobiRcxd4gbkjCen
         mDjBRMWn7WR6PKLfxRAajjgtxQ2kRDxBIYpNbgy7uBpWxmlKUl0tnugesiv7B7zBtCbj
         S8JVuK5k4NBPpb3crzw+wxqaRetOSK3GyVnikBfzc3PZBaXkRY+Zmt8A2rLp9iGZpKSK
         Fzr9zkGIHNaljrtc/9dG1GAaJHXFb/iJjEFdvi9AJ4BzkXnDpOvXVINJmI+Irb1hkker
         nMJaDC5Z6+uMGSfi5q11X+BkeXcp1i2gcL+wmAhnfrsc0il2koueT9ZBQfqVj4kgMx2D
         SAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714573560; x=1715178360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcHvufFFXZ+akEkYboV9zst5m9ZUEIVky4/bpfz81Og=;
        b=RgdJ5+VMDiObln3J66QPF1H6jb0powi8OniezMf/WFwicqUnaQeJfd2wIz7ECErLvL
         iptooELsGK/UmfJL7H8fM403rbmYd7HnnOUnPpgO4BwIkIPGkf4xv/oojYyS53NvwHgq
         BrfT/uslc+aYEXZoD6BYQWFozH0XF4cw5yS/WS2lWtbB2sdP57h6uU07KLezwMPo/rdx
         iZqmNVCJnjkfPxBnJQczF+Xuhz5SNHkRdsIwXxn9PkycGF6mmXUJr3mVebFwqlaENM/J
         X3PPK48C1isven86edGAP7T15CuLpTE4H0eEv4J4hp42maGa58sXSk4eVzhwksrlTnkz
         HDKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTjGw6rCmz5qvnKV+CpksY2e768vqD38uieckqMZU9UCVLuiCRa+mI+leUXkO8ZWG2pM3lq0A2PfwOybtBRWtWU9KW9DiM
X-Gm-Message-State: AOJu0YyTY76ogrdlrqUAuF4bwWN9KQ9SQzU6DV2Plt3sqdd9dILFVyuD
	uKCA6rMEFt0LNci9opKIsLfRYjSRzvDwPCfVyujYNwsOG/U0P8mE1KoQUH78eAYCGtvG+N3I7Wx
	eYdQDaQA9AhCggauaP6rJrPUd0dM=
X-Google-Smtp-Source: AGHT+IFR8nvYcuqTRWgyS6Q8KO5M+AcgNcB/TRzVeFlHsMz91a7KfqGLozTtv/ovEFjEHf07pEDwcbsSR6rXuhToxY8=
X-Received: by 2002:a17:90a:1fc7:b0:2b2:c380:dcac with SMTP id
 z7-20020a17090a1fc700b002b2c380dcacmr2640166pjz.45.1714573559945; Wed, 01 May
 2024 07:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024042938-computing-synthetic-f9fe@gregkh>
In-Reply-To: <2024042938-computing-synthetic-f9fe@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 1 May 2024 16:24:41 +0200
Message-ID: <CANiq72kMo0eSgN+bFoHGHcJeqkMPdmi5VC3X6X_wXPq1kotDDQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: macros: fix soundness issue in
 `module!` macro" failed to apply to 6.8-stable tree
To: gregkh@linuxfoundation.org
Cc: benno.lossin@proton.me, bjorn3_gh@protonmail.com, ojeda@kernel.org, 
	walmeida@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 1:21=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
> Possible dependencies:
>
> 7044dcff8301 ("rust: macros: fix soundness issue in `module!` macro")
> 1b6170ff7a20 ("rust: module: place generated init_module() function in .i=
nit.text")

For 6.8, this can be indeed resolved by applying the two dependencies above=
:

git cherry-pick 1b6170ff7a203a5e8354f19b7839fe8b897a9c0d
git cherry-pick 7044dcff8301b29269016ebd17df27c4736140d2

Thanks!

Cheers,
Miguel

