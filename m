Return-Path: <stable+bounces-158571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE2DAE85B6
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315015A589B
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A587B264A83;
	Wed, 25 Jun 2025 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBxkJzya"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6537625EFB5
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860439; cv=none; b=qfpoRvgAlWQprAoP18aQu3ubqn1ug5RbWFAdAltrqQYZ9+SPqTRBwrRpXvr8X8XhNOweENWzqQBvuxyqH/X4RGRLnmxcKGao54IyQYV/QJV8dT4ypcYwErSNuLcCu0HRKxrloU1u9P+9iB9Mj+mNKrkR3Elf8k2T0GbkNnh8/Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860439; c=relaxed/simple;
	bh=lVZm5LuYnUEdahR7TrpS4pqOUaUO8mEt4cUW15egg30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbVoU3WFcE4UScRH/Gb94wePKz5OlSGjARhuPWrQ7cq6rkeNNgI1jERA9kgUNmCf2vM9j6/1bGujeJ+U49uLn+56c2oR7/kEWWrVOFtel8RkAgimD/+M8Ik5rXi1w41+WeLWdSmKdxqZaIZtk0apCyFqrzTZtngTbIk6996y1RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBxkJzya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B44C4CEEA;
	Wed, 25 Jun 2025 14:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860439;
	bh=lVZm5LuYnUEdahR7TrpS4pqOUaUO8mEt4cUW15egg30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aBxkJzyaqF5ZzWnSlzecfQwjE7pRrdPOZJClbScJevB9WOT4F20cR6xyQQOmQE7wx
	 MMA5sQWx856ZnAXIjztO+QxJGhHsFO92UaVrH8fiFtBWy8m+4lKCFvZt1QayUCorQM
	 P2b1BOsWCIUSj6lMfNg/aX1R1Lqhjfp0xRbBcKop1/gHkuC1PsxGGJHmMOAbV3+gJ3
	 4xJLJ3RAQPXcOftr8ub6lbbMbcEy2iZ2xEOskITliWzIT9xEqMa2MmhHIRE7sGceGl
	 9fhexap1yJkWwHL20uGps/+5jRhVjqIz8MTQGBVtW5NpBBdA0PIlqebsriWX16PXYO
	 j3SnW6hHbiQVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jetlan9@163.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] net: libwx: fix Tx L4 checksum
Date: Wed, 25 Jun 2025 10:07:18 -0400
Message-Id: <20250624200740-b9a1d19a892bb96a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250624064407.1716-1-jetlan9@163.com>
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

The upstream commit SHA1 provided is correct: c7d82913d5f9e97860772ee4051eaa66b56a6273

WARNING: Author mismatch between patch and upstream commit:
Backport author: jetlan9@163.com
Commit author: Jiawen Wu<jiawenwu@trustnetic.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  c7d82913d5f9e ! 1:  378a713847ffc net: libwx: fix Tx L4 checksum
    @@ Metadata
      ## Commit message ##
         net: libwx: fix Tx L4 checksum
     
    +    [ Upstream commit c7d82913d5f9e97860772ee4051eaa66b56a6273 ]
    +
         The hardware only supports L4 checksum offload for TCP/UDP/SCTP protocol.
         There was a bug to set Tx checksum flag for the other protocol that results
         in Tx ring hang. Fix to compute software checksum for these packets.
    @@ Commit message
         Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
         Link: https://patch.msgid.link/20250324103235.823096-2-jiawenwu@trustnetic.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Wenshan Lan <jetlan9@163.com>
     
      ## drivers/net/ethernet/wangxun/libwx/wx_lib.c ##
     @@ drivers/net/ethernet/wangxun/libwx/wx_lib.c: static void wx_tx_csum(struct wx_ring *tx_ring, struct wx_tx_buffer *first,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

