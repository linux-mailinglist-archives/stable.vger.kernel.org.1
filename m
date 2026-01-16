Return-Path: <stable+bounces-209984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 196D1D2AE06
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 04:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 946B3300943E
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 03:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A219930C342;
	Fri, 16 Jan 2026 03:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mP0Y/zJS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IdLRowKQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7DD2F3608
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 03:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768534771; cv=fail; b=SrXQz6EwXmBjNEdqns3id4s5XFeyiIPVR0MowLbTomakwKBVxhpy25JRcw3Au/NNVuO3r/DL7uJy8ZYoyXGyfi1alPOtsKddF/C4+ifrMuoqtKlpp4JZ1TkjP/W2lKrPmxpVPKXMxAeTjcw2f5vHRzkq81ZjS4wVcC/4MqEHuOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768534771; c=relaxed/simple;
	bh=dLSRqdS7lpSlJOoZWDy9Xv+AVOeHMf2AqSUdZsBlbFc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RAVaH/ADzHfJ3zmmZ6KvHdI8xg3wUcnJDBdFNH3SUuFgtN8Ztd/Ggj7oqWLe6Wlp2wsQq3Fe7wvdm2x/cr8eAAhtjN+jlTvRvqsd2Wol8jlAPX/r2/v1bkIwZxskJT9pWX3Yemsw+CSBm0FwzLXMBidaKgN0aH3n0ZN+bhPvELI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mP0Y/zJS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IdLRowKQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FNNF5T1429743;
	Fri, 16 Jan 2026 03:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=egoiuM8R11RfgGwA
	DTqjHOkiJ0d63EWT2Tq4bXYFoXo=; b=mP0Y/zJStKgvDsVrC+AI30TDwtlFtClW
	zWH13HE+m77HugT1m339FSCvleU11diN0jL+Q87b0O4BJmx7Qfl2JV9+6ZJWkeb+
	o0oXGwAfxbZoDQ8Myx/+URZOrdFHXLmNpA+rZ+O/C88e5Y/Ld1aW7Gn9bFoXrrkO
	olPOrtRuX1UuqP9w3GYQu2LlRFtJe6TWCOUMG4YKpOatP7cPC/p9Sj8+N1asert5
	N6GHOCJoMFKUIBIBDF5o4lzK2s9wOoAI4zNPWt3B2iPXS853PviICcWxtP6omGff
	mIaaGnra1SbZYDiQUXi/grn7KK76RrZZ3lPrUyvBIbgzBjSGvQth8A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkre41ba1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 03:39:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60G2j7d0004358;
	Fri, 16 Jan 2026 03:39:13 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7p13sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 03:39:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIl9A3NUV3d6APb+uLcRE/abZBXnDqPWKNTckjEmq08zFbgwOkSziWrMSh6AKUfqBVlGDBaWtCKKLKcp9oHLxamk4geZBzlDxtBCym4S6aIqK/TZWa3oYTyxpP0wd0GFnbKfN8o5ipF26zAK8OSlQvH/JryAXisT5OU9o/Lq6TB55Z7PFevoQu/lO+/OHrE8plVfLcvuJN9fENd/UcHLhiDSP1/srtDzMju7I5D6PxuoKk73qtTBw+jTqlSkJyNBVFXkxYj+qJ7YImjKvP8x2zWSFXfUJ1dfCuydSPlsn3wpWcYzpHkVt2oGzVJfcwNNETrlZQIgaOWt34F8UaeGSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egoiuM8R11RfgGwADTqjHOkiJ0d63EWT2Tq4bXYFoXo=;
 b=QWJkkYPhvi1sGW6S87y48YoX9UQofPlDdJGIM/8nH2nGIuyFKzKZo1sjn7BD66E3aWVEMYRK1+p742sNh3XS/0UDO6svzC6jPfNsHjNXeD18tx2eyfbx/dImviuySVGhsH9w4C9BnoJI0uVkOJbPS2DtRdtrSo1GD7ZqsbK7wo63wx3Z82m07gX4yhPHpUDBcB/whRzkwlAqz22r6CEomd9lUYD7EqLTT9MSPySUfTtOi2kPA3YiNwlGjU29fNeYVeJ+ygc55l4PCvwHYXVFUKURzFAarFL/enc6ccolT095Rrku8iv19CaXh4IkWKe3NSvTaABgVOAIu+EUnR67zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egoiuM8R11RfgGwADTqjHOkiJ0d63EWT2Tq4bXYFoXo=;
 b=IdLRowKQBvOKFjTV/fvqoFY2VuKb9RCxLVMVfVZPNsr+KucnU6CHWOa0JYcyJfI3yfw7ANDGi5XCp21b0IiKosYxsK3uYd+wo0Dxrm13+sB5braHlBJGOk2krDVfwll4tsXnKKKfrNIpVgQ226F5ymeo5AI6cujeJSpbfbiyBgw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH3PPFFC83155F5.namprd10.prod.outlook.com (2603:10b6:518:1::7db) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 03:39:08 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 03:39:08 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, david@kernel.org,
        hughd@google.com, jannh@google.com, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, pfalcato@suse.de, vbabka@suse.cz,
        Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH V1 6.1.y] Revert "mm/mprotect: delete pmd_none_or_clear_bad_unless_trans_huge()"
