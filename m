Return-Path: <stable+bounces-113966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F8BA29BF2
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E8A1888B5E
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C154723CE;
	Wed,  5 Feb 2025 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H6gPhHxm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x5h43rCQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B7D214A96;
	Wed,  5 Feb 2025 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791633; cv=fail; b=o6d8unt5ArqCRe2ggW8+t3XQxG1trlSKFOV8HPgWf0PNKjiRA4J0dgTu+9c3zya88UH9E4CoJFAH+cO6+VeYulM8qkXfDHztSXiveqdnX7iaf/XfABnAmeeYBcIVdtj0N/2BbynD9gmTP/OZ4tgnUzorRPXSiiRpe8l3Ph7TnC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791633; c=relaxed/simple;
	bh=IAqx1kHl3uFTDo6yo+/Z9uKGmsjlxDd/9kn46R1Hj+8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KIhwc7v9BDut58FIiaFBAGt7L9H2fdy7ijonjWR6XGkDMChisBSpjfMqOVZ+ecReWcljJkOFhZZTlqPYQhR+mx8MB0REsifFBY8oPdgfXA2J9sWmG/X+oO/7MJBatTqRb5EmNcf6/21uRIp56iX+Qq0rk3/tGZjmwg6gGyYmihM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H6gPhHxm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x5h43rCQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GflW6032250;
	Wed, 5 Feb 2025 21:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=4nzZYi6+FvucooJx
	f0OT6qD/GLlPH5GWiv/PKzRbyXk=; b=H6gPhHxmny8VkTTvH8y5qIsZQAK0IgDs
	i/zwaSFgGUWM3xD9z87FePGboEDSj7IVdAirbz35OpBvJztAS0PjSKTLsQSujsmJ
	9Y7ROwj3miG4vQ2Rin+GFpQvGvt6AW/ZXEp7i6oo6riqBhJ8FDCtSYuE8IPpS/4G
	SrN/8t3zszDWPQD8p26azNohZW2MLKB6R1sy0+SxDEr865Z11Uu1ZOID81qxLmjX
	WeStwp7dIXniKCarTk02T8yf7G3h9RGOlTCTNcwbkVIzxPfH3S4YhFEmfsBu5MHs
	mzU/EAcdIeqgbu6M4DAKdOt+YKa+lQF0W+GxjhfghUTOjnrSnInY2w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhju03r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515Jxgw9023528;
	Wed, 5 Feb 2025 21:40:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8gjweaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teztKWU64Unz0A+dDz0AcIs41iCid2YXHNwo7WNC1suUlt9HY8JGnHYy7s4SXBMftmV2bMLr9T/Qt0aROoe6mhn2YSbEWfoYlgCrh16DDmt9smnV77ICUlz+lUykGC766KWE6z8V5j6vsD9DCPQ9jeOamssn09MVIR5PNYrGXl3/mgstMo69a74f9dj4GpXlPmaLayEGUzb/Pg9xDdRJS5ZB2rNam7/wN5TxWqurPbUz5R8xj+gOn05voNjmDHX/w6LyWugDINfjVeweX2kZ8sRNRntLlX6iA/oLQO8+xKEcFEFDWfl1H+BcRGD4Ayz80eEbCkcbLYQzcw9KuGO0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nzZYi6+FvucooJxf0OT6qD/GLlPH5GWiv/PKzRbyXk=;
 b=CRZjgHRheLkpo8l0nOamqilqvuGFfRcCmuMN66MfGkOR4qq6i/lw8FKW3QO9zLrgifztGYQ1ORsMdozDSyBND5BOG6/LMyRJRI/GC1m4cigwkgu7IKoujjYBtP0nWvLhFT4I1LeRRbTOg6DN/ojt2bz1JRQArryBETgZjIFqrKHfYSjlE9+o8IWxhbiNZtMeMKZplqe5jpnT3jTqcxHn4ir1aK7d+mQpM4xTrXo5fw8OK+LcHgYBhgfLozYjen96Th1Jlwf102fqyObIpnhuz6OaqVgGmKNR/pykXphld4fwzXWZBzdVn37Nho2fR4h9gxaL3n+7bkzvPwshqtIecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nzZYi6+FvucooJxf0OT6qD/GLlPH5GWiv/PKzRbyXk=;
 b=x5h43rCQA1b+XQYCAGvndru6CexJqzl9xhBW2Yysg6+R8TChsEbEITtg2HxauUPDFY9uyzXQlaa/uCNW+5SR6xiR5rE24Bdc4l67LWf+4K20EpI9fuMK1F1xIxY6lvWM4wYl11ixFr3fEfxbDKYriJ5G9QZfDWjiUDv7hK+Hgv4=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by MW6PR10MB7637.namprd10.prod.outlook.com (2603:10b6:303:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 21:40:27 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:40:27 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 00/24] xfs backports for 6.6.y (from 6.12)
