Return-Path: <stable+bounces-98576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E70AE9E48AB
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8F31880582
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7311AE876;
	Wed,  4 Dec 2024 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heR+AxHJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF26D19DFB4
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354582; cv=none; b=dcYB279xW8OwDpPnz4bmAFFQP+ysTZTN5vXpMUoHmq+P1mid0LheASKHEMXYsqr+o8OEKSX6GrFWq48x+pS9LivjskPIzejIDnMlqZmXQJG7SnTU6bn3twRAip6TbEq5akUR/XYKM9PUilW12K5CeUi0kOmF0ChzUktfs/sqTDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354582; c=relaxed/simple;
	bh=h/2yukU/PLvQ5dCvkSTTw4gvmy4ihrwjWKKUdtAd3A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsY16JPZxmb8wYTjh6gXbH/T/MR1tqQwFnVHvfDoRLrwVL4b2hozW21g6LuTRpwWOnIXKVyg5fYB/sZGdvUoWnENhLLkAgbiTNZDN4R2B3QDpxlPBoCeQKXT+aIBYQekvPEiEfNBXtV8/V4y1519xo/Z4gkkRFeToKHDKIIBHr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heR+AxHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0D7C4CECD;
	Wed,  4 Dec 2024 23:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354581;
	bh=h/2yukU/PLvQ5dCvkSTTw4gvmy4ihrwjWKKUdtAd3A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=heR+AxHJf3cgA7h0X5KH7wCcd3BNc4QYWqWrY01iE0jzLr3RtDQLKfXwJTAyB112N
	 m6Qpb9q8JZ70SR32prtG++zYDkUs28T1Lg4R0d8Ap0iELHJuVvsoO5XbK6fYwTp2et
	 dlLHo+eJYMOFJdmPnE9SYP19eIYfvCWQ6uBdAYb/ZecpJzoEn4K2LArZDmDWSuE6iG
	 IXk7bz2SnczUU6yq38OrPWlXiRKobNFXHbPxqIXtbMwv6MAyqsTtojgbwra67g9uqU
	 6NvQGpk6yyPshSydXGha/5F/a7csp8fp1nuH3KIq5Xa48FiSF3JWiIw8OIoIa2BX0u
	 X5q+XyXpRfZOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jing Zhang <jingzhangos@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 2/3] KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device
Date: Wed,  4 Dec 2024 17:11:42 -0500
Message-ID: <20241204163104-dd6998843c811041@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204202340.2717420-2-jingzhangos@google.com>
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

The upstream commit SHA1 provided is correct: e9649129d33dca561305fc590a7c4ba8c3e5675a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jing Zhang <jingzhangos@google.com>
Commit author: Kunkun Jiang <jiangkunkun@huawei.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 3b47865d395e)
6.11.y | Present (different SHA1: 78e981b6b725)
6.6.y | Present (different SHA1: 026af3ce08de)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  e9649129d33dc ! 1:  8e383a676fc79 KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device
    @@ Metadata
      ## Commit message ##
         KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device
     
    +    commit e9649129d33dca561305fc590a7c4ba8c3e5675a upstream.
    +
         vgic_its_save_device_tables will traverse its->device_list to
         save DTE for each device. vgic_its_restore_device_tables will
         traverse each entry of device table and check if it is valid.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

