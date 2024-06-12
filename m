Return-Path: <stable+bounces-50335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA93905CFD
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 22:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92741F215F2
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 20:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B0584DFC;
	Wed, 12 Jun 2024 20:42:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from iodev.co.uk (iodev.co.uk [46.30.189.100])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DED984D39;
	Wed, 12 Jun 2024 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.189.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718224965; cv=none; b=mTqXtBywr3U0l2BEJ7As1CSCkiwC1gqQ4eRnrV5r/z1GWwrO6FLP9Vq2Fu1+vEN2xBYhqNXbh9viq6fx6my8L/EkgO9nIcQfYCqJN1/8j4tIiN9O9UJ2jC88gIEMtDC1NpZInLfpjTlJdDvG3xDI7fj8fCnHqRYgBHW8kYpHLsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718224965; c=relaxed/simple;
	bh=+qyqE9vjz/LOYQtCfw+SBzbNmcA8piPkgSyHmAla2O0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qq1qV6SoW+LQb5Zok3uwyGSzYiR5FM2QDAz5377/B6+lSK8Dq92XLZ2nKg3T37AuCVJ2Xn/HWqyeohbgjDFShWC/zqoObtQMerdKauBizVsqyllGFtvI+tm2vgaNsfeXxIT0NP8dLbnmvpWbQ5AmH/gQIwOrzSRsbf3fML1rkfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iodev.co.uk; spf=pass smtp.mailfrom=iodev.co.uk; arc=none smtp.client-ip=46.30.189.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iodev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iodev.co.uk
Received: from pirotess (222.red-83-46-228.dynamicip.rima-tde.net [83.46.228.222])
	by iodev.co.uk (Postfix) with ESMTPSA id 91AB12F8341;
	Wed, 12 Jun 2024 22:33:20 +0200 (CEST)
Date: Wed, 12 Jun 2024 22:33:19 +0200
From: Ismael Luceno <ismael@iodev.co.uk>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Intel e1000e driver bug on stable (6.9.x)
Message-ID: <ZmfcJsyCB6M3wr84@pirotess>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I noticed that the NIC started to fail on a couple of notebooks [0]
[1] after upgrading to 6.9.1.

I tracked down the problem to commit 861e8086029e ("e1000e: move force
SMBUS from enable ulp function to avoid PHY loss issue", 2024-03-03),
included in all 6.9.x releases.

The fix is in commit bfd546a552e1 ("e1000e: move force SMBUS near
the end of enable_ulp function", 2024-05-28) from mainline.

The NIC fails right after boot on both systems I tried; I mention
because the description is a bit unclear about that on the fix, maybe
other systems are affected differently.

Best regards.


[0] HP ZBook 17 Gen 1 (D5D93AV) [8086:153a (rev 04)]
[1] Lenovo Thinkpad P15 Gen 1 [8086:0d4c]

