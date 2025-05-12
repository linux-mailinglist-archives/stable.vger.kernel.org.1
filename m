Return-Path: <stable+bounces-144055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4ADAB46C7
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 23:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90251B40A0E
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B14F299A98;
	Mon, 12 May 2025 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cp2XCpd1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1BC299A9E
	for <stable@vger.kernel.org>; Mon, 12 May 2025 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086756; cv=none; b=RoF6scDlvmqnh5tp7TfEwfOyFKTMMYKvoJ7ZWuLYWx2kAzcY+FJj+rmEh27dIADntD/GZdz1K/Mevp0i6xux2XL2xbsTO9kQ1E6hXWTM7gRdgtdEgJeFje9x7u8oYH7ZKGXFnC6i8+dBSyNJQ5MWDp5C3HWDKdrNCL0fWznAeNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086756; c=relaxed/simple;
	bh=KvgpMgZuDl6Cvg3J/eq4mNCzpCY8vZRx8JdMyeV5xO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTKjZKBQvD8qgy2WePhwMrIeByz/ooRekc1SV980FjFFXb1LhqbwTyjYUDUerKh8hBGYPTLfdU490QXTOiAXZAYxx9eqTk1NzSrwTm8Pk4WvIcsq63NGm+7gcZFFyy3UiVM9I8Pu0bp0Y4WKZvjmVhF8Ll/akkeajf6nFo4JQlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cp2XCpd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7D3C4CEE7;
	Mon, 12 May 2025 21:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747086756;
	bh=KvgpMgZuDl6Cvg3J/eq4mNCzpCY8vZRx8JdMyeV5xO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cp2XCpd1SH5pHJcmiomamoqHUSYcjxGH4I+58CsjTQY4lFLTlZ5fbleJ/Cj6M3so2
	 YOML/WIK29TN9OzpGGgKgjisHvAJmek2dFLgwuHIyvKDGwGqTtNkft96szblXe3tIy
	 MQwGktRkunI5WXRN/F+onLOSHvbZsP1Yj28yKubNTSBzmsaxEO5ltt+4nfXFNa9rQ1
	 KsL7zTd0mEA5kU2h7/XPXknt5djtZoAMFo0EAtPiPOKLI4IubpXseUaDJgYOjBhbi8
	 GSnVUnE01pdmB5ROZVAZBFLiLPTM9Z5DgnxsdOrp6kDEYwpEvKn2eFgRiU6e7ov1Xm
	 wQgN/4fyk42Cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] usb: typec: altmodes/displayport: create sysfs nodes as driver's default device attribute group
Date: Mon, 12 May 2025 17:52:32 -0400
Message-Id: <20250512162223-1a8b67f218388c6d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512013644.3325607-1-jianqi.ren.cn@windriver.com>
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
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  165376f6b23e9 ! 1:  6af9e8edcdf8e usb: typec: altmodes/displayport: create sysfs nodes as driver's default device attribute group
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
| stable/linux-5.10.y       |  Success    |  Success   |

