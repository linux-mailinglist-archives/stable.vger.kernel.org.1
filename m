Return-Path: <stable+bounces-118452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52271A3DE55
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCE9D7AB210
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 15:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C8E1FC0E4;
	Thu, 20 Feb 2025 15:16:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913F11CCEF0;
	Thu, 20 Feb 2025 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064602; cv=none; b=DByZkoPVy5H1XFxpjsMZQGEjUBqRkeBja03TvVk8MaijzVDxtmZ+gqEpea/CupaYibV0PheLi+AAOMtdZE//7QdbC3zj9CXkB1rd9rRLN07MRHBz3AMGBdiprBo9i6fZ2cYyfuGBmwJFDkCWNSuioHU0bXlwYZ5dUMrFw/QKY8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064602; c=relaxed/simple;
	bh=TIg8CqN5hO+RqL67o6DLnyrSFUhVBiw7Xn0qzxP77JU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atom41IGghwiQ2AzLO8DqSRphQO2K0HZbBu1lo0mKpWyAduRjg4NfuRfAYobFRDxzKkfmD6wwfypI5Ij264utb18rGnSXbG68oqt07RqZxLZ9g/iTDC2ruvVIR/eaAn9cAwhToWyahO6TJkQDbChFENqLJw1BazU4jkls4CxBUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9198C4CED1;
	Thu, 20 Feb 2025 15:16:39 +0000 (UTC)
Message-ID: <41e9f6a8-1f72-465e-b6c4-0bebdc462d31@xs4all.nl>
Date: Thu, 20 Feb 2025 16:16:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] media: venus: hfi_parser: add check to avoid out
 of bound access
Content-Language: en-US
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Tomasz Figa
 <tfiga@chromium.org>, Hans Verkuil <hans.verkuil@cisco.com>
Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250207-venus_oob_2-v4-0-522da0b68b22@quicinc.com>
 <20250207-venus_oob_2-v4-1-522da0b68b22@quicinc.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20250207-venus_oob_2-v4-1-522da0b68b22@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 09:24, Vikash Garodia wrote:
> There is a possibility that init_codecs is invoked multiple times during
> manipulated payload from video firmware. In such case, if codecs_count
> can get incremented to value more than MAX_CODEC_NUM, there can be OOB
> access. Reset the count so that it always starts from beginning.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1a73374a04e5 ("media: venus: hfi_parser: add common capability parser")
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/hfi_parser.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
> index 3df241dc3a118bcdeb2c28a6ffdb907b644d5653..1cc17f3dc8948160ea6c3015d2c03e475b8aa29e 100644
> --- a/drivers/media/platform/qcom/venus/hfi_parser.c
> +++ b/drivers/media/platform/qcom/venus/hfi_parser.c
> @@ -17,6 +17,7 @@ typedef void (*func)(struct hfi_plat_caps *cap, const void *data,
>  static void init_codecs(struct venus_core *core)
>  {
>  	struct hfi_plat_caps *caps = core->caps, *cap;
> +	core->codecs_count = 0;

This really should be moved down to before the 'if'. There is no reason to mix the assignment
with variable declarations.

>  	unsigned long bit;
>  
>  	if (hweight_long(core->dec_codecs) + hweight_long(core->enc_codecs) > MAX_CODEC_NUM)
> 

Regards,

	Hans

