Return-Path: <stable+bounces-5350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F0B80CAE8
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03AD11C20E90
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9ED3E498;
	Mon, 11 Dec 2023 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtdhY6jF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFE13D97E;
	Mon, 11 Dec 2023 13:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE84C433C8;
	Mon, 11 Dec 2023 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702301145;
	bh=VKs1EvBmGIBwqV2FwfnKtoshqlh3tYuJXm/ZPmZw9mc=;
	h=From:To:Cc:Subject:Date:From;
	b=HtdhY6jFU/kTASHqTfLYT4x6ST54NyjoG3iXRxd3TyyTGiQxtkiy7dCdmMcfHtWzn
	 pkIJhCpB/1B6TiLofbbMGpTQq42JpzfNOu5b1m8plSRfFFI1vA7yS0e+eQrtO9A4t2
	 P1nv//3JLBryXto4tV/p3iu/0goPC7CorOhYa03i5fTEsdMNGQFTBKNJRKiR9Dow6W
	 /6OnJaGPtKzVzNaXQAfb/YjqP7QSDMpfd1JeIda2s1QYKQZLDXtDs+jSOx4Xoz5ZJb
	 nnw1YTxeJu7q3P7eWVEuCD9HrvzRM+xxgAaCrxeKaRUY9ekUurk4sunduxJnGUYPXd
	 PV0ZkwXGujsYw==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rCgIq-0007Ff-0Q;
	Mon, 11 Dec 2023 14:26:32 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	broonie@kernel.org,
	alsa-devel@alsa-project.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org,
	srinivas.kandagatla@linaro.org
Subject: [PATCH stable-6.6 0/2] ASoC: qcom: sc8280xp: Limit speaker digital volumes
Date: Mon, 11 Dec 2023 14:26:06 +0100
Message-ID: <20231211132608.27861-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a backport of the following series:

	https://lore.kernel.org/lkml/20231204124736.132185-1-srinivas.kandagatla@linaro.org/

which did not build on 6.6 due a rename of the asoc_rtd_to_cpu()
interface.

Johan


Srinivas Kandagatla (2):
  ASoC: ops: add correct range check for limiting volume
  ASoC: qcom: sc8280xp: Limit speaker digital volumes

 sound/soc/qcom/sc8280xp.c | 17 +++++++++++++++++
 sound/soc/soc-ops.c       |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.41.0


