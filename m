Return-Path: <stable+bounces-114326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73970A2D0F7
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB86188F624
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE80D1BC062;
	Fri,  7 Feb 2025 22:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qfd/J7qP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FADA1AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968660; cv=none; b=gqHp5OnkzE9tZxajuzjczzYjCGGMmwvLf/q9FGaUtJlgP5vXlcVNz0PDotp5UPa8dGB7t80vFM0iyMp5b58Sbd0krmZ1U5hG8eZmf7dF8HRUgHcFmOKMJ8lM40z5+Kqe27MAwIxY/rkDhbyw06HX/hP4az1DHZ4FgyCbP1JEpXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968660; c=relaxed/simple;
	bh=ZLtXl6V1Eu1hFyMjatWhGurXBDOS3ijo4nvAFsL2+So=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4qybj2r7n/3HbvKUTZAiLLvsaKo9w+mQaw+yeyhG+ETGKBVKfAJ6xZmZQhbCGEwQ5cqbJc4SR2qZ3Vtjx3ZLEqcp4b/+q422kg1sNnsGnv8HP1i8EyFJm+L9TJZw3zQ4Am/JTzkKtsqACWA77i06kepS3uPHIGCkHtZugS/r5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qfd/J7qP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94FDC4CED1;
	Fri,  7 Feb 2025 22:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968660;
	bh=ZLtXl6V1Eu1hFyMjatWhGurXBDOS3ijo4nvAFsL2+So=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qfd/J7qPwW/0Ab4uvxLCv36nJ9h7b3SIzJMXw92oPI3AJLYsFDOeENc4QPqAYpF7t
	 osoq8FHhMkpCOPw9QD3mdUak8WLS07oSCxYZ4b9Dzb3uXSdlW/3Tm11UHbdFqfWTjG
	 uNiQEnv3F3JISLqgUsLu/wdg+9B30mUf6tkHJzYKCSfGAYyIIWzCOPTp7OajDWxERN
	 XFEovxMNZHX0AYawKk51jtyoqUmfTk8GSkQHQP3g3uIgPTRJ80g5HBK5FBgVrqmAb6
	 9i6hGASE0EmPk6Sp75Ec9FbhxeFm7TYc17W9XhPWHF1SpxpWl0COMWga1ulAg+Fj8H
	 O7CGufp9q7oDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: vgiraud.opensource@witekio.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] net: Fix icmp host relookup triggering ip_rt_bug
Date: Fri,  7 Feb 2025 17:50:58 -0500
Message-Id: <20250207161840-0537b2235c1afad6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250207145657.2504508-1-vgiraud.opensource@witekio.com>
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

The upstream commit SHA1 provided is correct: c44daa7e3c73229f7ac74985acb8c=
7fb909c4e0a

WARNING: Author mismatch between patch and upstream commit:
Backport author: vgiraud.opensource@witekio.com
Commit author: Dong Chenchen<dongchenchen2@huawei.com>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 9545011e7b2a)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  c44daa7e3c732 < -:  ------------- net: Fix icmp host relookup triggerin=
g ip_rt_bug
-:  ------------- > 1:  ff9f0e32926dd net: Fix icmp host relookup triggerin=
g ip_rt_bug
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.6.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

