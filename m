Return-Path: <stable+bounces-173229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7710B35CB4
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DFCD3678D7
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A7A34A333;
	Tue, 26 Aug 2025 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a/DCHHeC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4E733439A;
	Tue, 26 Aug 2025 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207704; cv=none; b=ZGHCfREqjteA81XHboqEW6j9dX1vrXatC0OaFw06XXG9dukooqFOB4Un/tvW65WmKu59Lpy/GDs8O7wYe2/aINLvnhwPYOPJQz360YoVequJwojSiKgShuKC4yV6QLlsL/u9diERPkiuHuBdByOrt04+QRMyAr88BiNr+BQn6qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207704; c=relaxed/simple;
	bh=wiuu8j/CdOBLRVP7wno3bVDk8k7vPU2xAOUTT7rXOWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQNK4aCcU8SnYOiZzW9s4IexIP1EdV7KtIadO+rdJ2tidxLVQC1JUT355R+38iOJl5WVmJjYzEVZsSF8fSTV1FqBb0IUkOaxIubMistWeySpqRzvomqBuDM+5UUnmf7+0tzQued7NgtfSnETb3gYmArsC4cSC30NlPaeiPiGrAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a/DCHHeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4E1C4CEF1;
	Tue, 26 Aug 2025 11:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207703;
	bh=wiuu8j/CdOBLRVP7wno3bVDk8k7vPU2xAOUTT7rXOWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a/DCHHeCux4/wbFl9WSyQv0ap8Mnx1l61VbMHivkUkdfWTLqZRIHgmfBiI0qrt2a2
	 9MdG1TXS1+nStCSuZ6gikF8C6BsaKLbX0fO1qMSE3tCKe/SaduWeiO8WxtL9PwUCXi
	 rsooEv6KGgsIj/+4nnlfZxOFczWqY4MDLwYHrzR0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.16 254/457] platform/x86/intel-uncore-freq: Check write blocked for ELC
Date: Tue, 26 Aug 2025 13:08:58 +0200
Message-ID: <20250826110943.635143730@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

commit dff6f36878799a5ffabd15336ce993dc737374dc upstream.

Add the missing write_blocked check for updating sysfs related to uncore
efficiency latency control (ELC). If write operation is blocked return
error.

Fixes: bb516dc79c4a ("platform/x86/intel-uncore-freq: Add support for efficiency latency control")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250727210513.2898630-1-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -191,9 +191,14 @@ static int uncore_read_control_freq(stru
 static int write_eff_lat_ctrl(struct uncore_data *data, unsigned int val, enum uncore_index index)
 {
 	struct tpmi_uncore_cluster_info *cluster_info;
+	struct tpmi_uncore_struct *uncore_root;
 	u64 control;
 
 	cluster_info = container_of(data, struct tpmi_uncore_cluster_info, uncore_data);
+	uncore_root = cluster_info->uncore_root;
+
+	if (uncore_root->write_blocked)
+		return -EPERM;
 
 	if (cluster_info->root_domain)
 		return -ENODATA;



