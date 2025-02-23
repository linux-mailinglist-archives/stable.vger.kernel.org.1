Return-Path: <stable+bounces-118685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC00A40DD0
	for <lists+stable@lfdr.de>; Sun, 23 Feb 2025 10:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE5C3B3F7D
	for <lists+stable@lfdr.de>; Sun, 23 Feb 2025 09:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F17B200100;
	Sun, 23 Feb 2025 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WXUc9DfQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TX+N5mbn"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674452045BC;
	Sun, 23 Feb 2025 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304470; cv=fail; b=SUodCnvwJChgXT26ulrXTunRdagphEletViML7htEoI1opBLNX9BEpINa0FUtgHHWULRlfUlFnUIo1EQc9DjOrwHIfaVTqpsicldUSWgpX6TtHa3TXA54Wbrzyqj81n/YRiWxIo2spR2/Dxz8Pj7uYkVKxUEPT6IQb5Tgt4ZuWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304470; c=relaxed/simple;
	bh=yzxSjeaSiAcnEXuu6LJ824fyFq5oWoLjAs8sJ60LUYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lPWHuAp0POjXv+4p9MaKTliMJ1/cJrrU1YEb7fpuL71h936J/5QpNBF490mrxK/BRWHYMITibhMV1Jc6b/ARGh+3VwmgS4yZg04B/sgHWxCDCliiGQElhUJTmCCKB++d/k5Lk4b89vtmvVfJOGxiuYTM0hPWg6FPZx1fmHsVGL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WXUc9DfQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TX+N5mbn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N9lJIU006186;
	Sun, 23 Feb 2025 09:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=kYpHwgxQ/YUvAV1RX3
	yy0K+Fn8iWI06KNV5CB4RzO8s=; b=WXUc9DfQ2okvwRYBGuAKOiR5eELAX0cQf6
	wNRs9Y2rZ/YCZ/dDj4fi5H7FrS3uEDFHcJTVTJ7OsuE2Y8GeZm+YdRN5AySrzbf7
	KFRj337rSAr4h6UcbsWIrQWGRQA6S7ajXyeJYQayuAXqNftYuKc7h2zgrHXJA8lR
	Ni8qBkqXC11hiLKA1q9vlFwOnzdY2HwxtD1H0uyAjbc+L1MurEq0ST0NxM5M+0iJ
	drJ2pbzGhQxKeZ6U36py+k8iR7721n5YngvkpyV+QM/RPzVOOZ4uSuracDEHInu9
	p2Fg120eIocYNxGA3LPequJieQj7n129b6gLnFarerx3W6O7/4fg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5c293uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 09:54:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51N7F0ra007609;
	Sun, 23 Feb 2025 09:54:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51cnb9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 09:54:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQSUFxY1rtBQtvpP2n7Zr3SA3dUR8eNdz+z4OSgD8lRahML0BeIEJeACRYR+/xvPJ8nB6zLO+P5GAZSZ0vsfmvFhdHDpgbhS99wB4R6ruR9T+9f5uSCkMSt8j/9T6bEtcMKnD/blnv94BwNU2UCtji3wzAuXUUUJVBdMv++uuXzHC7iZE5xJXSkV/dcncLvy7fpule8ic/iI4xFnBxZpu5mIFLxCQDyeayLBlb/XKuTEMSYJDAF1YHG6KqNqEsvnW03bRYZqhfHxBOgXbRauvn7bNWZMSxTEDi6LVZyHTQGKSCmo3Xm54PG1BkeOOBhOJ9HUD/QUJ+wp6yYwLB5j3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYpHwgxQ/YUvAV1RX3yy0K+Fn8iWI06KNV5CB4RzO8s=;
 b=bqt7sCStPsDIzNQ5BacYqGqPkyGyvxQBkDWtw7x53lByBfaHwiOabTbtSu3dbc+J7QMsNBQSfNEveUS7g9X6Xp+Pef6hcJ/tPR7OtZ0XoCPrnuonWtBbo9HJYKRVNoU0YC7yGGT9O9XGEihU9La9G7ozNOxyJFgEA3s7GyXq/sfcrAxf5QiWrr18hOrRkLLqbm7o7to6U8LsJk8F9iaYwjFzsZJ5MiEPBIpcaNwUSI5K6BwbtFbwrRiykJm4L2R0xAAKX8k2ytaI2aKnhVVEw8pnt2GBBYZq2aQrIdv2UTc2Cg186joXdL4hj+Io0AILSjdjUdqOuImJiC/sKP/fAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYpHwgxQ/YUvAV1RX3yy0K+Fn8iWI06KNV5CB4RzO8s=;
 b=TX+N5mbnC9kcAzg8jolytMELLhwBvs6T1l5b+z1fxr6eW5M5CnhK1BQsIg2aKd8q9p3JQ/KnASefOwjreOKTEeb0Q6FJOXaw/zEoPYxfsDgUKvgEuFF2nCSGT8I2bdAkOkSvNmNf9hyBcsgqFMq9GFzXb5HAbHyZrif+4l/VIM4=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by BLAPR10MB4961.namprd10.prod.outlook.com (2603:10b6:208:332::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Sun, 23 Feb
 2025 09:54:02 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8466.016; Sun, 23 Feb 2025
 09:54:02 +0000
Date: Sun, 23 Feb 2025 09:54:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Brad Spengler <brad.spengler@opensrcsec.com>
Subject: Re: [PATCH] mm: abort vma_modify() on merge out of memory failure
Message-ID: <6cac23fc-d8c4-4315-a0e1-ab94f41fe3fb@lucifer.local>
References: <20250222161952.41957-1-lorenzo.stoakes@oracle.com>
 <20250222172634.fecb3b5e5f74e310f4a94772@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222172634.fecb3b5e5f74e310f4a94772@linux-foundation.org>
X-ClientProxiedBy: LO2P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::13) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|BLAPR10MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: c621f9f2-c223-4637-f918-08dd53f000bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uJRn2c50SHIFPcnJzQHfNiKqMkyqhIelL7DzzeFRCEZTS8xgwPZH4uOimr+0?=
 =?us-ascii?Q?dRgSliziqF5agx3D/3TQhlrHgmi3/JLKzJguslrjKauEN9Sj5sISBzRT2ELd?=
 =?us-ascii?Q?8gDou3gI0z15DrmDFFwOZ5Nrn+2vzb7aknC2HMf0W0PuXmI8XV7JDq7/kerS?=
 =?us-ascii?Q?Oa7UXyGCFquNSEuX5yqvVGjnkmbLr7FQif/0zLugNumKV62tT+aAWU/25wRg?=
 =?us-ascii?Q?sYhfigkkwODWIJg3daWKwTt+gAmVzgSgYQJTgItreiQ8ehrxnCEb2LxqZXHt?=
 =?us-ascii?Q?QF9N24m5yDVMx8tnzIcXaJartEU3G5QG0T3uUidvr7jb2S5mkfSCA1wBdvCn?=
 =?us-ascii?Q?moXkfskmsRgx8VBUwejD42ov0466fgnmxmNKWHWlVmo1flMbkBEczvFTBMB3?=
 =?us-ascii?Q?m2nvycTmYq7gg95nJpBudmVAQcfhdxA1ouqHBR/FIYac0tkUQamE1PYDCbnQ?=
 =?us-ascii?Q?yBh5MbAMyk5rPQb+Qvb9j7WOXohSFj46GZntAUOaRakDlahlmHzR/OXeXyld?=
 =?us-ascii?Q?4G3OH2wBqB4EpEUY+4femAX/LpTFmuwMKDiO1h9d+OHYocaIOgN1lUKUHyru?=
 =?us-ascii?Q?G19nSpWwGF/1R0cGe4B5DIfHfdqOtaa9j1vEbGKKxDJlaOdicd4hHOjjNnns?=
 =?us-ascii?Q?IDMQl06vW59mmuvXhgP58QG8LEyNy8iLgZANVbN+4rUNmtNb2DWlcFXa+3dc?=
 =?us-ascii?Q?WGu49Wo614dNdgGrMai4hocGbAmCPfWjQKymevrDX6dQr0tXzbHW5FQ+bMq5?=
 =?us-ascii?Q?n2F2EuWLm3ivP6P3QCgDs4CGhK3UfSHMWGAxWXkRwMQxhomNGX7+M7a87ChZ?=
 =?us-ascii?Q?ycrDz9NIfU76AYIc9+U1Lc7ThGi5n0ttIL7x0Py5teB3tvhvBqRTCJ1hLRi1?=
 =?us-ascii?Q?TtCpzjUKvvwpkx0yroWWg7R1g0mERQEa/B31ZxdmVWtX4pFHuJXJegASeREd?=
 =?us-ascii?Q?2sCcIOtca+1n7eSRB+3ZCcErv95Y6TAL/l5oS1ngGYIIkR5oT67HUMMdEcoW?=
 =?us-ascii?Q?nZauUFmCg/CVhv851N9nE/wBvZRqoCaMP/qPlAgXDQ2yqVh7bR3DVue/flIA?=
 =?us-ascii?Q?uFhzqm7buU2S9Y+851FjGA2+dw+pTLbItXX8KdfQdB4kmGHSuYw8yV1F8Obg?=
 =?us-ascii?Q?/R8TIOJU/VrrLiL72E28uE+5hbFSymzrLe7plMPUxLdxSD6gNkxLfJDn3kHA?=
 =?us-ascii?Q?xOZgk0LQR7QpB5Xqtzsxz+3cc9uSZ6kZkqjpsE9+uRgktYZOvGWR+/ptYcAa?=
 =?us-ascii?Q?3u2h8cI4XV4Vk2Mvmyd0dU+j2TDcQV3SSb0ZiL+Ze5VNcFGvflCw65AH3vFf?=
 =?us-ascii?Q?ohFDnWr1O+XErpbQuDUyaf6gQic8tnGKtmCK0O9815BEt11dA+oBs6jWs6qp?=
 =?us-ascii?Q?JQXtH42+OduesQScDZp0FEfThadV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jg+i12p2zVQekXFMjBq99YHGsSkCznqAQ9+G/j+pSj+8hL2Hrnpu9aRXrX5o?=
 =?us-ascii?Q?oFkyphDql//nxvBqw8UsIK+vYcChYk1hbIBIprdyX5Fl89m16ANvUemNvKyA?=
 =?us-ascii?Q?RpEA78aMCq9hvXcxPWaw9nbgbXeqsc/PavdbAa7eAmMYkLDY+Ciq6cqZrMiE?=
 =?us-ascii?Q?QbfVUjnc953KQjQHmEImZejE7kpIJNNU/ETdEhRFna7IRJ/033SQF4Nd5p9s?=
 =?us-ascii?Q?pO6S2G9SSQs66NYtQdtFQRB1KddlToqISZUV6H7rgf3pc/xs0gFXNBAMdaDO?=
 =?us-ascii?Q?OlIco/ffxLImIP9VKzwTPIEz8iFhQlzCS1ekAY/tGs2OTJV2iiHTepn+kXrl?=
 =?us-ascii?Q?8MRuvXvMJV73mlLpAexaCVEIt3dNSbEfimtGy0inPqtZP1OmcOwPn7PnktE9?=
 =?us-ascii?Q?9M9b15tOMDdZYKi7oatbtCcnfFG11nQu386D3VKEbxDtNz0NHdEAN806xTj1?=
 =?us-ascii?Q?DCtliDNQoMq9lrnQ8tMm42YtMyl8DRMAeAwIHEMpKoi1svyzNhSbuN8FOX3G?=
 =?us-ascii?Q?M9nagsJK8QnyDTFM/PmWJaU08ccwFG96bk0efg8NS40hBucdJYpHSQN9U61R?=
 =?us-ascii?Q?myAhteDQTnz5y0pfLWhbkUJVg/VBNYyVwrjwUIvmg7Nj+umyinR5GJUD0kza?=
 =?us-ascii?Q?uKjV88TEeETWqNxrEvaByRku5TZ1i8/HvTmeRB1l0XSCxvY5RZTN/sPCaYh6?=
 =?us-ascii?Q?QcqQxkG5mYnhssOcDEZdvEGixsRaG5VJft1Mc5W2GZKFWDkzEqv8/38VZ37/?=
 =?us-ascii?Q?+lFJGSOxjVF9X9jJwnkhfE76mzzZ+UaB0uLU6jlnc++Fm9utr9tJyXZp1/sK?=
 =?us-ascii?Q?4Jvl/+DQleK7x9IxMiR0BsxGC1oLs9hk+zhhh+DFRxBV7SjgkwqjyTS2JT78?=
 =?us-ascii?Q?z6iqYkzdnYD2DKbHBSywOiCc/nG+jf0Ri/wqKMmjCP0bvXJLQa2jPPNOIJ0f?=
 =?us-ascii?Q?f4uewB8dne2dDdaiIWfbE5pIoVGy7n3ybJUeV3dGOXb/oBV/vM/Ymcu5nHtF?=
 =?us-ascii?Q?o7WGeiE+Zt0TjnBs1ycyb0RznIFr2TGJwkoGC5+K32VDwasV0sLjSEQ8v6bx?=
 =?us-ascii?Q?QdtxRXDZDp9i3UUsSaj+p3k94eYLW7Lk3LZAmLKFXnr/OOvJtNyK3wIoSXMb?=
 =?us-ascii?Q?9kA9A6x3+iO/iECxkA9QG2AXPlc6DpJcIrep1FQZ9h/1HBdsyt5L3/SjS/CX?=
 =?us-ascii?Q?6g3pmyUWgwmXQ36k7OSKbwIgvs2Na1+rgaOI5pumX1DD1YblsVJHRMvF72uc?=
 =?us-ascii?Q?+Mx8gL5bBNq+VpvqbAT5PkvaMxu3nf9A232QbhJ1mfK/O0nYNY56wlPcXJt5?=
 =?us-ascii?Q?c5nJJNCtywFwQee5qSMbczNrI0DSw7GRUX5JnYHmLJPmJPyXGFXGTAYvY/du?=
 =?us-ascii?Q?j/wShi5dZSt8oLqS8N6BvKhXKKoQu+vi+HSC3zSNxUExcygz7ZTOx+vUi1PB?=
 =?us-ascii?Q?VlhZKlbhOKoXtTCOWU13hfvELfuglcFcCKGuDL0IgxFPMU8+FYbra1Ybaoa7?=
 =?us-ascii?Q?07cQYDJE1EfORL7OTjNIo8wYcT+ZAvhc190ejsZMlW6iaX1AP3FvQvzyLHeM?=
 =?us-ascii?Q?/i4zNILce2lw3za6WuxTOG2cgqrtoRlL4F1Ke0ktZeKUoZ/IFOlqYn6UZ/H0?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sdPcUlv3wfDbRoAGR4IDM57BpOWLk3gMY2l/otV+VrFWGQbx5AKy6EDsTSb3P+8HqtJwtJBnAB9MPEBqV49Y2kk/+Ea9BVq6DvbOE50pGbgsMoCWDyll9ge5YU6R8G3JBvwiKuYldOEgYo2H8N6dGMsmLDXxijFsKxSUQUUOJkc1cc5ovdMUQ6Q+aat8mr2oPkqOFHQFVtL1k2vPZEm5VSaomF8CiCHRpQtL3U0YO0aurfmshsJP6XisuQsSbD8meHInsUG+g1BFTILRm18WY9soLX1Nam4hqmPqWsWcz3TySE6iRcfokGk5HohSCT/nDnLfPFJgnYSXr0TXl5GoFA0QhANgXxDokcl5x2IEVKgYMlrlP4Vwgh7fTqAjSbiD6XCkc6pvQRF26zlqTcuTDCs3YBb3TRtksEgTW1CpLV/W2XZ7GyQasV9pXPy0r6W0sLHVRWXj5b0iKf1w5iPkbGxnyy3hjHBWTrKZXXOnDSCDZNC2lu/okjfUx830h8ud4hmdPICRsYh24tHLzMQbvzU0KKEkHZeXDMD60OK/N3f7KgEuqmovbLHrxI6S7tvuCziAoEqQXVI4NHw5CvnETmNEsj/KpQe+Mip9RHJap5Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c621f9f2-c223-4637-f918-08dd53f000bb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2025 09:54:02.7214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVkq4pyLvDXaS2kV1lZ2qDo9ftlb7NLgXz47CXsBrD1M1JxKWG2flvOmUW1n8AU9ATAcyaJxloEst13mfCGZbRY8XZZOZLPhzNhmXdxAi98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4961
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=863
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502230076
X-Proofpoint-ORIG-GUID: 8GhiZnk_QB8MLNemb_5qJ-dg13-bHqkV
X-Proofpoint-GUID: 8GhiZnk_QB8MLNemb_5qJ-dg13-bHqkV

