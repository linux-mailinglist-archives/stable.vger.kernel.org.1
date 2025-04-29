Return-Path: <stable+bounces-137073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 151F2AA0C13
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FD61B65DE5
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7029F2C2593;
	Tue, 29 Apr 2025 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOiX/trt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3139C1519BF
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931007; cv=none; b=oMPRT5F5N9v+UjmnhyzgZK/90Uap8pCv03+u6C1dEH3RZyW4xEEJIkgQwve3eojCB5KNqpnYJOAS87gIhPY2ChlRnKzIU2FgGj4FA3dC5ZSCU+MW+bMvLrIqVYkn0p2ACBw0rmcxROZcrJxXQ+anEGLgCywAor9UprVkNtbKmtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931007; c=relaxed/simple;
	bh=s9wnOChKwl2haq0vfaGByIGBULP9KgkjyV7U0WFBlk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1p9146lqU5xklujAUj/B9l+4jAJkmmdtlFnFM0bmYC7Pd862RRdhaovtfLCvRflsAeY/5s2e1gaGvQ7rVJmQAT/XfKq7K9CckhPdpHD46LUHiaU2fHQzc0isuNwlm/9hUODiwxJ5R+3sTKKEtUfSw4RdvIJjBasslNYBei3y0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOiX/trt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC93C4CEE3;
	Tue, 29 Apr 2025 12:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931006;
	bh=s9wnOChKwl2haq0vfaGByIGBULP9KgkjyV7U0WFBlk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mOiX/trtSgAn3pfk9C3L6irViyJT2UOrEAx2JeaYHQjc8lyEUodZjSYs/nFrOWA5v
	 3oJkslPd2ueDoWFJ2geifa+kx3w+Wb8gy5lKIJSMV6d8yHxxBccvRFQFVgMEKZKJ43
	 yHLljvDEx0qFOxYDSdI4OwTA3vnGilUx9f+NTXgmlbsB5+G2bg24JalRITL1fYGG7h
	 geLXiS5Gs7MBPHUPavzde+FJmFttDd+c371/OtaA5s20q8kHN9dWsli2JJ+CEZXrCt
	 PDLnB5grxYazEm9GUjIAPJf79J3hCkd4YSBfzXuUy9WP2Mi7hVPl76fs4dHKIA4Mf3
	 F9RWjf073ooEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 5/5] net: dsa: mv88e6xxx: enable STU methods for 6320 family
Date: Tue, 29 Apr 2025 08:50:02 -0400
Message-Id: <20250428220905-be06787afa8e80c8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428075813.530-5-kabel@kernel.org>
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

The upstream commit SHA1 provided is correct: 1428a6109b20e356188c3fb027bdb7998cc2fb98

Status in newer kernel trees:
6.14.y | Present (different SHA1: 1864c8b85c76)

Note: The patch differs from the upstream commit:
---
1:  1428a6109b20e < -:  ------------- net: dsa: mv88e6xxx: enable STU methods for 6320 family
-:  ------------- > 1:  e7966367c7c75 net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

