Return-Path: <stable+bounces-154761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5317CAE012E
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE213AB6D5
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C380C27F756;
	Thu, 19 Jun 2025 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BETwttR5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818AF27F73A
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323768; cv=none; b=Vjgnpr2vhx8KQK6Z4WJhD4CV+LXcOEUuJgJGaoU6zogDmvtLd8ZdO5VDEQO6YBLWIN+cIxeMgkSL2APU36vZ0aX4MMMVUYjwuuUHbMA8cSjGoMkcDUI2rwyCyl3KojflXMv/KhU8HuUdp/fHw8y57/Xlu9E9Sv/iw4vMOX2asv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323768; c=relaxed/simple;
	bh=uWNjjgAClkhFUZ1py2ltsFl4SM13e69EOHch3MeMo2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fH4e8TZZwhRMt0HXzYWf4d6haBvVi/KTtB6bwtw81bXxTCbexcfsXYD2FjyLsKCW4Yer4l73wEsTbLvL1uD+soxrU3d3tQ2o1xF+viD/4KOHfpKTC/YGmSDZEDBGSGb64Qck7GT/6OD097kGP5Kgf7S6K8wPQ43MW5ttQKoNaK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BETwttR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC7DC4CEEA;
	Thu, 19 Jun 2025 09:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323768;
	bh=uWNjjgAClkhFUZ1py2ltsFl4SM13e69EOHch3MeMo2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BETwttR53yRwVRXPKqhM2RVhhwqIgZrELt3OlT5CHkxRo/cEfZwCMXkA+7YVVuN2B
	 gl2PP9A2ZHK5KemWXRoD0OqIXfLsFXF4RiS1LabanljsO3hNrxQocXV6S0gQ+T+P4x
	 iB9fAydNHbMd6kEEVzRxmaUimczVODlbzzg7ln1twbRh/1Yd9Uhcxcoa4+DWAHe5A0
	 7r2NwMV8gnr6Krb/ZIG62upocRaArfCfXBWBqlRiz09AcGEYNTLOi8HKLr/d6APfuQ
	 CgCRbCkHWCcErEcwU5yi4FxNbsbbu7Wh0kiA9qNWxZRO0TZLuLcK84EGKnk3e7PK/1
	 jbGQdy4dBlLNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paul Chaignon <paul.chaignon@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.10,5.15 2/2] bpf: Fix L4 csum update on IPv6 in CHECKSUM_COMPLETE
Date: Thu, 19 Jun 2025 05:02:46 -0400
Message-Id: <20250618141007-b3db4a0bbd6a9834@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <2ce92c476e4acba76002b69ad71093c5f8a681c6.1750171422.git.paul.chaignon@gmail.com>
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

The upstream commit SHA1 provided is correct: ead7f9b8de65632ef8060b84b0c55049a33cfea1

Status in newer kernel trees:
6.15.y | Present (different SHA1: 147c9e7472c9)
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ead7f9b8de656 < -:  ------------- bpf: Fix L4 csum update on IPv6 in CHECKSUM_COMPLETE
-:  ------------- > 1:  ac4f00b960a0e net: Fix checksum update for ILA adj-transport
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

