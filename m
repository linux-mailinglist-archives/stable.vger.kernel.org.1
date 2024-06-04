Return-Path: <stable+bounces-47962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E12A8FC02D
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 01:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E81DCB2163C
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 23:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C596714D71F;
	Tue,  4 Jun 2024 23:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="VSd5X7kg"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2109.outbound.protection.outlook.com [40.107.212.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81482144D3F;
	Tue,  4 Jun 2024 23:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544966; cv=fail; b=IV/20ajS6mERAjhmxlKprGxCQrKHE24+qORSFLPhxrOEoHuxPyF6WeMC0JM+TzsQqFDI2mdPyoW/hEGwI4AoA6EVNsVaP2Ki3CVRlIeCJ/O4vzzbMVs1owlv24ShoOvik/4YvmrBqV5tCypG9Kf9Hiqb7NZTquAjzPxN8sqnXT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544966; c=relaxed/simple;
	bh=XrfiWtDuYnZdsinejtb7wLfJhH7Se+9WQ2907NDtv5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QHXFWK5BevXPr0Kr33seHtMY/TTifyGVSRC93RemCbSM2e5l2Svw6pBFjGTwVDdz//6PzIkp5Kvs72NMiUuDVqXMb2s7YAXisLdupGHZjaGdaGF0vhQprdveGAYp9rR+dJPvZ0Sr9qJ+IcLa/D2jUJiulIg19J34/J+ktzsG1B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=VSd5X7kg; arc=fail smtp.client-ip=40.107.212.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDuaOUlpxkIVNXPHMkDdHNupXrkr8JGB93xeFe7mar7Qu0dN8z2mKxzsGEacLLqILJmBZkOfWFNevFG+oyrp/Sk1km/v8jOpGhz3cSQ3wOKVGsg/31/OpO2pvkybXhgcciNq4rdDHzI3aHkaplwdJjQonRdgWiXlwYc1sZ5i/RuDSSWkcouTgPH2LHsA02fabbNSbinLNYTq2/r4/kh+54Cxluru3bBjkbX/lPz3smdIND71NXC7AidssmlyrQWp02xdZQwJBJDbxUU8f4/Yu/ajZXkvbLmgflhFcZ4ArEFlIxZyaDeZK8HFT0C20ezgLYnE9QnFExgncSmmdL16XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgFAk0t8buK12Swo9M8E2WKPM2udA1VmV+n2vpvLnjw=;
 b=URAzFUId16kziYkYuyqawAuDePeAWdKhXDVcAPHysNluPLjv6BHlny8IvmsAZDky4oGWV5et/nZ0H16efMWrlUMH/S5goDvExN6hnDGCtWwX1xQ4X6hCLVFYQbDqwWkaveq1Rd7MVqlC6tNskDgaLtpA51Sh9krvYWW+EeK0Ql92cm6LcQK5ZySlnFFExtWG/WCYmXjoiN08CO0EZtOvU10x72qgAWQ2MgAJGxoApDcRrfcTJMGqz5EQQGM2Nml7sjXnsMResikgmJd6ZE9s6Mal0FrNgZpse99nZDckhK7WZXsGWdkRElgO4y7jvWbctR4fvVMNj8liM/avwWL0Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgFAk0t8buK12Swo9M8E2WKPM2udA1VmV+n2vpvLnjw=;
 b=VSd5X7kgcMCUg5RXMhznOZ+YBbf09YapDJw1IJ2j+B3ZaZKxfr7/+D0IqfOrSFEJE7Um7KaIsjZS5vkNOFzbh/EwYLJDDhSarLt5v5HR2W+wN533LB9HQBSHPwZkcP8bLy5Gh4veA4YBzspQ8WTADaTD2oCBVnhG4+diHk8lhiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 CH3PR01MB8575.prod.exchangelabs.com (2603:10b6:610:168::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.30; Tue, 4 Jun 2024 23:49:17 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 23:49:17 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: peterx@redhat.com,
	oliver.sang@intel.com,
	paulmck@kernel.org,
	david@redhat.com,
	willy@infradead.org,
	riel@surriel.com,
	vivek.kasireddy@intel.com,
	cl@linux.com,
	akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] mm: gup: do not call try_grab_folio() in slow path
Date: Tue,  4 Jun 2024 16:48:58 -0700
Message-ID: <20240604234858.948986-2-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604234858.948986-1-yang@os.amperecomputing.com>
References: <20240604234858.948986-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:610:b1::29) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|CH3PR01MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: d15a5653-7896-4278-c0af-08dc84f0f260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|52116005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D6ta4Xbon/sK6Ku+F2J75YdSUHgkfRu5FxiCDoWizJFqeAZLek69oVUBN9IK?=
 =?us-ascii?Q?qF9qpTD4es9d1MQDXKeQ87GIijvJt/lp/wjjdDskfsV7CjZC5wU1GXQ9yAWl?=
 =?us-ascii?Q?QE5gUvXJRmjjQVW1BhUQiRjs+L//nwNaA5O89g0ewRk380zwEfZe89ieM/r1?=
 =?us-ascii?Q?z0GwUjTXM7YjymuRkZdQVh0OXNaKZkNQRqh9BTLn1mkMTdnck4K3SmhaKIC2?=
 =?us-ascii?Q?0TeFCnwOWCk+m16GhIeyqMeo/XDKPQkM1tgZvrkMPH2GFilsX04ScL5vPIs3?=
 =?us-ascii?Q?AcMAhGv6Va30JVhoIVUg1DmJjksRFfMdlJ9pVPu12Hd0/1cq5RsHqRJJEmcT?=
 =?us-ascii?Q?4qnUiKF/4paC0KW14dGZxGhng1xjW083XJXzzwVIJXz61+Jg/jsFAj9oJfOJ?=
 =?us-ascii?Q?Qq+YtHaHSFvKTWvoIiHfMcj/qUT27ye/as+v3j+Mr2yCNqCceB48AT5qBdMW?=
 =?us-ascii?Q?PNyDA2frfYxWRA8hCLtjNsYdi5rZp975GAQyr+O3j+/iULQYdUEKEWlTJUhw?=
 =?us-ascii?Q?7Hsm5oLX1Wp/4CXczdMKmO15LHYRHXSfIx3MwT5oYvdk9pgQZzU8Qo2OWmyU?=
 =?us-ascii?Q?dfotNtytSlPHewqOF0eUeXxDzWmKhziPBr0h4B8qsbOKTFxxyOikkHRtoPgI?=
 =?us-ascii?Q?HD03iHEYKxkJZ6rAby/BnB8pY67sxptpN9etYepbJ6tMufb4GQqERH8Kk+qs?=
 =?us-ascii?Q?tUOKrgGEBtGkY368PNnAJfyRypLD6mF7ZGyS2xK+F2koxUSPDiUVHdL5TDJe?=
 =?us-ascii?Q?KaG9tvgFabmN41ifLlWlbT2rQodd7vduZ84fFaaZnGCgqXp4yX9usZOkUfve?=
 =?us-ascii?Q?54Nsc3hCMEKbYaf6hGNOHAliVEQwOIT0MZUirE1bAR/FUXzdl10gzbrL4zTl?=
 =?us-ascii?Q?tUYPCCh93ezOwtewLaJaCsLb1jwll+8h73fa3Gytk121D76DNCTs3SQAeB6I?=
 =?us-ascii?Q?o48b/TRrfacWleGVsQMJr3HcAqzYmGa/Bcfw0JnlDcLvsi23Oozvu9Dxwq1O?=
 =?us-ascii?Q?vrt6vxcYOjuc7cmHZwdKUY4gu8uWU3WiX13xc3c/iRn+uhWWnCbPUhGbqjVT?=
 =?us-ascii?Q?pwGVnNbWC8NLaR7oDWy+/ng6gChcBEcD1SB62vERiemfIejCuZiiUItEasSU?=
 =?us-ascii?Q?joPLfCOKdDjX/xepLjvME3xeQ74fV5m3PeRI3mNcXhCThA7AHz+uun0bRXSV?=
 =?us-ascii?Q?uCGrjdbuRhPq3ZrdVX53ql3r2UgFYiFWMA2ZltuZU9PjO9o1w3q0Eav38li4?=
 =?us-ascii?Q?mmZyz8/zZADD6M8S+QATUah/S1oIhy+9FNOHMi+NiSZktEEZyzu/oIyKl8qn?=
 =?us-ascii?Q?mLXFBwteYFeJmf+YvVOEp01vpXqKWIF87SbJMZo+F234mQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IqNCUt5jU3DZILqCqh6xjvtoiRDu+aTjsllLfdlZFU4Y1DZ9ReDU7TgArp+p?=
 =?us-ascii?Q?jKOg1uWFcuHgajZc3GwXP7nNWWdCLKjt+TI9za03uDTxl7W8w17agk4ZYMIe?=
 =?us-ascii?Q?zSw6KaYRKMnbf2PSjBUWG533KYmXCA1ET7nnSBs/pKXYDjgBXjumZfm1v2bw?=
 =?us-ascii?Q?HJdafdT8Mm/yfUqzb5QFzAJC+S19wQUYZO7JKoFwQz0nL0mT0u/ZINSRkeae?=
 =?us-ascii?Q?/rn33+ubhu4P2WCVgT2jhaQgv0/8Eztbi6ZOdlWww9oJQVsdPW2zZZFs1VJx?=
 =?us-ascii?Q?Mf6VUAsn6fRYos0ZtejdybyEltUGIcTRYd0EP2Z7KXtMGuzAa/Z47UOkLnTC?=
 =?us-ascii?Q?psJb9NmZRO08RLVxOLkGFKgT1FZVU/OBkIrxFBREPGGYqV2NokNRdgspYiWX?=
 =?us-ascii?Q?ApwFftRFXka40l9Tl1NanwvsEPDArD70g8e03cm/EVJTxcZTYA15Ep0wGx+b?=
 =?us-ascii?Q?0HMUsqT+Vw2SM2LqD+psOjWviiFrLa4JexzM04pX4D20ylux5OlUpbECE+g4?=
 =?us-ascii?Q?FZpq7UlntA+r4dy6j7gVncSFzWV3AJl/ykiX+w7xWOaNjdqJt1scRpdedfQT?=
 =?us-ascii?Q?LGkJ9gJ5X4rzVTfKhFSTse/fnVn4U9QjOaGkq65cKClJ4DMgI3IXjEAVL+T8?=
 =?us-ascii?Q?TCxdR5k9qT4tpvmCtwgaPCYu4Z4Oh5Xm6r6HbMjZTfjrYEmtY8N6mHzN6Cfk?=
 =?us-ascii?Q?MbmUYrRQrZ/iMEgK8SsrVTB9KAtRy/KcMR20k0t8KHrp4KcfWiMOUWOgpjw/?=
 =?us-ascii?Q?zGoiGnLzPfsF2wKNU2c5Jo+5dusyEtiN2yoRpw+vspruMHbStprm8Y1TBwtu?=
 =?us-ascii?Q?DqHqAHU7lSGCVKouhFlveNOac4fJlrBLpwi7MofDYAuLSMwsVN+AbG0AErqO?=
 =?us-ascii?Q?ANwmeS66TZhMgTUH3d4kEV2e4SJhBvVk5YvKb77u1LT0dyB2HMLKDLbE7Iwj?=
 =?us-ascii?Q?lAQe6LcHUjTQZxEEoZlFHhki6hneETvmEEtxTDb0FCACz8PATSS9v/qfLkab?=
 =?us-ascii?Q?5RHN+yBLy8xyPwwpZPTsCdys5WO7VbIJkwAO9l5v3c7A8rQ3usb7yrifDbg/?=
 =?us-ascii?Q?b/5YRORODNCNON5MINF6fLxO3LeGlqHRzMK6QaZ/6GYAXl10C218R/6uOgYQ?=
 =?us-ascii?Q?OXScdc3QotcWEM5cBeQFLtZthq6s2fHGOEEeIuwYft2O5hTO3lHUpvXLUAPT?=
 =?us-ascii?Q?tKJWFO9XvrQpKadcp8g9UZ07iGXtpcMrc4I/3JLB6ghi2WFXFtAULZDsVbrF?=
 =?us-ascii?Q?48AEnzOrZ87z0+5shZWuOSdJrLoQm+1UJRJ011weRDCycc5WO9w0BjiI+3rh?=
 =?us-ascii?Q?u2zHJhTJr928n/Ua9NIPWzlwY5n2KjmNxUJJQpYWGx1hWiBURL2yqR75DWwS?=
 =?us-ascii?Q?Xl8FMQmmHoxeV/POLW5slhvpIEXRr0LFYdo0JB5qLGs864TEZP5d8hq9WczI?=
 =?us-ascii?Q?xc8sgtMZJSmTcgAVeeMa1sz/bUmII7VOqqFHjVaGF+kYVOkdkqmq+UKtRPUm?=
 =?us-ascii?Q?kMtlV8wGi5DHjYBAOZILuGyNwwXeVDBWwbGJkpp/B/AilAf5i7nJKMpyGmEm?=
 =?us-ascii?Q?XjM2gQe82ENeydGqJpUOzGBjCRWKWtjbAXZXGk5eD2syTy5we6dSGlhITNzI?=
 =?us-ascii?Q?JNVZXRcNQQcLbOcJvjTTgl0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15a5653-7896-4278-c0af-08dc84f0f260
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 23:49:17.4401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SY8jnAeEbt/CO1nATvG5ycAHPbQOPq98IWwVcx2bonorw0GFvK9qMjw0Q8rFgknRami1zDSYkU0cqfZQRyNJ16Hem112lJGdd1+2Ga/UBPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8575

