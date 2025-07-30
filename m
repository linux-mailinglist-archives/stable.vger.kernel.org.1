Return-Path: <stable+bounces-165181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05719B1579F
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 04:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCCA3BDE8B
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 02:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C161C68A6;
	Wed, 30 Jul 2025 02:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOzNeRz3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0223315A8
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 02:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753843405; cv=none; b=Q8GqCs6Y5OyumSegvWFOHHyrHxT6otnvYI0OG28DD59/FuxxH9vBGqGehGiXUXJZfP+DHEX8xVd91+704aV8nNI49dxqBgU4VGkKTwn6iu6MA78H9A68ok2nkRmOBUTKugNi6q9vF0ReTIdToi2CcD2rHo6fWi5OH89pAH8ZLts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753843405; c=relaxed/simple;
	bh=yEIqm4L5ayU/5yfMoKyxLQigMtkqfl/W2C2TaJyhmXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cB0boa4waIEHA2f2x6WNp0uyzqk8fgMF6DRNf9D6MDFqYC0bT4HtyujpwDcVAGKQABmnph9u+oh/vAFEVfnCY+IE7gGeaAMs1/q/O/k5SKFfe/4TTaHl06FhkOMVseNKzPGvEJsHGbFITvy8fnuD5Zc+WdkckIA6aobz/PxdW6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOzNeRz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6674C4CEEF;
	Wed, 30 Jul 2025 02:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753843404;
	bh=yEIqm4L5ayU/5yfMoKyxLQigMtkqfl/W2C2TaJyhmXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOzNeRz33IMGKDKvY3jbrEbJTPi8GMtT3p+qi50h9ff6MhV9WUhONT3FtPszZUcMY
	 lK/kjr7GxiUiWhvYPpfdRVvFFE87GTdwlpaaMZNEPBebe0dX/4+8rqGSi8fhmRH1r1
	 oKogLF4Wr5wGGtB712QMjQbuDwla9Ilp9vDUWZ9+IndGI0hk6+dTBJXmsWM2zhNeAA
	 SZuJ5rnGYnBO4LYmT49ZXOnchLUd8pyse2KCNon7w4X4RufTPRC8f3uXou7gD+ken+
	 5H2EV8+LBoRzbgesm8uT5xjXRaUdfYfA9wtyrBtr/H/wmVUmill14Kk2QFOaJ2jwdG
	 lX6mKU+FTb0lA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 1/3] mm: drop the assumption that VM_SHARED always implies writable
Date: Tue, 29 Jul 2025 22:43:22 -0400
Message-Id: <1753842031-acf97e18@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730005818.2793577-2-isaacmanjarres@google.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: e8e17ee90eaf650c855adb0a3e5e965fd6692ff1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Isaac J. Manjarres <isaacmanjarres@google.com>
Commit author: Lorenzo Stoakes <lstoakes@gmail.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  e8e17ee90eaf < -:  ------------ mm: drop the assumption that VM_SHARED always implies writable
-:  ------------ > 1:  bc4bb0b14ec1 mm: drop the assumption that VM_SHARED always implies writable

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