On Sat, Feb 22, 2025 at 05:26:34PM -0800, Andrew Morton wrote:
> On Sat, 22 Feb 2025 16:19:52 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > The remainder of vma_modify() relies upon the vmg state remaining pristine
> > after a merge attempt.
> >
>
> This patch is against your "mm: simplify vma merge structure and expand
> comments", presently in mm-unstable.  I tweaked things (simple) so it
> applies to mainline:

Thanks that looks correct! Apologies, I ought to have accounted for the need for
this to be hotfix/backported and instead applied against mainline.

Cheers, Lorenzo

>
>
> --- a/mm/vma.c~mm-abort-vma_modify-on-merge-out-of-memory-failure
> +++ a/mm/vma.c
> @@ -1509,24 +1509,28 @@ int do_vmi_munmap(struct vma_iterator *v
>  static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
>  {
>  	struct vm_area_struct *vma = vmg->vma;
> +	unsigned long start = vmg->start;
> +	unsigned long end = vmg->end;
>  	struct vm_area_struct *merged;
>
>  	/* First, try to merge. */
>  	merged = vma_merge_existing_range(vmg);
>  	if (merged)
>  		return merged;
> +	if (vmg_nomem(vmg))
> +		return ERR_PTR(-ENOMEM);
>
>  	/* Split any preceding portion of the VMA. */
> -	if (vma->vm_start < vmg->start) {
> -		int err = split_vma(vmg->vmi, vma, vmg->start, 1);
> +	if (vma->vm_start < start) {
> +		int err = split_vma(vmg->vmi, vma, start, 1);
>
>  		if (err)
>  			return ERR_PTR(err);
>  	}
>
>  	/* Split any trailing portion of the VMA. */
> -	if (vma->vm_end > vmg->end) {
> -		int err = split_vma(vmg->vmi, vma, vmg->end, 0);
> +	if (vma->vm_end > end) {
> +		int err = split_vma(vmg->vmi, vma, end, 0);
>
>  		if (err)
>  			return ERR_PTR(err);
> _
>

