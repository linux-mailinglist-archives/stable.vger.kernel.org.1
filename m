Return-Path: <stable+bounces-139354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6061CAA6328
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 146117AF1CA
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2AE219A76;
	Thu,  1 May 2025 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvzRgF37"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC8A1EDA2B
	for <stable@vger.kernel.org>; Thu,  1 May 2025 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125499; cv=none; b=Ctp9UIBFOsN1lQvypCdo2Spex5X2LueGgoythyGF8wkGK0A5Tx/bnlNHDT+UhqpgmogqapQIs8iilMuHkTSurdGbj7VrOGWCezdVq6W3rzQO+eU6Te6drEDSi1KUXuM7YZ/lnTH1++u5FqyOpLWa820zi3KZd5z2LEFfj5VOLTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125499; c=relaxed/simple;
	bh=GlePgCmqylC9LHQOnlugLpAIk/CJFeka9L/FLuJpYlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NqSpbjm+kpwHt2Dl4RPXleJCcriQxy07sEW3VG0uLMBRXlFyriqAvwneDuQ8sLUZAuHeoPZcOkFpjqtudC6X0niAtRXlf+SIL71kO2eo2Qdsy1PhABkkXif51OsR7sWeXGdaJd12TbL3CbjUZ3hRaDYSOnJ1fmznv5ovDs72mw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvzRgF37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5019EC4CEE3;
	Thu,  1 May 2025 18:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125498;
	bh=GlePgCmqylC9LHQOnlugLpAIk/CJFeka9L/FLuJpYlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HvzRgF373YOJ+Zy6BZ/2ytJtxgW/+tYfahuV/25TQ4g0MqI9FMWvdsAQKUVB2D63J
	 bVZRTkNG9mlgVS0OeofbvNY0F2mRMxVF9EXB9ImdC2rKKNgiFEoqKH9EFgdG9crDRV
	 ZYMCmFwsUyR4Ail6OzFXajDJzAXya8bmy8bEVaGovp0t5eUVv/LDIq0lCgw1O/JCn/
	 qqMQ0HIrxdPf4bDyKYKBs7F6OAf/VX4N/KwqXrrjyOBK5Vb2nHyUniqS4lf+l+myjz
	 A97qQlA1xM3YQaWl7JYTBhKGa7j2+2XJq3WKYXSUcfmqZCd2V1oa87G2kP+Z+fpyH4
	 pVxd0hOWmlMww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Tsoy <alexander@tsoy.me>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 5/6] Bluetooth: btusb: Add new VID/PID for WCN785x
Date: Thu,  1 May 2025 14:51:35 -0400
Message-Id: <20250501121434-b84a545ea5d6c24c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430230616.4023290-6-alexander@tsoy.me>
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

The upstream commit SHA1 provided is correct: c7629ccfa175e16bb44a60c469214e1a6051f63d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Alexander Tsoy<alexander@tsoy.me>
Commit author: Dorian Cruveiller<doriancruveiller@gmail.com>

Status in newer kernel trees:
6.14.y | Present (different SHA1: 8f67322e6990)

Note: The patch differs from the upstream commit:
---
1:  c7629ccfa175e ! 1:  5622b0e1b9ca6 Bluetooth: btusb: Add new VID/PID for WCN785x
    @@ Metadata
      ## Commit message ##
         Bluetooth: btusb: Add new VID/PID for WCN785x
     
    +    [ Upstream commit c7629ccfa175e16bb44a60c469214e1a6051f63d ]
    +
         Add VID 0489 & PID e10d for Qualcomm WCN785x USB Bluetooth chip.
     
         The information in /sys/kernel/debug/usb/devices about the Bluetooth
    @@ Commit message
     
         Signed-off-by: Dorian Cruveiller <doriancruveiller@gmail.com>
         Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    +    Signed-off-by: Alexander Tsoy <alexander@tsoy.me>
     
      ## drivers/bluetooth/btusb.c ##
     @@ drivers/bluetooth/btusb.c: static const struct usb_device_id quirks_table[] = {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