Date: Wed,  5 Feb 2025 13:40:01 -0800
Message-Id: <20250205214025.72516-1-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::24) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|MW6PR10MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4aa82a-c40d-44fd-e45e-08dd462db454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7RiWVsqcmLdp7eskM2IFLsqeufV2XuRXX2YxQcD46k+9SKk22BTyOrib9r7l?=
 =?us-ascii?Q?Bh1SAP5WnA3kl458M4pR+ddeoHZskrdHcm1x9OWmr3JN6ePVuYAkbsPpZ/Au?=
 =?us-ascii?Q?YXwbUYs22MM3ybnA5bqXhHOOmDoNYttp5pTtDko8aXkYNCXPNI9p2A+tZbai?=
 =?us-ascii?Q?fSrKUTMcVrXPNZAI39jGUe7kEndoxQw3xIXbHHj+kIeNiJ5PQtMt9QpnZIQ5?=
 =?us-ascii?Q?FehzArdcg/O6l2JxQwke5AoUu7PXGVDspvDuCaASjsTAoSU03ZHnKTxv9uZw?=
 =?us-ascii?Q?sUXnVsH9YNP7bxTojlCEqP+K7kz/DDHOHiz6gTpVlQO/DFoLsGytrR1tH26S?=
 =?us-ascii?Q?0E0aP8bVF+dhiyjm53ouHHnyRhptdSGDFCggkqcehFOfuzcAfusFK8TYjj4+?=
 =?us-ascii?Q?swVH9XwiPjNWjWKIDfTmgkAqevL3a/M5ugSMqSOCaaO/BN3hG8Xpv0Wr5tGA?=
 =?us-ascii?Q?/RPkP8BKag648Y0qcQBqvssJ4D2efPBxuqtGAlRaQe1v1HuW/StfYfPO1IhT?=
 =?us-ascii?Q?2xX5bOgJkkqOTZKxwT2xdyNQD5dNisIDZMFrScPw7eKUkukyBZ2c/pN8bHwR?=
 =?us-ascii?Q?QDJ+qs7OQ/oKt6TwbT+1DweX+cmfpcrpUFdCHKuS0fJcIR2Q+2wKsgg95qNv?=
 =?us-ascii?Q?TkdBkD8iQgpv5koROje22u3ueR4evr6wU0h6bv2SPmrx/shJ6Ar1MenLcgPV?=
 =?us-ascii?Q?x7/rtLe698inYKyqvU7ZPzQlSshnyrmxy6umTiU1Ne7EQHpildEzZ4uRrFM/?=
 =?us-ascii?Q?x+cr5qgxvMHy+525ug0aPJbnUlam/83dxCuICO7da8M8gcrmdJJuGdVOeAbm?=
 =?us-ascii?Q?556PQ8b+FYanzAOCV9akuaOMuX0kTV3+yVPEQQEcsM0ZIPXTGi94+AoaLbxJ?=
 =?us-ascii?Q?7wU0lLaxePpPPejvqlwx/yoSFHJkVahuOvJvRB/yol0pnmwG5cZg/I0NTDKs?=
 =?us-ascii?Q?9OFGkRkUfYxHye0+Nx2lNiCbb1FHpaoNeFb54wpiu7rliVLzwrtfnsWqMmDM?=
 =?us-ascii?Q?niiu8dQIX9N5axOm9W2vPa2QtKWFc2pl8EO/bkUuK1O3niDQC5pDgGIOP17F?=
 =?us-ascii?Q?/+T9TsgbWwHmiG5JLJ+MMJWSEysGppRq9VYDDo9n2m7F7MhaGiykEXAttaS8?=
 =?us-ascii?Q?FERN069pQgdfsuDt6gFUJ/ekPEL/Sa6vsG3Wuzz2cMpXsK0+4RTl+vwd+6s8?=
 =?us-ascii?Q?y76mSuJdcfXIV9/BhPwD1Z3gsOSpWEGPOqYUXlqk4Bbutx53ruJAnNczZuG+?=
 =?us-ascii?Q?pydIftKnxi7g4bvqtbg/SPuqqHkTiIouJ99eypCoTQSPPJyF7mE2hpJYmPOM?=
 =?us-ascii?Q?O6jhCRoRvjgBRzZwcwOlgxqaSBnTfGj7z8TcWKbwtLBm/J3ul4/6x7KIzuui?=
 =?us-ascii?Q?03KjOEQ5CR+bnlrDbaNtllsmMxuY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J9d2trz+NoPgMzun8ECPWtu0OPKvLgx+o/jqhgrnlDN74oAhx1GIsjbj6tfJ?=
 =?us-ascii?Q?NTibWoC/5hSORSyfNEKk0Dn08L0df4821bPXQlbxdMKUZiRj7yeSVOHne2n/?=
 =?us-ascii?Q?wiUJ5ZAZe68mKQng97I34qLlvJut8FvOu4rmNuwhB9ZOGhx6FqeX9vYZlwyu?=
 =?us-ascii?Q?Lja+k/ghnbmkkvboeFNLAIwre2+pESAWYTXaZv8TYw9e5YTJQjYphMKQPRZ6?=
 =?us-ascii?Q?fzMD5UtWgiwtvGT/Kt2XgY8BsVfsVzhpN+IEWLUuDDU1agxqxC7TicNie981?=
 =?us-ascii?Q?gWjIuS7p6YxnngvnU9WYB/USBrf/sXa8IR+8nZ63QkaGzwiluhT2TmOWNcmS?=
 =?us-ascii?Q?Da/YV7Q2+FeeAyAbKaQJiz+SPZ+6o8zPPbGTkeOAo+tYpGf30oG56qRrX7VX?=
 =?us-ascii?Q?8+XviU8lpzWeqZnqiM+aR1B1Na2RS4p6kyj+E4XwT7pvKz8AS/xK+Z0j3mBU?=
 =?us-ascii?Q?e6u3eZ2gFcAtNN6MwxhXJmFeUjuAxoTslg8iQxNreczlFAQF0r9mnLOFQVDw?=
 =?us-ascii?Q?oqheJaOzMiS81X/xLnNbkXdS2rs+XhyBOEwF6wCKI+X7pgZ2hV9Ql0bbTpU2?=
 =?us-ascii?Q?oEmcTfHbjQqA266RFbBYwbpTXRLrqlyZ5UH5pAnEoZ/8ewfXt14rcL8Z4smP?=
 =?us-ascii?Q?QlXBs8Z9PAQqtY7JPYUWMviGegqmhP1ayuFX/89uCXYUaugY9tjpDLdjNGgw?=
 =?us-ascii?Q?cq/mnD1T5c5rVb7HPwLhBrmEIE79VjKVn43Ahtp4uxrIM3uq0khixPI24t+O?=
 =?us-ascii?Q?pHCLkGAYdO7OaPeLbNZSAlJ1IPC0tQez8IKmpAeC4vG4s9Ktk7FHsLmqQGfl?=
 =?us-ascii?Q?GORZ5V6TYIBOaV+k9MHyTx4pNv3ykPnxPzORQfF0BMW+K5g82l63lMGN6nZt?=
 =?us-ascii?Q?mHRFdyWcmpFassIIz4SmHNlJ5J84rs8jHDYdmrolrzhKmLdc+vJe/V6zhUvb?=
 =?us-ascii?Q?H31wLPDrrOWc1WNjZ29YUPRkr6Ke3nlJugiFA78HJ7yxi9aE3wOW8Ev1JMxr?=
 =?us-ascii?Q?pVotSW6tiw6m8fz4i/OzyrRPvWt1lIMpHLSzPj5lSIQn9D7M1zFwtMH5NR1Z?=
 =?us-ascii?Q?09DsruerTZYGN5W12Ok/F0ewLmGM5gdEbBRyRTg70BX8eHFIZ/B8zITk97OL?=
 =?us-ascii?Q?2c+tuRmR9ob7EaUu8M97IpO4ZE3BL5k1o7feWZy2hdkQM+Rp6sbm3FL/0W8s?=
 =?us-ascii?Q?GmbzTX0jEQXYeVmaJJIbIkCfDBRyN+XHL5OTY+pLZFAuA8U95HP1gjm7yT7t?=
 =?us-ascii?Q?BWxzvMjkC7k3OqzOSDcV/yZ6sqQS5Mm5XHdPwSSmmzoLCyvYf4djA1pNrwV2?=
 =?us-ascii?Q?wkdKgo4Wf/n8Ncq+Tx/KLLatup+5qz6PY2l/qj2Pv0/g0oSlUHu0uZpA//+8?=
 =?us-ascii?Q?2Al87w+UfqxVAMJuZGrqGdB/gQ6TylLxonoS/SIE66qPIGjwdllaW3ZyRoeP?=
 =?us-ascii?Q?dPnMVNcb8p1FmiTMtev2gfx2PvWLQhG/2G3s7OQPjqegLw7zgD+vnoqWdVAh?=
 =?us-ascii?Q?iENEborm4lzDJ8dxu06fjimfNkHdqOjn0+fs6jrkwK16nPH/K//CJZ4Ek1po?=
 =?us-ascii?Q?ry6uL6rpoYjfZ3Yh9rBnO/S/hxrXt5u0t0Ad/lvRr3ywY+LbjsDyUcHR0xr5?=
 =?us-ascii?Q?fkQfK9bBcDlOCqjmPJ8cZobLEOd2K+x93ItpCZ2F8jUhAQT/17Ca4k/i4oCD?=
 =?us-ascii?Q?Vwczpw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1BbBp67Zo5AIDzTer8jRnnky5FdxFp73Q6TpWsPKY/mjpQT4bgiOTn05Ni6WzjpZqNTrN6GIV3rZ+M++kB3ert3VIACMO0nB99X8M8h2nO0cBx6sQGGyGQnJ75CS6YbdlJYnZqk0aYnXgdW8cUM6McvlmuO3r5mM0RkSCTQkMyA+isC/LYoTWinD4XjaGRaRfuebHnjDkwYMTZGMIGu/4lPuJhdXTs22wSRrsV96N8tFqWSwh36V6E13Te5u2sPeE1XfFWUXw0v11crpIvi6Ic9CZCFOmej5p0wl/2shiqi1N1GLxhxjGksRVtNSyZ+AJgS3LVopoxwobfZqbNBmYV0RqIDdhH5W598V4fS1Un6wznxWLH1cG6Trra+VcSEPzyh7LMlA1ilOdHaLjAGKRFVdCMe7MT0Evmhc25o1HWkZZKO+zUHZTRYDwaxL11rxjtAEE/0k0DkOdfXsncbwJCBnBueIi/wqJWi0+7/d7pWAe0RF/xIRUf/xDeaSjzpEHnz6spuNdEteeE+g3BYacOETa+OPjSdahEqX0PsvwQQgRFwGlszP6bO0PhghNyQOWEXTxf/MzFjsMUda/I6HJhkRuEY5cTu8hwBs/9Pv3fU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4aa82a-c40d-44fd-e45e-08dd462db454
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:40:27.2040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +39Zsi72OJjl6+zOa5sA5IJRhWH9zxy1YUV8Tbhki9c36JgyE1aHVj7THfQAlqND/R6yvoCRjXSCscahJ8yAfD0dshPkX277Ij7JxGbt/vE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: XqGcaSccjr3sWGJI4j_0jTyk6HqYu95Z
X-Proofpoint-ORIG-GUID: XqGcaSccjr3sWGJI4j_0jTyk6HqYu95Z

