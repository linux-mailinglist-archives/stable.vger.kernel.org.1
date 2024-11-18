Return-Path: <stable+bounces-93808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435A69D153A
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 17:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B92BB27CFD
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 16:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDD01BD9F4;
	Mon, 18 Nov 2024 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RxOKnzO4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o7NMkAh3"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C501BD007;
	Mon, 18 Nov 2024 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731946738; cv=fail; b=Gu5UA+Jy5aTQ732hAgXOckKyMi8w/JnnD718r/pVzlEpi7ZrZceku8lZc7KtQU4WclBjoqBcW4sixKkyCMPk3nWhJqnpjR/eKUWsaEv180RrZoCgmXWdaeYZA0JrUKR4pfmfl4l1ygU35Y5gF+NbI/AfubxEDYFjsghLdcSk1kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731946738; c=relaxed/simple;
	bh=sjI1WzT1XqGz+xz3HXhuHAdt/2TF7qsYE4GFZx6Qt38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BMePZwTt5V2qvD7e82Bo8J5RP6IpAxI0nf9n69fiZ5zWGFWFVCcapLXQ3fxLF5Grm7VzNJXoYh8CvscRR8rb3NS/QuhNj+nTwoVB1RT103IXwmtGInSaZ6uqo2WmTeByXmDe5P37pfT5NfIwddK3gTSUqck7DlsbHRRsiCy1SAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RxOKnzO4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o7NMkAh3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8QXZX032645;
	Mon, 18 Nov 2024 16:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OxWMYoiN4etCWEyz5nY0Duc+cphdupWfvPon5pvG3ks=; b=
	RxOKnzO4cNgq8fEj4WhXU2d6X9MJmgpQKqQePnp0jyZ+AEXrVgV9fRStYO8eDjOx
	BOWXaS/C0qCMTlxZO+P4DGqW7/GWlxjvVaurvNvo7lB4ka5Ag9jIswYssMBkb94k
	UhL/oYW0SMm3OkxBkzUZy0/YAbQpoOSU012ai4hoN2ddunFc1Jsvbgy8gUiHzTww
	EJCS1UUKdbCPEcEbWaqHN/2ezOarwigumoPCl0UwgQv3lca6WgANsH5qOgE2f7+K
	zIdLW1IAw4dVniMSqAzbwhZBnHTuRQAhWaqBeiZUjtak6bMIbtn+R6pbqpqKWiok
	n+7djNborFkpNmsr31zNsQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0sk2md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 16:18:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIFPi6S039269;
	Mon, 18 Nov 2024 16:18:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu78bdx-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 16:18:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/eYt9oA4A979OouXyh6k1OmeaOJC8fEUEess0uo6CrOAot2aDgORyokE0AR7hnXumR6zkAdFLE/8M0fJxkYCsLZwiLo5hHRtikqgKhIVMsA/F18TPXPUkyrfVJze+V6dpk75qQcymGdxiFTntNuGpvTqbcDH0PtJaHckntJBDEwpprVPBF+ivKci3Ugge28IJi7olMLtKc60oPYQbt41I3zkS8LabDKhPzBoK+Lbp9Ui6cMZY38+lQgij1wev1mQnvM4UK9IqkGbHiei6Yv4+AzIWg4tBfl36nwUoaLIu/6jzsSS+qBQDts8lHkDYwhKfR3b0nO7q5emiG2p3CqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxWMYoiN4etCWEyz5nY0Duc+cphdupWfvPon5pvG3ks=;
 b=CKTEl0NQ6jLfPYFQmlqWeT9SsCl/nZ3kZGWCGRXhiNl9ZFTson93TxeN6KHWVq30y7ckx5wOOLLDMelyHo+2Ho4RNdu5UEeS4Mr0OuwXaRUcc0yfoMHUQzAVNMo3+dxYKLu8oyZGlW3GIuPY3JoEfUcE4Uosg/Q+uAo3H6vYlYJ4Sd2HabSkPIcKoU3wUuay9qknRbUUhRCuSpYm0TLwt5cpSv73Y+RrxwmhARDyrDTtHxkrSBr2NjhW30OZ8rAvNKPbDkdKbJcUwPYQwDhmnNoehLFxXPhozjCgW3mwI/1qDr1xIk8A0s2vubvYYs4uPLUAnNJDfJg8E/abxQlBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxWMYoiN4etCWEyz5nY0Duc+cphdupWfvPon5pvG3ks=;
 b=o7NMkAh3wb8L3t8FT/HsQr8poWe9WdIoX7dzNkq+W7H46U77aSsE/Oyy0KBIvyAl0LTmuv4SzXge74USpbH93qoK0W9hWfl9a5Ne5f0yXWWXQ8Ex6iLktvvcZ9U7aoM7Vfjg1RZ7xnKeBmZgLMwjOYn9DoVg8OrblrO7CEgVKrw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ2PR10MB7619.namprd10.prod.outlook.com (2603:10b6:a03:549::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Mon, 18 Nov
 2024 16:18:18 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 16:18:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 6.1.y v2 2/4] mm: unconditionally close VMAs on error
