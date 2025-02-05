Return-Path: <stable+bounces-113967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794F8A29BF3
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E173A79D5
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A336321505F;
	Wed,  5 Feb 2025 21:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C+N0FKxA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ys3TpATN"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94DD21504A;
	Wed,  5 Feb 2025 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791635; cv=fail; b=fvx8vuvqL9a+AEm3ouQOakSSGMqdEWhk34IOfQVBYosq+rz3Nw7qUASVLP9+vVpKqJW8p8c37rhoQcFjKWy3Apx+gsDBYog0Azw2gZlxxLYfHaNV8McrY31TzLPLkFRU81odnOYDW09FZwHe+VNkvAIPmfG/8EadCuktC1Z8wGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791635; c=relaxed/simple;
	bh=9MYSY0h3GgWJUs8mKg7DpBnrZ3qdeo4CUHCc1pNQEfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uhUUog62D0UZ2Pl/ROZM1x9nCiavcaCXfh5tPaDfH2V9mh0u5zS6McnYmhaUdKQJykbyNr7Dg/ghEkOC9n7mfMUSF8BcVlmNinTuLfv/HWRsqJja8PwuArfJgclnrqEjwEIrC1ZQpJTDfM0rBmMB48SHoSVaTM+FHTWL/FtZEso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C+N0FKxA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ys3TpATN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GfpOs032330;
	Wed, 5 Feb 2025 21:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=u2hYBs6IwO/AbkrdDjmwTp8trpmAlzmS0WsXyfxShcw=; b=
	C+N0FKxArlqolzP6hffmtH0VmpdMv8wE6NW3f+HptL9RRywMTyWRZBzC0faXkD8p
	ZpVtF+ghgjE3FF4VX7NZl9Wz+VVgal1OFif7MS39jAm916ovMtrm5wfbFOREdZDl
	NRoQvjm5kKZqwe75Njp73xJNt0tr0LjLiNUMPWnw5sIchMkWFNPPWe8pbjPeLy4z
	BK+6CodiFCKD1arxvPrVoxFAo+hy+n3mUqSqKoDKKjIuM/3Jxdjvwl6Vb1YniNO2
	U8+Mxx/4zztmaeko5c0bNKoYGtXTJwUr3pbyQYCgiWzzkQBjclp4iT04RQou0ob4
	WFQ8A4DZPlJfRlyEo2iBAQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhju03rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515LboJo027088;
	Wed, 5 Feb 2025 21:40:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fp5a46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCEfHm47V1VrVU1sks5AVqFUBJjiTs4XKEloCCDzY7kfXv1aXTvJTEs9VmT+ko9U4mSI/Nr3gyOoXHZDOctaCeV9rviUOv7beiRANGPgBFodudBrA89rI5lO9djcXiUdGdZI4el4DAF/izYrK6f1COM14WolJSSRwE2K/YDEBSy1ttv4HE5Uc7yqFHP1cOWILsQcWXW4GTQoEwBuEPw9kUmjuOB/hUuzXBXJ3lbxxrP8JVgvq5LoHcnRTFn8rJumXktrHgfRPt+8tlO7ap0rzvao01klL6YCkxjhmHzfyE6mdP8da5cDXX1x7ryu1ns6zose+Hx9uapCv3kda/3XdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2hYBs6IwO/AbkrdDjmwTp8trpmAlzmS0WsXyfxShcw=;
 b=gLcxZnL6uatm2NADlxI0dgOZZOnjGQOQlboADS7W/iHAQjXtnnX7K3OhbZ0tohtFUeNAsEd/U2aHHqvB0svBB4IerJ7T1uthWw/3+YXNE2wZX1ADuWwcR6Ecy0CUXFfLguJogO2Y5TWCdLE3cFBMpItOUmsEjfHGqIiDpF0RlPw3ejyK1boCBA5jbnYUxz91FGLBBZjL+O4bZC+093e0PCmL3FLrgCtb/FQp10A+xz5dlF1ueMcBYdM18moiY20RK387M0vFTZEYqQjlmBwzIMDcqpEkiV2L6XyE50Q6vMfucOcrdjxN7AZcQ+OrcQdL2jTSVnTKKLqzn/QChI2oXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2hYBs6IwO/AbkrdDjmwTp8trpmAlzmS0WsXyfxShcw=;
 b=Ys3TpATNhXXLowQ6D7f+xLyv6z5sjlhYUX5cUXItXIv1aqTlfwrzA+AlOZIzM309qgYWEbvO4UqpqeQOo9H9whpFn2J+mTglsxAPmNOc1/EJvpHAabQbYusRfNmQrDWwlEouVJkmyy2lpd4tJCUHgoMiWRCGR3BSzmqBUz6T6hw=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by MW6PR10MB7637.namprd10.prod.outlook.com (2603:10b6:303:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 21:40:30 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:40:30 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 01/24] xfs: assert a valid limit in xfs_rtfind_forw
