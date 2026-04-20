Return-Path: <stable+bounces-239431-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDUoKVFf5mkWvgEAu9opvQ
	(envelope-from <stable+bounces-239431-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:16:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DF6430D6C
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E26D34AF1B2
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF57633F5AE;
	Mon, 20 Apr 2026 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jQ/xV8/B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FDC33F58E;
	Mon, 20 Apr 2026 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700235; cv=none; b=XaGEiM04aAXDxBQ7FqqgB7RhHbn0Cz8sKtvKWiv3pq1PQN034yaHCJQXTUVk6keMrmCvmH2p8HqZRE/cafOaNtVE3SuP0uXulFzZWfxtSFccfzQ/sdSzApmF/v3EDvHU+wDoj0HdrFZxnhmbaV6RpMTgP5hglPUsXjflfIjLJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700235; c=relaxed/simple;
	bh=kDsftj0gUgmSJAh6rbQIPuV4YBfTXLWYxpvxMSGhoa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmjRlSRQnvFOHmWzNIUHMuysVN7bN9GZiTagTrQRzCquPdKCeIoEXlXTptPbXLduy9RMCFWvFsJnsztSpTc/+DU/39CoJBkSclj+FZX32gWRQFLiI34aNUO8ecljV9kTUa62Fu2craJbZGz7bK4RM9Y31aEO/TIEOOmCUoM/4bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jQ/xV8/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D15C19425;
	Mon, 20 Apr 2026 15:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700235;
	bh=kDsftj0gUgmSJAh6rbQIPuV4YBfTXLWYxpvxMSGhoa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jQ/xV8/BeMoAwGHuDza8k+4mz6fRZ+aBPs2yQdppym0jA1A2S1NA9spDh4kBlX5Wp
	 F33tH1GrQ1mJoctqUoOYaHN66Q9eQh4RYdIkLYI5nkwnr4pO+rOYaY2vcNaZxMrm0W
	 PrOmBHydt4T+VSTJPOadjDuvX5WGu73orOfW5XF8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 093/220] tracing/probe: reject non-closed empty immediate strings
Date: Mon, 20 Apr 2026 17:40:34 +0200
Message-ID: <20260420153937.382541447@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239431-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iscas.ac.cn:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,goodmis.org:email]
X-Rspamd-Queue-Id: 98DF6430D6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

[ Upstream commit 4346be6577aaa04586167402ae87bbdbe32484a4 ]

parse_probe_arg() accepts quoted immediate strings and passes the body
after the opening quote to __parse_imm_string(). That helper currently
computes strlen(str) and immediately dereferences str[len - 1], which
underflows when the body is empty and not closed with double-quotation.

Reject empty non-closed immediate strings before checking for the closing quote.

Link: https://lore.kernel.org/all/20260401160315.88518-1-pengpeng@iscas.ac.cn/

Fixes: a42e3c4de964 ("tracing/probe: Add immediate string parameter support")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 2f571083ce9ec..8dc495561c3f9 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1069,7 +1069,7 @@ static int __parse_imm_string(char *str, char **pbuf, int offs)
 {
 	size_t len = strlen(str);
 
-	if (str[len - 1] != '"') {
+	if (!len || str[len - 1] != '"') {
 		trace_probe_log_err(offs + len, IMMSTR_NO_CLOSE);
 		return -EINVAL;
 	}
-- 
2.53.0




