Return-Path: <stable+bounces-158585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3504EAE85AA
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9908B161A55
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CACF266B6F;
	Wed, 25 Jun 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4sQToSr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E064D264A77
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860454; cv=none; b=d0E4GfV6GQpkTtwgr+YlshXatVjGTMuHzvaRoAK8c/DH6OhHbz5VtPCyXFN+L3yTJ6ofJBeeP8eOMC/0LhylWRMJ3bdLazJBX9d3jErCKO5sMU0lQSf3bTnub+1Wf4tdkXEhfKtrD5OCIrFA97gEVvcsOsRagWiJqt6zU/DdfLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860454; c=relaxed/simple;
	bh=KpcP0BlRd48VRYEcXur8NP0SZZ2FOdDyTyXeJeHSmhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RiStbEnaMLFvFlyXgAZcKe50//1DAa/c9Y9y8TeGpMmaBFiBDDMv5W2GVcXEqSMX/HiCRZ21kHiD29TuVMddc5U51BLF3zPS65h5h0fDBziKsWhfLqQxROrU9pwD3opIeHRjgqeUY08K1SQM2P3iEGrer0f5yUP+rZs2IeCrUks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4sQToSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCC0C4CEEA;
	Wed, 25 Jun 2025 14:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860453;
	bh=KpcP0BlRd48VRYEcXur8NP0SZZ2FOdDyTyXeJeHSmhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R4sQToSrhGchls5tlxALMsHvz7sqjV6GxZ6IriooG2miRfWUpSpz7glkOUY68GyGh
	 Gw57+DJqucuR1VjOGRKzyL7kFFiTdHsA+z7ADa8sowCxkRm+aC98M/T2WHauPm5Y0D
	 idk5PoWnOVvSNnxKGVKDcHdTWhdH+sBkMVTCSeHr84jRJadW38wE42O4o+LJGIOHLt
	 o5P2B44abED1hx2kZo41I0cE/FghKJ8E0L/kLmR7JS7vAKoY9+jE6gmX89hVlgyFgx
	 c0QHgVsY+5qjBjrc9a+VP+uQzWPLLoF2U+m4Znge6qivLSkpFbivg6VHjqWNYZ2FKv
	 LFYDw+vlrFPbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	schnelle@linux.ibm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] s390/pci: Fix __pcilg_mio_inuser() inline assembly
Date: Wed, 25 Jun 2025 10:07:32 -0400
Message-Id: <20250625000602-732a4f6dba03b526@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250623112103.3663238-1-schnelle@linux.ibm.com>
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

Found matching upstream commit: c4abe6234246c75cdc43326415d9cff88b7cf06c

WARNING: Author mismatch between patch and found commit:
Backport author: Niklas Schnelle<schnelle@linux.ibm.com>
Commit author: Heiko Carstens<hca@linux.ibm.com>

Status in newer kernel trees:
6.15.y | Present (different SHA1: 003d60f4f2af)
6.12.y | Present (different SHA1: 578d93d06043)
6.6.y | Present (different SHA1: cc789e07bb87)
6.1.y | Present (different SHA1: e0e15f95a393)
5.15.y | Present (different SHA1: a8814ec473c6)
5.10.y | Present (different SHA1: 3fdee3d467c0)

Note: The patch differs from the upstream commit:
---
1:  c4abe6234246c < -:  ------------- s390/pci: Fix __pcilg_mio_inuser() inline assembly
-:  ------------- > 1:  1004858958e81 s390/pci: Fix __pcilg_mio_inuser() inline assembly
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

