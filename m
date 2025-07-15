Return-Path: <stable+bounces-162075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98819B05B6D
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE4917BFE6
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDF42E2EEE;
	Tue, 15 Jul 2025 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XEZicZsi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD4B274FDB;
	Tue, 15 Jul 2025 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585606; cv=none; b=XMTDR2sahXt4COZkl9fQq+eLpHTG2JpSGGiovvshhCgbKt09EF1vDofRKMM31uoQ7o79NEqTUYQUYJSJDOI4trFBrFHlcT3c+T0QmBpHJHeLjVQVFXIJ3j8sotNvoHcyKp8ZspAjxQr+g/0xAWzcyXfZNUs9y6blvIl+fPbfon4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585606; c=relaxed/simple;
	bh=9kJC49LgX0qrLZlepf+waZ5NeCMO+j/l8EMMEtm6V/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCgO7gJkJwe/p/M/vRjmMzq6GBwUIQxuZS33iXMFv6eSCA0/9stcRyz/JNKYYTfRuTPFTaAnKbVWDdFN1eoL1tu7FcEkWApWdlT7TPCF1jzqUnqjY46jufm07j3VJb3DzGDkZvOF3dNSXzrDqMcGZQKFsTL5M2pnHA/phph9YCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XEZicZsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512BEC4CEE3;
	Tue, 15 Jul 2025 13:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752585606;
	bh=9kJC49LgX0qrLZlepf+waZ5NeCMO+j/l8EMMEtm6V/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XEZicZsiNvz1QQ7R1tswgTpGj75aH+gMxogzvBZFg/hSQig+RdELNS/lV3BIWlvn2
	 bQ2aoxANoGK8mjfRL3coPbYJsx2+oMEWlYmCqLjaOmlUDrgQhcNSknmwN2p6AFRDaj
	 k7USNcgsYPWOQv3sKOP84xlyn61Yg7YDgkGqLCpg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12 103/163] ASoC: Intel: sof-function-topology-lib: Print out the unsupported dmic count
Date: Tue, 15 Jul 2025 15:12:51 +0200
Message-ID: <20250715130812.991931552@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130808.777350091@linuxfoundation.org>
References: <20250715130808.777350091@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

commit 16ea4666bbb7f5bd1130fa2d75631ccf8b62362e upstream.

It is better to print out the non supported num_dmics than printing that
it is not matching with 2 or 4.

Fixes: 2fbeff33381c ("ASoC: Intel: add sof_sdw_get_tplg_files ops")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Link: https://patch.msgid.link/20250619104705.26057-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/common/sof-function-topology-lib.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/soc/intel/common/sof-function-topology-lib.c
+++ b/sound/soc/intel/common/sof-function-topology-lib.c
@@ -73,7 +73,8 @@ int sof_sdw_get_tplg_files(struct snd_so
 				break;
 			default:
 				dev_warn(card->dev,
-					 "only -2ch and -4ch are supported for dmic\n");
+					 "unsupported number of dmics: %d\n",
+					 mach_params.dmic_num);
 				continue;
 			}
 			tplg_dev = TPLG_DEVICE_INTEL_PCH_DMIC;



