Return-Path: <stable+bounces-227624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EaoMr6yvWlBAgMAu9opvQ
	(envelope-from <stable+bounces-227624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:49:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B702E1034
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB08E31237F9
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 20:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCE0367F2F;
	Fri, 20 Mar 2026 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="TWT5FtOw"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42316364E82;
	Fri, 20 Mar 2026 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774039557; cv=fail; b=Txj+DX3EjHNcfiQwPqMDwe653GrtdP4sz78gygVm298/kWGI2/bC0ypZmsf0h3uuzIsEzxT1CKWdcHO3xOaO6f+mzA/WEbl/8i+yctbM0qtC6cCYhthaEPFdpxoM9QS/gYnhIA274lxTzt+1NFmr/oaFMvliN36c8LD47fQTI5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774039557; c=relaxed/simple;
	bh=JS22T2SaCFtHsqdAu8iNZ5Bsia2Uuaa8tiBGMkm4UJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PUzWAic6xlPVgV3DnA47lsz9jczMz6BeoF3+JmD5lmUY0hmLQcwuyumXo5EztMfSnKFYVWIRncQ2hPzn2vBOSoCdvwfBSXfMnaFhXCijo9n/dfyf5iFv29pnPsIJ5XBo0MVvkmUpMnZUujHQrrfr15j3LTUr/yuI+g1PVouPVYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=TWT5FtOw; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KFOC5w1789579;
	Fri, 20 Mar 2026 13:45:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=F8OZAAlvouFmjKKisE6b0HPmZXPRu9qKqYSQ9NCkogU=; b=
	TWT5FtOwexmTArU/YJpC+B+OrEz6lMyJtYp3B+cY5q0DYNqxWIvokHEZgQtwDW8z
	Y7zMq99GV94jOz9K9gAFEc3+uXKHupBrbJVDEKuW2uoQ+Eg50Smc66Lw7X60RCAJ
	Cf6TwpPHHAtiqnDe1mVrfqB0OhkpySYd4CHc0/ZBLcPZlp0JD/o2pUd1UwB46ocY
	vlS5cCtFk1kvlh/9SXIbt50m5N75rxjx7H9IwcAAOErjHXWqJ+368/0+bXyF70o+
	dN8gcxhq8yFpPzmeEZXVOC+lxEGzvKghQcBXbScH9lp0BAv5YutDMSFrPh7KCSQz
	qrpY3FyzbxxRpYgFEeHwVA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d18uggb77-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 13:45:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kS2Lka5UV4AM4qiHbUJh9CKLnULicOVkWp87sQ+ho/89gOJWZC+WfF46zi68ewxDRAFpWwBvRNJ1nTXPlUi4ecSFrVY8pquA1+DlpOl/kVhTwy5fGvhZSVLAd6ts8rQDj5u6D7SiJauFk4kSjnZzVzXH8pM5FEn7+h2P/6AZATVmFTEJQTQ3d+FRBESPAROsZJY87qrrq7O+2J+of8icRoxE1DXKsIOEh9v92fgStJZyXbFjBwPgpGs8BLybzik32Vr+K06SykVGY/pxjNjhSDI1ajXtUuaL4P6LQsWFos21WtC1IplyJKDNOd+kcf4kZm0HPeIOH6AMWHidJcoF3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8OZAAlvouFmjKKisE6b0HPmZXPRu9qKqYSQ9NCkogU=;
 b=F/wqehDuPtyNQfnH5gu0RoF8IjHMNYp1n9cnpPJIH9chA8ZRZzBO4DOOCtJuBZWE5V/Zd2oYntFCf6i3CNrNPvNcMHIYFoGGd4NXvJVTD5voVeXwL+WCDnezndkM253I2qN1H7OhcJHO6yJyaAxILngsimjR+9eM+PwnCI+3u5P7Zb+BUXa2glmqGLh3AhJwzooA9WDme1IechKriWHEpCqT1bFQgzZ6I1Q4wwYb6vW6ujeLdOnnsPXiF9GdCKTfwmFVPJPule5x6eWa1gNNB93URs3LMFqBKZZxSzqfSvv5NDbyGZaT/HiGRKuGRGXpdU5X3uNBIA3cvC8N8Zq7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by LV3PR11MB8695.namprd11.prod.outlook.com (2603:10b6:408:211::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 20:45:02 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 20:45:02 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: frederic@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, ptesarik@suse.com
Subject: [PATCH 6.12.y 4/7] timers/migration: Clean up the loop in tmigr_quick_check()
Date: Fri, 20 Mar 2026 22:44:39 +0200
Message-ID: <20260320204442.32901-5-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320204442.32901-1-ionut.nechita@windriver.com>
References: <20260320204442.32901-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0296.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::16) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|LV3PR11MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 237e3e6d-aca6-4e4e-3584-08de86c18f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LkFgn3B/PLULXJeCJPnhvtOhCp2x9fqKuany0lKw+OXy7n6AHtkytQrAKrM3fa/kyqT4nsJvqWyoQ5NGFJTs+8v9+DRH9PKeVBed0c0fluJw052APwiE6Xuehi8pLUEO9HmFMiDYMSoW9sZTpow+qZMAKwPmODEtUQvKTtN/ZBOwKG7EyrPqjgOTWXcYld1f1+NUJNGDT/srWbtnk6yaQ3AFXvqbOSeU8j3jhGEhv3ABECUWaog5xTPT9rJSKQEimjkuUy8XId7Ic6j0YKIUEobOoITfH29pC59GwSaIAm1jNAEulILR7b5XejjnGcE6cL4UGI+UaMNTQOAYH8oNaO7/GH1QlHz1+KNkd76C4KD1kQAzmCs1Z+/kXtQbANPJOEHG9Dy3aaelKNV4ziT3LgZ8oj7ybxqc/2fQu++Qrj2X6CF81O1AAOkaNOfscrgutJvzTxOWuPe2nnh5TJdP9K0WDMVuSWbArZQRMcC9uDdOT3aoWDzb5M+XSv3n+4sTZ6LVlOoXUukRkxcUvVhjzAbwofxqH2HEVDGN0TAPi5pT1BARiqJOOYZOJ288Mj+LY5mFgXA8e5LK/76RsfE0WlHH5GgAcf07Ay+h+tEhtu5ZlAAi/zW6LqC+IEubpkneoZ0t+eUTX1/nL0zbOB7pIPMMcwDD8RWqkEmQj2EouW7dMp66y0WGPiO9EN/Sol90Uq98OQyd/rwa38z7oYbopDY6FYNAMi0uBrfAg6fPg30=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HfCWKmQdhUvww3w/G+hHYyLyd/hnFpxyfpQ0UUFf5c0BGLZphZ4wDp723HdU?=
 =?us-ascii?Q?tgm+bW8oRfaJuldsCzIPowPvUQyIHSsGJEg2dFIx+hEq7CQ1mloNojH3Ah7g?=
 =?us-ascii?Q?ItNIev5cEa0e3kVfMHFzjk2SfdrYvgvd/t6oayvcUzef2D85EgyawquGAyB9?=
 =?us-ascii?Q?eOQoszjWCp6jFCfotjB8lzBsbbTRwHGn3kPvaSGfy+DXhZaGuyrtIocM54VV?=
 =?us-ascii?Q?w2UxGSArLLSLEC8WpfNoajx+hsF4uPeFiJcgMyP5+4Q6TIjWlG4nqJMBh44D?=
 =?us-ascii?Q?bJaiS3etywYj3m3AHBYfY0ed2dHJDi0f9jPrtiCJe/9rU0mjMls8eIbFuOSX?=
 =?us-ascii?Q?kwb8AH9V0dfNi0z16WOuR6K9QKCzGZKIWertwDIjyQ+Fz3dJ4p+roGhs2a8/?=
 =?us-ascii?Q?yniIBnfAi2zo0Uk/IMzRzRHLBtg4isgDbL/FIu5SZJubRhtLN3LLMyotn5+a?=
 =?us-ascii?Q?FbfFcx2fkdMRshyTRauP2Qes3y6zdUC1JvVEGfQD/t4f4iTL/ImYlUPndD/i?=
 =?us-ascii?Q?uQ45zZvdNCVEecGzsg5yuK+ClXqnEeM5U/RHYGixu6HSi5jn7Ovvalp87POX?=
 =?us-ascii?Q?zt8w1naswIlPpNo1jybeAjKqcZF5npGqGzJpHsrfSX5Pr32WIzyR+GWYWffN?=
 =?us-ascii?Q?kp2lVY3ZTD6xa4u5oFTlTNzjrhw4X4W7Ht0xh/mg8D0ITjFxeVufcOMXj597?=
 =?us-ascii?Q?qFdLMSUZXnQKRJDg6h+/Qc3hodNI8maMQ85HHhnKfx66baEFHZVu0Bm1lQ/y?=
 =?us-ascii?Q?BE1eywr+foLqq2vmlThSybx34XJQXzbYGsfKJeGFi4fZ7hZz7ym2nFlVyjvS?=
 =?us-ascii?Q?CCMS2mIjtL5LfcFjnIC9bSOMPohRMTFclTwIimENWuhYLG6enqWGmPbxh+28?=
 =?us-ascii?Q?BGeZA3CBC3ARKCRnqIvh1fnRpdvBld+3i8Ecm2i8spuBuaKKJDvDAj3eefCw?=
 =?us-ascii?Q?IGl8W/NC7QEL9B0bASUFVv83arjfer8P+HRBVVbqwnlMRIrxX+AH6sGbDVCN?=
 =?us-ascii?Q?aOeey2dNX+QYWnoSY4aNnMs0ulAD/ZFGqEG29ECQq6MfhHIhJnRnuyJKaWsg?=
 =?us-ascii?Q?hUMn0sV0u2MG6b7CMWhffwTkSH8Oxwies+sqx89Ma3UOUribWoi34PBF65vs?=
 =?us-ascii?Q?ITLkLrKR4w6k97pBA7IvzHHrqQ3VKLoiMS60u7P5jyVQtz/LmTgxlNpX2C0X?=
 =?us-ascii?Q?xyx4zhT3zIAYKK42xu7R5HjEaH4o9wM3o1ZnBgJae/xWi7CVfVPYV9eNcmuP?=
 =?us-ascii?Q?2jAZ0ZVL5fZfdDPdDFbHFdMZs3jD6ejSX4n8D56deT0wwGDa8XZUj/wT4uw4?=
 =?us-ascii?Q?ftPRRSGLafPd54Vs8iBb0StUb3FuX8NIVxm/5cTTrmtU5RAqKArS4EinDNqa?=
 =?us-ascii?Q?dDSosBvVQxkddaSOZ0+cAVcKxfqAhACTss1zC/xHHebCGYE48GpE9fB4ODvc?=
 =?us-ascii?Q?CmeGpnsdkm7E+D4hELGhs79J6+fcSpIrB9jhgds7DdvblCPuEf4YeWcLYEGn?=
 =?us-ascii?Q?Q0NbDB5bjogpC0lpkhmo9UKiEkjEKZs+sAe92VplQXHreAlkrXE+xwfkYsqL?=
 =?us-ascii?Q?8DXuWBIIz6E8nTGwO1DqD2d8iJAqJse20ods8twlKxmUCpEybKf/gL8tC3JU?=
 =?us-ascii?Q?+1Jt+WEZlMS8OUFwu91jkzWQJXzzsyV15H+7VoGF73RpYHXnfQ6KRyXUHV6S?=
 =?us-ascii?Q?XUzgw+WUfzMFy4Q1wUpxCfGNYhgt/BIa/He+SDBQe1Sh4/QRWsoyNhfVl21V?=
 =?us-ascii?Q?ZFis7HPPY3R/Z7K8RxnqNlpTbOAXKj9rSgfmOvW899/dviZeVsbxCKvGw7rN?=
X-MS-Exchange-AntiSpam-MessageData-1: XImKeZ/oRu4yhK2o14Ymo06MBdRsR0m3AW0=
X-Exchange-RoutingPolicyChecked:
	MtYsYgcysGSUcVC+srVtd/NA9ef2l+1bGrNLGu0feiblQN4W8R8D/0/IxDdtt8jRwhOaYqA/+UvNXIR+8w/pqYK2MXRRf/OO2Yu/4dryrLQhJGA/6yD+hU+c1CahMp0olYN4XXT4vSwEgLw6r/l8dZ9l75v7hNlZnxzuHaTNo0Rg9YzZZ9k/+99y9uFNXwNd27YTWoRPeeAr8XgAXd/tT9+eUTDwqW8Oh9n+Kq3k8a6L5P0Ph1eJzN0yEks2nIuwaJqxyZoU0CADZ8X/4IW4sUnIBI/frYJUwtJd35Wr5EwWG0J+ab2N21+MklB4MwNyy87XHPUWGep6Z+VWSNTLdQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237e3e6d-aca6-4e4e-3584-08de86c18f1a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:45:02.2109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28i163DFFojxnDaE8akfifOom0ZkUIKAug19Q/UWMzhanxs3UlvD9oc8JjoGm0wx5Zi0MLHtVaoveeAeBRp2RLhs2hhZUWxfXaKfdIP1qTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8695
X-Proofpoint-ORIG-GUID: E9OIpapmCG-SOve95F2yUeccf35KxH4M
X-Proofpoint-GUID: E9OIpapmCG-SOve95F2yUeccf35KxH4M
X-Authority-Analysis: v=2.4 cv=A89h/qWG c=1 sm=1 tr=0 ts=69bdb1cf cx=c_pps
 a=pAJzO7k5KbwWJfk/IQaIJw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=VwQbUJbxAAAA:8
 a=iox4zFpeAAAA:8 a=TxSv_89OuFmXkGjAIxcA:9 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE2OSBTYWx0ZWRfX+kmcllsjtaT9
 3ehX6xTkq/r9ZmJQwFQ+NOtCy2CkLZzN6TNLL2BtCJUrCyx4aAXn4DzFAAUA+qLrZLdtYKjkCVK
 kJm+cLskU9n1I15qc/TUdjD9l0skL538ELbvgs+NuX7kGw/7sGvcL9rPueCGtaz+/AhkAcaZiJY
 yBCbBy3f+uh/Eqd3xPn23PSDgaLNRHP233fdedKaMI463hOTFCe3208t7ZMWEiKzoqKzKzoqdog
 LHTQglX2ladrbpqkyv97SRL1vdI4TYO4fygRjHPq5pXKZjKLh3UcJjNX/uZ703kuXJqBBYFzWlU
 fIre0yawpuErdNOfiQ5To5jkzRUCxCfeVruVb01aj6vC162uT7oaEV+XhLWNAuNaFi+KNTaEkMT
 TDKl8i+FD9zqoV/ygRpgr58CkmWoHRQFOjV6yC2fdDVFkiM5G42KldPkL0kneTBYVNjpVih70q1
 zaWA9DM4umvD1H+/QFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200169
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227624-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,windriver.com:dkim,windriver.com:mid,linutronix.de:email];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 47B702E1034
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Petr Tesarik <ptesarik@suse.com>

