Return-Path: <stable+bounces-96049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A39A49E04DA
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E3328534C
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13AB205E00;
	Mon,  2 Dec 2024 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9rCzdIR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E592205AD9
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149604; cv=none; b=SI59e9nnMYfLG5kEQn0i+r60oB9gEx4eXftA+KrRsMv9ISws9bv1noQ2UobY5unl5TeEgohe0oi7VDxi5O6YYT3FkNfzXBL/kHltp4WIbZI2HpNXLrAwA6yr9FPUcKvtMvvQ2crcDDuH1/4DV/SdK9KwiACiP8RRissmom4/joE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149604; c=relaxed/simple;
	bh=H3fFuFLBUHeDE2YmR1DIfAD2Yr4bq9+qxEE2MQjBIog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyJLtgscl3gRXMk/kIxHMFU43A5IDqslFw6jJMRJKo2vQn+NLJKWKNpQxtbaSjcMVPfvKkThf34jPO6REVCWQkSsIrY7kozG7o4+e5Q9CBA/7RZfBv1DSiGO1gz5rvJX2DNHq/4xZhvx5CKTUDfJC9W+jTPWx+HRMrwOV5Su4m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9rCzdIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF60C4CED1;
	Mon,  2 Dec 2024 14:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149604;
	bh=H3fFuFLBUHeDE2YmR1DIfAD2Yr4bq9+qxEE2MQjBIog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9rCzdIRwjXXzJIjVjfhKIDKpCCWXHs55IGiszaz/7LevIVL0JvvkNpN3kmUogJ8f
	 LBT7t6Xw9XFQKRpt0nCjwDoJwVTYQ6sFVzSMxW1xlQncvtOuCHS7R9jYO+x8HzxN5d
	 O4hWpYZvWkyRuyqJauyZuZXvHp47/8rlgtpAtlaVAkD4XeFOpZ8ehipNyTPH6cbBtU
	 He3/bv5ZTzoiL4JG07DR8qtJKWkKlGBgykTyj5S0g+Tnmzdc8/X4CzFnAq5KwUjxU2
	 MkR4uhyB/MbC0IJEzVlE2uuo76HZenlVEHaR8P5XusZkgq+rhBPkbWvIM+LaXOVz1j
	 o6WOrZv1wci2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 2/3] net: fec: refactor PPS channel configuration
Date: Mon,  2 Dec 2024 09:26:42 -0500
Message-ID: <20241202080125-02c54ca2e86ff1c8@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202110000.3454508-3-csokas.bence@prolan.hu>
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

Found matching upstream commit: bf8ca67e21671e7a56e31da45360480b28f185f1

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bf8ca67e21671 = 1:  c14e2a4824ead net: fec: refactor PPS channel configuration
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

