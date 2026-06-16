Return-Path: <stable+bounces-264244-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DqEqNBB1MWo6jwUAu9opvQ
	(envelope-from <stable+bounces-264244-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:08:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E21CA691BA3
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:08:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Qc+yZ1aS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264244-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264244-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D404D30C2CEF
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B670044103A;
	Tue, 16 Jun 2026 15:48:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB872EEE68;
	Tue, 16 Jun 2026 15:48:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624898; cv=none; b=jOJ9cirY4FEvUm1Of8AVK8v4mrcUlhcFntV3RUtzIC+Zd+iEdS7CRv1T7Q4rTPurI3vUP7F4atS/ps2OJ17tF5atlMgriAj0lvMVgb+6ZAHiEN0NVug9G5pg6JLa0ouJyRf3C9IC3BFtN6oJGCduG5R+V9dj95lzLxj2RLtWCLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624898; c=relaxed/simple;
	bh=iiAU40WgVsdFcnxyTvOyu48QIhA+72nTYLeOp76ZpG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuxGYQc7ZXtRr5XiejsIJiONyELb6gkEl/+MtlrFfsd/Upha33qoGA1HG4vBYU6viuvlFNpzZLTZkb2GIWPTAZJFkwPS7H6uoVmIvG65YlZNFCbsmSW6v8xGP2ZsCIIFgPGWCQDBcjW6cvgYsH/TV9oNG2N5X4EF7DJoivOiPEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qc+yZ1aS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BCA1F000E9;
	Tue, 16 Jun 2026 15:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624897;
	bh=vP9q87hUPamHXKSO9kT4VyiXR8XdPwsHXYE0ciEezyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qc+yZ1aSNI4n92XJgx2pwjcsYbul0IoMHXkwrT2Hl9URN2PCrxdkxe+nD57/kTqM8
	 nZT3kCRcWSD5vwl5BSzB3Hji1CEOqxZDK+yhcWjOgu650qg9y8QMsywhwJhuqWryL9
	 7vkrpOHfQC7nsy0lt+uyH9BlfuIZ7wlrvfPw3rS4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Harshal Dev <harshal.dev@oss.qualcomm.com>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 015/325] tee: fix tee_ioctl_object_invoke_arg padding
Date: Tue, 16 Jun 2026 20:26:51 +0530
Message-ID: <20260616145058.563702357@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264244-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:arnd@arndb.de,m:jens.wiklander@linaro.org,m:harshal.dev@oss.qualcomm.com,m:sumit.garg@oss.qualcomm.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,qualcomm.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linaro.org:email,arndb.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E21CA691BA3

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit c15d7a2a11ea055bcecc0b538ae8ba79475637f9 ]

The tee_ioctl_object_invoke_arg structure has padding on some
architectures but not on x86-32 and a few others:

include/linux/tee.h:474:32: error: padding struct to align 'params' [-Werror=padded]

I expect that all current users of this are on architectures that do
have implicit padding here (arm64, arm, x86, riscv), so make the padding
explicit in order to avoid surprises if this later gets used elsewhere.

Fixes: d5b8b0fa1775 ("tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
Tested-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/tee.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index cab5cadca8ef99..5203977ed35d1d 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -470,6 +470,7 @@ struct tee_ioctl_object_invoke_arg {
 	__u32 op;
 	__u32 ret;
 	__u32 num_params;
+	__u32 :32;
 	/* num_params tells the actual number of element in params */
 	struct tee_ioctl_param params[];
 };
-- 
2.53.0




