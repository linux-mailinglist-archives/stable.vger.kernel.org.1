Return-Path: <stable+bounces-98326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E019E4021
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29E3167586
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFC120D4F7;
	Wed,  4 Dec 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqkyvMKD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF0920D4ED
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331195; cv=none; b=e4zyrpTepB2naemXHbvoJWaTq7qM62dJdoxUne2acu2tFLG01nwYle8Kq+Mzwdn87kYUPzvCg0xFK8np3auwwx/EmmQ73utfiiQ55vthOB61FxSNw5Gr0RhTTlac+CpJ5Ji0PNLAGoiKZCyPsbeS7DSLlqwMGgAgZEq9V5aR/xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331195; c=relaxed/simple;
	bh=yfiVbh6++3g9a/iK3qpK0ELDU4TCwD5+PTtLby3uTes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROZNDzYLrL+MsKCWjY0124zR8HMZvgctGGkSNJ8G+URLf3ENX3ad+la3zZzv4brSeFDwn/CmD38MM/pw4Ua7ma7+0EHyjXudGm//IbjV9+/enTm2AC8UeXSjDW6KRUQA25qTP9c285rwHWVxsL1a3Bm0xyMmYkbcbXYGxxu2PS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqkyvMKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF7EC4CED6;
	Wed,  4 Dec 2024 16:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331195;
	bh=yfiVbh6++3g9a/iK3qpK0ELDU4TCwD5+PTtLby3uTes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LqkyvMKD7PJmezAG0wqRxDWnT+U1PkiSrtwaF3cYg8PsAbHnIwuc4rCWskTjE5I8e
	 MB+aX+lzNvqiwyKYEpqTjEzVCmaYg73KYJ/wsMikSthxgP2mLE1wfOIZsMDcpgbLwm
	 pV3dJiJIx0K7pJ7lklFv4rlvakcZD0HjoloKNspNyrECKgPQXktT7JM/qBpdwsciHH
	 e+0qZfC0uLQsPsip4a9yHxSW9r/RfJBW5z8XpVYTBFb0UhchY8gTO2IItLRPYpKde2
	 bCM7bDfUcYN3JxrhyUmPdgu7vsHAs07Te915cmnXh5J+TaL1qunLLUNVRHwLrmifvS
	 7SU0izvXBTtnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Zekun <zhangzekun11@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10] Revert "drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()"
Date: Wed,  4 Dec 2024 10:41:55 -0500
Message-ID: <20241204071451-3923f78cfc9a5645@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204082356.1048-1-zhangzekun11@huawei.com>
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

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

