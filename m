Return-Path: <stable+bounces-124236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EFFA5EED4
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC66419C0C2B
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED291263F25;
	Thu, 13 Mar 2025 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5nMQRYM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B03D263C7B
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856499; cv=none; b=A6/yeuo53kP6VL/0bNj0N7XDV1yJHLc/9QmvU+fXobnjJf7urFR1vWUrtR+JemFVqbgoiDTKjk+H7Z6MMNA6XJUkN6b2iN3y1CmGFAVA1hChFixPF95yz+DgIkUXM7rB37SsdUiC2/RyrhIxsTIZQG9i8n4I/yxPPokop+cVBdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856499; c=relaxed/simple;
	bh=bGwWxgTBWuHUMEds1cu39DTT9ZeZRpIsYV+0WnhZnwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTbROgL71B67tGOW6HqJ7yRslWzALOEcpgJ3rG0y/LjXkqQ0tP+PB/z5BQseVJGC/gEMoeVLIa4O2GYxUV+xuOtuPpFZrZdOuO/Q3zJLUf9aW8Ge3MEnZx0hTMDIX+3v8tgH2MdERUEGu5quYIWQoCLx4nOzMgetdZuMuUKE1Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5nMQRYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA25C4CEE3;
	Thu, 13 Mar 2025 09:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856499;
	bh=bGwWxgTBWuHUMEds1cu39DTT9ZeZRpIsYV+0WnhZnwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U5nMQRYMtTjyiOWEuT+4+UDHtHnhlE2tHGtFXfzhAAKBCl8u5zOQp0fIeEAybBVf0
	 /SEJLT6/x63qQ138eUZAoAmmva0IrmQezNFGp7Z49Tef1LRVpCyEl4qyl58VeTzDVP
	 6rXNqr/mep284FNpvML9vYU77hHDAJYQ8IODYSF0vv4z6uor2JOobMvIenPf0A7UZ/
	 02hxg+0KNjSr2xDxO5kZwv+O0ugXNVKaEYJ+Kc1Y4IBom8pWABM3cUTJ/bj/gJ/r99
	 8k/ZD0VGHdKIA7/DkR9s0MMn9dEkesWhhom++Z+zXD3cyq1wVnO1GdT5OIrZKoWqEP
	 1vQPNhNgy9tQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] fs/ntfs3: Add rough attr alloc_size check
Date: Thu, 13 Mar 2025 05:01:37 -0400
Message-Id: <20250312201820-bc6d5bb168360bc7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250310075343.659244-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: c4a8ba334262e9a5c158d618a4820e1b9c12495c

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Konstantin Komarov<almaz.alexandrovich@paragon-software.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: e91fbb21f248)

Note: The patch differs from the upstream commit:
---
1:  c4a8ba334262e ! 1:  ae4a5f7e9e7f0 fs/ntfs3: Add rough attr alloc_size check
    @@ Metadata
      ## Commit message ##
         fs/ntfs3: Add rough attr alloc_size check
     
    +    [ Upstream commit c4a8ba334262e9a5c158d618a4820e1b9c12495c ]
    +
         Reported-by: syzbot+c6d94bedd910a8216d25@syzkaller.appspotmail.com
         Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## fs/ntfs3/record.c ##
     @@ fs/ntfs3/record.c: struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
    - 
    + 	} else {
      		if (attr->nres.c_unit)
      			return NULL;
     +
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

