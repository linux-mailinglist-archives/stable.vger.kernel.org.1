Return-Path: <stable+bounces-198068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3326C9B0DD
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 11:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8043A4E52
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 10:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C88728B407;
	Tue,  2 Dec 2025 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pz7gfWYJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NAKD7xcz"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72B11E9B3D;
	Tue,  2 Dec 2025 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764670642; cv=fail; b=cfatjMzPGSPiESxmqAkTI2fBIBKJOAYadl41Pzioy73IsxLTWA3bf4+kRGXoeqo7Hm9tP37fJFJ0bY5f9k992cE9UwKCqkk2NZ1I2qedlwerp8xyP4yOD7zAtgHLGr00g5645hYsi+3uOYumlcoSI2vl2KA63kL6k+whm33lfMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764670642; c=relaxed/simple;
	bh=sWOjZ/x3CZ12hO/amRAVmPskf4OzFGrevT61tkgPzcA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=f0uiiFdOKBJwADqw7Dgm8LBOkuuBfOsFHy7B0/dTFl5i3Hd9LagR4UNKRkvU72UiK6SqPa8h3wiTNPUChqdN1SQAc8hfP6Y7DU/Hrf1mmkFMISx0ALkH0ObcNrFTmWVjQ4L+W8A2KDQScUlPBtN9kzO4IA5jtryCvoRfhfzMwNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pz7gfWYJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NAKD7xcz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B21NFpU3432449;
	Tue, 2 Dec 2025 10:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=JWG9gip7ejsOLFXf
	jpczsbXDu9ZXfXCY8sPnd69Nbjk=; b=pz7gfWYJS1MobplpIac58vAfJIhuwzYt
	kyW7lbKjtsNQbsgEGiaLi6VkLzYjj3k2UbFovN2m8o+s0OvBQcFdVB/SyByXUBEo
	jv49ETZ20VgQK7XXuRfjISH3AU/VDrFdgeg/yTfkYsn8y8Zc8vWG+W7WRPKAn6uH
	L3s5YVxJ6JecFqSJrnQ3b/mMYPU4URwmM8VBP0FKJlcmUn5Df0VYUNkhNcJjw49H
	72s1hn9LRXd+mEx+DDwZgaeOeO4+NhZ4JeLSvhiz4oBr1XlbAVCBgWdb2BiqUQ2v
	5BnHnasdE0PC+Vz+RPGY6WeG1nx4ZE4UkmLtyEGamvTYYoAYFAZY1g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aqrvc4rfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 10:16:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B28B6ei035370;
	Tue, 2 Dec 2025 10:16:37 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013049.outbound.protection.outlook.com [40.107.201.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9k6kc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 10:16:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3CgCZE3YJx1RN3qzmYR9/+lQAeTfC0GU/QQyutxrIDp9vSvPyUowIH6OeOeqAmOrjBBsihG3w5LwbPWW9Qd8B/Y/7D3X4sevU0zI32aOOsIXdwH+6wk1x9+y6C5qNS3DfvROOvjkIFxKHndMPJheWfBWGNkL7hf8M41/Cml1eHPxBO/AKamj712QmvQW7rQfEkMRAx0z6i8BUczcfwsj1Fx2WVG+ezHkT/zVx8Aw6xtOgkUXSvM5r5k+6v64ndXxoiCj9O70JL0qyPTXNCfzY86PaelsjJFT2gDQjV/t+Wh1Ko/vXmD7PAn6cEuNYmKUed/erGUdxC5YlHp3iWPCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWG9gip7ejsOLFXfjpczsbXDu9ZXfXCY8sPnd69Nbjk=;
 b=tQ32qmxb75aLtbS4YO3fxQ3X1IwN+94Cu403idCG9v/LC8RevAeQzKC7UlfdUKRJ3IxgzhVkPsJhp0HjVPftcVWznPYf5fYS8EodT/4XA4rpBH45CPJ3zZGSZc5jblvl8zs41yfjB+mjetCS9tFXZWFPEMb0l7jgnYIB86EZDytjX02WlDM7iOhLrDXwrGJ1kmG5DBf8D0piq+cdLtN5aHGUJbbTWp9tXqzh0WlM2AXKerX3dJIXe+0PlAJ8Vo8+WakEpIkuHJ62rLuPyuVpEHox/ET2kMBOptJQ6Ikenm/w4I0KC3kcEpmzTUUwUfOZzc+3slqG2gZOJi/xrh4/pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWG9gip7ejsOLFXfjpczsbXDu9ZXfXCY8sPnd69Nbjk=;
 b=NAKD7xczDBQioVsGYQX/6YHew5AXbOIVbwFHZrbMies77XDc5tXIEm9tnQ+WbA957ZWtnrsQZYpXD9WYU0A6OO7jy3anrNA0h9n1x18tPRRc4o8X8u0Orxuqo9r2NrZG5Fj9ic5cams7KBNHWX8sjIK/GGfegEggrPU8bewS1ek=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY8PR10MB6468.namprd10.prod.outlook.com (2603:10b6:930:60::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 10:16:34 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 10:16:34 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: vbabka@suse.cz
Cc: surenb@google.com, Liam.Howlett@oracle.com, cl@gentwo.org,
        rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com,
        urezki@gmail.com, sidhartha.kumar@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-modules@vger.kernel.org,
        mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com,
        atomlin@atomlin.com, lucas.demarchi@intel.com,
        akpm@linux-foundation.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>
Subject: [PATCH V2] mm/slab: introduce kvfree_rcu_barrier_on_cache() for cache destruction
Date: Tue,  2 Dec 2025 19:16:26 +0900
Message-ID: <20251202101626.783736-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0063.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY8PR10MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6b90b6-d555-411f-1498-08de318bdea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ARdhVwjn0eBySOs670EDDN+XQSWxfTZtotQoVktP4XPErWLy2Ix0JaxQQpyF?=
 =?us-ascii?Q?arnnHGRWWAD3KdWuegobbXB2qjQz4Ye28uqlyRpZjBYy0WLqjf564C1rQrJU?=
 =?us-ascii?Q?Wx6aGmesUtwpZiJFv9OIShIX78q44eI0TddL64FXevSLMacvS1ZcptTjagon?=
 =?us-ascii?Q?bpKzDKmm/DWVtF+Bcvv9pii9kB2Nnwyl0rB6TOu1JbVSDrgKEzpR+ziVxezW?=
 =?us-ascii?Q?oQUbhbh6+OoTt0fQdo8BySFhJjc7ikJBsWWvl25PDJ7gSAYgkID+l6EI5enn?=
 =?us-ascii?Q?s0//Z1+u5Hz6gJD2dbuZAPw2/3uVQS2xP5FdMXivNVa1TuUYtyEpct2vdCnF?=
 =?us-ascii?Q?yHyYvfB4XvkYhtULz2jL+Efyvi3X427RZHcM/+PY0KXgBExeJ45KCvDf5pBM?=
 =?us-ascii?Q?qWMoh3gnFrdhtZcZCso+nj0RUESRG/aLJAw5mGaKv183DSizr9J5TsA9I2p3?=
 =?us-ascii?Q?HY29J1HcAo1dv+fYmBwZ81jKrV14AS2Wzi+/1dy6gJZ0N5OKjs0PQYnWrhpl?=
 =?us-ascii?Q?Rd58bkXZDcyx9ioY68vy3w5KuxKFlzDl62erj0MLS6ijl0qyTgzrYqV8CJqB?=
 =?us-ascii?Q?Z299Db1gcl5071gZHNp4N7hUnBJ/kqVBLwb1kiKhhmek2c57qn02HxqNGY+B?=
 =?us-ascii?Q?ZJPetZL7EYTo1YB4JwpSz/IscPB3hzqmCLE6S9uLjPc8fcafDvjRk4SU+Kp5?=
 =?us-ascii?Q?KGBRw8rp0X7Y+LQ0yrw3DoUTculIsCI/sDISZuaK/ErG8rEkqke0smhVPqsu?=
 =?us-ascii?Q?kzrFiqnmz+4rvtESYyG8uDVBrWZJlvecrcSSfQGjjQa05T3vhOpVPCuInVL0?=
 =?us-ascii?Q?t9CqnBKzffIRBmNmxFJzgMVh6jxcRhM+AqiEPORQMEcsT1THfq0i6k9kMRF4?=
 =?us-ascii?Q?zsd47ngk/syq5zUfTH6f5R+Z8G6UR7rwqxB9wAPdfA1U5Q8Wfq4PJ8lQ1N85?=
 =?us-ascii?Q?rGtIzVLAtdo33XSNt8kbLTXnB6gLXxftrQ5GgmyXbvftcJxhFRk1EKb3csCS?=
 =?us-ascii?Q?ofRvtULBjCgrGbT5rMviH6Ucv2PhbVCcHqILfS6VpY+7Pk/gNGGcdC80a5VA?=
 =?us-ascii?Q?eoi4L4PljAvDVdHJl2FFaJqC6sQyTcRyWAXlcZKs6pQy1vBqitmgQjZm/sj7?=
 =?us-ascii?Q?ND84UZ3RZRRDHmd1IS2cULEL/veHmRMpyne0HDx0iT75BI4tSZZWYTZbF/iE?=
 =?us-ascii?Q?T3ABP+4yeeVSnTDVHKh/Ga6KatqzWBnN74DCTRQrPxFBnqRhjt0JLkrZk0YW?=
 =?us-ascii?Q?v0T/rGv1Ngg8f1W6HOi/4gDFG8jhawFxI/t2SaMZzgON45egtM/fehEOW40N?=
 =?us-ascii?Q?mVZWeiGvl6lf2xrxetFHevNXjQ1424K06KByNZxp+Kzx3vxxBOAxGGjv1APS?=
 =?us-ascii?Q?CatzNLkiumw5qugE8xxn+3mPVNJAmUFk4KMqBq3SPrYyCRVuxidQp1ZaotMe?=
 =?us-ascii?Q?L+YeZRzgygalglA8u/t6cUerBrGIp2wScbAGmV/x+mS65H4DMwTidA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CE84uv5+8iOauaNuYAFUWg+nu0H0U/N40kvv+UqxTOFzmMgoBAJEVGgngflW?=
 =?us-ascii?Q?was5t27d+2GIN6e7zib3I7IehHvH+o0rA9dBhjOMmBqCq0YM5fiWIej3vMWT?=
 =?us-ascii?Q?UIT/YMd50lAtez+dyo12y2GtL4zoECVDGAy4ARvOOhmlPL3npohEtpzlGxaE?=
 =?us-ascii?Q?DD73a+TvwoW347Of6bVbzJFc+GYumFS6jPDeovFGuJklSxHvbRmRFU3LgFgG?=
 =?us-ascii?Q?KSVB5HzL6Tinif3ClXWo10la/HXTF2QF8/XDsxtoHNs/LCBczB7fnxzr7IFV?=
 =?us-ascii?Q?p5ChTVxy/wRQV/3J1zmtTCGZOY/ocrKW8/EiaFoHJAKBcG07IVR2v6ncfWAM?=
 =?us-ascii?Q?GjHX1jCdl+stUEVWf+3B0xpePadesZI6JaIr12bXx+y/WLVCk5g5SZDmtMam?=
 =?us-ascii?Q?HHE98snkWNZPlIWYy1cLxzweYrsiYLxLRc/Me18TlKsREd5HnVY/R4mZZGvT?=
 =?us-ascii?Q?D/utisWsUvioiAEAdBF1QnYX2N8p1ZvGPdGUsIFD9TUJstwhIcsXQYBL5SsW?=
 =?us-ascii?Q?pKo+95bAEIIdY35a40/7x3tn+oJxak2yGCTZ19q9Q8Zy14xjtrNMzADuBNI4?=
 =?us-ascii?Q?/91xjagQ0fRZb+t7vL9bNXmFLKk/156SlEYESiayFZfb5biQtKtCvTy3AcCS?=
 =?us-ascii?Q?/0PUw4+81GnnoexVX2P7vD17SXDI05UzpZyqD+HQxs5vMpBcOXMmMRMozUZI?=
 =?us-ascii?Q?r+ePJ8n7/T0LZlZT0VX8YnDJL5eggDoOqxRuH2YsR3l4JuG7bF2nr3t59ZnN?=
 =?us-ascii?Q?DKAJEmvwckJNcNml5RyEv0esbk+TQOGJCTdUxzZ/PIj1Z7Vfi+0SSaznyukE?=
 =?us-ascii?Q?DHtuT4vi4wX4uko0f19SkXcfJO1SZRM4Hz7WcJ5B1TbT1ms1vICKJwhOHmuJ?=
 =?us-ascii?Q?ayjY1rfB4TLS9T5JLaQnU7QDgoeQ3Gvjf/BIf+mt9mAN8gwAHJCouqr3oHv2?=
 =?us-ascii?Q?n0Iv81wS+Pk8sJbxXmTFPNXwnU1Y5oql1YzBERuAFyLLao8umsaJUMB9zXLf?=
 =?us-ascii?Q?7cSW3HrbBPKMKGk2vWo5p4k3/kQ/OQBGZwDVskp6BkwXjCv9jbVQ8sKAvvtY?=
 =?us-ascii?Q?4GfJkiNi2JoGOVUhHu++M4kbdqUgB0UJ2Rodk5L4APJbithRPB8KK8GWzvHH?=
 =?us-ascii?Q?0khXgPDN+y0JVipTAOM/XXSyeKaGV5ektFf5T8LxmM2KFXTGiV3UhNIzXrJc?=
 =?us-ascii?Q?v58AyDrjSB9SgQvqmXgsjIj0Ho5vpV6VPT0ZXlcWAFX4rxxrc3k40DGqDZID?=
 =?us-ascii?Q?VJiVSK5IQUGLaEcWc5yj+SAUqr/Ch3zPmux3oOYbyVw/+lXBtfThma5eljeN?=
 =?us-ascii?Q?74lmLFwIV5je6ozWMvAGU9r1v0KW8li5sQf4rKBOebHShck6bP+u61FZu/W3?=
 =?us-ascii?Q?iIqmFC07EFe+fD0TS0FOIUCApFntU9LW89T/MoVYfHGG5zeJ3Mqym6LQdNdv?=
 =?us-ascii?Q?XvpgMLj4xng9tM+QrZ6Me+Af82TCDjL0gVUZ5RaynGFDePvVDVsHxDr2hLpx?=
 =?us-ascii?Q?bpJzAyRkTaAsK2WNks6rS4hmV0zI9Q8ekpo/GWl455xdhFK0P99rm+XvRY7E?=
 =?us-ascii?Q?ob46b9pIGCMbLOswVidqObOYNoyUDIUq+GXnyID5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lAxo2blHHeAsoHUxYEcaSXTZoiF2TUAU45UJnUaujYxJ+sWnio8vB72qq17b840osqVl3fM7By6/cQhMrIO/omoSR7xkyi/u8p8LYCxwVUBEb14BHejpFqmRWenFieAWF36BA5RRiu7DPLzIMguNSL/6U42wIyeBSY0j5SBJm4ARuppmB2oo74bWL0LkgXQDldHw4MnuGUS+HJ/FUYZ/nQT1yOV7vrIAY06Ln90tyH2CXrFfgowL9kKSbLzomgnV72UFHd/Xbr1sOduxPwTjn133ZkPwcEWgPwSvaw6bPTnr1hLIlFgty0m6HoILrDP45QPkoZQLVFsHU99Yz1p0YAl7OMiglBn3JaPectKxdqY9Ay1YQmJJ/xbqE1kvnWw4f5MsXSNNP+bMt+HVSqumLvoJkwRYxwpuyNSg0uZ3VwtNnRkJo49HHHF2JYVVI1O32v4iXB5f7zyqV/nHVhBk1KikGhakiho8EGJJiR7NvaVEZSVvUs7VjDEHgrgEX586DTDaIfkVVxag5BSXURjGrF9XSeVbaFu72Ii6Qi6TFKpRnWJC3Laz8XFEpLczXVU/cXEI6X4o+IjE4/m3v4fj8aCXTQU6CpbpEbzGK287ZMI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6b90b6-d555-411f-1498-08de318bdea2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 10:16:33.9945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96AwAhwmuUqz5HEGppRgrSTvt2nHonCSIWX84NovmMzVsQkyEPHORBCkTqChHETbjpT/wMdmF4OdaFkbENNeCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6468
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512020082
X-Authority-Analysis: v=2.4 cv=ZeYQ98VA c=1 sm=1 tr=0 ts=692ebc85 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=hD80L64hAAAA:8 a=yPCof4ZbAAAA:8 a=yO4LRhKTJlilM3sNaQcA:9 cc=ntf
 awl=host:13642
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDA4MiBTYWx0ZWRfX7g3vP1GJx7m1
 o4hI30UF+n78tKT/Pz0T2Xir9lMqUOKPaR+jugqpgW4O47fNcn9U44OPe/TcNW2BA7m3ptA7dHr
 qhzhcx5hZrRLU2LdAGncYDapFtzXptUYD7qW8nBu5PX3sEd7rG9gbXRuAxAPzpqjPrhfE6HAlC/
 PmU418YvO556RK9J42/3Q2HrHivdbxGg7b4AI/ncsNACLZRJQtf45TUSLNlQ5sOaH/8bvBlYtXT
 BB9Yk0NNqCbq7WSIFzyIYENmXENLsAGommosHA9raKogTCbvc2xbzsUh5WEP2RRvXG9tqYrW/T2
 h1y3OcfzZd9fgAKd77hXLhYFPMICoEU1ETfhcOg1ud2251ppeKCOxyfo29JydJ+X9F3htmnsPAv
 Q8v11XKrlwCyuSVrKm9pdtFmo+rf3gjV/vxakpIxCdquV9OpSTk=
X-Proofpoint-ORIG-GUID: uLaC3CE4JNXYlTrxfwp3Vi8YxrQHOJdH
X-Proofpoint-GUID: uLaC3CE4JNXYlTrxfwp3Vi8YxrQHOJdH

Currently, kvfree_rcu_barrier() flushes RCU sheaves across all slab
caches when a cache is destroyed. This is unnecessary; only the RCU
sheaves belonging to the cache being destroyed need to be flushed.

As suggested by Vlastimil Babka, introduce a weaker form of
kvfree_rcu_barrier() that operates on a specific slab cache.

Factor out flush_rcu_sheaves_on_cache() from flush_all_rcu_sheaves() and
call it from flush_all_rcu_sheaves() and kvfree_rcu_barrier_on_cache().

Call kvfree_rcu_barrier_on_cache() instead of kvfree_rcu_barrier() on
cache destruction.

The performance benefit is evaluated on a 12 core 24 threads AMD Ryzen
5900X machine (1 socket), by loading slub_kunit module.

Before:
  Total calls: 19
  Average latency (us): 18127
  Total time (us): 344414

After:
  Total calls: 19
  Average latency (us): 10066
  Total time (us): 191264

Two performance regression have been reported:
  - stress module loader test's runtime increases by 50-60% (Daniel)
  - internal graphics test's runtime on Tegra23 increases by 35% (Jon)

They are fixed by this change.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Fixes: ec66e0d59952 ("slab: add sheaf support for batching kfree_rcu() operations")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/linux-mm/1bda09da-93be-4737-aef0-d47f8c5c9301@suse.cz
Reported-and-tested-by: Daniel Gomez <da.gomez@samsung.com>
Closes: https://lore.kernel.org/linux-mm/0406562e-2066-4cf8-9902-b2b0616dd742@kernel.org
Reported-and-tested-by: Jon Hunter <jonathanh@nvidia.com>
Closes: https://lore.kernel.org/linux-mm/e988eff6-1287-425e-a06c-805af5bbf262@nvidia.com
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---

No code change, added proper tags and updated changelog.

 include/linux/slab.h |  5 ++++
 mm/slab.h            |  1 +
 mm/slab_common.c     | 52 +++++++++++++++++++++++++++++------------
 mm/slub.c            | 55 ++++++++++++++++++++++++--------------------
 4 files changed, 73 insertions(+), 40 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index cf443f064a66..937c93d44e8c 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -1149,6 +1149,10 @@ static inline void kvfree_rcu_barrier(void)
 {
 	rcu_barrier();
 }
+static inline void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
+{
+	rcu_barrier();
+}
 
 static inline void kfree_rcu_scheduler_running(void) { }
 #else
@@ -1156,6 +1160,7 @@ void kvfree_rcu_barrier(void);
 
 void kfree_rcu_scheduler_running(void);
 #endif
+void kvfree_rcu_barrier_on_cache(struct kmem_cache *s);
 
 /**
  * kmalloc_size_roundup - Report allocation bucket size for the given size
diff --git a/mm/slab.h b/mm/slab.h
index f730e012553c..e767aa7e91b0 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -422,6 +422,7 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
 
 bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
 void flush_all_rcu_sheaves(void);
+void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
 
 #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 84dfff4f7b1f..dd8a49d6f9cc 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -492,7 +492,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
 		return;
 
 	/* in-flight kfree_rcu()'s may include objects from our cache */
-	kvfree_rcu_barrier();
+	kvfree_rcu_barrier_on_cache(s);
 
 	if (IS_ENABLED(CONFIG_SLUB_RCU_DEBUG) &&
 	    (s->flags & SLAB_TYPESAFE_BY_RCU)) {
@@ -2038,25 +2038,13 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 }
 EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
-/**
- * kvfree_rcu_barrier - Wait until all in-flight kvfree_rcu() complete.
- *
- * Note that a single argument of kvfree_rcu() call has a slow path that
- * triggers synchronize_rcu() following by freeing a pointer. It is done
- * before the return from the function. Therefore for any single-argument
- * call that will result in a kfree() to a cache that is to be destroyed
- * during module exit, it is developer's responsibility to ensure that all
- * such calls have returned before the call to kmem_cache_destroy().
- */
-void kvfree_rcu_barrier(void)
+static inline void __kvfree_rcu_barrier(void)
 {
 	struct kfree_rcu_cpu_work *krwp;
 	struct kfree_rcu_cpu *krcp;
 	bool queued;
 	int i, cpu;
 
-	flush_all_rcu_sheaves();
-
 	/*
 	 * Firstly we detach objects and queue them over an RCU-batch
 	 * for all CPUs. Finally queued works are flushed for each CPU.
@@ -2118,8 +2106,43 @@ void kvfree_rcu_barrier(void)
 		}
 	}
 }
+
+/**
+ * kvfree_rcu_barrier - Wait until all in-flight kvfree_rcu() complete.
+ *
+ * Note that a single argument of kvfree_rcu() call has a slow path that
+ * triggers synchronize_rcu() following by freeing a pointer. It is done
+ * before the return from the function. Therefore for any single-argument
+ * call that will result in a kfree() to a cache that is to be destroyed
+ * during module exit, it is developer's responsibility to ensure that all
+ * such calls have returned before the call to kmem_cache_destroy().
+ */
+void kvfree_rcu_barrier(void)
+{
+	flush_all_rcu_sheaves();
+	__kvfree_rcu_barrier();
+}
 EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
 
+/**
+ * kvfree_rcu_barrier_on_cache - Wait for in-flight kvfree_rcu() calls on a
+ *                               specific slab cache.
+ * @s: slab cache to wait for
+ *
+ * See the description of kvfree_rcu_barrier() for details.
+ */
+void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
+{
+	if (s->cpu_sheaves)
+		flush_rcu_sheaves_on_cache(s);
+	/*
+	 * TODO: Introduce a version of __kvfree_rcu_barrier() that works
+	 * on a specific slab cache.
+	 */
+	__kvfree_rcu_barrier();
+}
+EXPORT_SYMBOL_GPL(kvfree_rcu_barrier_on_cache);
+
 static unsigned long
 kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
@@ -2215,4 +2238,3 @@ void __init kvfree_rcu_init(void)
 }
 
 #endif /* CONFIG_KVFREE_RCU_BATCHED */
-
diff --git a/mm/slub.c b/mm/slub.c
index 785e25a14999..7cec2220712b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4118,42 +4118,47 @@ static void flush_rcu_sheaf(struct work_struct *w)
 
 
 /* needed for kvfree_rcu_barrier() */
-void flush_all_rcu_sheaves(void)
+void flush_rcu_sheaves_on_cache(struct kmem_cache *s)
 {
 	struct slub_flush_work *sfw;
-	struct kmem_cache *s;
 	unsigned int cpu;
 
-	cpus_read_lock();
-	mutex_lock(&slab_mutex);
+	mutex_lock(&flush_lock);
 
-	list_for_each_entry(s, &slab_caches, list) {
-		if (!s->cpu_sheaves)
-			continue;
+	for_each_online_cpu(cpu) {
+		sfw = &per_cpu(slub_flush, cpu);
 
-		mutex_lock(&flush_lock);
+		/*
+		 * we don't check if rcu_free sheaf exists - racing
+		 * __kfree_rcu_sheaf() might have just removed it.
+		 * by executing flush_rcu_sheaf() on the cpu we make
+		 * sure the __kfree_rcu_sheaf() finished its call_rcu()
+		 */
 
-		for_each_online_cpu(cpu) {
-			sfw = &per_cpu(slub_flush, cpu);
+		INIT_WORK(&sfw->work, flush_rcu_sheaf);
+		sfw->s = s;
+		queue_work_on(cpu, flushwq, &sfw->work);
+	}
 
-			/*
-			 * we don't check if rcu_free sheaf exists - racing
-			 * __kfree_rcu_sheaf() might have just removed it.
-			 * by executing flush_rcu_sheaf() on the cpu we make
-			 * sure the __kfree_rcu_sheaf() finished its call_rcu()
-			 */
+	for_each_online_cpu(cpu) {
+		sfw = &per_cpu(slub_flush, cpu);
+		flush_work(&sfw->work);
+	}
 
-			INIT_WORK(&sfw->work, flush_rcu_sheaf);
-			sfw->s = s;
-			queue_work_on(cpu, flushwq, &sfw->work);
-		}
+	mutex_unlock(&flush_lock);
+}
 
-		for_each_online_cpu(cpu) {
-			sfw = &per_cpu(slub_flush, cpu);
-			flush_work(&sfw->work);
-		}
+void flush_all_rcu_sheaves(void)
+{
+	struct kmem_cache *s;
+
+	cpus_read_lock();
+	mutex_lock(&slab_mutex);
 
-		mutex_unlock(&flush_lock);
+	list_for_each_entry(s, &slab_caches, list) {
+		if (!s->cpu_sheaves)
+			continue;
+		flush_rcu_sheaves_on_cache(s);
 	}
 
 	mutex_unlock(&slab_mutex);
-- 
2.43.0


