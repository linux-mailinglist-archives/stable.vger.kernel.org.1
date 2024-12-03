Return-Path: <stable+bounces-97309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE0E9E241D
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F70163F32
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A4F1FBC90;
	Tue,  3 Dec 2024 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gK8czfhu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12CB1F755B;
	Tue,  3 Dec 2024 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240114; cv=none; b=nCzS+f5VCrstKWjh343G6KfiDe0ELRIs/td+fg0RJUpOleiFbBtgq2sU/l3VgyuarRS+PZ5TdGiXi6/kYmrMo+rkD7aJGXqap/NW/JLyLZgHFrYJbkjQZjwHlLjZVlimUqkNzirwfuFfZZ8u7eIkGdmQeS7e8A0bVcq8clwiBRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240114; c=relaxed/simple;
	bh=/6j4Zuaft521yQ7obX5JXIS0aRFtxuRHTb2rAtqbak8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WktamWBabbceboJIZztq4Q7tqzqmO8bCEe7EpP37mshzzlWP0Ue49HBAGFBZBiboB123hSpMv839XqZUwoYHHLzGjSn5trNkcOK4KtwHuzerg/FUFz0vUP3eAFmKyGdtnhojAqjm0Q6yKdypg1DegiDz4FbQ9Q115r9YLUqo3yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gK8czfhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BFEC4CED6;
	Tue,  3 Dec 2024 15:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733240113;
	bh=/6j4Zuaft521yQ7obX5JXIS0aRFtxuRHTb2rAtqbak8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gK8czfhujk23cFkuWlcMeNFPpNo3yKYS3KiLHp2kr+HVIqHVEQ0uP7tXV+kMycmTF
	 n2udVjzxgI5g1obOmRo0Kr7Q70wDGDhU6uIvjkT5QJgqXyC827kFKxTkajzwHE3u22
	 hqeN1vnU0dT7qMhEFbtRc7O8sazwrXI/C7hLrT1Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 027/826] acpi/arm64: Adjust error handling procedure in gtdt_parse_timer_block()
Date: Tue,  3 Dec 2024 15:35:54 +0100
Message-ID: <20241203144744.520393642@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksandr Mishin <amishin@t-argos.ru>

[ Upstream commit 1a9de2f6fda69d5f105dd8af776856a66abdaa64 ]

In case of error in gtdt_parse_timer_block() invalid 'gtdt_frame'
will be used in 'do {} while (i-- >= 0 && gtdt_frame--);' statement block
because do{} block will be executed even if 'i == 0'.

Adjust error handling procedure by replacing 'i-- >= 0' with 'i-- > 0'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a712c3ed9b8a ("acpi/arm64: Add memory-mapped timer support in GTDT driver")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Acked-by: Hanjun Guo <guohanjun@huawei.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Aleksandr Mishin <amishin@t-argos.ru>
Link: https://lore.kernel.org/r/20240827101239.22020-1-amishin@t-argos.ru
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/arm64/gtdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index c0e77c1c8e09d..eb6c2d3603874 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -283,7 +283,7 @@ static int __init gtdt_parse_timer_block(struct acpi_gtdt_timer_block *block,
 		if (frame->virt_irq > 0)
 			acpi_unregister_gsi(gtdt_frame->virtual_timer_interrupt);
 		frame->virt_irq = 0;
-	} while (i-- >= 0 && gtdt_frame--);
+	} while (i-- > 0 && gtdt_frame--);
 
 	return -EINVAL;
 }
-- 
2.43.0




