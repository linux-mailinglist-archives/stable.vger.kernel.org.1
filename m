Return-Path: <stable+bounces-71567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F04965A1A
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C611F224A1
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 08:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079A116C6BD;
	Fri, 30 Aug 2024 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="fm19jzOr"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2102.outbound.protection.outlook.com [40.107.20.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F10D16A92F
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006082; cv=fail; b=qOjXpHZwnTonfcI2e2bYds32V3ykkC+ZX4IVwdLxyveTlAoG39M7oB7mVotwjcaRLATnfps7j0q7wGafUwPdOKRPy57JcbEvPufYB7d3cO1NpskipIZTkMROkaphg5M/Qq87x3VdeKrL8qsFs4CG84YanSCv2TOv3ueZm7Qw8Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006082; c=relaxed/simple;
	bh=NczjjtON0pO6X1ijxtzkfSsfjfDcso7mmft5P0igElI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ul1Jszz1RpEbDRLossnIZRwNizDYDXv2YQ0vvzaawwMt5xa+iPTfpKUBg0G1KbWxJImLa7NEFQT4HaHdsIlFJ0CtBO5rQ/TE+cJ8xi1kc7awaz58qmyQRobOvLjlilJEdUP2NExVc4QKSXrQjLLqGyvIaYY1LbXSKFPDpgxvb5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=fm19jzOr; arc=fail smtp.client-ip=40.107.20.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqBJlde1aYWwhSt5jV367UV7Iao6FByUUDXNzZzNth+84ZhngFgYmf6OGYXImmD6knyH8atAriTSwdd2i9OxhDWOp9zHpM9htcurGxUaFosVnMnu8zkuVSizWGjntqUyynXLV8/XqD8K+uQEEGhbjE/gBBIk0IqfOSH3Y/x1HnErFTtv7UaRtQsTZSCkjMDahqteGixnr8fSQSOB14QrGjD0b7P00YxGa2ybVUeLy//00ikSGvZQPX/X2/ci+zihrYhQUUEq4uXc3I/xozkiqrjgVHQrWH4OjMitmR/N44D8BZG9eNYGOd1UPwnCw1SQRux3zNDHahgO5YdcjQIucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h46s2FHkE6qA7J0C5go3zhsoLKzAwuhyIFSyaag+vws=;
 b=hstWJhhdEwByGhMZ931NPaHyP5ksZ+7EsAOsbIiuUPTUk74PTBbJF4kU4scil0Jq9Fd+8ixmvWKzVPZWZ0cgInyPLpqqX6Cpa5T1NHS3ZiMOr0ZN6h0gmmoG3q9B43HlRlG2QvGHpod7CniS+pun2wCrOGM9q7yrgdK84U0MKe+DM8eDLv8nrVJ5ZfB+cZf/g6e3GJy2HbmZIFY+TLWla313RT633YpwS17ZKPkP/K7XohhsT2GvDh8CqyF5egZwKOQ6y7pfB7lg8YCPRErERjBKLGcDjCZ2D2cb+q+2LgjkiRK2ASpiIzb1pOZ52JZb3qvWxzqLuUgiDiJIf9wInA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h46s2FHkE6qA7J0C5go3zhsoLKzAwuhyIFSyaag+vws=;
 b=fm19jzOrieDMTAUXjZXvqikp32KDzO5AJwvkayOoaxfkkrN8YM4k0nLU8KQ73HyyuL2f/cB+GdO7xdCODWEB5A4Yo7nmJT7Im3jdLIRkBT6URvdvgJGIlEtelA8Rt2nvWbOcicdpVd8M5/M59kCjQFOGp8/izhRJKKgSZwgoWB9c7jADB4A6AfHFZy98+8XRgQA25GcgqitZZIBqfXy4E5bxUXc+vMaDkMjvaAyrXghy22MTmldIOgyXlDpArNF9pzfbKLo/27J917Uv73SGJ1plg/UCPi5GclZIlnDYNYTLE04t0KuthpnbwMAWR5hQFRtNcqwz0Zxu4e/c/QGMlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by DB9P192MB1827.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:39b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 08:21:11 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 08:21:11 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Vasily Averin <vvs@virtuozzo.com>,
	Shakeel Butt <shakeelb@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Andrei Vagin <avagin@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Borislav Petkov <bp@suse.de>,
	Christian Brauner <christian.brauner@ubuntu.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jeff Layton <jlayton@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Jiri Slaby <jirislaby@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kirill Tkhai <ktkhai@virtuozzo.com>,
	Michal Hocko <mhocko@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Roman Gushchin <guro@fb.com>,
	Serge Hallyn <serge@hallyn.com>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vladimir Davydov <vdavydov.dev@gmail.com>,
	Yutian Yang <nglaive@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 4.19 1/1] memcg: enable accounting of ipc resources
