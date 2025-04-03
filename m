Return-Path: <stable+bounces-127697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1806EA7A726
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600B117725F
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0D6223708;
	Thu,  3 Apr 2025 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrD2zLrO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188AD24CEE5
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743694780; cv=none; b=tbvfGq2DuYf/HA7tr4SgNcncL1GOh3T2oJhQ3NtIJKd4n7etM+7ojQgg8jjnk9ucXjovM9qw9LHoC3whfjjome10KE/uBobmjrmbfNsyjteoU+6A/O8tiIksDZjf5lt7uUJ+wZKAld1q0p/cQ7U2qaSiVByojHc2Ms3ZjCHu/JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743694780; c=relaxed/simple;
	bh=ulTtPI1zXoqdh1iRlj0Ock5IeVnO11Nwxx8HNlpZe4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZbAK9JUKZtqmQd0acsEw53k2h85QTkXhFS54hSlkAUeLxjyQ3eDlURYyj9FiBKw5MVNR1lPV36n3AjMA/fFPK5WQd20gydLhbh1KG/lXWU+FWWY6Esaaa1Mgno+vcpowDNXn7i8WZ6pbin8H797/HEYUYxsHYXLnIOdYWxWos8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrD2zLrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CD6C4CEE3;
	Thu,  3 Apr 2025 15:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743694780;
	bh=ulTtPI1zXoqdh1iRlj0Ock5IeVnO11Nwxx8HNlpZe4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XrD2zLrOlv/NNeZRtRQO1hP44dGegdfewGNzU/wlL6iSkSFPLXsMh05j1FP77H2GB
	 AR8Pmefe7BeHjWp4hxfmSpv6zfxLGUaoTnSUIKC5Zi0qCENsWpdnozM73DZ19FVeKT
	 ldgFcDXqJep9h2QJZbxJywX74QHLTAVhC00T2i7KEyz0eZCwRGEJP7lW8Ge66tpY2l
	 7kNq1o/+3LVbIrrOuWsAslwKAghVIZ24mnIfdU2iymavwEVJQFer84diY6OpOr+oYJ
	 VkevEKwO/6RWnTZkbBbGjCafpOg+mvxdTkZgfm3hyT9isp/UB7msemv8Z636zTpr/F
	 EKEqXvUkTwDiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()
Date: Thu,  3 Apr 2025 11:39:35 -0400
Message-Id: <20250403072011-f82ea39e6604778d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250403032915.443616-2-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 0e881c0a4b6146b7e856735226208f48251facd8

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Tuo Li<islituo@gmail.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: 30652c8ceb9a)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0e881c0a4b614 ! 1:  efb93eed6f136 scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()
    @@ Metadata
      ## Commit message ##
         scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()
     
    +    [ Upstream commit 0e881c0a4b6146b7e856735226208f48251facd8 ]
    +
         The variable phba->fcf.fcf_flag is often protected by the lock
         phba->hbalock() when is accessed. Here is an example in
         lpfc_unregister_fcf_rescan():
    @@ Commit message
         Reviewed-by: Justin Tee <justin.tee@broadcom.com>
         Reviewed-by: Laurence Oberman <loberman@redhat.com>
         Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/scsi/lpfc/lpfc_hbadisc.c ##
     @@ drivers/scsi/lpfc/lpfc_hbadisc.c: lpfc_unregister_fcf_rescan(struct lpfc_hba *phba)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

