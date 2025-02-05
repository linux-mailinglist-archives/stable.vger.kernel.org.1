Return-Path: <stable+bounces-113990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 298F0A29C0B
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F7E1888B3E
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD26F21505F;
	Wed,  5 Feb 2025 21:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xs3urnyY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0F4rPu4V"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A009215040;
	Wed,  5 Feb 2025 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791692; cv=fail; b=BlIBqB+qFjDm1IyI9uFOLrBbgI4b5KZHxEljI93SetPmJhQKpkvCArahitnC2xdGvrMGEfkoQ6Bb19fixqlmcHLscnMvt5jq9xNa/kVi6ukg+ZYD81p6Qt8F8Yn95k+X5oBpr3X6HfGH7i1Ftu+zuKwg9decuz/kcrUy97BAcOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791692; c=relaxed/simple;
	bh=vxoRIYyzitlsKhp4YmnaPMrZaeGamnL2oeUu96UEGFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H2xgAWOzpDjIKiHUt0Yy4keHq++0dzzPWsWHT1A6L7RdoRALiygMkqGjWyqEJydEyoOeD+zlJdHQtwPk+X2KuTrnNeDLVKQ89e01YBdvHqfEbfkY5ZX1IXSvmWY55+5f6rZJODQfXnC2dzdY9A4wBwnh0sWAp6nH3dq8jP6C8Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xs3urnyY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0F4rPu4V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GfmwT005740;
	Wed, 5 Feb 2025 21:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5h4scpKqGm4C+UGBL6932aGlcqk+1RsFKoxb/3nZ2VQ=; b=
	Xs3urnyYRVOjKb+FN655gS3VOFVa9W/GuURAJ4iQ4UFDClXrXgMmNqF4XyZlXiqV
	gipHbI20rhTF2SLl6RulIeimI9/pYncQI/W3eCMblynKuURPfofn7QXe+mPt8TmF
	V1/2B3QqIU4aJfzv20i+MPxiBep1K+XCJweIpSJZ8YmcKrxmum2Dk2Eo4q6Es40J
	BJ3PUBjbWNgsl6x+pO/6Ce6A3+3PVCYNXDUcEvMQfOS4rASRb59yQx1npwchsP4v
	k/seS6dJHL2isKXwbCejI+yQyk4xf8fcJxpeS4bD+cau6aZegQcMQaAOLvbm9mQP
	pMr7BfvgPRQkXTx445PImQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44m58chg5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515Jtvps020686;
	Wed, 5 Feb 2025 21:41:13 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fr085x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPQL6zP+SgMJAluxtMOn4ZhtAgjiIku1iT0TbHjFAVRV5GH4YcK9BbF/xm9jAed/YN4F0Q1KKI8XEf0t3KLI4bO3F+eSsGef1XPotIrOTc7xm7Oa3dfOex/StslOI2nopJgXfSuVwEL7JIfFFpsGJmkd/ksp1quCxkpsKCb5EEOk1zJn61inoal6vM6Z6LgdFtIpNn2Uh0IhjAaKyGLO3yN9DLXOXE+iXaUAfQ2eG1nMrMYFXFPKE4oA3jO9LCrXbnZT2UJZ0wvnECLk7SpHhDbaruifzgXDcWoTparubQTgfZJFFPcaGDKGSggz5Gq2Qu6dX92sP4sila4wNYp3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5h4scpKqGm4C+UGBL6932aGlcqk+1RsFKoxb/3nZ2VQ=;
 b=eTqi+V3pKNfVhrgKFqvAxtpBFm/wXT39L2yDuBy9+Z+y8PXscWwL12xU2xKGRBCJBc5euRxuzOak/6jnmQCF5xRRGhPS1bRFZ30PdreAINkGNIcDhDPRXkngpar8Lf3a+e/ZPgQ0GWckeh30UfU4+ZcwdyQXLrNpj3AE9SJD5JPB+92btzxyyiIUI9hm2V95QD1Y8kLgXMCIuSLH6g06qhBbQ+qFaTqXbrfVSbARMtaIKTV8S2kz+Wxf4R3rgepk0O1/lD0jAweoSkE2Y9R/Fo96pdMon/wH7CKhpigDpkQ4olYoNZ2r307u5C4b+2/RHS7ihQGSFu/3RZXXOff0Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5h4scpKqGm4C+UGBL6932aGlcqk+1RsFKoxb/3nZ2VQ=;
 b=0F4rPu4VVUDaQFb7BXEqxffnLyfRaDCoC+YPlHWTKEnl6uQKq4vBsm9cIXQCpKKX5V4lCuttCGpPCb62J/8ucMQ1LThzY5vNYCC5XWaO9m6KeaCX9vArfTLlqr4F5CFICuViFkQGWS447oOVuE2XUfCG/rbmFCzngu7/H9wLn6M=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by SA1PR10MB6320.namprd10.prod.outlook.com (2603:10b6:806:253::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 21:41:12 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:41:12 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 20/24] xfs: don't use __GFP_RETRY_MAYFAIL in xfs_initialize_perag