Date: Fri, 30 Aug 2024 10:20:28 +0200
Message-ID: <20240830082045.24405-2-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830082045.24405-1-hsimeliere.opensource@witekio.com>
References: <20240830082045.24405-1-hsimeliere.opensource@witekio.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P189CA0050.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::25) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|DB9P192MB1827:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e0d72c-a98f-40ae-a493-08dcc8ccb454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IFptQVvki3AqbTnVjnkXfXI5T4Y/XppT+O3f96ip8SHIRapuQVU35fjVrAzN?=
 =?us-ascii?Q?bVoawWij+4rVLAFdRwJ/Bz7dHSQlx+t0VEF8DhiJGrgqsRNablmAg3yVJC2y?=
 =?us-ascii?Q?kg/JHRQL1uOlWVJ5+7lq+DcDYbl8wWD5/rEuvc9I8qCxF7CF298VewDnD2YI?=
 =?us-ascii?Q?22cAvKIBBR7Ha+GPHkOF+0InSoI4d0Po2vMEuOnS6HgF/il0uEJJvKOxp1Bv?=
 =?us-ascii?Q?Ru3+qqU0KBU81yUK/HSLpmU0QSApk7APtUkgp+RdKqJ2ClSiXtfhqWA3METo?=
 =?us-ascii?Q?okBHMh1w7s5SVsOpHoMkn8vWwIJP2kuxzc7a2kczUxgREAddIwUcudWO91SB?=
 =?us-ascii?Q?DxW9KuxpM2kMQs0dafZco76nF51414bl2B24PF02wFwHrD+Cvrk+xZ0ZvIQ7?=
 =?us-ascii?Q?D1FIkYFcLp5hhTaEPE7gV18WyETuv0OP48RaT0yF6AMmYYf42t4HyMqNuzcN?=
 =?us-ascii?Q?GZT8rYGO3cwbF79nmljAwV4u9Vzy6hfAFQmFJXWixsIKkRc/F3RHLag1c+JW?=
 =?us-ascii?Q?0ZlB9/7ivWN105AwMX4oSBUpNUxIs0oXZpkltoS67uRGFZmepsy81rTa9BCm?=
 =?us-ascii?Q?88L4RefAfHmymGNUZ+zmqSQ6Xf60rUDwCC6rzHWbfg5uODWlaGy6G01dP6R8?=
 =?us-ascii?Q?C0hvyAlBmlCtGlCmnZgM2WVUliTgj2J5jpkdeM/rDU84MhG/c7P7M9KOGb5E?=
 =?us-ascii?Q?xQens/H37/U6s++izgHEsb0xMRnugB+upLyhY3JLvvRBCFr/P0epWhZNbIzF?=
 =?us-ascii?Q?M6BtZt5AI8vSh4pPsjwB7KFXRqI8oiQ0C7Kkg4xTtvbPbCdx6mxG6PXWgH6u?=
 =?us-ascii?Q?0ubi0BsRZQLqTw5UfukpVQQmnfzCDTT/iKp8J7TOdw5b/pvFlKKs8RzRkyNp?=
 =?us-ascii?Q?2R22Jv3Xzh/MA6rguueXe9klCEWz04NEcWHBZ8EHLlMlZODS+wrqdzEc1560?=
 =?us-ascii?Q?dhdxzT+HvD/kUbzHkNPKZiXJNt1k6faK/0Tmlq3RmBTZ+CWaz5OMxKtsgV+G?=
 =?us-ascii?Q?Mgtw02kFPlGuR+poRUDb06TdZEMKbdeS/1H0DbhfEsbptpO+g+oqUJoLK+iS?=
 =?us-ascii?Q?NAU233YJKOe0x8c5Epd/CuAxbXI2hYLbRnBoeWb3x6O3QzVMXI6IAT7KrWpu?=
 =?us-ascii?Q?3kd3YgbSViGgCH29qWiJSZ9K7STZX50oUpkW1t/hUYnXZ44ZTEyXz5OtBAlc?=
 =?us-ascii?Q?hUZYw4/26wNZ01BaR8kPDGZldBxAEZuVELV57Ccfco6I7WHciGLjRnYw4lnp?=
 =?us-ascii?Q?IJ4VeXW5mQZmU82La927JmUhkEcR+AIYJPY22LwgDns9/ZrYDf1VJTVuyawK?=
 =?us-ascii?Q?JaSTJePQGubkO9aiq/Hn7AEEk9meocEotwyPClJcocQtRtlV1+lZk/esyikh?=
 =?us-ascii?Q?9htZVqY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M7dGI8U9jRJwsAgEa3KhmcIlDTQYBWMVevVYwO8iHjeJd/W9+qszXTXJS0Bu?=
 =?us-ascii?Q?xAAdN3oVYUje1V631hGL6QBwyYQChDwngBkA8q18XgGvYfC22M27eCOmQebQ?=
 =?us-ascii?Q?C6+FPlOdzZoMXItPG72pn3qTQQtzT89sUNsKKot1OHCB5kGYlfOwjao84f6f?=
 =?us-ascii?Q?tmpiTiMuyPy2Kg68h6obcXQn4g+CbuvaCYmMfa5+dMo6cy97E+BMZ0oBCgoT?=
 =?us-ascii?Q?kSAxdfx3/tDB5OFJxaziMfvDgLrXvBLMCfw0rC1w6x8Uz3TQkY5kwxWMyynz?=
 =?us-ascii?Q?sqL4KXmsiLTnj991i9+MMNSvOmExdz5PDXkqqiGdg8FrJ9Ot+VcJz/33K+mq?=
 =?us-ascii?Q?hNrvF9X3XrCKrbXvj1hd3LLRgeo850QrV/fHZDYRoJcTYo3ZoolvsmZJ/eua?=
 =?us-ascii?Q?r/wRavVzqvwazQP2v1XpqNjFoc5/sFJiwra0wzJScFqlQViI5/R1atd6tDOm?=
 =?us-ascii?Q?KZrTh/MsoUJq3YB3u/JwTWHQjnhH6Nh3sRBvd8dqCVkVqykP59FLbOUPRTjW?=
 =?us-ascii?Q?td0kAaX7hbo7GNHn8acM5UatNQryYyPYCI3jxC93xDtJv52tpEm5YVGX5hxM?=
 =?us-ascii?Q?dFGnCymaNhApwW7iC+TJaafGqy/OjQ94dtgkCY6NC0gHhO8LQZ25vP9xbPiJ?=
 =?us-ascii?Q?cDZfj17mVc8vSxIhTov706VhsfGbD5bxdSokEK7JTB2+wtR4wC/nbPvgM8MR?=
 =?us-ascii?Q?6FrV5rEFAsFISI8yuG7lJmDwK9MKj9kr9t3Z3tW9lhFNDW7tlqCnSQ5YPcON?=
 =?us-ascii?Q?m602X+czfrLm+cWkL2fT0IdWAI0ngTNL0eV+//TLB+UQ+0TJURYXUIA+3OLz?=
 =?us-ascii?Q?xlw4feSCAEstc8NFkUOinyXD52I1JPv7Lzl58Vz1AUbXSBZGcG38I7G3npYZ?=
 =?us-ascii?Q?fpyqY1M2UfH0gBBf3t21mVlN0ffQK8d0EQ5JYgEVk/NOniW21R/Ndxu2Jo3j?=
 =?us-ascii?Q?pItyHAEa7PpQh2bzE5vIJT7szA+LWBZBAUQKf1oJdM/nlCZJQbojMB0YhpBV?=
 =?us-ascii?Q?b6tUQ3Al1/HJnRgyNG0smoR/WN+CRQrT9Sz8S9N+x09/X8obGFHtT4ncfMTB?=
 =?us-ascii?Q?meZipZEnFFsl/u6urYip1rWXCqPYjkeq0M5k0rk1JTpG7IiJQCVW6p9QCNmH?=
 =?us-ascii?Q?erEbFtFyOX85BJgPKqIMJknkuPmpG1bPxWxaFOu0bn6Zdke6tSdl94eYBdyw?=
 =?us-ascii?Q?8ZJL3Gadf81VLEjqM/VhgD/jBzALKNBHEh/lt0JrgYvlsrU98I6ahp59K4oS?=
 =?us-ascii?Q?ICtC+1d1z2eI8VU9mKX0eyaN8rqcuDyHdwkRYTl7HXHoLw1NJWJ6NnzGeh4S?=
 =?us-ascii?Q?XV5kwqMi9U+i/FKm14j1cMAfjvdCyd379NpZwFU3FYEdI9AAoxqquiF/pXXj?=
 =?us-ascii?Q?dpeChm5j1USzl5jxFB3w4lUK9dag5IHlNMaD4S4aVWraAXkCmLNzWeGCWhbC?=
 =?us-ascii?Q?2Ro07I3wOHfEFTBZwBl1OPVfeHk2d88WDv46ZkY/AUvPoy7y0/HD3nHYfmDt?=
 =?us-ascii?Q?fYgrN3DuF1fMOQIbC/ITD1sAb0oafEr38Ygj0gAroM4FsyQxb+p4B9YdJfSp?=
 =?us-ascii?Q?jVbJPe8mOIez3PbOX/MKWkXUuptw4fRnFNbG4WMOmf45KvnUTQyfDPAiGdwd?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e0d72c-a98f-40ae-a493-08dcc8ccb454
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 08:21:10.9955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cgNQIrgvfydY0wQsk/5nkShbcOrX+yOTwX1yngAT14TCONv+KvvUJY7zueaM8wo8Y63IqWRpUeGU4/U1Mdf0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P192MB1827

