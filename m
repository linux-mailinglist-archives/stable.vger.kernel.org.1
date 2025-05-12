Return-Path: <stable+bounces-144046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311C3AB46B8
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 23:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB01F17DE2B
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6603D298CDB;
	Mon, 12 May 2025 21:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGT/MUNa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB70266B5C
	for <stable@vger.kernel.org>; Mon, 12 May 2025 21:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086716; cv=none; b=hzh0tA+Ta9DEiQaozo1EVYOy+9nhy8mYnTv8IdUgcYWBmoAqLu+rf/gFuvR9B5c4/ZfWCnyuC38on7A8XCwXCAuOAPh+P9g6guV1hWLeXDyUDT9Qbv27oW7MArqHt3UuVuooEzHCI4B3L+vXdKo/zN6oxSSjC9IKtDucQrXllGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086716; c=relaxed/simple;
	bh=YiTQkQ7tCCue0MN7wceWylldNmgvrxNNZAxRH1sV/SQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqkkXVBDewV9ddvrjD4C+KE1ha5R5yEBmpU3ONvH0NxbSzyAKrMw+wZcS6eraeuqC0TiRnPgHyqQsmnFtJ1D29JfSy5PbLFGSzfA4FtAMOdTU2cdR8PWg8KMEHeLo/yQHC1E5PFaETFXwdeFqpJlYsiDCZdSm5ET4wNWJjS1lKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGT/MUNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743F2C4CEE7;
	Mon, 12 May 2025 21:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747086715;
	bh=YiTQkQ7tCCue0MN7wceWylldNmgvrxNNZAxRH1sV/SQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nGT/MUNanzI6O86mBQbw4vtel2u5ZvU1FTkpzjiidgOf8syOfAvlRT0jZuLufcczl
	 pmjreZXZfGICzWgm4G8haWAlUCCo1g+xg2CpE6mWeNE2MUdyUPgDfjDjPwU9GNBVaO
	 tD9rKlKNi+SU2cNXKD/L7DnyThhIxlj5FbYZehhEgchGlKT6H+DmVWaW8a2nhgK7+O
	 3z4fRUkHS/vApapHYX+jvO0lCP0t6jHCNikqzTdgCHiBHAveelXNNF6bKOZ2NXtYJC
	 lYm1gguAEBdCvpLL1AxDI13qD7CA9AwGAigBBaJ1hEbnPCYFzHiHpmd0KTsXsHQjGb
	 mu55mL/EHp2Sg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] usb: typec: altmodes/displayport: create sysfs nodes as driver's default device attribute group
Date: Mon, 12 May 2025 17:51:52 -0400
Message-Id: <20250512160329-7cab6f207c6abdef@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512012239.3323952-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 165376f6b23e9a779850e750fb2eb06622e5a531

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: RD Babiera<rdbabiera@google.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 4a22aeac24d0)

Note: The patch differs from the upstream commit:
---
1:  165376f6b23e9 ! 1:  e6db96b46a3d1 usb: typec: altmodes/displayport: create sysfs nodes as driver's default device attribute group
    @@ Metadata
      ## Commit message ##
         usb: typec: altmodes/displayport: create sysfs nodes as driver's default device attribute group
     
    +    commit 165376f6b23e9a779850e750fb2eb06622e5a531 upstream.
    +
         The DisplayPort driver's sysfs nodes may be present to the userspace before
         typec_altmode_set_drvdata() completes in dp_altmode_probe. This means that
         a sysfs read can trigger a NULL pointer error by deferencing dp->hpd in
    @@ Commit message
         Signed-off-by: RD Babiera <rdbabiera@google.com>
         Link: https://lore.kernel.org/r/20240229001101.3889432-2-rdbabiera@google.com
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    [Minor conflict resolved due to code context change.]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/usb/typec/altmodes/displayport.c ##
    -@@ drivers/usb/typec/altmodes/displayport.c: static ssize_t hpd_show(struct device *dev, struct device_attribute *attr, char
    +@@ drivers/usb/typec/altmodes/displayport.c: static ssize_t pin_assignment_show(struct device *dev,
      }
    - static DEVICE_ATTR_RO(hpd);
    + static DEVICE_ATTR_RW(pin_assignment);
      
     -static struct attribute *dp_altmode_attrs[] = {
     +static struct attribute *displayport_attrs[] = {
      	&dev_attr_configuration.attr,
      	&dev_attr_pin_assignment.attr,
    - 	&dev_attr_hpd.attr,
      	NULL
      };
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

