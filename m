Return-Path: <stable+bounces-96047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52959E04D9
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9A028508D
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6F82040AA;
	Mon,  2 Dec 2024 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arS5sHCj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3DA2040A8
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149600; cv=none; b=XLqF1+zl4tHcUW+HvCQK0kMmHiZpB5YlyTsj74fbxYYF4p+IpKGT6opiTYGR9/KJC5YrZBHlrjkngb7oPsvoeMiSuWtqboTKrljBHBdRtbSd/XwXlz8O6/KbPmOtLC0p96+Y/cLh9vQzFiu0QGGSO90gW0KoQLzIaa1/04QsDDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149600; c=relaxed/simple;
	bh=dh5bYB+6/8wXlVMlBqfwdU8bJ/nsBjY49weGLWjTe48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qY8R/Tu2orsiTqQyn/R3VKTPm8Xzl8fPVxy0slDmWdQhFw1l5ej6TpetGDmLOFFOvO9bBEaJ6hWlvoCpmUKVGisk9MNvC1sxbDqAqKwHz9Sa87CCSQesPsbU9U02TyjD0FvOTdTCOe1/yUeJnSd8FIch4ziyVCIXxbQcjjvGJxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arS5sHCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1330C4CED1;
	Mon,  2 Dec 2024 14:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149600;
	bh=dh5bYB+6/8wXlVMlBqfwdU8bJ/nsBjY49weGLWjTe48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=arS5sHCjzn39lFa/sjJhfPYzWkCjoUfq9JqP/R1B4gKtW0vlxEFx4rSLEId+KMmml
	 6IagYEvbjhJzG4664Z1rs86jYWlWmvEKxu5bDV6mvyDqfoMVX4aFbx4ScfpzU1Io2W
	 7bpTBSKnGL+rKWu+6BSmvpb06yhXS3RdgL8oHiQej+UZsj2UUq6gJK/RgrDjRddTDJ
	 RJ8ETReNlsJr6JbgWNaNl+YRSm9APPls8c0onMPwZ4DWx3xnx3iYOnLGa4wHGj7ilc
	 iyMn7wKo+2fg1/lSfVmT8WaGM6FaRYljHpIIaWZE2EsJoiSQYKdTWWt+z0qEnlEzYP
	 T63vl5qpJ/UjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 3/3] net: fec: make PPS channel configurable
Date: Mon,  2 Dec 2024 09:26:38 -0500
Message-ID: <20241202083301-67d58dedfa3aad25@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202105644.3453676-4-csokas.bence@prolan.hu>
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

Found matching upstream commit: 566c2d83887f0570056833102adc5b88e681b0c7

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found
6.11.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |

