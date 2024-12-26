Return-Path: <stable+bounces-106109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B7D9FC750
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 02:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A140161BFC
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 01:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A115B8F49;
	Thu, 26 Dec 2024 01:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIh3FfxR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DFF4C9F
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 01:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735176100; cv=none; b=WQX/xC6JLLZ1oIP3rmjg7g4FrwwAnWUyKtcCq8wKBJTgWD04YzjtbtVhiq7lztIKAQ42m2mJwMV/xkJjGsiXUpkC73GmqSIDPXL6MfZYf91WvUhl5NQxAD2QpalAz3ChNLdE9X5iCF54oDP4TNj9pUED+PT2PX4DcQYs3TJtUtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735176100; c=relaxed/simple;
	bh=FXdjjuudruN1Hj6cOZaglinLceszTRshd0a6/rvCYZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GI1f2j/M5BMLhtTAwIMWrJlIzp/l0FTMN/Ota/YUSATebwT2MCkf9XkWEK2b2xkM+VxaG4pmCEVqUDgpxjHz+omnsGW4cD3Lx1tOs3rVSxUjtO/EpyXsxMEtZpR91OtINx8IGNDa5+OPd+OX/5bcAgdVjkfC2/Oq9pAXP61SInE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIh3FfxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B98EC4CECD;
	Thu, 26 Dec 2024 01:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735176099;
	bh=FXdjjuudruN1Hj6cOZaglinLceszTRshd0a6/rvCYZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kIh3FfxR+h63HdJgdbhj9naM/qYJBYbLp5glVZZRED590IZwZtbOnpZejtxabzEJI
	 zeMfkNAcj+ntD4Kdez4aIMtg2Wfh2RmTf5QkHEWlW3uTiY4hBwffsCqJ37wX8PXANc
	 ixjJPif3Ye1de6iUtshdkM53QAmY6Ui6cPFplKC/or52/dsrlO8FnJ52ab6oo7T7hS
	 wJ7SUZt4oAwixtS3bN+GX55BlMtewqSWLfeHgqL9WA0uZ7lNFqIInAluSqfRMNuzPZ
	 Obcepv9wcS29+GDmdfCpVLDaGfXcIo1i/5An+tSb7jy6bCy0cbzyvpnb8a/9N4+yBE
	 oVVaEmLsK3SMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: trondmy@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 2/2] NFSv4.0: Fix a use-after-free problem in the asynchronous open()
Date: Wed, 25 Dec 2024 20:21:38 -0500
Message-Id: <20241225190141-f5a244c27f8b16d2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <e82e8f89d5449c947c7e81e2bfe9c7c4a980c0d8.1731103952.git.trond.myklebust@hammerspace.com>
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

Found matching upstream commit: 2fdb05dc0931250574f0cb0ebeb5ed8e20f4a889

WARNING: Author mismatch between patch and found commit:
Backport author: trondmy@kernel.org
Commit author: Trond Myklebust <trond.myklebust@hammerspace.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: b56ae8e71555)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

