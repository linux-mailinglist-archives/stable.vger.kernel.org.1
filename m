Return-Path: <stable+bounces-59201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BA592FE07
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 17:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ABA11F24097
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 15:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AB81741F1;
	Fri, 12 Jul 2024 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Q5BU/txJ"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2116.outbound.protection.outlook.com [40.107.237.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0361176232;
	Fri, 12 Jul 2024 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720799962; cv=fail; b=CntZcPwvWYKpknflNlYU5adaNMS3NCHuOEhqMkqJkBQgtNXBsxQN3DUmrl1i8xcSzFTg/kC/PQDtYkl6x3TMf7P/szw2PkI4bgeU0RGYfV7/7v2y26M0DiS7aUSjvEz8/utA1lpottHB21YiGt1qAoFiXlAomZiEXDhhksD3Kkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720799962; c=relaxed/simple;
	bh=KfkWm2sHJYxiKCck6h/NmiL9hMiXtI2UoZI9Gr1i+1w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ClN69gOgaaq1/gO06bcajbVJISbvpfQ+WqoZ60ZqM+iU4JVEJD/O2WxyeDRh4lLKwsOwKoZvxbTkNo58V+S0842rhPlIXRTY9NXzTvSQtgGRFo0ZVLWYutbt4A9VkZdEW6kwMe5z+YSm4k8NQ5QZMoSIkp7/pgsyPsLaoXAsA10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Q5BU/txJ; arc=fail smtp.client-ip=40.107.237.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqpJ+KnlghOLt99Rw7fvCBXS34cJ/nY8HKXX8QBUymIQ04wYc1banI+XuFMjIVPdp0DEoeXKtCJTBY21adoujoEP4AJXTXoRkarIKrdj8Nw2y1GuVINWmRXLCZACLhTxDfYA+T1rlvMrrHoEGsUisxPdAXd62WBKfKvASrkN8g+oHG7m15xiDrJZqDtHgnlFJLb8Qm2tjT9rYNWpN7vwccGc8xE8Y3S8Z+kTqnaZzddwf1GTy1Fr2Qxc2BjtCARqYPICJs/cOnhrHt2S64Hw0SskSowplL67kMS19RWwBp+ACDJPw9v/WMX/hCPcVN4VlAsxpKY5Ec7qKecEtg6YIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6xTkbfCKHtPsLO9wNV8wJbADLLHwaAOm6JsLtOK1q0=;
 b=AHVBkIs0nzEt2b0pkGqNq1eq1Hx0dSsGyl1vj5rEquE56othST6T7prOkkERsvzbVBg2LiSTYl/lv/3RwZtvjnej8uGLLaWHK5zP62G5A41dii7FuV+htkvAcD73yX7NH+UQJ6cFU2iV5FXEzEU+UOTVmN4/3OVmjPl8ludJtF2t2gkspb9DRBw6lKqFVZ7V6Eb9tYc64q7DWDVOnpVsYodkb58ZATb4jHWbXO7A2NR6KzJuo6pik2Kfc/DlaxgJ0AZXzH2Ik8/5ftpMDimzL9tcrVtJ/d3bv5ktczlBCGPlhn7f42UmL266dechX/eWI2BzLt1dgXMopc3DYM0OIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6xTkbfCKHtPsLO9wNV8wJbADLLHwaAOm6JsLtOK1q0=;
 b=Q5BU/txJFxToyFu9tyH+Mw3Azg4McnsAr4abSrtiW+RdCQuuA6liZ+1W75queLpqxeWHzEB32PjO+5O5OmNqsa1JF1cl6ykoNAxWD4BHnBZlUFhC2sL1jIXpi5NxNtwQ7k+Cu6OyBpooMYhpGQCvT/K81EsUV9sA7SpYYTp/X9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5471.prod.exchangelabs.com (2603:10b6:208:11b::13) by
 PH0PR01MB8070.prod.exchangelabs.com (2603:10b6:510:295::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Fri, 12 Jul 2024 15:59:12 +0000
Received: from MN2PR01MB5471.prod.exchangelabs.com
 ([fe80::dba1:7502:f7ff:3f80]) by MN2PR01MB5471.prod.exchangelabs.com
 ([fe80::dba1:7502:f7ff:3f80%7]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 15:59:12 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: corsac@debian.org,
	willy@infradead.org,
	jirislaby@kernel.org,
	surenb@google.com,
	riel@surriel.com,
	cl@linux.com,
	carnil@debian.org,
	ben@decadent.org.uk,
	akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mm: huge_memory: use !CONFIG_64BIT to relax huge page alignment on 32 bit machines
Date: Fri, 12 Jul 2024 08:58:55 -0700
Message-ID: <20240712155855.1130330-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0313.namprd03.prod.outlook.com
 (2603:10b6:610:118::34) To MN2PR01MB5471.prod.exchangelabs.com
 (2603:10b6:208:11b::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5471:EE_|PH0PR01MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cad084f-0dca-4ea0-3413-08dca28b921b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qOMWv5Buihvnv4kf+N7KGVlnZVRBx5syrjXJJ57trN1ieRsKnG10hC68xvRh?=
 =?us-ascii?Q?Kx04b7oXUXoLwydCh8f40qQzZpkV4AR7KvsusdkvJiVJp7YC3sEOVxrIXwuO?=
 =?us-ascii?Q?b40DX2R7PYYAYz7vVCnU5aIEuuhHMPuW0AhNLr6s+N/VDWMI7As9kCI/UjrN?=
 =?us-ascii?Q?L7+XjWKlsv5IhbQmoI+47JPah8yYJITWa5QzG45n1jSzcplPP3o0kpxlugKd?=
 =?us-ascii?Q?jBYydbS2HamVlikL20h5x4rnThU6mk9A1TPHGdFHtMp51B45BL4tV2wSHPR1?=
 =?us-ascii?Q?ya/dBKbHm2689Zf7KbUh0IcLSXyVuy9zNofL4T78u74iv61jlbmbSeu9Puku?=
 =?us-ascii?Q?tGytWj+omfZLyA2psBX4Su5PsoVSsckOhkoYKf8jrzKgbP7uPQU3z3IjxhrM?=
 =?us-ascii?Q?5mQbZ1uAmsC3bE4J7xokA/jSCAaG17GZtzmyE4njMlTzsukmdPBZI0wpwFvz?=
 =?us-ascii?Q?hjUJ86LgaBFGflmXXOQJjWjcwKr8OJY390bI0BnE6wyBKcvotuRq83Kfijxs?=
 =?us-ascii?Q?seCIMaeJ0LDo2UvEGSjcDqdVI765vxcLrKtthk5zYlFkNpGF2u4EGTOdnWNq?=
 =?us-ascii?Q?CL3lZZt+gqpHh+iJxNKp2o2G6XikC67TgriJBorLcQw+F8M+Uc+XSPhe26oM?=
 =?us-ascii?Q?ejuJz97Cv++p2/SbLF2ArC53VcW3uSQjn/94eQeuaU1r7pcbrB1aApOyEPVK?=
 =?us-ascii?Q?QfGwFYT8qYvP6OjWn1yLe0kYTaT08bHLOaDmRp7fKCU5PXzg1CqmHbzrl+me?=
 =?us-ascii?Q?LcaBAPWYTZBuU1rOqSfXKgdQYX6J68j4K2pSHgsH/v/DWhN4kPpKGxytFUQd?=
 =?us-ascii?Q?RXQP8Yyflbr3+faAE7EPms7syUeyAeix2q1+7ZNdwZTTE48mypGb84U8jYA7?=
 =?us-ascii?Q?/ala6nbtKErPDUG4vRWHLQZBKAWJ9BVkx3RFBJORK71yjKk76Vt3GZFwBsNb?=
 =?us-ascii?Q?zW/hZdpeY9Zy3AjUzsU2ak6avUmZfylmMY5ARwOyAhi1UNv03Uy9KNtLdW0t?=
 =?us-ascii?Q?gKq2rMUypZAXGfJ90U0POod/ywgLDI6D2t4a3fLo56GgALjxkQZvLdHBa9qF?=
 =?us-ascii?Q?IksHxs70guE/zKhzEkk28bakMhPpSE/bZe6T3Lwlo8Sd9oTPU8y+mX0tMCio?=
 =?us-ascii?Q?BuxOE0F3V5l7lHLzb50PIegTAfLmbFzFB2nJfFWpyF4exEUIQ+fMkMGR1g3H?=
 =?us-ascii?Q?er0mSlnp+kQAb0cv6yDE/nMZdhPHE3rrIK/O3vnJehgdbI0+OGw1C6KzQpQH?=
 =?us-ascii?Q?7XneyrHbixrcxRlSfDOLAYktcBLfSpxGS368ea9EgikqmP2hyX3nZfelAFVB?=
 =?us-ascii?Q?TpAkk4dPu7XHqLtuHd23cZbkWh2yvzGnckoColtHNBDepwaR69VB7T2zeBxS?=
 =?us-ascii?Q?OOfQHhE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5471.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U4DlLOuWwDbuxw+Le71Xiio+SO2z1160fPtX1zqrYHaKwr076dQ1BaNRAfs9?=
 =?us-ascii?Q?qGCp5AHxgvfZm+i69i4g5M0ASFDXCOQoDaSPS8CB/0ElYWc7yEKll1VpL/kp?=
 =?us-ascii?Q?5QSJcp/YZgkXWFKRKSXpzkEZCGH0u9Lp2pq3jfo8ssgW2afSNuWSknkySbfH?=
 =?us-ascii?Q?lrQz6q9yATjF/D61MW+miQYSMO2y7cmhi+TcGGjWB0kPhUV1MJ59bs1BF/jF?=
 =?us-ascii?Q?cZrCngCMr2YOyTCVNIQXCmSd4/11y7g0VXXk7CydqkXWH98ZY7JC8VXUwArw?=
 =?us-ascii?Q?vMEY4Z6tsYC5InI9GTkzzDgjDnHQwRLCBG65pQSZLMCLSV9BkwZTvm2R6F+v?=
 =?us-ascii?Q?A3KsRsUz2PYQ7dKkQrogFXdVRiU9zHyh5+LEEtrqOACucfaZkjhV2K8k6uNF?=
 =?us-ascii?Q?nE3l58IVYptWgtNgVv6rfACwrkYrF1SHeapNEo6SvwrzFGBBrE7l4pzvYxr2?=
 =?us-ascii?Q?H9pQ8jWa/Vq0BSPWnj0a/cl4fWyEV92cpYmr1yEq2kC/ecSmV1YOLbZlGdMY?=
 =?us-ascii?Q?yW0CWvZ1Cxmg4xqC8fGygwxkvlECkpxszWwU71aGXAzKLAiahJNcag75azCU?=
 =?us-ascii?Q?AQZ40J3BLjN1OSLNcts/czId3iAYMO96Mi0mtElhDBWUKmZHsgJajsBJVqMf?=
 =?us-ascii?Q?COjrYrZUPnWwJ3VnGP9aMpw81gVFsmh1yQ0aUwWiCsAdYSrJXbqAwqsWzsJ8?=
 =?us-ascii?Q?cZ7Gotl1uGbQYwyz3iGe7reSuF6y/jo02MPYXmxH60nublhg2vjeKO7SllZT?=
 =?us-ascii?Q?dJvm6ycqihpttC66m4OAWL/uWnuKHLH+yHpikYvSqNVs5wenmxYBlj/jKepF?=
 =?us-ascii?Q?r+Avx2g4pUMEXjLayJyQdu/ISYoEpv58SnshlE3eB2s7gd1dPSrzL9lt46hl?=
 =?us-ascii?Q?gRnFEKwKWQa0X7qH4HjGCH5ZY45UqESDx30Zq5XJrdBznph5ppirNvmljmTb?=
 =?us-ascii?Q?AulDYF9BOLWbz3oNQh7i0xdOPkA55ggTWX7X0FTx3O1ypoXyTutW3o0Ib0uU?=
 =?us-ascii?Q?OkSVuU6355dCibQPmHodXonGs4COfmIzU8XRR1aj3zT5v4xvFzP0a2eUURdb?=
 =?us-ascii?Q?gQYsKPJosll5O8gaYf3wRaHgbDr9NV6qrCiNjlEsAWAswSEFx7IOpwQ7lJNR?=
 =?us-ascii?Q?yWQ9dJxlFFR1dDCb6T3ydSrOQx51rSpoT+5xLtAcwKQTjnskDSXWkgj/e0xk?=
 =?us-ascii?Q?DOf3FAG8WlbLIh5S/BmbVWRWUDUIwwKyS+xkDSxp25tUTK0k/9Wp2BPcnpt7?=
 =?us-ascii?Q?La8xWssNiou5hJwaSyFTiBjqlOPpGvQSOXVBDKpLBc5PkQm4uuXbRKcCoPdB?=
 =?us-ascii?Q?i3/x+d3kiiaZS6pv2tLwYq0BUe058HQRPSrUP0AfbXAGj7du+vC8cGz9TRaV?=
 =?us-ascii?Q?+Qo5NlWXQuk8xhu28/FhwmGGrzLCLkNVn8qyLqpJHw7Ydbj5JRszM5272t/n?=
 =?us-ascii?Q?nVYrZW9o7s/RWYIt3WT9KrUCWvDyCzdNyBH8rLpLCcx1+jeo4+hT0+fG0cZI?=
 =?us-ascii?Q?MhKJAa7FoePsEgAkMsKyx7Q2v3KR1WbrphMzEpXmOvTBo8L3D1dm+1aktFlz?=
 =?us-ascii?Q?CBFjRflUg1pFGponPqfo8OrrtlZbW261L+z6h2P1tt8+nh4zxWspT4JNaouM?=
 =?us-ascii?Q?7mEQ5aSn06k7ZDqJUklytK8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cad084f-0dca-4ea0-3413-08dca28b921b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5471.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 15:59:12.4443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RMN5p0BTSd93bsOosD15ba3QU+zoN7WlgSADaPQReCV1r/U813IBZ8K4/MPKOL7sA+ASADPp0fCwtUxvPV+wZmmCFLWc9DtqgsqCHkgvS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8070

Yves-Alexis Perez reported commit 4ef9ad19e176 ("mm: huge_memory: don't
force huge page alignment on 32 bit") didn't work for x86_32 [1].  It is
because x86_32 uses CONFIG_X86_32 instead of CONFIG_32BIT.

!CONFIG_64BIT should cover all 32 bit machines.

[1] https://lore.kernel.org/linux-mm/CAHbLzkr1LwH3pcTgM+aGQ31ip2bKqiqEQ8=FQB+t2c3dhNKNHA@mail.gmail.com/

Fixes: 4ef9ad19e176 ("mm: huge_memory: don't force huge page alignment on 32 bit")
Reported-by: Yves-Alexis Perez <corsac@debian.org>
Tested-By: Yves-Alexis Perez <corsac@debian.org>
Cc: <stable@vger.kernel.org>    [6.8+]
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2120f7478e55..64f00aedf9af 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -857,7 +857,7 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
 	loff_t off_align = round_up(off, size);
 	unsigned long len_pad, ret, off_sub;
 
-	if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
+	if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall())
 		return 0;
 
 	if (off_end <= off_align || (off_end - off_align) < size)
-- 
2.41.0


