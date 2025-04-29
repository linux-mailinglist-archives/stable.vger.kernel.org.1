Return-Path: <stable+bounces-138543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF17AA18D1
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762F73AC34E
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA84252284;
	Tue, 29 Apr 2025 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q57Pz8x8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7032517AB;
	Tue, 29 Apr 2025 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949585; cv=none; b=GZrbOOQ42fwBi8oCnSNpkgRTu9Py9wYbA2e199ft/ltlDf25eBDLIldbX8NtjYe1lTj9kfGTXTa8diISOvvfwpVJ70YtIG5oNz/zHDMNHZcBziA+/YmYJ/T//HuEVScEiEjOm9q02FjWErvbM0MdSUDnQ3e+XzK8fT/ka5IXK8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949585; c=relaxed/simple;
	bh=dTJStFYc6ZTV77/BZhK3AiHDsaEEU5ThkZRT+d3zyQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlNqeza2brC89y5JowGxhq0GgavpU8Hbe7G3ZfaZakonT3g5Qhacw3LtXV+OGHxQourBHkIFelVhx1oQozWPqVUm2Qj8r0q75Zlm0YF4gFQILiCBQsZL2f2DwAGa4bPMAKgHp2nh+IiAqksUOknrm7tBEn48OUSz0h1+LR9RmOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q57Pz8x8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227D3C4CEE9;
	Tue, 29 Apr 2025 17:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949585;
	bh=dTJStFYc6ZTV77/BZhK3AiHDsaEEU5ThkZRT+d3zyQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q57Pz8x8cx0uvugWyawESFKagGv5YMo3qWyQIZRtlKrYb16fvn2Ppx1c7x/Hz0SCb
	 ivxRjNPdl+Hv/kjCz4rtcMQK9h0g509qVCWR5vdxQyiI57A+Ud7Av4AOtR8leSd30y
	 NaP4KzaiJi++13ZvVN12JqvpPXe7UzC+i0FD7CYk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org,
	"stable@vger.kernel.org, Sasha Levin" <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 365/373] net: dsa: mv88e6xxx: enable PVT for 6321 switch
Date: Tue, 29 Apr 2025 18:44:02 +0200
Message-ID: <20250429161138.144025304@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5639,6 +5639,7 @@ static const struct mv88e6xxx_info mv88e
 		.g1_irqs = 8,
 		.g2_irqs = 10,
 		.atu_move_port_mask = 0xf,
+		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,



