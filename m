Return-Path: <stable+bounces-194920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F2DC62030
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 02:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2BCF356890
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 01:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8C92367BA;
	Mon, 17 Nov 2025 01:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i09QA4gG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C96A1E4AB
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 01:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763343511; cv=none; b=XIvkijgh3BvR9U1bJf/qZx8+Ud/ejrqKrswI8r/NEMPhoR3SDGsetUhfDmI2JnTdVg7/bSaiDbtKfQp/EmQjR53Dnlkryuhw2lyov9MO2y2cc0sSET7Rho33zJ9wnMIfP2g6wp5yGUggS4ZPB3d6YMIWqj6LzYttLNMxPS3rmzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763343511; c=relaxed/simple;
	bh=4J0Y/3/+xNlkwAt5r4aphsEDKQO77GGhJxd7GUgHL1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iz3eHtEGS3B4vTAFsmEPz0B9odZWdKOfzeHaBnvrEjPPxbtHH6yz1Xs1pdCvZIeaxe6N4K9uHOcKfiUJYH0iAfFLY0pntoGbDGk1FRwePrl6H0go5zD8SAkVvvT83eRkKWkUYyfkX7JfJbb7ZcPvj1ZYHln6kRatRf8gbiWtJaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i09QA4gG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF20C4CEF1;
	Mon, 17 Nov 2025 01:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763343510;
	bh=4J0Y/3/+xNlkwAt5r4aphsEDKQO77GGhJxd7GUgHL1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i09QA4gGaKw94VkKdhLUGiCyXLn6PH/MYN7VNXDCS/5b4zwLSYN7oVGVMPOxXwhrl
	 7mAZZrSQpDuheO85sa4fIP/0BPN7kTTEOmHWS9WBhIMarvLXLFwTc/tiY5w/XRXdeP
	 art3ITPEcBwrToUSBLrJhK2MOQ89TswwHKI9BaVJXIbdpnCHVOsItBSN39naWcTiio
	 DnUM99AiOtV79ac+6AxWUR6hTjpRMDZvI2Wgg0tHRthS0Xb5RLrD0NO6OG/M3XEcQ5
	 SBZ9BvSs8hL+nq8hNcHHwFfP3uzy+5XR1monqZnBx2CHTm/xoBozMV46/cNOUAOb+J
	 mX7nGiMQBPLgw==
From: Sasha Levin <sashal@kernel.org>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: Re: [PATCH 6.1.y] Bluetooth: hci_sync: fix double free in 'hci_discovery_filter_clear()'
Date: Sun, 16 Nov 2025 20:38:28 -0500
Message-ID: <20251117013828.3745002-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <tencent_FF86E4B3752C0E284C4FC31B2D4ECDEDC706@qq.com>
References: <tencent_FF86E4B3752C0E284C4FC31B2D4ECDEDC706@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: Bluetooth: hci_sync: fix double free in 'hci_discovery_filter_clear()'

Thanks!

