Return-Path: <stable+bounces-133861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9954A92804
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0DD4A3251
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613F8261576;
	Thu, 17 Apr 2025 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vjKYfgaV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E7D261568;
	Thu, 17 Apr 2025 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914370; cv=none; b=Tv2qTq9OHFtVJrVYe2CkzYZWuC1tVd2a8vcs0iWmiimkk/wdjsmM7EZmQMMo7j//bEc8dyLCG/SrWnVM35jFddDlzd+cGlugrUETClK+c4tKdmF0Wax4JiAHyP/o1N2uYo8hu6orYyWAcxsb5RZQ0wJV4nb3vuUVR6ofFssafag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914370; c=relaxed/simple;
	bh=33MKyxfejg/GYJPsEZZPdbK5u0n8fDlAjUf4tElKgk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBfyJooVIB2sTK/GeYfYmHrUmkUNdYlp2s51T5S3JcNpjSP6mdbVX7AjgT12Bi6o/i3Cy9jrf1X9SNUy4bz15HvejRbbclamIpJvhSh6/tKg/Y/VvriOJpH8pOGaadyOVmsHRdtU1v1yA97PEpSiMQa9pf9prZvn55B/pbvH8yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vjKYfgaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93554C4CEE4;
	Thu, 17 Apr 2025 18:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914369;
	bh=33MKyxfejg/GYJPsEZZPdbK5u0n8fDlAjUf4tElKgk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vjKYfgaVVUhh1W9++DIKSzOs/Vu7W2aw0UaEpcoY9gsk39V9yDat5w/vVrL0s8dw6
	 s8TrWZNjR97OTLyG8m7RW0zuZmuP7LeLmBLZvq7QU11UnLj2xtowv6rdT0UMwJyO0K
	 /c1dTdNDFDwcC70PaNK2J58PXjvnOwjBjjN3uqUs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 193/414] HID: pidff: Fix 90 degrees direction name North -> East
Date: Thu, 17 Apr 2025 19:49:11 +0200
Message-ID: <20250417175119.202588593@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

[ Upstream commit f98ecedbeca34a8df1460c3a03cce32639c99a9d ]

Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/usbhid/hid-pidff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index a614438e43bd8..6eb7934c8f53b 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -145,7 +145,7 @@ static const u8 pidff_block_load_status[] = { 0x8c, 0x8d, 0x8e};
 #define PID_EFFECT_STOP		1
 static const u8 pidff_effect_operation_status[] = { 0x79, 0x7b };
 
-/* Polar direction 90 degrees (North) */
+/* Polar direction 90 degrees (East) */
 #define PIDFF_FIXED_WHEEL_DIRECTION	0x4000
 
 struct pidff_usage {
-- 
2.39.5




