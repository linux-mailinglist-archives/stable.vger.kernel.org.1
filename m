Return-Path: <stable+bounces-138185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8750FAA173F
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA3E9847A3
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882EF253322;
	Tue, 29 Apr 2025 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tt5Sb3NA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460292522B6;
	Tue, 29 Apr 2025 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948442; cv=none; b=k0zVNrIoG+KrQu002/rbN0Pi5OWal2uNWvyA/A3jiet6uThrxRPZ52v34gSBUvivigkzxoruBm4loEVzEAMA1ZSB4vGizjwBSpWLN/YQJV2Hne7sI7LgIir9dFO9JN1QaGBq8LAetua+ffJWL8otaDek/rFLP7Jjq6RWnGqWV28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948442; c=relaxed/simple;
	bh=6sZYdJdUlvg5Pinf9FbBpbk7csCsL4dVbBoBNt5Txak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hz/UjQ8Xk2NzHk36xBn2TiyWHqHEiWiW1JsUM+EX/YfNgASGqu7cF0k7zkRzb1mXlrZDKdWktOf3EWCRiEGJP8yAtOpXzFD0SbsVFc/3/ULVgj7LYDCWGc7hWOmgVDbhk++EHYCzPp67fCxILvfR1w3/ybQlQIFOQdrabXG6TQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tt5Sb3NA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C214BC4CEE3;
	Tue, 29 Apr 2025 17:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948442;
	bh=6sZYdJdUlvg5Pinf9FbBpbk7csCsL4dVbBoBNt5Txak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tt5Sb3NAvpn7lz+SoLEoj5p6c/uxXgzzAcFZfrd9f7dufLCUSWpu4Bfc8FzCSFb9v
	 Gc8+FxHOYs6KYxTC56sqPsDdil/EH4QSG/gvt1Ez3x80jKHt+drBVzzBDURE+L7TdU
	 TyzMZI38qUF/I2MlET8L3tE0Rb0fz+6KIm0QmY1Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org,
	"stable@vger.kernel.org, Sasha Levin" <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 6.12 264/280] Revert "net: dsa: mv88e6xxx: fix internal PHYs for 6320 family"
Date: Tue, 29 Apr 2025 18:43:25 +0200
Message-ID: <20250429161125.933094877@linuxfoundation.org>
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

From: "Marek Beh�n" <kabel@kernel.org>

This reverts commit 2b27df6852444b76724f5d425826a38581d63407.

For stable 6.12 it was misapplied to wrong entries of the
`mv88e6xxx_table` array: instead of the MV88E6320 and MV88E6321 entries
it was applied to the MV88E6240 and MV88E6352 entries.

Signed-off-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6182,8 +6182,7 @@ static const struct mv88e6xxx_info mv88e
 		.num_databases = 4096,
 		.num_macs = 8192,
 		.num_ports = 7,
-		.num_internal_phys = 2,
-		.internal_phys_offset = 3,
+		.num_internal_phys = 5,
 		.num_gpio = 15,
 		.max_vid = 4095,
 		.max_sid = 63,
@@ -6377,8 +6376,7 @@ static const struct mv88e6xxx_info mv88e
 		.num_databases = 4096,
 		.num_macs = 8192,
 		.num_ports = 7,
-		.num_internal_phys = 2,
-		.internal_phys_offset = 3,
+		.num_internal_phys = 5,
 		.num_gpio = 15,
 		.max_vid = 4095,
 		.max_sid = 63,



