Return-Path: <stable+bounces-127687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2870A7A71D
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DAF16438E
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F532505A6;
	Thu,  3 Apr 2025 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwzj1zV2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063CC2417C4
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743694736; cv=none; b=UlisU2UAJ35W12/fhf56Tre6r86k67Ydo9zHyDfOy3Q4CgS7heUsxp/AUxGPA5J/8qGozWSisTgsLTf0u0KXW3i3h5fxnke6wafGAffjHY7oGS2mo7SXqlFhbfIEZ7Pcujfl6zZwWPXDHICoKIKUW8intwm0biM7lAmIihDBpiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743694736; c=relaxed/simple;
	bh=y6qdhNJdpg9O9+sVx5Ngj9kh/5BVwmOjba7AK7E1WnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HvuWbb+C1ndhGyj17wQJUTbgtoKpllDENdirIO42FKea3yJan7tfXvx5c3ued5njL9GSkJAD0foXXJm/Z3lPN4Wa63QW4UnkErhOHbB0+Xokn7mQNIcRT9b/+kWiDwWa+dQdaSgbi9wLXXHX0ST0kDhtOYtmMzrfwMxDeSD7YTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwzj1zV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B5FC4CEE3;
	Thu,  3 Apr 2025 15:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743694735;
	bh=y6qdhNJdpg9O9+sVx5Ngj9kh/5BVwmOjba7AK7E1WnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cwzj1zV2pLHD9haV7GB6YTuA87krf2hjDEOPNjXDLX3G/pUyMIzj+zi6tVPEYeFkE
	 mc/KyaeIQ9OHMZUBydDD7GvnZMMh1430LbbRviQ4BR8yYGdk4up9q0L4ri3R0AveLF
	 BOCVFs/erqdZoTmfMSZhpJhqIMJt8StiTIXRXB8nKJkt99sdVjmFTZy1IUTlNQVM34
	 6ut66my8l5BSccMF9PorLsdGp965+dtweEfFjM0xjjUc8s+BCbud2d13XI6t9ZmZiI
	 GFRYZaUjkh40aKyaCe5jf6jOAsdrBgmIng4EMsg5DnEF93F+2sEdkahK/48k2HwEdS
	 nNS/ycGAOaMNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()
Date: Thu,  3 Apr 2025 11:38:51 -0400
Message-Id: <20250403075021-00813a69bd57e6c5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250403032915.443616-1-bin.lan.cn@windriver.com>
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

Note: The patch differs from the upstream commit:
---
1:  0e881c0a4b614 ! 1:  878d9878dbf20 scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()
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
| stable/linux-5.15.y       |  Success    |  Success   |

