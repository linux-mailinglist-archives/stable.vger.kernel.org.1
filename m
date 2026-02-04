Return-Path: <stable+bounces-213636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJiJDJNgg2mfmAMAu9opvQ
	(envelope-from <stable+bounces-213636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:06:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFDEE7EF4
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9F64306BC9C
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F35E41C2EA;
	Wed,  4 Feb 2026 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qUYJHfh0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C6341C2E3;
	Wed,  4 Feb 2026 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216995; cv=none; b=tEtDZIx0otmdR4cCanxXD1f3NmnqsKM1GY4ta85O/xC7p9BCt90HHN7S8FXjH66JO2/dy3H68kK3zUXxcayj2ZHtahCd1ZPuhTu6lcLjpz/YhBuAkuTgO/xRRe4UHwy1h+5XFR3sIu0412dp+IZFgoUg+PAeOcpStPTK9cmzHwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216995; c=relaxed/simple;
	bh=vQ3yBSVIid7P3MVIdZYp7J4BV7fV/Q/9bJUeRtuxW58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dK56v+9bgl6hvaC6+O/NhN907wY2up/3vo7EvaRcVmkzpVxQleqVJF/qKFfygcpuC5GKbp6EyGd15xcfFNZ4h/zWzpclcatkwRRkXiDJkmt+1xv8DpSGhureaPVZwEcjmu+i4mbnwpnyUzjDwST3ZVyfA/vD6zh6VM91pDLHxv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qUYJHfh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845B0C4CEF7;
	Wed,  4 Feb 2026 14:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216995;
	bh=vQ3yBSVIid7P3MVIdZYp7J4BV7fV/Q/9bJUeRtuxW58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qUYJHfh0tgeVSoP+L4Rn6Pjv+6tRre0z6MRGKcRai5eEOv8c5mwlQajk16kdHP4fF
	 jO62KSsLOlmN+4ENEYyWh9lq6kEVx1OXU37MOnj5UMsO15A+A5/DOOa4CoHyveugbT
	 m/4Jvm40/3J5tD5gZjoF/jwwZ6UOWii7RSQLEjak=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maciek Machnikowski <maciek@machnikowski.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 059/206] testptp: add option to shift clock by nanoseconds
Date: Wed,  4 Feb 2026 15:38:10 +0100
Message-ID: <20260204143900.342554692@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,machnikowski.net,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-213636-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FFDEE7EF4
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciek Machnikowski <maciek@machnikowski.net>

[ Upstream commit f64ae40de5efaa33c36f4e2226b33824ba1b42a7 ]

Add option to shift the clock by a specified number of nanoseconds.

The new argument -n will specify the number of nanoseconds to add to the
ptp clock. Since the API doesn't support negative shifts those needs to
be calculated by subtracting full seconds and adding a nanosecond offset.

Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Link: https://lore.kernel.org/r/20220221200637.125595-1-maciek@machnikowski.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 76868642e427 ("testptp: Add option to open PHC in readonly mode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/ptp/testptp.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index aa474febb4712..b943a594ea733 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -133,6 +133,7 @@ static void usage(char *progname)
 		"            0 - none\n"
 		"            1 - external time stamp\n"
 		"            2 - periodic output\n"
+		" -n val     shift the ptp clock time by 'val' nanoseconds\n"
 		" -p val     enable output with a period of 'val' nanoseconds\n"
 		" -H val     set output phase to 'val' nanoseconds (requires -p)\n"
 		" -w val     set output pulse width to 'val' nanoseconds (requires -p)\n"
@@ -165,6 +166,7 @@ int main(int argc, char *argv[])
 	clockid_t clkid;
 	int adjfreq = 0x7fffffff;
 	int adjtime = 0;
+	int adjns = 0;
 	int capabilities = 0;
 	int extts = 0;
 	int flagtest = 0;
@@ -186,7 +188,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:ghH:i:k:lL:p:P:sSt:T:w:z"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:ghH:i:k:lL:n:p:P:sSt:T:w:z"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -223,6 +225,9 @@ int main(int argc, char *argv[])
 				return -1;
 			}
 			break;
+		case 'n':
+			adjns = atoi(optarg);
+			break;
 		case 'p':
 			perout = atoll(optarg);
 			break;
@@ -305,11 +310,16 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (adjtime) {
+	if (adjtime || adjns) {
 		memset(&tx, 0, sizeof(tx));
-		tx.modes = ADJ_SETOFFSET;
+		tx.modes = ADJ_SETOFFSET | ADJ_NANO;
 		tx.time.tv_sec = adjtime;
-		tx.time.tv_usec = 0;
+		tx.time.tv_usec = adjns;
+		while (tx.time.tv_usec < 0) {
+			tx.time.tv_sec  -= 1;
+			tx.time.tv_usec += 1000000000;
+		}
+
 		if (clock_adjtime(clkid, &tx) < 0) {
 			perror("clock_adjtime");
 		} else {
-- 
2.51.0




