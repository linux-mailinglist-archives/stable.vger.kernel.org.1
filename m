Return-Path: <stable+bounces-98588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E279E48BB
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182B8166FB4
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2701F03DB;
	Wed,  4 Dec 2024 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDHWShZv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A58C19DFB4
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354605; cv=none; b=eXgUMyTnfQaMPb0VNc5aeIGE1Pr88DtDMWlqRXQAf6E4kGXn7a01bBKHFpKp7YVaKifkrKev/esmlRyxUkuwoX3OHU0v+S5LPGRIRIEd5bV+SRWC4IeTmCSPOzQK/2X50wKbPw+m5X2zITzsaPubXOKQIWMt+qKN3hpXKS3AweI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354605; c=relaxed/simple;
	bh=mcrkW3YdntQSGWV64YVn+dYEZ3UyK+HX0E0SSACnLDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpuM2CKmbBSC1NL/TxzIJe+mHdT9jCdCq9Vx4TMH0LhxGOK+6M/RmrnoQR8ROHtwfvKLjFR3t8LuCO32DrrMOytEV4Rcbyhl6FmD9VxsNDJy3H05xsTTkdlUrABdBrk7Z1BkYJUfbBdZjTr8ZOVLvy53GgHbWitWHAvel9ntATk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDHWShZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94424C4CECD;
	Wed,  4 Dec 2024 23:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354605;
	bh=mcrkW3YdntQSGWV64YVn+dYEZ3UyK+HX0E0SSACnLDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jDHWShZvbGMdwqvTCbongoKwrTNHGRTvfacCG7emXofwcWaP1Ugu5juHim7i74WaN
	 Wt8UE3j7uW2PotSsINOTS+s1iDaaahHCoMm54O55Bc897MlShRjEDy+qbs2eJUK/Hg
	 rm3eJ8Z4ZLeD/QSJcmF6r5eQLukTYR0npwKZwwvuAa3AgXW8efqNm8RYfolm0zRCz5
	 fQB9aAH3Zc2XG4/FVWPr04Mas+ZTtC7MyxLhaeajSnMb5YJzixjpzPpvBTBzDgka2p
	 abtkB0eGXDTLKNHNsI7eJgNeaDsRhEMb34b8mn8OR4xz+0fhtIAiAGQW9GWPc+pXSd
	 OnpuMCCYGaKYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jing Zhang <jingzhangos@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 2/3] KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device
Date: Wed,  4 Dec 2024 17:12:05 -0500
Message-ID: <20241204160044-ec4baf54d7347a1e@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204202357.2718096-2-jingzhangos@google.com>
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

Note: The patch differs from the upstream commit:
---
1:  e9649129d33dc ! 1:  cfcfd1df25f8d KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device
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
| stable/linux-6.1.y        |  Success    |  Success   |

