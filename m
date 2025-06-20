Return-Path: <stable+bounces-154854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A33AE111A
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 04:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6118B3B9C21
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 02:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ACB139CFA;
	Fri, 20 Jun 2025 02:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gs8dkOUr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E922137C37
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 02:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750386312; cv=none; b=bjKfxmddAagNPo1UxNouKNNPjN8Tk1tyWPcAwO4PmniL7cJk55bwTPp1r07SVIV2oYtmjT6ESv0mYVt2ewo/x3dYHiQSsNdt1bb7I1AE1Sb1BXfqIq4NjLR+PAVv3jnbDNEJPrnPt4e27g1jhaRISEDW4Jjk4xsC0lD55ugXyew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750386312; c=relaxed/simple;
	bh=azIQ1y5zNM8av6ygy8mgKJYvmCh97gwZurgZ7I1wHtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7M9orwI0CiAo5Hk6Dbiyk9ygt/aq4zFOD9QreDLuz26Ue2GwkLxzP3O3m3Nm6b1o5NZs70amw0WS4z300jsaplBZpcx7PIFx/EODNHOAinaEJ23S+K99FzIu3OmXjVNYo2yYtH3Sr2l3MC3WUIASt1WPRixPEPXMp4ni09OdMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gs8dkOUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CC2C4CEEA;
	Fri, 20 Jun 2025 02:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750386311;
	bh=azIQ1y5zNM8av6ygy8mgKJYvmCh97gwZurgZ7I1wHtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gs8dkOUrZqtOCYywEoNKL9MX7bYPzPM2uB5RcgBpW5J7W1TZX1Eu11jFilXmD8sFo
	 q+Mseu5A5k9HcLUOU9AqLRJER9C9WiJcZoUnQ59rvOK6nBzrq8cyT1gARuJQcsK5h5
	 mz7yM6Lp+mwusMFF7WR5mpDjIdvYoFvCnCxo9nae6xQ2IFOIXAi3/w8kHXLyJAa826
	 t/DkuBhOGTnQ8chh9+JXQofL6o4kb8QAyOYBU5vpMFk2Z4CHHkvGZXVdvnKcqdDr3a
	 8ng1SwzLlrTLy7zVgvndMF17awuc1gfv0EcCjn/Ox3AbDWSs2FNaiMf5vvfCgcYqVS
	 gV+P9eHgIUQ/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	linuxhid@cosmicgizmosystems.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] HID: usbhid: Eliminate recurrent out-of-bounds bug in usbhid_parse()
Date: Thu, 19 Jun 2025 22:25:09 -0400
Message-Id: <20250619055611-fef836ca56db5295@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250619035944.14494-1-linuxhid@cosmicgizmosystems.com>
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

Note: The patch differs from the upstream commit:
---
1:  fe7f7ac8e0c70 ! 1:  46a4432fb0033 HID: usbhid: Eliminate recurrent out-of-bounds bug in usbhid_parse()
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
| stable/linux-5.15.y       |  Success    |  Success   |

