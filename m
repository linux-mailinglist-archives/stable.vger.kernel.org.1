Return-Path: <stable+bounces-136831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF1EA9EB47
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 10:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F2E07A49C5
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 08:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBD025E81C;
	Mon, 28 Apr 2025 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOseDqzK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF2218CC15
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 08:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745830675; cv=none; b=ICxuqs7JNVTH+j19P55q2bTrvlubL8EbFL9JSmYffupUxZM0GTPjsMBzaV/DIL8IsCc/O0IU569fN2AFVJn0nlVHj9FX+Ju1jzR59i4jpHNMVS6fqASISmStMFCqvnyVfwP+KYjQmrF8QBeSEDTfpv2iDE7Q+CXzfqEsJ4zWmzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745830675; c=relaxed/simple;
	bh=NYbjMJQWi6j4iho6BrxZHAeyI4ktuWUC8DmVPyIrvG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFhXeJ+4xAWUyEZfOI8VCQJp4U9qzjwipn7Bro5b9RYAihszjr15JsXKQnXJDaXGUPRm77WBd47TRwjfgrWT7xwUbnBvtFmOHzrhxVapXLIL2GG8q/fBRaKYM7QQsGOlVKzstqSiy57JrHWz1K6hUnEhRwXogWWHm6Wo+khYI6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOseDqzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB96C4CEEF;
	Mon, 28 Apr 2025 08:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745830674;
	bh=NYbjMJQWi6j4iho6BrxZHAeyI4ktuWUC8DmVPyIrvG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MOseDqzK4FS0TEiTjaaGdDm8XBE3yT1aL8CP4c9x55E8aRYRLe7fa+XNicQjH40lt
	 p1fDuXnJIftUtHG20tEe/zkxj68xTS+Sx49PpHKrGq+6b11Z/jmi8zS64P5VkdxFRe
	 L2eZczdVY1eqAa2ggVei6OyyAhUgwWWQvCImHJWVzkjp0+rpGWTc1ZI1zhKZvGG3nj
	 rKPB3ojMhumlVQKB15rA0lhhX6og2FGc7E5KMIo7v8bn7Pq07rcTYni6MxJymOjanb
	 8nsgqHkYvhsKsfSP0Kg68ElSZxYSo04rIMHVuRXuKf+g2BLNSK9AYBMtuUY5FB1T0W
	 JcSJql3BWrNfA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y 3/3] net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
Date: Mon, 28 Apr 2025 10:57:44 +0200
Message-ID: <20250428085744.19762-3-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428085744.19762-1-kabel@kernel.org>
References: <20250428085744.19762-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit a2ef58e2c4aea4de166fc9832eb2b621e88c98d5 upstream.

Commit f3a2cd326e44 ("net: dsa: mv88e6xxx: introduce .port_set_policy")
did not add the .port_set_policy() method for the 6320 family. Fix it.

Fixes: f3a2cd326e44 ("net: dsa: mv88e6xxx: introduce .port_set_policy")
Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250317173250.28780-5-kabel@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 819a03693412..170d2e28c2b4 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4149,6 +4149,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.port_set_link = mv88e6xxx_port_set_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_egress_floods = mv88e6352_port_set_egress_floods,
 	.port_set_ether_type = mv88e6351_port_set_ether_type,
@@ -4192,6 +4193,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.port_set_link = mv88e6xxx_port_set_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_egress_floods = mv88e6352_port_set_egress_floods,
 	.port_set_ether_type = mv88e6351_port_set_ether_type,
-- 
2.49.0


