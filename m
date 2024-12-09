Return-Path: <stable+bounces-100207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A680A9E990A
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F71A1887C9E
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDD91B042A;
	Mon,  9 Dec 2024 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKe1+X+l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508771B4230
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754940; cv=none; b=C7/1N4QspEjfGS0dx+b3Bcq7YxjwvV81eFHPbG0hsjO188+L3y4urEsM4IvqICgmzF9xIW2DdwE1FApNmtGczM2IpwNQTsm8J/VsLivRPe9t1/50B2fuQk+uA96ccAZdz9Ez34pQA5qmokgfxVpq4rjGEFAudP1TWe/NRaKsLfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754940; c=relaxed/simple;
	bh=h6dFHAQ9pIGTX3gtlMz8Z1bNcWkqPqx+W103Kk9XMWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+S4BOc9tuA20N51t1YQ9SFrE6eazU973NDAmozL9WkftbxVU77HDA1RtjEGG49iYzDpDTmN1Ka2NgG2WHMvEwsN1OXPgGKDitelfguCXy1mU1FNiIvP9VlvGwNf2GPt+2k4QHyRe6HUN88EtnrpjmVwh3baODKfqDzcHfqhokw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKe1+X+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C489C4CED1;
	Mon,  9 Dec 2024 14:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754938;
	bh=h6dFHAQ9pIGTX3gtlMz8Z1bNcWkqPqx+W103Kk9XMWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AKe1+X+l/dkkUDnWWI+Y/oMMbnVAht3nxtBVrMLXoCVdI30peRIgiPeWmjasLSRJV
	 bPFogEf0eTCGTO3apNTB1b+KwpFuteI6C7GI+eBpFNX5bENp1/8/UxBobjjFsKBJsO
	 TvORIgTb6rZvANxruFFEkKwP+Zpz32VB3N0RWyW5JJvgHBuBg/2Y34partRYWMRGqY
	 IC7vLSzc59iUY+VvZz9DcDfzaq72lEn1XQLzL8xsndGnvdc0387kCKY/ye8f/YAZa+
	 NFyADzLlkZ1Z6ClDLVhlbO/LPkltlmw1r5x/FUxjFelwAvqVJs2UutYAz661AlC9Wm
	 J8vmyhrDufYvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy-ld Lu <andy-ld.lu@mediatek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] mmc: mtk-sd: Fix MMC_CAP2_CRYPTO flag setting
Date: Mon,  9 Dec 2024 09:35:37 -0500
Message-ID: <20241208093511-fd8981455f4e690f@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241208090347.22418-1-andy-ld.lu@mediatek.com>
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

Found matching upstream commit: 2508925fb346661bad9f50b497d7ac7d0b6085d0


Status in newer kernel trees:
6.12.y | Present (different SHA1: 6b751bd44d86)
6.6.y | Present (different SHA1: 8a68eb7a528c)

Note: The patch differs from the upstream commit:
---
1:  2508925fb3466 < -:  ------------- mmc: mtk-sd: Fix MMC_CAP2_CRYPTO flag setting
-:  ------------- > 1:  0b11ccaf21e40 mmc: mtk-sd: Fix MMC_CAP2_CRYPTO flag setting
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

