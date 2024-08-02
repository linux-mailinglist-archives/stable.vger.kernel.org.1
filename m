Return-Path: <stable+bounces-65307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08609946601
	for <lists+stable@lfdr.de>; Sat,  3 Aug 2024 00:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E6D282F5B
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 22:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CD51ABEDD;
	Fri,  2 Aug 2024 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T4DP+zJ/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bvAbk/xF"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCADB13A3E3
	for <stable@vger.kernel.org>; Fri,  2 Aug 2024 22:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722639072; cv=fail; b=Rqil5Oro14fBxwHbrwtJjIxI7uhNSTWd+R0WQBizg9HuYbcz2fHCa9I/PVMravWwqBA7Dm3MX/6Cq0jZPNLCdYCsrXVZ89I+R2anoCY9Vq/SeYdqgAn5tfhdedqipTuOrO3dDSubcA3FqhA7ATK0hXG41zDYJ4S4MYlShneEcE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722639072; c=relaxed/simple;
	bh=1Zpdj9/k87wVjmZAqXgaFvqlQRelyIah6HnIfUh4w3g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=me9dtG0PZraoLohn6uVy9q/cuytRsEVrmfPBYB5jvQpNU46UaTgJrkrLwdb5A3Dyp84ZZdVN75k991g81Hopjl8H9qVh6QlHpgFzhW89pa1el48R24dpB8LQ180CC5/6/E8oBMkMXwy0RVJ+tWa0AyhmbHBWmeoUefBg3KX0iRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T4DP+zJ/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bvAbk/xF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472GtYEl022323;
	Fri, 2 Aug 2024 22:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=NyXlIXHCEhJjmY
	bOi7rCG4dYO9MZ3L5T9qWNmXIwyYs=; b=T4DP+zJ/wrENdgVUwgT1Y59orKOFfw
	ROhd6z2rHx7XoL/NX4h9JkbzD5BQ0QIXN3c+9HKQfhVveoXHxV8VTYvKbuYvY1Sb
	P6LCwhq01JcNy9Rse/I9ZP3HfIjCEVXtHYCPk9ZsGY7uxavTtwF8Jhl2HpTvqPy0
	4jjjZsf8+DTWH+YT8nGFeNUbEGPhvHaDH7ttMiLxZGZldnthx30cOKvkCsT6j8pt
	+wNKNe3BXfoMD7fVmw0LJSXP/eKBrviBCxK5cqiS1n4Mt/glVD3Uwvv/cNs3M3Ul
	jAKDF5K5HE0FezbfL/KdCwseT6a6r5hRxtT8xKci+pgi/9kY4NnMt4Gg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40rjdwjagr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 22:45:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 472Kstu8001919;
	Fri, 2 Aug 2024 22:45:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40nvp27vd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 22:45:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3dUkTjrF+fMfmPDEmwL1pIbR48qsekY8RQ3CmN++kyw64sTyFUDWobra5sIq3SXCf2WWldRhuo/gNy2UVEUvUMKpearSrH05dXNTrWkKspsLDK6+e8uAhisIZTjmq0NCkgeGXUJo6hi4Rgf2KtUszY5J978BXwsisOm1NrFY8ejQFmYSjOq773515cQWdYwTsMfShstXoG/p0P8PXWAfaQNSvAO4Rh9afrtL14MTldAAdSLaqlrwfcqL8xm9j2qcv1IV4kuasQwKkMvWiimyr/tMNtCW8+yQEVRVdZEDwenVuPt6Qh4mX6BlioBGwxXYQnU7QSBcWmk/9s51gd5Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyXlIXHCEhJjmYbOi7rCG4dYO9MZ3L5T9qWNmXIwyYs=;
 b=ca3NhTF9tsYMdqgEouKRcdCsF+KCZ+AVbRcX+GHpaIQvCqo5kNtiMxxO8A5G/2E4hD0PqguRZ+kLjHpknvvu5H8Y8xAouSit4XI08hjQCcX3ef/YihXaHVwywx32eA5YfyhbIzIy6OCXc2cJLqIMMVWaZ6v91YLfHdosMoTigNt2zZg/iv1yBMfNfeC3s7YE1gmdrGZ5lUWK6mJHIwLqAWLbyhjGM6ffAXkTXF7chNpyXVADFfmqatyJS6qNCxwx6MCbyvN/b67TPLEuSaJjlTP5EpQbrK8SIUZOmXe+rkIfHLwOmOzjDJ7CrX2PKSkl7dFVwVZjPEVSHCmxUroz9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyXlIXHCEhJjmYbOi7rCG4dYO9MZ3L5T9qWNmXIwyYs=;
 b=bvAbk/xFro6Mly2UUVqcc/e9jFXV0K8pFUto1xXedioHn7flaBhQNHys6N7wvZVu0qXLnl8CbQG6Q5FRCiWIllXGwMsDfYts+W36yvt2pNZKtxLs8vsYg4jgxrxCd0GskDYmHh3aWqpXnW0kfp+Vx2UdH34V9GPgMHY6QblXniA=
