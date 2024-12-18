Return-Path: <stable+bounces-105151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B419F65F4
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 13:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B5516CA70
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 12:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699301A23A3;
	Wed, 18 Dec 2024 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE5pMAzQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0641534EC
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734525239; cv=none; b=WiZ12/0ImYxXYDhKov7kdWGoRs5uMHflpazSHvhppt3fBiNu4cnoTqlSRaY9KjLybVXF62f4yiMLWFWfw/JMiEwxlD+KH4+uAdNaE+pqHGYSDKGFE0PLmKp3XcZ6ZCPE5L1W5uV6LW/33SKNsXVIpMKSqmINpneVkQyzHCISyJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734525239; c=relaxed/simple;
	bh=bWTt9cAjSDoaG6jjlDMufZN3rHny+//JlfR2WkDnHxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rjDHNFYoAqpWSCRYTyIa3UGkVD4yuoHW7SXf1/NYQ0m0vwHGYTupjzDBF/9FR818jtfsz/C1VTjp8e5UDuXEwe2weeQnSWt6dHDiL4xgpzhAidHR0JhdJpGc9rw/REaGanVDL+u9pth6t87/dodwbOiQODnloO6DRienQhnqCIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE5pMAzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F116C4CECE;
	Wed, 18 Dec 2024 12:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734525238;
	bh=bWTt9cAjSDoaG6jjlDMufZN3rHny+//JlfR2WkDnHxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UE5pMAzQIQRXdx2poe7N2kfHKmZe22Ts/mG8UnH2hyvz/lrKdlX3A4FDOzcgyEYHL
	 wpx72flB04Cejr8loc1NakjmfkppYdL9sSRGDzgHbXcoueBJBgjd1OzmOM7rvRcXzA
	 TlvMJYuVO/9YjJS3Ot0BUKQ1BeGGnYiCuwsI0MYrGkVqi/K7eLq2rHONuk8mNdIFV8
	 0M4SwS1sBcfhOaOrvGJEVCrv1EaiE2Xsy2K3XjJ0La4baz6ffTiqLpIWoYv3bTnycO
	 U52rsn81s3B7eKIr6hHwwTJPcSij7s3mzjIYVZoVZLys9y/dDDDApbUlnJ//LXBMTP
	 NZDLa+N4aObsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 1/2] erofs: fix order >= MAX_ORDER warning due to crafted negative i_size
Date: Wed, 18 Dec 2024 07:33:57 -0500
Message-Id: <20241218071625-a0fd6e6bbe947037@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241218073626.454638-1-hsiangkao@linux.alibaba.com>
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

The upstream commit SHA1 provided is correct: 1dd73601a1cba37a0ed5f89a8662c90191df5873


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: acc2f40b980c)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1dd73601a1cb < -:  ------------ erofs: fix order >= MAX_ORDER warning due to crafted negative i_size
-:  ------------ > 1:  025315542f31 erofs: fix order >= MAX_ORDER warning due to crafted negative i_size
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

