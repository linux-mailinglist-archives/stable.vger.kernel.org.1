Return-Path: <stable+bounces-113974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C781A29BFB
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2820169127
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C414215057;
	Wed,  5 Feb 2025 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ekMI2nXu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XSCZij2T"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A2A21505D;
	Wed,  5 Feb 2025 21:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791653; cv=fail; b=NbfHut2AAd61KJYLZ772Csbh2fXEhrHXeSLTq2O4j7qj2D2YPYW2Gg1zNMyfo6nBn4fDHSYC1NYvgoIdfRonYKX2B2ygSOyMoAoa3yYsuWZDDFRuV2oi2l8/qOCr4AUjgRdwV5Y2ESimE881mJWQmDEZdOJ393+/Ul2NhNXpA9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791653; c=relaxed/simple;
	bh=CfAkFvmcrynMSrjxoVn2DfJTOjG5wElrhm6YBNQoP+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZljbEI318edI7uElpUvxrCbvQcPJwGrnjSwR1Ap82l0OUi4DlcKcr/o8jWkopUQ9q4eCmJkNjE51ybrnWWv4FYU4fLv1wN/66U7xBIUDKtdooXF3jA8Qnbu8C2pfjGeH2iTcswjMY4neJtCCZyggmeJTa9byit4ZwRT7fI/KUVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ekMI2nXu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XSCZij2T; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GfiF4016851;
	Wed, 5 Feb 2025 21:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+ABh1slJlJOpC8klhf7npbgKcFgLf2y+JivGqPfzx2w=; b=
	ekMI2nXu2icddzmOyj96yKiexTby59iN3LjhG1Il/ttVc1sMtUDc1rl58oEY7YYu
	DYnrdcT7Yp022D2f3H9anuFfkdaKRLWjJwjqbt77f8c5RzbOvV8e1yY0PcTQskLG
	Q+WT9uTx5K0rD4eRBNxQGGuF/yBzIfqKkbJq/jEPSK47u9Fk8DM1IMUaJGnNkIx4
	/wQoauWynkAu2jF9MPiuAUSD6WKXmA9hxdOiJrJroDTIpLpo8M5vwhxqsyVomn1s
	MoNPHuP6DuS5xE/eCAvQhABygClbWTmIAhEUd/zXkZ+1ClG7W7fbpeHwWB+SXZdl
	bxc4l8CYSRfJijhCImCvbg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kckxm21m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515JtmVt027758;
	Wed, 5 Feb 2025 21:40:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8p4yujx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONTimNq1JqCa5nEIqaiZ9Lf1S3vAwdLbBmXVBnIyo/V6MljuIQDaubHGNOqbHmWQoUu9rkqbIRLJR1eJq2HcYdB99ww7W32xShUp/jJ2YJyJfl6y2qQ5hJ22KtsLFIKrUeFAgRbb66D+GJwA7wefCecRwbP6idhxek1rctRm8rAEJPbNFMe2y57CM93yMEnpUl32bncx3j96RWJohwMaeM8LBl8K1k7wx8H/0kOO0nz1/qqutywecraNI94kwWB052rE4KAcFnqZDlVSHOu7iYLfNqolRzShrFbBBjiy51pKt5WsBoIhTbyF/KRIlFPp4ahwUbuHG1uNJyOyYfbjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ABh1slJlJOpC8klhf7npbgKcFgLf2y+JivGqPfzx2w=;
 b=sqwfnyF+0qL1uBaU6rKYXiHZwdQ+RO9ME/P+Kc5trQnTkZMVpDdfSfCL+XI2Y5e6fxF/wPpvTiQDEIbiYUHLilbKGPYNQDB8yljDKjfD/IssrPrCYy1C9w8/3hkusNcbKLHh+lzvryjOwmVVyYxxfKxcWMRmSNN/OE1Wz7xiByH6aTlCiO3ZgRkK1mWYnmD8yCVPO1SUjcuQIh0Xn6X4VmdSjpJuG4CHoN/rQxjzZl19qAs2/P+l8jku1A14f/OjuJpacCj8yytDznPrwhBmIsdmwrgMwT1slX/R0oGFWscAVq5pIoj8/8WlAbAkGQY/hhoBVmT8CR9ywBklWAWHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ABh1slJlJOpC8klhf7npbgKcFgLf2y+JivGqPfzx2w=;
 b=XSCZij2TzcgxybRVKkcwrnFsTj6wcZRZ5NG3SyJ74f+r6gah372GSmJauK2zCFeXNWAgOMeutq7ZU18Me3iKe9a/eblgIhHFVu02jHLmMQzoiPwJ5X9uGC4oihgTn+nnQsYVTwexA0qnPMTFfB6jHI4ZV45CgwhJ1hgTMzxdLl8=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by DM4PR10MB5942.namprd10.prod.outlook.com (2603:10b6:8:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 21:40:45 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:40:45 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 08/24] xfs: return bool from xfs_attr3_leaf_add
