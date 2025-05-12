Return-Path: <stable+bounces-144054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21814AB46C5
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 23:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335C58C146D
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EA3299A8D;
	Mon, 12 May 2025 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfIWmwY+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B565C259C9F
	for <stable@vger.kernel.org>; Mon, 12 May 2025 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086752; cv=none; b=U9KWYJyo4bc6TnEaNsMIMdPPq4sHF9IeACN4kfEb7PU84zdgRexC0bpQs+fGPrYKG8yk9ghirGm69mPEQ1SbHhhTdieFyyEbyLXFcvC9wlwY++ct3thxN8bZOVwS1qUd70XvtZLShfzWHyKmzjBnU2X7xFsSlJPIso93R0C3gtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086752; c=relaxed/simple;
	bh=I8anpGbic2ira5cOeBUeG5Rw0hMb2r9GxOlIljy0+Dw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFfJtnae8Fhf0UvBltfHV3OMPeMQtt0ZpRRV2U3RuIhUB8+bjVJpZKC9nXjhFeqL9UgoT5iFX3qeY/AJsmB+AydWrcfEsy4jRLvMH6v+Rbw0sVmVDMLEzYmON8H9FFZltLSPhrF1XAeSf2pI2EmZZPRvLxmDtG4HU9tEbZEWz4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfIWmwY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B75EC4CEE7;
	Mon, 12 May 2025 21:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747086752;
	bh=I8anpGbic2ira5cOeBUeG5Rw0hMb2r9GxOlIljy0+Dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GfIWmwY+KV49lxYmaMGbyrkKjng2KR92RjupXV+AzADA7J4pWUoFpAF3McL0raA7O
	 0G43O44libtXPSS+0HCTe86Hri7GSYIHRbFniBzpG5jQJlFzreSSiFrQcpaYsoVKsz
	 7pMlZgvjxpq+KxN4L6Oz9v8GLM6DDX/eloD4sGM7KJIBz/mgBIFHnGyg/z+JrkXsW3
	 9QM4VoPUH6rBiWO4YFBtfRgUR2yLS3W/q+N7zI8hOUuyz0KISsnx2HT4I/sw18Zdud
	 emBYdttVTSJOMDgaF5Ir1WM61jnWGBrdSIb4zeetKidRiqTltpUktSfv/k07R92ssQ
	 orAmfUh6AAX9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong zone index
Date: Mon, 12 May 2025 17:52:28 -0400
Message-Id: <20250512164544-8b3d2ef17b469c44@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512025231.3328659-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 2774f256e7c0219e2b0a0894af1c76bdabc4f974

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Byungchul Park<byungchul@sk.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: d6159bd4c005)

Note: The patch differs from the upstream commit:
---
1:  2774f256e7c02 ! 1:  dd7506755fcde mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong zone index
    @@ Metadata
      ## Commit message ##
         mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong zone index
     
    +    [ Upstream commit 2774f256e7c0219e2b0a0894af1c76bdabc4f974 ]
    +
         With numa balancing on, when a numa system is running where a numa node
         doesn't have its local memory so it has no managed zones, the following
         oops has been observed.  It's because wakeup_kswapd() is called with a
    @@ Commit message
         Cc: Johannes Weiner <hannes@cmpxchg.org>
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## mm/migrate.c ##
    -@@ mm/migrate.c: static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
    +@@ mm/migrate.c: static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
      			if (managed_zone(pgdat->node_zones + z))
      				break;
      		}
    @@ mm/migrate.c: static int numamigrate_isolate_folio(pg_data_t *pgdat, struct foli
     +		if (z < 0)
     +			return 0;
     +
    - 		wakeup_kswapd(pgdat->node_zones + z, 0,
    - 			      folio_order(folio), ZONE_MOVABLE);
    + 		wakeup_kswapd(pgdat->node_zones + z, 0, order, ZONE_MOVABLE);
      		return 0;
    + 	}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

