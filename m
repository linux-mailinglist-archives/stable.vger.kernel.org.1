Return-Path: <stable+bounces-124488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88277A62151
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 00:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FDE519C5A92
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 23:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E971A23B7;
	Fri, 14 Mar 2025 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKpybZiH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834CF1F92E
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993829; cv=none; b=m6mY/gbtToBYW/bK7NrYaE3acV0MgXVKmy4qUF5s5Djd2hxJMsYX9G7AhBu5Iw5bRSZd+ATsXWAjVqHxNCoG4kMoSwsl2ttO5s4JUrY2HDFXRugT4UUn5x2o8s0ql+cxIzbsxmE/97vLsihWa4KqVGMQW3Wlg9jPDQzQWK5QLKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993829; c=relaxed/simple;
	bh=yODi1OQGvzysj3zzvdAyugrUudTrpyTYs8ZJU45It7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSKeD4G3/64oBae1ySu6CTC+FTfy0TFnPmqcy5MWjGWw3+q4mLgnzhOIXQ+aFiVrfp4JYN9rRFYIHpBfegeQEBJsyJmsH35fjmblRSnDAX4RcXSyxnek4d14IkAN11UizcAEjjNPjjXHGvNWxNGcROl23PMjtEJdByM2oIiyzxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKpybZiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3B0C4CEE3;
	Fri, 14 Mar 2025 23:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741993828;
	bh=yODi1OQGvzysj3zzvdAyugrUudTrpyTYs8ZJU45It7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IKpybZiHM5djbEca0eKvmOrly0klzW9Do3RPV28VeGi21M8r1b76BMlzYnT1AqVh8
	 2x8vhoVPoNGoPRI11BeB5dPwk9Q1m5m8z7bRMgbc8l50apw0JG7+gyLSp5sEsxhgU1
	 79xefClvcNUVLAgROAVkDCbgoH2nok+thieY10hFNjdb3ZkXOwbx1LpIHcWJ0Fn7eu
	 1vgdCXD7vscQJko+xsggh3Ju+458Qe/sUjK3rbjlrXhMhRBPkq/MnTeZX/ynafWzgY
	 OZCGSVZSMIuypfLwJA/lcE1Si7AurbEkqQ1AEP/DElc6TfKMld1r2lER7Hl+aUpsFd
	 e1xR3AMVkES+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 01/29] xfs: pass refcount intent directly through the log intent code
Date: Fri, 14 Mar 2025 19:10:27 -0400
Message-Id: <20250314110259-2f112c3ac5caf730@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250313202550.2257219-2-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 0b11553ec54a6d88907e60d0595dbcef98539747

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Darrick J. Wong<djwong@kernel.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  0b11553ec54a6 ! 1:  17e9e595a5fc0 xfs: pass refcount intent directly through the log intent code
    @@ Metadata
      ## Commit message ##
         xfs: pass refcount intent directly through the log intent code
     
    +    [ Upstream commit 0b11553ec54a6d88907e60d0595dbcef98539747 ]
    +
         Pass the incore refcount intent through the CUI logging code instead of
         repeatedly boxing and unboxing parameters.
     
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/libxfs/xfs_refcount.c ##
     @@ fs/xfs/libxfs/xfs_refcount.c: xfs_refcount_adjust_extents(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