Received: from CH3PR10MB7611.namprd10.prod.outlook.com (2603:10b6:610:176::6)
 by DM4PR10MB6086.namprd10.prod.outlook.com (2603:10b6:8:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 22:45:55 +0000
Received: from CH3PR10MB7611.namprd10.prod.outlook.com
 ([fe80::964e:c609:e8a:418e]) by CH3PR10MB7611.namprd10.prod.outlook.com
 ([fe80::964e:c609:e8a:418e%5]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 22:45:55 +0000
From: lugomgom <luis.en.gomez@oracle.com>
To: luis.en.gomez@oracle.com
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        Edward Adam Davis <eadavis@qq.com>,
        syzbot+c52ab18308964d248092@syzkaller.appspotmail.com,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Alok Tiwari <alok.a.tiwari@oracle.com>
Subject: [PATCH UEK-4.1-QU7 1/3] hwrng: core - Fix page fault dead lock on mmap-ed hwrng
Date: Fri,  2 Aug 2024 16:45:48 -0600
Message-ID: <20240802224548.354733-1-luis.en.gomez@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:332::8) To CH3PR10MB7611.namprd10.prod.outlook.com
 (2603:10b6:610:176::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7611:EE_|DM4PR10MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f61aa3-c312-463d-0b69-08dcb344de63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IG0Tk36dDnCLawKijaAxe86CupjaQSwTo62hBYk4y0Bh8fgWAEFdqG76AzLI?=
 =?us-ascii?Q?Itbnaxy2RPR8gpwD48qu9/HGT6TQuB17pz46oSAbhSqWuWKxOr2RAyv250Qv?=
 =?us-ascii?Q?I4nBmJN5zFrZCj6/09DT+rXAbf1FN+oBRYldpfN2ZP999IRtpb0GfNiMQzsa?=
 =?us-ascii?Q?4dPsASIYa/0SEZqbZQ83fjr/0DESSJy81ytqby4j7tuFo6EKpqd3RDqKOx9d?=
 =?us-ascii?Q?tG/JHTYt2WVCQ9MGioznL46cTwlckONWi6xVhVfPSnxKKXl2vFRNe0gzid+N?=
 =?us-ascii?Q?2Y3rIcGdKvfSIejMKV78Qxv2Ss+/7Nw1jC31tLddm8a0HAuj1c9tJ9hq7xV/?=
 =?us-ascii?Q?HFptHUBkhqgkk5KbkSpD8vVoiANnXt9BbLkZm+VTgfUf2U82ZAqusqcg7hfD?=
 =?us-ascii?Q?ztvuanG8imccHyHtlQyNt0BOIY+9FAZ9npPgjbmjSAN5QRk8tXgKGU2gy345?=
 =?us-ascii?Q?dHPuyiY4RWqlm5u8/zgfIBzTIkAm7FAUo4rI8HPxdzFSICBKi/8ZOJdujJc5?=
 =?us-ascii?Q?vZFWeTOCkfbKqLnV+6FmtGLmbCEcs8PycmdENy7aGxow9z3k6I8aJ6/gGgJs?=
 =?us-ascii?Q?G/XV0dG8z4RxiPJolBinFlA1WcIzRbmwSbJjfSPxP3kBQk+ftwwmdTrNlQzO?=
 =?us-ascii?Q?JzGXF6ugKLLSwyD88CtaTJHTwv1/gRsjEwWHNvlY2iCqtol+tK+o7wEJTQy/?=
 =?us-ascii?Q?rz/FNULG2EUWKX5krDgD8WsSGXiOwxBDts/2sFtKF5MdTrcqEwVjmfRX1w6f?=
 =?us-ascii?Q?w4BXIKfYM/lz5iwbhEG8/lfUxeK+CWTaXlA7cvOOW7xUOGrUnnuzVlXw+KqF?=
 =?us-ascii?Q?vbb7B3vJzq0DBxP4tkSxT5Ez1urDFf4ZVY1/b5VspTPLgleF/OVxS8E3NKXs?=
 =?us-ascii?Q?FdAMAlYSz87IuX+/TP55enib4KonhP+Qt8BsbdvBJ17RY94EyGkWyUlPBetI?=
 =?us-ascii?Q?mDFo2r9Ut9cYZiPH5REovtFvsGYG4ZP8JbdgJp4nfFMZW5w5lBQlC4Y8LMYq?=
 =?us-ascii?Q?aKx5zGmHxdQtgm0gTXTKnElEeJeb+Fqd5Kl62OV05W5WZjilXoLERQ+30Vyv?=
 =?us-ascii?Q?4s88elpk/bL5ajGmNIhPGSYl49ZKYh89hgug429fLDj6zVnI6tYIgRcKt26E?=
 =?us-ascii?Q?xiCs+ehybfOL7Vi6BWSxjCGwr/rw2PD3ZGKAMhtmrjgrOmelh1zssChyD29s?=
 =?us-ascii?Q?95omB4lpoBmCCusJX2+LiffVAXFQBeZeiasQoDyw61VeWA024AbuTxSy4uXE?=
 =?us-ascii?Q?atEtwF/ObemV3wtmtxpYRwP+xtUa+8UEZamYZJX4qt5KLFuto8Cjr5+49Br6?=
 =?us-ascii?Q?Gd8KkLzJdjLgtOX5cJ05WSMnTEDZcw8frbTpZ1Xmgy28Ft1WSSfTChMAGxzT?=
 =?us-ascii?Q?G9As60Sv8oFTCIUHgv34ie8DpKxpUa531LRNFmLvdjmOZu2v0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7611.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PsXIY1ZCJLGO92CcmDZZu6g1ooiuCWVa0hQEKtDjvpl8FETZv2HjjI4Jo0O4?=
 =?us-ascii?Q?wIuw/gqs4V5wP3QXtjKWDYGoOArp439l1bQekrd25nxo8X7S17BSYsVfd3/Z?=
 =?us-ascii?Q?yDJ04UhPVEkRmjntirZwPGbrvCVKAPJOKqbQbrWd01aCTIFqwLbd6oA4RKXW?=
 =?us-ascii?Q?0ThDLK5lvikswVEygo2t5AgdioTl1sQ0JE+Vp/uNvP1c/z7RaGs7oAiNOLWm?=
 =?us-ascii?Q?794FFwiILN+xuZRihWZHK8EYVFO3o00GKdoJj2vYYniQlXHwIRtMkQica6NY?=
 =?us-ascii?Q?LV5nA2S10Ybe3s3FNKy/5zMyw4XMCNVxc0DqvYY9hxfHhJwiLJtUiNBgEQOs?=
 =?us-ascii?Q?KFIGIhilAGcS3Gb3nyXAugMQHoGRIzN6R4hPqmFjlYYsxhPN9LwB1w1b//Gb?=
 =?us-ascii?Q?a5vkOos06g+PFsDd0g4CB18XBEa7tDz/DLpGZ/fkMBqHkHCu+ymDIJS8Z6sH?=
 =?us-ascii?Q?XK79HtuWgG0qxhD0R08j73WTr/NRArC7EMgdOTHrNqbDOPuj/kUVAknSHNsc?=
 =?us-ascii?Q?p8xKyV2t7UBGuMyUPoPm6B3Po6pQIqUipLVbwxRgzzCSgQgt+WdqrEmqozzA?=
 =?us-ascii?Q?advv4N7daKb5H5pTaacpbHTWIWp/dEEWn4uG2w5sdwS0F1p+kdUe0CiSf16f?=
 =?us-ascii?Q?fswFXoP+UvKYTvCy8NkvAKIJ3xsk522bwQ5oYgBoSYbBhSY4j5SU35lYZzRk?=
 =?us-ascii?Q?G5XdJuMsu8I/PW39NvmOrRnGnXQaZyEM/+L7drvRBzodtDUASKyafOLNeG8K?=
 =?us-ascii?Q?sADr39j+L/Ul2lo/N51N47GWORldynbwuM4Q9VW9qRbtQN9GtaJwmmemKmK8?=
 =?us-ascii?Q?vL3eTFswxOz/RbF0i6CowzUcBG5Y3rsBV64x6gvnPIFbk0+weMHTYg1B2tH7?=
 =?us-ascii?Q?k5CXC0Lksm3tMxk6zVFRpdtM6NmdNsd/XKkLGFGZvpp3Iony/yg+kBGxBwbK?=
 =?us-ascii?Q?uHfeOuLUDSP1WKXxIvGRxLxRsIHIdrq5JIVU407QqTe2yhDQGAU2/zVhp3NR?=
 =?us-ascii?Q?aL0IKJp9jobw+1kJ+dYn/BMBRVFEwxE7Il4pXbc0rZckzE1RT6hmYEbdsXGP?=
 =?us-ascii?Q?Zd1AqCSDR8ABV9OfR1iZKcmX8i/4LsVDVyRpSY3SwqgtnivtEusFrWVc2Owp?=
 =?us-ascii?Q?HHJ8Q9NpBPoMomHjnvEXwhY/9VxKe+0fiUWMvRv6JFXIaf+Zl3bYgOanW7xS?=
 =?us-ascii?Q?Y83erpSefN+fnGcpcO4NNgLY7j+bFLLHqz0OBLwO3OOHod8P/pUYIniIk6sY?=
 =?us-ascii?Q?s53k8I8O4D6HBIe063vLRM2TfiXfb+t+0SoH1A4ZJYBjXADNOIxavh6lEGdB?=
 =?us-ascii?Q?vQVV76dGYb2h2LrG0AbCZgEowA6SJ45J+/+mcnCBzmsZ9kjW+QQiGVwMS8IM?=
 =?us-ascii?Q?uiPC122j6SOWdJnvfhU9FK+zLkR6RXKMMTscmOAOY7MedYxD5AacqNMHNwE3?=
 =?us-ascii?Q?jVw1ZuoMRUyCLtvsKb+QQKd5hQQoJi0KpFuqztzDHVdzRr/p2MeUKuUCXoqm?=
 =?us-ascii?Q?P6Evi7uNAAneqFQYNqG4Atf0MwI8YJLF+jS5vPI3YfMh92DWr6PI+/P6bVbz?=
 =?us-ascii?Q?ce3C5I2sQ0hOI+A/NnRGj+bASQYSqMeyegQ4tRsi9h+uz8I21SCeTGy5YNdv?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Su2/v+ivV1NA0a4BeZwToj4f/+UZ0c6Cw60v4gb/fLUkroyQp+4TnQBau3MO5VYG2lyKLrynmVByVoqggebFnhigWNr0wihJ/VcDEl61txX425kzDSLRzvke4PpZz2Fy2q25zazcmsJPuguH8Ft0xoJfqujZOP9WK4ElcYueKfJkbdWvOyCnVraksywQZSppEMtCnxujXNbenMU0O1PbhlXYTnof/CkdWpgaJOqgsIpExZAJExASpRAhc6n0qrg+Bypn9ALWPZ3H/00xPW9xcTGlKD0ePfTDskKOA4c5Khw13cOOpTbkdWNo6qZw2UK24YDzvdDw1irdtgIYsuLObNXYvxFDkA7/LiW6ju1LubzgLbyKYBiyG1ZT84AuglOxXvc4tSUK+3ALBwxUJKxsI8np7GLch93VJ88ghv+ZvBpPuOSy0Gq4AxHIDCvZLvaCFR+A4auqahS50dyAx1w/fCSCOcdyu1h6LV5dQmWXboF8CfleI3MKkz5iWhKjw4ynEy04pIDqJkVtIlpBbnfFeZZpJ7a3dgr2NbOjQ7JeigRdwK2aY9wD1a3hWbEH1WYv6l11tmaoxnYXQSN0p86eU9zvusKc6y34MpYTNmq5j5E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f61aa3-c312-463d-0b69-08dcb344de63
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7611.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 22:45:55.2551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Krf9/BQ1FPZM1Ad4RblB/4ud2eTA1VpG5VoN1BDvpE1J6B+JXUkvbobo+JNQtzkhKKBVTScDzStDg2o1LVR3J/LrliqOuThXqJjFV8XXLsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6086
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_18,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408020158
X-Proofpoint-ORIG-GUID: RTd_d1lLysUyvmKTpNfrVJmscTRtQvEA
X-Proofpoint-GUID: RTd_d1lLysUyvmKTpNfrVJmscTRtQvEA

From: Herbert Xu <herbert@gondor.apana.org.au>

commit 78aafb3884f6bc6636efcc1760c891c8500b9922 upstream.

There is a dead-lock in the hwrng device read path.  This triggers
when the user reads from /dev/hwrng into memory also mmap-ed from
/dev/hwrng.  The resulting page fault triggers a recursive read
which then dead-locks.

Fix this by using a stack buffer when calling copy_to_user.

Reported-by: Edward Adam Davis <eadavis@qq.com>
Reported-by: syzbot+c52ab18308964d248092@syzkaller.appspotmail.com
Fixes: 9996508b3353 ("hwrng: core - Replace u32 in driver API with byte array")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit eafd83b92f6c044007a3591cbd476bcf90455990)
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
(cherry picked from commit 581445afd04cac92963d8b56b3eea08b320d6330)

Orabug: 36806668
CVE: CVE-2023-52615

Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Reviewed-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>

Conflicts:
	drivers/char/hw_random/core.c -- Minor contextual conflicts due
to missing commit: affdec58dafc ("hwrng: core - Replace asm/uaccess.h by
linux/uaccess.h") in UEK4, and it is not a candidate for backporting, so
resolved conflicts instead

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/char/hw_random/core.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 5643b65cee20..208d0fc2c923 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -43,6 +43,7 @@
 #include <linux/slab.h>
 #include <linux/random.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <asm/uaccess.h>
 
 
@@ -51,6 +52,8 @@
 #define RNG_MISCDEV_MINOR	183 /* official */
 
 
+#define RNG_BUFFER_SIZE (SMP_CACHE_BYTES < 32 ? 32 : SMP_CACHE_BYTES)
+
 static struct hwrng *current_rng;
 static struct task_struct *hwrng_fill;
 static LIST_HEAD(rng_list);
@@ -79,7 +82,7 @@ static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
 
 static size_t rng_buffer_size(void)
 {
-	return SMP_CACHE_BYTES < 32 ? 32 : SMP_CACHE_BYTES;
+	return RNG_BUFFER_SIZE;
 }
 
 static void add_early_randomness(struct hwrng *rng)
@@ -222,6 +225,7 @@ static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
 static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 			    size_t size, loff_t *offp)
 {
+	u8 buffer[RNG_BUFFER_SIZE];
 	ssize_t ret = 0;
 	int err = 0;
 	int bytes_read, len;
@@ -246,34 +250,37 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 			if (bytes_read < 0) {
 				err = bytes_read;
 				goto out_unlock_reading;
+			} else if (bytes_read == 0 &&
+				   (filp->f_flags & O_NONBLOCK)) {
+				err = -EAGAIN;
+				goto out_unlock_reading;
 			}
+
 			data_avail = bytes_read;
 		}
 
-		if (!data_avail) {
-			if (filp->f_flags & O_NONBLOCK) {
-				err = -EAGAIN;
-				goto out_unlock_reading;
-			}
-		} else {
-			len = data_avail;
+		len = data_avail;
+		if (len) {
 			if (len > size)
 				len = size;
 
 			data_avail -= len;
 
-			if (copy_to_user(buf + ret, rng_buffer + data_avail,
-								len)) {
+			memcpy(buffer, rng_buffer + data_avail, len);
+		}
+		mutex_unlock(&reading_mutex);
+		put_rng(rng);
+
+		if (len) {
+			if (copy_to_user(buf + ret, buffer, len)) {
 				err = -EFAULT;
-				goto out_unlock_reading;
+				goto out;
 			}
 
 			size -= len;
 			ret += len;
 		}
 
-		mutex_unlock(&reading_mutex);
-		put_rng(rng);
 
 		if (need_resched())
 			schedule_timeout_interruptible(1);
@@ -284,6 +291,7 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 		}
 	}
 out:
+	memzero_explicit(buffer, sizeof(buffer));
 	return ret ? : err;
 
 out_unlock_reading:
-- 
2.43.5


