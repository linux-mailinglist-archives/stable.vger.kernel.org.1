Return-Path: <stable+bounces-41589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198048B4C52
	for <lists+stable@lfdr.de>; Sun, 28 Apr 2024 17:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7116281953
	for <lists+stable@lfdr.de>; Sun, 28 Apr 2024 15:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D79C6BFAA;
	Sun, 28 Apr 2024 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="fWybyjhf"
X-Original-To: stable@vger.kernel.org
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234C26A8A0
	for <stable@vger.kernel.org>; Sun, 28 Apr 2024 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714316775; cv=none; b=Ur+AkHo9lYTT5eI9KM0V6iQQq1BT+X0YtZNwoXgGjUCmc/pSBMy89vEaldxhXKvoIvEOIwWhvaf9AK52D93QrtkvQoLi2CgRt2yXWLcifLIt7ZFd1sbF40UsdtU3GW4mRBSuz1O3cjMZsPGXGV4cTN6ImjQzf04fG+OwcWGY1d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714316775; c=relaxed/simple;
	bh=hP6bWKfmIWZcvLvnBCgb2WgOYQ6rMbADOOuc5IufO5I=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cfAOzCdEpNolKvKl2t3EUyPZzS79Xcpmzc6zH7e3iXdYHOT5gnjHhkn5RX+iGdI0z2OEFP0vhw33FMCnvJYrtONQfg6OTvukyAKxUuHbWAYxPZ0QLMkzy7SV6b/buHxSPmJDMRzQAB1ZdgDJ3kM33ET4ciN045B80gL7aw9WlsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=fWybyjhf; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id A6BC2D96C5E9F;
	Sun, 28 Apr 2024 17:58:09 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 9cGlU_kSC2O9; Sun, 28 Apr 2024 17:58:09 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 7221BD99A2FA3;
	Sun, 28 Apr 2024 17:58:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 7221BD99A2FA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1714316289;
	bh=hP6bWKfmIWZcvLvnBCgb2WgOYQ6rMbADOOuc5IufO5I=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=fWybyjhfR7gJZEaXaLVJgeEEyb51THB9dBd680Dfe9O9pFDQMJWT2z9PAeHnUjarO
	 YpHofv08O12/iUBcUGDQGEqvA8Uecz/MlDKZ3cl/et2/iqoqjWd3nQMxc6B5C20jo1
	 XHX59AM1XYwy2tLxqDAzvCdWECtZQOg5eCwZ6phgsDNTQqaoGk0s3P56T3Wzg+lO5R
	 mw6mLJx7uAy/sfyS7EWa4NuqT3lbimSin8FvH6XSdld9fVm1xRk9pHgfHuO9jczf50
	 XyO79KTZt7z4p3uP1BlIF3XphTEjHkvatJmTHut4ODunpAYN0/ZP37HjjIHROrG/tF
	 m28BZ5xlIEkLg==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZPPkGjyJ0eCd; Sun, 28 Apr 2024 17:58:09 +0300 (MSK)
Received: from [192.168.1.100] (unknown [89.250.9.26])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id 0E4CFD96C5E9F;
	Sun, 28 Apr 2024 17:58:08 +0300 (MSK)
Message-ID: <1c978cf1-2934-4e66-e4b3-e81b04cb3571@rosalinux.ru>
Date: Sun, 28 Apr 2024 17:58:08 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To: willy@infradead.org, riel@surriel.com, mgorman@techsingularity.net,
 mgorman@techsingularity.net, peterz@infradead.org, mingo@kernel.org,
 akpm@linux-foundation.org, stable@vger.kernel.org, sashal@kernel.org
Cc: =?UTF-8?B?0JHQtdGC0YXQtdGAINCQ0LvQtdC60YHQsNC90LTRgA==?=
 <a.betkher@rosalinux.ru>, i.gaptrakhmanov@rosalinux.ru
From: Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Subject: Serious regression on 6.1.x-stable caused by "bounds: support
 non-power-of-two CONFIG_NR_CPUS"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello, colleagues.

Commit f2d5dcb48f7ba9e3ff249d58fc1fa963d374e66a "bounds: support non-power-of-two CONFIG_NR_CPUS" (https://github.com/torvalds/linux/commit/f2d5dcb48f7ba9e3ff249d58fc1fa963d374e66a) was backported to 6.1.x-stable (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=428ca0000f0abd5c99354c52a36becf2b815ca21), but causes a serious regression on quite a lot of hardware with AMD GPUs, kernel panics.

It was backported to 6.1.84, 6.1.84 has problems, 6/1/83 does not, the newest 6.1.88 still has this problem.

The problem is described here: https://gitlab.freedesktop.org/drm/amd/-/issues/3347



