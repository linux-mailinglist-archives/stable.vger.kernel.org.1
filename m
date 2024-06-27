Return-Path: <stable+bounces-55977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CA691AC7D
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 18:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4931F259FB
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 16:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A7519939D;
	Thu, 27 Jun 2024 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEQyaSPP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEE5199392;
	Thu, 27 Jun 2024 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505323; cv=none; b=lkLh3HNvweQnXOuqM413XxTkFGNFbToYct3gi1FV55XiKxanqxSkpsHXXZeS3tCm/mKKzUiEOSFhSDkt6pixvsk5ujj1DNhZ6spZ62+cqISoEgQVbirjT6sXNtmdHQ3HtIqimwRwYb1xsJY2vm0t6XtcfCnNtE4u0EwZax9Wobo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505323; c=relaxed/simple;
	bh=kVLYV7wBgQxmFh3aypgRbiiiHGjW8/Z2O0qs1JuDPUI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=bRWPewkFjqsmkc5YY2l0CHUp/BF+IeTDLsW+7AALvp/lL3mk2Fb8pe9Wq8IDJmD3E3+T8UfDAs8kTTJERB4kfFGN6BPfEWGObaW5hYIXDnzyeYaStCtjxGaI04/49UdRy5oUhaxJ+JmJdZTSiA2XtdtKcPGPm5u7xaZbjU7trug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEQyaSPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13C4C2BBFC;
	Thu, 27 Jun 2024 16:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719505322;
	bh=kVLYV7wBgQxmFh3aypgRbiiiHGjW8/Z2O0qs1JuDPUI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=oEQyaSPPC/uxDY8WI+6LGF11pXkgny5Urm0SRMnJYYhCQihD/dFusuB07/b0XCV+Y
	 RHV1jE7DBuMJMuhWFehTn2kk+//p6ka/ndvF3zJGSFZMcTLYEd7uyBFi8SfWmgqzjL
	 aCaoeR2jCJuTakPgMPFF16GLW6vSogFGLgIZgiDpsWP+2JryLVK10k+LETrt0EY26X
	 crGCMrQpomQtgscKvC0xdqgWvHIc4VQD3HTXeB2CGLtVZG79fZDWDJF+GatFv/Vp47
	 lar/8aJBpdisdN832DPHlos20tu0T9bJTwt493SIKwUpmbMWD4YegXg9+sFMz4eB5X
	 337v150xiokmA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: Allow driver initialization for WoW
 unsupported
 devices
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240626024257.709460-1-quic_ramess@quicinc.com>
References: <20240626024257.709460-1-quic_ramess@quicinc.com>
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Rameshkumar Sundaram
	<quic_ramess@quicinc.com>, <stable@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171950531986.2164695.17835818417025337826.kvalo@kernel.org>
Date: Thu, 27 Jun 2024 16:22:01 +0000 (UTC)

Rameshkumar Sundaram <quic_ramess@quicinc.com> wrote:

> Commit 4a3c212eee0e ("wifi: ath12k: add basic WoW functionalities") broke
> driver initialization, now mac registration is allowed only for devices that
> advertise WMI_TLV_SERVICE_WOW, but QCN9274 doesn't support WoW and hence mac
> registration is aborted and driver is de-initialized.
> 
> Allow mac registration to proceed without WoW Support for devices
> that don't advertise WMI_TLV_SERVICE_WOW.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 4a3c212eee0e ("wifi: ath12k: add basic WoW functionalities")
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

9783e0407421 wifi: ath12k: fix driver initialization for WoW unsupported devices

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240626024257.709460-1-quic_ramess@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