Date: Wed,  5 Feb 2025 13:40:02 -0800
Message-Id: <20250205214025.72516-2-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|MW6PR10MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 371c1ca4-46c8-484d-505e-08dd462db614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZMFEiftJEiTW1/CXIYWVUlHtmPCVhUdmpswCz1NYQo5TCtFi7Zy+QasbnpuM?=
 =?us-ascii?Q?Zp9xk4K+Tq3g+0sxaaXFUu7TVupR70KCWU41Ei8zhLMQLU3loxhrTBWQjjRi?=
 =?us-ascii?Q?EytKvmcMphxVJ4AcZGlPLWNEBnFS7EgStpgh2SI2rhuOFl5eJAcNKaF93ASG?=
 =?us-ascii?Q?V0KT0R5yMbaHx31AVPLHnxaU545aSagcsdc88TpwVRolsmLhDtPziEnXr3GP?=
 =?us-ascii?Q?IRj0P/aE9PLV/rx8x1UNixKUVWiJ5mN60UxHTow8cvbf7ZUFmCIoxYRZTSnc?=
 =?us-ascii?Q?pbL9pAyBph5dkd4iuM5VRpppXAYrvAdFWFwJMrUXCqEt/2pers0td89RJ64z?=
 =?us-ascii?Q?V+M6vuCeQZ9Cwj7bMf3zIGtAJab0IRLCxV0jXGJSV/m7f2SpB7mdVdWLJ5wg?=
 =?us-ascii?Q?W2r33yVfnwV5nndeNzk3JZcwoex1XTDS67RPJPWTXsZh/HqXho6iWEp8y52J?=
 =?us-ascii?Q?AFAxjYIDBaQZuxmhEBLxzpHzuf1G+M2SuaxXqWuAzpMEbzpOE1jC5Igz6BpG?=
 =?us-ascii?Q?m1NELECIEDvLYtzfJgNyB+IUsZTzrTfCkyjFJiGGBcpUVx5TM+NTt61QQElG?=
 =?us-ascii?Q?uwT3rgEdF76d3LtxWsN67eIOczDOn1f5qAqPcG1En9ANE540PDlDSjHwMFi2?=
 =?us-ascii?Q?qFys9ChWlGCVIyr0UtbB2ZkZKjSywHV1S7D3r9nxg1THH1mkIRQOlRpoudN+?=
 =?us-ascii?Q?WJ+IS6RQg/3Q0fKHQKD1hg9DnChg5f+mqM+A3vUGEWx3bqn7HUGtsEYlQ1rV?=
 =?us-ascii?Q?tZDhP9w+IzWrrDEXpUgrTuxJ4Ha0uUEXeezXcvoHYwB7ctth+JcQWoKcMJQ5?=
 =?us-ascii?Q?As5eK5wHuOo3E896/6a6NSIIfti3NsfqSGj/xs7IKQnk3Yr+ZUkxNG895w6R?=
 =?us-ascii?Q?CadFpWcQJHb+bexAtuFv/omy/6lhIFDLqYkdCX/fmNGiU+CgtHkjUDqMEsBW?=
 =?us-ascii?Q?k29p04Lg0Bb4t1zfarFKC0BJZVWuzQFetdMInIscPYwt6+K5l1A8M3ZxxVxC?=
 =?us-ascii?Q?LwoZn0DJtF8Z8lVh9rsvVv6my3zoNev+f27gl+3dD3LT4ciGFwN+ZTBQCoUh?=
 =?us-ascii?Q?Z2EOJlKyewvIAOlLFLRdHRHw40rfOhGW/WwzZvd+Kz+ME4ZXgLoXpuBL7UPs?=
 =?us-ascii?Q?uJz0rduv/QM0+ggqqQMno7SQJaKEpoT2NoUI5R8NQh7mUuIgX02zGc8EpOZu?=
 =?us-ascii?Q?3E2r+TdUlmPZh9dbQW8a1DbaJbhh5aw5wYGcWZU92bF9L39i+mTv7Hd8Cvgi?=
 =?us-ascii?Q?AWjpma+K8C+tAW64fmmrds7ca+ACPzqkJ3DUOzxnd7sp2JUnpnFHjOCNIwuU?=
 =?us-ascii?Q?epP0eVQb/uLTJlA8Q5q+cl6MWQz095UbaKl0uo1+5foFSQ8w8LREysqCaTtC?=
 =?us-ascii?Q?voDV+gSmDwKeXtkzdSNnu6N864gt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BPZcIJKzbT9We2x+0wPeS7YLrq+P47twfGmRmgItvLKi0jLMH4eiPLV22ac9?=
 =?us-ascii?Q?WzQtn4SGKPrNd8NdnMm/afvlhUkOPl/VRmdZkQgdrbmWfXgqG7nMdmjwP3iB?=
 =?us-ascii?Q?7KE9g46s9MgwXQA+VmQpgkwtBGRNKJz+lFPbcd9vCX2j7yH83EJuPHBLPqZt?=
 =?us-ascii?Q?pBv1TnvGQBiHCjW0f/3/KC+8adWa5xA3cCDHX77NtREo7Kd2noThXwoxG1pX?=
 =?us-ascii?Q?Hv3rrZzG11xECZUkZRyaLpn/8wSvuwD60RNXT2ofP4FHc6Zsams2+ASwQXzU?=
 =?us-ascii?Q?pDLTpwiOWuzBofODGx5Y5kUeDequXeY/q4A20j6XnmWKT7I9tiUfrq/5EYxa?=
 =?us-ascii?Q?xiA1BZJEdw2UGqf92L3EtN5My7o23cuY8tQttBGqXJ0ZcXX8yC6BzsvzZAaO?=
 =?us-ascii?Q?hdYkwcSnI3ECsJBCFoA3JO4VmYlcUU5aFgG7OUHEfFY69lwswtm1+ADmMypa?=
 =?us-ascii?Q?RFj+nDkdPbQYbgVa63Vr+td1OIDJOrzJDmqx3Yqy2mPf4jhME0jPUzlt9sme?=
 =?us-ascii?Q?zGfkihhU+PU4XSVh1weyhXHQhBOAKWlhUePY6i2lEUa56LSjIlp2i46SF57Y?=
 =?us-ascii?Q?WDGZNaGIkFwtI82KK2ZLQSg++fzs48B/ocPI4UzJ0HslJ6fmP+3QYVYUWNrN?=
 =?us-ascii?Q?evuehKLO1PJIDfTTXVrCKhcYfN9kc4sXJ3gUrd+EF6fc14P9uMTiGdHq8IwB?=
 =?us-ascii?Q?jBwu9SFsXfyzsY42AWItoNPYVpBTMqZtJneQJW9oftZm/lkZ5RSewXrtELou?=
 =?us-ascii?Q?TWe/ApHbrDSpi8qvnOVob35rdglMzQYiY666a6l+yrvznx7Qed93pU8LX1Pg?=
 =?us-ascii?Q?jhAIdYoVVMmj/FT0E1GKEZq3GSv/Dw20r7Xu/TiVY/jcS/qSG8aIiehCHzTf?=
 =?us-ascii?Q?ET/Kv5kuH0K1zGZXIRRFmAHo1w2yytZMiGCAaw0R4JYupDi+Vfl97VJZwJhF?=
 =?us-ascii?Q?Cshj7+2abMiCpVWqmXaEbW9wKHR3y6BdGDV47CvNJWQx5cn3EJKaeQIsNX/Z?=
 =?us-ascii?Q?Vi7AtJxCNYUdnczqOxhGtFKa8ff5kIkxXwiHUHLAfvVus/q79p83zdZNZAuL?=
 =?us-ascii?Q?tgNV4FBHhzLhs2w1MFmVjgOgVfTl5yCtNDxj5/9t1mleufc4yoWZdRN9T2ex?=
 =?us-ascii?Q?KOArvFSvaok+t16Sw8Bw9uEiZ2yBel1u9SsOEwzMqBTyIE3NIXKIOGg7VDn7?=
 =?us-ascii?Q?pwCBnbGecC2Kr1mXmeJaOS2w2RL2tq2SVVIHlIPYnMntyhXQnOYBWjCTvQrZ?=
 =?us-ascii?Q?UO0Wcyu/6XKVzI70ET7U4PQZKIsgpvOcAGX90W1jkz/OEKGh8+maErh0P6tM?=
 =?us-ascii?Q?Ccylq3xRdChE+NRkKOtI8ZTXm/4RMF84yEJX4FRWp2JmAeeW6kRBn5IwDLl4?=
 =?us-ascii?Q?7IcVGgIHD6BHxnRoHJSQF/OLNZfIpGVFlZ/zi92XBOphN8IYDPyuNaqEyQQ0?=
 =?us-ascii?Q?o8gQVvhNgJ1nJIAL0gV1dIRXOEbStSuCUWzw49kQS2nFgmO8+vkGveM4M6of?=
 =?us-ascii?Q?2p8o5Yi2b0hI1LOrHQ8GaIReyIyhbD+XqQV/FtuGn3Lc5NHyEJQHC4MVaCpv?=
 =?us-ascii?Q?7TagosAX8yruC37u/NX8BnehPBB36THrCEwiQZd9+Lr+MMFnZi+oRBiDnQTq?=
 =?us-ascii?Q?XKw1qScDJdSne0OMGbA9D+t32+JxXd1yUaONw/kZysqX5fakNTHOyh4XmJNf?=
 =?us-ascii?Q?yQD5Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z2YcPtJd0DDCLmF0d0bhIzcr90PB3694KgRrHIhcbrWS77qdvRp6ZurZDrqnKFz9Rq+wcq9eqpttfyBvHKaNbVjSuJru1vUyaADUR0gGYQ4896i9XfTxWb9LkQX7PQdNEFjowOyGPobcQ25qfKV7PqHqsnzkDeQjFv2V+F3bG1D76k+/MxY+L34l3W5l1eK+gXqR2HtV8Z5BqqzwDs7kGIv2QU2Yty0tH3HWuW6WUeoAKQCQcA0UYoaGB+Al8zjFiULP0ipeEMgqgLu2V4p6A3x9d+4tB2nz72ROInvxH2eZiL68rVlsXKgxbCuR0ZFmSA6pQZ6pqILtVV/SxZ8Afs6IpgkxM0EBZJ3ugtFkvrd+lbluDidHfHQryBnm4a4+mhAmxv6MeCnb6YXX3o+e0VpxG2oHkbcDO8WeL9cooqu21F1opIbzpOFM5JpEKmJM1f+UGlp2lpCqsLG1vvkFas8gVMr0KlRnNW1+0AGGZg6Y+gJyjlJBvUfqxOMQHLhyPnDcvIWFAy/1YePiQsTN5agxu6EjhBIxM19DNZULy46lZrBoUA5/n/YlGJ+w+X3uPF4sG+REB0kdvDO11NClF3ODpRD6tI+6qrIFQiqA/rg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371c1ca4-46c8-484d-505e-08dd462db614
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:40:30.1532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Is0YTFhI8nLE0fpVxSNM+PF2SCH+9h3Buvpl83jFMassPesrNG28he7XyKCEmztjhRLCog4EPTLOuBzrRMaZzwefBQLGJUssK4y0BNswTDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: HWXBRrJhs1Rs7faetFpQjCQy9AAnGQx7
X-Proofpoint-ORIG-GUID: HWXBRrJhs1Rs7faetFpQjCQy9AAnGQx7

From: Christoph Hellwig <hch@lst.de>

commit 6d2db12d56a389b3e8efa236976f8dc3a8ae00f0 upstream.

Protect against developers passing stupid limits when refactoring the
RT code once again.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_rtbitmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_rtbitmap.c b/fs/xfs/libxfs/xfs_rtbitmap.c
index 760172a65aff..d7d06dc89eb7 100644
--- a/fs/xfs/libxfs/xfs_rtbitmap.c
+++ b/fs/xfs/libxfs/xfs_rtbitmap.c
@@ -288,6 +288,8 @@ xfs_rtfind_forw(
 	xfs_rtword_t	wdiff;		/* difference from wanted value */
 	int		word;		/* word number in the buffer */
 
+	ASSERT(start <= limit);
+
 	/*
 	 * Compute and read in starting bitmap block for starting block.
 	 */
-- 
2.39.3