Date: Mon, 18 Nov 2024 16:17:26 +0000
Message-ID: <ef2adefc6ecba82fc5b5615f459af5881ee3c013.1731946386.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731946386.git.lorenzo.stoakes@oracle.com>
References: <cover.1731946386.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ2PR10MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b2c6d4-44b8-4cfc-ffd7-08dd07ec9ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7zWCD6+UaHc1dDXaCjxH/JDwvw1Xbrd/hVZVV96BmdyEQCIBLlGRhy6IiWpo?=
 =?us-ascii?Q?DsavrNXNMNGI14Y1W7w7A7gWLuROg1BoC+9jXgEh2p/gtYy0gg5AoUnbcsY7?=
 =?us-ascii?Q?1M8jKeO/MlLlZfc269deHgzOjw5WOl2QY9HehkUfh8YxQzBe9wVvgea26oki?=
 =?us-ascii?Q?DCztX7C4Co7zEwlBmzVoANCmeTR5oyaCaY/Q02BgICOOWAWJkWevk8GVzgQ3?=
 =?us-ascii?Q?xu8rGko0Wb4ri1HcuT+tCrk+FajpU9MFDy+FQNvNF8Jb4A5/b425G+0oOdcr?=
 =?us-ascii?Q?RY5ws7ZOuhWREbS/csadlgdzun7HQwQqyDUVXQaH+ExoEuffoS7/vC0DzLac?=
 =?us-ascii?Q?Ux33nAmjyyktEAxG/K0CEYHkh5LIfflsUuAeOhdE7633/ZZkrXAzHh66aU2H?=
 =?us-ascii?Q?CBehUJUQEzoBCDwE8GFWZN/NrnqhW4QO/oInt+Bvte3ffk5vOnolm2ucwDX0?=
 =?us-ascii?Q?IhkLWvmGF3qxujnokPVf8Olzi0k558tudnqbHAIAHpF/C/gCRQWBPwnMAvGA?=
 =?us-ascii?Q?w19ztBwQPIan3vR6BQFf0qVRv4Z9fEg3jhoHRO7YHbDS5WQWLehIV0aawEsk?=
 =?us-ascii?Q?AC8iWi3RRZpXkwrypaHRwlIEsVsuvvwKgUDmF5DqdvHEKndknxM0letcJM3/?=
 =?us-ascii?Q?Sh0BM1DT6FRepsnFQu9YFbGFV6L39cD1jc09BLvvzVjyJd/9HrBpZIw4pE2X?=
 =?us-ascii?Q?+YNzf36yfpM/Fo7qvltDluAvdf+hiQ3u37gqrj4QHYK8xLu28t+Iqlu4Ghsg?=
 =?us-ascii?Q?pK3bxDWRRXrYKBpV0V6iFAF4RboE3g2/BV3kvlFmSe79KfBFmFzjM7v+yhuR?=
 =?us-ascii?Q?cnX9NXZ0GLInJMynxBPMslIWbsksS9ohOK+qpIz2wb93oeveFms0ufyCcKQe?=
 =?us-ascii?Q?mX97PjpXIdJsjMgMCkcDLQfjaNzszwkB3EJcnmKRJw79DFoPL47XY17jE0Qn?=
 =?us-ascii?Q?UfCXe2CWwzK9iRREV4NlcoK0NGMULU3MPYcdtoNZLMlbDUxHK+PIYu4n18mS?=
 =?us-ascii?Q?wuYl/D9ZPM0jh9R814lBp7P0lCsfMN1fp3ZN7Onhi00clUwQhy/nty1yOIvP?=
 =?us-ascii?Q?mWM7gBzssgHkHr8cJobOXlREgk5jMKZpdLheqQhDM74NLOMjjhfeMh8xXEKD?=
 =?us-ascii?Q?XbkHapxRYIVtNpoMCjwOBRbc1ET8E9s+ZqZMGhASAORVm35+kgqMmpmsfuSk?=
 =?us-ascii?Q?8vvFje19i6q+ysYpW0xuM/ibt2g1Q5JOPE/8PeMfui0aOvz/oGE/wBjk6KuO?=
 =?us-ascii?Q?nCnaLgMR8cq1jrQfrIAE+oCrY1/TIVdGOZWC7Mzalxwf/jk1ZkBnMQmWXP87?=
 =?us-ascii?Q?3N8cs4Kj8eKb0cF9th+iRvFS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HPNvWGweDdconWe/cD2Am8iUoEb090Hm2VJh382ixZhqTQCe/q08Mwi/O5U8?=
 =?us-ascii?Q?ex/JSqsepG3T2z7lbI2/6xJz7SPn088Mi7VPdYzHv3GkfHYurakBQV3lR9Ss?=
 =?us-ascii?Q?UHClv/dpwZMeswacIwSAfPtwkvfUn7InvMfBM1/z1YWmNxExy3OjUiX318Wk?=
 =?us-ascii?Q?4dvrOpLFCiXEKUuAR5vEhXsHtYmgzKexRnjYiWzgMVbHHA6vc6KLEuY7cRwA?=
 =?us-ascii?Q?Np53Yb2CD4Q/Y9fuzlsuhdxgcSYatV9H0o8eiICy3zNHvMJa+pTenZP2YoLp?=
 =?us-ascii?Q?FuHSSOQLzzFhghtJtpOuQYD+VsysXXfqE9OJpP0sT+wVvJq+8+kvWROQmpqO?=
 =?us-ascii?Q?QviXh1gf3PviJhbbF2YL2PIwiyd/1eKEjIHb1Fv0/wFHDMsA02zkUOcyMCh1?=
 =?us-ascii?Q?WSzpdJtMwy16Tc4kdSUEZUnYL+PHkJtepCzHHJ70LFdAnqq6aOd9//vCaGoH?=
 =?us-ascii?Q?mc08u9Foa//pMQp3aNcl4Mb0Ly8NWIHE1JdGzMclSDk+eLq6hVg5lXwCjGiS?=
 =?us-ascii?Q?WnZXIgHgRpdc9oynC3l1cVJycBuKjkK0lB456ia6Y3O5cxlX4IIQ5cWspGA6?=
 =?us-ascii?Q?zkDFhJyEAxZA25SMP2sXDLnaW2MXx8LWpeCwTBhEb+rDv8I93YeDyW+z9s9s?=
 =?us-ascii?Q?xOOjFw7VePnsBn1v28E9mZ+Umi/l7xq4ewy1OGguYlz0tsrhYBX1VfbTa7X2?=
 =?us-ascii?Q?u8s3RRsV0n7bUZiaJNZql4lN/0QvXvMDTpIkY7Qigl0YkQsmNnK6B1QcPw3F?=
 =?us-ascii?Q?U1wGzeSr4bRrtdyBzEoNPFk2SVUpmmWX7UZY8pghr7cwajvnhspi8u9Am9yw?=
 =?us-ascii?Q?GdVMxoTeBUGoOtlP+uYPaTf+xufIz007Tse9/VtFHR3uWTeoRp7pWxGNaKZa?=
 =?us-ascii?Q?MPlH7ES7wF310mmJ0wfdNH3v5dYSBNS1c8oSLdrYwxlX5Jewi2efdh55sqMH?=
 =?us-ascii?Q?AaS1UOIaiy/TiQNkiCXABuGnZzteQire2LLPNoQoFWEI9PT6vK9YIdMkZNSw?=
 =?us-ascii?Q?5UhQeCprJIb1CNPeHxu/7izBWWQWVZFh0LzZJYBB4jglktTKh0cWBLHa+Y0I?=
 =?us-ascii?Q?heap5nBonxxjqItpABE/26j9iJpovp6FYnHuzNV+0XptlOUoLXGyiNTtRwTn?=
 =?us-ascii?Q?1IhDHdag108RDPL3cgs2j0FUhneW3LaKzNZEmK5kRQhcjOTN7giPeFbzYCLE?=
 =?us-ascii?Q?Lwko1iOkkV8hKRDD0r15EL77UbNN2GkrI6aod3A0aF2Uxjz/Us9uoONyV9si?=
 =?us-ascii?Q?u8JSlVgR1mG5xQBaPGCIYkCoOpDlvyesNwLwb++DxHuPT3YVlaX8GhV+ISTp?=
 =?us-ascii?Q?XZp1oyGlMzWs+EKMhA3RPBYQyAC1SRYAbuBzGFucolkshU+uWIR1wCERKJjL?=
 =?us-ascii?Q?dPf8Wznk8aiPGS3dnSOLoxu0VCzrWDvKG+xVhnX8uINnkTX0V7gRTEvueqpx?=
 =?us-ascii?Q?TYnAjKLoTCAnjfmCR3ePTg+oX02/NCfLqAgjNONBbD2ggLM3Sn0kmeyS9n0Y?=
 =?us-ascii?Q?/pQLzy8B20YIT4hjhpeipBpTbZ6bvoG2/bgqtSuP8p/+FPvap0HFpum+OzT9?=
 =?us-ascii?Q?KodEnOy9VL7hGJkMe4Lmz96QAn4k7Z2pX52gBYzvHswL64+O2s6nybMQBfaB?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3gLIGuE9OvP9/BruG+eWWYIwTkt0QIoOPzX88B7BNAJU2/xZLLyVGAx1nkBbAW8Kgmsr9AtO6AJOIBqaEdtRutkPpUh47yzZZwQMkHWT/+ZjEvM36ON3T/ja7yqD5oirTWBUp5EPbRMb8FCSu5i0Y5nKXuhN0XyLU7s6n+FhLJXBiArgS1Wo4SqUS2t/POM65TkhL/Eel+noUSNn0PPHCNKGh+i22sAPSscXthcBZd1hG+AIEdwB4TKxKHkq7Lb+Qf2GqpqtaEfKdZ019wz/OwuRB2xsKxdLtl0yU9fSazLTwyaYC0j7duFEAQvco5h/4qP6Wf/lmOgfp+UoHGOYWxGYu57wWqYtNE15E3Zru9i5o7k2L6RGidyZrniynou5AfLyfzCYpAMhqDQVcrcadvlDlJp/N0w8JPg4Hd1Oe+dOAxFLO4s+nbN8BflST3oL1/nGriK7QX/iV2AWQFXGjcdJX/DDbpm45dqdUKH0XOyyyvRi/SBjHkwsxrHZG05Fma6QRre614QdwxasPpWDXLtx2Y7kxrv/AqRvq3MTpOCVSBYiYvUgrh+HKLowNBlWSg6gzu6nUZ7dpNSDZ51vM+Ll2A7Xg1KZL4bV3XHZpRM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b2c6d4-44b8-4cfc-ffd7-08dd07ec9ceb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:18:18.3789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdDMH4QSpRrevIbgFXNn0/34dl3kTuMyl2W1qGSK+MGXCbfB2HjrbqFoHufA4aj5Tp7+pibeHAIRmz7pT03BuN0zqFbhPOvfETxP5aNJe28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_12,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180135