From: Vasily Averin <vvs@virtuozzo.com>

commit 18319498fdd4cdf8c1c2c48cd432863b1f915d6f upstream.

When user creates IPC objects it forces kernel to allocate memory for
these long-living objects.

It makes sense to account them to restrict the host's memory consumption
from inside the memcg-limited container.

This patch enables accounting for IPC shared memory segments, messages
semaphores and semaphore's undo lists.

Link: https://lkml.kernel.org/r/d6507b06-4df6-78f8-6c54-3ae86e3b5339@virtuozzo.com
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Yutian Yang <nglaive@gmail.com>
Cc: Zefan Li <lizefan.x@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 ipc/msg.c |  2 +-
 ipc/sem.c | 10 ++++++----
 ipc/shm.c |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index ac4de3f67261..9a1ff5669cfb 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -137,7 +137,7 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
 	key_t key = params->key;
 	int msgflg = params->flg;
 
-	msq = kvmalloc(sizeof(*msq), GFP_KERNEL);
+	msq = kvmalloc(sizeof(*msq), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!msq))
 		return -ENOMEM;
 
diff --git a/ipc/sem.c b/ipc/sem.c
index cc6af85d1b15..8010cd9d1d7a 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -494,7 +494,7 @@ static struct sem_array *sem_alloc(size_t nsems)
 		return NULL;
 
 	size = sizeof(*sma) + nsems * sizeof(sma->sems[0]);
