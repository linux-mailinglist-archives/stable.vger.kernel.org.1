Return-Path: <stable+bounces-61327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A1B93B920
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 00:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268091F2300A
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 22:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534A213C9C7;
	Wed, 24 Jul 2024 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Eivfab7h"
X-Original-To: stable@vger.kernel.org
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7D013C8F3
	for <stable@vger.kernel.org>; Wed, 24 Jul 2024 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721859879; cv=none; b=oegjdK6oMWDKAI1CkKe3KBuPCP4Pd5ngnZAXxuYtIuezCvaNwEAFhAciUudJ/Qf9Ic3mIy9O/9WPO5xbF3JZLcAfe4h0yhWgOoBq9+/Tz80QIlrVKJ3jP/LJttqS7xls7mbCh+5nmf5LzH5MAu5FLTvGo8Jv4Sbo48n255/nCcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721859879; c=relaxed/simple;
	bh=FOX3CF69PyQxiCr877/OkmnO+5fy6DMx7+bI5kwdjKU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=m+KaWzQwTzYti/DRkJwjX1EravcFCv/PmcxebZMHkbm5zN9yweE0RR3v+fTuPy/wIrMRUpbiiKRAG9DjF0LwrN7JnSVoQxBYIjKjfXpgTTJFNw9V2z0zvFpYNfKU6K2aNSl3Uw8hK1HsAE5eNkCrrtNBiPPAdZwJLqP/cY2FW9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Eivfab7h; arc=none smtp.client-ip=185.70.40.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721859875; x=1722119075;
	bh=FOX3CF69PyQxiCr877/OkmnO+5fy6DMx7+bI5kwdjKU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Eivfab7hqgtkUXTNdb2EXVzsbeQvmvLqpGi+fq3NDaImsy9l8CnY1+stYNO/1x7l1
	 WUedn1jJ1OiWwcU+9Ldn//ULgGBmi439IwDnMxaixyBHJhDBDBa+s+0emS6sAfdh78
	 jzhlcaHiGS+j4POtjtnFIaR0vbSOAEltSt/uxEDpsp6ZWbCOzFLifoaLj5BEgXJ4Lg
	 3fRiH9YTgv53PnKPTMa5PBz0D5XQweBT5yi3iX5h2DjNvUq4RqKJVwR9kkqEx0Vp5s
	 Ypgq4p4gt+wlaSVkwfiYopsofbfu7Q1FnP8Gl02AGI4kb4wsRT5bxA6I30Ohl6ZuYU
	 0/uq/BSOadugw==
Date: Wed, 24 Jul 2024 22:24:29 +0000
To: alsa-devel@alsa-project.org, stable@vger.kernel.org
From: "edmund.raile" <edmund.raile@proton.me>
Cc: regressions@lists.linux.dev, o-takashi@sakamocchi.jp, tiwai@suse.de, gustavoars@kernel.org, clemens@ladisch.de, linux-sound@vger.kernel.org
Subject: [REGRESSION] ALSA: firewire-lib: heavy digital distortion with Fireface 800
Message-ID: <rrufondjeynlkx2lniot26ablsltnynfaq2gnqvbiso7ds32il@qk4r6xps7jh2>
Feedback-ID: 45198251:user:proton
X-Pm-Message-ID: e4a59c6ab075e46504783ff58826a51143fc3be1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bisection revealed that the bitcrushing distortion with RME FireFace 800
was caused by 1d717123bb1a7555
("ALSA: firewire-lib: Avoid -Wflex-array-member-not-at-end warning").

Reverting this commit yields restoration of clear audio output.
I will send in a patch reverting this commit for now, soonTM.

#regzbot introduced: 1d717123bb1a7555


