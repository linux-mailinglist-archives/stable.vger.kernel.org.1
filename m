Return-Path: <stable+bounces-114316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EB5A2D0ED
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778BF16D617
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2EA1C5F1D;
	Fri,  7 Feb 2025 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oy23Dn8k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21CD1AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968641; cv=none; b=jUTmlOoiwjien5HYTbZX72dCb1RW6emxasoew3Tl8sIpHlU6A255t92YtZ7wAndNSlIZELEhS3lvC5wlF24T1OM5Q00RR0a1YRVr8P9ULkDHOSnDX4TKc/x8pHjgHjqm9ZhHK+U6hMl8ZaT1fSaCIAuSLFYG60YBmHE8gfUl0cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968641; c=relaxed/simple;
	bh=8bcm6xjnyR48SYgnwYBoJ6X2KBJPL5PChtBu0YsJkaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CZ4XgrXOkojhUzhQg8ct22y3fZ2YPAfjEQqDPmZBjcGD+Szl7HxD5p1z9gfcVybos1U9WEb2swe/vy16ffQb+Qra8DWUpczBDOBrMy/ZzfscTCugVcDobk/+7e/sMlHcY//lVVeUEXbTYeHwgVfwoMq0OAIPYNc6u6Fq/++HEFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oy23Dn8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10014C4CED1;
	Fri,  7 Feb 2025 22:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968640;
	bh=8bcm6xjnyR48SYgnwYBoJ6X2KBJPL5PChtBu0YsJkaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oy23Dn8kD1cHyVRQ64YKAU73MkJlA67QyMlfL4xoP/QZ1YFrb/MfWz53DWYcUp1xF
	 EMPkBjvBVNcp2nAXA68Y4mMZ4VPv8cdAGoFeSVSQeBX0zmmk+8O+jTPaIft86Y6PrY
	 Naf5EZMb1xOHW5U/viChLL8FsloEUYoiquxaS/Hqy2eKt9Vf6NKx3mSNKg4WUnD09t
	 jnOqazIB8XYGd6WB5V1VXnwaGIp+hwVaF3SqfTqVbC/5uqiWy+T0Xm0Ibv0Ki9jlAm
	 CGo/n+fy26v5bZYS0feSwcUba0WcWeHpED+VW7Q30CU8YEhwOO3IiopTwjEtyTFXQo
	 MAXhUlPtXeSow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 01/11] xfs: avoid nested calls to __xfs_trans_commit
Date: Fri,  7 Feb 2025 17:50:38 -0500
Message-Id: <20250207170315-17bec20a851e3d46@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <173895601419.3373740.4927786739399794017.stgit@frogsfrogsfrogs>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[ Sasha's backport helper bot ]

Hi,

The claimed upstream commit SHA1 (e96c1e2f262e0993859e266e751977bfad3ca98a)=
 was not found.
However, I found a matching commit: a004afdc62946d3261f724c6472997085c4f0735


Status in newer kernel trees:
6.13.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Failed     |  N/A       |
| stable/linux-6.12.y       |  Success    |  Failed    |
| stable/linux-6.6.y        |  Success    |  Failed    |
| stable/linux-6.1.y        |  Success    |  Failed    |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

Build Errors:
Build error for stable/linux-6.12.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

Build error for stable/linux-6.6.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

Build error for stable/linux-6.1.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

