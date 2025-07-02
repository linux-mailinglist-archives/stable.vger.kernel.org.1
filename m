Return-Path: <stable+bounces-159186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE81AF08DA
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 05:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA30162F64
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 03:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F8023B0;
	Wed,  2 Jul 2025 03:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuC7X8l7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A439134A8
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 03:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751425379; cv=none; b=cpiHIEngEt180fF4rI8eOLN4FCykNYeFUzY4cpUrE/8/sKY8PYIPIy053JZHvcF952P6qSzigKZroxvWBXvxWzEmpf95/LKF5aG5UDDM2fwUZloG8+uy2li0MNfdObZsxYfE976yBOvyAu//Y4ipKaVdpdvzgx9t9jnsvDoDE3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751425379; c=relaxed/simple;
	bh=qmZa/w9FdmvSWkAOu9mWLJPyunEdeEAApSBBrud4fzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lpvyXVFjX28keQA/C89vOAvj5fzvkz7/YcOfUnKG1g7lD83Vwn87NQeNYjeHhXA2YUC/pI8ucoM9mc4MR1ySpPUWV5sgvDJqAMBEE/fJj9Ir6IdfmOH7sz7N54emHaI40tyI/4G3lp/ZtSINOIfsbUjuacW1Y4QtRKr6A9DLUY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuC7X8l7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98407C4CEEB;
	Wed,  2 Jul 2025 03:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751425379;
	bh=qmZa/w9FdmvSWkAOu9mWLJPyunEdeEAApSBBrud4fzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XuC7X8l7rJALYNwO9zqO5QRr5PnXIthIWMASkTybK91bFgCEUYX1HMEz4Lb9unHko
	 Mt4ot/OHCUJyso+IF9ygglNMOHNUpXuFZ9ZXWLLFncwywxMwRByaQsvz6zA+/mP6i1
	 sMiksdp5OGdMkZ/R2HBeNbGu7mkb+Zru6InuJjQievaaNi1y5tGGE7KesM7TOqokS3
	 QbuTlVb826u+jfCoYZ31S5xhPFtXz+6LERXkUaT/7UJpEnmcGJZ/7Xl2ZLR439YgAq
	 J7igwYqCnTf2RM0nljpGQrfgxvHedNTX5uEImwEfVKMU+ogWFGQwuvvnYXzMSBOmbz
	 ovRrFhe2FJGZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	avadhut.naik@amd.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] EDAC/amd64: Fix size calculation for Non-Power-of-Two DIMMs
Date: Tue,  1 Jul 2025 23:02:57 -0400
Message-Id: <20250701215110-ec8978958de859f5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250701171032.2470518-1-avadhut.naik@amd.com>
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

Found matching upstream commit: a3f3040657417aeadb9622c629d4a0c2693a0f93

Status in newer kernel trees:
6.15.y | Present (different SHA1: 8971673d7c04)
6.12.y | Present (different SHA1: 302f2ef77d98)
6.6.y | Present (different SHA1: 653a158b2ec7)

Note: The patch differs from the upstream commit:
---
1:  a3f3040657417 < -:  ------------- EDAC/amd64: Fix size calculation for Non-Power-of-Two DIMMs
-:  ------------- > 1:  673c64c326b4b EDAC/amd64: Fix size calculation for Non-Power-of-Two DIMMs
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

