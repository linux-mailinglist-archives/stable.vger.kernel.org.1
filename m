Return-Path: <stable+bounces-206101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D72CFC711
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 08:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E38F305745A
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 07:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B24D2874FE;
	Wed,  7 Jan 2026 07:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgSc0Lle"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA07250BEC;
	Wed,  7 Jan 2026 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767771867; cv=none; b=LPVD65B4guOBA9v4jyUuO47ck+C5b4Fw/2Sk9Qoej/LHWEuSG25l7/X7Cdt4jjI2A0s4g/inKnmHIvac9WCFLWdcqQuOwomNwjAXm8tF22Q6PbgoiPmAPZFo6Qz3sB4EWvDhzrFxrOrYZvSv4WSrGhbUMKaaJV0wh4EXlcbiaas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767771867; c=relaxed/simple;
	bh=sJ6UFNhgdxznEaPlaWVQBro0xL6d8TpL3PTMM/QEoas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=heN7Opa6D/sWCNNhBbT+WESTE8QerHIk2YI5eoDOGUqspR7w9jcOx5blo7/t7vOKEIwspjv0fXNXgmk2k8bTazuL5bWLxjp3BWE/5E5YrbNhiS5Hoo3sVL0iSdrwvpCzucJIo2o3iyuJx11bCaSE2kHEAuEMGsaJCfOE3L+FPRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgSc0Lle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F2CC19421;
	Wed,  7 Jan 2026 07:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767771867;
	bh=sJ6UFNhgdxznEaPlaWVQBro0xL6d8TpL3PTMM/QEoas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fgSc0LleW1+4ixYN+EkKOwPYZlY5CH3OyFyjgM6BuNcG6MdnmufiI7IjfZxtmeA6g
	 6QAvMAbrDP96FQEvvKvfcHUk16ojSpSMSUezysNBFdKNx8qTZvhENyhs+pOdnEgigz
	 r3a5Z2mh8pFBUce7WHW2U47brDllUi4Qnwf8hD/io15MtcLq1R2L0bGS9wezMzEAjx
	 00kAmSc6Jkmvos8eozilHT+em7NxGnXAsfPeOoqH7ez6TryDIC9gYnM5SBqWzDOagp
	 2EO9a6Wy4+ZA958KSVY9BgvJGIpRkqWPOd0hKRRwff7EmAOPLe3nk8k3q6VGMwgwR5
	 wT7rSufiAim8w==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: ioana.ciornei@nxp.com,
	Gui-Dong Han <hanguidong02@gmail.com>
Cc: Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] bus: fsl-mc: fix use-after-free in driver_override_show()
Date: Wed,  7 Jan 2026 08:41:51 +0100
Message-ID: <176777167465.2143957.13769286595533147394.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251202174438.12658-1-hanguidong02@gmail.com>
References: <20251202174438.12658-1-hanguidong02@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=668; i=chleroy@kernel.org; h=from:subject:message-id; bh=iZF3c2s/gwLPk+6gtKcn3ZoWh+VlN+vu0LbNBwJXh5I=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTG8Tk0v5mkmnZl3UEXw1Mh7FJcwlynXj7qbFIrWbqsz 9gy4OqujlIWBjEuBlkxRZbj/7l3zej6kpo/dZc+zBxWJpAhDFycAjCRpUsZGdrDTuusjjk6Re7G mdKVXckp05e7vkx6ur4ynOcUT33/mgcM/7OTJ/BGrJxh5LT30nmtnjcuu/Z/36a2Qpbdtt5/O/N bdnYA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Wed, 03 Dec 2025 01:44:38 +0800, Gui-Dong Han wrote:
> The driver_override_show() function reads the driver_override string
> without holding the device_lock. However, driver_override_store() uses
> driver_set_override(), which modifies and frees the string while holding
> the device_lock.
> 
> This can result in a concurrent use-after-free if the string is freed
> by the store function while being read by the show function.
> 
> [...]

Applied, thanks!

[1/1] bus: fsl-mc: fix use-after-free in driver_override_show()
      commit: 148891e95014b5dc5878acefa57f1940c281c431

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

