Return-Path: <stable+bounces-249489-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC18KVIeDGqoWgUAu9opvQ
	(envelope-from <stable+bounces-249489-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:24:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1845579F36
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75E5B303D168
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 08:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044A63E120A;
	Tue, 19 May 2026 08:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="DFcjKopM"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B0C3E1204;
	Tue, 19 May 2026 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178983; cv=none; b=Bx/yBbNa9Cr6c2vF1ww0QPmVC/ZSphY27kl26WiXo1WNUbzdC+eAzHnfcpSAibrGkuU6TjOvCuR7Q4fM3qL5acrXqLORudCOwDXckT7PcVM2m8CPmkVcFYF9BhkQr3EIqsRwMaqEWawWymVE09UCVb9wvXAzeoSQ84SIYd/xObQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178983; c=relaxed/simple;
	bh=bmiF4hgiYvfm4DpcWrvdshUorT8fJivbWbXfyBprHZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UqhGd2RXGt6pVaIQkGEy513J/+dp7bw/KUvsIVl4B+LwmQjxAUAGWCoyBqqhNls3zB0ZsANYqgKZcDnOidDyPiQWMq1SHon67QEhbq641jurSUVK3Fr7Uti3eohOLmxwira9QfnCRR4xnyj5OagdCs8NdaIz1L5uykWypHQ66l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=DFcjKopM; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779178950;
	bh=N4qacGr6j6nnaxJIu/bwPWo164GQqwran37q3vVYr2o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=DFcjKopMiPrn/Sx0c+Nm5jiwzMxc9khb0bcectoFEJCA772IIqrhGNDADd9KejvUc
	 VxXDFFCDru6wqPyp7ODnUEG8VmXvUQAcrVRmMq0B9EtWM5BsYizMaPJGR2mmPf8VnX
	 AWNVJM/mZXtDSSodkbdTxOE6lv1WEEfK5gTomXmw=
X-QQ-mid: esmtpgz15t1779178934t1c5a46ee
X-QQ-Originating-IP: zo9ZWQiDkcjI48CRJGSauneMCr4+Z2hEUln1YNd48Jw=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 19 May 2026 16:22:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9981348278823218018
EX-QQ-RecipientCnt: 7
From: ZhaoJinming <zhaojinming@uniontech.com>
To: srinivas.pandruvada@linux.intel.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ZhaoJinming <zhaojinming@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86/intel/tpmi: Fix memory leak in mem_write() error path
Date: Tue, 19 May 2026 16:21:36 +0800
Message-Id: <20260519082136.2999917-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: Mw43FEVz/zQ/LO8jTJsuGVbRD/4NCqAG3muPAYexi2guMipRAW1oVdqp
	xwqs5BHaupmGFfoYJb2DoTunAIaYD/KdIqDMXV48yiHocRd5HimEMO/F4V1lLsSCWoBx41O
	uxKFFE9YyZUWrGjNV0rwYZ8nm79SskLSR+SQgEioCDhhO8AHA7FPhNg7Ei6951Ukd/DTGyp
	LKJkdg1+yu1fEocrkNS+NZheDvouREVltcRUsVkBYQOQuuM6J36Xy5dM766k0ZY38Zh114t
	Ftj8CsddMi0D2gStDIr6yupbGLVs1VFOJ8yZ3LGoyN6Mm85M/fNxghMdnF7tKxjrVf55xn6
	9vX3uJOtmRPdZqFfbWovlWL2x+ydO5dd4CYpCpW/G4JcCqgd2yAyYg1R7JavWWF4n7S1r4I
	en0/xdU5pX4kfiuBW9s2GLaaILfWIu88tpv6K2yTPX4daYR6QvYv04F0khDeUbiAli/PazK
	bWokz3Vqye6ru6ATmvnUQKYcFYy1Jyl9Bsm1e4bi45GPBJIdxZmRErjabQQblacfSadKObY
	2VVIQFy6AzYMStKebA/i/AenBqvz3rgckfzWuz/XQfi7CB9n+KQrTlB+K8r+HDRtrM5MUD2
	gLwZh6xyYOPOMBVt8mMPDifrmZxo6lvndsVSFg+q3/uBhabfLLEOjpAmQKWDNh7HUOTfSyP
	DA+vVTXrj8Ych1UGOXVGkKv/zZiJvkvtSjtFekvGNrqMyVMWKxws0u1gX+L1GvT06WU3mlZ
	fxKH0z5hCsuwDRmJE0Bg3ifc8ugD6Ry9yIpocvfKbL23FbqtmZkbpliNf2P6cNVR1q8AZiu
	deZLbtLk3/+wMXmTSngfuQDjRvbwsE/q7mNvNlY2B0kZ9CoovgjiQBxk1Nyfquzyu69NWXx
	lkj3zZxZoXvvWKB1tW0LbRAfcYoXI5XywGcxAea9SqX0d3kXRwBit3gHfGlQzaCuPYWL7wd
	ZZciA1AuRH+eJGM8BGZCS8APeaJwLwNrV2SOfGYeoGUyagxHO5m4r8ZGzi5YsyIDdKUY+oT
	QLZ+klAdt+NwmSh/jvADK67WfBCZ7oHhxg4ZGlTvstBPkld8TMCJ5zM31JwFLp99yaG3u4B
	dGZOCYAVnD6mNC23plULP5XCvXewYDuoJcmy0HsfojJ
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-249489-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaojinming@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,uniontech.com:email,uniontech.com:mid,uniontech.com:dkim]
X-Rspamd-Queue-Id: E1845579F36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mem_write(), when the IS_ALIGNED() check fails, the function returns
-EINVAL directly without freeing the 'array' allocated by
parse_int_array_user(). This causes a memory leak.

Other error paths in the same function correctly use 'goto exit_write'
to free the array before returning. Fix this inconsistency by using
the same pattern for the alignment check.

Fixes: 8e0a2fc68ec3 ("platform/x86/intel/tpmi: Use 32 bit aligned address for debugfs mem write")
Cc: stable@vger.kernel.org
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/platform/x86/intel/vsec_tpmi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec_tpmi.c b/drivers/platform/x86/intel/vsec_tpmi.c
index 16fd7aa41f20..2a428bfcb209 100644
--- a/drivers/platform/x86/intel/vsec_tpmi.c
+++ b/drivers/platform/x86/intel/vsec_tpmi.c
@@ -495,8 +495,10 @@ static ssize_t mem_write(struct file *file, const char __user *userbuf, size_t l
 	addr = array[2];
 	value = array[3];
 
-	if (!IS_ALIGNED(addr, sizeof(u32)))
-		return -EINVAL;
+	if (!IS_ALIGNED(addr, sizeof(u32))) {
+		ret = -EINVAL;
+		goto exit_write;
+	}
 
 	if (punit >= pfs->pfs_header.num_entries) {
 		ret = -EINVAL;
-- 
2.20.1


