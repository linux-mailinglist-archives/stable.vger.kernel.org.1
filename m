Return-Path: <stable+bounces-132791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E37A8AA44
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE084413FD
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B5725744B;
	Tue, 15 Apr 2025 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lp/jyKEE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2712580C2
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753405; cv=none; b=qUZzXa21ERJ2lVE8PIKoFKKzB/OVs5kPA9PjUi1Sv5eh/vP6xv04u4C6dhvE87O4r/91A+YYf6Q57w+kHSubqZ3aO+WLDk6/YiR9qnfxl7gu0YLq2nEeGKJPY5/XBfZT3P1RTaEbF6EeBlVPsfOfi+sCwFpwO+EclUFmfYNyoc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753405; c=relaxed/simple;
	bh=+iCVzmFeIIklU12S1AbxiR0VWXfW18PWPcic5r9G1hw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVN3u6bd/zrzA0StqDgPW8mD4kZyLTVsJ6pFVGLWGR8fYp//GZg3WG/bdT0sh78yvufqKbOvZBA95tMsyLVyCTAtivy9wEmTvC8/vVwyRLQwWoyAjdaKY/SyveR6/11naqOkFuSdj6acA00pO5JgLBQrYB6i6O4xxpfg7KhPxzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lp/jyKEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87F8C4CEE7;
	Tue, 15 Apr 2025 21:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753405;
	bh=+iCVzmFeIIklU12S1AbxiR0VWXfW18PWPcic5r9G1hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lp/jyKEESh0j15IY9b8LdK740+E0h/aMY8mGbJuufaMVTxaKHXdlJIwkbQg+Tf2GQ
	 /2GlQateoR4nITfJY/nH13o4BPCkqepV8vfsf+0PRf74niBMJF0awAba8Nn32YdSRc
	 wf+sJKnZq3enRY94kViUj/7sVAMPWdukt7BlsB6Ul5oE+p1yofkW0k9cUiljuGqpBf
	 79R9LncfgFYdXE/A2rITVDhYP7OoTD5IW7vHLJ19Rg1v7B+FZSoEAAra+Kp5EeEdtc
	 Gwl7GkdPZsGVmxAX9LDXjJxcpaQ49tfeknK4mVwMpbfhYWvo+qvnYhtY+h7MAQYeAO
	 IG8CRM0g6Qz7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 2/2] usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()
Date: Tue, 15 Apr 2025 17:43:23 -0400
Message-Id: <20250415131127-81dfbc8b6031488e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250415015659.312040-2-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: b0e525d7a22ea350e75e2aec22e47fcfafa4cacd

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: GONG Ruiqi<gongruiqi1@huawei.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 976544bdb40a)

Note: The patch differs from the upstream commit:
---
1:  b0e525d7a22ea < -:  ------------- usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()
-:  ------------- > 1:  4cf6fea3b1723 usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

