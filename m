Return-Path: <stable+bounces-197003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD4FC8996B
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 12:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6763B2EE2
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 11:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39974325487;
	Wed, 26 Nov 2025 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xq4PQZLb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3B9320A0D
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 11:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764157644; cv=none; b=JjhlsGw6qJIBno5wE6Qzf/aRmB+cOlh575MXOmDsmbHzUf/KzsaP/HoPNBq3zh/IvsPvLppEZwOSjOTBs5xJGD/AFQNDM/3B0h7ujSym8VC7VcA7LPLcdo81CktI8Y+W9aZK8Ab7+KDgeXVsHzgBNT5BuMa8xZNzqyAO/rapRoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764157644; c=relaxed/simple;
	bh=vc7PoksGtsCyhQ0ATPqcjN5/q4c9LzGPM5Ic2MQeJLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bj2I6x7q8o05b22Gyte+ETm385xigPXWhfwtxqhsxG7huwT77J/l0CC/YVCRZoYuZhJIr7zD26z/haGa58gMjTyzQASBQ3lY5HLDQVP1AdayQpkuQcbS00y6dhPV/Mz3rOyVOti+bjn8k3zloUrAaTUraYw/lzL8htS/vv76Lp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xq4PQZLb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A88C113D0;
	Wed, 26 Nov 2025 11:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764157642;
	bh=vc7PoksGtsCyhQ0ATPqcjN5/q4c9LzGPM5Ic2MQeJLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xq4PQZLb7fjxkd+BL10nb5ViFpFY+LWhIYqx2GpnkuMx5d2I4UMIilC6P7z95qLqS
	 Ie5JVilNEr7WPo5849jD4MzlgqicV+NiX6aSJvL923ijvcTXM6d2i2bPgQE477M3uo
	 gduyu16Y3uORkWTEVvo1uNKaFlZH4QQHPNE+TW9OSWKBn9QthppDGRnLvyrGvWe2ae
	 fYKAZ68VXcZaYODeOYoHM+TzsmzdTisMO36PVZ013PN2QVdOan98WlsXMkUduNx3uU
	 qSG1nDvV5pdM4CywqBp7zTUjUXnR5aVtpmsQXZmaf2XjCRH7mn3rC9UteS3nPQgt/4
	 cQ53vcxTdLyCg==
From: Sasha Levin <sashal@kernel.org>
To: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: stable@vger.kernel.org,
	Koen Koning <koen.koning@intel.com>,
	Peter Senna Tschudin <peter.senna@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 6.17.y] drm/xe: Prevent BIT() overflow when handling invalid prefetch region
Date: Wed, 26 Nov 2025 06:47:20 -0500
Message-ID: <20251126114720.1350849-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124221609.718106-2-shuicheng.lin@intel.com>
References: <20251124221609.718106-2-shuicheng.lin@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has been queued up for the 6.17 stable tree.

Subject: drm/xe: Prevent BIT() overflow when handling invalid prefetch region
Queue: 6.17

Thanks for the backport!

