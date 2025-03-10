Return-Path: <stable+bounces-121646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4504A58A48
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 03:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EEDE3A8C1A
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D4C18E764;
	Mon, 10 Mar 2025 02:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mq3Ex17Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85DA156861
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 02:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572869; cv=none; b=XbWnq+yc0/n0F5Vvf7KnXmOOCQ2aU3y+wEfoes0NrgvWMGIJZOLf7Vyh0JskM5UzXlAAjLWGtCzZQmdyFd8gUZXAL08Z/Pjtm4ZGLpxFfM4EVPXIAUkPYjT10gk6OTVdaQmR4LKF/NVAeMfFDb/m2I3waPMufGTBQjgouxwH30Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572869; c=relaxed/simple;
	bh=MptNho32ee3dBqnrGu9og9BhsDE6uAA96pO8Bm9CBK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=be6wMSrjLYZqbD+83ZiPWtVOsSHjESJbcF+tPspSABqE9mGPGcX+r9qfWmtZP6tgiHEdsJ+BRX08p1ZLAwUVDt1DUph/jdescfytE3nzHJaRq1tRfDWStrU73CIlMWumLm0S0wDIcslhMysv0En+lpefQdyV0bpMeIg9t5RyoCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mq3Ex17Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC1BC4CEE3;
	Mon, 10 Mar 2025 02:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741572869;
	bh=MptNho32ee3dBqnrGu9og9BhsDE6uAA96pO8Bm9CBK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mq3Ex17QZtoRztAbt7ek7txMWo3Xdjz6B0bbe4mk0IPITLKdvY4aTqVcx91rfB2zq
	 uycV5HxzeOZa365Wjk3hNNE/VKodGKofV55pykmF6qQP8rTyveqMHWZUaGs81Y79Qz
	 SiVnmeS4v1wbrw+gw4GSDrXkrGHtdRULWZBPB8K1AWMED5jjVVmuRKWeR/6n0wsAti
	 OtlKGNtfUvnGfrh4I54d7vmgbHXvg1vM/N2882AGq7aI+6UaKiGqpQsi5EIrUtojHx
	 2D3abTr6BSQv367ezI3WOPrcUXkX1P3v8SJ3GMOpyHuj7tHfZpfcudoF6udHXl0Aga
	 zWI/ea+aDFNPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	miguelgarciaroman8@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
Date: Sun,  9 Mar 2025 22:14:27 -0400
Message-Id: <20250309200218-b44aeb59f6c61146@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250309145636.633501-1-miguelgarciaroman8@gmail.com>
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

Found matching upstream commit: 91a4b1ee78cb100b19b70f077c247f211110348f

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Miguel=20Garc=C3=ADa?=<miguelgarciaroman8@gmail.com>
Commit author: Konstantin Komarov<almaz.alexandrovich@paragon-software.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Not found
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  91a4b1ee78cb1 < -:  ------------- fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
-:  ------------- > 1:  c9056c5e43e40 fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

