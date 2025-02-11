Return-Path: <stable+bounces-114934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB023A30FA8
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 16:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F26188356B
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 15:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD07B254AFE;
	Tue, 11 Feb 2025 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ixmAEc+a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ot8b7+WU"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9457E253B56
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287446; cv=fail; b=r0VsMseXRAnZoh8nmWijxjZ5qqtXmBhXdRVqSxcqEt3BYhmaICbRtok9OZPeXRrvwS460GS3g5FZERl4C0Jpv/AiYo0GwZ+DNcWTIsDQvMNjMyan60IfwFcYwK3lqgDHWOSu+bfDUTtPRbVOdYUE6rjMU7XtFaG2Wf+UuHtOyIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287446; c=relaxed/simple;
	bh=MyO3ICuy9Jteq6BH/fIh3DfX71NuzvNW4lTtcLcM7NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cgCqov6k9G6MiqlRIHAxh/rVpH1VxRINXiHeyHJ2KFyHeyZZ3mVil7QefYth5Pd0Xcpif1xCiYP7aqLlTAAfyP2ou7tfBBw1hAcINn9/Xa0ncz/QElaqkgPlOExaahHtUKSiMRoI+SulzENQ0l5StlCCRh/XZbDSDqP+hOD7E+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ixmAEc+a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ot8b7+WU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BDtbPT010323;
	Tue, 11 Feb 2025 15:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=fJ/t7KXK1idzymvV8t
	Uk7Uh0zUUS3px7A25YRtaODWQ=; b=ixmAEc+aKXv+SftNod7UTX9tdSp6iUCam/
	V+UPm6Vr53tSL2Y0IIOvnzPLQV3S9nYshDtAwDna5FNCxWAVXWsU2Uw6GOTdpAuN
	6DChHWB3FTuH/6lVcmksxP3D3aw99F8bA+VBCJ67L3btlxVlv/LbDZyynxXcSoyg
	iYkkMzl++Jfyi+NMAwbAp0EgwHiHw530+Sj7SpnNAST1Bx1xJyw2uA36EFsmyb3Q
	j8+hFlRlCk+thu4h82AMa8HuYn5q6fG4te14yDX2Y2MezW34o+zYq+bMJEB4Rwal
	oZ/ZAZqF2TQQ0Cc/gYynElmmQgvJdKmtruwJyYZGBjfD9s7ZcaZQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0sq5fun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2025 15:23:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51BEULUf026947;
	Tue, 11 Feb 2025 15:23:43 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwq8wj84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2025 15:23:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cxfcv9hCkCOop4aVvZd+kdAcVyQE+3LcBty/VvUr/eU8MTYu3GP6Y1t+G6AgCcBMdHINi5YtV/Ap2+hDsOoIVXYAkSUYn8zoWepfLMLDo+DH1Z9IhcLVZQfGZIc4mg/m0U7ge25TMicj1MaEQUMoGRrilqgRgxD5m+a4vy8E50IquMuJDBfTXhp8TK6J4nZFZx09Zi2AvQo7K4tY11MOwdlT8fChrPfFyWKB5zuMKl8dRhRCFNnnIICJJkfsbh2aQzfIHaP3h7AaRLREo1Yh2L2B80hr/1CwrjswDbpKCXOobIgU/M5flynMZr1KjCZmNlobkn6OKb5jcVA8FXlIrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJ/t7KXK1idzymvV8tUk7Uh0zUUS3px7A25YRtaODWQ=;
 b=oyXAupI5RkoFlubXNUVVwObsCSkHtJkrUXub/Zcz10lKu/vd8UFbDth22gkWjY3WjLb0868ovhOpFSaKhTOUtN1vKupKsv14mFSuTxCtTTfyoTYAejifFd6D4Yk0JRMKSn4NEkKk2dWfsMW3Y962j5rqJKbfjGi4GbR9+FpkC5a3rOJR6myAuk9GBl4CIHKnH5rZsUaS2z+APzxTtgOEbVOekBdzkg3p9T6WHwqgGt0w5rbhQzV8QJQYw0btUGnUgqqqlegqwaGEwd5n57V5f+5KI01ZogLjrxP6CoBlnUB8RdPEwH9EzB5flI3KlT2Kd81t/rO0Zq7u0CGH0C2A0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ/t7KXK1idzymvV8tUk7Uh0zUUS3px7A25YRtaODWQ=;
 b=ot8b7+WUi5byQ0XYsVnN/13fE6ycf4flNPtg13sFSZ0VW4CCuZc7cXZvR1qZ61yCF4OZbrd379xRV5NRpWpxK5JHEJS4fPZ9ImiAW1yLgFy8JjQueFG6VqnoiFTmq1CT1KErqI4fhfFNWz4V5oGZidfm28JoYA6ogMenCiKyI24=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH0PR10MB4905.namprd10.prod.outlook.com (2603:10b6:610:ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 15:23:29 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 15:23:29 +0000
Date: Tue, 11 Feb 2025 10:23:26 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] maple_tree: may miss to set node dead on destroy
Message-ID: <cczf2ivzq6aj6hhxkpzlbmvjbcl72podpyzqf22p2qwhrf3gv7@gxs5hnjcky5a>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
References: <20250208011852.31434-1-richard.weiyang@gmail.com>
 <20250208011852.31434-2-richard.weiyang@gmail.com>
 <42meyihs3gnp3bbvn5o76tzh6h2txwquqdfur5yfpfu36gapha@rtb73qgdvfag>
 <20250211074821.uw43qk5mk2shrndk@master>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211074821.uw43qk5mk2shrndk@master>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0375.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::10) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH0PR10MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: c4410be5-1954-4c53-1d2b-08dd4ab00973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yceEw0JBIiFtEZ/YhAErSMyR0SSiGkYEqQy33hmgVhSNMFA6R7XDRFsZ/+A9?=
 =?us-ascii?Q?JI/PMWsyWCUbo5g+hho65OwUUI4d5yRKBE9qlpAfhlpaoIJkb4/dmFP+PEN6?=
 =?us-ascii?Q?yInQQylLH5bBmCChZgf78q4SjeZaO9VvAUMilBLRvGtSPiVq057dpujMhOQ8?=
 =?us-ascii?Q?cs3lfDath9/j8vM5zMBYyFROWJ4/pUgu2wddTyJNZgP99wt2n+y0jcDRpqrv?=
 =?us-ascii?Q?jtMicyXP/zCwjv2BNPY+GO7A/xQA2mOn+sUaf6UvnYW6aPoqWWjbfTq5iZV/?=
 =?us-ascii?Q?MGi1c425EUdKDOvAmyg67PnVRt29+Kd6FjfDzfultUZojF3htKDvI5rTBmTw?=
 =?us-ascii?Q?ujgI1KwX8cjqvkbY/QXtcXYQTGro1RpEhKJWKI1v/d2j0z7jb8VAPkOSQn/u?=
 =?us-ascii?Q?eAiwLvYb9i9jd4i0K+WG5WApUCBkTwM8xmDh8ip8ubOEWQW2I2Ph1rAyfjsL?=
 =?us-ascii?Q?NsGnv3pb2E+TV/sTSSBvCLqf/Lylj+qp0l9Y+JfYiGtRB7JFPUNI1naoNlTl?=
 =?us-ascii?Q?nGL6ISR8YSI/Zz6Jx8inQUlb2D4aOllzUd4a9DDfTxP94usomftpqOXTOflW?=
 =?us-ascii?Q?OaPAvmQE0Tmb0GC/UKRDOuxjeOMNWv4cl0sd+auya1GQJIB/FRxDFSvra4QL?=
 =?us-ascii?Q?VtnV1S9lZHrsvvRAjQm0YJD1iJ9JfSMvLozg9Hcyocda7NOTElnQaTugHXgc?=
 =?us-ascii?Q?9nXBfinuqLgzlusDjFiHD0XDNLh/GKrzhMuhQS2ihV1GVP00qdtCvhxLPeDE?=
 =?us-ascii?Q?Cx+7fp3hWRXarHDHYkm8Ks3lBeClnDS7zLc+85qy1Hdm0HrbvS+O+ToKh6Fu?=
 =?us-ascii?Q?npqO1Yq6WNuMgP3aHx/hWfwMbgBaeyvw/s5kvdqJwrEkzFGVludgKn0QwKmh?=
 =?us-ascii?Q?pb6Wo0N8NzccX5BingLlZLHpCbTtROwQVBvzvoaLm+I7rrHJkaBzvJESRr9r?=
 =?us-ascii?Q?g225s2EkX1cdtVgCuZ2/pPJDJgGn6/RR1jy93TVJLh8QF6BX9ncew4XjWmJZ?=
 =?us-ascii?Q?ooETIRfhM2HJ+YgStUool+RHjw4hwtKMaC9nwIbGhOJyy0thSAShf0QvTTpo?=
 =?us-ascii?Q?RMv7Y+7dnmKlsUrqsH+eWGWSFqYyHB9HTtYcdQCny7zC08luGnKnQzlJmkLL?=
 =?us-ascii?Q?+oXWn7zjEUFyCwiagdIz06zYYbaUsnvrUEJWYet70LrtAyXt28swodH25LIw?=
 =?us-ascii?Q?lHv7pJUZO54u0WUaaKGhP2xzMlRHN0DWJTyh96hVaYQLhEkuJlk9O5AAOngK?=
 =?us-ascii?Q?kKSAHI3uREhnW55cI3XtnsuRwBWHy/AWibIMoXaf2jrgYl72OaHyZNLIIhev?=
 =?us-ascii?Q?GVLZyVZAdWmkhrcXZdbbxpMB7ED3tb62I7gGX6ecIXYul11Za+suoucB1m99?=
 =?us-ascii?Q?LhzoOyLt9x1XA+Zuxu2kc1WR4Tet?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YWDXSvA7DFraJaQmDG5aWSNCaC9fuNCkX/IShYG7abqd4tmjZJc3CEbz+HS8?=
 =?us-ascii?Q?GGie+/mFvQizUlhFpL5GSw7se/zLQQlcZaPfNzoc9F187bxKYa0Bg8hM5STn?=
 =?us-ascii?Q?AZvgpumv1Y0XXVqubEf2yVfiOamDzvhgzDClDZHyZS7H1TCepPpfjdgnuWbu?=
 =?us-ascii?Q?2lKhvoTy0wqpVR/Ra+JYxvyYsaz5fg3/W7E4Erqm2zdfpP1wnHryuK2aNKd/?=
 =?us-ascii?Q?wni+L028IOuuP/PqqOHQVSgy93pi7UeoYyR/jOcVTzDVKFGiubKOQYJlSkoS?=
 =?us-ascii?Q?B3jZ7uyG+oe/n98/t/L6P+1xGQKRbyGbJnhRRKYci6pCe8Spj/dYdXU87/Ld?=
 =?us-ascii?Q?V58gxgriC2Fzw+F8tx3nfPcMO3wK+jk7vt+YNzLyF+hqn+BH2wRW5W1DZtD9?=
 =?us-ascii?Q?R50/lT5cjlmvnybyoQhhxH5j+UMkxgZHtUTH68GIZQ4TxR5MyiGyIDxuYI9v?=
 =?us-ascii?Q?8jwrQ5sOwUiF4F4jhRZb8TdOx0N5UPqy7sz7r4jgsDFIH9lwL6YD79Mq97es?=
 =?us-ascii?Q?JXRmWx27ayfxEkb3TyaH8/b49d+BK8IJMlRrENyzIPJRw2mNF4fDKHGrIEOk?=
 =?us-ascii?Q?EgCYwPz7o+YDi1csJGSqW0fpArNVvTcF19uVsTxuAQHftwWFMCK8g6q7FPBP?=
 =?us-ascii?Q?oRNlXrAo8TUnqNa8in/3Qc7zTl5g2pGMRd3acKRIklAbfuRN7e23gywh22XL?=
 =?us-ascii?Q?Ndq2AJhUnQvjyatKXfVKBvgtVyCMSxU3bUtA33wbxv7x2yE8CE2Dn8/cA8CA?=
 =?us-ascii?Q?1znSbzdr7vkCx4n18bcV8e028BGKMNOXD5kl0NbUiFyWVXI1bYe6RLbIba9+?=
 =?us-ascii?Q?3suSeSgCUm1G3PbCzOxf7NSzmkjk5/+I8yr7XcMYGn8+WJgIZWgaIfxP2+bi?=
 =?us-ascii?Q?vkBmCYAsoGT9WwqMLS6KexD1NcTg1w63qzXS1gMb33zLvrgGjUlvO6UaA/ir?=
 =?us-ascii?Q?ZQTNNxJZ4nFxAwj7coaSWHqmOrL5UT86C6wwagZL6Uk2Y54CZwuKTH7fgVRM?=
 =?us-ascii?Q?0emGUO3XWau2tHiMNT1vs0099liA76hWg+1kZZpT/lKEtzwAbcHhLeu8NtSA?=
 =?us-ascii?Q?3x/kY0+srI7flgflw/cA8aPsFTguZaF/mm/mVG/2gXeadkvJY38Rmi5FXUfI?=
 =?us-ascii?Q?5DFk/H7ssXzKBFP0XLtv7jxy35mCPkn1K4sljOikT2iQm9STsOfvwlTku9Ly?=
 =?us-ascii?Q?RhoE+u7YJerKYlD4CLjM62aXvFX43cqwJ9kkCTPEXjEher9QYQZW9cphBTr4?=
 =?us-ascii?Q?ngqiXKTbufBcmvgoPQ1UnoUcwyKdjDl51ZSvQ4Rd+3MiNv1ITW2GGySm50S9?=
 =?us-ascii?Q?E625IAR144F7idFRDdioIjqViiDlG/tvVocON+oRRHCUNnaLx2UaU3NggCeQ?=
 =?us-ascii?Q?jdUwO+ctFysAHomqQBfENKg6oeQqolCwG4Rf0ipn+AHKFVL4oC3riCWcRqju?=
 =?us-ascii?Q?LoKtrujCbgNE78v7MPGpVEf4xvouKZ2pH0laM4VY9+wIphW7r6DOYeZT6KdT?=
 =?us-ascii?Q?3FsTID4e/sAdEBPIQoSHwHZPErksb98CF3nFD0ppOiJGmJZ9L8tKtunci6Q9?=
 =?us-ascii?Q?A4GY4pE+TruhLFZnQzprOGw/KUIzzutt4TARaT2E?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	trVjuCmx+M4duTojBlQeYP2YRlW/EWbWA1E4FT29RJ5izA8RHj6XgY7v7APtJDLUcvYiN7pWqo2S8xY6QXEaQgldpdZf3SpHIosef4Yb24Q/zaqNdzyfuH94hdebk5pVs8sL0kWZHc6PPsWQd93bCix/7BAiWFbLI1w+/30YvdDX1myiX37W+pqkcXD7EugHCYtfZOrsZVfq6upKQQX5u4enE7RIAfJwxrsZMjawyHeXdOrYBE8Aw5/tsagwhmSbvsd6oR+aEwcYRMfpxSNj3yVmWQi3C7fioRZCxNOlh9ch2AIE+xEmj99089nuDo8fgMwy6HiJQJvhl2+OFrbMtaf6UgrM6kqikW0G7qTBqFZK+Dgz8LN8LYcKgfwoedW2sOYScJyL86peMsZ48kF4luoY8A0SNO5JclDCOncabez47K/RRbowgOCG0mj9JjC8TI4u1hEyMwM9TwBFjGSN1S7XxN1gvqXfzFChYiw0rA3Wx8TMmHQlr8ujZDab5IIQqiFel5xFl4gt5tSJpWMuMSPUFA3stDE0ikC68PGF+PLO4DXKwHSxW/HyAAMKCbOaMzLDqdLvGaijaeXmgTor9wQLzkwg3G/gzGhsp/kWfDM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4410be5-1954-4c53-1d2b-08dd4ab00973
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:23:29.1673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFrHcG0xTNTBuNqDv6fHdT4UtHSou8NTKPPqLnhZOoBjNkm+0bD5ju9P15q166yVRowuRfhAg2rl1vIGn4Nodw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_06,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502110103
X-Proofpoint-ORIG-GUID: s00HIvcdHj-8DLqYEEj6WxX-sNquzEs4
X-Proofpoint-GUID: s00HIvcdHj-8DLqYEEj6WxX-sNquzEs4

