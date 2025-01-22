Return-Path: <stable+bounces-110184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8A4A193A9
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 15:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6743A3F73
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D780213E81;
	Wed, 22 Jan 2025 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7jXdBiq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE896213E7F
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555399; cv=none; b=DQUZZ4jzdaSfOYY2Fvy3lpwOK7+86cvrCylmGBVmPpz7wLcejeszpjJSUckWRktfOPKFdLwZvFbAGax5ATrbwCMI2DXOTphBnBqzhc35oVcHPel8ZOsOD4S64ltBp/sKp6n9NZ0OgncrPZbga6QoYByGsmIT+B2Xjjt15GO7Ek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555399; c=relaxed/simple;
	bh=8UEX3XT2Qrx/SNQ0SjuGXbZsWvxZQKrb1eQmMQkTTlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yyde0UHamSv7ByjqGxfPo9Y/Kiv7hal98RIbtKknV+zNSJKwOxx7OVfwIKYtRE93u/OZnBCaayi0CE7Ismq3/vFTvA42qN7uI5Zt9K8FAJzzkCbi1ANmVz3faIUYB4oB7BHm60l23197czoXGAeOCcOHUxs9nV0jrQKpMEKtnpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7jXdBiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0890BC4CED6;
	Wed, 22 Jan 2025 14:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737555398;
	bh=8UEX3XT2Qrx/SNQ0SjuGXbZsWvxZQKrb1eQmMQkTTlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h7jXdBiq3dZsUEUZYrtRNGkAV9hqrOEtMiYW8VjHqa8tTCyhA/lhP2/t7v52Epjah
	 Xrrl50lZv1F0R/zMzWV+CwvZb6bliTORZX7VomZd/ySGh7D8dAe+9RDTJCS/6JHqtV
	 gqjbpwG7YBZNm/txayyu7liN+KmrMxMjQZB12opQzJ3GAsSK9TwSMiuV2D+AbVIX95
	 Xp/aVOsEXvgESwO/+lwK/PEI48FDLXRaWHompnP9ENW/ST9ZKv6RKL38+Eaumc7rkZ
	 nmyKGorrJUcurRewZe8u15q1zpXgw+RwAsi/y4JvMz/0wX9bMOdTRyDch3J/iKSeV8
	 J/808M+vcxPkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] KVM: x86: switch hugepage recovery thread to vhost_task
Date: Wed, 22 Jan 2025 09:16:36 -0500
Message-Id: <20250122080314-cdd8ce8c6b9e49cb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <Z4gGf5SAJwnGEFK0@kbusch-mbp>
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

Found matching upstream commit: d96c77bd4eeba469bddbbb14323d2191684da82a

WARNING: Author mismatch between patch and found commit:
Backport author: Keith Busch<kbusch@kernel.org>
Commit author: Paolo Bonzini<pbonzini@redhat.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 91248a2e4101)

Note: The patch differs from the upstream commit:
---
1:  d96c77bd4eeba < -:  ------------- KVM: x86: switch hugepage recovery thread to vhost_task
-:  ------------- > 1:  e24606748e041 KVM: x86: switch hugepage recovery thread to vhost_task
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

