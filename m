Return-Path: <stable+bounces-98587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8938A9E48B8
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C5D1880674
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E80C1B0F0E;
	Wed,  4 Dec 2024 23:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TE1ayGku"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9AC1AE876
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354603; cv=none; b=KCKHeLfSepn7lTbuYgbl5VJE/xB0RTJIYGpPxSyX8uucXy1FF5iNxFWcA8sOg6CfCVEBWG2ZmPGcGXparFXDjH9wXSlliJpbkA3jPH1OyZUpXnKqZEw2/vAX9hYu7gnAZBwAKULIF880HyN5S8BWcb48ofhrk/5DLl0ry+CGsBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354603; c=relaxed/simple;
	bh=URk10dDtj4ycoyhOPmzMsReyUOCJeMnpT1nzTOYY0Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wm8eF7+TTZjl/E9jI9EorgCSwPJSvrJfQL99jsWBUTf/2fAkhkUQLjXvy8msNaV+oXs6KN8/waWW32xffaXRebST2nMk4lwfuUt/SXJPybtNd9UoMUQ+d4jpvjyd2tf75QAujIl8GCRO1v8v5YOicO8gLtd31msPprI78+AQHLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TE1ayGku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFCCC4CECD;
	Wed,  4 Dec 2024 23:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354603;
	bh=URk10dDtj4ycoyhOPmzMsReyUOCJeMnpT1nzTOYY0Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TE1ayGkuynKYTun7HJAeBSoNzNqtjAvnVOMXyyXR/qhvJIO2iWiNBScM+uTFoRKsJ
	 HUOwFri41QCkVjSCM5ZuwvgXg5fpllwybqgeDEn9RI7kj2UmfppLsyFWHJWRfDNex+
	 AWd213aacO8apWRxnpF71xouyE6D56rhwks7wsDz5aWCe0eR3j1N5LKHosUvXSieLB
	 MpSgeaA/MBqhhDUmVU1keoSc751A12WppgSZAJjkyZ6jvV2tfj4DzkCjYgKVa9Sg0C
	 e1BGh2V4jpTk0LuKUNYyyZUCmCBaXEtm9JUi9wCxEQ/yDEmCxJtLhi3NDAALHWCSDm
	 VETLW7tg2UuUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Zekun <zhangzekun11@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] Revert "drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()"
Date: Wed,  4 Dec 2024 17:12:03 -0500
Message-ID: <20241204072048-d1ee98d4a22f7b45@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204082752.18498-1-zhangzekun11@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

