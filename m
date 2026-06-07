Return-Path: <stable+bounces-260971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M94VNHtDJWpVFQIAu9opvQ
	(envelope-from <stable+bounces-260971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:10:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DEA64F5E2
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:10:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Gjb1pHaO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260971-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260971-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFAC23036399
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFBB2E3709;
	Sun,  7 Jun 2026 10:07:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783FD78C9C;
	Sun,  7 Jun 2026 10:07:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826824; cv=none; b=ZirGgoDxsRf+OWarHT8nZhUgkMAI5kLx1ybSUPw/OCxbIzhyfKPwhs3UTqviN05ItqyWVl9QFD2i8x7KQNE8+pZNSV2qrapimG4DpmDSf+cQdCU6Rb//ytdVF3gDEwOCB2b7cskQ50s2yn7ncGHBdgQg0RCi0x5UGKzdd3NWPlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826824; c=relaxed/simple;
	bh=XgHvVWaHWQMggL7l2YcGvtUV1naZTNMhPyQnxRwDTOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d24YYGQBfqO+lXLnjXCPgVjGMeBn/I8l4LqE/DeiG/Qr18P4MrWQA9zhGsE3yPl8QEuDnoOPLSl+M6tif4lioQif5VXIeXYigZgMJHfAkWJOKP+ktcnUlm/Bsz2DPQemZMISnqs8bGZo7yutuXTGUzxR1YK5kpNcDUc1vnWM9Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gjb1pHaO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01BE1F00893;
	Sun,  7 Jun 2026 10:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826823;
	bh=wZoPvcdK8nY5KJvoPKD2N57jLi8/e5910T7S09qmeJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gjb1pHaO4e2bbtof3V0ofqVXKs/E6phhM3rssl3jIOVOm+PrIUTIKt6Q6+FnhGjw8
	 eRsWJXjJerRJLP2ICbNy/VxtXDJ94G7AJF5Qnnn3k/+fhI1ZO8qGkLiwh5VwQATWji
	 BV9l20s9lrEaFfqsNuK2REiMucxNZ+jNcU+8vroA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hongtao Lee <lihongtao@kylinos.cn>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 011/315] tools/bootconfig: Fix buf leaks in apply_xbc
Date: Sun,  7 Jun 2026 11:56:38 +0200
Message-ID: <20260607095727.916259717@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260971-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:lihongtao@kylinos.cn,m:mhiramat@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27DEA64F5E2

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hongtao Lee <lihongtao@kylinos.cn>

[ Upstream commit f42d01aadcedd7bbf4f9a466cabe25c1781dedad ]

If data calloc failed, free the buf before return.

Link: https://lore.kernel.org/all/20260520030126.147782-1-lihongtao@kylinos.cn/

Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
Signed-off-by: Hongtao Lee <lihongtao@kylinos.cn>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bootconfig/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 643f707b8f1da1..ddabde20585f21 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -390,8 +390,10 @@ static int apply_xbc(const char *path, const char *xbc_path)
 
 	/* Backup the bootconfig data */
 	data = calloc(size + BOOTCONFIG_ALIGN + BOOTCONFIG_FOOTER_SIZE, 1);
-	if (!data)
+	if (!data) {
+		free(buf);
 		return -ENOMEM;
+	}
 	memcpy(data, buf, size);
 
 	/* Check the data format */
-- 
2.53.0