The try_grab_folio() is supposed to be used in fast path and it elevates
folio refcount by using add ref unless zero.  We are guaranteed to have
at least one stable reference in slow path, so the simple atomic add
could be used.  The performance difference should be trivial, but the
misuse may be confusing and misleading.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 mm/gup.c         | 112 +++++++++++++++++++++++++++--------------------
 mm/huge_memory.c |   2 +-
 mm/internal.h    |   3 +-
 3 files changed, 66 insertions(+), 51 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 17f89e8d31f1..a683e7ac47b5 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -100,7 +100,7 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
 }
 
 /**
- * try_grab_folio() - Attempt to get or pin a folio.
+ * try_grab_folio_fast() - Attempt to get or pin a folio in fast path.
  * @page:  pointer to page to be grabbed
  * @refs:  the value to (effectively) add to the folio's refcount
  * @flags: gup flags: these are the FOLL_* flag values.
@@ -124,11 +124,18 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
  * incremented) for success, or NULL upon failure. If neither FOLL_GET
  * nor FOLL_PIN was set, that's considered failure, and furthermore,
  * a likely bug in the caller, so a warning is also emitted.
+ *
+ * It uses add ref unless zero to elevate the folio refcount and must be called
+ * in fast path only.
  */
-struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
+static struct folio *try_grab_folio_fast(struct page *page, int refs,
+					 unsigned int flags)
 {
 	struct folio *folio;
 
+	/* Raise warn if it is not called in fast GUP */
+	VM_WARN_ON_ONCE(!irqs_disabled());
+
 	if (WARN_ON_ONCE((flags & (FOLL_GET | FOLL_PIN)) == 0))
 		return NULL;
 
@@ -205,28 +212,31 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 }
 
 /**
- * try_grab_page() - elevate a page's refcount by a flag-dependent amount
- * @page:    pointer to page to be grabbed
- * @flags:   gup flags: these are the FOLL_* flag values.
+ * try_grab_folio() - add a folio's refcount by a flag-dependent amount
+ * @folio:    pointer to folio to be grabbed
+ * @refs:     the value to (effectively) add to the folio's refcount
+ * @flags:    gup flags: these are the FOLL_* flag values.
  *
  * This might not do anything at all, depending on the flags argument.
  *
  * "grab" names in this file mean, "look at flags to decide whether to use
- * FOLL_PIN or FOLL_GET behavior, when incrementing the page's refcount.
+ * FOLL_PIN or FOLL_GET behavior, when incrementing the folio's refcount.
  *
  * Either FOLL_PIN or FOLL_GET (or neither) may be set, but not both at the same
- * time. Cases: please see the try_grab_folio() documentation, with
- * "refs=1".
+ * time.
  *
  * Return: 0 for success, or if no action was required (if neither FOLL_PIN
  * nor FOLL_GET was set, nothing is done). A negative error code for failure:
  *
- *   -ENOMEM		FOLL_GET or FOLL_PIN was set, but the page could not
+ *   -ENOMEM		FOLL_GET or FOLL_PIN was set, but the folio could not
  *			be grabbed.
+ *
+ * It is called when we have a stable reference for the folio, typically in
+ * GUP slow path.
  */
