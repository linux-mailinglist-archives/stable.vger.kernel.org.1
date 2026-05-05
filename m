Return-Path: <stable+bounces-244112-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKo7COrY+WmbEgMAu9opvQ
	(envelope-from <stable+bounces-244112-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:47:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 830794CCED2
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C6FA31012C4
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86B8386C08;
	Tue,  5 May 2026 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="OdeS2awP"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E6830BB9B;
	Tue,  5 May 2026 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777980498; cv=fail; b=Gfe6o5rdT7/RuJX0KlAeTdmc0iABWS2OSXqbnxt5hu1mzcAa3pjVcLGUDjWipXlCR0CQ0aDCsnOrDHCYLQdAu9vjZ7NaNz2ubRsixbPMIKm0IViS1ROmr+fr1K0d5TAsnckV2zjVYvJBQWP00jXcWKZdHGaF26z6BIn5J9WBlBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777980498; c=relaxed/simple;
	bh=LN7TvZkOtYNFlTM/9ur4wxYUJAXZrfN5Y6dD9+ZQyVg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HE1iVfoEL/mNh+S+pDynq81b7CDA3T40afQzwp0JSVTsL4Tzne7xxK+ny+jgmZORhByuqOntQFrlv+YsFIJA9CnjHOrk2+tagnNYl8k3kU+VfYFRC7Gwaf48KRyOnVgl/0ggTgf0fWNeJAbbWwm5Sm2m1z99S5IpfCuXAWoeA48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=OdeS2awP; arc=fail smtp.client-ip=52.101.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pry3k4VFkJYXkGrMSN00aEzmmZC17OxqboFyZ4CfQ1Qg3PoPJ2UDrd9U538CTQv83GM1A40r1Sx9FpkRW3ZIrltAoeQjvMxVd8AzsLw9l8GwzYpOI6duOw3TWsfhlX2OaO7ZfgU7ZtNtRdAVu/azrihUghWffgmkYtTf6JMRNk2dxRpAxupMpj7Aiqh9TrgUYjy4Ft7ytDBN3wajCk2G9XMsXoNFtCjXnBtDXxRUzTLtK8g2rhjz9xM2br8PRAfHNlvl3qSkpnjYbF+KJobdvwtyVVD67ojwJce9ie0sGL8BhNeBD8wQ/Pg47UGCrCPHr7KmFG4bFkPSBvOPeIL3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDOhYqeAqk43M01+I+JiGn83msKTMHLwHp9lXS1fEFs=;
 b=yiOycEnGc0ajViBe5cnCuy+Wbehye30Epn/wQzD+cDy9+K2tKhbPtA5AulhH3lFsrHsyjnlOue8WhkLZwqWaHsdgA9zCpnG70hBFP0aGmrwU6yrcvi+LqPFPFeEDYiCb5ttA2angmysc8eNSADE42Y33FGlCcUKvRBU3Z41LwEvtzRpzIwc7qkdQ2X80Zr/T16x9+sbSqzyuQJ1D+tD/LDLzsc6fKxMnIrxWuvlFSmUWiWgkrXWgDIvHX3ZFiG3axNiXOlXBlMgnXYdFaU1lIu2kh2JaAnzY9MCiUFPNFDgSQvj4DEH+AjMxjwprm/TBb8Gwte1noS19ElnSR/6iIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDOhYqeAqk43M01+I+JiGn83msKTMHLwHp9lXS1fEFs=;
 b=OdeS2awPd03t1L0v+elkdj3Qm2Ta6z6YtPqP1+PePfyFMtcIU48XU2oqpetxQ1KnY/ky5cDCNanu0LCccMFH3NVZfMVZFqfKl8TLoLisc3mgGW4ek2Vut7Gk2rL9/Vr1g8LewJ5jMC6Wem/UixL5sb8JpdnJ8xIhMGhurglV0PFJ6K2LLU14gZorXGUZvR7c5mT/dt6C38QXE79AEMNyqAcvpKFsqghIyyl+7qzMEs2KzvaGtmHVs4pXbO2AvNNMIvUg80JxyrjgdDw46zh3Py7FM3hkbGJtN0fsNqvZciTMcxaScHSeagfAAqtYZdpCPdJ42yadNwSUlbsmsqZFGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:39b::19)
 by VI0P189MB3520.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2d9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 11:28:13 +0000
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4]) by AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4%7]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 11:28:13 +0000
From: Yunseong Kim <yunseong.kim@est.tech>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <yunseong.kim@ericsson.com>,
	Yunseong Kim <ysk@kzalloc.com>,
	42.4.sejin@gmail.com,
	Yunseong Kim <yunseong.kim@est.tech>
