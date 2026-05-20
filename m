Return-Path: <stable+bounces-250484-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAN6CGPuDWpb4wUAu9opvQ
	(envelope-from <stable+bounces-250484-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:24:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD9A593944
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F176430A70A3
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D3A34041C;
	Wed, 20 May 2026 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cZc7AH+U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C2136D9EA;
	Wed, 20 May 2026 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295530; cv=none; b=SfBYeV1G8YXQEONIO/OT2p6UF7xJizjne5xO3EpT8HVU94SZLUO99i3tD0lHQ0seGJTqSertJskHCWALuVxaZRp+xKJQfg8R8sH5W++cTCFr2BB1w8rxLyKAt5dwjj7wJF+ckybv0EGKCnhvRhJDx/Z2QMpBK3n+spB4GZ2oJIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295530; c=relaxed/simple;
	bh=6P+Sd01rlHhEJ0hiTnEjbSgA/AFSwKpzw/va8QPiN9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbrqmw8/m1QVqjwgkUL7U/1aFqiuS+Teq6f0DBo2CWq2B19d9oN/o4W6C1XBbzI/q5WybwxMXccg39V32AHsMPGm8Sqs/PDDxII9e36M6wSdl+InSso4mSaAHhx2CQcn+Z/T1wagR+3kJ1ZcehWCHwhuhZIbARfCfEcUK0PCOQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cZc7AH+U; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04CD1F000E9;
	Wed, 20 May 2026 16:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295529;
	bh=aPxs/2y5iHskL5rXd5tJrXlOSP9NLXnLL945dpgKWrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cZc7AH+UUhBLuStiYJmvU5KrmQC+wRSZ7zMmbKnHG94cxKBBzAWFRRbPOKVB/xMjF
	 WaODQDzl88q01gOKKum6orekgPD1nR6Oea0WgCD1XwwXnhiMuzR7vDGyvD5Ui9X6dm
	 6WVrVOcSBrM1P+05rdfGvC51bsXAqbUIQ71tGJeY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wander Lairson Costa <wander@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0454/1146] rtla/trace: Fix write loop in trace_event_save_hist()
Date: Wed, 20 May 2026 18:11:44 +0200
Message-ID: <20260520162158.475108813@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250484-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1BD9A593944
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wander Lairson Costa <wander@redhat.com>

[ Upstream commit 4bf4ef5292b9253d8607c61a875d9f6b14129976 ]

The write loop in trace_event_save_hist() does not correctly handle
errors from the write() system call. If write() returns -1, this value
is added to the loop index, leading to an incorrect memory access on
the next iteration and potentially an infinite loop. The loop also
fails to handle EINTR.

Fix the write loop by introducing proper error handling. The return
value of write() is now stored in a ssize_t variable and checked for
errors. The loop retries the call if interrupted by a signal and breaks
on any other error after logging it with strerror().

Additionally, change the index variable type from int to size_t to
match the type used for buffer sizes and by strlen(), improving type
safety.

Fixes: 761916fd02c2 ("rtla/trace: Save event histogram output to a file")
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Link: https://lore.kernel.org/r/20260309195040.1019085-16-wander@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/tracing/rtla/src/trace.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index d5a6a7351d40f..a4912aaa10eb9 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -358,11 +358,11 @@ static void trace_event_disable_filter(struct trace_instance *instance,
 static void trace_event_save_hist(struct trace_instance *instance,
 				  struct trace_events *tevent)
 {
-	int index, out_fd;
+	size_t index, hist_len;
 	mode_t mode = 0644;
 	char path[1024];
 	char *hist;
-	size_t hist_len;
+	int out_fd;
 
 	if (!tevent)
 		return;
@@ -394,7 +394,15 @@ static void trace_event_save_hist(struct trace_instance *instance,
 	index = 0;
 	hist_len = strlen(hist);
 	do {
-		index += write(out_fd, &hist[index], hist_len - index);
+		const ssize_t written = write(out_fd, &hist[index], hist_len - index);
+
+		if (written < 0) {
+			if (errno == EINTR)
+				continue;
+			err_msg("  Error writing hist file: %s\n", strerror(errno));
+			break;
+		}
+		index += written;
 	} while (index < hist_len);
 
 	free(hist);
-- 
2.53.0