-int __must_check try_grab_page(struct page *page, unsigned int flags)
+int __must_check try_grab_folio(struct folio *folio, int refs, unsigned int flags)
 {
-	struct folio *folio = page_folio(page);
+	struct page *page = &folio->page;
 
 	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
 		return -ENOMEM;
@@ -235,7 +245,7 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
 		return -EREMOTEIO;
 
 	if (flags & FOLL_GET)
-		folio_ref_inc(folio);
+		folio_ref_add(folio, refs);
 	else if (flags & FOLL_PIN) {
 		/*
 		 * Don't take a pin on the zero page - it's not going anywhere
@@ -245,18 +255,18 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
 			return 0;
 
 		/*
-		 * Similar to try_grab_folio(): be sure to *also*
-		 * increment the normal page refcount field at least once,
+		 * Increment the normal page refcount field at least once,
 		 * so that the page really is pinned.
 		 */
 		if (folio_test_large(folio)) {
-			folio_ref_add(folio, 1);
-			atomic_add(1, &folio->_pincount);
+			folio_ref_add(folio, refs);
+			atomic_add(refs, &folio->_pincount);
 		} else {
-			folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
+			folio_ref_add(folio,
+					refs * GUP_PIN_COUNTING_BIAS);
 		}
 
-		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
+		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
 	}
 
 	return 0;
@@ -584,7 +594,7 @@ static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
  */
 static int gup_hugepte(struct vm_area_struct *vma, pte_t *ptep, unsigned long sz,
 		       unsigned long addr, unsigned long end, unsigned int flags,
-		       struct page **pages, int *nr)
+		       struct page **pages, int *nr, bool fast)
 {
 	unsigned long pte_end;
 	struct page *page;
@@ -607,9 +617,15 @@ static int gup_hugepte(struct vm_area_struct *vma, pte_t *ptep, unsigned long sz
 	page = pte_page(pte);
 	refs = record_subpages(page, sz, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
-	if (!folio)
-		return 0;
+	if (fast) {
+		folio = try_grab_folio_fast(page, refs, flags);
+		if (!folio)
+			return 0;
+	} else {
+		folio = page_folio(page);
+		if (try_grab_folio(folio, refs, flags))
+			return 0;
+	}
 
 	if (unlikely(pte_val(pte) != pte_val(ptep_get(ptep)))) {
 		gup_put_folio(folio, refs, flags);
@@ -637,7 +653,7 @@ static int gup_hugepte(struct vm_area_struct *vma, pte_t *ptep, unsigned long sz
 static int gup_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
 		      unsigned long addr, unsigned int pdshift,
 		      unsigned long end, unsigned int flags,
-		      struct page **pages, int *nr)
+		      struct page **pages, int *nr, bool fast)
 {
 	pte_t *ptep;
 	unsigned long sz = 1UL << hugepd_shift(hugepd);
@@ -647,7 +663,7 @@ static int gup_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
 	ptep = hugepte_offset(hugepd, addr, pdshift);
 	do {
 		next = hugepte_addr_end(addr, end, sz);
-		ret = gup_hugepte(vma, ptep, sz, addr, end, flags, pages, nr);
+		ret = gup_hugepte(vma, ptep, sz, addr, end, flags, pages, nr, fast);
 		if (ret != 1)
 			return ret;
 	} while (ptep++, addr = next, addr != end);
@@ -674,7 +690,7 @@ static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
 	ptep = hugepte_offset(hugepd, addr, pdshift);
 	ptl = huge_pte_lock(h, vma->vm_mm, ptep);
 	ret = gup_hugepd(vma, hugepd, addr, pdshift, addr + PAGE_SIZE,
-			 flags, &page, &nr);
+			 flags, &page, &nr, false);
 	spin_unlock(ptl);
 
 	if (ret == 1) {
@@ -691,7 +707,7 @@ static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
 static inline int gup_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
 			     unsigned long addr, unsigned int pdshift,
 			     unsigned long end, unsigned int flags,
-			     struct page **pages, int *nr)
+			     struct page **pages, int *nr, bool fast)
 {
 	return 0;
 }
@@ -778,7 +794,7 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 	    gup_must_unshare(vma, flags, page))
 		return ERR_PTR(-EMLINK);
 
-	ret = try_grab_page(page, flags);
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (ret)
 		page = ERR_PTR(ret);
 	else
@@ -855,7 +871,7 @@ static struct page *follow_huge_pmd(struct vm_area_struct *vma,
 	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
 			!PageAnonExclusive(page), page);
 
-	ret = try_grab_page(page, flags);
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -1017,8 +1033,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
 		       !PageAnonExclusive(page), page);
 