Date: Wed,  5 Feb 2025 13:40:09 -0800
Message-Id: <20250205214025.72516-9-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0161.namprd05.prod.outlook.com
 (2603:10b6:a03:339::16) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|DM4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e29e31c-3de8-45ab-bf19-08dd462dbf1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RsTI+ivX38iZ/GG3vm9VmplIPBGUTsnHzHIL6LQYKefWT3ehBN+ZvPBwhgKC?=
 =?us-ascii?Q?P6pCWT/tmAsemXz1FGo0JLiJIG4b4iehXHOlkme2bYbTVdrU4QAVUMw/pegM?=
 =?us-ascii?Q?kulWyGFL+c21PpudXH1SwlKRrxMuN8+W+ThHMpPxsJoQjwXmpXRu66BeQuPR?=
 =?us-ascii?Q?IDNeh2DmZIoEzQ4R+IOxYbyosVE0NwfvAlqRT6RO0nki8GljDhLfBTUTvgha?=
 =?us-ascii?Q?2zLP2hgHMJdSKXG+GVFYg4Sxr303Pjs47D8J1/REs8eZTnIzE+r+/sTNdbIT?=
 =?us-ascii?Q?lUK703ljuX8nDVl0gd+IuVciS5DsTkuMpziX6O452Jqt2Fqe6TWSJM/GGbCZ?=
 =?us-ascii?Q?YjAEDpC5cJUPtIXFnHAXFioZEKulEisGUn7/oN04jq0W9pYMbXQZ0CWW9waK?=
 =?us-ascii?Q?iqJj9xAXe87u5x0YdkMthvYR7s8VnC1/S4wRdxOUNQHjxFXjnJ3fdWxvFEeZ?=
 =?us-ascii?Q?nU0cJ7TIFMtPwECQOe1aA5Dg/yolf2VrLmJG5rFb3f1p5E7iM8gwn+AYHdi2?=
 =?us-ascii?Q?LC030Rciaa0Sz5O/rdloym/n9JhBpbbqO3qZ3trtYEsuAqYAXbeR+D3r/F3o?=
 =?us-ascii?Q?/3l22XKpcggefEbuaYdbmZdAfJANrnT5OtaasoUflE81GV6awu+wTZ74m0sb?=
 =?us-ascii?Q?ADwMbApgGrgIXTnsmeWyZaHLTt1yuG3imkZ1xd7r1ZtHShHsOhXQAdkpsiX5?=
 =?us-ascii?Q?L5DCfMHISflyy9lpZnOgLeyZkEa0PFdTS4PEs399CaLrNtPnAmj3nIg/j+Y1?=
 =?us-ascii?Q?L80jdL3QhHBq2hD5w+icD/FcIWjLDkZRmq8HVYHOFbdl+6Q/lC5CR0bQ8rJT?=
 =?us-ascii?Q?9vp9LvslAoibWHB2ksTp5CoEr/MqpcpOQ0Lt8yokQMRs+O8JMNzrHT7oZ2r6?=
 =?us-ascii?Q?HBvO2HPKKy1jbcikrzNBNbAV12/gid9eYM3QjD7HKCv+LclzRxGdh7IFmWa6?=
 =?us-ascii?Q?AOdRNzseG1IjgVRtRzz9MEc0ChQRFlKirDx+bzkCJSP8YrNWnv3T6jUNHTzE?=
 =?us-ascii?Q?LdNVnrr276IP5yeprsUkCPIu0gXmAhxYSfngeZMoLsqP5zlKaZJKZ1WzPZ4d?=
 =?us-ascii?Q?dnKeYqyr5xxrP4FK9gQYt9KWjsD0Ri+zYxtmek7AqVhMeTNR/L5D9l/3mQ44?=
 =?us-ascii?Q?8a/3r4tt4aJLgWZokOHMMpGBLIu08EsGxFgrVNDn3RveZiJpbttU72OYPLtD?=
 =?us-ascii?Q?D6iROoJNNqggl0jEJ7Q0zDw5qDwxG/w4OIJPwWjCZql+G/11x2NsQyjzq1VW?=
 =?us-ascii?Q?WKd4+Am58yySxr89IsXjvuPrOUUmKVVZtv3C5yzlwm9bO3oQ2jh6DmJaq0Vf?=
 =?us-ascii?Q?4C0Ilbw5BtthXgEck/QYne2npJzuLXfd7LeJINTK9TO3f8cPOQbIm/iQ20be?=
 =?us-ascii?Q?vLhNUXeZPhkYHvi87oyAK4RF4aRE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OJ4BdrAnNSe9AvqDKGWDBr2sSQDHJyw736qwnATLyk7254ZGlNTmkOmeM0tN?=
 =?us-ascii?Q?yLFQZU+aqy+YNstZaqPZ+B1i40g1RIdGe0Tc2duTyMQHiO47UIcFVmLGIQpg?=
 =?us-ascii?Q?TiCydYZTK9MpzysciijVISh74mf6qr+UAAWdvU6ENxQgDb0RsrK/grag12Rf?=
 =?us-ascii?Q?N843aiZDrrYrcJY7D+wzoj+8pbx+x0AZJBAxyjYi2TsjQcdnNLpGptmbbfc1?=
 =?us-ascii?Q?gYWxLA4dPqqwegndzb+WmNzEqCRPBF4nLkFso5Gb/sk2q3qjofOBHqGiV1mh?=
 =?us-ascii?Q?mJFKa2vtPfVhdPhgDFMk3Tg+Xms7wo8jpLCBXf+0b4/gKiVh4qxlqjl2YAIF?=
 =?us-ascii?Q?1QNUe9xUP4vh3cI4vatGmVgP/z1Tu0dOx6Qd1ZPrtTRUUzMIn6Ck5QRJBsTw?=
 =?us-ascii?Q?dqfDetGd9jIpmxOy5nUzN/3bVZV+olw+falSD4iGM85nkI2UPzZYEuydLcOr?=
 =?us-ascii?Q?yzchQIBCosD6OWDTIQWGHkluU9MUDZKFx/HNPpdr9PfQmJpImvnmmk2ufMk4?=
 =?us-ascii?Q?z77Kw09wdep/HL0p3e4tuCpDfzHEZjEyVSr37ExsdYgy9iNyK4HVGcrtLZ7s?=
 =?us-ascii?Q?IxljyucWpjQ089/IMK+Lz/Hhl92lz5WE6VWG5p2FhO+NAEr5DE59Jy2kumF5?=
 =?us-ascii?Q?TwJYL/OzXmIgBkgyRixeu96eabDFiMHViHyG2fBPDCXIVB0+csDDDCfH9NrH?=
 =?us-ascii?Q?VVj2+sySeDuwZQ4LdnOHgKk+KLyLDaHZS6hARn70sWDVl3mr8dZIdEgczh74?=
 =?us-ascii?Q?svdASFKdSYtFfenY4PIebvcHHfxyvyyFHJjo9qP126q9s/GQ9bFQqonWStFQ?=
 =?us-ascii?Q?OmKiuY8OEL4LweY5HWokJ/e96UQMZgSflCppZd7vP5Ea8GKVlsHfAkD4VxrQ?=
 =?us-ascii?Q?1Gz2RKqx72xkGyeV6yINt1w4Z3ew8bfJDCBLfXx8fpo2z1e3eLn97GiTNvsI?=
 =?us-ascii?Q?aoi2yWSctR7K3Pr1Atc7tCsoJsUkEEWVo8eFcRxmxH2pHBYaYq5TRjvP5TbM?=
 =?us-ascii?Q?vycGwgg4xWbGf3H7TY5Q5chfVylr/2NYqEBtAC6f5kJ2M3jPAH85vg4XWR4M?=
 =?us-ascii?Q?yW/m6cSnU7Zob+uWlpHJ5M/Xct58Ur9gGXhtSTdB003562xnxDJChAQsWoMJ?=
 =?us-ascii?Q?CQ7NVwnZt0QYYbYmBDqT4R/dR38vLzh1VH10iroKu2yQHZGYozuooD+cR1eS?=
 =?us-ascii?Q?0LN1BDeohlIn0eyeUZYX9RNLYQqVJPU26ZRNzLx60jBmnXCboyEcGWjFeOaC?=
 =?us-ascii?Q?bocUW2TL+Hmgq+2cWaM22PPpBSDxFp3N1hg+r7474ErKIVvwoMoUHuJ06us7?=
 =?us-ascii?Q?ft2pJbRwzYrV2zAgsC2jQmlyXAPCgEyelwptPWR4jqeQ54AkHMO9HXPQ3Q7a?=
 =?us-ascii?Q?A8GcypmwHGL6dmSM0UqAziyZdzCjZ2csmH1/tQ6pn/iGirWqkhXBCrSDoRup?=
 =?us-ascii?Q?wSmvLYVjJQBJwhCo0Wnw0jQlmZiFMmhHdb/iS0C2+2Wm1zvBXseq7eL76Yez?=
 =?us-ascii?Q?hWl/Pc1QOGQAxjg3dMAEiTE9RVcvRNuNvWF2ZvEeMaiU9Q7U6yqQ6h7hhH5Q?=
 =?us-ascii?Q?r9fy4q7/J7ApHOoG6sAVBtmzQtkd1QhqJftosAqaEq1/gyAo3ncCbZJ5IApA?=
 =?us-ascii?Q?QInLa4hW38X6tOuC0RO1F16zm1pf9ysNvYZ/VM+USEyG+YaE7iP7IOfuVmSj?=
 =?us-ascii?Q?6Z6wZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SDf5vxqo5LMB9LH0lx9opX+8OdQhuvgUx3PBW0o8UdqWlY1Zc/wrDsx59zI6ieOHu41UuqbBj3HgovwXvbJemztvNYr+HAz/CMVvHWkYACIAEgwEBYciutJHqAyMDKvY+Y/Qbn6lFJHlL/GTq/3qTgGpNPIgqbbHRsimRfS+C/nBb4RPpf7gWKvQv0/TcDfyyFwh/S9ny4R2FhL9qieedTPkKTBVEb/KDEw8FnWyR/RKzn8Zxc508ovWWxiCQ6w4LZ9yo/jzIvB6NUoHj46S9EuTnRT5ZTs/Zs7UUresPfz4rUdUIs5wmR04JjpRiTdR0q3a5LosFH6t9QJq+PQrNqogjjY4xJW3WB/jhwkLBk2v/tXATF7fJx7rXfSHjDKwVE2/GA9ZpDLUfhN0eg5G7yZ0yf30SoIBnfvhYg/ayjaxqwvMD+pPZJ26O+QAM88A1sTwzj9R7IQlDJnOzerQ2EskrAB9ZdgH8flfeBc8ISXVZzmtgh1RGuoKmrBcG6XlhX9Ee0V0aYVSX76tJyDrzyYpdESUMa6E+8ANJUWD0Kvt5VcRjUwF9YhrxJIQ/BujiTA4wQC9Gs72h28ED/nKu3RYlGa2JuhgZjqWNZPllR0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e29e31c-3de8-45ab-bf19-08dd462dbf1e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:40:45.5944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwDn+ngdupwjfV3p9irs8XL74H5prO1shojItHNYmD6H1X+JMLkb+tVhYcMwmo4IcgXB4UL60UP7TAvs3JgVWf6ukWio8v7DMwylAW13WGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: Ch8XdIKTTtB7cbX4GnimgADKcV-tlRIE
