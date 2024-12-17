Return-Path: <stable+bounces-104486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502119F4B54
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 13:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5341C7A1DFB
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 12:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB701F131A;
	Tue, 17 Dec 2024 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1ryvN38"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB151F03DE
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440129; cv=none; b=mA0LuJ3X3nk+g1Xc/7DcBlzoAckWB13eblM7rRRExJMtiOjcDgZgKEzcohl7cbvssh8Xcx421qi6M+omq+whYy69bt3K0tF3GzUSSEW7LQIBirZ+04e9rrjA7KWL2oPMkLgNqhkRLs1vYv5CwrEsraBjYy2B+W8aEUyb2D3MpmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440129; c=relaxed/simple;
	bh=EaVsuX+NBs2LV/INqZgrxZLwMwXECbx+jY19izrvjZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YubQ2dJVnRo5/tjeHvdt3Wm2G8Pqu2hfa9Q9VltlcY2yuW6yhYaWmiyNt8MzQJ7m1G6nc2YhN2dTTJU96uJ01MVh3v31xqbPyFdzJMw7+A9Gog2LKRfmKqBKTcqtFeHsA49jdy0Nw6J3pxLt3gnTK/FTPnUPU1n6ddrnEqUMbNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1ryvN38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91028C4CED3;
	Tue, 17 Dec 2024 12:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734440129;
	bh=EaVsuX+NBs2LV/INqZgrxZLwMwXECbx+jY19izrvjZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a1ryvN38AwadADvzkwAsZtvesSzqVkLz94X6V6tnhgecV/GA9w392RHKZcG+V2es1
	 gNwv8/rGeFydo4PmDPE3hdPfiyYbitWBQY6UINh3UHiIqxP+jVJrFJEok9fUMzjQaj
	 dO6r26PxM0XA3PDk1qAbcHdWzVWHw+8TkdMfBK4o+P+2IR+e3PUMp6ueFyNJhX1TsN
	 QKNmlyl14wcu7/GywyQ2ybXExM9lnN+W8QCNC1+I4RQxr4iJdQToV/p4LCv8b6pZyV
	 4p5vzK4bfnFN6c1OSA5wzzyuw1WoqovMVGpVw0PvUIHfhuq5K2gznYXfVBUef9CtlV
	 xA1ng9szAvABQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 6.1 5.15 5.10] bpf: sync_linked_regs() must preserve subreg_def
Date: Tue, 17 Dec 2024 07:55:27 -0500
Message-Id: <20241217070333-49f4fc28e7f0fe11@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241217050005.33680-1-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: e9bd9c498cb0f5843996dbe5cbce7a1836a83c70

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Commit author: Eduard Zingerman <eddyz87@gmail.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  e9bd9c498cb0 < -:  ------------ bpf: sync_linked_regs() must preserve subreg_def
-:  ------------ > 1:  de6256c869f3 bpf: sync_linked_regs() must preserve subreg_def
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |

