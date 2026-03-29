Return-Path: <stable+bounces-230881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGtsNkEKyWm5tgUAu9opvQ
	(envelope-from <stable+bounces-230881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:17:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FD0351C2C
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE9B83006441
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 11:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE9035AC23;
	Sun, 29 Mar 2026 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="N7HlM4pq"
X-Original-To: stable@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster4-host4-snip4-5.eps.apple.com [57.103.65.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA4D35B626
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774783038; cv=none; b=MfCebY93Hskhb2H9K8usCIs0JonVyu00CSnm/2gtvFN0zoba8RKichpDVS1ZlWWf5qWvJNt+hzuF6w9GE3zyA1QescMku+rMpIy+KlVLLkjA37rOA/cQiwHQKZHRzDyI5BNtmnG92+kj8KNNYalPhFsMU6liY1XKXoIo8UlbZiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774783038; c=relaxed/simple;
	bh=bklynfWm0VI4qNWvUOMPnNYVRhGPtQ9KmEkPZB98Hk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVtNzVw+YK3i/vEBNOOXrBYbGcjGhnaLx53BR3nbyOrKYIFNjfEQcQhkp33X+uxcR/JR4ZdzRcZvcMRUcHo4M7iTyzgwjym5dGiIUtJ7FL94hYBB15EbdIBipYF1lx/4+tGUjXZhYdZF21ph57kqi/N3FC4CkJSiUfZvmc33Iyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=N7HlM4pq; arc=none smtp.client-ip=57.103.65.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-4 (Postfix) with ESMTPS id D2A3D18000A4;
	Sun, 29 Mar 2026 11:17:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1774783036; x=1777375036; bh=kmK9jSWqh5Q+e1AL7HMBVf8XSfWYxGXxUEPCqFex7SM=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=N7HlM4pqZD/UdvFZ4lRh7VwJu9+4Dr6RkWl4i1jY0/FNsZqs1DHcautOr1aLT+JtIELUacB43aLHrYmNSEebpMbBaa70DyityB49JdV4E6fuwYC7FceePzHu0iZPH7o4rJGjeaVs+jkoJJkZgfRhYWgmXymB6ntxl7Z5km+JDB0SS7ls77/4wteFBrcx6U4b6bJAM9edpI1eYdz7KFf8m+uspq8vCOQB3gSQYVTqjr6867pzaxlW92eoRimPxxYl/QqFzoFga/plB3Rku732OXDOlw1jyk+dmFU1EjGf1o3u2y9QjUor/rg8fuYtX8/DpGmbVallQSRRkgpgignt6g==
Received: from bimmer.. (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-4 (Postfix) with ESMTPSA id D381D18000B7;
	Sun, 29 Mar 2026 11:17:12 +0000 (UTC)
From: tobgaertner <tob.gaertner@me.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	security@kernel.org,
	Tobias Gaertner <tob.gaertner@me.com>
Subject: [PATCH 2/2] ntfs3: fix integer overflow in run_unpack() volume boundary check
Date: Sun, 29 Mar 2026 04:17:03 -0700
Message-ID: <20260329111704.411449-3-tob.gaertner@me.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329111704.411449-1-tob.gaertner@me.com>
References: <20260329111704.411449-1-tob.gaertner@me.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=GL4F0+NK c=1 sm=1 tr=0 ts=69c90a3b
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Yq5XynenixoA:10 a=x7bEGLp0ZPQA:10
 a=C3-SEi6G3EkA:10 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8 a=VwQbUJbxAAAA:8
 a=BXPtrl3ALzOmZKxukosA:9
X-Proofpoint-ORIG-GUID: 7Nh9xqpvObeP_NucbXr3Pi6R0GacuMX6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI5MDA4NyBTYWx0ZWRfXwAcLnUm5gJD1
 KgWZpaYb2UkIZQ9uENI8anXlgJniwO03NG96CS3fckBWQm6SsZl+m9AzbybaK2GKr54i1WIU8Tt
 cD6/rSN2AGjiwyL66e82oxU5pXH+RZJhj9Ym5q49EbdbEvvNP1RuqYi09Ut2WcjFIXkCgTD+3u0
 saXF0kWbimLKi3hS0fgZhD+mBCaw3zTNiTJykVr3JRUX5eAqHkaNr9ZpHl8uHD6I7+8pTPGNAPw
 AEuFauBtIbU+1SZDR+rEQNQHN5aPT6LcVJMvVticO00mwmGoHURasAlQ86XvIOtOiqKg9m+uI4q
 xQDFvIHaw+IDihBOsQOA7PFz/GMoAyX8+2TOBR1CNR9XrF3TKRXL3TtzxVxQgY=
X-Proofpoint-GUID: 7Nh9xqpvObeP_NucbXr3Pi6R0GacuMX6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_03,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1015 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603290087
X-Apple-Category-Label: Mjg5MDYwMTc4OiRjYXRlZ29yeSRfUGVyc29uYWws
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[me.com,quarantine];
	R_DKIM_ALLOW(-0.20)[me.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[me.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,kernel.org,me.com];
	TAGGED_FROM(0.00)[bounces-230881-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tob.gaertner@me.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[me.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[me.com:dkim,me.com:email,me.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B6FD0351C2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tobias Gaertner <tob.gaertner@me.com>

The volume boundary check `lcn + len > sbi->used.bitmap.nbits` uses raw
addition which can wrap around for large lcn and len values, bypassing
the validation.  Use check_add_overflow() as is already done for the
adjacent prev_lcn + dlcn and vcn64 + len checks added by commit
3ac37e100385 ("ntfs3: Fix integer overflow in run_unpack()").

Found by fuzzing with a source-patched harness (LibAFL + QEMU).

Fixes: 82cae269cfa95 ("fs/ntfs3: Add initialization of super block")
Cc: stable@vger.kernel.org
Signed-off-by: Tobias Gaertner <tob.gaertner@me.com>
---
 fs/ntfs3/run.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index c3c6917fa..a68000bd4 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -1027,9 +1027,15 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 			return -EOPNOTSUPP;
 		}
 #endif
-		if (lcn != SPARSE_LCN64 && lcn + len > sbi->used.bitmap.nbits) {
-			/* LCN range is out of volume. */
-			return -EINVAL;
+		if (lcn != SPARSE_LCN64) {
+			u64 lcn_end;
+
+			if (check_add_overflow(lcn, len, &lcn_end))
+				return -EINVAL;
+			if (lcn_end > sbi->used.bitmap.nbits) {
+				/* LCN range is out of volume. */
+				return -EINVAL;
+			}
 		}
 
 		if (!run)
-- 
2.43.0