-	/* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
-	ret = try_grab_page(page, flags);
+	/* try_grab_folio() does nothing unless FOLL_GET or FOLL_PIN is set. */
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (unlikely(ret)) {
 		page = ERR_PTR(ret);
 		goto out;
@@ -1282,7 +1298,7 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 			goto unmap;
 		*page = pte_page(entry);
 	}
-	ret = try_grab_page(*page, gup_flags);
+	ret = try_grab_folio(page_folio(*page), 1, gup_flags);
 	if (unlikely(ret))
 		goto unmap;
 out:
@@ -1685,20 +1701,19 @@ static long __get_user_pages(struct mm_struct *mm,
 			 * pages.
 			 */
 			if (page_increm > 1) {
-				struct folio *folio;
+				struct folio *folio = page_folio(page);
 
 				/*
 				 * Since we already hold refcount on the
 				 * large folio, this should never fail.
 				 */
-				folio = try_grab_folio(page, page_increm - 1,
-						       foll_flags);
-				if (WARN_ON_ONCE(!folio)) {
+				if (try_grab_folio(folio, page_increm - 1,
+						   foll_flags)) {
 					/*
 					 * Release the 1st page ref if the
 					 * folio is problematic, fail hard.
 					 */
-					gup_put_folio(page_folio(page), 1,
+					gup_put_folio(folio, 1,
 						      foll_flags);
 					ret = -EFAULT;
 					goto out;
@@ -3041,7 +3056,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 		page = pte_page(pte);
 
-		folio = try_grab_folio(page, 1, flags);
+		folio = try_grab_folio_fast(page, 1, flags);
 		if (!folio)
 			goto pte_unmap;
 
@@ -3128,7 +3143,7 @@ static int gup_fast_devmap_leaf(unsigned long pfn, unsigned long addr,
 			break;
 		}
 
-		folio = try_grab_folio(page, 1, flags);
+		folio = try_grab_folio_fast(page, 1, flags);
 		if (!folio) {
 			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
 			break;
@@ -3217,7 +3232,7 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	page = pmd_page(orig);
 	refs = record_subpages(page, PMD_SIZE, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
+	folio = try_grab_folio_fast(page, refs, flags);
 	if (!folio)
 		return 0;
 
@@ -3261,7 +3276,7 @@ static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
 	page = pud_page(orig);
 	refs = record_subpages(page, PUD_SIZE, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
+	folio = try_grab_folio_fast(page, refs, flags);
 	if (!folio)
 		return 0;
 
@@ -3301,7 +3316,7 @@ static int gup_fast_pgd_leaf(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 	page = pgd_page(orig);
 	refs = record_subpages(page, PGDIR_SIZE, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
+	folio = try_grab_folio_fast(page, refs, flags);
 	if (!folio)
 		return 0;
 
@@ -3355,7 +3370,7 @@ static int gup_fast_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr,
 			 * pmd format and THP pmd format
 			 */
 			if (gup_hugepd(NULL, __hugepd(pmd_val(pmd)), addr,
-				       PMD_SHIFT, next, flags, pages, nr) != 1)
+				       PMD_SHIFT, next, flags, pages, nr, true) != 1)
 				return 0;
 		} else if (!gup_fast_pte_range(pmd, pmdp, addr, next, flags,
 					       pages, nr))
@@ -3385,7 +3400,7 @@ static int gup_fast_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr,
 				return 0;
 		} else if (unlikely(is_hugepd(__hugepd(pud_val(pud))))) {
 			if (gup_hugepd(NULL, __hugepd(pud_val(pud)), addr,
-				       PUD_SHIFT, next, flags, pages, nr) != 1)
+				       PUD_SHIFT, next, flags, pages, nr, true) != 1)
 				return 0;
 		} else if (!gup_fast_pmd_range(pudp, pud, addr, next, flags,
 					       pages, nr))
@@ -3412,7 +3427,7 @@ static int gup_fast_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr,
 		BUILD_BUG_ON(p4d_leaf(p4d));
 		if (unlikely(is_hugepd(__hugepd(p4d_val(p4d))))) {
 			if (gup_hugepd(NULL, __hugepd(p4d_val(p4d)), addr,
-				       P4D_SHIFT, next, flags, pages, nr) != 1)
+				       P4D_SHIFT, next, flags, pages, nr, true) != 1)
 				return 0;
 		} else if (!gup_fast_pud_range(p4dp, p4d, addr, next, flags,
 					       pages, nr))
@@ -3441,7 +3456,7 @@ static void gup_fast_pgd_range(unsigned long addr, unsigned long end,
 				return;
 		} else if (unlikely(is_hugepd(__hugepd(pgd_val(pgd))))) {
 			if (gup_hugepd(NULL, __hugepd(pgd_val(pgd)), addr,
-				       PGDIR_SHIFT, next, flags, pages, nr) != 1)
+				       PGDIR_SHIFT, next, flags, pages, nr, true) != 1)
 				return;
 		} else if (!gup_fast_p4d_range(pgdp, pgd, addr, next, flags,
 					       pages, nr))