Make the logic easier to follow:

  - Remove the final return statement, which is never reached, and move the
    actual walk-terminating return statement out of the do-while loop.

  - Remove the else-clause to reduce indentation. If a non-lonely group is
    encountered during the walk, the loop is immediately terminated with a
    return statement anyway; no need for an else.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250606124818.455560-1-ptesarik@suse.com
---
 kernel/time/timer_migration.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 2f6330831f084..c0c54dc5314c3 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1405,23 +1405,20 @@ u64 tmigr_quick_check(u64 nextevt)
 		return KTIME_MAX;
 
 	do {
-		if (!tmigr_check_lonely(group)) {
+		if (!tmigr_check_lonely(group))
 			return KTIME_MAX;
-		} else {
-			/*
-			 * Since current CPU is active, events may not be sorted
-			 * from bottom to the top because the CPU's event is ignored
-			 * up to the top and its sibling's events not propagated upwards.
-			 * Thus keep track of the lowest observed expiry.
-			 */
-			nextevt = min_t(u64, nextevt, READ_ONCE(group->next_expiry));
-			if (!group->parent)
-				return nextevt;
-		}
+
+		/*
+		 * Since current CPU is active, events may not be sorted
+		 * from bottom to the top because the CPU's event is ignored
+		 * up to the top and its sibling's events not propagated upwards.
+		 * Thus keep track of the lowest observed expiry.
+		 */
+		nextevt = min_t(u64, nextevt, READ_ONCE(group->next_expiry));
 		group = group->parent;
 	} while (group);
 
-	return KTIME_MAX;
+	return nextevt;
 }
 
 /*
-- 
2.53.0


