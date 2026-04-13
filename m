Return-Path: <stable+bounces-236193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MInGFvoU3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:08:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DB23EE5AE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C9AD304BC87
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48E1282F3D;
	Mon, 13 Apr 2026 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wUM0IvPU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FB9281357;
	Mon, 13 Apr 2026 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096282; cv=none; b=i579a0h9NV7uwQHHwSgrb37C3h7UuYeGIrSxEADsQcek2vOh4fUUzEhsNbddSu2Z0pzmQ4oMTzxLGL4dwzjwCwG3SzGJIPxqD+nYw9dcDhOt9V4iVTbLNPWoye58cf9VLMaQaNuZaUhQQBYPXc191EU+xXadfz67+UJnk64scDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096282; c=relaxed/simple;
	bh=sXzsWrdiFkuLOAoIuyc/arWGxgwBSiKrIIwICOc3r70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCPZelBj9Wljk+m45kxBRvVXqSHAlvfWDMSC/8BeQFs953GM3pRvNtiVOrytpSQrlimtj0bprxX5585FtdNujmsyw2P4VvDRfUqtV+RbixpEyip7//+yo+YSQF8hLHmzYE6wUDUhDBQF3shopmBcq90jiEfn+LrVNVJXV+pcYi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wUM0IvPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D806EC2BCAF;
	Mon, 13 Apr 2026 16:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096282;
	bh=sXzsWrdiFkuLOAoIuyc/arWGxgwBSiKrIIwICOc3r70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wUM0IvPU4iefYDICEXMIkoF27Ai3TXC5HhylYXhORRIheGQF2jXE0tQ48zAOx9Wga
	 w0DMyP5ofIlXRzaJHWWVyNsht/+ZgvlufABaP6M+dienVbrfDHK6A7iSl7y8EC/oTS
	 vjQPvCvh1X1KpAQKf+aYO+Q4fMLfeLUDE22YLbto=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.19 30/86] platform/x86/intel-uncore-freq: Handle autonomous UFS status bit
Date: Mon, 13 Apr 2026 17:59:37 +0200
Message-ID: <20260413155732.699411844@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.568515178@linuxfoundation.org>
References: <20260413155731.568515178@linuxfoundation.org>
User-Agent: quilt/0.69
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236193-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: D3DB23EE5AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

commit 4ab604b3f3aa8dcccc7505f5d310016682a99d5f upstream.

When the AUTONOMOUS_UFS_DISABLED bit is set in the header, the ELC
(Efficiency Latency Control) feature is non-functional. Hence, return
error for read or write to ELC attributes.

Fixes: bb516dc79c4a ("platform/x86/intel-uncore-freq: Add support for efficiency latency control")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260325192909.3417322-1-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -537,6 +537,7 @@ static void set_cdie_id(int domain_id, s
 #define UNCORE_VERSION_MASK			GENMASK_ULL(7, 0)
 #define UNCORE_LOCAL_FABRIC_CLUSTER_ID_MASK	GENMASK_ULL(15, 8)
 #define UNCORE_CLUSTER_OFF_MASK			GENMASK_ULL(7, 0)
+#define UNCORE_AUTONOMOUS_UFS_DISABLED		BIT(32)
 #define UNCORE_MAX_CLUSTER_PER_DOMAIN		8
 
 static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
@@ -598,6 +599,7 @@ static int uncore_probe(struct auxiliary
 
 	for (i = 0; i < num_resources; ++i) {
 		struct tpmi_uncore_power_domain_info *pd_info;
+		bool auto_ufs_enabled;
 		struct resource *res;
 		u64 cluster_offset;
 		u8 cluster_mask;
@@ -647,6 +649,8 @@ static int uncore_probe(struct auxiliary
 			continue;
 		}
 
+		auto_ufs_enabled = !(header & UNCORE_AUTONOMOUS_UFS_DISABLED);
+
 		/* Find out number of clusters in this resource */
 		pd_info->cluster_count = hweight8(cluster_mask);
 
@@ -689,7 +693,9 @@ static int uncore_probe(struct auxiliary
 
 			cluster_info->uncore_root = tpmi_uncore;
 
-			if (TPMI_MINOR_VERSION(pd_info->ufs_header_ver) >= UNCORE_ELC_SUPPORTED_VERSION)
+			if ((TPMI_MINOR_VERSION(pd_info->ufs_header_ver) >=
+			     UNCORE_ELC_SUPPORTED_VERSION) &&
+			    auto_ufs_enabled)
 				cluster_info->elc_supported = true;
 
 			ret = uncore_freq_add_entry(&cluster_info->uncore_data, 0);