@@ -3842,13 +3857,14 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 				    next_idx != folio_index(fbatch.folios[i]))
 					continue;
 
-				folio = try_grab_folio(&fbatch.folios[i]->page,
-						       1, FOLL_PIN);
-				if (!folio) {
+				if (try_grab_folio(fbatch.folios[i],
+						       1, FOLL_PIN)) {
 					folio_batch_release(&fbatch);
 					goto err;
 				}
 
+				folio = fbatch.folios[i];
+
 				if (nr_folios == 0)
 					*offset = offset_in_folio(folio, start);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8e49f402d7c7..b6280a01c5fd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1331,7 +1331,7 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 	if (!*pgmap)
 		return ERR_PTR(-EFAULT);
 	page = pfn_to_page(pfn);
-	ret = try_grab_page(page, flags);
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (ret)
 		page = ERR_PTR(ret);
 
diff --git a/mm/internal.h b/mm/internal.h
index 3419c329b3bc..dc358cd51135 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1215,8 +1215,7 @@ int migrate_device_coherent_page(struct page *page);
 /*
  * mm/gup.c
  */
-struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
-int __must_check try_grab_page(struct page *page, unsigned int flags);
+int __must_check try_grab_folio(struct folio *folio, int refs, unsigned int flags);
 
 /*
  * mm/huge_memory.c
-- 
2.41.0


