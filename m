Return-Path: <stable+bounces-66094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C31794C71C
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 00:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1538B23D84
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 22:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9109115A86D;
	Thu,  8 Aug 2024 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="L9C/5Sev"
X-Original-To: stable@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A884A1E
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723157711; cv=none; b=u/tCozRaOUmJ2p4b/38TyY19eYOY5fOcBAaAy8bBjOXThx3LfnkLmUajPaMIWGaYW9rEGsWA1C8eBYlTE7p9sGXSLFT1lxVHOSH6AIZvXAShQhPwP8TcsLLyPVB2TZMpaVuFYt+ZVsdWzZjES14Vp4riheCeBYhqcP/WVFIinTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723157711; c=relaxed/simple;
	bh=1NKtmq3Nk/R8zp64zJcQjKuN7lYnQdLZJRltWtNgZ9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f2M6Y1KGEzCdJcAWOuK3PZEZ2BHlPkfFGS2vDyKR5+9YHyCB5TK7EU0LMPUFrtdzcL/xi8QmatUq+uEZTPkWHtVrpYa5QLcfu6XlLuRlayzzQn/FfBZ9iwb5j9rrmDmuTGBqpTWywrFhWu4dFvVphgRsXuhny4ll3z3Vquxu8rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=L9C/5Sev; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Wg2SF0NP1zlgT1M;
	Thu,  8 Aug 2024 22:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1723157708; x=1725749709; bh=mfUmrcY/v00ZEmywv2UOcBolceDphli2mMI
	fEUyNP4U=; b=L9C/5Sev/Wtf0mZqO0ZIxfRtNXB0/EuVKJ3cAmpxarT8brREJfq
	SfA8rX1iYPNaYkH/LhR0Vwfww3w+r2KRVt8wPN91SXOox8ycEqXv6r6+nFoO54rq
	6JUCqy6WH8Aw8TehBnV+o+rP81jFXs8ibRvl4jQY9NF3wWk/ilgJvSvU70rb/Q/5
	HPp24RCRBleud5QE0J8U/gk3LVmaQbr5sxB0Q4AzVsNaRpudRauKkfJK8BvNLjCH
	k7zkDQ4TniGZ7uteZ+Z8VKgsQTV1GqpaPtk/4dz7uLrzuXt24YIITcsQCx4IFA4y
	2/wClm3LTiaX3GyMG3rXiYOWWCqUhUZ+5uQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id oxrxkwHhkJ4W; Thu,  8 Aug 2024 22:55:08 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Wg2SC1nNmzlgTGW;
	Thu,  8 Aug 2024 22:55:07 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 6.1 0/2] 
Date: Thu,  8 Aug 2024 15:54:57 -0700
Message-ID: <20240808225459.887764-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Greg,

The mq-deadline 'async_depth' sysfs attribute doesn't behave as intended.=
 This
patch series fixes the implementation of that attribute.

The original patch series is available here:
https://lore.kernel.org/linux-block/20240509170149.7639-1-bvanassche@acm.=
org/

Thanks,

Bart.

Bart Van Assche (2):
  block: Call .limit_depth() after .hctx has been set
  block/mq-deadline: Fix the tag reservation code

 block/blk-mq.c      |  6 +++++-
 block/mq-deadline.c | 20 +++++++++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)