Date: Fri, 16 Jan 2026 12:38:38 +0900
Message-ID: <20260116033838.20253-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0171.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::21) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH3PPFFC83155F5:EE_
X-MS-Office365-Filtering-Correlation-Id: 070c77c6-5ce2-4fcd-9d53-08de54b0ce27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UD0PKOLmCxUEMU8h4gFMJn8Z0jWHwM0S20TJorObJwIL/zkx+1VQtEGyGS1V?=
 =?us-ascii?Q?5UtZH3R63LpPqOOslC+AZOA8/UI89tgAuaIAb2GH+LHlV+zPCObHR0V3p7l5?=
 =?us-ascii?Q?mlVRUcQf81Yy5gn/a5CKGCZP+zQid4OTRkioSN2s/PitShIl/cULVGGdGha4?=
 =?us-ascii?Q?9f3pJZhava3aKn6/v0P5DMinW0Rko2qEgO5CokPW7hqc2UnGGQDjuIDkeoG6?=
 =?us-ascii?Q?S8vLH5SkD0i1LdZ5N75RLolAlPuDigKzhFDgM9nqGuohXEDtH5Bed4VGIlM6?=
 =?us-ascii?Q?nbGBSIqg80VRIW3hdu4EsUKNyLrU3ARY1OPzpt6oh+OOUApykuS5skRCzmY6?=
 =?us-ascii?Q?anAdGb5NLl7ZnCFMjfLOK0L1kQtNl6LkUKYdAxkM4hYw/gp+fYzexvrzWVq8?=
 =?us-ascii?Q?Cr6oh5oJaquBOxRlGAS9sm8vJ0KO3acmQ4Y84e01hBQ4oyGXHBokrBDg4Put?=
 =?us-ascii?Q?tUMS8GP+Oxp5h3Q0SQdEY1Fjy3/AnCZrfMQ40mJ+yI8hn5oX2ifv+7GkL/Ps?=
 =?us-ascii?Q?gIsX2eMZ8tvYyuvzqq3jdGOrPmq7Uk/JQtAyuhoBeiHs0ZH0O+rrTlad2AUX?=
 =?us-ascii?Q?hPIkIWKuCShWMXrVB4OYoRvG36IIGR/yi7FxgquKWMeJICplYF2rHKP75E+7?=
 =?us-ascii?Q?YVvfroKnQd5G/dIISDWozuA0nKx/kC4zf6sgBCnL7TtNmu4Uc8uhWHBIfZ38?=
 =?us-ascii?Q?ysgi7xQ2w8LM3C7aMPu5AwHFWxVFDe7bHcqO899EqDGKfvsrUMVQ+InoTGHL?=
 =?us-ascii?Q?9NOgYbzkPmXNqIy5Y7SXAckCddzlUG4rV2WRRNk1ov7cIlxD6rDnDcGr2J53?=
 =?us-ascii?Q?s0oValqthhvdCRsBYHpTqVriGDuk1Pz79LRlry+gM/X0zSuWL5evRtLiYeMz?=
 =?us-ascii?Q?TtGnBFw7vL5Ha1CaM2AZfa9qmQKfpquc8jz6Y6lirq1oBtykuk2wCpEUM6kr?=
 =?us-ascii?Q?6DaGoJ7AfdqpcGiRF28VwAtUwhQBQnjg9emFQt1NJjv0Y1UDHY+I0Xb782eU?=
 =?us-ascii?Q?RjTB4GsanG2zncAEyKhapG++OxLHS6VPbAi1YJQFFkBd6IiTmfDzhOmV/c7k?=
 =?us-ascii?Q?a2XYXasannvYzdvVTAguK43xi9r2NVIsxuPHmDeCVqwWvBmyDykcLxSWG2QU?=
 =?us-ascii?Q?Olu6EoM/pnIWP9l6CSsrU9lkEz7aMPHYruPWqaDeHrhrAjCDzCp57VgjVqNk?=
 =?us-ascii?Q?/oyIt4LKqvvEJ5zeqNMjPUFb5udtsCvX5OMvId13waxD8gAiGSJF43tYH4F0?=
 =?us-ascii?Q?Yo8FSsgk4w0CENMY6Ux9I5zsUR5TqfE6Q35USwLkEw8IYRa4zWZ0bBd8yJ6K?=
 =?us-ascii?Q?8pqIMOl7tP8NBaGRrttQx6ZkQq9qI8X+qCz2ibPYHwpSvgzGSB4RUHVabKeV?=
 =?us-ascii?Q?TOu9YVUdcrD5TKkdUS+aQipQITv1lZ1jlhinM+nf4miIBsHicg6ps1nVmy6y?=
 =?us-ascii?Q?dTQfSAWcihyN5iDjoA4HisOL4463hrISmE0Uo+FoxBQWfXIztgKhGkt0i/t3?=
 =?us-ascii?Q?CUo8pe3z2PE/aRwloRfC6nGblid54dj1RDi22uwzAAxeTjI0/DSxGTm4I3kd?=
 =?us-ascii?Q?7kX/k+wE3IFQ0Lm6I3I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IZOPMmDOdPFwjUEz2gcTr0xWOBTg84y+A3xPIA8eNsuJxYrSIOS4231EdXMD?=
 =?us-ascii?Q?6XupZfShceGVe5UsrVhwbdlPCquL1wTptGCERzMjKHpo+sgsz+fhlGlfRvqX?=
 =?us-ascii?Q?mFtQ1toBMamDWFCTmjLMumPv2lvuD8CSmAkLWG3vUfsnCZkKIXDJrC+2+gU/?=
 =?us-ascii?Q?Hs8oqabxlH0GuAMaxkMljIqP/UBPBuGqhnPzWPOIYa6KCeC9LBC70yC+Hb5E?=
 =?us-ascii?Q?ZHqejXI0G85OD/rc9eGrT6AmlnTtdfqFrgg8FT1Sjc7zedoLb43V5gmVqGng?=
 =?us-ascii?Q?rfmqO1QEa+ImkkBlmTuR1rl4QuHACEAH9OdS8XUys8ooldAsvOz1xu2thNh/?=
 =?us-ascii?Q?7zLFF3dxSTiysdiK3QW2CvSbEbbrDwu8anu1qAj5/WPu8ZOtya3z3+2BWBdH?=
 =?us-ascii?Q?5m25D0Z7DvD3HOTAeVyWvWXVSrAZFtc8fWDTNgOmR4NaDYL82I6PIkaxLmX7?=
 =?us-ascii?Q?Oenyno5e41isOVuVmC2eIAniA1oIqgqeJmJ38tTcFLdJUzx3yHdvwVRnaxLf?=
 =?us-ascii?Q?JvTGskaPMcss3IFQXL933YBr+xeT3GdghE1G0I6G/4Iv67qLdq6sBGQXDKUB?=
 =?us-ascii?Q?l01M/QcCbZDG+8GR5mFNhbQMgHwBiDgxv24tHgTnMLmbJiv9rLO4KTIY23x6?=
 =?us-ascii?Q?Dx8bh5rjqSq+E7r9oTQPsVG2AoSpIwzuevhOL9zxhHU/tvNK7ai3AXQG0qnf?=
 =?us-ascii?Q?NOjsUhlBc4PwfaCS0OJjwaT8oPwM1xbWdvmUSlkSv9t3hjp4v2PhO5wIsrIF?=
 =?us-ascii?Q?X7JFDjToZGHc8w+T+su+0KZjJ61ydMy7XOcBpmUvZpuaDIWGFEin6JWElOsd?=
 =?us-ascii?Q?WcFYVsj1sPoRqMFB4qzf7xFx+hUeRyMuw8TlWnnMdgXbt632oIRbEI5Cl+WK?=
 =?us-ascii?Q?1SuJUYbyScAardfoWjiduvQvo/Q8FLjmt62cAiGtXgO5qGihNeikSISVnGhz?=
 =?us-ascii?Q?Xr8Tf/iW9MiIP0CIg9Ggb+anjAMZyOJQQ3zGbA4536T3iOouVZFI3HrdLPiQ?=
 =?us-ascii?Q?Au5XIYCjUJW9pYYC6S6mUW0DQ02FeMmGXLjZwGknikxTsda9KeSXWrukO2Dr?=
 =?us-ascii?Q?zJcPvo3MbOYWmGwvPVWU3yyjAyXSQ8kvObxgX/1ZV32m9Qf22RGvFK0Xqth1?=
 =?us-ascii?Q?JFH9WdvvNCmI4HM07KUH4k/uUPPjODeUpScde4J1L2BR/0sK97kBsW9sJ+/4?=
 =?us-ascii?Q?xbvOeoQAT2QRaeAyTYHsrrJJryMFfh1GbgK9ltdeCws9T8hPSGe3edVtFl1N?=
 =?us-ascii?Q?yeyuDt/sWxMhk1lgHXm82GiCjdCDS5ccFEOmkZV4e9vbGwO6KZjLaktIzSHx?=
 =?us-ascii?Q?/dDBPZaJDftuny8fdUIJpXvvd48P7OkM0ejKk8vLzrv/ZmyJS4Aw3ozIASCu?=
 =?us-ascii?Q?JD9xrZ9zY5c7+0gHnBadVfDiv607I4Ia552BQ14uIE9PNuiF8/4U9LPf0t1n?=
 =?us-ascii?Q?+3NiE+fw0lDwIuado9hskINrSBn6GYnXnBjilIErFt2wb5laEYW4yMfeotHn?=
 =?us-ascii?Q?SOdyS1LUxxgkgeDURW2LFcQuh9QU1B6aJy90KeFGg4X1JRi44UbSbiAIGLrR?=
 =?us-ascii?Q?GgG3gfJWfTQ8l4GjkU9H9y7gcaTHiBv7/zNw097Hq5x2jO+ghytwbBlnNGi3?=
 =?us-ascii?Q?7+L9ZoRbQjT6HQoH8Q5qx5sAHgPKkKFtyCkSIwCHj1oBLEGx1kM6oGrYBuRt?=
 =?us-ascii?Q?UBZCAAgRS7nAtm6OU5kSs40BfCIigGxyKqqGcEN2Vf7GH+LsaE5+cFcyfoZP?=
 =?us-ascii?Q?UNcnGYByCA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5c0HlK5aoTY45zjILMYCVr2oi1L84zzF5qu6B9KS7B1Y8kDoJKYK7zj4lHp+WVF6YWb+HwZVpSjGXksV2YvCjeVFC4xnPTEeNHTMnLqMgChfs2ClaPZ3l+lPxe5I8aHf87W0YgUtDuiZBani0/2LcL3PqHNDwq0R2h5iVehVEb9JV/N8Q8uNCQZBJDr+ql3J6Rb1gJUSwPdFjDJHtZFO8TPc7hQcvc9W5jzIPsKCDPFLOFwyr9MeGcS+cOrZD9yOD4oPXLQkDKNfe5kBy3Ry776gjLA07BWsFIxaBB+YdpIUFzuXXOR3PDIdKPdOcIqXAPdCg7dVZHPxngh1E7/nW0OBKStJWNOkuug+bHkHFwGNGbyXG0I1LeCymOW7N6TiVluIMFDOF8sb+zYhJNzR1I2+i01+B6VlwKNYrOkgRIz3I+CbOmLolC6MkLkG8nAkZ3nPzbQXwDLcrCWPRL1W/V/tuZj7oNkwfBRXGncO4VVbTBbLLyG61yA2s6RpZgBk0FDuk0648d/SyLNRy2z4GBBGrGDZikYXQ9W+DkgC58LUDAmjYMgFZbHVCnvUKIJeCxreDJ6l+SDnTFpt4iZJilJwQBf/bX/v5aXiCIuuVqU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070c77c6-5ce2-4fcd-9d53-08de54b0ce27
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 03:39:08.6036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOFuWpuBBx30AT1K0LTTo3xuEkZEQfQ93fFTJzIzPrziR/JU+9/hu9us1hQf7TIdrFHwm+XdsS/5Qg44sgqygg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFFC83155F5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601160028
X-Proofpoint-ORIG-GUID: T1uBelgQioPMOPMivfLoAVRtVpGOJv22
X-Authority-Analysis: v=2.4 cv=YKOSCBGx c=1 sm=1 tr=0 ts=6969b2e2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=EAewW_Bvr-9Cxeq_rZUA:9 cc=ntf awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAyOCBTYWx0ZWRfXzLgvT0lQtbJj
 5iMDomD3cue1eIJxm109W2hPgp32WE36p8qfcnvOFVxAl7+AAz4pE8u9tCZl1jscaTabq8Nxtmq
 CDLdIKrD4FylOAzQvqotmIM3/hmWBT/7NsZL3BGp9NrnQk83h27uXh5bapEGXl3aImUmO5x0D/6
 mZGcFEiIxQUBdJyuyoo/GwN1dG0OAXtvrUN5eF+MdCH2w00kUBoY7A3aX6WdT6nyV4atFy5279E
 wcY9/3jYvJygyqteK7/+bP2ofF0AJsciFlBrc4CWHn9Hr28wMlZqcbkagNsUYFjilCd+4+GYshV
 Goau3gc0iLlNpG53CHxLbxHtZf19J3Yie7l+gt+bN3EMaTdBAxiPgQ7rLiHTCRw837IpVe4cZ5d
 Y63pgPDAhUwf7OgqyYGlsX28BJjzyQJu4EICNak6eCOfAByDxQ2ia95/eXrRtNTBN6Sa5NI3cTf
 eapecwLNhCqnDNyoFg5qS0LJhcdXCjoqxR1b6Kh4=
