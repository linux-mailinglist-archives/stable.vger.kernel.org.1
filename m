Return-Path: <stable+bounces-197007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A23F2C89ABF
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 13:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4932A4EDA28
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 12:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587AD32694B;
	Wed, 26 Nov 2025 12:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZceuFycw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1683E324B12
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158589; cv=none; b=kb3DXHdXer+UH4aK3ziZ3KvroQRX71GewjlQxDwSlFLkl3i02UzJN+DS+EVK8QVNkZKgho7uSvG7GewznQgyTYmR66p9EPn+TJYkL/a6v/hLnlfOHz25x4EsEEyQ+L77kSWnR+LS/k88ArkNf5GgaF6rVs9FfFTz5tdL4xqhxQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158589; c=relaxed/simple;
	bh=TbhAFm6XJeyPBntDpsZxnQxHCVcI0tshMVBwqLSeRX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxTc9CD6rWiKH04tSp4YxaBC/xJNE1GmWVHjxqKImsN3yRfo2L/tFncXXJpNYOXhYfreaCApwfcnwNcXekklK3PAxY3Hm5HKC2UUcmf6i+0+iuX3ffcLj4/9G/JQ9BIYcTNEt1ZfaOz1BKguYYeImt8ycpqlwuEzA/CxIVkbHiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZceuFycw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D93C113D0;
	Wed, 26 Nov 2025 12:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764158585;
	bh=TbhAFm6XJeyPBntDpsZxnQxHCVcI0tshMVBwqLSeRX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZceuFycwg7rF9+UpKgfNt2ZR6TTiNSJFEFj+9mwqaN3Tl1Zu4xyu+Fc+S1DrM+KDa
	 CioSf58nrpHRb9/xdQXQutZve+Mg1i8Z7rrB3ZTyaxo/Qcj+hKS8qBXKESGLlxljvM
	 +kdf45af56oTrtXXHUZQikmsfMdsselblmlDbVncAKZN8UZH+VxLQx4ECi0XArBavl
	 QfBjm0cQ6lql7LwMbDnPps7Gyr/VrCYUx9NthE0mlLNy2h3l8kZxL/hpFIOJiiJAWu
	 ysyS69seajRKiQYI1xrov/Ba1/UCoXmxa74MAe1/4rWNxNyEzmxsObm5oSPf22b0mW
	 Jbk3bioCVLB4A==
From: Sasha Levin <sashal@kernel.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	tatyana.e.nikolova@intel.com,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com
Subject: Re: [PATCH 6.12] Revert "RDMA/irdma: Update Kconfig"
Date: Wed, 26 Nov 2025 07:03:03 -0500
Message-ID: <20251126120303.1356691-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124021459.691989-1-guanwentao@uniontech.com>
References: <20251124021459.691989-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has been queued up for the 6.12 stable tree.

Subject: Revert "RDMA/irdma: Update Kconfig"
Queue: 6.12

Thanks for the backport!

