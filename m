Return-Path: <stable+bounces-213855-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNAbLzNpg2kbmgMAu9opvQ
	(envelope-from <stable+bounces-213855-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:43:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBF3E93BD
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A70C83020038
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C343428851;
	Wed,  4 Feb 2026 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lujtk9dk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36D442884B;
	Wed,  4 Feb 2026 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217740; cv=none; b=lJ1nxEihswFPdAB4kvdzPrzSXVOdiJAtXFG69RKxOTE9sDaLGfQLNRd8SVSsYuLHUop5BODACoBqVNCkoRzTkWt/GYxdsMR9g8AOkSTbpb0J/H9BnwDyFHUV7NRqlA6hlAqgr+oCLEPCcKCoWvw9wbgFaL7MKsFQd/6GUKJefRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217740; c=relaxed/simple;
	bh=bjxRVlM19aB2RZf5V5zaXk8DPYNQt6f+SsDiK7mcVns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEmSXJpu+i+zd9K9U1+Z/5MHX+5zDQtr2ClK0Xpo3aY/WDzdWjJ1PJHeEErI6ovuUn1cdkfVJuCeCLy6ZWopoNByF9odKXlv43Vm7pO5j6naXiCKANYq6DoxDPVd7PmI5uLDLhpO0zNRQ1wZRVq0xWsrMNEyGz27QoZeOmieeTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lujtk9dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F47C19423;
	Wed,  4 Feb 2026 15:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217739;
	bh=bjxRVlM19aB2RZf5V5zaXk8DPYNQt6f+SsDiK7mcVns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lujtk9dkd9VrXPfZ0f/AloApN8EdLG/FJZnFEYcGRg82QoJWS4wpejsnfyJjBG4er
	 v82c2oD/9dO/nCmY7FLL4VGj3vyu/GPNm9Col1QASgEoAZCStcDH/zq1F/mMJTgih/
	 mEN0u8f6/L/pfKwB5SKW+a+LJQENfX78SrI5ihg4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mahesh Bandewar <maheshb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 087/280] selftest/ptp: update ptp selftest to exercise the gettimex options
Date: Wed,  4 Feb 2026 15:37:41 +0100
Message-ID: <20260204143912.789320824@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,google.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-213855-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EBF3E93BD
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mahesh Bandewar <maheshb@google.com>

[ Upstream commit 3d07b691ee707c00afaf365440975e81bb96cd9b ]

With the inclusion of commit c259acab839e ("ptp/ioctl: support
MONOTONIC{,_RAW} timestamps for PTP_SYS_OFFSET_EXTENDED") clock_gettime()
now allows retrieval of pre/post timestamps for CLOCK_MONOTONIC and
CLOCK_MONOTONIC_RAW timebases along with the previously supported
CLOCK_REALTIME.

This patch adds a command line option 'y' to the testptp program to
choose one of the allowed timebases [realtime aka system, monotonic,
and monotonic-raw).

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Link: https://patch.msgid.link/20241003101506.769418-1-maheshb@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 76868642e427 ("testptp: Add option to open PHC in readonly mode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/ptp/testptp.c | 62 ++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index b609efbdea55d..2323a3329b298 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -146,6 +146,7 @@ static void usage(char *progname)
 		" -T val     set the ptp clock time to 'val' seconds\n"
 		" -x val     get an extended ptp clock time with the desired number of samples (up to %d)\n"
 		" -X         get a ptp clock cross timestamp\n"
+		" -y val     pre/post tstamp timebase to use {realtime|monotonic|monotonic-raw}\n"
 		" -z         test combinations of rising/falling external time stamp flags\n",
 		progname, PTP_MAX_SAMPLES);
 }
@@ -189,6 +190,7 @@ int main(int argc, char *argv[])
 	int seconds = 0;
 	int settime = 0;
 	int channel = -1;
+	clockid_t ext_clockid = CLOCK_REALTIME;
 
 	int64_t t1, t2, tp;
 	int64_t interval, offset;
@@ -198,7 +200,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xz"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xy:z"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -278,6 +280,21 @@ int main(int argc, char *argv[])
 		case 'X':
 			getcross = 1;
 			break;
+		case 'y':
+			if (!strcasecmp(optarg, "realtime"))
+				ext_clockid = CLOCK_REALTIME;
+			else if (!strcasecmp(optarg, "monotonic"))
+				ext_clockid = CLOCK_MONOTONIC;
+			else if (!strcasecmp(optarg, "monotonic-raw"))
+				ext_clockid = CLOCK_MONOTONIC_RAW;
+			else {
+				fprintf(stderr,
+					"type needs to be realtime, monotonic or monotonic-raw; was given %s\n",
+					optarg);
+				return -1;
+			}
+			break;
+
 		case 'z':
 			flagtest = 1;
 			break;
@@ -564,6 +581,7 @@ int main(int argc, char *argv[])
 		}
 
 		soe->n_samples = getextended;
+		soe->clockid = ext_clockid;
 
 		if (ioctl(fd, PTP_SYS_OFFSET_EXTENDED, soe)) {
 			perror("PTP_SYS_OFFSET_EXTENDED");
@@ -572,12 +590,46 @@ int main(int argc, char *argv[])
 			       getextended);
 
 			for (i = 0; i < getextended; i++) {
-				printf("sample #%2d: system time before: %lld.%09u\n",
-				       i, soe->ts[i][0].sec, soe->ts[i][0].nsec);
+				switch (ext_clockid) {
+				case CLOCK_REALTIME:
+					printf("sample #%2d: real time before: %lld.%09u\n",
+					       i, soe->ts[i][0].sec,
+					       soe->ts[i][0].nsec);
+					break;
+				case CLOCK_MONOTONIC:
+					printf("sample #%2d: monotonic time before: %lld.%09u\n",
+					       i, soe->ts[i][0].sec,
+					       soe->ts[i][0].nsec);
+					break;
+				case CLOCK_MONOTONIC_RAW:
+					printf("sample #%2d: monotonic-raw time before: %lld.%09u\n",
+					       i, soe->ts[i][0].sec,
+					       soe->ts[i][0].nsec);
+					break;
+				default:
+					break;
+				}
 				printf("            phc time: %lld.%09u\n",
 				       soe->ts[i][1].sec, soe->ts[i][1].nsec);
-				printf("            system time after: %lld.%09u\n",
-				       soe->ts[i][2].sec, soe->ts[i][2].nsec);
+				switch (ext_clockid) {
+				case CLOCK_REALTIME:
+					printf("            real time after: %lld.%09u\n",
+					       soe->ts[i][2].sec,
+					       soe->ts[i][2].nsec);
+					break;
+				case CLOCK_MONOTONIC:
+					printf("            monotonic time after: %lld.%09u\n",
+					       soe->ts[i][2].sec,
+					       soe->ts[i][2].nsec);
+					break;
+				case CLOCK_MONOTONIC_RAW:
+					printf("            monotonic-raw time after: %lld.%09u\n",
+					       soe->ts[i][2].sec,
+					       soe->ts[i][2].nsec);
+					break;
+				default:
+					break;
+				}
 			}
 		}
 
-- 
2.51.0




