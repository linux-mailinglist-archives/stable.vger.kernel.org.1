Return-Path: <stable+bounces-144043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8473AB46BA
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 23:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D08D3B1CD4
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC9C299951;
	Mon, 12 May 2025 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEAgzwsz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC08259C9F
	for <stable@vger.kernel.org>; Mon, 12 May 2025 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086704; cv=none; b=uM9lM3+C/Wh6UDljk2w630Pwb9JHtHc/Yqkfs11hqn1daUE1ZqC+CpuA3HCDhTlnLWytWt9KtZ2lRRp81KFjA0tkxgdn19+kD4Wed8h6ZI7NxKK+eptJSJVR+KUAXwMiR39FUkpk4AF6hIoEvoCQ4pwsWlK8oIvZfMYI24u9xFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086704; c=relaxed/simple;
	bh=GXn+CWBIOmCeYXzSjVvq3ykqlZevqiHd0VBXWyZ/tt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ca/m7p5LNQCbybtkpSuPub/t5zEdhQcv2Z1cKFnlavEiMRNVVOeny0YJriDonf4bJSPZh5qz0P6hAKkhHgCUc6HmPEvLJUKn3x3Uh9R/p8wbJnPEonNSJ8bQNvjyIHB4CHH6YomxBGNBF62AFDvsc3lavGc+dh+GJVktGLTkcIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEAgzwsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A6FC4CEE7;
	Mon, 12 May 2025 21:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747086703;
	bh=GXn+CWBIOmCeYXzSjVvq3ykqlZevqiHd0VBXWyZ/tt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tEAgzwszDO9NxnngC4wgkFooZyCLRuwSWGMD75nLkPggXe4X3n/oAcFi2+vImgQob
	 hYdI08VYrFXDWXGIqTUyJLp2aIx8RQoORnnb5vq1ioRUEL+C1DLu6rCj91pvktcWuw
	 8l7cpyl4TLnuYEykf3F9HIquuN89ZcVeIeBR4gEANTLJPAo/AYVnQGFQX71U6l5T2P
	 /WieEnpki3xsCmvmc9YnF4Okw802frjpz/LT0vPTjaMUcAXK3LxnuPNb3IXU4rmMoD
	 gKI5UNGJGw/gIdybEfRMpUv+cWNOvgkDDY2geGvvU1KPlMtvctkfS06XtjdzUZ3r2j
	 oK8Nvfc2GIs2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] usb: typec: altmodes/displayport: create sysfs nodes as driver's default device attribute group
Date: Mon, 12 May 2025 17:51:39 -0400
Message-Id: <20250512164131-bcbf4479f4b1b0c2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512013213.3325252-1-jianqi.ren.cn@windriver.com>
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

Note: The patch differs from the upstream commit:
---
1:  165376f6b23e9 ! 1:  3510a18e8899b usb: typec: altmodes/displayport: create sysfs nodes as driver's default device attribute group
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
      
    @@ drivers/usb/typec/altmodes/displayport.c: static ssize_t hpd_show(struct device
      };
      
      int dp_altmode_probe(struct typec_altmode *alt)
    -@@ drivers/usb/typec/altmodes/displayport.c: int dp_altmode_probe(struct typec_altmode *alt)
    + {
      	const struct typec_altmode *port = typec_altmode_get_partner(alt);
    - 	struct fwnode_handle *fwnode;
      	struct dp_altmode *dp;
     -	int ret;
      
    @@ drivers/usb/typec/altmodes/displayport.c: void dp_altmode_remove(struct typec_al
      
     -	sysfs_remove_group(&alt->dev.kobj, &dp_altmode_group);
      	cancel_work_sync(&dp->work);
    - 
    - 	if (dp->connector_fwnode) {
    + }
    + EXPORT_SYMBOL_GPL(dp_altmode_remove);
     @@ drivers/usb/typec/altmodes/displayport.c: static struct typec_altmode_driver dp_altmode_driver = {
      	.driver = {
      		.name = "typec_displayport",
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

