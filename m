Return-Path: <stable+bounces-119530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB07A4459F
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 17:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C7816E38C
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 16:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BE918DB38;
	Tue, 25 Feb 2025 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TP4IVE/B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637CD18DB09
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500023; cv=none; b=AajpYEYmH4gjCU/OwIZrQjCcrU3XqvXMhWELqANrAwm8449mAapQ/E5XDIeXQZvFouRnoE/EeYd5eeXxWwwjevyVRTEfIlA91z+49ehPBBynEc5663Dbu8ux286HfPI+x5OnKWSAs4nmGAcQbGwpjU+caYnUhE9plBuTnPRccYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500023; c=relaxed/simple;
	bh=Qah4rOgkb/Czz2CHa130TTOWACWSyBAd1gtnXOTXgW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFmIdaPM0m2Odz+KB9FOidGSo4/892knwZOztnwH3WmuSBuYmdpK+1VWcqF8ELyxzcUdKjWI5nElyz50aAnStW6JzhfVTXz2njKVbvwKIA0eT55V7xqzu9KTtUeNHjXaHEu26nCqBm8KUiXPKf++Qn+Io8j/VVk7bDyQmgSyRHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TP4IVE/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954FBC4CEDD;
	Tue, 25 Feb 2025 16:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740500022;
	bh=Qah4rOgkb/Czz2CHa130TTOWACWSyBAd1gtnXOTXgW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TP4IVE/BBr7YuTTmH4mi3GmxBr9gVhbR7EMLhCLnhx+5/C1exS4AFmaTcCUHzCKIj
	 nK1cDOeHp8UxVtdsx3YcVEWNhq8q+mA/gR2Lctr7ptw8mBMuVurLhCoGFBjBcRJv+2
	 tv/E/EzTgwrDWekRcx5HJk1JYmcVTrt/lSyeFEDYWBbT2+MtcQLSW1a91oMQuhc+3g
	 Zm0eDZvl8EHn5BkdnJA3/g7csk1Yd66h/y+V4s3InxaWq/PmIXFZDotE+1sP1ivkTz
	 LwgfjjgMBAHLXi0XV25jhtJVU/xWuWO6IGam4GXnN2zbb7Gw+qgJaDRTcDmtjN1yg1
	 9SFLQbshxAHOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	foss+kernel@0leil.net
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] arm64: dts: rockchip: Disable DMA for uart5 on px30-ringneck
Date: Tue, 25 Feb 2025 11:13:41 -0500
Message-Id: <20250225082806-83877f26f40284c7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250225114329.885043-1-foss+kernel@0leil.net>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 5ae4dca718eacd0a56173a687a3736eb7e627c77

WARNING: Author mismatch between patch and found commit:
Backport author: Quentin Schulz<foss+kernel@0leil.net>
Commit author: Lukasz Czechowski<lukasz.czechowski@thaumatec.com>

Note: The patch differs from the upstream commit:
---
1:  5ae4dca718eac < -:  ------------- arm64: dts: rockchip: Disable DMA for uart5 on px30-ringneck
-:  ------------- > 1:  1efc320b58df2 arm64: dts: rockchip: Disable DMA for uart5 on px30-ringneck
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

