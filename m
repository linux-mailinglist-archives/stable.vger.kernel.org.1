Return-Path: <stable+bounces-189119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43195C01512
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 15:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB99F507FAB
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 13:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5616314B90;
	Thu, 23 Oct 2025 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qhCtQU1G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DxVl6Ffx"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D102D2D8376;
	Thu, 23 Oct 2025 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225399; cv=fail; b=jEt0K5jRfBo97K75gkQjNeRjZXKcILLjtnaDAseotVOSUgOPfMVfK5ekKp0YTd16KgxQqUV9+XAmS2JxYRh3nDUmJuE5GFCryW4Oc31TjprPSjcx0EFscXdusVfI3ZyP1V0YsRfVguo4xrxNQoIKfH3GG68KS05pzDOaft/WSF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225399; c=relaxed/simple;
	bh=4QV5uQCzY21R6A59Ctz1DwTHrAqu6Cn7sIpRfDa43lI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MqEjFbFh068cBRw3Qon4Ibe7vjwq2mDk5MfTw404J/BPIlkGLSOZi0elitb6ipSjNf99v6kWLq5OEDTbfIiHg+4M7Vdhds50bTfJL9xUsNZjk7PErQTgafpnt/opm7fh2iQP77RkTAatTxdWUj6rUKiWn/inMAeWfzK5jGmtFPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qhCtQU1G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DxVl6Ffx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAtmUj016338;
	Thu, 23 Oct 2025 13:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=bsQJuwD4CadX5nGc
	1HnQQSbObqQMv4ChtZaZKXVIvLY=; b=qhCtQU1GkOFBjWz6TWZJdyCVnpelVC1X
	TkITx2LqjlbRXY+pERqy9kyEzVavBKG5Y729wIvs7uSvbr/6VoIH7GsYPV0i+VpY
	c6DHCeGmotrSdUmSiHkB6urWRQy8+OfTjNrCL3dFdnb7S/IEjB9d3cMDS6IwA8Eg
	NgX8x9zn2Aa7ds3XaptB9vqTs2qsPgNLRdzdNTgLjaClrDO24hU7ekdDuPKLTNla
	bKbKOISYcI4WN1ol8HnFEns6OcPoUk3sNSOquxebi2qkNNuBKe/KIw0ca7Xyz396
	R4IdH3iw0OHwK/KwnPD/o+LTEHaY/lRNiGDfrY4HbP0asi6y2FRxcw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2vw1qqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 13:16:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59NBlIpu035546;
	Thu, 23 Oct 2025 13:16:13 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013019.outbound.protection.outlook.com [40.107.201.19])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bfkgv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 13:16:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLjk5VHiN9eKD7kid6kjc2foV7jwFl/XJ/MveGvNnW9vu0AfwYgWR2B0OQ4FEMRleSAf7m0jbTeKLfwg7IfpMg2UDirZn4OwjvtWb5eE4/Ig3SjYTcwDMdqKEHeZPkyGumBpCgp/vXp0Hbc8/4WYPp+pFV2vMoLY4Ai5gUIa9pNNMmzF9abzDT3AIlHVA70g9ak/lUuT9hnxBeabAcYA8aXoJcmtYItOeKB5Qf1EWTX1Z3MVwUGYc44LQXoTBqtd1SyQCH0QtMkORBeVKK7ucxFpMcMsJ+p5rsuwYQGW2NTQtZ/P3U8eoO6ZDhhOnu/9Ey+L0ABkTztNEf4+LlOsCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsQJuwD4CadX5nGc1HnQQSbObqQMv4ChtZaZKXVIvLY=;
 b=fKeCt7He7qcCKQ6FhGcrZhi0qBh+Uk2fbbvFfuAGf9gt7Ba1XKXcK/qLw/jF7xF0sKvI3Vf+KfkOpIk9A9OQb+WQQta0hbuSZEzDzbfUz9ILd2ExJyEYs2GBf3dCbrfi+pe+DFR7avm9uax4ygFNugxW3jImptHsBXq3z/2iswl0fQRRNB0y7PUMLQU5iA4TwGh5yT7dubEIEx26x4s4q1alH036ZhJ3EI4TJd/w1fouaoLDzu/dvCs/ICaLZYf4D4pEV7HN6aJUpcJrsumujteUpWfmVo7Rdmizb5cWDyOr0ByFjvPosX0tk7stJ8S6d8QceyHvZwNnNCDVSVSvcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsQJuwD4CadX5nGc1HnQQSbObqQMv4ChtZaZKXVIvLY=;
 b=DxVl6Ffx+otZn5kcU1ILbJgBseSOTFASf1r/MH8nqJwWtGAokC9bTFTx2P2fnepqDsHVadAbUBtrigarVmAwJ6k682JlXPVSU/Y1yME6ngLYuVwXBCLwNoXHVZJ5wKL835zvv7HjC+aSBz+/7mZLIqbDJJaYxCCYXs0K7Htsa8w=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY8PR10MB7338.namprd10.prod.outlook.com (2603:10b6:930:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 13:16:10 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 13:16:10 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>,
        Alexander Potapenko <glider@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Feng Tang <feng.79.tang@gmail.com>, Christoph Lameter <cl@gentwo.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        stable@vger.kernel.org
Subject: [PATCH] mm/slab: ensure all metadata in slab object are word-aligned
Date: Thu, 23 Oct 2025 22:16:00 +0900
Message-ID: <20251023131600.1103431-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0096.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY8PR10MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: 849c520d-f462-4997-d595-08de12365527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dDn77kUyEIHxkowc+lLN4w0/X3fDtXIHR2164q9+sAHL0y17Ac/jkefM0brM?=
 =?us-ascii?Q?0Nal3PCrJ1XYmn+lmB5DBm9/baVxJvwYeaRP7WSIF2VpvUC2fMXK7gMRhVgS?=
 =?us-ascii?Q?Pcft0xod9pNHOHkIT0Jxa54+RHtV8uw3zX/y70P0/+plFZ0dDVJuasGOtH7O?=
 =?us-ascii?Q?erugiPDeqnNj3fRShb+t87Vj8gUxv7nnTjNRgC88gNYCOYPBJ//Ve6d3Khyp?=
 =?us-ascii?Q?oCAvH7l1Vh2Lxfgd6Te8j95tvtk2idYN+ai/wE8B5mg6iv+x2XRstjkV1WEc?=
 =?us-ascii?Q?Nh3apDAzw/pKvKLC0HW1tjNHDwZG+O1pD0fEyEcC6de4gnrNuyiJXxnriQ7r?=
 =?us-ascii?Q?ysRf8o4k4LMiAF/GnO5q851bHjT1g+1fdV0ZJouT8GnqLKq8s9r4gGDWimBu?=
 =?us-ascii?Q?c/9BCAfGRVxwyCMs6hSWfAt0qPRiF8i4tsMUrM/Ltj0XuVdMD7eH3J9woDi+?=
 =?us-ascii?Q?HyEok895PTE6W0WQMtzT5wwmSq4pVAtammzbPa7R8bzK08fk+8pWQ4M1ugX+?=
 =?us-ascii?Q?xZvQN0G3jrBOfsd1PvNza/7kKp7uCR8J7NygrCsDhflsaVQ6QLmoVux1acGC?=
 =?us-ascii?Q?+BynNfH1dy6MXF1zU4zx1Vk+XCdGGg4MEhWzwRwCm0I2iefwOjyWPrSO115O?=
 =?us-ascii?Q?q0SwsoHltKVyVBddHRl0D6+EiBLMcez/8Kzm7jAidIsPsisABIweWv3Z4Gn5?=
 =?us-ascii?Q?cS5WAGkqKU8tdNGbOK3FSr2ycJC3PkUz+WS6aW3IDKbO3qpVx4S7+1izHAtK?=
 =?us-ascii?Q?u+pK66Lfmc2dxD5rS+lar2cDKr5d75Mek+VpcXqZ+iJhqGVRdpbHcTdyBHdM?=
 =?us-ascii?Q?zSqHMDTjCFPROYJziA58hYyoZT5WTviLemCFk/W/rdPu1vD5LveUfen0rUIo?=
 =?us-ascii?Q?/hq4nAGWnlVcqkmLKkns24llTwzcpfH0fDFJ/RDQih+1CSyf9bhrH4QTSUdx?=
 =?us-ascii?Q?PActAVK6F4CtpMSckT8Is7rplCcG09AMa58AgsobXc3KsNTouyNIhbq2WONi?=
 =?us-ascii?Q?5fnFFWlidvjtQEH1V80kN+VcmBNVddKl3usVLx3+vXtLYS0xw9rR70Z9kvU2?=
 =?us-ascii?Q?SrevCKoLbzbAbnlAsYu3sKsC8YZ8Z2GDcM1DDoNiYdY8JK5M4kLqFLaUUmvl?=
 =?us-ascii?Q?QTkBYhNMuszhuIbyqPtS/5VWSdUR7yDk6HhiN5rccWZ9KMEOLiJkO0j6eUvI?=
 =?us-ascii?Q?kr0zaVenwLKKVq+uQZpI4eGUwLvTxq+526NX6rQZGNhORxra+ZcVqm5yMAj6?=
 =?us-ascii?Q?0Ou4iv6vzJaziE5Zriv1zYUVf5tKO5JymRI+3F51TG/MnFnW6T2eZRuUVMrb?=
 =?us-ascii?Q?mDRQjiu4ruWwd8i7TYqiBLvXa3yQMnEEyC545CDOSyy3SzKMZx9qflYlu4HO?=
 =?us-ascii?Q?G317LZhyqEVCdIh6+N20RP8cn2qPI76mBb8XerVnYl0HbDZs6WncVCKde272?=
 =?us-ascii?Q?FBSzW0gzMZ0/MpMyJ3HdNcdQGYkbfSzN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?etakS2lHSCox4SVGlZeCb6nY70IndMITc98CQYjKbM81+AsehGLSM3FNBCav?=
 =?us-ascii?Q?+UVWYgacM7UuNu6HCwNzpwhEGWXFDEFdPi/ksDfho3If8m9FJaGfub7RPIqD?=
 =?us-ascii?Q?VBBoLAxZDo9kPXtRaSxKsvSr/HWeiaQpkWydYdry4M0fIYPwrhxGRYEUFzsd?=
 =?us-ascii?Q?DEo5E3bcNz3LZMEo5J/Xi5cXrqvBB5PnANPU4D9HMwElmkMScNjFTP2z/Z3J?=
 =?us-ascii?Q?hpjU5u386x9v8TrCQEpzf6VFV5aNBIKlYsc7evA9bs8HGOgJqg3ZqCY9v94u?=
 =?us-ascii?Q?7GGFJZFDmkLa2omK1NEUUOvCG4nnYIRcfFbx12GcOdfq1QB3lxDpq4Gg1Sj5?=
 =?us-ascii?Q?Qzdh8C17JXduyOHz78vA59uPNFksvkZM2zBSnw8oy2efW8yhrKx0zruwdSdU?=
 =?us-ascii?Q?rhPeSRUEVWlA6c1yqxNPiSFSOYO2NYckjqXoVJ7o6xTAL4gKgfu7PvoShNVC?=
 =?us-ascii?Q?4MWm2z2d0TwseHLw152Y+AcjLs3YNHBLJdcph14cA/sFX8WdYkldAX5BON7K?=
 =?us-ascii?Q?/fLG9EFhKL9LofhpULAKhpkQLrCD3pP42+KpeJ6gphE/+V0D1XZXNGOGGKaT?=
 =?us-ascii?Q?/rk8gb3eh6fqNlqBg3VW4xndMh1gwNyQGE3KZ+NKicb0NQHOv4Q9dhifWsm9?=
 =?us-ascii?Q?r9Ii/D1wQMfuV74I3LUSOW8Y/kpjeSIrwbHHtpBk0OueFO9/qd5f7QNBXRpo?=
 =?us-ascii?Q?a4k2jaDHnGrpouJp+uVe76Ys/IObeRiYLL0cO5ak+SCtA3AIhMgSOMN2LUNs?=
 =?us-ascii?Q?MsgQxIvEkrd9OV9aYapCrt0Bk4c2NdLzek/zqZS7c0Bu9JT1pXMA0wDtkE4N?=
 =?us-ascii?Q?yJqbh5U45iGTJjKKwqj62BQYw4o5H69jfRkKkoNi40fx/UDNwteVJD90fL25?=
 =?us-ascii?Q?HIhRxgee379nxeD0MqHyu6AKQ55a4i+gVQrWXcJGvLhHr5+bqld+d2F6nPRg?=
 =?us-ascii?Q?yeuerXNSZP1riDLNa4ESscEoPrIpdkcPGtAomyCnPBu4q85ZBBFaMLVzpuNV?=
 =?us-ascii?Q?sq1sLUoxqVyfCAzlu7kpvq5+qJIE0ZYXVT/Fh8e4VOUc/D5rt2uDfDFnc2j6?=
 =?us-ascii?Q?BtyESDKZYoPicmA7qGXXMqUvbXvxV3QHamNf970dx7fYzMvSapb0rgbmhyYO?=
 =?us-ascii?Q?++KRmwnfTiJnzShpi1e5twqUH6ZysGFeULAxhJv8ABl2R2xCknisaXA2Rn3E?=
 =?us-ascii?Q?PUkP7GGRpzkFmq0OXHuBO6m+1m43qdhNkxhvhIZSI/XBoAPSpzHKBdoyj3Vp?=
 =?us-ascii?Q?xAwizrMEIi9Lltf6KDAN4Do581wg2W1IkAT0WaJXhHQxlu5WcW23eLLnZTcx?=
 =?us-ascii?Q?f8v05hpfWhtmKCOF1awX2YxEtxx7rzoFXtc0/PZy0iCMHZhUw0iRuQl/hcJs?=
 =?us-ascii?Q?g2FUBZuKuMAxsv1DDlQtJj+EyEETsdoO49nVuaY2yfI6JrK2Uc7/ZeNlCKNt?=
 =?us-ascii?Q?7s8OhGPX2zAzry2q9iTy6MkXdpP5KiKr7rc9DDYEyYseYSY63lnZBOf8xRew?=
 =?us-ascii?Q?bbVtbtZV33G7l+fm6JGGQ7dPbWdRSc2QlIRiqW7jgfiby851qILXqjjVldyX?=
 =?us-ascii?Q?5rt+bGzivcCbcqkd1Ur1WjKMxd/INJu9glnSAGD4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A5qSIMgJj4BhO16dP1J8VzfmqJmXOEIt1lC7ywpWt+D3hpYn2rfVC4F1TwDuhqnzYlrVE1m8hrjE7rND3k39WUouBg2/qwBffdigk4kxeGShkBnzMIDZWIx6I2b0BoTtdh3ijujKJjiB68PwAtfd5w5HSSCzqM+wmBK7PUEOewuqsYpOAon4/ahQu8m2OLt1S4EaQkpIRviCNDYKXtb5G+7BVb6uTyD2+Gi+Xfs9sHWJ6CIKBVtOh7nn9mK6/LvH7QWSbU/7rXNy2d8eGp88PkbjS3jP4xsKMUnQ/RZKljA9C5qrpZYNqOWB/Z/CFWDhB4ULLrE7BiPzXgi27a39QouZsDEdIFUoV0DnfyhIP+C77yiLctGfxJqcu85+3geoanwap4ipznyD5+Obb5YtqR1yLRat02u0eyB69NVh277/a48cMxPVYmX8iH7FY06pQRwcpPFGRC8EqarCdN6yS2kM/vl3pboR4FOGeQqPGXu1B8RdfPWqH6uH4hfCkGc5HFysPvgYZRxGc+Ujj5hJzHLQFEOV2Ao61GywXfSC2L1BBcvLI/C1m94LlyqEff/FRMVkpwwv7Zd19X2kjQclq9dLq/QqIiNx0a8FDNzOil0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849c520d-f462-4997-d595-08de12365527
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 13:16:10.2882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWWWKNQBXexuf9ohPUnsaSSgmPbF1vusWEmKrvWubEdueQq4zcyKJ/w82JrgbD0etxyPFJ4jVrCIDn5SdcsJ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510230121
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX/AkoSYxgUNXQ
 xwAF24cGB9axR9QtrIkC10sy+//+6z0AUPP9YXGbM6CSBFRrwRuqPQoDmM7sd6qHETNMgvWC0+6
 BixbWU26yv9Elo60rcy+P8IgcFmW/l34BKP5VQFLWS+63EAVJ7CX7ffA/ec7Kq2z8c0VS1sUYES
 ME3svANmR5VHaq/I8XdJF11qt7tL3CRysmOhTIveHhEA3jd6HT6+yVS2r8cj+A4mmtqnG2PvZJZ
 /eHt7iotuUPCDvfl66tVPlAlh2mwrtMSS8MiLIpoCbzagTPXgFsR5nd6lhsXPdQO/DR4tZKjl/1
 KQIU0HmztkVGEzfWQvUouqEmLm4VAoMZ/qQRUje4H7I0bNQo5BZVqPmAvCXrUsMgJ9jsEVkkBNR
 oOxGiBKAzLxpoWcOnKXJ8Fv7Q49yZ9L6doF2GNwf1FAThRdKnk8=
X-Proofpoint-ORIG-GUID: EgyMXjmvwlQscQ3okzYNcY25jZPjN2P0
X-Proofpoint-GUID: EgyMXjmvwlQscQ3okzYNcY25jZPjN2P0
X-Authority-Analysis: v=2.4 cv=FuwIPmrq c=1 sm=1 tr=0 ts=68fa2a9e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=60bAUpEqyJ0hnt3RZ0MA:9 cc=ntf awl=host:12091

When the SLAB_STORE_USER debug flag is used, any metadata placed after
the original kmalloc request size (orig_size) is not properly aligned
on 64-bit architectures because its type is unsigned int. When both KASAN
and SLAB_STORE_USER are enabled, kasan_alloc_meta is misaligned.

Because not all architectures support unaligned memory accesses,
ensure that all metadata (track, orig_size, kasan_{alloc,free}_meta)
in a slab object are word-aligned. struct track, kasan_{alloc,free}_meta
are aligned by adding __aligned(sizeof(unsigned long)).

For orig_size, use ALIGN(sizeof(unsigned int), sizeof(unsigned long)) to
make clear that its size remains unsigned int but it must be aligned to
a word boundary. On 64-bit architectures, this reserves 8 bytes for
orig_size, which is acceptable since kmalloc's original request size
tracking is intended for debugging rather than production use.

Cc: <stable@vger.kernel.org>
Fixes: 6edf2576a6cc ("mm/slub: enable debugging memory wasting of kmalloc")
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/kasan/kasan.h |  4 ++--
 mm/slub.c        | 16 +++++++++++-----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 129178be5e64..d4ea7ecc20c3 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -265,7 +265,7 @@ struct kasan_alloc_meta {
 	struct kasan_track alloc_track;
 	/* Free track is stored in kasan_free_meta. */
 	depot_stack_handle_t aux_stack[2];
-};
+} __aligned(sizeof(unsigned long));
 
 struct qlist_node {
 	struct qlist_node *next;
@@ -289,7 +289,7 @@ struct qlist_node {
 struct kasan_free_meta {
 	struct qlist_node quarantine_link;
 	struct kasan_track free_track;
-};
+} __aligned(sizeof(unsigned long));
 
 #endif /* CONFIG_KASAN_GENERIC */
 
diff --git a/mm/slub.c b/mm/slub.c
index a585d0ac45d4..b921f91723c2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -344,7 +344,7 @@ struct track {
 	int cpu;		/* Was running on cpu */
 	int pid;		/* Pid context */
 	unsigned long when;	/* When did the operation occur */
-};
+} __aligned(sizeof(unsigned long));
 
 enum track_item { TRACK_ALLOC, TRACK_FREE };
 
@@ -1196,7 +1196,7 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 		off += 2 * sizeof(struct track);
 
 	if (slub_debug_orig_size(s))
-		off += sizeof(unsigned int);
+		off += ALIGN(sizeof(unsigned int), sizeof(unsigned long));
 
 	off += kasan_metadata_size(s, false);
 
@@ -1392,7 +1392,8 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 		off += 2 * sizeof(struct track);
 
 		if (s->flags & SLAB_KMALLOC)
-			off += sizeof(unsigned int);
+			off += ALIGN(sizeof(unsigned int),
+				     sizeof(unsigned long));
 	}
 
 	off += kasan_metadata_size(s, false);
@@ -7820,9 +7821,14 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 		 */
 		size += 2 * sizeof(struct track);
 
-		/* Save the original kmalloc request size */
+		/*
+		 * Save the original kmalloc request size.
+		 * Although the request size is an unsigned int,
+		 * make sure that is aligned to word boundary.
+		 */
 		if (flags & SLAB_KMALLOC)
-			size += sizeof(unsigned int);
+			size += ALIGN(sizeof(unsigned int),
+				      sizeof(unsigned long));
 	}
 #endif
 
-- 
2.43.0


