Return-Path: <stable+bounces-113968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5AAA29BF5
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF85B3A7975
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E725215063;
	Wed,  5 Feb 2025 21:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wighlcl/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yUVD+a3B"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9CA21505D;
	Wed,  5 Feb 2025 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791639; cv=fail; b=mYRKU9WKjHAYPTsca5ZAbyd2Cv9sdxVEhWpVHMlH06paf4uzSw54FbgiYZBtPyrvBOI4TjE+mySUNO8pP7sC3+XAhoTSHAsQqiGyzTy9rq8Jfg7o/CVqA1awGUEzEfP9ioyUbFhOee/B7SmIuIqnKU1FH3T9g7NUASTGPMvJaeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791639; c=relaxed/simple;
	bh=6BV+R2P4fjPGp4xM7eJIL5levpZspfLBlQp9Py+TDig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BLRl7JdG+xJHlxniCVzEqBTyhrx31rN2B68WvIsIkhjZ8QDp9j3N44kV0HBkqe/JK4b2XVd3xltU32NY2E0h5Hvgvyp0QiP2CdVtwyPHBxHAw6nxYy//KeqM4YGeJJ1ECikG9Fr53ltZtu6j/WOp4E2n3EQOEnJaPhWg9RVsLcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wighlcl/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yUVD+a3B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GfiP9009552;
	Wed, 5 Feb 2025 21:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FZBkF9b1Lw25IXuksOylQ5BnwitQNUTr67/dt3/L7Ac=; b=
	Wighlcl/97GvphJT3DyGFIf8cT7vw36EAWE8sei9/tSz+qEJ6Bq+Ht3gPwsGqWzM
	xLuiwhIiD8jBReo5QqU0+GZuQMRua4ub7Lzm4EpIi7guyu/Gm4GeLB30ZLvGwYM9
	UQ2RVENPol3wDhlYyQPv6uxGM1v1FSLBGyo6PjUf21TeT1nLf56N66sFJpPbRY8+
	Abw7OVlLulAUuZdVSKdylF4iFGTuQoFbhUgfRpp8AderjpyZYLhtHdvv9UrlFeBf
	XwQyuSi2urVjKn8tgaB/W5SZ6ipMsCyery+MTGp2HxKifuRuCyQMA1doEtkvYCmO
	ONvStr+ZTBRYpFxhoLePOw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4ubcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515JpvrE027145;
	Wed, 5 Feb 2025 21:40:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fp5a5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRUtSRv22hYtuCEESO+eULPjSbC5vKJZ3tfhBCWCRqIMqqmCBpOnMcIWFV0l0Nv7/EdSSe+ShqN+Wl7OfKFQN/ZYcDL+k+Ze8UYeIggNJlKV2T8K0iTZA7WnzIhzRyOOo2fMEcQuSu2EycA6wcLx7+bTQTiENSBuoocjKLQeIIGnZCdMrlFZbOhwCynqS9ScJFlG4hH0uvjHPoW86TtKQ0dZThG2/elmTO9rBpJSDp9YrE8PobsbWBSFj/v22D2NZocuNjHnRKmX5UXDm5/8J4iv4Onxy67owlvBcbvel/DMBj/C5r3tJyxjgkOJ+t8iF+vYoEZAm35Zz8KHBL7q2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZBkF9b1Lw25IXuksOylQ5BnwitQNUTr67/dt3/L7Ac=;
 b=GtBHCz8X6SpbCxi7Wd/jkh5eBSn4bevEKQ7bCMZcZLxYSxLVISbOuw4GjjOiqGuHEuS/TvP9sSL8NNoh9/EN3Fk3C/9YLASyNrZr4mDVVFiju6szNf/9gsdTuNk0tqQQCRY0wKSG6zEDXq2TnGxMSu6EWQz3XN08evOMWiBXWnVnxMsUNOAwjQ/5MreT6snW1LaKebviERKvNPNxlEHFhfIJ9yLuqBNS/J/NMMupNAd4bNur6Tylgouuuxiu8gDd/5mrC23n2Xzm7YAEBEVP6kxPOPGKmrHKY+YRh2pxv9i0pE3g4YEG1ggz/LXJNc655+vX0YdqLo5H+Lw0A+RLWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZBkF9b1Lw25IXuksOylQ5BnwitQNUTr67/dt3/L7Ac=;
 b=yUVD+a3BTdP1uqsimkizRfgi2eNbvijC9vkiPAIs5hUvtWjK7J/jsHinOMe/W4IpTNAmGrL452VnbeVr8mUHASVIqEi6QFI/WWw9eh0oPC9Akaq1+ciNEdepSwCRPjjPHDSd6xqwERM5CPSrwLlYYXyUUJxeQNiUe1t3WTt4UWg=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by DM4PR10MB5942.namprd10.prod.outlook.com (2603:10b6:8:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 21:40:32 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:40:32 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 02/24] xfs: validate inumber in xfs_iget
