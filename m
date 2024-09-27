Return-Path: <stable+bounces-78025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 446149884B6
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7592B1C21C3A
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4233C18BC3B;
	Fri, 27 Sep 2024 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bhcRUN76"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B7B18C034;
	Fri, 27 Sep 2024 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440215; cv=none; b=iliKidwembCkT9Yc8KpIfleNEIn2bnSxJBz6VhfNxzNb/ECJe5uW2mj7oEPrzYnlir3v9Sxv5pzaQgTmBrdQ057iSD8UPGH0WOCipdZCryOcwpD4Ya5DX4u83FOLg6452MkOLgwepNb7FwVYmw1Zjbq4JhNXbNwh3RrH0IrXbCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440215; c=relaxed/simple;
	bh=YiecAvrW3+lZtZMp2zfUMWu/Abw3LMehK588afuSsg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JheDaPC+5JGQE3KS2LiRjhnodZ++Y3uliI1CkUUrdMpLV1D4RUGqoJUw70VxVdFx8MSDGr2qaEtIFLr39FCTYtJiA8xsX3+UmXC7WQbRqshqfRiU5Ge5GZfGpPKachiOViGgisDoSOVg4FhrKq7Kz5fE+Pqaeudx3fejYgozx9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bhcRUN76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8C6C4CEC4;
	Fri, 27 Sep 2024 12:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727440214;
	bh=YiecAvrW3+lZtZMp2zfUMWu/Abw3LMehK588afuSsg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bhcRUN76setXgB0tfqRYX3RBL+HnCNSMG+jnKUvC+E/LYRZeQAWPWJvtG5hbv/pr/
	 KVtBMW4C0I+xqw2vFYCAOk2cQxdZsTA8qMUNRYb8lCY0xHNa/PdXaBxMrGgOS2zTx+
	 +Ax2SBtU5oOWqp3Z+VpdjcoUo3E0b2OLsCgC5Q1U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 04/12] powercap/intel_rapl: Add support for AMD family 1Ah
Date: Fri, 27 Sep 2024 14:24:07 +0200
Message-ID: <20240927121715.410913930@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927121715.213013166@linuxfoundation.org>
References: <20240927121715.213013166@linuxfoundation.org>
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

From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

[ Upstream commit 166df51097a258a14fe9e946e2157f3b75eeb3c2 ]

AMD Family 1Ah's RAPL MSRs are identical to Family 19h's,
extend Family 19h's support to Family 1Ah.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Link: https://patch.msgid.link/20240719101234.50827-1-Dhananjay.Ugwekar@amd.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 3cffa6c795388..8b7a5a31e8c17 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1285,6 +1285,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 
 	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd),
 	X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_amd),
+	X86_MATCH_VENDOR_FAM(AMD, 0x1A, &rapl_defaults_amd),
 	X86_MATCH_VENDOR_FAM(HYGON, 0x18, &rapl_defaults_amd),
 	{}
 };
-- 
2.43.0




