Return-Path: <stable+bounces-247781-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIQnIdknB2ppsQIAu9opvQ
	(envelope-from <stable+bounces-247781-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:04:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE00550F64
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D68430D1CDB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBCD47ECD6;
	Fri, 15 May 2026 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bGdWIDPm"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013000.outbound.protection.outlook.com [40.93.196.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D1480963
	for <stable@vger.kernel.org>; Fri, 15 May 2026 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853315; cv=fail; b=Xl26HliyniNvWdnqYmh30TRN11vYFpAzNhYj9T5KF/1OUApYSdyqEpSUtgwBfgPxYaCaj95SNjghw5xOU+21AJ/0KXUgy8oLld5I0NCovm8rDDhqWcPEvBUdwICVn/NAHNY0QvqYHFIFglSIWOBdUb/GSAOoWmzWpsZS+ZFcqiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853315; c=relaxed/simple;
	bh=bZZTEh0cf37DbPXIwA9d5tCnSOcaiARqWYOqnn40pmw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TpiObMopWMlWho7QT9FytPbRzlpY3F3SQsJoCNobALRYc10yJXc5Dk//uOIKeWXBfS8tUpWu7l3n18J4o1oXNsuGhXaWWwkwAIzgBQVtxCYDZGBbQXMzdSMxQQstah/okdn/RCxsMVqA1O9EecpWKZZgsVP6IYmeMkCp226WZo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bGdWIDPm; arc=fail smtp.client-ip=40.93.196.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zL+ev0NyV/zACwPau/nvhFNiWfAkf3CGUz5dxzYpdZOiu3+SDXZ+MfuoH1+7+4lqxmAwlsCvHXnMbTIDnXwEBwXaD0dzpAWRGgeke1Dv27dRE1vtxJh5SSCMO7wcrJfTJbot9SY8iJsSehTtMAzmAgc84bjWPHq1cFrPe9hoiBUGB5wNKgevO/bM2SSUWkbFNQm4F5pJmh0fIARP5RaZsGtc39TQhr8zJ7CecSbffCqbRQ2peSEhRQxSy+8CUSufO/tW4gwTT0hVnrhTu5UUAbQgBpzILAlxXRUxd9US0rTe2vqxluebfRkRHYMYon9m4mmbeSqxTRq8ACbZqqtWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dpu+jlCilEyhoB+rJ3lZDVsaHZ1m0bOiiK+3HNPk4hA=;
 b=kiGvaEfBPzQylc7T9sQ0yqxIxgpHp/WV9JlMp/adiyCd0mhOK3hrukoZhU+msFTHPJI44rxgZWJfsTNMcvKhNdOLCjtqRfs7qPwkTr/Bg9u5Ud8jToR9oTNRwWWxKNGkJzEDHBn6zI7ZTJbVGxbsGxJdQqAdpR1ValVKIsJ9x5w6fC0XtBA+GutRm8bHmgaY6k8o4epDfvtGAAaB1rilerZuPKTNLCdInO9oo7V9mHpY89pH0RpFd6FGDmunqWj6jUtARjazo3I3VmgPH6Z3oGIWBlz7ZGB1b/vyGx5LlILKPK440RBO+RUG7V5fg1yEly9nBm+4mdJ2Cw8vcsS8IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dpu+jlCilEyhoB+rJ3lZDVsaHZ1m0bOiiK+3HNPk4hA=;
 b=bGdWIDPm2HZ5D1ibZTV+aetBgpR+aEzVm2ZF49gcORWXjQRFnExJz2j699znK94FKxqRByiTx78g9/V56xMx5VLnLJmp1ZBHZEAhJs6KAN0psuQ4xS7k1oQV7Fa32iITxCeQV3IlPkgCqT4XjIhgC67GAmDmZZlXAk0Xr8ERpyIbIVewrh/qY6Mra1u/wLAk4X4sbgRlAYCbVwx77+ANpxIaeSREOrdc4xQ6PGgk4+m5ndMjMKgBO8Ko68RXnB/mqf7mxxYjjWqEDhFZenR9YryXVxk9Icz6jJL9muvDQQnX8sc4Am9LbufpvdZ9lX52p1+4I9kypQgRJxOysTSbHw==
Received: from IA1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::10)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 13:55:06 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:461:cafe::59) by IA1P220CA0004.outlook.office365.com
 (2603:10b6:208:461::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.20 via Frontend Transport; Fri, 15
 May 2026 13:55:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.0 via Frontend Transport; Fri, 15 May 2026 13:55:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 15 May
 2026 06:54:45 -0700
Received: from fedora.mtl.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 15 May
 2026 06:54:41 -0700
From: Petr Machata <petrm@nvidia.com>
To: Sasha Levin <sashal@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, <stable@vger.kernel.org>, Wojtek Wasko
	<wwasko@nvidia.com>, Mahesh Bandewar <maheshb@google.com>, Shuah Khan
	<shuah@kernel.org>, Richard Cochran <richardcochran@gmail.com>, Yong Wang
	<yongwang@nvidia.com>
Subject: [PATCH 6.1.y] Revert "selftest/ptp: update ptp selftest to exercise the gettimex options"
Date: Fri, 15 May 2026 15:53:53 +0200
Message-ID: <2e4d2f2b9efa7b0b32476947f63506cfe9568d1d.1778851656.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|IA1PR12MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: baad0ee0-f4d6-4425-0eaa-08deb2899138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|3023799003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	mHvUbLVLVBPYAbLn5PRUwK5FNjXUbtxPxnsoHxFYO5KfVeeYSQgt1xDFK0alDt8TUh+diO7u6CLdt0z9mjd7eZzI5lhfwqqy3ndw8pAGdwFnqt93EYl1RpifdDYjKNz+o7px4LEiujPClxDRFKpxypQx4zmapzua/tP5C5u+c3Gc6jK3GtpW+y8BXX7T0Xi5p48pGIcDDIAgzkQ0lOZ+yE5A59693zKlZNDePX3Jznh02euLjLXIQZ6P0CENys01iC/zQMBmw+k+4ohyjts7lM/3C+sHZ2Ob6u67rU1tAgyIpSpixnI0xkWW4x9RIZyOo+pmG9HLM2YK4pdyJJpbIwlg9YpBMcLzusuTwGus08bad9Js33kc4GcLvTm/Wh6UBwMBru6Pz3EHU+EKZHSZ1PdW6tlci/UmHDjCDUeQMS20Exf/gyv1tZGi1LztiT/KOcHciVm4e67ePHTzhf3g/7CKTtSnj6aPYyLw95pqfz6e1smI8jvdEqV2l/0FynBTc0KCe0C1BJQuJ3XN8ZUdguUxE+WYYOVKjcv0Box/kNChS3lQc4EJ5W7YpMf8Cwe04GN2AekikG6Qha+KozpKOgwQokIY9GlK/df83XhWRUVLKJKtuYC/S6g2N8Hd0irwwYU9xYd5TLRYr1YOYe8q/XeLV+8ZH7ZUalixtmvOisD7HjwrCBvajdSGeBYB7GmG
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(3023799003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wa2AVQ1xmb0HaqE/2R2YViGtSCFe3h5PHH6ozJ9JECvmXDdD/Tvqo7Mi4jdZ5ciwu1Edt4dMtrVHHdCqzBFhcuyyU5rP/A+7OchIykksrivlrcnlvMOEq53Lj0p1PcusPY+GvE7tXh5kaVzWb5ZAv8kZrlGGBzGaQo2TYIGssO+G2r7cb+ekX1w65kHa2yc2quV4kNs6JMapoC91iO61qBcVJF6ElJuPBsY8v8oqA2vW3zO7KKYATpzY+1GoeM2keEHbO7FjltoSxLbqLF06t+wdkutwJVvIzDCkMpJaB5whIPF7JvoaN4VqDxfKaht7w4hFlFdXbJajxkfevtOod3/5GX4c55XKtatbgTT8Zzh0QQi1d9BYf9VDwlNg2bpgXUqLsdh9Gv5grAYvDKx+e8XH9m1sKJcR6UWvhKblrlytv9RRk9tnxk6n0DbIpQ59
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 13:55:04.8018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baad0ee0-f4d6-4425-0eaa-08deb2899138
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649
X-Rspamd-Queue-Id: DAE00550F64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,google.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247781-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

This reverts commit 06954f715deb0ed053f8bf85547370db6870225d, which is
commit 3d07b691ee707c00afaf365440975e81bb96cd9b upstream.

The cited commit allows testptp to set a configurable clock_id. That is
done via a PTP_SYS_OFFSET_EXTENDED ioctl call, whose argument is struct
ptp_sys_offset_extended, where the clock_id is set. However, this Linux
version does not support the ptp_sys_offset_extended.clockid field, and
the test case cannot be built against this tree's own UAPI headers.

The reverted commit was introduced to resolve a missing dependency of
commit c6dc458227a3 ("testptp: Add option to open PHC in readonly mode"),
which is 76868642e427 upstream. My suspicion is that the only conflict
between the two is the getopt string, and there is otherwise no direct
dependency between the two.

This patch therefore reverts the cited commit, with hand-resolving the
getopt string to include 'r' (as introduced by c6dc458227a3), but not
'y' (introduced by 06954f715deb).

Reported-by: Yong Wang <yongwang@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Note: the issue appears to exist in 6.6, 6.12 and 6.18 as well.
      Depending on your preference, I can prepare separate
      patches for those branches as well. Let me know.

---
 tools/testing/selftests/ptp/testptp.c | 62 +++------------------------
 1 file changed, 5 insertions(+), 57 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index 532fb6a5d059..7030bae8e5e0 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -147,7 +147,6 @@ static void usage(char *progname)
 		" -T val     set the ptp clock time to 'val' seconds\n"
 		" -x val     get an extended ptp clock time with the desired number of samples (up to %d)\n"
 		" -X         get a ptp clock cross timestamp\n"
-		" -y val     pre/post tstamp timebase to use {realtime|monotonic|monotonic-raw}\n"
 		" -z         test combinations of rising/falling external time stamp flags\n",
 		progname, PTP_MAX_SAMPLES);
 }
