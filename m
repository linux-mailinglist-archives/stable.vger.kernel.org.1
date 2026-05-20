Return-Path: <stable+bounces-252525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OBoEYr7DWru5AUAu9opvQ
	(envelope-from <stable+bounces-252525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:20:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B03595DCB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21F973109E98
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F043F7ABC;
	Wed, 20 May 2026 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ywxNxCfx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3AB3D5647;
	Wed, 20 May 2026 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300902; cv=none; b=eMel78KaBUpTg2dGcPwJIu6uH7MgGPPUv/Zquap6gHmqUx28SY6cFnxETLSNKfaRR0iFjFo67i0XtwkPuuHGLyMM3T8xuEufGefLARoFeWtYKnrm7PBZfPqY5W0g9zN1T+9qD0DU2AKAj3QgmhpREXmp+PdPmqHY+lCC671mky8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300902; c=relaxed/simple;
	bh=YGKtFRmZmIn36gl78KRutRoTAb1mmPbPgxHVslyWAeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RshpfpKRL9zTXHxe80y0UUi2GiZiyZiBhjbrm4l9p1C0grNrFgbhb8t1zPp2WMbBGHgcuL9R1jUAq+Dj45PIQ8khxmK3RUiajeSOhEmMFV+e+g3WiU4/5+Eayl5cYC06bjetpvwtbSnaG2FRHc4TgnKhMikBNtDpxE19vNmCB4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ywxNxCfx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8501B1F000E9;
	Wed, 20 May 2026 18:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300901;
	bh=V+fUF+36u0dGiJoIW2cKSEfh5p3OikaDxoG2ibyqXbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ywxNxCfxgEvGdlR+hHPdjw+qJcT3JJlwJ+eO+CzgYmZMUZ5+XILxSzxNHM24beAgY
	 Um9d/Seb5NG4k9bMcszXHYHjFWuQaS0xU79I9jQneTZrO5fV4MBvIE/fePmqpU7uzG
	 8frMbWRE1+Upqk9E3gR+Bp2Dry7v2cL4uhpDUv4c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yihan Ding <dingyihan@uniontech.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 352/666] bpf: allow UTF-8 literals in bpf_bprintf_prepare()
Date: Wed, 20 May 2026 18:19:23 +0200
Message-ID: <20260520162118.862589010@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-252525-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,uniontech.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,uniontech.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E3B03595DCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yihan Ding <dingyihan@uniontech.com>

[ Upstream commit b960430ea8862ef37ce53c8bf74a8dc79d3f2404 ]

bpf_bprintf_prepare() only needs ASCII parsing for conversion
specifiers. Plain text can safely carry bytes >= 0x80, so allow
UTF-8 literals outside '%' sequences while keeping ASCII control
bytes rejected and format specifiers ASCII-only.

This keeps existing parsing rules for format directives unchanged,
while allowing helpers such as bpf_trace_printk() to emit UTF-8
literal text.

Update test_snprintf_negative() in the same commit so selftests keep
matching the new plain-text vs format-specifier split during bisection.

Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_printf")
Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
Acked-by: Paul Chaignon <paul.chaignon@gmail.com>
Link: https://lore.kernel.org/r/20260416120142.1420646-2-dingyihan@uniontech.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/helpers.c                            | 17 ++++++++++++++++-
 .../testing/selftests/bpf/prog_tests/snprintf.c |  3 ++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index db4739951702e..8aa7ca9c34c74 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -847,7 +847,13 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 		data->buf = buffers->buf;
 
 	for (i = 0; i < fmt_size; i++) {
-		if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i])) {
+		unsigned char c = fmt[i];
+
+		/*
+		 * Permit bytes >= 0x80 in plain text so UTF-8 literals can pass
+		 * through unchanged, while still rejecting ASCII control bytes.
+		 */
+		if (isascii(c) && !isprint(c) && !isspace(c)) {
 			err = -EINVAL;
 			goto out;
 		}
@@ -869,6 +875,15 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 		 * always access fmt[i + 1], in the worst case it will be a 0
 		 */
 		i++;
+		c = fmt[i];
+		/*
+		 * The format parser below only understands ASCII conversion
+		 * specifiers and modifiers, so reject non-ASCII after '%'.
+		 */
+		if (!isascii(c)) {
+			err = -EINVAL;
+			goto out;
+		}
 
 		/* skip optional "[0 +-][num]" width formatting field */
 		while (fmt[i] == '0' || fmt[i] == '+'  || fmt[i] == '-' ||
diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
index 4be6fdb78c6a1..20a3c622bd28a 100644
--- a/tools/testing/selftests/bpf/prog_tests/snprintf.c
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
@@ -114,7 +114,8 @@ static void test_snprintf_negative(void)
 	ASSERT_ERR(load_single_snprintf("%--------"), "invalid specifier 5");
 	ASSERT_ERR(load_single_snprintf("%lc"), "invalid specifier 6");
 	ASSERT_ERR(load_single_snprintf("%llc"), "invalid specifier 7");
-	ASSERT_ERR(load_single_snprintf("\x80"), "non ascii character");
+	ASSERT_OK(load_single_snprintf("\x80"), "non ascii plain text");
+	ASSERT_ERR(load_single_snprintf("%\x80"), "non ascii in specifier");
 	ASSERT_ERR(load_single_snprintf("\x1"), "non printable character");
 }
 
-- 
2.53.0




