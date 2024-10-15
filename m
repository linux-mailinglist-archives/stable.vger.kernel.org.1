Return-Path: <stable+bounces-85338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFBF99E6DE
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE0B1C250F1
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C9E1EBA12;
	Tue, 15 Oct 2024 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZlJcOrxS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2F31A76DA;
	Tue, 15 Oct 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992780; cv=none; b=T+DibKDaImEQ7/Pq207Hk12mqKWHfYCQNMWWXc9ztaEnVmV/EcOJseIK6a+0oMLGS+JiulAWH9uUFB6qHPvZX5sxBwIoYByEo1++N5jB2+vHDJTvIF/jZDlGfB6Ps6WiHcu17W3ZnRJYho+u1tnAOWuSkGktiHb5koWvteNadn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992780; c=relaxed/simple;
	bh=f8emcxGkbUwq1G+MGQx7u8SO5Um0dR2ti996aH1JljU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgC/nxep6EqOAYhMSJEgvoJ1hCNta5ZUCAP1mguuNkec6NlGeuT46tuwVKp4hp8+Vi0fzULd8nBYqZpw1SL2QUSa0SuxKl7KUzuFm86xMi7g6Bwx+9/MQd3D2jKDCNdgq8d0DzywhGfwA5VBLpqwTP8p0iXXODAPLVnBw7s0+XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZlJcOrxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557B9C4CEC6;
	Tue, 15 Oct 2024 11:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728992780;
	bh=f8emcxGkbUwq1G+MGQx7u8SO5Um0dR2ti996aH1JljU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZlJcOrxSbt7ZVAcumNo6ie2qQ560aBptcuWLO/bQwo2kv9I01mBboqeDFyz/sGLev
	 o/B4XUJx1l6i/A9uAO6KDRB6A6a/g8jlLxfhsaprxb9CnmttZyRwjMs1XMreVP1v5y
	 zrgDSvPcR4KIvShlXV63XlRBRcbYMvz0BTRZzNLI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Corey Minyard <corey@minyard.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 185/691] ipmi: docs: dont advertise deprecated sysfs entries
Date: Tue, 15 Oct 2024 13:22:13 +0200
Message-ID: <20241015112447.702382910@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 64dce81f8c373c681e62d5ffe0397c45a35d48a2 ]

"i2c-adapter" class entries are deprecated since 2009. Switch to the
proper location.

Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Closes: https://lore.kernel.org/r/80c4a898-5867-4162-ac85-bdf7c7c68746@gmail.com
Fixes: 259307074bfc ("ipmi: Add SMBus interface driver (SSIF)")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Message-Id: <20240901090211.3797-2-wsa+renesas@sang-engineering.com>
Signed-off-by: Corey Minyard <corey@minyard.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/driver-api/ipmi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/ipmi.rst b/Documentation/driver-api/ipmi.rst
index bc281f10ce4b7..0bfeeeeb17c85 100644
--- a/Documentation/driver-api/ipmi.rst
+++ b/Documentation/driver-api/ipmi.rst
@@ -519,7 +519,7 @@ at module load time (for a module) with::
 	alerts_broken
 
 The addresses are normal I2C addresses.  The adapter is the string
-name of the adapter, as shown in /sys/class/i2c-adapter/i2c-<n>/name.
+name of the adapter, as shown in /sys/bus/i2c/devices/i2c-<n>/name.
 It is *NOT* i2c-<n> itself.  Also, the comparison is done ignoring
 spaces, so if the name is "This is an I2C chip" you can say
 adapter_name=ThisisanI2cchip.  This is because it's hard to pass in
-- 
2.43.0




