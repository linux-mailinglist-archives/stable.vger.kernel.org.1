Return-Path: <stable+bounces-165552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6410DB1649E
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778113BEFD1
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2F12D838B;
	Wed, 30 Jul 2025 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO5cqo/U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC421DFD96
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892940; cv=none; b=qzwYs+6LfJodcTKBEScrcF8iISe989ahgA97kSXjAvqG6zkVyeuRKoP+2+XXOHC7+Fq6hZVJ6S2lMXZDagTBtkfmbLU1ljNm577P1tGPD/ZHfHUE2e+q0uaRdek6WKL2WPaH3cxIx+CRwoT0A6gIXwrLF6s7suqQ7+5UCE/XoTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892940; c=relaxed/simple;
	bh=+Qbu5Dt+ARZGiKyba/banPote71Eaf0NYm6ef6WVzgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrkshGQEQp0SDKcy7l+oZDkIRcySQGLhUjT81BGgjhY+cDyXm+JNXMKAeae5qQixTNHTLjy66a9PCjxrbgXjcrnjMd+sr/OrEKNecsmBRVDW03po3Ucd0EU4p1C+PeYddMwzW6ViEOiw+e/5Nxbnmk4/CT9S7c9TPkqFB+rsMSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO5cqo/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30289C4CEE7;
	Wed, 30 Jul 2025 16:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892939;
	bh=+Qbu5Dt+ARZGiKyba/banPote71Eaf0NYm6ef6WVzgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iO5cqo/UkQ00mVR5/c6qhw2jvjW4Adm8m3UVFWDps7orojrA4ZaLaUXmtzhjvWMEn
	 4WHOGRXWmzdAAy+Edj2Y1QyJ6GxtuKv0A1rVNUJvCfU1xCZH5Xymbofbl+wgghLotL
	 uIOSt/5ugyPpPaeRnTIH/Lt/6ezx6GT64qDQx+wwEdxKkpMfCT4abN2LDJhVcDvUn7
	 cWe9/cHZKtUrTyEc8z2NgA8U+45GyFuwp5FqCFsouSr5/QnPqE2pdlfi+N9fgCgdGv
	 b0EJnZmQkt2aV298CxLXsb66yib6TS4Wtvpdh+li3Z2aD6w49EXqtjme2hNPfe04s/
	 pizku27LlDP4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	matttbe@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 2/3] selftests: mptcp: connect: also cover alt modes
Date: Wed, 30 Jul 2025 12:28:57 -0400
Message-Id: <1753887608-2e6325ec@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730102806.1405622-7-matttbe@kernel.org>
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
ℹ️ This is part 2/3 of a series
⚠️ Could not find matching upstream commit

The claimed upstream commit SHA1 (37848a456fc38c191aedfe41f662cc24db8c23d9) was not found.

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.15                      | Success     | Success    |