X-Proofpoint-ORIG-GUID: uJBBSe8JciJ7_GG4USGnHHdOOdYjG_tM
X-Proofpoint-GUID: uJBBSe8JciJ7_GG4USGnHHdOOdYjG_tM

[ Upstream commit 4080ef1579b2413435413988d14ac8c68e4d42c8 ]

Incorrect invocation of VMA callbacks when the VMA is no longer in a
consistent state is bug prone and risky to perform.

With regards to the important vm_ops->close() callback We have gone to
great lengths to try to track whether or not we ought to close VMAs.

Rather than doing so and risking making a mistake somewhere, instead
unconditionally close and reset vma->vm_ops to an empty dummy operations
set with a NULL .close operator.

We introduce a new function to do so - vma_close() - and simplify existing
vms logic which tracked whether we needed to close or not.

This simplifies the logic, avoids incorrect double-calling of the .close()
callback and allows us to update error paths to simply call vma_close()
unconditionally - making VMA closure idempotent.

Link: https://lkml.kernel.org/r/28e89dda96f68c505cb6f8e9fc9b57c3e9f74b42.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Jann Horn <jannh@google.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h |  7 +++++++
 mm/mmap.c     | 12 ++++--------
 mm/nommu.c    |  3 +--
 mm/util.c     | 15 +++++++++++++++
 4 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 85ac9c6a1393..16a4a9aece30 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -64,6 +64,13 @@ void page_writeback_init(void);
  */
 int mmap_file(struct file *file, struct vm_area_struct *vma);
 