X-Proofpoint-GUID: T1uBelgQioPMOPMivfLoAVRtVpGOJv22

This reverts commit 91750c8a4be42d73b6810a1c35d73c8a3cd0b481 which is
commit 670ddd8cdcbd1d07a4571266ae3517f821728c3a upstream.

While the commit fixes a race condition between NUMA balancing and THP
migration, it causes a NULL-pointer-deref when the pmd temporarily
transitions from pmd_trans_huge() to pmd_none(). Verifying whether the
pmd value has changed under page table lock does not prevent the crash,
as it occurs when acquiring the lock.

Since the original issue addressed by the commit is quite rare and
non-fatal, revert the commit. A better backport solution that more
closely matches the upstream semantics will be provided as a follow-up.

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/mprotect.c | 101 +++++++++++++++++++++++++++++---------------------
 1 file changed, 58 insertions(+), 43 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index f09229fbcf6c9..8216f4018ee75 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -73,12 +73,10 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
 }
 
 static long change_pte_range(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, pmd_t *pmd, pmd_t pmd_old,
-		unsigned long addr, unsigned long end, pgprot_t newprot,
-		unsigned long cp_flags)
+		struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
+		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	pte_t *pte, oldpte;
-	pmd_t _pmd;
 	spinlock_t *ptl;
 	long pages = 0;
 	int target_node = NUMA_NO_NODE;
