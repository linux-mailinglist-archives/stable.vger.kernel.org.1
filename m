Return-Path: <stable+bounces-194879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC7CC619B1
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 18:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63C1234A169
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 17:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE1222D9ED;
	Sun, 16 Nov 2025 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW+RXTc2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1BE1E0B9C
	for <stable@vger.kernel.org>; Sun, 16 Nov 2025 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763314366; cv=none; b=FcvOlcgDm3gEIQ6keWaQ//CtZN+lyWcadFqbEm7TLvHlfsmKzbiM8efGOAq7m1DX8LYl/1vBlnn3RLBdS6+ULSriQCyS8OJbQ5CaUTGV71uWC6WFUU9QL/k2XqBDvFl4RE5GvhUDcPRjLJDuJpuIs75oa3URWjyuXaR3d0khpeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763314366; c=relaxed/simple;
	bh=nmPHqgN7JzwzT1wgDjcGDU02coOnspycmaoeybKuCL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fug4ZuE59vFSyhwg7tXrsqqPxL2kUSW+wONE/dsatEY4CpUMyJGIxlTP2/hoGg/guicOGSdRJsipeOiGm3huiJ/W6A4Z09flHJ01Tp2lBy3XfiI3DxnuLEjt8hQNGSpelIH7Hr7caLfxl5o9TtMOo+kqkeRXb/h+DH26mtHJAm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW+RXTc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A54C4CEF5;
	Sun, 16 Nov 2025 17:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763314366;
	bh=nmPHqgN7JzwzT1wgDjcGDU02coOnspycmaoeybKuCL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TW+RXTc2cHP5YXMmly30my7RFoNPRaq5vBbjBDvelo+2MM79AQ8ManfJpmDLIR8N/
	 9pifgi3uJhF448s3vVX7tUi1GpRQFpJ2CS/VAWqJvGnqe2GjNxaKkVkp/pzEUazqJ6
	 qdNlKzkd4kpbMu5Ftx4eJa9PMpfjfIrpVcl6xfZzS7e8LAN1joqwUsW5FK3IEnD8LV
	 a/mAS9tfmeG7awh9moH/rlOvlQqkGjjA3u//nZdIAlOBUDUgw/J/b7zc+d49CF2OMp
	 RCY3slnt9vMdbvrQhUTqnYHTxIXrPjJ/dN7jEdSWGLWhzJnb4qPVFmLSVgAxPK4Sha
	 Bb0oac44NryLw==
From: Sasha Levin <sashal@kernel.org>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: stable@vger.kernel.org,
	zzzccc427@gmail.com,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 6.12] Bluetooth: MGMT: Fix possible UAFs
Date: Sun, 16 Nov 2025 12:32:44 -0500
Message-ID: <20251116173244.3623326-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114080751.4432-1-xnguchen@sina.cn>
References: <20251114080751.4432-1-xnguchen@sina.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: Bluetooth: MGMT: Fix possible UAFs

Thanks!

