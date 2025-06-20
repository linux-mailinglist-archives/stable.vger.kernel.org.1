Return-Path: <stable+bounces-154852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0597CAE1118
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 04:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF8119E26A8
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 02:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782D713B788;
	Fri, 20 Jun 2025 02:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wkq20aa8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DF9137C37
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 02:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750386304; cv=none; b=AOGp+S5NPctCJUcN6DLLytzHhj+axzrkNyMGc0Kc0AFTwtT+hXe2JeZ9DJU7kuzYBDFECnAkk9XiuvM6YvLrI70+PXXuLkorl7dddX4NmAYwqCPwQpnaPVVhZDZ0EALeU+R/AFHxtIPA1bi0GRdQMrVORDowJD8mwD2pktvfOIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750386304; c=relaxed/simple;
	bh=iDv1vVXP69NaJEWACSacnp/sPD8tGOtdHAfLAmgfJsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RyZRQlkYZm3n51zOx6kPE/camNiwwUaxp4KPA0/pO9/Tt3BVj8tvM6fFY0JyRCNwGoy+0tXJBKWWPwURogn7x3bVPI3/igZmRipbsiDsUbOAz5YH0YvMIP+CL6oCYkqaEjy/3mSB2BDwvg3bwFBdhy1kG5qWe5a0qruz4oTKcIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wkq20aa8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943D3C4CEED;
	Fri, 20 Jun 2025 02:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750386304;
	bh=iDv1vVXP69NaJEWACSacnp/sPD8tGOtdHAfLAmgfJsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wkq20aa8UtSlW5v6m65HiSP8sINuPmJ6iZbHCauwu1jmtwxEoA7czip6nmwaD0oIC
	 ZvXbX+9gZjC+Cpty8amoDVm0ut7ueu0Z3qu5p5mADgABnoH3jvJfHZ3/jT/uqstDeO
	 pwu4LEB7OVeHi8TDjfYhAbQqJIk0VA3+hrJNcMIIUhzCJfRe8+TQ0osGdhp9HVuW/F
	 z7aCWRQ6+GNGje1BDUQ2PuCIT6AczIvvjT8ZvdgcF37C8mooyiIkLOhgtIjGAlm/sa
	 1IJtaNclocvPvaR8nVJdeRjAuTSvWS7LagyA6wA7W15ST0FXeMwVHTZjAjitcJL0tR
	 NNy7mfrbYkXnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	linuxhid@cosmicgizmosystems.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] HID: usbhid: Eliminate recurrent out-of-bounds bug in usbhid_parse()
Date: Thu, 19 Jun 2025 22:25:02 -0400
Message-Id: <20250619053904-7a48279c05cc3ff9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250619034418.13671-1-linuxhid@cosmicgizmosystems.com>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: fe7f7ac8e0c708446ff017453add769ffc15deed

Status in newer kernel trees:
6.15.y | Present (different SHA1: 6dffa4488614)
6.12.y | Present (different SHA1: 549d235f4f07)
6.6.y | Present (different SHA1: cd2287ce05d8)
6.1.y | Present (different SHA1: 345ab0a1113c)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  fe7f7ac8e0c70 ! 1:  718d78696acef HID: usbhid: Eliminate recurrent out-of-bounds bug in usbhid_parse()
    @@ Commit message
         Signed-off-by: Terry Junge <linuxhid@cosmicgizmosystems.com>
         Reviewed-by: Michael Kelley <mhklinux@outlook.com>
         Signed-off-by: Jiri Kosina <jkosina@suse.com>
    +    (cherry picked from commit fe7f7ac8e0c708446ff017453add769ffc15deed)
    +    Signed-off-by: Terry Junge <linuxhid@cosmicgizmosystems.com>
     
      ## drivers/hid/hid-hyperv.c ##
     @@ drivers/hid/hid-hyperv.c: static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
    + 	if (!input_device->hid_desc)
      		goto cleanup;
      
    - 	input_device->report_desc_size = le16_to_cpu(
    --					desc->desc[0].wDescriptorLength);
    +-	input_device->report_desc_size = desc->desc[0].wDescriptorLength;
    ++	input_device->report_desc_size = le16_to_cpu(
     +					desc->rpt_desc.wDescriptorLength);
      	if (input_device->report_desc_size == 0) {
      		input_device->dev_info_status = -EINVAL;
    @@ drivers/hid/hid-hyperv.c: static void mousevsc_on_receive_device_info(struct mou
      
      	memcpy(input_device->report_desc,
      	       ((unsigned char *)desc) + desc->bLength,
    --	       le16_to_cpu(desc->desc[0].wDescriptorLength));
    +-	       desc->desc[0].wDescriptorLength);
     +	       le16_to_cpu(desc->rpt_desc.wDescriptorLength));
      
      	/* Send the ack */
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