@@ -88,15 +86,21 @@ static long change_pte_range(struct mmu_gather *tlb,
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 
+	/*
+	 * Can be called with only the mmap_lock for reading by
+	 * prot_numa so we must check the pmd isn't constantly
+	 * changing from under us from pmd_none to pmd_trans_huge
+	 * and/or the other way around.
+	 */
+	if (pmd_trans_unstable(pmd))
+		return 0;
+
+	/*
+	 * The pmd points to a regular pte so the pmd can't change
+	 * from under us even if the mmap_lock is only hold for
+	 * reading.
+	 */
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
-	/* Make sure pmd didn't change after acquiring ptl */
-	_pmd = pmd_read_atomic(pmd);
-	/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
-	barrier();
-	if (!pmd_same(pmd_old, _pmd)) {
-		pte_unmap_unlock(pte, ptl);
-		return -EAGAIN;
-	}
 
 	/* Get target node for single threaded private VMAs */
 	if (prot_numa && !(vma->vm_flags & VM_SHARED) &&
@@ -284,6 +288,31 @@ static long change_pte_range(struct mmu_gather *tlb,
 	return pages;
 }
 
+/*
+ * Used when setting automatic NUMA hinting protection where it is
+ * critical that a numa hinting PMD is not confused with a bad PMD.
+ */
+static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
+{
+	pmd_t pmdval = pmd_read_atomic(pmd);
+
+	/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	barrier();
+#endif
+
+	if (pmd_none(pmdval))
+		return 1;
+	if (pmd_trans_huge(pmdval))
+		return 0;
+	if (unlikely(pmd_bad(pmdval))) {
+		pmd_clear_bad(pmd);
+		return 1;
+	}
+
+	return 0;
+}
+
 /* Return true if we're uffd wr-protecting file-backed memory, or false */
 static inline bool
 uffd_wp_protect_file(struct vm_area_struct *vma, unsigned long cp_flags)
@@ -331,34 +360,22 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		long ret;
-		pmd_t _pmd;
-again:
+		long this_pages;
+
 		next = pmd_addr_end(addr, end);
-		_pmd = pmd_read_atomic(pmd);
-		/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		barrier();
-#endif
 
 		change_pmd_prepare(vma, pmd, cp_flags);
 		/*
 		 * Automatic NUMA balancing walks the tables with mmap_lock
 		 * held for read. It's possible a parallel update to occur
-		 * between pmd_trans_huge(), is_swap_pmd(), and
-		 * a pmd_none_or_clear_bad() check leading to a false positive
-		 * and clearing. Hence, it's necessary to atomically read
-		 * the PMD value for all the checks.
+		 * between pmd_trans_huge() and a pmd_none_or_clear_bad()
+		 * check leading to a false positive and clearing.
+		 * Hence, it's necessary to atomically read the PMD value
+		 * for all the checks.
 		 */
-		if (!is_swap_pmd(_pmd) && !pmd_devmap(_pmd) && !pmd_trans_huge(_pmd)) {
-			if (pmd_none(_pmd))
-				goto next;
-
-			if (pmd_bad(_pmd)) {
-				pmd_clear_bad(pmd);
-				goto next;
-			}
-		}
+		if (!is_swap_pmd(*pmd) && !pmd_devmap(*pmd) &&
+		     pmd_none_or_clear_bad_unless_trans_huge(pmd))
+			goto next;
 
 		/* invoke the mmu notifier if the pmd is populated */
 		if (!range.start) {
@@ -368,7 +385,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			mmu_notifier_invalidate_range_start(&range);
 		}
 
-		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd) || pmd_devmap(_pmd)) {
+		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
 			if ((next - addr != HPAGE_PMD_SIZE) ||
 			    uffd_wp_protect_file(vma, cp_flags)) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
@@ -383,11 +400,11 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 				 * change_huge_pmd() does not defer TLB flushes,
 				 * so no need to propagate the tlb argument.
 				 */
-				ret = change_huge_pmd(tlb, vma, pmd,
-						      addr, newprot, cp_flags);
+				int nr_ptes = change_huge_pmd(tlb, vma, pmd,
+						addr, newprot, cp_flags);
 
-				if (ret) {
-					if (ret == HPAGE_PMD_NR) {
+				if (nr_ptes) {
+					if (nr_ptes == HPAGE_PMD_NR) {
 						pages += HPAGE_PMD_NR;
 						nr_huge_updates++;
 					}
@@ -398,11 +415,9 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			}
 			/* fall through, the trans huge pmd just split */
 		}
-		ret = change_pte_range(tlb, vma, pmd, _pmd, addr, next,
-				       newprot, cp_flags);
-		if (ret < 0)
-			goto again;
-		pages += ret;
+		this_pages = change_pte_range(tlb, vma, pmd, addr, next,
+					      newprot, cp_flags);
+		pages += this_pages;
 next:
 		cond_resched();
 	} while (pmd++, addr = next, addr != end);
-- 
2.43.0


