Return-Path: <stable+bounces-164625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1DBB10E64
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 17:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E6A1C27BD6
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 15:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619382EA141;
	Thu, 24 Jul 2025 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krgyKpDp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8942E9ED1
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370121; cv=none; b=b5I5TpU5RmXDMHYPyw6Bh7adkAAWOCQ8W7CV6mc+PxWLH4js+TFvHLVBDOTCk1gRDLrXm4cReMDD456V98G6iWuiR6lir2hnf+1rB1En5p04JO5QEWkTQWnLxmdaGmchnE7a2yOM3TrjkM+vYj8wFIufqkQ4VKCNwLQuzHFg024=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370121; c=relaxed/simple;
	bh=gWgReEzBbow3W5MoP9Z8TfkouS1C6QEIgYSP106YGDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7px8AIam/Zm/t4n+snxbFr4m9aAa65MRmeEA81JSeanGhOPdsgoZ4ZBshxJ8FS36ZuZ+9nQ5xyEOJw6Cqp8veOlFCIcAUjFsfclHF18LYJNHlvab+Wso3HFGvr7cwOv/peAuvwulFp5bysF3piYdEEn25oMHHVE7it3K6/FoR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krgyKpDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07175C4CEED;
	Thu, 24 Jul 2025 15:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753370120;
	bh=gWgReEzBbow3W5MoP9Z8TfkouS1C6QEIgYSP106YGDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=krgyKpDpTBG/iB8h3yqCp0RV06wjNKwcA+awjGhRNb25jDg1nDF03mEzpl7fBs7QZ
	 Zd3mQvGw/JR+5LbP6pLCncotTN1jN3N2XMm57SM56P3K4TyQ7epAnri5x0IMZwiLZf
	 MqHDPAc6d+CkLr6TIHalg84nYOgQKg6MuXBYPc8blnyr/yurYziQvJN26BDZCAemKa
	 XRHJC3uLohPLop+IhgxYS++FCXQI6lZh3Dc+GuKcJH+ygD1HS+gIvZYHJml/t29GHh
	 SVt4L8d7xmn7dgvt3uTpWXxNbgQpCbkfs9BIv08sa9L7rvgllBPiPPROrPJmcw7S9N
	 sT/JmBkpg+NfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10] drm/amd/display: Pass non-null to dcn20_validate_apply_pipe_split_flags
Date: Thu, 24 Jul 2025 11:15:18 -0400
Message-Id: <1753367646-f50e387d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724102449.63028-1-d.dulov@aladdin.ru>
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

The upstream commit SHA1 provided is correct: 5559598742fb4538e4c51c48ef70563c49c2af23

WARNING: Author mismatch between patch and upstream commit:
Backport author: Daniil Dulov <d.dulov@aladdin.ru>
Commit author: Alex Hung <alex.hung@amd.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 39a580cd1539)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  5559598742fb < -:  ------------ drm/amd/display: Pass non-null to dcn20_validate_apply_pipe_split_flags
-:  ------------ > 1:  fceefb8a1082 drm/amd/display: Pass non-null to dcn20_validate_apply_pipe_split_flags

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.10.y       | Success     | Success    |

