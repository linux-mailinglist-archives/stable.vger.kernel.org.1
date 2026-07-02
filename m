Return-Path: <stable+bounces-271196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +MK+Hk6ZRmrQZgsAu9opvQ
	(envelope-from <stable+bounces-271196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:01:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 927536FADB1
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:01:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=dBRjmCFO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271196-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-271196-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 049093108237
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B3734FF78;
	Thu,  2 Jul 2026 16:48:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91AB3469E7;
	Thu,  2 Jul 2026 16:48:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010916; cv=none; b=Tmduym7Y4uiDhKShwpay3PW7DLdeDI4p/4U+VH5EMZlxpjBUXuy5QQ+LZq7b/CVAaSACQ00AZLMMhm74GQqh9IyfFso47dR3zqcIVyfqG5QPm+qgkgYaQ3KPcZtZho9hT3ho8ZU+7pBtBmTkkgN8hfiaJOv0LPT5JfmrnnqUy9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010916; c=relaxed/simple;
	bh=z6BfcMhZ3wfXjXaRyCZcmfgsPpgc8UHaEn8T3jqY60M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIKVXGN8pRYHMidoN4CkHwzKkGwl/Qfi9Dp9jGw9mt1ZoUjk3gpMkrj7i30Ruu/sbzMQHhwo/zczavMnjrRuDTTHW285y1vM/S80v+boUcaoS+5zg8WND4AByPQyqNABFxo8XSUW56Vw3udNaNXT6hQbXALB4CQUrLCAIK58D+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dBRjmCFO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8301F000E9;
	Thu,  2 Jul 2026 16:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010915;
	bh=TCU1GV1B7RhBYUlek+mYPb5o+opsVEiBoInXSmfiJxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dBRjmCFO8lDxwzYjrGNiuScUyEqVjNXxYfQaHwy5wbokDNmC1iYVzrMBlrEYJCLm5
	 FkfpunflkHtLZElkcjhyXIDJscGbG2tjWFAVxoaSm2zY3EsVQQjrB5BaPMVD2OT7Jt
	 L7sYFbIFaJlLJccxuBnXtWKGXVK2lEQw6mVPXyS8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 085/175] Revert "ptp: add testptp mask test"
Date: Thu,  2 Jul 2026 18:19:46 +0200
Message-ID: <20260702155117.572064337@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>
References: <20260702155115.766838875@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271196-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:yongwang@nvidia.com,m:petrm@nvidia.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 927536FADB1

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Machata <petrm@nvidia.com>

This reverts commit 59ac47a0275fcd5a7637c3d5da20b0905563c7f5, which is
commit 26285e689c6cd2cf3849568c83b2ebe53f467143 upstream.

The reverted commit extends the selftest to test timestamp event queue mask
manipulation in testptp. It exercises masks PTP_MASK_CLEAR_ALL and
PTP_MASK_EN_SINGLE, introduced in commit c5a445b1e934 ("ptp: support event
queue reader channel masks"), which is not on this stable branch. The test
case thus cannot be built against this tree's own UAPI headers.

The reverted commit was introduced to resolve a missing dependency of
commit 8d9f22c570ba ("testptp: Add option to open PHC in readonly mode"),
which is 76868642e427 upstream. The only conflict between the two is the
getopt string, and there is otherwise no direct dependency between the two.

This patch therefore reverts the cited commit, with hand-resolving the
getopt string to include 'r' (as introduced by c6dc458227a3), but not
'F' (introduced by c1c50689799d).

Reported-by: Yong Wang <yongwang@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/ptp/testptp.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index e0aed424fe42d5..8f05212f82329a 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -121,7 +121,6 @@ static void usage(char *progname)
 		" -d name    device to open\n"
 		" -e val     read 'val' external time stamp events\n"
 		" -f val     adjust the ptp clock frequency by 'val' ppb\n"
-		" -F chan    Enable single channel mask and keep device open for debugfs verification.\n"
 		" -g         get the ptp clock time\n"
 		" -h         prints this message\n"
 		" -i val     index for event/trigger\n"
@@ -190,7 +189,6 @@ int main(int argc, char *argv[])
 	int seconds = 0;
 	int readonly = 0;
 	int settime = 0;
-	int channel = -1;
 
 	int64_t t1, t2, tp;
 	int64_t interval, offset;
@@ -200,7 +198,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xz"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xz"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -214,9 +212,6 @@ int main(int argc, char *argv[])
 		case 'f':
 			adjfreq = atoi(optarg);
 			break;
-		case 'F':
-			channel = atoi(optarg);
-			break;
 		case 'g':
 			gettime = 1;
 			break;
@@ -618,18 +613,6 @@ int main(int argc, char *argv[])
 		free(xts);
 	}
 
-	if (channel >= 0) {
-		if (ioctl(fd, PTP_MASK_CLEAR_ALL)) {
-			perror("PTP_MASK_CLEAR_ALL");
-		} else if (ioctl(fd, PTP_MASK_EN_SINGLE, (unsigned int *)&channel)) {
-			perror("PTP_MASK_EN_SINGLE");
-		} else {
-			printf("Channel %d exclusively enabled. Check on debugfs.\n", channel);
-			printf("Press any key to continue\n.");
-			getchar();
-		}
-	}
-
 	close(fd);
 	return 0;
 }
-- 
2.53.0




