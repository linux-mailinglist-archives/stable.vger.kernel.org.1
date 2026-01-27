Return-Path: <stable+bounces-211791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AXhEpq7eGm0sgEAu9opvQ
	(envelope-from <stable+bounces-211791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:20:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F28FF94CE2
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E4C773009397
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 13:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3712BE04C;
	Tue, 27 Jan 2026 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GHsKaMB2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5CB1EA65
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519951; cv=none; b=jonqfp2v/2pm4rCv+I5KJ9xOJRO/5oSC9jFxhiwq6JYgijRDLBCA9eHTeHubKSMYUIA/pkVLbyKiCqXgCdNtfNRWKPIYk7kC7+JVANu4wjBpn1W3ooEys1kFtBsVW3LCCP25KuPUiga4SGCxzmiLExwiyyW6LUagwg6YZhZa+9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519951; c=relaxed/simple;
	bh=TeLST0LyISyQJLPSjNgjUNvWF+/BKhwUB2m+32I6YIA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VRr4FYz4tXAoKhzMdwO9Zxk3EJbfEZREx3zY4AoMXdNpUegDf+HFHxkeRDrNhUAgN5HmeJG4b8HGrE/Q4IzP03uysdFrHIDfX5cMgNC5bNtOfbcpwnujFOd6Q/Kc68udanT4ImxRi9Ce1H3NukbQwvADCmTJez5/HvLL6hm6d1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GHsKaMB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBFBC116C6;
	Tue, 27 Jan 2026 13:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769519951;
	bh=TeLST0LyISyQJLPSjNgjUNvWF+/BKhwUB2m+32I6YIA=;
	h=Subject:To:Cc:From:Date:From;
	b=GHsKaMB2hoCqnSxSjOxVgYeX+/A5oMd8nc1mlMyUiS/arOpXhq+oBPt14DS/qBtoA
	 hbdctmvaK+k1dGdE5N5D5hnXUlvv/5o7FsVncvs4WJ8NV+qVi3wdshBPN1Hv4YioQZ
	 POBWUdfEWKESKPcn5WjmvNULQkIB8xOIkg+nffc0=
Subject: FAILED: patch "[PATCH] mei: trace: treat reg parameter as string" failed to apply to 6.6-stable tree
To: alexander.usyskin@intel.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 27 Jan 2026 14:19:08 +0100
Message-ID: <2026012708-hazy-pampers-568a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211791-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:email,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Queue-Id: F28FF94CE2
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 06d5a7afe1d0b47102936d8fba568572c2b4b941
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012708-hazy-pampers-568a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 06d5a7afe1d0b47102936d8fba568572c2b4b941 Mon Sep 17 00:00:00 2001
From: Alexander Usyskin <alexander.usyskin@intel.com>
Date: Sun, 11 Jan 2026 16:51:25 +0200
Subject: [PATCH] mei: trace: treat reg parameter as string

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

diff --git a/drivers/misc/mei/mei-trace.h b/drivers/misc/mei/mei-trace.h
index 5312edbf5190..24fa321d88bd 100644
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
 		__assign_str(dev);
-		__entry->reg  = reg;
+		__assign_str(reg);
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
 		__assign_str(dev);
-		__entry->reg = reg;
+		__assign_str(reg);
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
 		__assign_str(dev);
-		__entry->reg  = reg;
+		__assign_str(reg);
 		__entry->offs = offs;
 		__entry->val = val;
 	),
 	TP_printk("[%s] pci cfg read %s:[%#x] = %#x",
-		  __get_str(dev), __entry->reg, __entry->offs, __entry->val)
+		  __get_str(dev), __get_str(reg), __entry->offs, __entry->val)
 );
 
 #endif /* _MEI_TRACE_H_ */


