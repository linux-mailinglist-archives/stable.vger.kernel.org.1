Return-Path: <stable+bounces-100024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B49979E7DF7
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 03:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5ED16C67D
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 02:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0043FF1;
	Sat,  7 Dec 2024 02:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZxjtnBE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774DB1BC2A
	for <stable@vger.kernel.org>; Sat,  7 Dec 2024 02:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733537233; cv=none; b=B5Xjzn0IsfPeWi9WgQ0k49HpEoQU1F41gNKpEh+rj3s3vzn4022g8R+CxOu8MNGl2TAHVG7krMXrRFZMTnbWO2GOAKBK9g81n3EtBIgazkna/lQn8QOksLn2qwiw67nKarE7oGR4ljHvY+kAN7IqP2tX5rGc2FaEaeMZiGN0wcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733537233; c=relaxed/simple;
	bh=+Gs5NdMqcFKr+QKK31hlb15BL0zzvSj2CsFGwZ9SmyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJszKlv+JtOQWvIeMFhfhttCB7wUv8L4lmOEwaG+S/s8Du/n1KwcfDW5p/fgwPKZ0s8GE2qZbCH5nMj5+u0tSTWAsOSeSw1io0EA6a2r4o3LgFxgklCbR2BAkNV/HnDyGLx4OceEaqj2bG/6e/ekCBiDiCxOa89n/T9KC9WP1M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZxjtnBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC9AC4CED1;
	Sat,  7 Dec 2024 02:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733537233;
	bh=+Gs5NdMqcFKr+QKK31hlb15BL0zzvSj2CsFGwZ9SmyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oZxjtnBEiE77ugvAc/e+3vhK2um9/tGdBJHf6QWJhpgIfUj1O+6SdgqsfsN89HV2z
	 jAtbBabu/IEOCsfY3LsyQP3FJ7d8ww7jJ3n8B/sjzXOXRNoixCIdHF9iFLHSgXumax
	 rYK8VKpS83TFnw4fjvrHAwSH5Se4CDIyrfjIpyBn9blmcjbGsMftVCP+1baVWdXwFZ
	 fcEFmf8A5gBP87FQmJvuwcvIh/yBCCyV4p13zHT2IglS18jpNTCs8LQVpHrU8JelD2
	 jhlUhpXblV8C6Ypf++lsmdysqjBgQH0B3SmG7SZ3220zu8zW9Cm4QeSacj/PDFHSyo
	 kMx8vWZgiOAiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] powerpc/vdso: Drop -mstack-protector-guard flags in 32-bit files with clang
Date: Fri,  6 Dec 2024 21:07:11 -0500
Message-ID: <20241206192201-fec95722ddc9f98f@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206221005.2313691-1-nathan@kernel.org>
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

The upstream commit SHA1 provided is correct: d677ce521334d8f1f327cafc8b1b7854b0833158


Status in newer kernel trees:
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  d677ce521334d < -:  ------------- powerpc/vdso: Drop -mstack-protector-guard flags in 32-bit files with clang
-:  ------------- > 1:  c84848a9a621d powerpc/vdso: Drop -mstack-protector-guard flags in 32-bit files with clang
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

