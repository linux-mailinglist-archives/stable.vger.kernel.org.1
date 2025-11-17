Return-Path: <stable+bounces-195011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA6AC65E01
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 20:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id F2BA92944D
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 19:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46482258ED9;
	Mon, 17 Nov 2025 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hODNlawd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B82239E7D
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406571; cv=none; b=bt3wrY8lAYFG858TS50LYWs4UH9Lpb+MH9zhzq3VoVNX6zkbXArIrcO76kXR2j3A5BBH8ePyoonXJpQh/FPuhqhts3A+zNjreTVfey3Mr2u0+yLh/jybm3Xmrh105dw0CRA8vqJvoenukyJhAATJNiQLQleuGhqVohi6ueyRj/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406571; c=relaxed/simple;
	bh=lmUM/aBM8r3zwC5DrI/1BqMyF/hX44s5i2POo0ECAdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khBEUWfm/zElWGPQ7RF/zsJlMyZ/fG0oY/4/l9gfP/a/hq7xnP+j65oalisq1uRNk6fIrU50BorNm1iqAtYctioXQ5M3OD3BtKF6/S1aZO2amXo6WSoXMzhPbzo0hdqbkIymaXiG7V+SaobQ/citNomoIMRfgN1+phJF79tt2fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hODNlawd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D174C19422;
	Mon, 17 Nov 2025 19:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763406570;
	bh=lmUM/aBM8r3zwC5DrI/1BqMyF/hX44s5i2POo0ECAdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hODNlawdZZGSv+lhuXfCPVcrydmYhRAUORVURyscvvLQiV1g3sA9qXLyOMo6UPoIq
	 ZYw0i+TDQvzBlWVapB9KfD+nhwRhxOBxFHl/VpBQ5YGSKRfcplzYVyseK002NSGaeV
	 PYMvQeJ+UA/bnN6cmW3DEdprCz0IS/j6m7s2xLRUDqAxc2CV6ZgpKjDWhCStL12fIS
	 FKpTwKvrkMMjSAEKLa7xidu5gB0HhvgodduMKgQEFlhbxX+Orj6ZhSdbZ6mP8IsbVe
	 NkxH4f2izVha3EOpp5hKy8On4aNErne+xF8e0o9lDlBPVTtiUeCLrO/oatKRCMEYa8
	 GFhn1xkZyCMlw==
From: Sasha Levin <sashal@kernel.org>
To: alvalan9@foxmail.com
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH 6.6.y] Bluetooth: hci_sync: fix double free in 'hci_discovery_filter_clear()'
Date: Mon, 17 Nov 2025 14:09:27 -0500
Message-ID: <20251117190927.3999181-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <tencent_1120D6A1383F30BC0D07B441359D1F619208@qq.com>
References: <tencent_1120D6A1383F30BC0D07B441359D1F619208@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has been queued up for the 6.6 stable tree.

Subject: Bluetooth: hci_sync: fix double free in 'hci_discovery_filter_clear()'
Queue: 6.6

Thanks for the backport!

