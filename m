Return-Path: <stable+bounces-82241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA7E994BF2
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75CF1B294E9
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DC21DE3AE;
	Tue,  8 Oct 2024 12:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ddcY3I9t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D6C183CB8;
	Tue,  8 Oct 2024 12:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391606; cv=none; b=hlXMfFG9PKQN0H4b1K7UuaDvIoVXbfN7A0WNeKh6ZWlepC/+WH42nc9HYiEwwXKdTxoFhGrBU5jeJpo4GO89xHJp1bAGCcnfMY8OfJtzTQI5xB+IamfQr775PeOWqW7ZGrb5rG0wGBX25+49xOirvv7g9taQxNI0Lbj1fLbJIcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391606; c=relaxed/simple;
	bh=xVWB/fgM1K3DIvTl6Xa8ufyNZuYfw0nNd/YF4DUJDy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwffOvgCwUICapIFzjuZcIWxG0ViF0PPnJAdvV3izpVkLQcKPT6EduIA/+XFHHfqkmGQqgSzPKAxg4sS4+kRNQNUYtQtu0PNQ4K5bGhgpSt2Rtsi+o6mrIt2EYuqe9Sz0Jt9DLerMs9G9DX7nMGYFY2+C6Vp7zg/lPHhllDO5jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ddcY3I9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9F2C4CEC7;
	Tue,  8 Oct 2024 12:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391606;
	bh=xVWB/fgM1K3DIvTl6Xa8ufyNZuYfw0nNd/YF4DUJDy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ddcY3I9teCett4ZxB7zVlJKhLkOC1XNrTCNZO8KpNypCEK21mPNo+Bx/iV7xctQAL
	 eqk/m42z0ZSbp0SB2AFWaqKQi48tK9fHMzZARB4o708uFGGdF4iKUT4XtsnsyT2ZpS
	 n8DHLblwReMhmIlE5GNd5vVZfUNd14vetQ2PQbnE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 140/558] virt: sev-guest: Ensure the SNP guest messages do not exceed a page
Date: Tue,  8 Oct 2024 14:02:50 +0200
Message-ID: <20241008115707.874439729@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikunj A Dadhania <nikunj@amd.com>

[ Upstream commit 2b9ac0b84c2cae91bbaceab62df4de6d503421ec ]

Currently, struct snp_guest_msg includes a message header (96 bytes) and
a payload (4000 bytes). There is an implicit assumption here that the
SNP message header will always be 96 bytes, and with that assumption the
payload array size has been set to 4000 bytes - a magic number. If any
new member is added to the SNP message header, the SNP guest message
will span more than a page.

Instead of using a magic number for the payload, declare struct
snp_guest_msg in a way that payload plus the message header do not
exceed a page.

  [ bp: Massage. ]

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240731150811.156771-5-nikunj@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/sev.h              | 2 +-
 drivers/virt/coco/sev-guest/sev-guest.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 79bbe2be900eb..ee34ab00a8d6d 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -164,7 +164,7 @@ struct snp_guest_msg_hdr {
 
 struct snp_guest_msg {
 	struct snp_guest_msg_hdr hdr;
-	u8 payload[4000];
+	u8 payload[PAGE_SIZE - sizeof(struct snp_guest_msg_hdr)];
 } __packed;
 
 struct sev_guest_platform_data {
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 6fc7884ea0a11..c86be0cd8ecd2 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -1090,6 +1090,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	void __iomem *mapping;
 	int ret;
 
+	BUILD_BUG_ON(sizeof(struct snp_guest_msg) > PAGE_SIZE);
+
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return -ENODEV;
 
-- 
2.43.0