+/*
+ * If the VMA has a close hook then close it, and since closing it might leave
+ * it in an inconsistent state which makes the use of any hooks suspect, clear
+ * them down by installing dummy empty hooks.
+ */
+void vma_close(struct vm_area_struct *vma);
+
 static inline void *folio_raw_mapping(struct folio *folio)
 {
 	unsigned long mapping = (unsigned long)folio->mapping;
diff --git a/mm/mmap.c b/mm/mmap.c
index bf2f1ca87bef..4bfec4df51c2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -136,8 +136,7 @@ void unlink_file_vma(struct vm_area_struct *vma)
 static void remove_vma(struct vm_area_struct *vma)
 {
 	might_sleep();
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
@@ -2388,8 +2387,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	new->vm_start = new->vm_end;
 	new->vm_pgoff = 0;
 	/* Clean everything up if vma_adjust failed. */
-	if (new->vm_ops && new->vm_ops->close)
-		new->vm_ops->close(new);
+	vma_close(new);
 	if (new->vm_file)
 		fput(new->vm_file);
 	unlink_anon_vmas(new);
@@ -2885,8 +2883,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return addr;
 
 close_and_free_vma:
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 unmap_and_free_vma:
 	fput(vma->vm_file);
 	vma->vm_file = NULL;
@@ -3376,8 +3373,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	return new_vma;
 
 out_vma_link:
-	if (new_vma->vm_ops && new_vma->vm_ops->close)
-		new_vma->vm_ops->close(new_vma);
+	vma_close(new_vma);
 
 	if (new_vma->vm_file)
 		fput(new_vma->vm_file);
diff --git a/mm/nommu.c b/mm/nommu.c
index f09e798a4416..e0428fa57526 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -650,8 +650,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
  */
 static void delete_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	put_nommu_region(vma->vm_region);
diff --git a/mm/util.c b/mm/util.c
index 15f1970da665..d3a2877c176f 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1121,6 +1121,21 @@ int mmap_file(struct file *file, struct vm_area_struct *vma)
 	return err;
 }
 
+void vma_close(struct vm_area_struct *vma)
+{
+	static const struct vm_operations_struct dummy_vm_ops = {};
+
+	if (vma->vm_ops && vma->vm_ops->close) {
+		vma->vm_ops->close(vma);
+
+		/*
+		 * The mapping is in an inconsistent state, and no further hooks
+		 * may be invoked upon it.
+		 */
+		vma->vm_ops = &dummy_vm_ops;
+	}
+}
+
 #ifdef CONFIG_PRINTK
 /**
  * mem_dump_obj - Print available provenance information
-- 
2.47.0