@@ -192,7 +191,6 @@ int main(int argc, char *argv[])
 	int readonly = 0;
 	int settime = 0;
 	int channel = -1;
-	clockid_t ext_clockid = CLOCK_REALTIME;
 
 	int64_t t1, t2, tp;
 	int64_t interval, offset;
@@ -202,7 +200,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xy:z"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xz"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -285,21 +283,6 @@ int main(int argc, char *argv[])
 		case 'X':
 			getcross = 1;
 			break;
-		case 'y':
-			if (!strcasecmp(optarg, "realtime"))
-				ext_clockid = CLOCK_REALTIME;
-			else if (!strcasecmp(optarg, "monotonic"))
-				ext_clockid = CLOCK_MONOTONIC;
-			else if (!strcasecmp(optarg, "monotonic-raw"))
-				ext_clockid = CLOCK_MONOTONIC_RAW;
-			else {
-				fprintf(stderr,
-					"type needs to be realtime, monotonic or monotonic-raw; was given %s\n",
-					optarg);
-				return -1;
-			}
-			break;
-
 		case 'z':
 			flagtest = 1;
 			break;
@@ -590,7 +573,6 @@ int main(int argc, char *argv[])
 		}
 
 		soe->n_samples = getextended;
-		soe->clockid = ext_clockid;
 
 		if (ioctl(fd, PTP_SYS_OFFSET_EXTENDED, soe)) {
 			perror("PTP_SYS_OFFSET_EXTENDED");
@@ -599,46 +581,12 @@ int main(int argc, char *argv[])
 			       getextended);
 
 			for (i = 0; i < getextended; i++) {
-				switch (ext_clockid) {
-				case CLOCK_REALTIME:
-					printf("sample #%2d: real time before: %lld.%09u\n",
-					       i, soe->ts[i][0].sec,
-					       soe->ts[i][0].nsec);
-					break;
-				case CLOCK_MONOTONIC:
-					printf("sample #%2d: monotonic time before: %lld.%09u\n",
-					       i, soe->ts[i][0].sec,
-					       soe->ts[i][0].nsec);
-					break;
-				case CLOCK_MONOTONIC_RAW:
-					printf("sample #%2d: monotonic-raw time before: %lld.%09u\n",
-					       i, soe->ts[i][0].sec,
-					       soe->ts[i][0].nsec);
-					break;
-				default:
-					break;
-				}
+				printf("sample #%2d: system time before: %lld.%09u\n",
+				       i, soe->ts[i][0].sec, soe->ts[i][0].nsec);
 				printf("            phc time: %lld.%09u\n",
 				       soe->ts[i][1].sec, soe->ts[i][1].nsec);
-				switch (ext_clockid) {
-				case CLOCK_REALTIME:
-					printf("            real time after: %lld.%09u\n",
-					       soe->ts[i][2].sec,
-					       soe->ts[i][2].nsec);
-					break;
-				case CLOCK_MONOTONIC:
-					printf("            monotonic time after: %lld.%09u\n",
-					       soe->ts[i][2].sec,
-					       soe->ts[i][2].nsec);
-					break;
-				case CLOCK_MONOTONIC_RAW:
-					printf("            monotonic-raw time after: %lld.%09u\n",
-					       soe->ts[i][2].sec,
-					       soe->ts[i][2].nsec);
-					break;
-				default:
-					break;
-				}
+				printf("            system time after: %lld.%09u\n",
+				       soe->ts[i][2].sec, soe->ts[i][2].nsec);
 			}
 		}
 
-- 
2.53.0


