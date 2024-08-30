Return-Path: <stable+bounces-71580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E50965D26
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 11:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2EE91F21187
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 09:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC571428E2;
	Fri, 30 Aug 2024 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="w9Mm0DFY"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2101.outbound.protection.outlook.com [40.107.22.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECC115F41D
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010822; cv=fail; b=O6n8k4NIUivs1fVncASUlmj1IIt7s2YScikJXIQUvqV6Why2TSiHI8dVwjj7mkQgsFSvDsahizbaWihzS9Bmy3fmp7AzsuBT6FMH82srk61aaauTdQViMpjm3S2AlQNyTK9uiIsb4fphyma8UL+7MWWxPaSyWabHKVrr5yMwfDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010822; c=relaxed/simple;
	bh=prQ8fFYV4JxZFzMoxDDwe61uEbckrq+YrSKbv6FOazk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uNpG/erZ9NlS0OV3S0OcktDaVHcgoAH9KTn9UOv92mpoMrgNrseL08F9Z7HRTO9WdMylunfEKNMqsaFmFZdpc00DpTfpvQX1drcZzKsRyiVqebeSR88r1ki9oMA+RJJ3nEIWBPOfY4SqLNkA3mlVewvfRElHIzBK6fKoxZdQ5/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=w9Mm0DFY; arc=fail smtp.client-ip=40.107.22.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtEY+rQeVcpUtVhCllz4YbCL+nzjcNFmFj8TYBGUGRDA2DiFMOgLO90nVX9S04RGhvlQSnKdBtQNlkgcokwpLUrScMe+TzA0I851wS6hDOnISJYe+IFF+VnrrRb8Cwpn9xFK89uZHXENv7gL9FlwOj2VFlXhXbuRWuBMl77aDjkTP08XC/w1007SAKJgzpH8PdRzqjeqkNhUZbqWqmYg3O9rhZdRvy+rF9BoazX3zmu0sUUplrDZzMwJE2l6jHCz5r+GBB5F9lT2FkNBgbsipXxYdhMsB6B8GPJqXp6uLu6PmR8gtNwawkxlpmORKnQfBH/ckwD1bTayCvGNFqSjjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahaDO2SZeYLQzQr/o5/3vGZzZ1JylzDB5jKPcMVFHI0=;
 b=EbT6rGuj+WNwPrd7tO/nyj2qsJ7xbTm8ufT54SBnUQTBUZwi5KZa5wJWdZ6V5x3n70ANdwKLv8f1lKiun3WLfqC6E5iKKmwYMOEJWeUlZql3ZYJHl8Oga8IbM6XBBLvUygKpjbVeyRA6vQVkBmrDhgyk6Si3sAp/eB7ZdUZNewTr00P9l2hSQKNinY/iARVxu8QPRtInWA3cgHLbYady1C79+eMrD0Yxq5b+zcLCtHMhTUVwHi5tIgbaaZvMgWP1Uvz/YIfetjKN0Le8Q7PD0/lFY0t9XQS9dmArDTSdn7Tcg0SR+OW7nvTBpcy4iv95KeGBoBRlh3I8v0mptTatsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahaDO2SZeYLQzQr/o5/3vGZzZ1JylzDB5jKPcMVFHI0=;
 b=w9Mm0DFYC3wA4Fzvlmk1pPIeNTlIHQO/Y8FxxAGNfdey78dB3J+sSMKogtpiXOtgB4tQEmyatmD7KV56dkKkUa2glEFkM7+49giUmpMHhRHAyKBIC3Hx3an6oNm+IdEf0GxLfD/uHUI/gwnf107gxkJI8N/fgrCUx1+PagpH9v0tgiSgC8bJESNMAvVLp/Qf7Zdb3s3eqUo06+sGaNG7kSN67pt4MSafa+NLlUSfY1SLK3HSe4+XilreF5eEk95rrWmQpJLJ47De/HVgCw2I6duImYIBcAE15+DnwwLGPpaG0iFXvPyP3U6WtJh8iIElJboFN8u6l926K4mTl+uxmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS2P192MB2145.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:62f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Fri, 30 Aug
 2024 09:40:16 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 09:40:15 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Rafael Aquini <aquini@redhat.com>,
	Davidlohr Bueso <dbueso@suse.de>,
	Manfred Spraul <manfred@colorfullife.com>,
	Waiman Long <llong@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 5.10 1/1] ipc: replace costly bailout check in sysvipc_find_ipc()
