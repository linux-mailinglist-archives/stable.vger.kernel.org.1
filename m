Return-Path: <stable+bounces-139351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37415AA6325
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E91C57AEB2C
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B032236FC;
	Thu,  1 May 2025 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8AM+0XB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EC1223316
	for <stable@vger.kernel.org>; Thu,  1 May 2025 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125485; cv=none; b=g3Zee2kfnZbqL1fxSvnK9JV0cTXD6Yb/rc9Oc4NDrFxwO5o948K1IBOLxXhw90r8L1Wu/l6jNE8f4QefPpqg9rWyaWfxrcE7a8IOXKp3pLH5uxFalw8DqMEM/3T5tBuOPMrypdfVlU/nKvrPyHQ1ljVyIoSi193dt4pt/DNvx6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125485; c=relaxed/simple;
	bh=TLoQvvCtciRBa4dLrkAeA1MdMmxAf1zyE9QB7RQuhYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SFRBvm+/ZhHYKlK2YEgTz8JTRA4yX9hgAX8EETBC1uFrPNHPd8ibPWxfhvV9feEOcFg4RKoSuaRsPFfgMKaUmbj7GZ6a08Oeyc3OVXKnhHi/3WCPt8sxXhxP1kbX7hJrlbijfh4C+meKZT/ZG8wb0U5j0PX40o2P47mWyNizBHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8AM+0XB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EA0C4CEE3;
	Thu,  1 May 2025 18:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125485;
	bh=TLoQvvCtciRBa4dLrkAeA1MdMmxAf1zyE9QB7RQuhYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U8AM+0XBh7OrTxpQmMqBsb5oc6x7xv4CW/kyHL3um3BmC7mEdOuk9mlk0TxNOEEbj
	 fCGSZ9833zguw4Pt18SKxhtiC9c6+a9JxIi2VH2S2FK1mvCCdIg4pB1qEPsQ1p8jka
	 zd4qbIdiwsXmRdP/x46wGDoUYrKfktOnnmx95twEkzCFyBfH6hcPi/dOXkm+ZmfJlY
	 r0bHyjDKN4LRo8/SIcTSdR0JV6KymCj7AgBMJrvIRb9bB2+wueilhmVdPl7eRG+jfs
	 gRhr2p+a3gmnudiYPs7ehhg/xVKFxzYDGKAPlWQu9dNw6VWygchd97OrxgNHpiktFW
	 YcS2bWfLxwQQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] comedi: jr3_pci: Fix synchronous deletion of timer
Date: Thu,  1 May 2025 14:51:21 -0400
Message-Id: <20250501072008-be567c25f36298ad@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250429123806.532340-1-abbotti@mev.co.uk>
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

The upstream commit SHA1 provided is correct: 44d9b3f584c59a606b521e7274e658d5b866c699

Status in newer kernel trees:
6.14.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  44d9b3f584c59 < -:  ------------- comedi: jr3_pci: Fix synchronous deletion of timer
-:  ------------- > 1:  0cd4caf40f329 comedi: jr3_pci: Fix synchronous deletion of timer
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