Subject: [PATCH RESEND] checkpatch: validate upstream commit tags for stable backports
Date: Tue,  5 May 2026 13:23:21 +0200
Message-ID: <20260505112320.362715-2-yunseong.kim@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC3B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2f0) To AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:39b::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P189MB1752:EE_|VI0P189MB3520:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c47f6dc-9126-4bd3-5c14-08deaa9964a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	BKeW/ZMjkhhqYWQpXGrLCKCpneAx2ho2FYA8BKasmNiCgUOgNSKn627yZiW/u086WL81+RBs2k/WDFIGDsxOhxuNY5yIfE/ENT3BMjJo1B3xthcCOaoo72bLH+U9cfTRePLVKO2VSne5MBLDtrdt9A+TtXAsInuN+ubR1bS+hqBuY6BFEgsWjU/PrYLGDCTwuLcx1bCYFFtiOpSnVp0zwyfVr+Tr4zgSzPthKIRHF48GO4qKqaPuM9xSerFa9XtrKCdhzlnVspjmp78pI66+6m8XNLiE3dobTDJjnqY1TiG0NRLU3nvpTqOarXzORslOJYxQ7wALf/mLymu4BvQ1nux6g03ZVt3wiby0ihS3vZcNjWYyuvEZKyO39hSqpFIqFKa14d4rbbZVRe87TZ0ybf3HYZQcpxrGUZn58itbj9fYqOLMu1nYY5rK/jEnsBXiKnYW+EBohRP2H3CngsuSUVgc7zyLoKUOacLy3TrmUeEardqkDH9UVp1fgz/AbvH8BQbeIfJyozkIh5ZpNP9EWn4tvvNliODV+OqW5mYnsN4VfwoqG8VH9+WCE6taCehqnVXAuiGJhhAvyIEVvfkKQjycVP+IAY291+9bxXLvN1PDgsJsvGIjBHtGlAUT4AQR59LAGaetPtTozhUxLBU101gi/QbPnKbQUn93+SR8NzmF31Z0dmVdyF/6PwboDswj6RcwtQS5agDSjdO2w5mjlw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P189MB1752.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?17+uD+NxKLjV/6Wmx64yx+l698iFxOLMqJqp2veL7KsVfJJhEO1DhEx6rept?=
 =?us-ascii?Q?FFgdZUcBjImk1NYnfEfcUqSvEz5cODIRDSE0/gCfou1SXm9OdCLGMQ+DyXdF?=
 =?us-ascii?Q?+bycJR9jkDavDvzTfou8o4KF/JK6/KMtx0UWnfP0m3wpy5rrGjRs4XW3HIHa?=
 =?us-ascii?Q?yhX9I1VDsvBOfrUIHU+TpPcnCl48an4BFZyezLH1zN3u1GXU5OzANhxqG7iy?=
 =?us-ascii?Q?rwEerBvVJCTNTmL5rncaDg3RnQla2UHe4yPS7g+eH1mDnaxH36ExglOJa0i8?=
 =?us-ascii?Q?sfVtWKyFSYWUBeGQhRUu5rrgEukNMs62CsZf17EjvZZLE1pFolYGoBw3+1sX?=
 =?us-ascii?Q?O1kwwtnKtdlUyiQyKNGf3brv8Ema9D4c5qJ/V6i7re9JTRttATKT6MBooFCx?=
 =?us-ascii?Q?ULAbkx0lYLvoAJzxB0g+6JlV8AZ4++rd23wEwZ/a5R/2NOVo+uwPcHcyoDdU?=
 =?us-ascii?Q?sgwvOI/oI/7ap0QX7pVDs6jdTNkXjyMtrtpys02yVNldFQonC5ylJfjeEoLe?=
 =?us-ascii?Q?sAze15I20cW+bo22UlOjOqGQf1SUlW65hCzaYUsej1Dby7kPFfmE0MhdaEZZ?=
 =?us-ascii?Q?FwApxYEoUlNoR9oR4eLu4qGSCkqbj9e6uXIpatSl/q2DNgUqL2pM6741TaT0?=
 =?us-ascii?Q?66zg+y+tq8Mz1AdR8BAGCRAfDOhlpaBQ1YNadEUmr/ii+RWdMQxNos+Fpnv8?=
 =?us-ascii?Q?YRG+0kTu+ZfPgBYcTAAntzCuCOixdWRgPkOSGk2ggjTTbILyqdTbxpQA0WZb?=
 =?us-ascii?Q?F8A9279INWzwfYifnfxOoFmuKEjoSKmyEc81AaY2OBhkREe7/C4dMtkXTxJa?=
 =?us-ascii?Q?bxKqZrCXcLXkt6qeJfz7JKySdc2/yTC11jcmsit128aUxI/3ea0jSOK1n9sd?=
 =?us-ascii?Q?IoP7ZD7cLmng39kgYOvbJnD4tOzYs15q2FIm88VexJmYfZNurLmoQ7Zw94of?=
 =?us-ascii?Q?Nw0CPOqoo5Xi2kjhb3+ZO1QaILcKRrwwjPfObkO7ZPEFQWEZV79y594R6jF+?=
 =?us-ascii?Q?hCei576Dc3UMkJd2tkyI3gjYa3LyBGRIS+nMnvmRZrHf1EmLuc6SDcTA42sE?=
 =?us-ascii?Q?YOqd00gUXJlFkB3kU0H0dT91p9gb+ZiswM5oiIaXq+3iByGL5SRv9y9CU/U9?=
 =?us-ascii?Q?GyGOD0f5su/4yS+Zn/Wa1SeK7nBXFR0vOuCtb4lhPIoaZIIY3VHmco69kYIE?=
 =?us-ascii?Q?E/GBxwHr5jRGUdIALlxAOGCddbGqd4+Aenq8DH7FInBCKRh4l4LgFVfafKGU?=
 =?us-ascii?Q?D1MpderY7Fy/oaSEY4qGEIDtabpuBMuo+vOcyBZVx/9arg8jXSmQtbvfd8yB?=
 =?us-ascii?Q?fulg4mdfiTHSA/pVfre7GidAeaNmPJFaNelmA4RNd6I141m8gQ35cesVPC25?=
 =?us-ascii?Q?DLw2q3u/W3VKW303C+I2HgUUKmMtHNi5h/XtB2VSwxBqmDybZXwgKF7X3XUi?=
 =?us-ascii?Q?qk0oYJLwUU7VFFvEQ3V5aE+cOEay87muokgSMj+4ZuXNHSFBq38F6W01dtPd?=
 =?us-ascii?Q?c9WeMdusGxfYrR+bSUpupOyFacD6D0eIiOGRibozEHQ1Wfeett6WQ488r1Rb?=
 =?us-ascii?Q?VDMrIn2BasWE1o73LIuxhB7RHVGSd01iK3REUb6dAIRzVysgcRM/rrOMOFih?=
 =?us-ascii?Q?5aCqlVrnEFrdKqcW5nycrH7sDX+Njaw1zD16hMHU0JBZbMkuDyUHu9aYXbNL?=
 =?us-ascii?Q?eWfT+ptwNC5VUJzwYENQMfK+dYbTSuQQduxTmQWPmg0cNqX48e2WKRan7bOW?=
 =?us-ascii?Q?CBDvULO9rA=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c47f6dc-9126-4bd3-5c14-08deaa9964a0
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 11:28:12.9436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTa3OjxTI5nqoOfXfjNj2EesCJmhg4ipF9Az6QTPSa0Me/X+7/zTmNe4JS80gw4nUzbfzIPx04+wbToDCaJKvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P189MB3520
X-Rspamd-Queue-Id: 830794CCED2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-244112-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[est.tech];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,ericsson.com,kzalloc.com,est.tech];
	DKIM_TRACE(0.00)[est.tech:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yunseong.kim@est.tech,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,est.tech:email,est.tech:dkim,est.tech:mid]

