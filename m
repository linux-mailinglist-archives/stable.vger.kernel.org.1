Return-Path: <stable+bounces-76715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5A697C046
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 21:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A7E1C21064
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 19:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A972C1C9848;
	Wed, 18 Sep 2024 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="X8CevSOo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D8342AAB
	for <stable@vger.kernel.org>; Wed, 18 Sep 2024 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726686230; cv=none; b=Y+NwO31W4Ui4NR2pvUXyrqnN8iUSDum5WMDmM+1Wsa1AT6kqZNpbIyNeLZudiMUSZf10qAC8AzLJ1XfGS0+qkTW5UGAaR6wfLVtuu0UEAp+FfBrPOR4ky5gcx6yMRWgt/ZMz70eC+0JqP+GeAIRJ46fQwvktqp6G6k36u8bQNpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726686230; c=relaxed/simple;
	bh=KcHCBYe5Bz6S2OMyoWpN1ozq0/s6h3MtBgf+WQidzPU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aV/lN9Dmt6LVLaKGmS9nhIDc44vFTGN2wwLRrJOPnsnHODi/Zf4zaFWorKcEVUGAkKdupSJacElWzprHsvcXMeevcN0h3FHyncFOT5/74BSNM/WvitdMuROEziT5koINiudDDXBxVmuHrFJ18YaW+KDuhJGU8o2emUK4pmjgjHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=X8CevSOo; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c23c559defso4613a12.3
        for <stable@vger.kernel.org>; Wed, 18 Sep 2024 12:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1726686226; x=1727291026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KcHCBYe5Bz6S2OMyoWpN1ozq0/s6h3MtBgf+WQidzPU=;
        b=X8CevSOoAMczJ1C9ILvUR/kuWDMGuiNA7aQWi08Ts0KzzFln4nQ4r1jOn5+3WZJrMi
         mED0VTc0n8YDIsRmrESR8IFJCuKmqeu3jj0+g7h3cq5VZTHE2fNfDiUWLQgT5VgKQ6g0
         cjLvUTyHr9CqG8/KGHBQ6h1UPWfXDyk2Me/9w1zwV9y4/6mzxKN87QVvgIDrRWRqfpFF
         S2Q6TD2p3cGJ2zoIbyPFtYWJljzQ3cVXKLJ+pLAO+RQ/rD113Pvbgfd+kL1JbSHGbtQF
         tZAKZsBg8a0L/K1d9Y7UAHAzGDnNqpdQrnCsVpHjpWywwW4eFdzL7X/2XGQwntL3nx9Y
         VEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726686226; x=1727291026;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KcHCBYe5Bz6S2OMyoWpN1ozq0/s6h3MtBgf+WQidzPU=;
        b=hjZ02tljH/G2m8BmUasDeFgu3MoypB5iIW4sACJbAwGko5RpZMi2y+H3sDKouW+nXr
         mAUmGjtNygoVY29xf11QOwTdC+LmSzY6lfTRqxwE4MZkCYyugF8/yKyXyDzqwJ82NJbb
         bpeNSuh7Yk+UaMr0wlaH3h/3Mus0xrPRo86RtIl4HPi3OB6ULLbDmviczAWVekyiK5VL
         OrEkbmH/hVLhMku2GWRhP6LsHc2rSO9zKiQ+JwehjeXbi80tbHyYcrVuTrfU0i91oxCc
         FGslFx0zxANOsSTDJ1GI4ghsqxukgNbjEIUt0077eW0lDygALzRXpxlsd67cQxqAcrlG
         AstQ==
X-Gm-Message-State: AOJu0Yx5GAiHkivvPP0ILzUOyWYWzKLk1DJ4MJStl74tMSvqd2vVV3/Z
	F87brzlbUGt8ybMl8luZh1CQPAl/tttGPy+PGKsHzlu+3VpHA4Yv7swJRU8YgmDY1+coWwyJKLe
	nAyeuV9RHQuS4VovLjqDdp5pApE6NACDL4qCkgB+8uI8FW1TBKdQJlA==
X-Google-Smtp-Source: AGHT+IFGYU9UfIn3o6lgY8SAP3X3VRax5v70CM6B59HtOwV+LijdATMtO3mXoTTNK57DWzFJCmMTY08o5PnN3cLxuMk=
X-Received: by 2002:a05:6402:34ca:b0:5c4:bb1:6493 with SMTP id
 4fb4d7f45d1cf-5c413e094a7mr8037496a12.1.1726686225897; Wed, 18 Sep 2024
 12:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 18 Sep 2024 21:03:32 +0200
Message-ID: <CAMGffEnHRA5b7RsEBGc4TPL4XDRGUz8hsLgnJpo6B8S=2-KG1w@mail.gmail.com>
Subject: stable request for kernel 6.1/6.6 for commit f3c89983cb4f ("block:
 Fix where bio IO priority gets set")
To: stable <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: hongyu.jin@unisoc.com, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

Hi Greg, hi Sasha,

Please applied f3c89983cb4f ("block: Fix where bio IO priority gets
set") to stable 6.1+, it applies cleanly to v6.1.110/v6.6.51.

Thx!
Jinpu Wang @ IONOS

