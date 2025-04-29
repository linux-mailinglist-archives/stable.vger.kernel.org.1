Return-Path: <stable+bounces-137693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 055F3AA1491
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F498188E070
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16A82459FA;
	Tue, 29 Apr 2025 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zjEc+1T1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7022A221DA7;
	Tue, 29 Apr 2025 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946841; cv=none; b=TRN7iEmPyfJ2esjmUyZvKLcZH+xGql3lJr2appjoqK4UNANnP+W2h0PqC5I7VHuvD9bPVD7VQLz3vtNJKOcVKwOeYOgHQMvdTlnuHnhxavj8CWZCghkk+nw3Fj71oSwcHyh/gIauF+hqEKOf8It7Gdq5KQcMbZtZ9Ebu1VZwSYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946841; c=relaxed/simple;
	bh=hNBtf9tMlUXYEzQ8voM5rYacm60gDwns/yC51qYc6WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B40Qc+Q815VYKzdYcAakjd/szL3yEZgtR3aK8Kk8a7AVhWWf7Bq9cj5XkZp8YC6IuwV8MrRfZLsyqYdMbRVybj3rtC8a6gGw4NxGtbyfFDx7nkf5jjdIsF9bYVx+QUjITf99kNRukomwoMiHRzNY+duWhKFDxv1prjRvIuul/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zjEc+1T1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D006CC4CEE3;
	Tue, 29 Apr 2025 17:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946841;
	bh=hNBtf9tMlUXYEzQ8voM5rYacm60gDwns/yC51qYc6WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zjEc+1T1omMv4TgcLuKSedV1ibzQ0pYzhfe15ZBkuceJMLlMegxrAgK7FkMXHretl
	 IjsHgIpU668V5YNTn9R5zPTHnvAtfw4H0GOMYAYSo49+rGfhPhqJUbZ3UxXdCkhfy/
	 lmOlW1Flz+QCsTv4StF08UfsH0vhwcXRYGjVzLrA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Trevor Woerner <twoerner@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 5.10 086/286] thermal/drivers/rockchip: Add missing rk3328 mapping entry
Date: Tue, 29 Apr 2025 18:39:50 +0200
Message-ID: <20250429161111.394028013@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trevor Woerner <twoerner@gmail.com>

commit ee022e5cae052e0c67ca7c5fec0f2e7bc897c70e upstream.

The mapping table for the rk3328 is missing the entry for -25C which is
found in the TRM section 9.5.2 "Temperature-to-code mapping".

NOTE: the kernel uses the tsadc_q_sel=1'b1 mode which is defined as:
      4096-<code in table>. Whereas the table in the TRM gives the code
      "3774" for -25C, the kernel uses 4096-3774=322.

[Dragan Simic] : "After going through the RK3308 and RK3328 TRMs, as
  well as through the downstream kernel code, it seems we may have
  some troubles at our hands.  Let me explain, please.

  To sum it up, part 1 of the RK3308 TRM v1.1 says on page 538 that
  the equation for the output when tsadc_q_sel equals 1 is (4096 -
  tsadc_q), while part 1 of the RK3328 TRM v1.2 says that the output
  equation is (1024 - tsadc_q) in that case.

  The downstream kernel code, however, treats the RK3308 and RK3328
  tables and their values as being the same.  It even mentions 1024 as
  the "offset" value in a comment block for the rk_tsadcv3_control()
  function, just like the upstream code does, which is obviously wrong
  "offset" value when correlated with the table on page 544 of part 1
  of the RK3308 TRM v1.1.

  With all this in mind, it's obvious that more work is needed to make
  it clear where's the actual mistake (it could be that the TRM is
  wrong), which I'll volunteer for as part of the SoC binning project.
  In the meantime, this patch looks fine as-is to me, by offering
  what's a clear improvement to the current state of the upstream
  code"

Link: https://opensource.rock-chips.com/images/9/97/Rockchip_RK3328TRM_V1.1-Part1-20170321.pdf
Cc: stable@vger.kernel.org
Fixes: eda519d5f73e ("thermal: rockchip: Support the RK3328 SOC in thermal driver")
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Link: https://lore.kernel.org/r/20250207175048.35959-1-twoerner@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/rockchip_thermal.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -363,6 +363,7 @@ static const struct tsadc_table rk3328_c
 	{296, -40000},
 	{304, -35000},
 	{313, -30000},
+	{322, -25000},
 	{331, -20000},
 	{340, -15000},
 	{349, -10000},