Hello,

This series contains backports for 6.6 from the 6.12 release. This patchset
has gone through xfs testing and review.

Andrew Kreimer (1):
  xfs: fix a typo

Brian Foster (2):
  xfs: skip background cowblock trims on inodes open for write
  xfs: don't free cowblocks from under dirty pagecache on unshare

Chi Zhiling (1):
  xfs: Reduce unnecessary searches when searching for the best extents

Christoph Hellwig (15):
  xfs: assert a valid limit in xfs_rtfind_forw
  xfs: merge xfs_attr_leaf_try_add into xfs_attr_leaf_addname
  xfs: return bool from xfs_attr3_leaf_add
  xfs: distinguish extra split from real ENOSPC from
    xfs_attr3_leaf_split
  xfs: distinguish extra split from real ENOSPC from
    xfs_attr_node_try_addname
  xfs: fold xfs_bmap_alloc_userdata into xfs_bmapi_allocate
  xfs: don't ifdef around the exact minlen allocations
  xfs: call xfs_bmap_exact_minlen_extent_alloc from xfs_bmap_btalloc
  xfs: support lowmode allocations in xfs_bmap_exact_minlen_extent_alloc
  xfs: pass the exact range to initialize to xfs_initialize_perag
  xfs: update the file system geometry after recoverying superblock
    buffers
  xfs: error out when a superblock buffer update reduces the agcount
  xfs: don't use __GFP_RETRY_MAYFAIL in xfs_initialize_perag
  xfs: update the pag for the last AG at recovery time
  xfs: streamline xfs_filestream_pick_ag

