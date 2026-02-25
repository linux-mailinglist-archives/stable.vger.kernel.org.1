Return-Path: <stable+bounces-218503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNRwDGNSnmm6UgQAu9opvQ
	(envelope-from <stable+bounces-218503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:37:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A322618F340
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8043D30A572A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AAE251793;
	Wed, 25 Feb 2026 01:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lYY4G67D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2FB23D7CF;
	Wed, 25 Feb 2026 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983334; cv=none; b=k2JImEI9yVd2AZYD3pmTvq35SDERRCaZIc0yKIt7I8RyvjPhidihj+GBUYW+Ii2mbu4/0gzIzExlqVtjfkO/DE74vN7ciLOtVRL/FP+lXj415dkYBqjo82J1Bhg1hoqFcLXd1bqRCtxfVgVmJlsWiKDHlS1cGCSpbIqKUODEgKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983334; c=relaxed/simple;
	bh=8O7jdvcHnqDHkCzIC6/aX5AuhZDUTvZfd+4BQcGKeFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrzQpKFCG+aqHN44MnYaagrf61mSZI5hKXSdewTyzH8lNbjpQ6cF8zaKM7pefuZM8Q4dt23WO76c9BnMIT1CmRo5FAtdZxGQdfri549lkEty5giGnBmwi4xPnh0XJU7M1aq4d+iVV4DUokCOmnTcIpZAjjHovWl+2wJH4m6Cdu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lYY4G67D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DE1C116D0;
	Wed, 25 Feb 2026 01:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983334;
	bh=8O7jdvcHnqDHkCzIC6/aX5AuhZDUTvZfd+4BQcGKeFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lYY4G67DmFT8vxLy0WWDGdOrFEieGnRtFbtvLxLgEik7Ulm8s1gxdg19sqzWT+YFg
	 24qK44dp+IayaQnZ0LD1j2wgEJjg2sLrA3YFnib6wgMG/2Scwf8biMR/4ZhKt+VFCX
	 gw7j3zcWJvl7vsY/S0+SUgMCiTTlBIsEIyBCRQ88=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Malaya Kumar Rout <mrout@redhat.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 465/781] tools/power/x86/intel-speed-select: Fix file descriptor leak in isolate_cpus()
Date: Tue, 24 Feb 2026 17:19:34 -0800
Message-ID: <20260225012411.228290056@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218503-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: A322618F340
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Malaya Kumar Rout <mrout@redhat.com>

[ Upstream commit 56c17ee151c6e1a73d77e15b82a8e2130cd8dd16 ]

The file descriptor opened in isolate_cpus() when (!level) is true was
not being closed before returning, causing a file descriptor leak in
both the error path and the success path.

When write() fails at line 950, the function returns at line 953 without
closing the file descriptor. Similarly, on success, the function returns
at line 956 without closing the file descriptor.

Add close(fd) calls before both return statements to fix the resource
leak. This follows the same pattern used elsewhere in the same function
where file descriptors are properly closed before returning (see lines
1005 and 1027).

Fixes: 997074df658e ("tools/power/x86/intel-speed-select: Use cgroup v2 isolation")
Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/intel-speed-select/isst-config.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 558138eea75e9..d00d15490a98c 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -950,9 +950,11 @@ int isolate_cpus(struct isst_id *id, int mask_size, cpu_set_t *cpu_mask, int lev
 		ret = write(fd, "member", strlen("member"));
 		if (ret == -1) {
 			printf("Can't update to member\n");
+			close(fd);
 			return ret;
 		}
 
+		close(fd);
 		return 0;
 	}
 
-- 
2.51.0




