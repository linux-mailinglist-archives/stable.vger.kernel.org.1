Return-Path: <stable+bounces-225259-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAThNJu/s2lQagAAu9opvQ
	(envelope-from <stable+bounces-225259-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 08:41:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9857B27EE16
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 08:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD28930584DE
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 07:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0528B36D9FC;
	Fri, 13 Mar 2026 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aexHNWc9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B773F36D9E7;
	Fri, 13 Mar 2026 07:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773387647; cv=none; b=flFNq+brbSpfem+Q8jibo5I5Ay+OGO+BvpnYJ6n+cLC0pDTniBJYRRwa3+9BKpzOB5Pd9LX3+Yv6Qlp6bklwTHsykYmV0rhDzk3bXg190KIJaIY1XZwBlFEvBqWqL/4LVPhNZIcUIyMw1eqL/ZkS3FhaI8XramzBO4bAo0UER6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773387647; c=relaxed/simple;
	bh=93GwS9PIRZ6UbEeV7xsdhQi57hubLHK6iKxhSGlhOKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iPWRzA0ymUWZJODHlNda89MgGZ9IwMjGbVl3yJ1i8tr9PFj20IBVHpjCh4vGYCPw6YIDcfuzwVPgdt13uaYUNnEyCIozvQ71sXlBbJ7H4Xo1ge8HBUw1opNMyYRnS3TJoP0yAzCFPgyJru+x7/b+uJimShEuOcKDjy7DLd3lg7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aexHNWc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6112C2BC86;
	Fri, 13 Mar 2026 07:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773387647;
	bh=93GwS9PIRZ6UbEeV7xsdhQi57hubLHK6iKxhSGlhOKY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aexHNWc9Rn5QDbi8u8KGhhSzKla4B4ikUlrx53qJnKmbU9a7yU5L0dKl252D94JT+
	 0xcuIkHAZ+m8ZyyQ9X+Qjf34gx3NkGha317apkAOMdzYk6/MILoOddHoSghGiXZSFs
	 o9jkMVncFIayREnxCf+kdmPZqgGmjqFEqqcNQCqBi4OnfuaUsZuuiiwwWJBjbuLgx3
	 6BatAQKkvOjNiT3dSm5KFZMuIf+Gql/hVg5QQ4/uXRYm3WsNh1TOxCmBNKA1f1473Y
	 5+ZnPNc5TVvr4pQGts0VbcJv4fXnv2nJDPr/9we1oy5HxxMtczYng8DxO805tyFskO
	 Bi/t60m8i8mpQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 13 Mar 2026 08:40:24 +0100
Subject: [PATCH 1/4] selftests/hid: fix compilation when bpf_wq and
 hid_device are not exported
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-wip-bpf-fixes-v1-1-74b860315060@kernel.org>
References: <20260313-wip-bpf-fixes-v1-0-74b860315060@kernel.org>
In-Reply-To: <20260313-wip-bpf-fixes-v1-0-74b860315060@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 kernel test robot <lkp@intel.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773387643; l=2088;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=93GwS9PIRZ6UbEeV7xsdhQi57hubLHK6iKxhSGlhOKY=;
 b=hPaq2ikNpPLvL2yIFZ81/fX3qVAEZCCJnFTH1JcYgntZXIV+zTOVSI34Mwakwgxa9eaXHdyf3
 /7CfoLk9qqIAW8awG8j4AcjVmSlMxtwq+pRCoqRR1vJRjDuzMNeCo49
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225259-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bentiss@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9857B27EE16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This can happen in situations when CONFIG_HID_SUPPORT is set to no, or
some complex situations where struct bpf_wq is not exported.

So do the usual dance of hiding them before including vmlinux.h, and
then redefining them and make use of CO-RE to have the correct offsets.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603111558.KLCIxsZB-lkp@intel.com/
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/progs/hid_bpf_helpers.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index 80ab60905865..2c6ec907dd05 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -8,9 +8,11 @@
 /* "undefine" structs and enums in vmlinux.h, because we "override" them below */
 #define hid_bpf_ctx hid_bpf_ctx___not_used
 #define hid_bpf_ops hid_bpf_ops___not_used
+#define hid_device hid_device___not_used
 #define hid_report_type hid_report_type___not_used
 #define hid_class_request hid_class_request___not_used
 #define hid_bpf_attach_flags hid_bpf_attach_flags___not_used
+#define bpf_wq bpf_wq___not_used
 #define HID_INPUT_REPORT         HID_INPUT_REPORT___not_used
 #define HID_OUTPUT_REPORT        HID_OUTPUT_REPORT___not_used
 #define HID_FEATURE_REPORT       HID_FEATURE_REPORT___not_used
@@ -29,9 +31,11 @@
 
 #undef hid_bpf_ctx
 #undef hid_bpf_ops
+#undef hid_device
 #undef hid_report_type
 #undef hid_class_request
 #undef hid_bpf_attach_flags
+#undef bpf_wq
 #undef HID_INPUT_REPORT
 #undef HID_OUTPUT_REPORT
 #undef HID_FEATURE_REPORT
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

-- 
2.52.0


