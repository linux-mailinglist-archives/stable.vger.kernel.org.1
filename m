Return-Path: <stable+bounces-166946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4485CB1F775
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 02:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048133B3E28
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 00:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5769CE555;
	Sun, 10 Aug 2025 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dfyg+DRW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A176EC4
	for <stable@vger.kernel.org>; Sun, 10 Aug 2025 00:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754786538; cv=none; b=VPxPlEopNHecRoiTewf0n4g2M92F2DZZH4US819obVS+DXVIBw4z0ZFmJfLZH9Lu3kWKu1lSEub+wX4okyfTRqJ4+OqEdffI4NTSAn8wI3geYZrl2LlCTQ49cs6bUoIDzb2AfYVT0q5QwgJg1RbcWpiUjyVk4I0VejnPrL3cgHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754786538; c=relaxed/simple;
	bh=5nRVAI4zmMXb+Vrhtzz+bt2kfUH8qczktJY5MPw0RfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZSje/NEUpFog3w9/ntDpqie5eGgrItoAiAz7nFdCxXNsw2Gh9iirxouN3kc12RqrryUJSYEnoiTRoww9vFbdHXmiNpRLuP0HObxqXbK1EyNOd/ulqkWE1Mss0WUSiyol3HVGrJmaXRfjP+keXVNByymOU9NRSGzKwlSROrT8ias=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dfyg+DRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFF6C4CEE7;
	Sun, 10 Aug 2025 00:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754786536;
	bh=5nRVAI4zmMXb+Vrhtzz+bt2kfUH8qczktJY5MPw0RfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dfyg+DRWrP2KvVXGMKs2lFF2N6a2LIPo515HeZeSJEBhIi9YyswC6M1lBktF8SXEb
	 XmCFnbEP+4jKle5NkNUY0wGHIug8TNASCNpWTDjs2Pwm/1eZxm/ejnTbar4ppi13ok
	 9GK7tpvaoE3lNlXosCSABeOsPMY5n8Pfxn4JjbVqESimZpxvtfFnM25D15ixG6MweG
	 wKnYqzeQwf4owfZS6vNd00U37TCeuasEnCKZve1O6hbxgFvzNyOhdeO0Sr/dzt5lbP
	 4uI6xXtdsBPb34gad7WK3Poy6ETa95JxzlWRChIMJ2Vjiax8ZDqH7ph65wv14YwMMO
	 EYEJdsgdG3a2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15, 5.10 6/6] sch_htb: make htb_deactivate() idempotent
Date: Sat,  9 Aug 2025 20:42:14 -0400
Message-Id: <1754785436-585075ab@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <69475adbed0c42b245793b211084905ecacfd524.1754751592.git.siddh.raman.pant@oracle.com>
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

The upstream commit SHA1 provided is correct: 3769478610135e82b262640252d90f6efb05be71

WARNING: Author mismatch between patch and upstream commit:
Backport author: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Commit author: Cong Wang <xiyou.wangcong@gmail.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.15                      | Success     | Success    |
| 5.10                      | Success     | Success    |

