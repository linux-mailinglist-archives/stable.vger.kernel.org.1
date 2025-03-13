Return-Path: <stable+bounces-124231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 622F3A5EEC9
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664CB19C0D75
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BE4264A9C;
	Thu, 13 Mar 2025 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2Hoo8w/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A78264A8E
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856489; cv=none; b=sK5AMy7EiI7sUehksjNEAGubvkpOdJK5TPLy+r4iNeHbB/HGBgTVEV1ylwQa86SkAfcZcaBs8Vl91uuwV89YTA5yIhIAA0SusbZSWhnfnqulOcM95UjHMhJ2qrUki9fGeuaWoDQcqBXCBCpeXiNErsWd8QjxhvL46zzcE3djwps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856489; c=relaxed/simple;
	bh=tVIa6/XshDva+S6hDHgjTThmY9x6jfdq+wcqouY4Kdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UAeszjZ+P7klxQw+0D3qFPWsfcJXXOcwEoGjTGtlsmCBdOWjqJ2/WSnAbL0D8Oxd4pXSpKmq0BnvhCYCRgt+1+zZ3crX7pWH32xj6a5ZhfRlOORnVQ7QhqeP9WMGMAP+vNFQJNXQRPX/QKZIAwkffEpkUOXaXXIKbuDU+neZrcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2Hoo8w/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8F8C4AF09;
	Thu, 13 Mar 2025 09:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856488;
	bh=tVIa6/XshDva+S6hDHgjTThmY9x6jfdq+wcqouY4Kdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G2Hoo8w/QxI71k8Fzl8kE1u22jMUleaz66gttyjgupHcvAYf27CUKOo9f92v5VsAJ
	 lYzKuebAFdM2BB1eVtk+nWpdkx1UAVmU5J4SkaMYBomyIaqJ7wos2zufiM983vTCs0
	 LAGAGGAHHG+mpTlcXzEeka4kAVAz1ENJYwrsoGWha3D7cWl4H/dSg0qO1t2whwM6qm
	 SsA3r4lTEqRnIUCDRWhuL3qMihxkvY+pcTK4PhDnzvWJnssJzs/Tz6GTuoIfyGVnze
	 1k85nDfzNeu+ZAUR894bq2Yfnkt6iV/Gigfp/Z5lAkDqmbTs9LG/BpiBx872CWXk4o
	 FRC7MlDpzLk/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 1/2] rust: finish using custom FFI integer types
Date: Thu, 13 Mar 2025 05:01:26 -0400
Message-Id: <20250312231549-a2a68b67fb37a5a2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250309204217.1553389-2-ojeda@kernel.org>
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

The upstream commit SHA1 provided is correct: 27c7518e7f1ccaaa43eb5f25dc362779d2dc2ccb

Status in newer kernel trees:
6.13.y | Present (different SHA1: 0545eb878267)

Note: The patch differs from the upstream commit:
---
1:  27c7518e7f1cc < -:  ------------- rust: finish using custom FFI integer types
-:  ------------- > 1:  e14eb7876bb06 rust: finish using custom FFI integer types
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