According to the stable kernel rules (Option 3), backported patches
should include the upstream commit reference using the SHA1 in one of
two specific formats:

  1. commit <40 length sha1> upstream.
  2. [ Upstream commit <40 length sha1> ]

Currently, checkpatch.pl does not validate these stable-specific
formats, allowing truncated SHA1 characters to pass without notice.

These tags often conflict with the standard GIT_COMMIT_ID rule, which
expects a "12+ chars of sha1" followed by the commit subject in
parentheses. This causes checkpatch to trigger false positive errors.

  ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")'
  - ie: 'commit e9acda52fd2e ("bonding: fix use-after-free due to enslave fail after slave array update")
  #9: 
  [ Upstream commit e9acda52fd2ee0cdca332f996da7a95c5fd25294 ]

Add validation to ensure these tags use the required 40-hex-character
SHA1 and provide a warning if the format is malformed. For example:

  WARNING: Malformed 'commit ... upstream.' line - expected 'commit <40 hex chars SHA1> upstream.'
  #7:
  commit e9acda5 upstream.

  WARNING: Malformed '[ Upstream commit ]' line - expected '[ Upstream commit <40 hex chars SHA1> ]'
  #7:
  [ Upstream commit e9acda5 ]

Link: https://docs.kernel.org/process/stable-kernel-rules.html#option-3
Signed-off-by: Yunseong Kim <yunseong.kim@est.tech>
---
 scripts/checkpatch.pl | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3727156e4cca..b2058cd93465 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3468,7 +3468,10 @@ sub process {
 
 			if (defined($id) &&
 			    ($short || $long || $space || $case || ($orig_desc ne $description) || !$has_quotes) &&
-			    $last_git_commit_id_linenr != $linenr - 1) {
+				$last_git_commit_id_linenr != $linenr - 1 &&
+				$line !~ /^\s*commit [0-9a-f]+ upstream\b/ &&
+				$line !~ /^\s*\[\s*Upstream commit [0-9a-f]+\s*\]/) {
+
 				ERROR("GIT_COMMIT_ID",
 				      "Please use git commit description style 'commit <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herectx);
 			}
@@ -3476,6 +3479,23 @@ sub process {
 			$last_git_commit_id_linenr = $linenr if ($line =~ /\bcommit\s*$/i);
 		}
 
+# Check '[ Upstream commit <sha1> ]' or 'commit <sha1> upstream.' format in stable patches
+		if ($in_commit_log &&
+		    $line =~ /^\s*commit [0-9a-f]+ upstream\b/) {
+			if ($line !~ /^\s*commit [0-9a-f]{40} upstream\./) {
+				WARN("BAD_UPSTREAM_COMMIT",
+				     "Malformed 'commit ... upstream.' line - expected 'commit <40 hex chars SHA1> upstream.'\n" . $herecurr);
+			}
+		}
+
+		if ($in_commit_log &&
+		    $line =~ /^\s*\[\s*Upstream commit\b/) {
+			if ($line !~ /^\s*\[\s*Upstream commit [0-9a-f]{40}\s*\]/) {
+				WARN("BAD_UPSTREAM_COMMIT",
+				     "Malformed '[ Upstream commit ]' line - expected '[ Upstream commit <40 hex chars SHA1> ]'\n" . $herecurr);
+			}
+		}
+
 # Check for mailing list archives other than lore.kernel.org
 		if ($rawline =~ m{http.*\b$obsolete_archives}) {
 			WARN("PREFER_LORE_ARCHIVE",
-- 
2.43.0


