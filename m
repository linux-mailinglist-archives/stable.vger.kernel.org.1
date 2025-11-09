Return-Path: <stable+bounces-192843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A380C44014
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 15:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9FA90347084
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 14:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A702FD7B4;
	Sun,  9 Nov 2025 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b="8TlNj8hJ"
X-Original-To: stable@vger.kernel.org
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E08257841
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.190.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762698001; cv=none; b=bnMmmjdsSIQn5gDoZK634LzbWVHVNDYMyPxAKulgxiFd4Xp6E/I1KGUClgdrs8MjSTWDgBIaZw5TZrGYhny56e40SYrY9pfav+uOex1PW/3pm5CR9QIOslNaoPSnr7RzT0ncL+h1Wnrx4DiYcm1HijCbNnVTtxVtyOpP5wtoSoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762698001; c=relaxed/simple;
	bh=Z4qJ4Nr3IOg2Tme6jG15gS/KcCkZrvPfxEsi/nBCNK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWKYwsGuL/WSikFTSTpScNFh9lL6c2UxWb8/TTVLkvIkGD0+le3nfUxTyj+oENuYnPk7Ga0sAs+QOWusz2ixxpwczIBCOPU+dix2U6aRUQaIXa9CU8o3ZPbiQV2uN5T1JkwT5a+Uke0uvRsrrdx9AmcMC41bw6dZM0xX/MCd4AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net; spf=pass smtp.mailfrom=hardfalcon.net; dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b=8TlNj8hJ; arc=none smtp.client-ip=213.190.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1762697995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4qJ4Nr3IOg2Tme6jG15gS/KcCkZrvPfxEsi/nBCNK0=;
	b=8TlNj8hJajbJfJsYjq4wu5MZ81sHzBsPNx5V8TSIyzW2ltDAYEiYIjzwIwRHvKTvo6ErOw
	xq2tFT/PyCLnmlCg==
Message-ID: <1bcd54c7-9a0d-4c91-bc66-8e049bae3154@hardfalcon.net>
Date: Sun, 9 Nov 2025 15:19:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Patch "clocksource/drivers/timer-rtl-otto: Work around dying
 timers" has been added to the 6.17-stab
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Markus Stockhausen <markus.stockhausen@gmx.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20251104131736.99355-1-sashalkernel!org>
 <475307d0-75ac-422e-b268-a88b827986f2@hardfalcon.net> <aRCcwYm9hs6mkbDI@laps>
Content-Language: en-US, de-DE, en-US-large
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <aRCcwYm9hs6mkbDI@laps>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[2025-11-09 14:53] Sasha Levin:
> Do we actually need the other two patches? They don't look like fixes.


Oh, my bad, you're correct. Sorry for the noise.

Regards
Pascal

