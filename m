Return-Path: <stable+bounces-237706-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK4pGciq3WmBhgkAu9opvQ
	(envelope-from <stable+bounces-237706-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 04:47:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 984B03F517D
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 04:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55197303AF35
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 02:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503D1285066;
	Tue, 14 Apr 2026 02:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="ZZq+FcK+"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC2E82899;
	Tue, 14 Apr 2026 02:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776134843; cv=fail; b=Dlailal6y8LBBFQMGOxSs4sM+DI8LjjJOiml+O9Tr1hsPjA0H0V06Uf37viYMC9TwrhUb9yDIksQdMM/E78fbG6tvHLEa2rFiaARdKBPsDINxmaipmc+JbQ/EMXu2JskzjN+pZZhLJCRs3Ezjv4UoCA6TVTpsEfV4HjOl0NvEOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776134843; c=relaxed/simple;
	bh=EVfze9RMKV9EhV597Yb+MLoIPqhQ1yTADK/KNpnx4rg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=N25zoL+nnIJkjIpZuu8yp1YFCYjoQLV/eZIRxdhgGlQqYLBFdEjV4KpxHlGSUBGBD5BZjj3wtu45kIn9+dd5OmL1S4KXOLw/BuddVVOTFJg+VwMTuoctjy82TWyNl948ZIzrCOCaFWb0HLTueQWxJ7D7mvpxnH0U/32c3pdaPXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ZZq+FcK+; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63E2as5O1563609;
	Tue, 14 Apr 2026 02:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=tXC53uKBw
	03l4cWHT4rhQmyZbUXQekI7LF/qv/wttMI=; b=ZZq+FcK+syGJqYn7ZoRNyvaM8
	gbOIW0SjLPC4QCLJa0DSldAJyg5Iy8Urprher2Gjr0iPIiDfo62Q54jvwfezLG+X
	ZzKRI30vU1sPwG2cPm7XZqCI/GdaQ8IxWiRgrip+WncdS0E5I7I5XBQ4RkwUAUs+
	+CHzqQmq5kIU89foWjlTfOfPeIigEcYV5Yh/dv1koQnj8tkqUiKeHLXNG3Wk/ik9
	WIrcFW4mJc3E08p+F6Zx8juBxr3XZq08hVEcwGXAVchPtWZKcnlh+DoQikVmY59u
	HpbxmnlhBzzgKAhh3CnboT7xtkPa+AOGNGzyb14LiyQ3+qlTC902KUvk1Qvrg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dh877g7jb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 02:46:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hB6uNvZxEHhOqFOs4RMIDymA2uU1Tbx7xgNXlbhvAnJR0XbPPYaADFIUyDnNvy0jZZoWkVI31O79ZJFlLVL3UCQfeWGdnxKZ9lEwDVgU6SMvUW9zgTMrjsZx+uwsm+xG4vsYFIRVfLMF+AL/HhDHzLAlTR0zllKe8eiU2ClOoAzm5cAYltNgsUbI96Ibx3O2AV5U6VPYwBARX0R9n4TKQyiaEphAOSqAHps49gwc+Rcm3u2u39/s0KqPxYQW3wXu+/+qOaHMY2/5OzlyGy3ABCyvuN4j+yCvT/dEAtPzWxNA7q/525RZh+anv6tZF4sTojKdYoSDvAka8a+jWjmehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXC53uKBw03l4cWHT4rhQmyZbUXQekI7LF/qv/wttMI=;
 b=byTIQHGBMhKI1k+t/8+2FCZZnJpDM95yR6U1mVkvYcU4pLgfHapb/8a3Xafhob6BLwwvcOp2DlGasvfLcox2zjMBcWWrzFxkBSojLCcZGLQMAawgq2nmthFTEd7BmUjkaJEDv8bx64LZOXqDfmNH1geFROgRxZjAWhTaGecRLbFM3TkkUg8EvBHLlXq7DTEYPbveEZpmxswStcBhataycYNu2LXI+DJ1rpCTML8r7Rt3HnEJT98jgQCx68pR4CAXtfmsQeZUnzkjm0Rea2+bB+42yZbous/ZsxvxLMlH9hKW198Bkata5TIlKoKWZa+LjQZjwsniRPN9yMw+aoDEFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21)
 by EAYPR11MB9562.namprd11.prod.outlook.com (2603:10b6:303:2bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 02:46:56 +0000
Received: from CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::89ea:ecfa:c345:3fc6]) by CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::89ea:ecfa:c345:3fc6%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 02:46:56 +0000
From: guocai.he.cn@windriver.com
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, johannes.berg@intel.com, netdev@vger.kernel.org,
        regressions@lists.linux.dev, miriam.rachel.korenblit@intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y] Revert "wifi: cfg80211: stop NAN and P2P in cfg80211_leave"
