Return-Path: <stable+bounces-19476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C30D8517ED
	for <lists+stable@lfdr.de>; Mon, 12 Feb 2024 16:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C86282BD7
	for <lists+stable@lfdr.de>; Mon, 12 Feb 2024 15:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECE13C092;
	Mon, 12 Feb 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmTE8CP6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D333C470
	for <stable@vger.kernel.org>; Mon, 12 Feb 2024 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751695; cv=none; b=gA96GbBXoUNAYBw90WKhK3pOnT6GeeeLyjULaM6S4CJyIySDQWdkbJVrtfFpZs+nKkk2LnFiTStKk/OGts5Oqcqmavnp8AFCVgQxJBV/Sc3WdpMmTCEdmiSVjVITrdVahSQt4hLpQ+9KM/FRLapC8tqZ7VDGDX2ex1z4ojpHSis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751695; c=relaxed/simple;
	bh=+Uesfua+CvJPDWq17ArzMv4ITuUC1A14TVjd7UU+nrs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iWe3S5cvOyYCHAsO7gepUIWEhSfLAqE3R9D2rSkS7uT3v/kJCgRfto0zNtdk5QCQ2A7y8ViFV+AK/XmNsWB6uNVXLNFU6rCz9kqCBkEok5bsB133Csui341iCisChYwcVPPsQeddbfR/I0jw7DVowuBtVhP73yMTcArS36nJmRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmTE8CP6; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e06c06c0f6so2506138b3a.0
        for <stable@vger.kernel.org>; Mon, 12 Feb 2024 07:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707751693; x=1708356493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wVQqSLmG6k2OkxB3p97oV/K3kbotGud22eLraa0EYmk=;
        b=hmTE8CP6lKNfJjjTXuAbiukSCqdOa9meDerlgGtycmSMeptbKSznYCIlFPbG7Y/FBS
         zCBsI31VxkahzLHp5edr7LUedMaf1DbAppQQGUUhJ/JbfouD9qQVs17WSK90B49BTC48
         AosqaCOuBtSSPJVR80zLXfRTlDJVS5qATNBApjr2tE6U70/QegetWENkTpN4aDCgisHK
         aTB4A55yga3aUnWVAwKK8aPjAymDV8R0e/L70Wz75t+vgDnkwhnXgnDeHC2wgnyT4EjL
         fPE7xQ/1OHJbJ1Jp7sn40CRdnL3elXhWjn0QoN9kmmhBoR+ntP/AjHswgJxmDmDKCG9O
         PUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707751693; x=1708356493;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wVQqSLmG6k2OkxB3p97oV/K3kbotGud22eLraa0EYmk=;
        b=fMYFYx2shGzB8HW5GGmGp5iSwW1Iki9cC9uGY/mG9eXnLGHVasCt63LU3B8eaWmabc
         xpbR75/e3yXyBBrK9TM+SMG1i51nAJsNCkyGWYr5zkKNp6OrXd3lv2EV0vdbj4XIjiXE
         GiEABFdbDZL3iMWkF6v3S9wgaBC4CiB+cpbsFE1pReg9mLwAuRcLQXk61ruF3pabo1vO
         DtD5EECwI5L8k+9u7u1HBAkFQXDCFCbHZ3yXZyzQwI0k5Qm6MxDGeFcwH5UXQkpJFHdF
         leG+mZ+F5/mCV1tbeSLFRr4sZWMbRTMxuuOs1D/8L0MH4t7DqpCdTScTVJR/cQQLr3Oa
         8yxQ==
X-Gm-Message-State: AOJu0YxromfVX+wQkOqnsNmGl+cpXb0kTuLI3eq+Kt1t1eXh5X9pDlcU
	0g3ZWgkiFAj7f2Ea1pC+5prIRIcb2UPJjh6zXaXWVIGgKH4Max257xtuXhfLFowyuEahfDttJ91
	5wuHhmfgXc+O7yymj/OPmMOr+TTHaxZhKqk0=
X-Google-Smtp-Source: AGHT+IGjCcUB9s7vN4LY7VVmdgp0VYcLtZ+6VXRAyZJTcrgcfOP4hBoTCUF3kXOunAufL7lewgzCoKW3TAZW7GZj0t8=
X-Received: by 2002:a05:6a20:9d91:b0:19e:b614:685c with SMTP id
 mu17-20020a056a209d9100b0019eb614685cmr8696283pzb.22.1707751693250; Mon, 12
 Feb 2024 07:28:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Leo M <lmartinho03l@gmail.com>
Date: Mon, 12 Feb 2024 16:28:02 +0100
Message-ID: <CAJbWX8JREQs7wFtFOfkhXTNhP1wPg2qTUQAJVnUMDkMDFmNBFg@mail.gmail.com>
Subject: af_iucv kernel module fails to load on bootup / manual start via modprobe
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

* update to 5.10.197 included upstream changes from 6.x kernel.
* in particular this:
  * https://lore.kernel.org/all/20230917191101.257176910@linuxfoundation.org/
  * this isn't an issue with the upstream state in the 6.x kernel as
the problems this change might cause are alleviated by this commit
that altered the way the iucv_if symbol was loaded:
     * https://github.com/torvalds/linux/commit/4eb9eda6ba64114d98827e2870e024d5ab7cd35b

In the current state the symbol is not loaded correctly and the
feature is not working properly.

This issue hasn't been resolved still and is in a broken state up to
the current 5.10.x version. Is it possible to include this fix in the
next 5.10.x version?

Sincerely,
Leonardo Martinho