Darrick J. Wong (2):
  xfs: validate inumber in xfs_iget
  xfs: fix a sloppy memory handling bug in xfs_iroot_realloc

Ojaswin Mujoo (1):
  xfs: Check for delayed allocations before setting extsize

Uros Bizjak (1):
  xfs: Use try_cmpxchg() in xlog_cil_insert_pcp_aggregate()

Zhang Zekun (1):
  xfs: Remove empty declartion in header file

 fs/xfs/libxfs/xfs_ag.c         |  47 ++++----
 fs/xfs/libxfs/xfs_ag.h         |   6 +-
 fs/xfs/libxfs/xfs_alloc.c      |   9 +-
 fs/xfs/libxfs/xfs_alloc.h      |   4 +-
 fs/xfs/libxfs/xfs_attr.c       | 190 ++++++++++++++-------------------
 fs/xfs/libxfs/xfs_attr_leaf.c  |  40 +++----
 fs/xfs/libxfs/xfs_attr_leaf.h  |   2 +-
 fs/xfs/libxfs/xfs_bmap.c       | 140 ++++++++----------------
 fs/xfs/libxfs/xfs_da_btree.c   |   5 +-
 fs/xfs/libxfs/xfs_inode_fork.c |  10 +-
 fs/xfs/libxfs/xfs_rtbitmap.c   |   2 +
 fs/xfs/xfs_buf_item_recover.c  |  70 ++++++++++++
 fs/xfs/xfs_filestream.c        |  96 ++++++++---------
 fs/xfs/xfs_fsops.c             |  18 ++--
 fs/xfs/xfs_icache.c            |  39 ++++---
 fs/xfs/xfs_inode.c             |   2 +-
 fs/xfs/xfs_inode.h             |   5 +
 fs/xfs/xfs_ioctl.c             |   4 +-
 fs/xfs/xfs_log.h               |   1 -
 fs/xfs/xfs_log_cil.c           |  11 +-
 fs/xfs/xfs_log_recover.c       |   9 +-
 fs/xfs/xfs_mount.c             |   4 +-
 fs/xfs/xfs_reflink.c           |   3 +
 fs/xfs/xfs_reflink.h           |  19 ++++
 24 files changed, 375 insertions(+), 361 deletions(-)

-- 
2.39.3


