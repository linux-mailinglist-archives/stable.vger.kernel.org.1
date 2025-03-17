Return-Path: <stable+bounces-124703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A19A658D8
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77D717DEB6
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C282F209671;
	Mon, 17 Mar 2025 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDmSz3wh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78772208973
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229600; cv=none; b=avkhgHzrU3Ec8ZFtBNyGvXzCvcpq0CucGUC+BAKotN0WPlaoMhcfF8MyNE41e7PAC0cvqpgq/vFfJH7q5HtSoJc2BjuZ1zXFuEqRD6ZNMj1khu9gVRnfQkL5hSklU7wPa63+8A7xDh2GADDC0AXp2f5nFaWE3rMf/Xd0xAkUmq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229600; c=relaxed/simple;
	bh=XDnAbOmVdWiduqmq+ojvbgbDzG0BuTxFUBrSInhfEE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNNwJoyfocuHruzC+7ltzWtFOBrRzDRLJ/FiAB49qRNcmuWw71z3fZMdrx/5nzNwsqMu+imQ7lQXDWG5/3dSEVTNdqUW1FFP2AHOqpblMRT4MuvBgPDTCN+ZP+VEdJ+uJB5pg/E1RDrFkcMOeyUTLEAO9k22MD36IWfEz6b98Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDmSz3wh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3917C4CEED;
	Mon, 17 Mar 2025 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229600;
	bh=XDnAbOmVdWiduqmq+ojvbgbDzG0BuTxFUBrSInhfEE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KDmSz3whYKn0+TtQ6UsnQWHFwHN0TjwA4tLUoY8TMnmEcLNcowDmYfEhpkIZfvxZQ
	 VWpUBecpXAKshagBzthdeZnKkAOV4XQrX29rECRER/K/360wlNLZNPU4cPFCJsQIuL
	 tKt04kKZGNGhAR4SKJPcw7NdNvYnKkY4w2eiKjdw8I/GFzF41pInOd4OXX4pv8iLwh
	 d6+P2Be7S+2t8JG4xO07SDYiltCZ2Y521C3lHUUwGUSIfY8zE8cQKNaIqo22xW++z4
	 eD/2G4roorPDvIan3CJalt9/MMzRfW1nyHymZeq0gMtXvIZQwvllZCrppgb6NCb8TA
	 L+UR80Pi+562w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	songmuchun@bytedance.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] block: fix missing dispatching request when queue is started or unquiesced
Date: Mon, 17 Mar 2025 12:39:57 -0400
Message-Id: <20250317083334-e265c88c77989821@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250317033039.6475-1-songmuchun@bytedance.com>
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

Found matching upstream commit: 2003ee8a9aa14d766b06088156978d53c2e9be3d

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 8b25c0a165dd)
6.6.y | Present (different SHA1: fe0d9800ead6)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  2003ee8a9aa14 < -:  ------------- block: fix missing dispatching request when queue is started or unquiesced
-:  ------------- > 1:  ee890aaab4d74 block: fix missing dispatching request when queue is started or unquiesced
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

