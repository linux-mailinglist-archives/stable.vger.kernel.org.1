Return-Path: <stable+bounces-165554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8236CB164A0
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FF1544C69
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72752DCBEC;
	Wed, 30 Jul 2025 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWExYOV7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750852D838B
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892945; cv=none; b=P+nl2GkFHIvTVk7nW3tJzKjQHfGRP4d6D2YJyzBl1QurIkVSgemhGXa7cVHOs9zcydsGXfRG5NxbFLCLxQaUNm8BMGH0X8agqDcMlZ9ALycM2TSkDTbe2sI5cRpPiEUwvyIfK2PAZLQV/s91NYb+tu10QNfmWggRMMMIZgtfcZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892945; c=relaxed/simple;
	bh=GtucPAALbTCrDMNen3bLtj+MofjmpL8wyq8OGmR5m2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSpWbPeNYw94964IDPpzSIV3ooXE/ibVhzaW3BwkF1LV7XLEwl1vFQZuYwFOv/+XQNKCV+eTC6hfSrbCp/TPIfFDRASL2jk9rZ/XRkLUwSsZNPV1nJ/m9xKGNowhwCeGkQol1qGRvNgBOY9r53n5chyWA/0Xt/hUn4UTxLkonno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWExYOV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA20EC4CEE3;
	Wed, 30 Jul 2025 16:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892945;
	bh=GtucPAALbTCrDMNen3bLtj+MofjmpL8wyq8OGmR5m2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWExYOV7PQl4tx/64ray3xyqxutPB1IyNsnC9lWODulx/kdl7hrkBc20wMTK7E0s3
	 Py8AOtcpKRvKyyg9f+5VTgyGcPz21NsptM5fnFt5pvOkZWn5iISOcxrvipTmEXyhyn
	 pgBjRcyJ4Gw9rZrP+1L9sJYm3iSFaIjwz6ViwlDd40PczXBpRnpI64gNGR2r869ARe
	 mfbja9X2U47iFV00rNff6jiYSu3pvN0tXPYPmzVu7NG3dpWvp34qKkjKfXFx+w5yNm
	 /H86pr/YUN8NOq3lec5GNJOMHiWox5+Jf06793P7KwNDJk7ZCMAFVKCP7MWw1Przak
	 NbOOlv3JPb8PA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 4/4] selftests/memfd: add test for mapping write-sealed memfd read-only
Date: Wed, 30 Jul 2025 12:29:02 -0400
Message-Id: <1753871285-0f7409d5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730015406.32569-5-isaacmanjarres@google.com>
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

The upstream commit SHA1 provided is correct: ea0916e01d0b0f2cce1369ac1494239a79827270

WARNING: Author mismatch between patch and upstream commit:
Backport author: Isaac J. Manjarres <isaacmanjarres@google.com>
Commit author: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ea0916e01d0b ! 1:  61035372efce selftests/memfd: add test for mapping write-sealed memfd read-only
    @@ Metadata
      ## Commit message ##
         selftests/memfd: add test for mapping write-sealed memfd read-only
     
    +    [ Upstream commit ea0916e01d0b0f2cce1369ac1494239a79827270 ]
    +
         Now we have reinstated the ability to map F_SEAL_WRITE mappings read-only,
         assert that we are able to do this in a test to ensure that we do not
         regress this again.
    @@ Commit message
         Cc: Shuah Khan <shuah@kernel.org>
         Cc: Vlastimil Babka <vbabka@suse.cz>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Cc: stable@vger.kernel.org
    +    Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
     
      ## tools/testing/selftests/memfd/memfd_test.c ##
     @@ tools/testing/selftests/memfd/memfd_test.c: static void *mfd_assert_mmap_shared(int fd)

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.10                      | Success     | Success    |

