Return-Path: <stable+bounces-104110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 617E69F1097
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A971882BA5
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0401B1E1C09;
	Fri, 13 Dec 2024 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqTIN/le"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AEE1E04BF
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102783; cv=none; b=UKLE+Lb9hZoDfB8oNljHAX06PciUdlFYaTiY5Gyuh1dXYCFtXQd1+oFBqd1WCkGSI/Fq2t7Z33wuHVbPWRgqTeOZBCbvTSsUnADc4is3AIJiNOfzfByf+B1SyCfDOYeEStZI7PmOg1CK/sH38WuRZWAjJcL4p+w7EkKrPLp3VVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102783; c=relaxed/simple;
	bh=EplsPFzpY2rtsY7N2Q3geHCjZqwYhS2VRNN7nscpzBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TajvCDx9BJiJwO7XSLzlYLtI7+9lK78JYFIcyZoEcBVBxRRgYkrxYuCIZKqjEu+DzSWU9D5ehILDPFrjQaOcky9u/iY1hpJ904HEjmENP3HhblUSVvt5qsRU6ec+horlo2mvY46zoLf2Fn0qcZs4TcYkyJ3RiQpLC/wTANhk/HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqTIN/le; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96ACC4CED0;
	Fri, 13 Dec 2024 15:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734102783;
	bh=EplsPFzpY2rtsY7N2Q3geHCjZqwYhS2VRNN7nscpzBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YqTIN/le80uHZWoSENUv7DB3Kyb6qH8hs2455vQcz9yw/mlRRFzHH6vazNcRYoLwl
	 T7WCDP7TD9EklcB2hdvPZZyhySu0V21ggmlsK0rWT6VH7Hpm81QELPcRXp15RaVOva
	 NdtdMMx7XLS4bulXAMEfPNLUz6TUmkH/qxdfim57zedNmFEYN+qkrhMTH2+ApceC52
	 WFi9cwga0jkIxBnK2WHevWi853jAotpwL1VHFzRr17MM8AGjRctJxomlHqKmj0FETG
	 hbP1HsfaTEM7ntfndvwwIjMPZkh0P5fsftLZv8g0lVVE8vZfVplk5RDifby4UQKJWb
	 LxjBAJUwG/6qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 v4 2/3] net: fec: refactor PPS channel configuration
Date: Fri, 13 Dec 2024 10:13:01 -0500
Message-ID: <20241213095441-ccc63d38af855c9a@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241213112926.44468-7-csokas.bence@prolan.hu>
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

Found matching upstream commit: bf8ca67e21671e7a56e31da45360480b28f185f1

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 75d06a0404ee)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed (series apply)  |  N/A       |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed (series apply)  |  N/A       |
| stable/linux-5.10.y       |  Failed (series apply)  |  N/A       |
| stable/linux-5.4.y        |  Failed (series apply)  |  N/A       |