Date: Wed,  5 Feb 2025 13:40:21 -0800
Message-Id: <20250205214025.72516-21-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:217::6) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|SA1PR10MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9e7931-fc23-45ab-d48e-08dd462dcf14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0vO2s19YUZFBZ5t095RbAC749pws7BxaGLMZsN0hOwKF1sbpKKifvnY0iqjm?=
 =?us-ascii?Q?T7J7mSuKFaQWDEyu6mgjUzYL2h4Qtn+fyv/ORUKDvwHDbJDAyW0VE7Lgu85h?=
 =?us-ascii?Q?GbTkwX3s6zIYvZrkIo18otXPeZ2qSntafcErlBwCZ6EVdQiPVI7CUGdTPK+J?=
 =?us-ascii?Q?rZ/wgyZiSiYIZMzoP+c7x8YQQE01JqRQtuD/hvGYKEuAdR5NfZSqpXJL5sgA?=
 =?us-ascii?Q?WIpSkqUrzE55ZuvWVJQ6Jy04YIkHd7SguILOMHiMDY0rSlIQ3yLQr2hn9zjp?=
 =?us-ascii?Q?Q8xkOYBWWTvvgfOXmdfm5gDs96OXEaTiWWKMKpfdxzg45K7+X/RN95i6vw6m?=
 =?us-ascii?Q?B3FAn9TxB+YD6NjV7+HlYR3c00COBjLeYaQKjLJ6fKasZki9x+W8UkRAH2xw?=
 =?us-ascii?Q?PLDTC9kLeA9j+Imh73G4qo06QKVi0ya+1TXymldBD7XD6jLUjiDyj2nIVkv/?=
 =?us-ascii?Q?wdOWxLtDKhWPBwHpJw28wLMPX9yZCPkKeK1hlOtX/huf4KhJxSuOYCOhJXf0?=
 =?us-ascii?Q?1KsnLtkFhCbarnk5VlemiHK3OoGlKrqD1sTZJj4YNhB/KKOFvzD4l9SELaLA?=
 =?us-ascii?Q?eHMLgSZMg+hLHbhTBE5iYwgwymYNvVKKsGcQ2wAUHwWgpFVxVHtv0Sz6DeVf?=
 =?us-ascii?Q?D2FHMauZ8PCkil4vq3XBq8gRaJ/Zm+iKW4SP+V1uNr5PUox6JKi0x7p7MT07?=
 =?us-ascii?Q?YpGdK2D3zhpMB96VooFw0KNuDdvr8JLbBByqisnmAN8A27doAMxoRKPK4lT6?=
 =?us-ascii?Q?pbo1D158r7FrdhVqwA6t+a/1abQ4BJPtj9j57dfG7Je9M6HPKLKeqosI/Sve?=
 =?us-ascii?Q?0LwToacgtbOrgcQDzG692rnn2DB9Pk/q0mM/Oy2DxaXb/rvBKG9SZZDWKP+X?=
 =?us-ascii?Q?tWTnmdkjhybcsREDT/waJxFCMPD0whdAWV1y9v1iZYviYpote3CYETmlko0H?=
 =?us-ascii?Q?SgQBNj9N/8lSdjyXUoXXjWnHet64nvPRa5mjvTTt2ryPrwpgvBy8LoFOUEFo?=
 =?us-ascii?Q?8ixDo0a5tkN8X8zZPSXg1Y377vwFGX3IefUQjyisklZ3VBl/f1HKGzCZA0Lg?=
 =?us-ascii?Q?Z6CXun+L+uS7NP4O1JGFRybqoINBSE6dSXnIqAygnY1j8owKKh1BmX25BBmy?=
 =?us-ascii?Q?BWxGPzZs8MbTWSfEarXftkx3uQcdyayY3jxIL2T9yCT1sg14VnenHem0voiz?=
 =?us-ascii?Q?AR8cRwvyZ8rbYg44ZimQEgDOu7J8HfxPIfzIZTkeYq74fLxvRxdlrwavKrNT?=
 =?us-ascii?Q?0QUbWESH0/O9S/pR0UfGwE9nXP3P09mj+ZZgSSbtCwM0jhX1a3Ytx2cLN0yF?=
 =?us-ascii?Q?mwwnxxh6+GanV/RCQVd4IvZUTeazPbTCnacXNUYKZmk8nOfz5bGd1brgMEqG?=
 =?us-ascii?Q?64fC8Lfjt3DGffHRewExqbvmY8W7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ku8E3qqlKvlPjax1iJ9XIK99vt4hObXbqWYv8E7TmpLG/QrhTVvcWBrgQzAS?=
 =?us-ascii?Q?5vxC8wG8ry4UcPuFm55AIKERwVbU4ls81zUtWRWNFVbalaoDR2grfgj1QRrp?=
 =?us-ascii?Q?wovQTaLzjsc0FfnOGSdidMM1ZcaFeGsJBeStkg6CIHjZ09Ftv2h+wde0Plp/?=
 =?us-ascii?Q?oTBCI7I/zBaSGiu6zBc2daF8xUssKUlMEvnszW+P04pZ4fjsrbeGcdl8PfXZ?=
 =?us-ascii?Q?iDMKj/ub/XdrjROVia/OWpUozd8OXFKCFUTmBQBm2xjPowfNkG1RfdOvHfdn?=
 =?us-ascii?Q?H0dKCXrXLZw5wVF9P4LMcT1p7HH8nYuF7oe+5XuD2vgdhkjyVyNBwup0I4Em?=
 =?us-ascii?Q?2rydOHJjWHKjumSwC+FRK9UhnoDymtbIQZ0RocLPLIuNwtjeEFQwRdD6rJMC?=
 =?us-ascii?Q?huzY+e4r9V1mxo5byl7ifjakq5oEFcmhbRSwmnZyF08T5UHDQr0nygUpQubN?=
 =?us-ascii?Q?2TQqjxv6TeQ2ewtr7w2yC84nt2XfJ6eVADI5YFMQDovFudMyKj+T4wAduXTV?=
 =?us-ascii?Q?x4+ICz080K6nRx0YJY0e8Zxz9poeGUrfIeRzvr2RvHwl44/xPcUW9qeKIMY8?=
 =?us-ascii?Q?32qtEubSMUJ4CGbvIO+ogI1PHfhV+UBCoII2mN2nx09Gqip9b/990Uf6BEIO?=
 =?us-ascii?Q?R2ogCkl6XrWvWvXJLLSMtr6H8xzhpCOCJI7aDLuGECBI3w5sWF8Qtzr2L/QJ?=
 =?us-ascii?Q?wTvm9moioolD6RrYnr/CCK6Pir1KSZM9LyyehyHtbc2cTY/EUtxMDRLGfvmT?=
 =?us-ascii?Q?kCzYJhfBrKGrUGa2WSontatpSjXGExx20sIVUvHlShGkAD7I8n5B4IE7cgQA?=
 =?us-ascii?Q?176oUuP3WyFv1em+M7d/iZdH6qdLXi1SFZTvcwto44q/nF3OGYpRhUBc069e?=
 =?us-ascii?Q?LkFzXCjsQ9n4XDgNlWuXUy5HtKvlBF72j4NjhuPXtIEHRR6IB2vhbRewirx0?=
 =?us-ascii?Q?ICykTzCCAccZzCl3BwVIC+0pYHtDfmGxfcaeYXNQInFky/hzJc0Gqn+Hl9IF?=
 =?us-ascii?Q?x6dNW20J8qUJ0kGjCYEADL7rTDBgT/qagkXf11YOAHWsJEvv5DrXFah5tj4D?=
 =?us-ascii?Q?xFOPrJQxVzxB57njPXJV/+WVJVRDFI6NtJ6COWK/9oebTxMq9UxX+zwGeY5Z?=
 =?us-ascii?Q?kYl2vmxrtba7osCmrnskyyAdkvM2t/d+57UPsajeUO85+0r8LTSjqSL9idcc?=
 =?us-ascii?Q?KDOpFA5yfpku5ug1lo/N/pZp3VgkVVcdtCVTGmu7oCjMW7/uP8IWtQJm3kKR?=
 =?us-ascii?Q?IcByd41Gqt6ivEuvBHtDvvz40f5Qk+T9sKuaJF87Vb55jAC1fW87MILUMsQl?=
 =?us-ascii?Q?U6Z5Qn9uw9ttdE0Cw+WiDrD5UGZ4wkeMyGO9e7k4ocxKvf6bb4dQ9Ons/bMO?=
 =?us-ascii?Q?TRlF7RKwlA+pqXGl+kNPK4oU1xmlFwqoAG4qMQBDyQ3aLA8nZGQeTJ+bJwX3?=
 =?us-ascii?Q?fiTXaSAmn7Ut45VBC3Uhtyznp0Yv3LL9QNEmDws3vz7T9Og7QLl7x5no1sC/?=
 =?us-ascii?Q?XLDwiceY2XD0bjVrHJzs3e3DN7djwaZAXZMaNxoG269UKUzM15i/wqT78QF1?=
 =?us-ascii?Q?DU5Yrp4h/5Vtf23QbgPFJuIkllUtk+RdyqMQpJr0GupqDBLCqdmhOV2A/c5Q?=
 =?us-ascii?Q?3N0JXa8BqSwfOkGTiPg3wyBKFttHkA+gjskidf3hLFoOyojYQiYIr5fCKzls?=
 =?us-ascii?Q?24kX3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nBN7lu4ObeDXq8VVI4S8FSUT2EH1IHmR6Q9J99PjJdQgTY2HAc2CR5AEO6vAWbOtxfbXte6F4khJaPdUgI3kx9bl9fONKhmDfAdI7LbrLiGE3XCKeAA+BEzs9BKtiBiRUbY4L+bmQeVhoXuVAv2srzwMHngC+yYHlwj/pVd/mB6+h9j9t9ICzgoFgTpXzEg6bhuHGfpza3T1Nj8HXCJpRio0OwQjkjCpRnw+wvxBhbsCJNMuncZ1rhF0M2jopSy1wM0jQL+smPh3PRQHL5KDoIOfRSm5FmlHyOhaPuCCUqopSStcHufARPt6L5GKw4yfwm3Wk1a5ozZ6uNpvmoOqOyLmCCZrKb9uCq/eH12PyNMv6FyNu7ihYX4LOJScN06xiS7I2b0gVHhXAIglEXlTFQPuDv9jMqeSx2mzS/M0/e7f7up/dMCYOgHp5p0xm6fbwnUgCorAdKmjqOYvDpR9RrpBjQUvwbqrZAO8mbUhvGOUIHZBHwynj+9Ydl28uUT7X3ufDuJKzfYotbhMQ+Xf9tyhjSLAKGcTlmS/VgjZ3yeRyZhvB2V6YglapGAt7FcC20OTr5xRIy9o5mGD131VIOnHmcVUjujHklsbLp9dJHA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9e7931-fc23-45ab-d48e-08dd462dcf14
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:41:12.0137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOU1fz76AbA/sa5zOo3CQOAXXB8r+YTiDkiXNd9de/T4xgS1uUd/YguuPlJ9mslBk9cNwYqmePPy8gv8aCmnPAG2vbM9KIA7scBzGllWCWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-ORIG-GUID: 6sMGyVieaDY_i-S-L9rY0Li0FXx7OhtN
X-Proofpoint-GUID: 6sMGyVieaDY_i-S-L9rY0Li0FXx7OhtN

From: Christoph Hellwig <hch@lst.de>

commit 069cf5e32b700f94c6ac60f6171662bdfb04f325 upstream.

[backport: uses kmem_zalloc instead of kzalloc]

__GFP_RETRY_MAYFAIL increases the likelyhood of allocations to fail,
which isn't really helpful during log recovery.  Remove the flag and
stick to the default GFP_KERNEL policies.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_ag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
index b75928dc1866..ec875409818d 100644
--- a/fs/xfs/libxfs/xfs_ag.c
+++ b/fs/xfs/libxfs/xfs_ag.c
@@ -370,7 +370,7 @@ xfs_initialize_perag(
 	int			error;
 
 	for (index = old_agcount; index < new_agcount; index++) {
-		pag = kmem_zalloc(sizeof(*pag), KM_MAYFAIL);
+		pag = kmem_zalloc(sizeof(*pag), 0);
 		if (!pag) {
 			error = -ENOMEM;
 			goto out_unwind_new_pags;
-- 
2.39.3


