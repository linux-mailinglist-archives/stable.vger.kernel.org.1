Return-Path: <stable+bounces-139361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3730EAA6379
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65EA3AE617
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCAA224AE8;
	Thu,  1 May 2025 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShgkZ7w5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09B32248A0
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126561; cv=none; b=MaBeewDl+8SXHrzTcCocR8HGWpPlxd7qn0+CH9fAH4XelQYjQxq/RwO0jbG3cZy8ii4odQ97bK3mapCzt/UpvSDhT68dnaBKDSPOaLwKHkxQc9WrKXWgkIR4V42SmfCO/oquA5aFjJJkOu9vUHsoSaruRysT5WT5/l7uYk5GYpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126561; c=relaxed/simple;
	bh=MOrA6SJn3BfrBh6xTXhMLnpN9PXHUy56tSyXwqc2dCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6WgqpLDKVtB+XUOaq5iwRcPTlMuEhlh17BAF/xAvTyZl28xOi/2e56VLf1FSSuCIVz/JjxmYxKTloW/dNRyxGW3uqg9QNu6zazHJMZTBdjGMVpU/aQzJtGUsxAia1mq05wc8Km5OU8AsUG3rx6y+iEJrBvTXS0bHzr8et3gmck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShgkZ7w5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5AFC4CEE3;
	Thu,  1 May 2025 19:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126561;
	bh=MOrA6SJn3BfrBh6xTXhMLnpN9PXHUy56tSyXwqc2dCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ShgkZ7w57LGHC0Ipe/6uS16Y5TaxHvSSRbi/yAkrwG15PrFGHprj1RNV+g6uSrCCl
	 QSeZNKRTI4wp1FDzFb+GE800+jq+4nKugIhwTpqlbksKG9phjtlwZlHJBu3EpeQK7q
	 LecU1aK9crQ0q9zURCbYjUzflPjcE1lVDhZ3qIqg10C+D6yD+7w1vzGyb2qMzqKPZS
	 LDEbiV1sbxJXKpKEWtjX8zaYXfdcONReOOuCvqgYm6KOgJkLgvL9zDr9vJih1BMvKf
	 fO/tH27ltE1bFKuDkiCZw81AxUvhAlT5+6pBABSbvf/MxxQRBn6QQC+hhIB1HzKWUc
	 IMMPuQBMGt6nQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Tsoy <alexander@tsoy.me>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 2/6] Bluetooth: btusb: Add one more ID 0x0489:0xe0f3 for Qualcomm WCN785x
Date: Thu,  1 May 2025 15:09:15 -0400
Message-Id: <20250501120718-e7b743936fbdca6f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430230616.4023290-3-alexander@tsoy.me>
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

The upstream commit SHA1 provided is correct: 45f745dd1ac880ce299c0f92b874cda090ddade6

WARNING: Author mismatch between patch and upstream commit:
Backport author: Alexander Tsoy<alexander@tsoy.me>
Commit author: Zijun Hu<quic_zijuhu@quicinc.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  45f745dd1ac88 ! 1:  338961172221b Bluetooth: btusb: Add one more ID 0x0489:0xe0f3 for Qualcomm WCN785x
    @@ Metadata
      ## Commit message ##
         Bluetooth: btusb: Add one more ID 0x0489:0xe0f3 for Qualcomm WCN785x
     
    +    [ Upstream commit 45f745dd1ac880ce299c0f92b874cda090ddade6 ]
    +
         Add one more part with ID (0x0489, 0xe0f3) to usb_device_id table for
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