Date: Fri, 30 Aug 2024 11:38:29 +0200
Message-ID: <20240830094001.30036-2-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830094001.30036-1-hsimeliere.opensource@witekio.com>
References: <20240830094001.30036-1-hsimeliere.opensource@witekio.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PAZP264CA0076.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fa::23) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AS2P192MB2145:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cdd8c91-0ec5-42a6-f38d-08dcc8d7c06c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JG8SO4aPq85IQLj5QqNwXJ8ljPa3s70308GkUVVjAxB98UpiuTf4EG/ii4Qd?=
 =?us-ascii?Q?5jRk0K0lOaFVYcHlXDFh/uqalhsuO7I17CxWc0DVJx1rCb3+hAKlENYFzOmw?=
 =?us-ascii?Q?hBiAFA0nGYTkiX05x0YGoQkkdDRDCnOf2AGDR+x8dlmUyTsMvymso4kkHgGb?=
 =?us-ascii?Q?CioZSM/uHjOHv6TBlwEuwLjLVp0BPXJWhjrXxqcXYrYUWr/WXm24GQsH6HrJ?=
 =?us-ascii?Q?xkMWyjeU/A7Bsx2Zt6bi2upDrwuUKRGAi5Cl6drEmqkLNxqhoAU/aHlecSUF?=
 =?us-ascii?Q?kC0SiQxWBqrxfR8fPLlwLF5uFdjfuiyPDyAgdY/hT4QBs9vLrx+GT3oOjLc9?=
 =?us-ascii?Q?YIqVBuzhqItlAyZ6BvVAqctULzDpWJXjQDYI0QilpAi9S/RNkr3YjFelGitI?=
 =?us-ascii?Q?3gCzs3NePwKgnut8euqUpVL4xaD+jzsXsuJ+iInLVzF7Xy0hbzRZ+8HUGZqq?=
 =?us-ascii?Q?4zhHITaO7Lbv913gY6mXO+SyF9EfsZz3rdUFIJsM//wKdoTP/nvJ7XPlyIKy?=
 =?us-ascii?Q?T3VlkFSzxkUBR/0NJSf6yOVdFyhNRMkkDZyUgkSRmmH9iTFUyYF3XksTYiPa?=
 =?us-ascii?Q?ERFlB+H3nnyql5QCWlMZ6EGNOEHG6isnfC/fSEgmhHvqXlTcUDWDuGyJqvYT?=
 =?us-ascii?Q?FQ6BLDsZQbnXH/lsqrajE8JIOg+CPtAUNOpnBoWUU9GebgzOE3PDyN0YSxri?=
 =?us-ascii?Q?wDzEtMLOuPNliYZc0ZlLkzxaYx+noFwhlC2rpErYcmtolHoHHuRFmf77liB3?=
 =?us-ascii?Q?oc1IVnuzqKDNO5PLAOZHo60saCzCjFjwu7hGUEgLfczFXtztgxuopdp6Cw2a?=
 =?us-ascii?Q?opptBS8b2sIHAYqoYGkq+k9h8XLRfyloFRkhuVkYgaztlUtuU7LA5XbI9mqR?=
 =?us-ascii?Q?LEYHan2WRM6dImzXvDE9SXwC733cDqGY2dc+aA5gDwXJrqVWwsvDIwcQBdUw?=
 =?us-ascii?Q?EJVTzD+HpvCyo6N2sGlVJManRu66k1ZSLZ0B2eYI0BcN0wS+KU1/a0Pe2j+b?=
 =?us-ascii?Q?NAQeV31de0KlC4AmTmImVkvIOUPAFYmWdw8IFKlVvdCaNUkUYY8LXO9hn53r?=
 =?us-ascii?Q?JkcNCrT6YoKhDY+r96tORpMSnCVHtog7yg3DQs0KUMayKj0L0C2Ycx9t73+u?=
 =?us-ascii?Q?DMBS+kHDEYLLz9Fs0lE7PmQ08l87AvkmK8yVhvf+USsKFYRkme6Ek+45wwWI?=
 =?us-ascii?Q?5veIr3UYrEpxaJDS6ov9l6xnFHuNHKD5lRzXQJdrNlmKrh6qwZduJMRgxtr7?=
 =?us-ascii?Q?aT7LRv+sdq4yQtri8KYmQjgLXmEDdXPnu/qwpabGsiBHV0inwwkDWpkl6eJf?=
 =?us-ascii?Q?oDQ7YmFk7ecjosCzTrMK0X4Q5s6c/6N3Y93+OZyEG+/g5h6yUQrIRgbs9zWo?=
 =?us-ascii?Q?o71HQco=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+HV7NgvYEnwrf+35chDuuaVBPPigSCNyCV1LRmmi16EnjCjBWzfuoHxI/YEV?=
 =?us-ascii?Q?cEL/65EKQy6Y3pTgR6gTGcKMLq1wsNscG56vvlwaQH/uGfEv9tFZbJPPhxHl?=
 =?us-ascii?Q?Z333GbrbUtiHnle54Z7JcjGX97DL7lEprgYRMPGjaJ1Kig0yYd3QcxGiRdIT?=
 =?us-ascii?Q?9lGeCTSAxFavPPMF3t80tDErflaOJ/2oDIkkA93oBS7WFsordtUuQmz/0Ixh?=
 =?us-ascii?Q?n0luycbp9ITTIcrDLKGfX8ZxofmdB3ps3PqLLZ2XuLvXNN7bxlbhV/13Ra41?=
 =?us-ascii?Q?6oKfsh/RIRF2ZxkAarDOwfKDzLOoxC+jh6Jc4Vzle2hKVX5nZABPXiv4EZ1M?=
 =?us-ascii?Q?9PNQTTEHogZG1z1CHk5+5qADA34UATGdAfe8G5IIgIIuEwQ2l/d3VV7DxrEv?=
 =?us-ascii?Q?Eh9U9Mdf78wq3r0WuoMJ80dJEZwD8GLH++rfXJ9AbQ8abWLwb9t2OKwxU95i?=
 =?us-ascii?Q?7tFAFJZWrurQz3yqBrkOfIXxFl9DudVk3YORJom+9ihOgPyDFoN24D1ELn/B?=
 =?us-ascii?Q?mbNFhF0HwO1bryU7LmNTmAyETrobDKnp8DbMVyjpMgtsQp74jdkH3sz7jXU3?=
 =?us-ascii?Q?nURylJG0w39SWPjkEChxKsVs/pW4ML37mNEvzip6hWWYKwW8kUcHabpxJMBn?=
 =?us-ascii?Q?hRcAt2JsHOOFZCAE/Z7WSXPH7KmU/ZN395EPpnlv7kWyy3ZYDW+Uj/J9PdRG?=
 =?us-ascii?Q?viKejqTvvm5rA1vpWjNqzlXEVCGGGoPJqnhAxg2uI9r7zxrV349Gf2LD4qmi?=
 =?us-ascii?Q?pEAJrqUif74fKlltZM9dUK7fjkWF5pGNQgEVvDbGvZvikcPHDjTV4QYuPPW7?=
 =?us-ascii?Q?QGR5grAEcxVp56R+G+jS4uhhyczdtfp17x8BU5WLHbOnabSnNReIRjbUAEXd?=
 =?us-ascii?Q?+B03B6/Dw6qKYCmXpousG6tlaZuY1T8X2OUF1T7/EXYymn3OpnHV+68lJuR1?=
 =?us-ascii?Q?uIKy6eXxz5NMHwH87FDxJH2Z+vVf/REHBo60fz6hUqMaxsZBxml2aqKfJ5Sc?=
 =?us-ascii?Q?qAOl7xdUbjsffG0iUi4TzS5yO6eQEMYUBEexxuu+YcEBVubHZnI4B/ur16Lz?=
 =?us-ascii?Q?bHXSPckr5XnOOzTmo6W+C40lcoWGV0W/mq+WR+9DyuChOWlRalepX2zwzgta?=
 =?us-ascii?Q?WnOUbqKbCKiiZj3igLuZPZfpxDcfaH0nra8oYYp1/4ttT6GjHtWGcwdEBg18?=
 =?us-ascii?Q?rkkJJiAYeJAyZgfLZDBGJqMRSAYarrP9S4Uvf4kFyczJINdKY4VxET/P7Yga?=
 =?us-ascii?Q?VxTSdE9fe3FrqugGJn/+4Lm/WdIY/eosH0xddE59I2wpeZIl2xTaqC7NuKt6?=
 =?us-ascii?Q?R5r9DtZHIYnjBjITHgFNzz47sojCCLiBvweMcSEGUOqafpdIc+I+hX286mpp?=
 =?us-ascii?Q?WdTOlVcL+ePFpn8TjUEJ4eLmhbbh6PCky4m00I2lExrsBRJCA5lTc5kAGLPX?=
 =?us-ascii?Q?3I4ERQfGWFWweakHtmGzhPtXE+4U32Wct1z0yPmhUeobRI0nNiwJM+4vpuH3?=
 =?us-ascii?Q?dT8BpJYFC6Zv/8qPlnjIdxwqsi3L2BsGJtVg+47KhvuvQq0hrmA2zaQiDEv1?=
 =?us-ascii?Q?HkR/qOmLtwYEDYU0PuOkiDr3w0CGzI4jc4MNJSWzgwfQU41+0kztiRfzCSVy?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cdd8c91-0ec5-42a6-f38d-08dcc8d7c06c
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 09:40:15.2813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuW/ndsQu5YUJ8hOknk7awWvy6LmxbgWnMgnsBN1wRivpVTfxBinIcmhmg8HtK0opjousL8UJAJ/V5CZMe/o7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB2145