-	sma = kvmalloc(size, GFP_KERNEL);
+	sma = kvmalloc(size, GFP_KERNEL_ACCOUNT);
 	if (unlikely(!sma))
 		return NULL;
 
@@ -1813,7 +1813,7 @@ static inline int get_undo_list(struct sem_undo_list **undo_listp)
 
 	undo_list = current->sysvsem.undo_list;
 	if (!undo_list) {
-		undo_list = kzalloc(sizeof(*undo_list), GFP_KERNEL);
+		undo_list = kzalloc(sizeof(*undo_list), GFP_KERNEL_ACCOUNT);
 		if (undo_list == NULL)
 			return -ENOMEM;
 		spin_lock_init(&undo_list->lock);
@@ -1897,7 +1897,8 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
 	rcu_read_unlock();
 
 	/* step 2: allocate new undo structure */
-	new = kzalloc(sizeof(struct sem_undo) + sizeof(short)*nsems, GFP_KERNEL);
+	new = kzalloc(sizeof(struct sem_undo) + sizeof(short)*nsems,
+		      GFP_KERNEL_ACCOUNT);
 	if (!new) {
 		ipc_rcu_putref(&sma->sem_perm, sem_rcu_free);
 		return ERR_PTR(-ENOMEM);
@@ -1961,7 +1962,8 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 	if (nsops > ns->sc_semopm)
 		return -E2BIG;
 	if (nsops > SEMOPM_FAST) {
-		sops = kvmalloc_array(nsops, sizeof(*sops), GFP_KERNEL);
+		sops = kvmalloc_array(nsops, sizeof(*sops),
+				      GFP_KERNEL_ACCOUNT);
 		if (sops == NULL)
 			return -ENOMEM;
 	}
diff --git a/ipc/shm.c b/ipc/shm.c
index ba99f48c6e2b..0a5053f5726f 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -711,7 +711,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 			ns->shm_tot + numpages > ns->shm_ctlall)
 		return -ENOSPC;
 
-	shp = kvmalloc(sizeof(*shp), GFP_KERNEL);
+	shp = kvmalloc(sizeof(*shp), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!shp))
 		return -ENOMEM;
 
-- 
2.43.0


