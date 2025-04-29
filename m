Return-Path: <stable+bounces-138177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D54AA16C4
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B32C67ACB78
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6289A244686;
	Tue, 29 Apr 2025 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JoZRtqhe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDE21917E3;
	Tue, 29 Apr 2025 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948414; cv=none; b=qcDlQg3y261lFrZu6fdWU6+EXS+VDlvDkxRdyRMM+dvZ1dfzHHbBnbRXZZEAg3HDZYRDxeAmJML06hepjWu1w2ba2qzVXajtaAvwvlLIBX7KsxAhl5Pr7PbdWUzcNomNThvdnkGHaSGriO6zN7sEP9dTagNFozYbvBXCzcWi5KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948414; c=relaxed/simple;
	bh=WO9Gq0ZnIr4mDOYyStflGW28O+2z2X4KFsVaTtC1uN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ix/eShmWl9t3JtQlWjWYQGp5u41q2qKbZMpwSwwO6JJoHPLJPs2XcpgFVanCL6roKZ87XtzYu5zDJg7tEuEh50S1X2smtkHQyvnDhgc0ekia8LNJHrbrVW2NPAi/mP9jlLriqBxahfrAOQlDoqeytpjVXmW//XVGjwMddRrgiDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JoZRtqhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2390EC4CEE3;
	Tue, 29 Apr 2025 17:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948414;
	bh=WO9Gq0ZnIr4mDOYyStflGW28O+2z2X4KFsVaTtC1uN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JoZRtqheDJQQLzd0AcExG1R9eebBGQrP7mf4/l/F6glWKHxzOWZQ43oEb6dNikk2h
	 sEr+BbwH9RAYoj8iHHgVu9o3b87ciRCkEvNjCM5Ip04gFYcnvzHhnhcPPBfCu0KYdm
	 GlYDFvWxkze+KddDs5eAh2cKFqv7OxmIHzW42EXU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org,
	"stable@vger.kernel.org, Sasha Levin" <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 266/280] net: dsa: mv88e6xxx: enable PVT for 6321 switch
Date: Tue, 29 Apr 2025 18:43:27 +0200
Message-ID: <20250429161126.014688749@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Marek Behún" <kabel@kernel.org>

commit f85c69369854a43af2c5d3b3896da0908d713133 upstream.

Commit f36456522168 ("net: dsa: mv88e6xxx: move PVT description in
info") did not enable PVT for 6321 switch. Fix it.

Fixes: f36456522168 ("net: dsa: mv88e6xxx: move PVT description in info")
Signed-off-by: Marek BehÃºn <kabel@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250317173250.28780-4-kabel@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6289,6 +6289,7 @@ static const struct mv88e6xxx_info mv88e
 		.g1_irqs = 8,
 		.g2_irqs = 10,
 		.atu_move_port_mask = 0xf,
+		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,



