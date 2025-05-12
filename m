Return-Path: <stable+bounces-143833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A13AB41F5
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4983168D19
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E870429DB95;
	Mon, 12 May 2025 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejJCUXqq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A656D29DB8C
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073106; cv=none; b=oW9tqj4ud1pNY3mhKR8/9ziyf9aVOPxpnoD2bKiqL+clMW04X0TOEKVWf/ir2SefF2SY6bMiRF61PPo2CA8Vt1Tc0wkeZYdk5JGhcjkn3LtCmFwa1vgtlQ/wKAYV860UKQGmXEpTNUWeNCpnJOcR1lHap6pmzrwXZmF19UEQpCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073106; c=relaxed/simple;
	bh=tPR/WWRZJSEtM7MBh0fqaeM5e5Y8SmAAjm2iw8AkWLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjLqeJebl4eiVw3iRnIxYVM+RaTO/5pCh9ejJnU3yjmgRC5SKqtUCgpQe2is1oHx5YYN1aSVnji5r6XY+lnaqFj/mtkPewEQnFIirPC2gBMwXkrjWo/H6PdUyMevPw5Rvyr0uISOzpmxlSyPWgmUY5ttTVbSniIRjezHU4PHONw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejJCUXqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD2DC4CEE7;
	Mon, 12 May 2025 18:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073106;
	bh=tPR/WWRZJSEtM7MBh0fqaeM5e5Y8SmAAjm2iw8AkWLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ejJCUXqqyANRSlrPwF7UMHugLqUltCp48kl93BjV/u52jO0dHb7g9GLy4ss1wSLQF
	 uSqh2kNX1kOUXxnhX8TdJzijbJ3VAG6ziqb/7QWWgaIERSYF462uCNBs93Cw31YYVA
	 TCbJ6z5zg0nI9tjukszEwsj51gXegEXa5eP9xvWwDzkml1GttGYjhXhHnSpjqbANGA
	 tCSFv58DMx+zHdd9T27bCtHo6YXBSqRrGQU5e0YDv+pufupKKGR1O9MkJxiubokhuH
	 URjBdj2VRR4Ply0NJr8T7mkcnye8suJ1tU21KvTfJNmyaFHrVcGP75VQTT5/t5du05
	 6345NEWFn/FtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 2/2] usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()
Date: Mon, 12 May 2025 14:05:03 -0400
Message-Id: <20250511204127-97ea154870caccf9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509062802.481959-2-bin.lan.cn@windriver.com>
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
6.12.y | Present (different SHA1: 976544bdb40a)
6.6.y | Present (different SHA1: e8336d3c9ab7)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  b0e525d7a22ea < -:  ------------- usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()
-:  ------------- > 1:  e59f2a21c85ab usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