Date: Tue, 14 Apr 2026 10:46:34 +0800
Message-Id: <20260414024634.2826229-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0012.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::17) To CO6PR11MB5586.namprd11.prod.outlook.com
 (2603:10b6:5:35d::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5586:EE_|EAYPR11MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f5fd89-98d3-424b-f7b2-08de99d01760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	Cr02s4HQ7W/716DDdYA7e9ZTaUc/FSPhKUUnuEZxeM0oXLW/AzGIspJ3uCeH482eGZFxlKoUQ7BK1QCJB36rMGa2FZ1QkRWncMwR/LNLDs6o81loqDbtqtxGPnGXijPySbsn2dcw8yMngk0qfmI9nLPFSKs2685b0Ln6lpSNEyIdkC6Nl6JeYnUdVk9vgsGsRGxIm8qF/jwahXiZqP5l5ynLOYBskN0I2RWFqHfTOsC7fABRoFsN8ufxw/HQebJ7GezkiJ1LxjC5vkvJik+VmfOypsc+lr4YJ/q/j+rtclVY6lh03ebl9MG40aYMx0KnSUcmTv/yBODk39j2qnioNthlBEQS3rHQW7OqTgNpfxAOXYdnu5B9pkQoQsa8/IDmihNezicwrhsAZjmUXHZTzLIZWveWU+pkJLZrc7nM26WWAM/u0Jq8O5HM5JdgsG/gvfGZdd1pC0x6lZ22qI6S/lj0/XeSCebsKtFhNTdraB2NnUwP7NrMbppGmb4qdwCvEZ2s1GHcJaXigLglZaZOlEenKJWoG9kNSRrchSmCG2X4cnyVfZrEiN07PVODDmjQpD0q/VNQB+lsjRgofbHxdNQW5KjW/YyTameJnWMWIavotOhcH6M7m7bsLvEP2+9msCzZH0Za9rMs2wOKyW14uV0ZyGLyym9R100lv6XJ3MdW7nHscDLn9ooyR5/jVN2XnhliK5DOOEpfpZ4XOMEmrnstGxV8NHJPUhoutYybFlc112K6Vx3xZiic/cOj2+38uuLCyfnQp4tFf1epSKFV6lViD7O/+1kC7cHENqtP2WM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5586.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dSGz+KtQBvhuTGjybIH/HCErcRuDTxZdFkdb8fOCzo0E2bsQH+PpN+1ap/NK?=
 =?us-ascii?Q?xv8Oo+xX3qmiZg0Ki+vY7UEQoomROouR/K9YvfVmJbB04JwrS35aH9cEGZYa?=
 =?us-ascii?Q?p76AT+8EHm5o4r/bYk0iUNtjwkL1mdPs7mupZkAEEXAxH/cJ3ZbnKSiGC3Fa?=
 =?us-ascii?Q?GBcXkCG7AYkeMXVtUFJFk8+t5F38ZPneNC9hArMro8jvIyjY3//voXhjpR2s?=
 =?us-ascii?Q?YnKWos8s7k91inJKSFormzI9sY84utZPdzgz5SoNlgI+qQ4Ed0+xYyquaIbI?=
 =?us-ascii?Q?qx5Gv35z51SsRUZ1lXjWcWWoJWqbYKGWmEU8o9bJqEqsQMqE7Vm9MXo07x5g?=
 =?us-ascii?Q?S21GbT3yeFWJSGQ4u8B7gkEW/ZeCF4Umw2jYtbCZUCEmYHVr2GU2wlKNE/g8?=
 =?us-ascii?Q?OO23MQOTZMACzvwwQWH0GVtuEEfJjANXdcGXooMhzSDZNQqarblUS2NKCdxF?=
 =?us-ascii?Q?w4Ojn8bc94MoxCDVi9k3GtRS2XX8Kp6jz47CxaCgk3u1ClfQGQlcOURbMajT?=
 =?us-ascii?Q?HwckilQgD0P+xCX2H0mBVDZT1HBOnWQk/B5k7MGeJxorJxnk9nM6MqNniqbo?=
 =?us-ascii?Q?AbeQM/4K/Me86m7lZlmjf9txvWFJ30E4dZ2b0PLp6/Ot5j4EctynTDYyM21A?=
 =?us-ascii?Q?SD5p0VRfKJZRkmxLigScrcaz9TxBgL/xvrs39fIBCXREWI3mNSyMpo822i8C?=
 =?us-ascii?Q?vee32jPHXgDAOh8TTuxdIVUo2G1swXUkkynU7qRHO/c6yQsU92NT25UVTTRM?=
 =?us-ascii?Q?sbErkNK384WgV5tu1BY2zveEtSN/8JpRcSUDujyVzYq8wwoleLmpYjXyPTd1?=
 =?us-ascii?Q?jwDYwBEBA/mU6cGU8NMdAGV4yLL35BNF71C4nWQ3XPvYkt4I42jAsPuSvyep?=
 =?us-ascii?Q?1HFbMeHCnUw0YR62GmIQJi+zDd45+MaFTsp+AlbMPLF7xV//daXU+NVx1XZE?=
 =?us-ascii?Q?oVnxig2YQfZx7Xy6bXUPUS64xyhSCmFKrpoY++7UhizwwHxOZNzBWtqc0Xwa?=
 =?us-ascii?Q?Nd2OtYtIf+CSOMRGJhucwB4/8w3/XTYFVyJsH/EUURElyEo8XYs34zR1P5XT?=
 =?us-ascii?Q?HgVYwl4SD0jYsWCrbbqOR2ZzeY92YeGQ0tF6+AirULgicH0UJ5XOskTB4gYv?=
 =?us-ascii?Q?tB2pN/EMop0grpGFV7Bx+ZjZ1yKN/nwma80S/lcPiYsgz1abhLVSYOHlOIFU?=
 =?us-ascii?Q?vH6zbFzW8EMNFMWqDSJves7UM6TiQ1aiK+H94g1l39AZcL6U2b3LBcOowxKk?=
 =?us-ascii?Q?3g7uKy6FqTDpi56rh4JWaMKG97ffVb2R999O9gwS142fTsSOY9VTQS/nZPw1?=
 =?us-ascii?Q?QNoCCoht4MEM3TUEbeMFOutuHQXoudjb+k0f3dklBtLEjyP//XJj9Sm3SGCW?=
 =?us-ascii?Q?usW7OS/ZSmTh43blowC0R+jmvSciYHD37VZ0e9Oab+k2T88yAYvDlzFufNPi?=
 =?us-ascii?Q?zBA4G4U/lGHYQmyg9bAoo4eLvLUvSnpzl/1zfWqLIyQZ/O4wmWBX1M9F9XYq?=
 =?us-ascii?Q?YXrhm/KBhnuo05eBr4XMQqnqvm3B9WlOF7qGtdNKNr4D7Sh4eoBpLqFV9q6/?=
 =?us-ascii?Q?VjqTZ0rxe6sEm0PGp3LSaNTk65UbaDhhgLorhjoYXDY/lSmeJUiwL7QnAnY2?=
 =?us-ascii?Q?8J9/Et9Iz1lu5vBP5gV48GD7aKH7BohqSkwEaXXIV6AJPVne19GF0Xtel0sy?=
 =?us-ascii?Q?LfNqvhxfYN9IE63xkIFgmhlUxuU5RIiM8IS6zz8DKSJfQDI/aldIOnwgMFTn?=
 =?us-ascii?Q?6NEzUwmzTP9m9KagRngqoPb1cJG7evw=3D?=
X-Exchange-RoutingPolicyChecked:
	KAmqmHq2R7WBNS3VqQKtfkuc38URYHtmXFIFL5VQVd25VHmsh3xCnY+wCGRNr04b/CzKou7Prawc3DsZ004g/RMpz+xSLBwV2h0ZQmwIkbahaJmxIT/cvRSkM24t/H0SneNzvZYaENjNCCDaBDxHImHgB+QuIDOS5CZklJWIblukd75tVFjMBxNOySzy+4oUuCU/STJs7NI35ZAyFyJHg2ZiIAsZqLYJNqri1Ma5PW5mzTBwgewjf4SD10DqBh39Lhs7g3yAPU7Zo9fQJOBoZA7/7ZOmH0we8pRW9onFwUoRPwRTjo8A0233xza686P4BKRcIsJXWRGgBKxOoi9m7Q==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f5fd89-98d3-424b-f7b2-08de99d01760
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5586.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 02:46:56.0472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArWWHw9voF7nXCSb7EpvpoZCbEpqtRI+lktHmVIS/mhw8y5C3W8ZNZfof40PrF/+dR2xFE/gnZSKcova77/BQu8m31Rh5DsNuQhmjlSNMUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9562
X-Proofpoint-ORIG-GUID: ophABAESKufDjYS04CAXj7HdCO0g6d77
X-Authority-Analysis: v=2.4 cv=ZtHd7d7G c=1 sm=1 tr=0 ts=69ddaaa3 cx=c_pps
 a=wodMs23R9wL6gmOfRTd43Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=y-J10uEhvVOKljhdnB8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: ophABAESKufDjYS04CAXj7HdCO0g6d77
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDAyNCBTYWx0ZWRfXw2kb4TOtPVOr
 tEBX5GgNw0U6P4jWP9QXyEc4LBKtIcZXG5RcXQac9SPpcTRCGN7qN/1kOH9swmvoj7L6gk+fzmJ
 bt0HdIDIIkaRb53twYWxdsFjBWCmRV7SOPSTyV8d0XmCHsVdXUE6wTH6fJBXcc3PE7eIKd6jAsk
 nEFprigljbzYWl153pWKtIjgZlzezH/gf2Xw4JAiBagAGJGCb78ElzMJj3RFSKTCtIX64Q6xBtF
 h0TsM7C7lZFoBlRh/D3ozSYY11ftBvObOgOtKkfr9MH3pbRekQ1A7Fso5Vbxm7I3QrKC30upjnV
 +QOSaTwz+RlR94ghcGudOglgRICMaQClpGRZ5ZjeaqYrTF7nnbTLERUukq2RXy26vFGuZROZpX9
 EHOHkWUP+WPGvnWoEbQ3TZ4cGhbx6mWmU2GHQtJnT/8XowN/MLBLGFPaJPH70ff112aH125Az1I
 GZ9IgHZ2ebbMQyVaIjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140024
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237706-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guocai.he.cn@windriver.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:email,windriver.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 984B03F517D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Guocai He <guocai.he.cn@windriver.com>

This reverts commit 4d7a05da767e5cbcf4db511b9289d7ebd380dc56 which is commit
e1696c8bd0056bc1a5f7766f58ac333adc203e8a upstream.

The reverted patch introduced a deadlock. The locking situation in mainline is
totally different, so it is incorrect to directly backport the commit from mainline.

Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
---
 net/wireless/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index fac19dab23c6..d07c4baa32d9 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1332,10 +1332,8 @@ void __cfg80211_leave(struct cfg80211_registered_device *rdev,
 		__cfg80211_leave_ocb(rdev, dev);
 		break;
 	case NL80211_IFTYPE_P2P_DEVICE:
-		cfg80211_stop_p2p_device(rdev, wdev);
-		break;
 	case NL80211_IFTYPE_NAN:
-		cfg80211_stop_nan(rdev, wdev);
+		/* cannot happen, has no netdev */
 		break;
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_MONITOR:
-- 
2.34.1


