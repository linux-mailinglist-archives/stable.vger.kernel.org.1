Return-Path: <stable+bounces-163650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 115EAB0D110
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 07:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2D7188546A
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 05:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83277218AD4;
	Tue, 22 Jul 2025 05:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hih1/vm6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4324D35947
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 05:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753160516; cv=none; b=YqmFmS0zob8pRmn7SEDLCBa5t1zb2ffKbmDYJosbXigxvxaJItY9SaaiyENmP4adL9IVWJr9UqbHGapBU6RiebJEp7YM94x4RpLViavLYV+I8FJoqFeq3hRRHYYZUtMsWaQn/RanbRuI2UcCsA37ifsB4zTMaU3qDxBQf8uwU0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753160516; c=relaxed/simple;
	bh=zOvYaIumaj9wMRfM/evTbQWpErRoOQBqiB/xK5UM0Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvJAXZZLh0pjwiZfmIX54hKuXme6CpT2i4hyKXGkY7YlRYDhxXUriAJLhw+9OSXLZa99j04cooZn1JO8SA8pT4d5B6DlKFP10mFtIb41rs4iHxhrX0CK6SpFSXSmD1eHdjFp4Ha9S8+gMZ6v/gKd1SfichpI3Np+Z7X06HBRGeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hih1/vm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B42CC4CEEB;
	Tue, 22 Jul 2025 05:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753160515;
	bh=zOvYaIumaj9wMRfM/evTbQWpErRoOQBqiB/xK5UM0Nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hih1/vm6fYo1mF9crOtpEbuK1MbqOQo91UIM8LgFOiQcA0BzeMuVw+TjBV0c12TAA
	 pnqgYx1v5kctTYmspKX733ekQJvk93zKS8WBB42sOsAPCaDCZEkGQDWXcif6x2epun
	 Ka+huMpGzc9mRsoGkquD6Bd9meMLHI32zcTl58KKLv1djAKJihJHojnF0Y8OkqKg1a
	 ++KnEXtgEGFrWFeEZM6gASAOvoZARiF9u09pwjWvpF4prC7JlhcaFHWRmv7WuURfac
	 IZ9ivq0gfmwIIKAXKbDtRVxjed17L8eBaOU2Z2x2SGgWLty1epJdNdiU1H1PPZeCCF
	 +PBYhY2WE/4Yw==
Date: Tue, 22 Jul 2025 01:01:53 -0400
From: Sasha Levin <sashal@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org,
	Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.4.y] usb: dwc3: qcom: Don't leave BCR asserted
Message-ID: <aH8bQfbAOsr8sVmO@lappy>
References: <2025072117-left-ground-e763@gregkh>
 <20250721155109.855693-1-sashal@kernel.org>
 <53640837-9c42-41a6-a200-f4074e0931e2@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <53640837-9c42-41a6-a200-f4074e0931e2@oracle.com>

On Mon, Jul 21, 2025 at 09:33:11PM +0530, Harshit Mogalapalli wrote:
>Hi Sasha,
>
>On 21/07/25 21:21, Sasha Levin wrote:
>>From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>>
>>[ Upstream commit ef8abc0ba49ce717e6bc4124e88e59982671f3b5 ]
>>
>>Leaving the USB BCR asserted prevents the associated GDSC to turn on. This
>>blocks any subsequent attempts of probing the device, e.g. after a probe
>>deferral, with the following showing in the log:
>>
>>[    1.332226] usb30_prim_gdsc status stuck at 'off'
>>
>>Leave the BCR deasserted when exiting the driver to avoid this issue.
>>
>>Cc: stable <stable@kernel.org>
>>Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
>>Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>>Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>>Link: https://lore.kernel.org/r/20250709132900.3408752-1-krishna.kurapati@oss.qualcomm.com
>>Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>[ adapted to individual clock management API instead of bulk clock operations ]
>>Signed-off-by: Sasha Levin <sashal@kernel.org>
>>---
>>  drivers/usb/dwc3/dwc3-qcom.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>>diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
>>index 742be1e07a01d..4874a6442c806 100644
>>--- a/drivers/usb/dwc3/dwc3-qcom.c
>>+++ b/drivers/usb/dwc3/dwc3-qcom.c
>>@@ -615,13 +615,13 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>>  	ret = reset_control_deassert(qcom->resets);
>>  	if (ret) {
>>  		dev_err(&pdev->dev, "failed to deassert resets, err=%d\n", ret);
>>-		goto reset_assert;
>>+		return ret;
>>  	}
>>  	ret = dwc3_qcom_clk_init(qcom, of_clk_get_parent_count(np));
>>  	if (ret) {
>>  		dev_err(dev, "failed to get clocks\n");
>>-		goto reset_assert;
>>+		return ret;
>>  	}
>>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>@@ -700,8 +700,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>>  		clk_disable_unprepare(qcom->clks[i]);
>>  		clk_put(qcom->clks[i]);
>>  	}
>>-reset_assert:
>>-	reset_control_assert(qcom->resets);
>>  	return ret;
>>  }
>>@@ -725,7 +723,7 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
>>  	}
>>  	qcom->num_clocks = 0;
>>-	reset_control_assert(qcom->resets);
>>+	dwc3_qcom_interconnect_exit(qcom);
>
>^^ This part of diff doesn't look good to me. Can you please double 
>check the conflict resolution ? (Probably shouldn't have addition in 
>this hunk)

You're right! It came from the 5.10 backport which I've cherry picked
onto 5.4. I'll resend.

-- 
Thanks,
Sasha

