Return-Path: <stable+bounces-139382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0EFAA6394
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 873907B3B79
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B78224AE8;
	Thu,  1 May 2025 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjnATyxZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8142B1E260A
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126704; cv=none; b=A1WqjdYvK+JgOi/DjQaRoFi1GedcPWMvQtmoYQy0Eu+1FxGAKiWIZelxEhQHnKbXL+GOOLage5WO7bLVRf63NXwxSEB54Qu1Z2nkaiVNh2AN7QKgzNTi5C3ZV0CYNBMP+SGp8f3WcEWaNjhT1HOfXHTdDnrUBIn5FdJuDXTk4oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126704; c=relaxed/simple;
	bh=YYgu6W7TSNsRFnONi83qnFqvi0B7/WLPAs4yU6WAyN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kggw4E3Mv2deBHeRCCrt5ltuikRDRYtlH3ZfKnzRInqGBx7vr04862kSHUIXmP7PCC83pJZVPRqMeQ57NjRT6uxeGD/zZax7sO/T8LQy18bnajZ148icU6raE9Qkw3mGp3Q5VDVH4TifEGFuOMO74C6O+QpbwiTvolKiKY+53rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjnATyxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDBFC4CEE9;
	Thu,  1 May 2025 19:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126703;
	bh=YYgu6W7TSNsRFnONi83qnFqvi0B7/WLPAs4yU6WAyN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AjnATyxZ2QyV2tpjj8DM/tfHFWaS+n/MEQFxKuMmhwrVlPI+Ib55SEGbP13OOUnX/
	 nK8Qxzv1snFM9rTgPcsFWLOsCUYl2Peu+h6PG33bfK6gvwvsxmXkYuRNg7ftz1zSVc
	 tLZ3zre6119diBh4XhDa10sdVKCzI6x0RmrQK4SDlPu0VM3n5DRWo8qzKIkUeK/Mwm
	 LL8K1ilHOqwLDISuL49ip05mFbZ8vX1WomNbWHklLbix/ihKt99/cplRuFBVZ9wXGe
	 OBrv7uPPx2hkqkPpoMUchSaJ2tkGCe3Z5z/XB67p5nw0sR0u43bgndss5IfZAOvMf+
	 3bf89IXYzWJSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Tsoy <alexander@tsoy.me>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 4/6] Bluetooth: btusb: Add ID 0x2c7c:0x0130 for Qualcomm WCN785x
Date: Thu,  1 May 2025 15:11:39 -0400
Message-Id: <20250501121206-06087900d937abd8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430230616.4023290-5-alexander@tsoy.me>
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

The upstream commit SHA1 provided is correct: a6587d7ed2cd8341f8a92112ac772f2c44f09824

WARNING: Author mismatch between patch and upstream commit:
Backport author: Alexander Tsoy<alexander@tsoy.me>
Commit author: Mark Dietzer<git@doridian.net>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  a6587d7ed2cd8 ! 1:  88557b8326c56 Bluetooth: btusb: Add ID 0x2c7c:0x0130 for Qualcomm WCN785x
    @@ Metadata
      ## Commit message ##
         Bluetooth: btusb: Add ID 0x2c7c:0x0130 for Qualcomm WCN785x
     
    +    [ Upstream commit a6587d7ed2cd8341f8a92112ac772f2c44f09824 ]
    +
         Adds a new entry with VID 0x2c7c and PID 0x0130 to the btusb quirks table as it uses a Qualcomm WCN785x chipset
     
         The device information from /sys/kernel/debug/usb/devices is provided below:
    @@ Commit message
     
         Signed-off-by: Mark Dietzer <git@doridian.net>
         Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    +    Signed-off-by: Alexander Tsoy <alexander@tsoy.me>
     
      ## drivers/bluetooth/btusb.c ##
     @@ drivers/bluetooth/btusb.c: static const struct usb_device_id quirks_table[] = {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

