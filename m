Return-Path: <stable+bounces-12056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6009831783
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 11:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4704AB21C64
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 10:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327B223741;
	Thu, 18 Jan 2024 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kbFfQBBn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E770C1774B;
	Thu, 18 Jan 2024 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575483; cv=none; b=a1N5/UrCSnwSwtND4xcDCYYY/HIePqUX1jX3tyRfr4krpuN4VJArzXPOQZRDHwmcxYN+r9QdezqAxKECW/XlalBbl07sbl2sI/aWy+9fy6tIIOoYzGaY0SCo07vFG1RvtvWLXMHSd+sNo6/MXRRhWWum2gyEUJbGUI+VgItyM1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575483; c=relaxed/simple;
	bh=ZiX9J+f2ObMrGaDFafDGrEabq8lh6B7JG6IAgiT7K+w=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:User-Agent:X-stable:
	 X-Patchwork-Hint:MIME-Version:Content-Transfer-Encoding; b=qwBSLcrbawJ/c3XRBkfalzbmIXgXAeP2YQYzlguYCH5elCJ3066YONkBLD7Ls2OLtwAqLVnD4OYZRfiGJLuWj537JU0gSknsiRw76s6cMBSgFWt3f4Po67MQGaX1SzowoNBFCk4RY2Jsk00aN5GXyzgkrJkP5lxgIUB+S2EnCHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kbFfQBBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C65EC433F1;
	Thu, 18 Jan 2024 10:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705575482;
	bh=ZiX9J+f2ObMrGaDFafDGrEabq8lh6B7JG6IAgiT7K+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kbFfQBBnEAMHZa06vQ4dApIDKYERDQZohE2+XlLiPET0Fed2q+w2Z6pkK0k/8JLKo
	 uO+Ig5Qq7G030PCG6TKkp7HMG9dqAVkBBym7kpkYU3YVqx41LkuWWrNJLMNctANV7O
	 ull84pTWk9PG5oOsnyiS/5APIrVOaTs9q7k4ddZA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 6.6 148/150] coresight: etm4x: Fix width of CCITMIN field
Date: Thu, 18 Jan 2024 11:49:30 +0100
Message-ID: <20240118104326.911436980@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118104320.029537060@linuxfoundation.org>
References: <20240118104320.029537060@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Clark <james.clark@arm.com>

commit cc0271a339cc70cae914c3ec20edc2a8058407da upstream.

CCITMIN is a 12 bit field and doesn't fit in a u8, so extend it to u16.
This probably wasn't an issue previously because values higher than 255
never occurred.

But since commit 4aff040bcc8d ("coresight: etm: Override TRCIDR3.CCITMIN
on errata affected cpus"), a comparison with 256 was done to enable the
errata, generating the following W=1 build error:

  coresight-etm4x-core.c:1188:24: error: result of comparison of
  constant 256 with expression of type 'u8' (aka 'unsigned char') is
  always false [-Werror,-Wtautological-constant-out-of-range-compare]

   if (drvdata->ccitmin == 256)

Cc: stable@vger.kernel.org
Fixes: 2e1cdfe184b5 ("coresight-etm4x: Adding CoreSight ETM4x driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310302043.as36UFED-lkp@intel.com/
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20231101115206.70810-1-james.clark@arm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -1036,7 +1036,7 @@ struct etmv4_drvdata {
 	u8				ctxid_size;
 	u8				vmid_size;
 	u8				ccsize;
-	u8				ccitmin;
+	u16				ccitmin;
 	u8				s_ex_level;
 	u8				ns_ex_level;
 	u8				q_support;