From: Rafael Aquini <aquini@redhat.com>

commit 20401d1058f3f841f35a594ac2fc1293710e55b9 upstream.

sysvipc_find_ipc() was left with a costly way to check if the offset
position fed to it is bigger than the total number of IPC IDs in use.  So
much so that the time it takes to iterate over /proc/sysvipc/* files grows
exponentially for a custom benchmark that creates "N" SYSV shm segments
and then times the read of /proc/sysvipc/shm (milliseconds):

    12 msecs to read   1024 segs from /proc/sysvipc/shm
    18 msecs to read   2048 segs from /proc/sysvipc/shm
    65 msecs to read   4096 segs from /proc/sysvipc/shm
   325 msecs to read   8192 segs from /proc/sysvipc/shm
  1303 msecs to read  16384 segs from /proc/sysvipc/shm
  5182 msecs to read  32768 segs from /proc/sysvipc/shm

The root problem lies with the loop that computes the total amount of ids
in use to check if the "pos" feeded to sysvipc_find_ipc() grew bigger than
"ids->in_use".  That is a quite inneficient way to get to the maximum
index in the id lookup table, specially when that value is already
provided by struct ipc_ids.max_idx.

This patch follows up on the optimization introduced via commit
15df03c879836 ("sysvipc: make get_maxid O(1) again") and gets rid of the
aforementioned costly loop replacing it by a simpler checkpoint based on
ipc_get_maxidx() returned value, which allows for a smooth linear increase
in time complexity for the same custom benchmark:

     2 msecs to read   1024 segs from /proc/sysvipc/shm
     2 msecs to read   2048 segs from /proc/sysvipc/shm
     4 msecs to read   4096 segs from /proc/sysvipc/shm
     9 msecs to read   8192 segs from /proc/sysvipc/shm
    19 msecs to read  16384 segs from /proc/sysvipc/shm
    39 msecs to read  32768 segs from /proc/sysvipc/shm

Link: https://lkml.kernel.org/r/20210809203554.1562989-1-aquini@redhat.com
Signed-off-by: Rafael Aquini <aquini@redhat.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Waiman Long <llong@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 ipc/util.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index bbb5190af6d9..7c3601dad9bd 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -754,21 +754,13 @@ struct pid_namespace *ipc_seq_pid_ns(struct seq_file *s)
 static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
 					      loff_t *new_pos)
 {
-	struct kern_ipc_perm *ipc;
-	int total, id;
-
-	total = 0;
-	for (id = 0; id < pos && total < ids->in_use; id++) {
-		ipc = idr_find(&ids->ipcs_idr, id);
-		if (ipc != NULL)
-			total++;
-	}
+	struct kern_ipc_perm *ipc = NULL;
+	int max_idx = ipc_get_maxidx(ids);
 
-	ipc = NULL;
-	if (total >= ids->in_use)
+	if (max_idx == -1 || pos > max_idx)
 		goto out;
 
-	for (; pos < ipc_mni; pos++) {
+	for (; pos <= max_idx; pos++) {
 		ipc = idr_find(&ids->ipcs_idr, pos);
 		if (ipc != NULL) {
 			rcu_read_lock();
-- 
2.43.0


