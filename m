Return-Path: <stable+bounces-212704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oP6YIgSRemmz7wEAu9opvQ
	(envelope-from <stable+bounces-212704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 23:43:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE00BA9B4F
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 23:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C36533017275
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 22:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F210834253C;
	Wed, 28 Jan 2026 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rM9EU8jL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A507D3191C9
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769640021; cv=none; b=faFOYwUhjlO/Z9eVNWTUuLmNJKxWRn76nHYX2hRyZmeCMMQdOQSf+BuKsxZS9hx+z0rHvybotRn/CiUyhxGszc8y9WwjLEHfeoiWYrraixozKsaG3THlIJVR/9Sd+zgECBBbm//P/C9A8BhQpP5Av2VedBX/tLGpnV10TUqEsRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769640021; c=relaxed/simple;
	bh=f9SD+LKm8hXxX434r1CNxoBHcRwO42bKv4C+Q6zLDhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7jBETrSgOFMPPi88pMcV6yHFFLmieyqBvmj/enByujBpdt7yNrj5G8yBJVESYFCgs0Wj8KjeAkpM4lUnDhRoxW7UWYcrcumSALsgAytUadxpCSbHkpRyoCaxGg7e3DATb/b4NYj7LvUAAm9HyiMjZSDHf72vmHwmxGJkcQ1S4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rM9EU8jL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6489C4CEF1;
	Wed, 28 Jan 2026 22:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769640021;
	bh=f9SD+LKm8hXxX434r1CNxoBHcRwO42bKv4C+Q6zLDhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rM9EU8jLtxoLhdkrDq1b1rav4F2JBKScnkWEayH/KoSYyTFt7939MKhvCFDcFcMkz
	 q8KGIluWqbBWFSBUrnSlrLR3kU6yrJBQowclQHt06qi7iIPKZCpFz2FQfuGQmg7xST
	 zMJNpyRoRcBklNggekidCxGZGplT4nw17fziAdgCh5aETz9GQ1TC1u881VCRDcHRns
	 UI2dSHwnNM2E36o/AvYjlSJxmqJVy4E7RshOPpdQLze9eGW4GJuf3ZzTkHTUuX8Pmv
	 nAnN6rczi+/U7lcM8TZR+ql71bfd+VR09EzR+ZqVCpgYEOAiuvEX4LkKci5JzIj3k3
	 fI5sB8ZNxjj1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mei: trace: treat reg parameter as string
Date: Wed, 28 Jan 2026 17:40:18 -0500
Message-ID: <20260128224019.2809980-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012709-cleft-animosity-5c8d@gregkh>
References: <2026012709-cleft-animosity-5c8d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-212704-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DE00BA9B4F
X-Rspamd-Action: no action

From: Alexander Usyskin <alexander.usyskin@intel.com>

[ Upstream commit 06d5a7afe1d0b47102936d8fba568572c2b4b941 ]

The commit
afd2627f727b ("tracing: Check "%s" dereference via the field and not the TP_printk format")
forbids to emit event with a plain char* without a wrapper.

The reg parameter always passed as static string and wrapper
is not strictly required, contrary to dev parameter.
Use the string wrapper anyway to check sanity of the reg parameters,
store it value independently and prevent internal kernel data leaks.

Since some code refactoring has taken place, explicit backporting may
be needed for kernels older than 6.10.

Cc: stable@vger.kernel.org  # v6.11+
Fixes: a0a927d06d79 ("mei: me: add io register tracing")
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Link: https://patch.msgid.link/20260111145125.1754912-1-alexander.usyskin@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ adapted __assign_str() calls to use two arguments ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/mei/mei-trace.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/mei/mei-trace.h b/drivers/misc/mei/mei-trace.h
index fe46ff2b9d69f..770e7897b88cc 100644
--- a/drivers/misc/mei/mei-trace.h
+++ b/drivers/misc/mei/mei-trace.h
@@ -21,18 +21,18 @@ TRACE_EVENT(mei_reg_read,
 	TP_ARGS(dev, reg, offs, val),
 	TP_STRUCT__entry(
 		__string(dev, dev_name(dev))
-		__field(const char *, reg)
+		__string(reg, reg)
 		__field(u32, offs)
 		__field(u32, val)
 	),
 	TP_fast_assign(
 		__assign_str(dev, dev_name(dev));
-		__entry->reg  = reg;
+		__assign_str(reg, reg);
 		__entry->offs = offs;
 		__entry->val = val;
 	),
 	TP_printk("[%s] read %s:[%#x] = %#x",
-		  __get_str(dev), __entry->reg, __entry->offs, __entry->val)
+		  __get_str(dev), __get_str(reg), __entry->offs, __entry->val)
 );
 
 TRACE_EVENT(mei_reg_write,
@@ -40,18 +40,18 @@ TRACE_EVENT(mei_reg_write,
 	TP_ARGS(dev, reg, offs, val),
 	TP_STRUCT__entry(
 		__string(dev, dev_name(dev))
-		__field(const char *, reg)
+		__string(reg, reg)
 		__field(u32, offs)
 		__field(u32, val)
 	),
 	TP_fast_assign(
 		__assign_str(dev, dev_name(dev));
-		__entry->reg = reg;
+		__assign_str(reg, reg);
 		__entry->offs = offs;
 		__entry->val = val;
 	),
 	TP_printk("[%s] write %s[%#x] = %#x",
-		  __get_str(dev), __entry->reg,  __entry->offs, __entry->val)
+		  __get_str(dev), __get_str(reg),  __entry->offs, __entry->val)
 );
 
 TRACE_EVENT(mei_pci_cfg_read,
@@ -59,18 +59,18 @@ TRACE_EVENT(mei_pci_cfg_read,
 	TP_ARGS(dev, reg, offs, val),
 	TP_STRUCT__entry(
 		__string(dev, dev_name(dev))
-		__field(const char *, reg)
+		__string(reg, reg)
 		__field(u32, offs)
 		__field(u32, val)
 	),
 	TP_fast_assign(
 		__assign_str(dev, dev_name(dev));
-		__entry->reg  = reg;
+		__assign_str(reg, reg);
 		__entry->offs = offs;
 		__entry->val = val;
 	),
 	TP_printk("[%s] pci cfg read %s:[%#x] = %#x",
-		  __get_str(dev), __entry->reg, __entry->offs, __entry->val)
+		  __get_str(dev), __get_str(reg), __entry->offs, __entry->val)
 );
 
 #endif /* _MEI_TRACE_H_ */
-- 
2.51.0


