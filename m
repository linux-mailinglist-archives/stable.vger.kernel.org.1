Return-Path: <stable+bounces-152423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60151AD56BB
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 15:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25AAF177FDF
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 13:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B839A2882A3;
	Wed, 11 Jun 2025 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1e6B2yW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78858283CA3
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647763; cv=none; b=Hy3ofwzwANf2VbYLr5jrt3+SZVRVCc3OB6W+xeDe3XoKW2uid33VC5elnRD1uO0wp2ce+nHXXc2u2SztDrUgKyi5qwa2ufLKcBmI+aKI29wrhxR4o+I6VOWrtMvY8aVbAwyeirD9pMOAIEwPqp4vKn9ohDbQUn5dIllHJ7O/Sfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647763; c=relaxed/simple;
	bh=kPYYB7+DHBf6+9zvVFIE5ZG2cTBOhY5mwIGlpCEnmMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BuP28CgwdXBluvOpDdsak0LrQSd5lhw2+TKRaBx+90c1PXCXEIXqDrTtw57tgOQ1+iTX11Weh+0NH9ZTE0t0p6992XQozZPxKzASqdV/RJaKcWspfDwGOzI4+NIzHaDrlKwNoKoxBf+xYWGvv/FFxKgg/FCKzxv/MOQCujGA2JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1e6B2yW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8464BC4CEEE;
	Wed, 11 Jun 2025 13:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749647763;
	bh=kPYYB7+DHBf6+9zvVFIE5ZG2cTBOhY5mwIGlpCEnmMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r1e6B2yW0jz+M44kFK24vX7hGPHdct/JLTvq1ji0206KjnGmmUQSuCyhSUD+MHv1f
	 d7AHPuSoNm8O2QqikC8ogsXK5vxxSB9pJg6ZNXu+KnbXm9ajT3YX2fdKuoDMPCiJSo
	 dCU6rVWr9CCUa61cHqzJPEaRenOsF33M7SUc9DEewTbzT38Pi6Nu6hmTGBd6dWnc+D
	 Txn8bhkN9mjOHtb2tDlF1yfO9PvTe14Bu+f32Hwl+0kzX03F4C4FqbZMfBX5rOkhWd
	 CIyo8jU0rDUZhw1kCcGuV61dxTsxgaJeBZJSuzcwBG8h47WADSQmuPr4DCTyBrKkIM
	 QgGJozxrH3Gxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kernel@jfarr.cc
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/1] Compiler Attributes: disable __counted_by for clang < 19.1.3
Date: Wed, 11 Jun 2025 09:16:01 -0400
Message-Id: <20250610163544-efd1151d43dd472a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241029140036.577804-2-kernel@jfarr.cc>
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

Found matching upstream commit: f06e108a3dc53c0f5234d18de0bd224753db5019

Note: The patch differs from the upstream commit:
---
1:  f06e108a3dc53 < -:  ------------- Compiler Attributes: disable __counted_by for clang < 19.1.3
-:  ------------- > 1:  fc85704c3dae5 Linux 6.15.2
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