X-Proofpoint-ORIG-GUID: Ch8XdIKTTtB7cbX4GnimgADKcV-tlRIE

From: Christoph Hellwig <hch@lst.de>

commit 346c1d46d4c631c0c88592d371f585214d714da4 upstream.

[backport: dependency of a5f7334 and b3f4e84]

xfs_attr3_leaf_add only has two potential return values, indicating if the
entry could be added or not.  Replace the errno return with a bool so that
ENOSPC from it can't easily be confused with a real ENOSPC.

Remove the return value from the xfs_attr3_leaf_add_work helper entirely,
as it always return 0.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_attr.c      | 13 +++++-------
 fs/xfs/libxfs/xfs_attr_leaf.c | 37 ++++++++++++++++++-----------------
 fs/xfs/libxfs/xfs_attr_leaf.h |  2 +-
 3 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index f94c083e5c35..1834ba1369c4 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -503,10 +503,7 @@ xfs_attr_leaf_addname(
 	 * or perform more xattr manipulations. Otherwise there is nothing more
 	 * to do and we can return success.
 	 */
-	error = xfs_attr3_leaf_add(bp, args);
-	if (error) {
-		if (error != -ENOSPC)
-			return error;
+	if (!xfs_attr3_leaf_add(bp, args)) {
 		error = xfs_attr3_leaf_to_node(args);
 		if (error)
 			return error;
@@ -520,7 +517,7 @@ xfs_attr_leaf_addname(
 	}
 
 	trace_xfs_attr_leaf_addname_return(attr->xattri_dela_state, args->dp);
-	return error;
+	return 0;
 
 out_brelse:
 	xfs_trans_brelse(args->trans, bp);
@@ -1393,21 +1390,21 @@ xfs_attr_node_try_addname(
 {
 	struct xfs_da_state		*state = attr->xattri_da_state;
 	struct xfs_da_state_blk		*blk;
-	int				error;
+	int				error = 0;
 
 	trace_xfs_attr_node_addname(state->args);
 
 	blk = &state->path.blk[state->path.active-1];
 	ASSERT(blk->magic == XFS_ATTR_LEAF_MAGIC);
 
-	error = xfs_attr3_leaf_add(blk->bp, state->args);
-	if (error == -ENOSPC) {
+	if (!xfs_attr3_leaf_add(blk->bp, state->args)) {
 		if (state->path.active == 1) {
 			/*
 			 * Its really a single leaf node, but it had
 			 * out-of-line values so it looked like it *might*
 			 * have been a b-tree. Let the caller deal with this.
 			 */
+			error = -ENOSPC;
 			goto out;
 		}
 
diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index 51ff44068675..539fa31877e7 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -46,7 +46,7 @@
  */
 STATIC int xfs_attr3_leaf_create(struct xfs_da_args *args,
 				 xfs_dablk_t which_block, struct xfs_buf **bpp);
-STATIC int xfs_attr3_leaf_add_work(struct xfs_buf *leaf_buffer,
+STATIC void xfs_attr3_leaf_add_work(struct xfs_buf *leaf_buffer,
 				   struct xfs_attr3_icleaf_hdr *ichdr,
 				   struct xfs_da_args *args, int freemap_index);
 STATIC void xfs_attr3_leaf_compact(struct xfs_da_args *args,
@@ -990,10 +990,8 @@ xfs_attr_shortform_to_leaf(
 		}
 		error = xfs_attr3_leaf_lookup_int(bp, &nargs); /* set a->index */
 		ASSERT(error == -ENOATTR);
-		error = xfs_attr3_leaf_add(bp, &nargs);
-		ASSERT(error != -ENOSPC);
-		if (error)
-			goto out;
+		if (!xfs_attr3_leaf_add(bp, &nargs))
+			ASSERT(0);
 		sfe = xfs_attr_sf_nextentry(sfe);
 	}
 	error = 0;
@@ -1349,8 +1347,9 @@ xfs_attr3_leaf_split(
 	struct xfs_da_state_blk	*oldblk,
 	struct xfs_da_state_blk	*newblk)
 {
-	xfs_dablk_t blkno;
-	int error;
+	bool			added;
+	xfs_dablk_t		blkno;
+	int			error;
 
 	trace_xfs_attr_leaf_split(state->args);
 
@@ -1385,10 +1384,10 @@ xfs_attr3_leaf_split(
 	 */
 	if (state->inleaf) {
 		trace_xfs_attr_leaf_add_old(state->args);
-		error = xfs_attr3_leaf_add(oldblk->bp, state->args);
+		added = xfs_attr3_leaf_add(oldblk->bp, state->args);
 	} else {
 		trace_xfs_attr_leaf_add_new(state->args);
-		error = xfs_attr3_leaf_add(newblk->bp, state->args);
+		added = xfs_attr3_leaf_add(newblk->bp, state->args);
 	}
 
 	/*
@@ -1396,13 +1395,15 @@ xfs_attr3_leaf_split(
 	 */
 	oldblk->hashval = xfs_attr_leaf_lasthash(oldblk->bp, NULL);
 	newblk->hashval = xfs_attr_leaf_lasthash(newblk->bp, NULL);
-	return error;
+	if (!added)
+		return -ENOSPC;
+	return 0;
 }
 
 /*
  * Add a name to the leaf attribute list structure.
  */
-int
+bool
 xfs_attr3_leaf_add(
 	struct xfs_buf		*bp,
 	struct xfs_da_args	*args)
@@ -1411,6 +1412,7 @@ xfs_attr3_leaf_add(
 	struct xfs_attr3_icleaf_hdr ichdr;
 	int			tablesize;
 	int			entsize;
+	bool			added = true;
 	int			sum;
 	int			tmp;
 	int			i;
@@ -1439,7 +1441,7 @@ xfs_attr3_leaf_add(
 		if (ichdr.freemap[i].base < ichdr.firstused)
 			tmp += sizeof(xfs_attr_leaf_entry_t);
 		if (ichdr.freemap[i].size >= tmp) {
-			tmp = xfs_attr3_leaf_add_work(bp, &ichdr, args, i);
+			xfs_attr3_leaf_add_work(bp, &ichdr, args, i);
 			goto out_log_hdr;
 		}
 		sum += ichdr.freemap[i].size;
@@ -1451,7 +1453,7 @@ xfs_attr3_leaf_add(
 	 * no good and we should just give up.
 	 */
 	if (!ichdr.holes && sum < entsize)
-		return -ENOSPC;
+		return false;
 
 	/*
 	 * Compact the entries to coalesce free space.
@@ -1464,24 +1466,24 @@ xfs_attr3_leaf_add(
 	 * free region, in freemap[0].  If it is not big enough, give up.
 	 */
 	if (ichdr.freemap[0].size < (entsize + sizeof(xfs_attr_leaf_entry_t))) {
-		tmp = -ENOSPC;
+		added = false;
 		goto out_log_hdr;
 	}
 
-	tmp = xfs_attr3_leaf_add_work(bp, &ichdr, args, 0);
+	xfs_attr3_leaf_add_work(bp, &ichdr, args, 0);
 
 out_log_hdr:
 	xfs_attr3_leaf_hdr_to_disk(args->geo, leaf, &ichdr);
 	xfs_trans_log_buf(args->trans, bp,
 		XFS_DA_LOGRANGE(leaf, &leaf->hdr,
 				xfs_attr3_leaf_hdr_size(leaf)));
-	return tmp;
+	return added;
 }
 
 /*
  * Add a name to a leaf attribute list structure.
  */
-STATIC int
+STATIC void
 xfs_attr3_leaf_add_work(
 	struct xfs_buf		*bp,
 	struct xfs_attr3_icleaf_hdr *ichdr,
@@ -1599,7 +1601,6 @@ xfs_attr3_leaf_add_work(
 		}
 	}
 	ichdr->usedbytes += xfs_attr_leaf_entsize(leaf, args->index);
-	return 0;
 }
 
 /*
diff --git a/fs/xfs/libxfs/xfs_attr_leaf.h b/fs/xfs/libxfs/xfs_attr_leaf.h
index 368f4d9fa1d5..d15cc5b6f4a9 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.h
+++ b/fs/xfs/libxfs/xfs_attr_leaf.h
@@ -78,7 +78,7 @@ int	xfs_attr3_leaf_split(struct xfs_da_state *state,
 int	xfs_attr3_leaf_lookup_int(struct xfs_buf *leaf,
 					struct xfs_da_args *args);
 int	xfs_attr3_leaf_getvalue(struct xfs_buf *bp, struct xfs_da_args *args);
-int	xfs_attr3_leaf_add(struct xfs_buf *leaf_buffer,
+bool	xfs_attr3_leaf_add(struct xfs_buf *leaf_buffer,
 				 struct xfs_da_args *args);
 int	xfs_attr3_leaf_remove(struct xfs_buf *leaf_buffer,
 				    struct xfs_da_args *args);
-- 
2.39.3


