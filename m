Return-Path: <stable+bounces-114321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD15DA2D0F2
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BCD188F5B5
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E260C1B040E;
	Fri,  7 Feb 2025 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bex5/FDB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30091AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968650; cv=none; b=ha/SWjP6lbSAffg0KI6eNGigS5dnRjuiFla2QfHjah3gq7waz57whZFY9HHIj/JhU+Q1VSX39Nq8bpeaFG0csUX+yBO4i+qhLLIJVrFH8G8byL51zkHsVha1siTeUiskbsaBIrw22gtWRPB5kMkzV7EtTe6uTro7FPw/U5hN1nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968650; c=relaxed/simple;
	bh=jH0yaTRNsrN8qDASEEiiXqiBy3kgA4KtcNd4a3xYyZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pg3fB7SvO2q5SUVIloS7oUCeuCmRHCKpEa7f8lh8duXQ68b3PuYz38rtqELkYkpfGwQsB3HgVLi1PfeL3r5jbwKX2CuXZRZTPrXt3fxahWGyLxCNj5fCKOHAw+tvvVaYymsHoGarUcFDW4oobXIvV/bLtNLoMACkZdQFzkyMJFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bex5/FDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18894C4CED1;
	Fri,  7 Feb 2025 22:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968650;
	bh=jH0yaTRNsrN8qDASEEiiXqiBy3kgA4KtcNd4a3xYyZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bex5/FDBLSQTnXEups2O7dpREpo6y0IHAswi7lS6idAuHF6pkSLFBF/NDXyYF20NK
	 yBswf61+MjCec38wcoA1ZnsgQ8uRLyl6Am2Z6qVqZcIcDKUD9yM5xZn5nDwBS+0hMy
	 7X6dH7e4UAJ9uoa8fEkNQZNlqinaFeSeoGzXxb6CzQkSpqjnPupL/dWY5RVbyhweEv
	 jmvkDAMNzk31vW+iKPUx7gcStt3cjEmgg6LioiRgGYyVyN8wV/Oc5OurMI/4j2urql
	 VWK2VfsZRs3K4B+VdUdMmEy8mRT80rFoEYteRCvxUdZLHA/P7GxzVFWldIZMgdGEAK
	 1eSjOhcZVu7Xw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 01/10] xfs: avoid nested calls to __xfs_trans_commit
Date: Fri,  7 Feb 2025 17:50:48 -0500
Message-Id: <20250204180941-75badf1461a04900@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <173869499359.410229.16535171441757027813.stgit@frogsfrogsfrogs>
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

The claimed upstream commit SHA1 (e96c1e2f262e0993859e266e751977bfad3ca98a) was not found.
However, I found a matching commit: a004afdc62946d3261f724c6472997085c4f0735


Status in newer kernel trees:
6.13.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Failed     |  N/A       |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

