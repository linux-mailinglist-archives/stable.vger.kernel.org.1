Return-Path: <stable+bounces-96045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE819E04D8
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B8F28518C
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC765205ABD;
	Mon,  2 Dec 2024 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzdooxGl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0F7205ABB
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149596; cv=none; b=E0HxQhI5kkoeh3R4mBWR5PqfdmjlIqKmk34VMLuaopt0Pm1KhhKSVVwNP1gBsecadREPSTqTm2h9s9ygrmOUNNAeQ7Jp6/gBHFTYbUHBs56VCZ8D3FaXnc5W2p1nZzYZUwhBTrK9bUs+Io+gr94uh1HmeAfaKdfG2VyjXvndItw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149596; c=relaxed/simple;
	bh=pLFUvCITrAcBE2oP9HYMztYikvDmILw6WU4eA/B5li8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzdqUqICrrZ7NwoYBQ6B9PUI3Hl1FuMKCa9Cy5trh8NYwRCewXjF5jzYEIY/eSs/Uzcv18dka5/X24NMVwhDJSBIcK+a1WC/EOmQ1WvsNv4RAzu6wyHst2RyxGnKEmu8OBUGgOkJtQ6esvxOx+vabXsOWaSs6Olg02GscKuBBjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzdooxGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EDFC4CED1;
	Mon,  2 Dec 2024 14:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149596;
	bh=pLFUvCITrAcBE2oP9HYMztYikvDmILw6WU4eA/B5li8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jzdooxGlr/ftBXc9c8hRYo1mxtl3ilU4cvzXvt8aiJHj4HhRNNDQkmn1tR73UVOtm
	 x86GjM7bifhrt5+nUEv+jYTxh6MZ8+A8APeN7j3/NTov28lwUNuBjyuDBEVrMVH7em
	 i0nuXzob6HqNjpl0Jigy7yiaot1ZJZIIwQRX8XPrA8PLr3XnyUmAqF1RsEpyubeX7f
	 LVkVj2aDcq8/tLaMSYvwl6uq8+ZMdTz59FtfmIh5g/mm2T5yitVeiWffzNVClBSAol
	 TNQMoOKLoYRgw296JevWIjvcj9uFxRhsMP+EVOnTicgLwoZYayLC2XwCiFwef4mFEc
	 iufJZuhweAL5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 2/3] net: fec: refactor PPS channel configuration
Date: Mon,  2 Dec 2024 09:26:34 -0500
Message-ID: <20241202082846-825aedbeedafd6fa@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202105644.3453676-3-csokas.bence@prolan.hu>
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
6.11.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bf8ca67e21671 = 1:  7e3e5ef779eec net: fec: refactor PPS channel configuration
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |

