Return-Path: <stable+bounces-77273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F820985B56
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36082284D6C
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205B31BD00D;
	Wed, 25 Sep 2024 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIMuMJP6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF8C1BCA19;
	Wed, 25 Sep 2024 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264892; cv=none; b=kjWBos5jlnOyhYldQ8GJviXwcIwHyjGTMSzSWMtR1t1Nh7H/S4EMZ+6emBu9HONqK0HhVItHLIdlEg8w2i4Yb3DE3q9AWfaJ3UhUwQJaZM4zBQt5H6A5dHVNKYLunBMA1wZ3Yj639QfKd80p9R2SyfgBmzHVewckOAtD5xhNgHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264892; c=relaxed/simple;
	bh=adr8yJDDImfJnU87oS+UW/D+ifNUAU6Fq11UOhAbFZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H96kMavDMkpJEDKmMou1wSas6V3qZAbREkO/pIFMp7qrKun2paRjEQnjeMcYglxAsa4Wk2tBdzaaPH3aRVjuIEO0lYbpr0k1G3nz4N2A7NNzkk7I9C1+KnOCOd2A/VnjYLlULE8d6WqTz4QN6NhlB0rgMymbLlP2Qcrad7DwfQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIMuMJP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A564EC4CEC7;
	Wed, 25 Sep 2024 11:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264892;
	bh=adr8yJDDImfJnU87oS+UW/D+ifNUAU6Fq11UOhAbFZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bIMuMJP6r5ud0JWo91QDTZUxedPquPHqPW36unGevOzbRQVB5AjhrMN5dAHiw1LqK
	 L8C8ea/Kfz9gXJcB7H8jo+KbEmVflN9re9entmACrZ4wM++iu2y14Wmu32SJIigbI/
	 RAGpkLq40HqqB4HnDGCY+H53K2vC9eCQyIDfrcGpPAJclAuRUe/0emwz0WreYCzT7V
	 q3a3e6bjwjaIuv5KL6OkqEg7sjF4KtSzKwHfFqW3n4LNfh8yGE3L8Bn/EA6CvRGSBH
	 bn4XlB42oqRrWxW9byP8dGIahsajRv7gv2uo9szbZqN/jr+eyxlXiy/TBIk38ZVLS1
	 +swS28mecFzQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: aln8 <aln8un@gmail.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 175/244] platform/x86/amd: pmf: Add quirk for TUF Gaming A14
Date: Wed, 25 Sep 2024 07:26:36 -0400
Message-ID: <20240925113641.1297102-175-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: aln8 <aln8un@gmail.com>

[ Upstream commit 06369503d644068abd9e90918c6611274d94c126 ]

The ASUS TUF Gaming A14 has the same issue as the ROG Zephyrus G14
where it advertises SPS support but doesn't use it.

Signed-off-by: aln8 <aln8un@gmail.com>
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Link: https://lore.kernel.org/r/20240912073601.65656-1-aln8un@gmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmf/pmf-quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/amd/pmf/pmf-quirks.c b/drivers/platform/x86/amd/pmf/pmf-quirks.c
index 48870ca52b413..7cde5733b9cac 100644
--- a/drivers/platform/x86/amd/pmf/pmf-quirks.c
+++ b/drivers/platform/x86/amd/pmf/pmf-quirks.c
@@ -37,6 +37,14 @@ static const struct dmi_system_id fwbug_list[] = {
 		},
 		.driver_data = &quirk_no_sps_bug,
 	},
+	{
+		.ident = "ASUS TUF Gaming A14",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FA401W"),
+		},
+		.driver_data = &quirk_no_sps_bug,
+	},
 	{}
 };
 
-- 
2.43.0