* Wei Yang <richard.weiyang@gmail.com> [250211 02:49]:
> On Mon, Feb 10, 2025 at 09:19:46AM -0500, Liam R. Howlett wrote:
> >* Wei Yang <richard.weiyang@gmail.com> [250207 20:26]:
> >> On destroy, we should set each node dead. But current code miss this
> >> when the maple tree has only the root node.
> >> 
> >> The reason is mt_destroy_walk() leverage mte_destroy_descend() to set
> >> node dead, but this is skipped since the only root node is a leaf.
> >> 
> >> This patch fixes this by setting the root dead before mt_destroy_walk().
> >> 
> >> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >> CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
> >> Cc: <stable@vger.kernel.org>
> >> ---
> >>  lib/maple_tree.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >> 
> >> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> >> index 198c14dd3377..d31f0a2858f7 100644
> >> --- a/lib/maple_tree.c
> >> +++ b/lib/maple_tree.c
> >> @@ -5347,6 +5347,8 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
> >>  {
> >>  	struct maple_node *node = mte_to_node(enode);
> >>  
> >> +	mte_set_node_dead(enode);
> >> +
> >
> >This belongs in mt_destroy_walk().
> 
> You prefer a change like this?

Yes.

> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index e64ffa5b9970..79f8632c61a3 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5288,6 +5288,7 @@ static void mt_destroy_walk(struct maple_enode *enode, struct maple_tree *mt,
>  	struct maple_enode *start;
>  
>  	if (mte_is_leaf(enode)) {
> +		mte_set_node_dead(enode);
>  		node->type = mte_node_type(enode);
>  		goto free_leaf;
>  	}
> >
> >>  	if (mt_in_rcu(mt)) {
> >>  		mt_destroy_walk(enode, mt, false);
> >>  		call_rcu(&node->rcu, mt_free_walk);
> >> -- 
> >> 2.34.1
> >> 
> 
> -- 
> Wei Yang
> Help you, Help me

