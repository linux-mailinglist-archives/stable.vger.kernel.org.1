Return-Path: <stable+bounces-110231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AD3A199E5
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 21:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2531888CEB
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 20:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B20D1C5490;
	Wed, 22 Jan 2025 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Jcc/Bh5d"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386A61AF0BB;
	Wed, 22 Jan 2025 20:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737577877; cv=none; b=AFuA1vuSOta0tq2vZrt22jAyPhNNbBgdPQmpdfG25bHgbUIc/rxDcXbFQMaJX6pCWiypSsGITZiPsWxJz2SD/j4y5o832QigobsvWyXVd68328R1MKz5zK5KHCxAbJ602Opl/sIPTH1DtEGva+tbWV1cb3Jjoglai1OW/xak2NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737577877; c=relaxed/simple;
	bh=mI3yXRuGMMLMi18QfC6wfscal5XGUfnAEan6uq7CUMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=E2eGondDFugoUBIblfR8t3UcTFMYIX+BFtpRTalZAErrj4NXf2lNwY7oNqzC8OpkEkTNtVk3Dx+Nu/tv6LEKomFUk1Rkc2E78t9dO9h7y50BPNnW6tYWk6y0Djr/jT4F6Vnz285vqHQZv6dONmPz8KYLvnqfNsn8npJ4OHZ1v9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Jcc/Bh5d; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id C10922046089; Wed, 22 Jan 2025 12:31:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C10922046089
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737577875;
	bh=mI3yXRuGMMLMi18QfC6wfscal5XGUfnAEan6uq7CUMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jcc/Bh5d25SGG+SvK4iB5/i//J6zHpRYzVRnaAxB3M7DzM/VU1k61Ob70kyTpDQHt
	 w5HGNpaW4bP30lYmtnnYmr9kaWYMoWHbOHP40TAutP4Iw+BLL+NoOaIjp5kjWArZup
	 gCvkyv3NpH80xeezGPeZZX4KOKAKo1KBYTfBhyY0=
From: Hardik Garg <hargar@linux.microsoft.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	srw@sladewatkins.net,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 6.12] 6.12.11-rc2 review
Date: Wed, 22 Jan 2025 12:31:15 -0800
Message-Id: <1737577875-20029-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250122093007.141759421@linuxfoundation.org>
References: <20250122093007.141759421@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel builds fine for v6.12.11-rc2 on x86 and arm64 Azure VM.

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

