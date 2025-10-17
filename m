Return-Path: <stable+bounces-186248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD267BE6DE9
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 09:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6EAA5008D9
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 07:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BABE2264B9;
	Fri, 17 Oct 2025 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dgNQvdmJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E924B233722
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684461; cv=none; b=uCVCQYnQT6P0PJDZDUbV0LGagcxvFN4Y/kZZyTFeidTtH890Nf+VkUPcwM/0JYoXnKZUekU4x74r1ytIa5C6bpbPRGZ/ui6iigVLlzJpbQ81XJw63EIWTfu2ny2xJLR1ha4BMJvduHPDAkvCEwmSR2xD9PFw3UHctteXO5FBcco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684461; c=relaxed/simple;
	bh=AfRxp8wPs3W/ZHgZgYxrmMLKqh9z6iNwst8yUxcXwhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKo2thL8LZUShUBu77dEmpghCVXFSbuNyaYGLgckU+28V4GkaxnLDpLtbULxXnwMH2pCreTSavp/y4FA1ULn8u7HlqZ4ggkvkmiEmTK4NAWaAe52k+G1CRZg7WpDFReYAVnjFet95AEVRkuCRjXhKFknIMdQM3KIQ4Uyz6cwU9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dgNQvdmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F475C4CEE7;
	Fri, 17 Oct 2025 07:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760684460;
	bh=AfRxp8wPs3W/ZHgZgYxrmMLKqh9z6iNwst8yUxcXwhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgNQvdmJ2TkJr++3QkYoU2fKMp86hzWYaaRmD6t9ThhdA7eQMRpJzDAGqfGdq4HqN
	 Jar6ptsG2+NBDMnVw1gBkHlV2dEKrlkS9tbHYOc302D6Z46bSVJTwb8r8B+CCKlNH1
	 EtiHU2EoFEfgx74+H2P/wl14/F0k0T18vD25VjkM=
Date: Fri, 17 Oct 2025 09:00:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: stable@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6.17.y] ASoC: qcom: sc8280xp: use sa8775p/ subdir for
 QCS9100 / QCS9075
Message-ID: <2025101748-outing-luxury-5a3f@gregkh>
References: <20251014191044.3808939-2-dmitry.baryshkov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014191044.3808939-2-dmitry.baryshkov@oss.qualcomm.com>

On Tue, Oct 14, 2025 at 10:10:45PM +0300, Dmitry Baryshkov wrote:
> [Upstream commit ba0c67d3c4b0ce5ec5e6de35e6433b22eecb1f6a]
> 
> All firmware for the Lemans platform aka QCS9100 aka QCS9075 is for
> historical reasons located in the qcom/sa8775p/ subdir inside
> linux-firmware. The only exceptions to this rule are audio topology
> files. While it's not too late, change the subdir to point to the
> sa8775p/ subdir, so that all firmware for that platform is present at
> the same location.
> 
> Fixes: 5b5bf5922f4c ("ASoC: qcom: sc8280xp: Add sound card support for QCS9100 and QCS9075")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> Link: https://patch.msgid.link/20250924-lemans-evk-topo-v2-1-7d44909a5758@oss.qualcomm.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  sound/soc/qcom/sc8280xp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This is already in 6.17.3.

