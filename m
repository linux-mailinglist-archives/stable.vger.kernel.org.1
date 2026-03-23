Return-Path: <stable+bounces-228241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GlIOc9KwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:14:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3D72F4054
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D2863053BE4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B050A3B7741;
	Mon, 23 Mar 2026 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="faFQDAFo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735533B19BA;
	Mon, 23 Mar 2026 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274552; cv=none; b=eJVxpy3XWuBP3RBMYP/r+xxWtDCuj3lxJB08vtuh4NCRvNb04mVyLBQaJtUI/srJ70gAgdIIQMx2m4WFeQ3TKLKB60M9Bj9Iw7Kwc7F+mi+EnNbQruTsRpBLshMziMGIllyIRZfIWhuM0X7Dud6ZJ6owPN3zJKwOf7TRm3p3Sqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274552; c=relaxed/simple;
	bh=rWbkPG5agv8t0cLW8YmwnUQA/OXn+FggLma40faK/h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpSnaz9HaDt/xsn7BEYjR5oaNWTILXE2lQ3Cp9VUfyBMnoHsszOthN8DISgcbgvxQ2DVIEgiHOUcnbjC00GRMUH8rAApDH0M+Oy5R1wqoA61/HhB5Y/0CkzctMEpFLpO+5nZhMHyG9k91tFR8yaADIrqcuDL5HU7DtmxWzifKfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=faFQDAFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09F2C4CEF7;
	Mon, 23 Mar 2026 14:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274552;
	bh=rWbkPG5agv8t0cLW8YmwnUQA/OXn+FggLma40faK/h8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=faFQDAFoOO+72wxgoLOl6LkITPtZ4xQ67Dv9A3iuEKCzf/bJU/Er2hJulqT9JAZKa
	 mciw4K6oQ89C4k0dzZcAhKiscWs6fzrOJYomBUaqFmXxJt/rjrMl73QTImR4P2dGlu
	 djwydSUgcZ6/b1RWb/vtIB64U69NkAhcckzOh20k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Jiri Kosina <jkosina@suse.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 6.18 004/212] selftests/hid: fix compilation when bpf_wq and hid_device are not exported
Date: Mon, 23 Mar 2026 14:43:45 +0100
Message-ID: <20260323134503.911876855@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-228241-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 7B3D72F4054
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Tissoires <bentiss@kernel.org>

commit 5d4c6c132ea9a967d48890dd03e6a786c060e968 upstream.

This can happen in situations when CONFIG_HID_SUPPORT is set to no, or
some complex situations where struct bpf_wq is not exported.

So do the usual dance of hiding them before including vmlinux.h, and
then redefining them and make use of CO-RE to have the correct offsets.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603111558.KLCIxsZB-lkp@intel.com/
Fixes: fe8d561db3e8 ("selftests/hid: add wq test for hid_bpf_input_report()")
Cc: stable@vger.kernel.org
Acked-by: Jiri Kosina <jkosina@suse.com>
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/hid/progs/hid_bpf_helpers.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -6,8 +6,10 @@
 #define __HID_BPF_HELPERS_H
 
 /* "undefine" structs and enums in vmlinux.h, because we "override" them below */
+#define bpf_wq bpf_wq___not_used
 #define hid_bpf_ctx hid_bpf_ctx___not_used
 #define hid_bpf_ops hid_bpf_ops___not_used
+#define hid_device hid_device___not_used
 #define hid_report_type hid_report_type___not_used
 #define hid_class_request hid_class_request___not_used
 #define hid_bpf_attach_flags hid_bpf_attach_flags___not_used
@@ -27,8 +29,10 @@
 
 #include "vmlinux.h"
 
+#undef bpf_wq
 #undef hid_bpf_ctx
 #undef hid_bpf_ops
+#undef hid_device
 #undef hid_report_type
 #undef hid_class_request
 #undef hid_bpf_attach_flags
@@ -55,6 +59,14 @@ enum hid_report_type {
 	HID_REPORT_TYPES,
 };
 
+struct hid_device {
+	unsigned int id;
+} __attribute__((preserve_access_index));
+
+struct bpf_wq {
+	__u64 __opaque[2];
+};
+
 struct hid_bpf_ctx {
 	struct hid_device *hid;
 	__u32 allocated_size;



