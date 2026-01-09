Return-Path: <stable+bounces-207519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4B5D0A006
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BA5E3140FAA
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D93935B156;
	Fri,  9 Jan 2026 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EjSeRK9t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A7C35B138;
	Fri,  9 Jan 2026 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962284; cv=none; b=ECQ2fsMk+FH9DvQe0z31S8LYm7p5hmwNvLtZFYDOoXFJiciRrYJb9GbbBCJj13VEDmBcoTCfb6ydKH5fAyXcdq9yho3BqCRv3OXxKTWHZpFu/X5fgaO6ZiqYFUuB6IOVD8U6WEfecTguqaDQetHMPELft0ApTJJB786su+fp318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962284; c=relaxed/simple;
	bh=cAMeCkK4Sv7H+oDG0DdD5Bej7Awe4UH+eMbx5CxfNsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmiU6LTm2uYx7JHbdCnoESBxXg05BEmZx+RxZ08Bxsq2R5fD5DRb0oj/4oTUgEqZ7GFZJU0818azDaMK33rn28ABCGf4fhwT6raLNSdJfwL/FhHMNEehyDn02QyREwKs26G0HyzPWYj9kDX0MNIiK8+LITivtsRhVnfKgp340Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EjSeRK9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49066C19423;
	Fri,  9 Jan 2026 12:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767962284;
	bh=cAMeCkK4Sv7H+oDG0DdD5Bej7Awe4UH+eMbx5CxfNsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EjSeRK9tcrBHi8mmBaIIDQygn2g8pHkRpbifiM5a70qdtQmi8we+PMVQ4OjShew/3
	 1IV1vKek9xL72OwELGd5JXtdB/EC2wzZTEr9b7d/VTnvAULuwf+QVduvY9M+wC0bGe
	 8lTYmbQrDEmrdjz1OhiaLW38atXSdek3GgX/OKoI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 310/634] iio: adc: ti_am335x_adc: Limit step_avg to valid range for gcc complains
Date: Fri,  9 Jan 2026 12:39:48 +0100
Message-ID: <20260109112129.196872302@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
References: <20260109112117.407257400@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pei Xiao <xiaopei01@kylinos.cn>

[ Upstream commit c9fb952360d0c78bbe98239bd6b702f05c2dbb31 ]

FIELD_PREP() checks that a value fits into the available bitfield, add a
check for step_avg to fix gcc complains.

which gcc complains about:
  drivers/iio/adc/ti_am335x_adc.c: In function 'tiadc_step_config':
  include/linux/compiler_types.h:572:38: error: call to
'__compiletime_assert_491' declared with attribute error: FIELD_PREP: value
too large for the field include/linux/mfd/ti_am335x_tscadc.h:58:29: note:
in expansion of macro 'FIELD_PREP'
    #define STEPCONFIG_AVG(val) FIELD_PREP(GENMASK(4, 2), (val))
                                ^~~~~~~~~~
drivers/iio/adc/ti_am335x_adc.c:127:17: note: in expansion of macro 'STEPCONFIG_AVG'
	stepconfig = STEPCONFIG_AVG(ffs(adc_dev->step_avg[i]) - 1)

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510102117.Jqxrw1vF-lkp@intel.com/
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ti_am335x_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 3ac253a27dd9..109adff1370e 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -124,7 +124,7 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
 
 		chan = adc_dev->channel_line[i];
 
-		if (adc_dev->step_avg[i])
+		if (adc_dev->step_avg[i] && adc_dev->step_avg[i] <= STEPCONFIG_AVG_16)
 			stepconfig = STEPCONFIG_AVG(ffs(adc_dev->step_avg[i]) - 1) |
 				     STEPCONFIG_FIFO1;
 		else
-- 
2.51.0




