Return-Path: <stable+bounces-139357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 309D0AA632B
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651CA189FFBA
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A125219A76;
	Thu,  1 May 2025 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sV7V9zbp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD882153FB
	for <stable@vger.kernel.org>; Thu,  1 May 2025 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125514; cv=none; b=plCRTWa9BFPpfD4C+YS19hUBL5BqYHuz9XnxMpPY6ITMCwho8kEii0ZrLybS9fuIxvuzFNtttvbCwVyFSytSjIBJnUWfGWGSTGRy6jArS2YuDoXywHd138YDDWnzcsk7P888s30s8MZCMIbsq9Dj1Wpxr4TBa1ubbF6yvwmRWi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125514; c=relaxed/simple;
	bh=a6unfyEB6NwPSif2mT778OG2I+Adg8if/5jd/ta+TEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOYecAHklHRWnBOYimVMZDqBRnpUIDAAFXt9XIeqQpLI5JymtKlImv9GZA2vhpkg+b3u+2a7cR4bVF2P8fdxuVVLZW23T4DTgD9hb8PWegSnWMIaWI81zAALYRSlz9n+6giC09QFXw80btzahbdURgkAi5CImJ/2aASPVRFWSpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sV7V9zbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1ADC4CEE3;
	Thu,  1 May 2025 18:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125513;
	bh=a6unfyEB6NwPSif2mT778OG2I+Adg8if/5jd/ta+TEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sV7V9zbpgkRiP5xpkX2devVycBy7oHLy2nBcNvgGkHFeHCtbgweGEBqkKUe5A0R5e
	 TD2GSBFnX8Af1MTar0o59T/GieDIeRITO++kLg+9jmm3nAtCNP0eyJfSuam+SuXxWv
	 F4G5CcwTH/QEUg8jUqkESZhUE1qiCzWwAr7Eu5oh2Fe7032eWjl0lD4Hv5Z6GbhovX
	 erv/F5xh6yW1VM78dnJcTRNmiPyT7Ht1wAv+ICXDoE2Sd5gD4ezPMv2aYArbt8DV1g
	 EZ8mbERCBZu7AY34IPz1OeyQn1E/hCRL4Y3Bnk2me46DMEMyVj0Sq01z0HVd2Zum9D
	 62hqcAOvTW+eg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Tsoy <alexander@tsoy.me>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 3/6] Bluetooth: btusb: Add one more ID 0x13d3:0x3623 for Qualcomm WCN785x
Date: Thu,  1 May 2025 14:51:48 -0400
Message-Id: <20250501120942-a858add8db3be5a3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430230616.4023290-4-alexander@tsoy.me>
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

The upstream commit SHA1 provided is correct: e69bcffce21c649a23645b20eb527b3d1ce6fc49

WARNING: Author mismatch between patch and upstream commit:
Backport author: Alexander Tsoy<alexander@tsoy.me>
Commit author: Zijun Hu<quic_zijuhu@quicinc.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  e69bcffce21c6 ! 1:  bb9c50e294220 Bluetooth: btusb: Add one more ID 0x13d3:0x3623 for Qualcomm WCN785x
    @@ Metadata
      ## Commit message ##
         Bluetooth: btusb: Add one more ID 0x13d3:0x3623 for Qualcomm WCN785x
     
    +    [ Upstream commit e69bcffce21c649a23645b20eb527b3d1ce6fc49 ]
    +
         Add one more part with ID (0x13d3, 0x3623) to usb_device_id table for
         Qualcomm WCN785x, and its device info from /sys/kernel/debug/usb/devices
         is shown below:
    @@ Commit message
     
         Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
         Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    +    Signed-off-by: Alexander Tsoy <alexander@tsoy.me>
     
      ## drivers/bluetooth/btusb.c ##
     @@ drivers/bluetooth/btusb.c: static const struct usb_device_id quirks_table[] = {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

