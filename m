Return-Path: <stable+bounces-149040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E612ACAFFF
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F5A1BA3038
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 13:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E322576;
	Mon,  2 Jun 2025 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u9MNsgWV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B6D221739;
	Mon,  2 Jun 2025 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872701; cv=none; b=BqpUajCKpEQsNdKt2vmM5AJMGEtxc7jUX+hLjUF2Ptzws1+4aD9DD17A2Pj1+58lSe8IYIYaewgJWGb8nk7s5zibyhwczSEPHwzicxBO/ViQ44FEImvP28vatGiAk2/m8NVWRVamgzRfmhLurS+JNXN01Ja+7w8y96E+5tw1M5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872701; c=relaxed/simple;
	bh=s4bpNvtPW2fxMjT7OYwu7prl27hua/sUYsgirlex09E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcXrLsyRx7USpZkoKriAomerhHj8qAxQmJ5ezfTusSRUzeu1RJ+FsF1/2Y/70leCv34sZPfLyXsqRIcdbyePntOlohEaPPGVC8c3URaB8E8Q0hQr5NY/dbxCaroO+6QrFkk67roG9ldjAxXkdeOSh4uKvePJ7lalTBBAYipPLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u9MNsgWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93627C4CEEB;
	Mon,  2 Jun 2025 13:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748872701;
	bh=s4bpNvtPW2fxMjT7OYwu7prl27hua/sUYsgirlex09E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u9MNsgWVqL1fVEDLzyo9i2rq5q+M3giPlEIykTHE9gdEC4xG07QteQn+LJfFFlbe3
	 HfJD7lh37Q8eJGxd9tMdEze5Ei6Rx2f/zgqB056jBkblQ098vIQh6VXN89R4jf4Kcb
	 MfYRrLsdMao5MI+7yaExCJWwrnkCBBGNGa4HW728=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 6.14 44/73] perf/arm-cmn: Add CMN S3 ACPI binding
Date: Mon,  2 Jun 2025 15:47:30 +0200
Message-ID: <20250602134243.425018518@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134241.673490006@linuxfoundation.org>
References: <20250602134241.673490006@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robin Murphy <robin.murphy@arm.com>

commit 8c138a189f6db295ceb32258d46ac061df0823e5 upstream.

An ACPI binding for CMN S3 was not yet finalised when the driver support
was originally written, but v1.2 of DEN0093 "ACPI for Arm Components"
has at last been published; support ACPI systems using the proper HID.

Cc: stable@vger.kernel.org
Fixes: 0dc2f4963f7e ("perf/arm-cmn: Support CMN S3")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/7dafe147f186423020af49d7037552ee59c60e97.1747652164.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/perf/arm-cmn.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2650,6 +2650,7 @@ static const struct acpi_device_id arm_c
 	{ "ARMHC600", PART_CMN600 },
 	{ "ARMHC650" },
 	{ "ARMHC700" },
+	{ "ARMHC003" },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, arm_cmn_acpi_match);



