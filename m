Return-Path: <stable+bounces-270969-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eQ0fNT2iRmqsagsAu9opvQ
	(envelope-from <stable+bounces-270969-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:39:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AAF6FB85B
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:39:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=CWSzUDTp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270969-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270969-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AC3B307D199
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B997346E64;
	Thu,  2 Jul 2026 16:38:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0AC1A682A;
	Thu,  2 Jul 2026 16:38:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010326; cv=none; b=JPNpppCt8Kk2vqyAT8LBOBuQxxlaOYqxKzctTHtwtXtr13k+10QMkGbrKhuaEtv6G5uzlgWJsRRHyrij1vt+fEFJI0ra0Iwl/ojAs8YIjM+3YvILXtxgyr72zZR0KcvVUa87Q0gHzs0sal0DbuMYD/ZgjfyFsbEBPRD5NLKsrqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010326; c=relaxed/simple;
	bh=mNyIcQYrd6016caxlTT4/VFXdQ6R6Bufz/sOgVXEap8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKQEJpUHjZu+gedv9vQPCmerCN82YHrTn1C0nXWniKFfzD6cZzeJYdklbzyqz0sB6I3VtsKmPv8ip/ivh9meSVrTVXejCW22IwDkgaTMnVqP3FgY1BnFp+Qksv+gbvDbQmz3h+0GHpSWCqzfucUIyIpvd1bIirAC3vMbBdaFL/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CWSzUDTp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437771F000E9;
	Thu,  2 Jul 2026 16:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010324;
	bh=Q7xxf0daikTjERhlIOpJ97yqlMKl+d2vs0/fFsoD1VM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CWSzUDTpXseo1L/lYkRca4KR/wMG0n86MYf+IwCfllT2DyaJg5RzhkitiAOHZeU/p
	 96d4lEqad5knzpgaUp4HjSkHAd8B7qsI4WNKTEAC6fBXu9eNi2DwHDsZBZJcTs5YUo
	 guSxeYbvUDsmrWrVbAzsN84cVHn5sBLOYQARX+Hk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petr Machata <petrm@nvidia.com>
Subject: [PATCH 6.12 022/204] Reapply "selftest/ptp: update ptp selftest to exercise the gettimex options"
Date: Thu,  2 Jul 2026 18:17:59 +0200
Message-ID: <20260702155119.129191797@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270969-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:petrm@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3AAF6FB85B

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Machata <petrm@nvidia.com>

This reverts commit 6b2176a5c99b33f3c4acc04faadaa9c75da7b163, which in turn
reverts commit fa361565a7275cc43c6ca1abec9ec4fcc9ec51f1, which is commit
3d07b691ee707c00afaf365440975e81bb96cd9b upstream.

The reason for the original revert was that struct ptp_sys_offset_extended
does not contain the field clock_id in 6.12.y. However the claim was false:
6.12.y does in fact contain the field. Reapply therefore the original
patch.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/ptp/testptp.c |   62 +++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 5 deletions(-)

--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -147,6 +147,7 @@ static void usage(char *progname)
 		" -T val     set the ptp clock time to 'val' seconds\n"
 		" -x val     get an extended ptp clock time with the desired number of samples (up to %d)\n"
 		" -X         get a ptp clock cross timestamp\n"
+		" -y val     pre/post tstamp timebase to use {realtime|monotonic|monotonic-raw}\n"
 		" -z         test combinations of rising/falling external time stamp flags\n",
 		progname, PTP_MAX_SAMPLES);
 }
@@ -191,6 +192,7 @@ int main(int argc, char *argv[])
 	int readonly = 0;
 	int settime = 0;
 	int channel = -1;
+	clockid_t ext_clockid = CLOCK_REALTIME;
 
 	int64_t t1, t2, tp;
 	int64_t interval, offset;
@@ -200,7 +202,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xz"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xy:z"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -283,6 +285,21 @@ int main(int argc, char *argv[])
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
@@ -575,6 +592,7 @@ int main(int argc, char *argv[])
 		}
 
 		soe->n_samples = getextended;
+		soe->clockid = ext_clockid;
 
 		if (ioctl(fd, PTP_SYS_OFFSET_EXTENDED, soe)) {
 			perror("PTP_SYS_OFFSET_EXTENDED");
@@ -583,12 +601,46 @@ int main(int argc, char *argv[])
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
 



