Return-Path: <stable+bounces-62581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6AA93F980
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 17:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CD9282EA6
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 15:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B56156231;
	Mon, 29 Jul 2024 15:32:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355FE13BC3F;
	Mon, 29 Jul 2024 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267174; cv=none; b=r875WuOV9ekx+1CJ1gK3k5f5Nejhl5Mq+mHz3POIr6GL0lnuFDnggd7Tsj7x6ZJ+uJG7Zt207kPhtszMfUW4zBZU7nm96Pye4nsCCkL2CgEemtUqKYLRkZOYcQwjBFMc+AwQxtQTJOh6aj1+5wvDy5LeXpIxk1626XTaVBixjOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267174; c=relaxed/simple;
	bh=kMQInnFptcqrD/lZA3jkTqm/Dqot/cFxM4jIxAhvKxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hH++rgaK2ngSpY8yEx+kNZM9NwD/El2gOWf0X2H+4/c0UwHziGKZVl/3C5qkJTNoF4VRvyt1iBfHc2qrnLCXufIA+kHtEtqQrYGoyDx1T31zpsbzCFQkGScR9Mw0r0yTKZgEz0xN0RsrpGqhayc+rYarxnpNm5NqTK6/TiTp9vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl [78.88.45.245])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r2.th.seeweb.it (Postfix) with ESMTPSA id E2A223EB9D;
	Mon, 29 Jul 2024 17:17:26 +0200 (CEST)
Message-ID: <52a60057-6fec-49d1-8ff6-71b6fa670f2c@somainline.org>
Date: Mon, 29 Jul 2024 17:17:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] media: qcom: camss: Fix ordering of
 pm_runtime_enable
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hansverk@cisco.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Milen Mitkov <quic_mmitkov@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
References: <20240729-linux-next-24-07-13-camss-fixes-v3-0-38235dc782c7@linaro.org>
 <20240729-linux-next-24-07-13-camss-fixes-v3-2-38235dc782c7@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20240729-linux-next-24-07-13-camss-fixes-v3-2-38235dc782c7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29.07.2024 2:42 PM, Bryan O'Donoghue wrote:
> pm_runtime_enable() should happen prior to vfe_get() since vfe_get() calls
> pm_runtime_resume_and_get().
> 
> This is a basic race condition that doesn't show up for most users so is
> not widely reported. If you blacklist qcom-camss in modules.d and then
> subsequently modprobe the module post-boot it is possible to reliably show
> this error up.
> 
> The kernel log for this error looks like this:
> 
> qcom-camss ac5a000.camss: Failed to power up pipeline: -13
> 
> Fixes: 02afa816dbbf ("media: camss: Add basic runtime PM support")
> Reported-by: Johan Hovold <johan+linaro@kernel.org>
> Closes: https://lore.kernel.org/lkml/ZoVNHOTI0PKMNt4_@hovoldconsulting.com/
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>

Konrad

