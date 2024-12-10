Return-Path: <stable+bounces-100478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC6C9EBA17
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 20:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC1A1677F8
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 19:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DA521423D;
	Tue, 10 Dec 2024 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4gBCzx5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6660D23ED63
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858704; cv=none; b=KB0iIHxEyvrFhJSJgMcsGYERRDTU5lk7RaLxOn7mXqBerBmEPrAz6lQ6wnSoohA8o4cBAhJj2ckVOB1F5GqtQGe5IVwjGFISLoq3nQ8LxArr0nedr9yKCsGb90NrbO4m5xH6L4eXLN1n1ZH7IyfJWQ2Nh4zxpHS3QLYnnTzZQBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858704; c=relaxed/simple;
	bh=rKDVEVKFAqCwdjrVquaOthHeOcLyoa3qk1sNsg06ebU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5w7UqkgZe6lGORxPfa0qdS/Uyi2kD7gxsalM6LYTVSTI6Og1SlezY9Ohc+gnQ1PRUUUqZIDUTMb2NQ8wl0O5M8CHptn8lFcQfQGtGYKVPbSK8BRzVBs+XPNLghAXWy+EkW6PhMpFvhXY+s8xG1cvViScsjPupgLjA/9MF55NEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4gBCzx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90B8C4CED6;
	Tue, 10 Dec 2024 19:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858704;
	bh=rKDVEVKFAqCwdjrVquaOthHeOcLyoa3qk1sNsg06ebU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V4gBCzx5PbVmVXi81o52lOVIvRioYmCiJOtZItR5Zt5MKuzsHpOFtFMo3m409NyNZ
	 cgSGyH+B5YbQ1zL5Efh38TmFrjtA/Ko4qi01kkMuVmsULKygqBkf86oClvRieM4rd7
	 RfCQgXoZjV4ozonMgdDsbKmjFheJ2hLAA5kwr6rOxqM83g9JfAVIEZMP8jPBUF04oI
	 j8hk7hB0tnMgcLGskHcc1SeDoipkwdL3h/m2rt2pnrlfGkTYmnQLehSai8AAhgkbfT
	 6AMuyh1VJxS4A0RgEUHyQsHLan4b6Yy9hG2beYnlqjuKwspSMuHlHPlpWLD5FbCkic
	 iWwo7jOgRFnGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2] xhci: dbc: Fix STALL transfer event handling
Date: Tue, 10 Dec 2024 14:25:02 -0500
Message-ID: <20241210082748-034df6c78484f384@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241210100440.3449803-1-mathias.nyman@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 9044ad57b60b0556d42b6f8aa218a68865e810a4


Status in newer kernel trees:
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Failed     |  N/A       |

