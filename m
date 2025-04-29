Return-Path: <stable+bounces-137090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F1CAA0CA2
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 15:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1156E3BE4B5
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 13:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C10E2C2567;
	Tue, 29 Apr 2025 13:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqsJxv5f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05CF3987D
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931676; cv=none; b=LrV1xOyPtAn2MZ1zQmIBTzaZtrHPvBQgopmbZ0NYmNeWa2esIB9dKcQmTnypXDs0vgrPN/OVXv4FjzTYByo92Ft9cefxYXYXvITRoSikl/m8WbeXTD4jHPvWBvQ9S1XBPYthkMCpKxsWPr92mCM/TncpaRVpmDROFoWzrK+jZHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931676; c=relaxed/simple;
	bh=y7kcJ0iGEMsdwBdU7wJ/vDrZ1l4g1JSm/N6woWBIEcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/YNUn76BGqlTYkN2CrTVDoiSHXRtfTGaq1eS0WArlj2Wb4lJ8YHx/Ues+0ah6BLQyzixQvS97Dr/SQQR3idc/TmlL07Y9pjsGpMZ4Ir/66pfmbqtnh08kHmLDeEZV3B4i7jPy273E95R+318g9I1wYEpt8TVvTgnHOEiqQSaLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqsJxv5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9B7C4CEE3;
	Tue, 29 Apr 2025 13:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931675;
	bh=y7kcJ0iGEMsdwBdU7wJ/vDrZ1l4g1JSm/N6woWBIEcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TqsJxv5fQyLTaQrw5EOEEyLnuYpJLnusmkKguIsEi57NUp3633c1smf4j+wT+QeJ5
	 55vFOtmd5deNGoA+fNKz9zdxvibIJBkhykuIhD0kdFCXiMNCNx3x5qUQlY3QrPOUWZ
	 35c/wPP1dOeo2A6XM8qlme9QQ5fERHJsKo1a5I2NZLlCVhyd1NT7tMgWfA0mfTfuUI
	 YSAScDTHw6CXgt+FEesPSW2FFUm2q6c9dlXhb827iUppMmwc6ZY768zcSGIBDyJvtG
	 N5rbQ7nz6E1BopFR4hAOtbi9/3FdmuY5xyPwlhx/ROD2oi6u4OK1JL74HipOoH1ZIm
	 MWgfDdvw+1NRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 2/3] net: dsa: mv88e6xxx: enable PVT for 6321 switch
Date: Tue, 29 Apr 2025 09:01:12 -0400
Message-Id: <20250428224708-0fd3025bea0f2893@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428085744.19762-2-kabel@kernel.org>
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

The upstream commit SHA1 provided is correct: f85c69369854a43af2c5d3b3896da0908d713133

Status in newer kernel trees:
6.14.y | Present (different SHA1: 7eb13e5b4615)
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f85c69369854a < -:  ------------- net: dsa: mv88e6xxx: enable PVT for 6321 switch
-:  ------------- > 1:  38e5dff6d5607 net: dsa: mv88e6xxx: enable PVT for 6321 switch
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