Date: Wed,  5 Feb 2025 13:40:03 -0800
Message-Id: <20250205214025.72516-3-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::6) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|DM4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: a54d91ac-d840-47e0-48d1-08dd462db726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eZ7Y1UJrF65R8h5DO0cDjWovKvZB2wX5zZpEFAPVu72wnHf9cABBiyRDXgMl?=
 =?us-ascii?Q?IX9mc851c7wvL16trcJT+FUNZmJdFWfR0mQf9K9aSJUO1Cx8irl7g7CkvqlS?=
 =?us-ascii?Q?kZs2aqgq1o5wVJMcShk51y4aNY+wFdTV1oVWvk54JTmhMD0oWcXQLa38o2Wj?=
 =?us-ascii?Q?MdOSzJ7omUTcRv8S2EWgOpHCPdBgykRaNUV2++6IVEusRe8HBnpQw6CIBNMD?=
 =?us-ascii?Q?c+Hp2n3wsSaQr2+BJyPMLeZzbJALXUqmjAtcd1Hf/BS8KDAUAzrY2Z9cWNzI?=
 =?us-ascii?Q?+BNf5bJcFfyEKT/m3tDILTJGnbPqsR0oxAGToDpUuZQ5MdHiLyM3aHW5j+dQ?=
 =?us-ascii?Q?mszbbw92pTlUEus1lGpz1IKBJSzI1KNKbUCfOWgbpchFewJ2CI9bExOQyKpW?=
 =?us-ascii?Q?9Ec/2tbZPwJyqBGaaIrdrdghM/bFRiM1IuuvnYR+1E6JPBFdNe717+8Ua3mF?=
 =?us-ascii?Q?eJf/2/0gt7O8mHhFWectF9n3Q0FG/sBu+NRXJ9BvoUIMSiABWMJyRJw8y5m/?=
 =?us-ascii?Q?AH1cFbUv9TQhDZcLqFsaKMyT2WAYJgE/jwW1LGEi4wwG7j+Df6mfD8hRRqtb?=
 =?us-ascii?Q?I1tHOOCmyDl6X3e9fDxQdto+Hqox1C/YwQUlVUhAscXJsm8Fvs6oWO13Qm4P?=
 =?us-ascii?Q?2nqcHiKOPa86XHeQ9n9fge4Nq0p5SKt9NmvtGDQK52sDOFmdvHVtwY9id07n?=
 =?us-ascii?Q?fIvQuB/Ho81kqOB3X/bOc2+EiQsClDyi8/jSczWWTWzu7MqptWwCCemv2R6O?=
 =?us-ascii?Q?bZesXRM6ob91L7+itfKS2oP65SUMtvGVWiZERGMEWlwal91Xt50hLVCaLgxE?=
 =?us-ascii?Q?2K3HFmaG8897pecFrJ84N/7QAiwdWz0BsTJ5XK8F0qEsdVwphcgmfEgKRQNv?=
 =?us-ascii?Q?I0yQtnizELuKZbYELRkKsjsJNtkOdp+CuC9dE+XHSLzTzBfFFQKmorO5UPFw?=
 =?us-ascii?Q?/EElB16C/4ZWRZAWJGQFNq4gWFw6pT3nTDIuhe0buuRE0t4bBFL64I4ONVLS?=
 =?us-ascii?Q?VEkT4qvOKCngVOJsyZbaM5YJMOkNxHBjaroJ+7O2ZZrf9rAlxWnfh1LOwEmP?=
 =?us-ascii?Q?VU6TmHwwWbHn39Be7e2XMMyVG6BIsw5qTWbbVqkSIpWy/vnwuyV6tlhF8CIP?=
 =?us-ascii?Q?AKWf3Bnutjae9p4n3qchGzUKHAWMaQnqoLY441BAhEDoqNKwIBtDLJA9DJba?=
 =?us-ascii?Q?htAP0E8yk6UTGFkEs5RPBDTfw/wx+a86PfjAs8ITJP8oaVShkbX8DkQK1m0l?=
 =?us-ascii?Q?I6cRIwh2gMv0OKMzVW6YUUmFE7lFl2WGnO0fz8b4tymyRsM6r+/3A5WnlSbm?=
 =?us-ascii?Q?djvKRfSTldyScqf27YcFwgKONzg+F2QSoFJxdp/F3qwqCs+MLekj2ghVPDoS?=
 =?us-ascii?Q?Pmwc62f21msavaCqNfXJJLn0g/0h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kd5Y3m5Wo6ZeXHsa8OXvy6Sq/ngYL6fwwZWT/9woBoCmQ/I/7hgNXIOtk5fm?=
 =?us-ascii?Q?ufCdtjGQGfjYtTcrbx1wBrC3rvOJuL5HXKLcG2bOVSm9L3pEgf6JCNbUAWRL?=
 =?us-ascii?Q?Zz9kfC5A68eHNsmX+M8ALIgIKpa75Ln/uNeyWsgsDARz6H/FO0EdLtdNcqJb?=
 =?us-ascii?Q?DdWBnMy+V5gV8xOZ8OkGpfgiu8o790KMJcMweTp/xwjjn5uTlDxzNFEuH2+W?=
 =?us-ascii?Q?SN2iQxfiBptq809n180Wh2ZWit2vqTvhqIOECeaBnbWVLH9s0JgGLm0fCpUr?=
 =?us-ascii?Q?edlWErrhJS+do/FLBjdt6RNQKX3LBBGObxlPpLgwtwYlQgIqVvePyMFfvQp6?=
 =?us-ascii?Q?Zi/4DMYOBvF9SbK9TXHEQ+/jvAYQGE4j0vcczwOgrkIQKhVG/VlDQzBsT54s?=
 =?us-ascii?Q?ksMRDWQTLpo88UZ7TzOrE312uRxhtWePmX9aYrnm+fWo+NxPvouv58GOmy2b?=
 =?us-ascii?Q?m9GzTJhpayfgAOG180p0uBAXRQcNH9XhzVhQgLmRw3wfFw4nSZxE97tiMO5H?=
 =?us-ascii?Q?N4TAtOWh2kAOWFWKCS3bkiU8lWXwZ6kmwI64ucMHAVDjUjC2l6/6ktllEVH7?=
 =?us-ascii?Q?1nZllLWtRE/fcps6ZEl6OkJEoiLKrIi6SUaR769C7Fh4nRi3cK1LomMl95MB?=
 =?us-ascii?Q?Lq08npLdbL3aP6oOf3yqwol30iSklBfV7ygPD1kY2B0QOMQdI3CmdyqkGvPg?=
 =?us-ascii?Q?U62sOjPZvR7NH9nZXBoxPyRRx7EYOAiZfeMvV7MPp0A8U+WdiqF1PQKae7em?=
 =?us-ascii?Q?V6SV70Cjedm/ti45ARoJI/RnI7YMSogGJEa9vxhRFJpdTYF2ceez1O1JhGPA?=
 =?us-ascii?Q?InFMqq9pIdMO/E8eSuOY5KqlzZxygGMZ//yde5TfummxJdIdA+aRKok5oDod?=
 =?us-ascii?Q?Y1cbAr6seHiqyNmhTg7rbfoVvyvKqTuMKX6IL9Yd61RI+ZqiIL2H7sw6qxrH?=
 =?us-ascii?Q?vnDKce+7XxlrJzG8XTohVtbcpOqyKk/t8vUC+B2KXxdDSIYBTdcY2cBdQyXI?=
 =?us-ascii?Q?dSUpIIazH7UvcrAbsB2RwYG1A5iDJI/CNhepF7RnITt/YGXTkGJUNIv//xKp?=
 =?us-ascii?Q?hUQj228hGnXzr96A/f2+ib7TdR9tEintElqwp5Yxv7qa8aaJS6cnu+wlarMD?=
 =?us-ascii?Q?xKpOy52mO35SUmEKEO+uaSQoqYJN14vmgHe5u/cNgMvHxkBkguf34LGIBYH+?=
 =?us-ascii?Q?WgFwRfMmhuk/ED2ubTnypO7yI9GEMMeyzY1Q/LijsJCroeBdbVgKbot9Inij?=
 =?us-ascii?Q?fEqbdbYiDGsQgYdmUs0Uzab1Ty0k31TzMaXZOs+ivKvB+Le5SQR7Ete3UELQ?=
 =?us-ascii?Q?xrKH9HfUN2VgH9aOqIBZfUJplMeo5FMmNYILBftw4oou+qMOg8Xs5lHPhtDJ?=
 =?us-ascii?Q?OO7GzpTH3qVsBZ7OLE/e3NnZEPagoKGDv6HlDu0cFu6RoZbDW/Jw0tnRm0L8?=
 =?us-ascii?Q?to7aw3+Sc5zjf9w0mWwJ65fbK7CmGuAVI2FWzx3UuMJ7uuA+F18uY5glk0hi?=
 =?us-ascii?Q?3oGShX21+uJkA9B0R6Y/kDbZC3bJwUKT6n8s/YW2vwyAVH4BalzBGPon11K+?=
 =?us-ascii?Q?KykjbP+GRHg8R3UCglRc0oZzU1iCXbyqR4xmwzSfGu4KE5VBsxG7Eskvke2g?=
 =?us-ascii?Q?anhkd+NlwLKJHG21IR8j+MsYBvwSaRPbsLfNTrxqfxccqKR6VQSoNRMgWAyh?=
 =?us-ascii?Q?6hQdow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b8da2Lg02OHh327PWMFfRd6m8zz9fVMw5VVUJRnA+bNjRhBg1Gye76gacnGz+km2CCGjYgw4nq+sKMaaQnrr6eMGsnIK29BdTRrcGs1+PqfSuSVJ2FKzizvRdAaM4tkRoKb6KoGsOY5jPeObJnCgCZPvxR/713wMo3g/SO/TMbSyqi6oQLnPseUT1yfqq5Ymj9jswv1chz54cbxqTmNdz9xUkbArkYx1XaEFk7tj9AcUfHfpW8zNN81PDtE3ifU5CAZf3KV/p3SNcJWOjPVxSORDkV9LIitwZl0rr/ip0JuVRIodieepq60TRVdlbXUtQgbll1RhED11HBMwUnPGnxFemqkUJCbxflFpsEFX6HVkH+dTo1o9wGEiBjJidehbOoj4d/35fcBKU3i9wdaBlprcfH7LZy+b4zXBffMKVpBQ/HKzP0SnVpEYOi+xd8TOFJqig1x+hVDIffGYHcsTlzaFqGslLmBtMp4Ul1k92eHTTUjEtOVW+eO+ibYO9S0qmMbqXYqEk8J9nJ8P6VvYWqquKi5Eubj6jFsDr0OYvIbZ9BQdqbZCwcxWq/TvplyQoS5bZUqCGavfg60ozldZnZ12OmFf1dIPkgBrWKiH0aM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54d91ac-d840-47e0-48d1-08dd462db726
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:40:32.1488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50UC4dFu9EecZ9kVupN4XRF4/tXIheWM79NTIjYIoPRI5CpmtfkotU1ukHDqxyJ+aaVIXRb643TtBsT+t2ix2kVHK3qaQqEpLHwiqR3lyG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: ML16y2CPbVTX0PaoKsk8Ihq8K8is7tOs
X-Proofpoint-ORIG-GUID: ML16y2CPbVTX0PaoKsk8Ihq8K8is7tOs

From: "Darrick J. Wong" <djwong@kernel.org>

commit 05aba1953f4a6e2b48e13c610e8a4545ba4ef509 upstream.

Actually use the inumber validator to check the argument passed in here.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_icache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 57a9f2317525..86ce5709b8e3 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -748,7 +748,7 @@ xfs_iget(
 	ASSERT((lock_flags & (XFS_IOLOCK_EXCL | XFS_IOLOCK_SHARED)) == 0);
 
 	/* reject inode numbers outside existing AGs */
-	if (!ino || XFS_INO_TO_AGNO(mp, ino) >= mp->m_sb.sb_agcount)
+	if (!xfs_verify_ino(mp, ino))
 		return -EINVAL;
 
 	XFS_STATS_INC(mp, xs_ig_attempts);
-- 
2.39.3


