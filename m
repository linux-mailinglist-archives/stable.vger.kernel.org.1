Return-Path: <stable+bounces-87687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0D49A9D7C
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 10:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E483282FD3
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 08:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A419189905;
	Tue, 22 Oct 2024 08:54:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E879A187864
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587252; cv=fail; b=AiBcgBWngKJzNKbSQ51gfVdp26SCIJrEEFLpuTM/1omT42GKVUUW9YPFD74QfMRSfVs41LkyS6nmmJ8pBV7d0WUXVrrpw8+dKXlrDRhBYK4f/euvZLAbYbJ0zlVsGl/KNGSoHNxY4cvuudBbBXvva2avzrLc0eMAGjQFBDc5bXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587252; c=relaxed/simple;
	bh=/G4nsfZ7AT7hnq1DZ4+neyYwkFfJruqlWWmca1R2/9o=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Fzmf3hUtzuFoFU0vxjoR/kpaCSqXRm3wgxRxC5SVpPG1rIU/O/0TVMRBnILfHAc0ZTiaMbqPe3HBDh6D2gBAFwOANufbIPnhhNnJGEe5mkyWWM9RlnIAm4sGgvADlTEhm3FKY2/YZ1FjkCkabiTUnR63Ps9sQB1QIZKQ7wSgQVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M4wfSH007637
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 08:54:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42c3r7372q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 08:54:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hY8q4VN8fmuFP33XaklcSVFYyYwM6l6/57rbUJSZE1cEKQ6fpLIW12V6+Kc+PWb0tRf8IzQPn1EO2+TXuL8MUR3+o3VIDMU6RRIajMp6YY8xs9osj3+Kv7fb9SsOkxZQkDBwS6f0ZFKCqxrsEP5iz5kdCptOZRWY5ue5jBWKhVL8R+GspcLPheOW9MeI7Y379tfOpGu6BU7eRja1NR4mxqDv36GAXR2k35NwTTCs5cBBPPC2l3aKVYGRu3Y8yKpLStmcTzWZt2glgekfpMlCpWxc4pb+/+TCK3iEYrzgIQin4TkPXEuC1dhXR0sbp9J4qu+6e1gOyokPSk756DFr6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFpdGAZU2SAFGtdL0HSQf3B4OkYg4XJPyHPg87h+sug=;
 b=Q3nyudzPRjv/+sDCClEU3jFjMtbx6Gx67BePqpb4zj6Azkdgy7QEYnaNKyrY3f96TkpAG5FjBwzsIIydEaAqq1DB4NWgPqpZZ2b5ABgsPu0/ld8XvOPM1TT2knRKb+KvrPcvDNmLOUALGwBnpV9DmZBnU7O4c4lKPrrbPKqQFz0YTgbECYLowa64k7d8G2uw1iDNKMyqZpvWEGcOgEumYQqiRTyF3NC5CE9D0MYxNCyWyjDvbwNZsFYAhpV5fkah7I4DFGl58RNclE5Hx0w1OJLSDdPYA+y94Gbbttez4eq3I8qhtihBBZhPTuJuW/QwwwUL2qwc7o7XW9QXlruezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SA1PR11MB5898.namprd11.prod.outlook.com (2603:10b6:806:229::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 08:53:59 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 08:53:59 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1] fs/ntfs3: Add more attributes checks in mi_enum_attr()
Date: Tue, 22 Oct 2024 16:53:50 +0800
Message-ID: <20241022085350.3115953-1-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SA1PR11MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c4bab6f-4259-4be7-7921-08dcf277119d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9xxsW+uxjswPUqCyL5cZvYLk4okM75Ki8jIcHSpgzDC8B/j2VLXry2il+B1r?=
 =?us-ascii?Q?lXcHVJnhCeDHopP/sWSAnMCLVyIPN2Mtongeo6psTxzFiYYIpDaCbA8ZW2zT?=
 =?us-ascii?Q?V4sEtsdjtAA4dc3KK3Ej4FXz/f+VcvdfD5F0fLpRd745NCZa08QNTCyPpy1d?=
 =?us-ascii?Q?EQX2LsKPTVOAFXKTa1OcETdRNkIIQwlbx7sGAoOJaWbHBqc4RQMEr3Rat9Cx?=
 =?us-ascii?Q?rgsW0DNVNdaraokSNL3Y7GBSJnuHq9ESdprPUbaKQOXIbOlC5MuBwfCOHb0C?=
 =?us-ascii?Q?o/2NKBc8GNcro+nSJlEoFD5l/BPULhZTZjacXX2jRFniGv7E2/RIycURNWLl?=
 =?us-ascii?Q?MyszK8E6ACOePY+ETqxVRSASIApT024rY1NRssX+OUGGPfatdgiuSTMCsDY1?=
 =?us-ascii?Q?SWz5RfC/JAlzvxP5RzcxCffcYMbNkuaxswlUVB3jOzScxaOHOtT6zLAJPNd6?=
 =?us-ascii?Q?TCy0o4jchzZefDiTxd/JuKJ5FymJIZ2gDkL6cFwEU1dgxOAy0Qqn8jsczfHx?=
 =?us-ascii?Q?M8O35D86UQm700gWyjWc3IMWaRhQ0b7Yx2vtKNRt3Mt3gmdvLP2Zn9ZRAqD6?=
 =?us-ascii?Q?kYZyGsw7G8qzSvFl0srxRyO1YGeku8CnNOWQ2AS0dOHo834BYJA9FKyhJPGh?=
 =?us-ascii?Q?g8cVTTviE7++IwJ3NsaxZ8yR8FpSLaFm/fg/amo98+c3Vlg+1kQ8/fc6zwXZ?=
 =?us-ascii?Q?ksVGnnh3G0il5IArYcEguZIvGerw9dOHJAm0IewHmPI1NQ555lnJpeHc1qGi?=
 =?us-ascii?Q?Pxtr++AI1P7NvPPSHx0pNPY0KWDkh/7dOXqFx0MKWMd8EenG/lHIN8dA54qY?=
 =?us-ascii?Q?n9UFIyb+AERM/iu9q1ZapdFuK5DTQyVNw0IseSrZUXwazkNlMWtVGZdP8NpA?=
 =?us-ascii?Q?cgfiIUHFBb69ziWki9IyCHFNU5dTGg8fZyG/vZ1i5f8JAk3NwXKnCq8ff0ko?=
 =?us-ascii?Q?ApPvLla06AYT5dh4ib7PssB6XuPlcwIokLc3zswJ3VF9KSpJMjUcAuIIx+hA?=
 =?us-ascii?Q?Wj+1v15pzYXDX3+dXv0/hG42Hcm10JkiSCB2/N2yVn57w0kTNcaXEJ3TS0t5?=
 =?us-ascii?Q?vrhlsRLJUbr0XYc+e0CYwFt0U9TfbO4kpHxjZb1sraNTistYQ6ITnjdJiz/g?=
 =?us-ascii?Q?3JRiiDk7E533vNM7ewmtYkPf2tdGQcXWJq5b+zh7RnOqNmSCoNAxixCmuYeN?=
 =?us-ascii?Q?Q0yesyC/SR+7+ZbNOnzl1UN7cUk/4qlj0qUGF5HURScDtWnH3y70G/SbK0WX?=
 =?us-ascii?Q?YLkrvFE+QciMBkQxaQZWbK2tDxIe1UV0lWhtx+6LEht0Ab2gsy5ljGyTQw0N?=
 =?us-ascii?Q?dsw2hGvh/LyoRtfuJWReUvSMZ6PJK5hUSbF3rVCg1nt0FWJTQwm00GxKjIQw?=
 =?us-ascii?Q?IF0LLs8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DMliNTaFJMHo3t6CUir4oINAHFkVajsWzyvBDeiEBhZYm/q6rJ/3yRkOEvOI?=
 =?us-ascii?Q?CeNHfTCEcuMzJEoRLB3Ath8d2e33hlKkhRE0fzYfJSxK8VDeP6uOiRq/8w4G?=
 =?us-ascii?Q?hGtell//vl+r1a5JKp/hjCH8DVpE1qg3TlBEofS4d6r+P/EqM2S0UUWDQSdO?=
 =?us-ascii?Q?7P+Hgh3WZXx+VN+TQdVWDyKN0FPHJPnOGGo+sM1OAL/M+S4byobTgSdD5HCP?=
 =?us-ascii?Q?uMpTW9477joXe/iofKxpp7QOfLi13B9HGNf0n1sJwKIYN+svnNkgMBH5YoXx?=
 =?us-ascii?Q?BQdj/jzqCvEx3sqk65LiJjQEGkLeycMMx7dWmrPADAh1mL/zQzMCDn0LBcrM?=
 =?us-ascii?Q?cJpKTbNQzXWlXnloffRnG2sgIP6DKjlc6uX5ncw0UQxG6+lY9KEkewu6xNwl?=
 =?us-ascii?Q?4qd0rQtgGRJHjEE0QYiZNI2hRZz+e+GhnKKrue05n5thHXLCBkZ2QScJKYOn?=
 =?us-ascii?Q?NImdwRY9DiJoDfB+R1zqn30mq97nsDn3XZdNVdsbqpaE87e8WLli5cEALdD/?=
 =?us-ascii?Q?eMXvXkm/Tv4K05AQGrTonRLVvxMGKcY354F/akFRVDoUkx0mT4YdiHpjV2ES?=
 =?us-ascii?Q?WwtJoXeLOYS2jNd7PrPXNazMpqTxyW0ua5XSmwEm5ym97PDhmHkJYVsI8Bo0?=
 =?us-ascii?Q?xinWYthTnnnZTLM+ha8MLifxVts3GAIWApko7e3fp16OYyTYg99cQpl13g2l?=
 =?us-ascii?Q?13EBmnMjstJX7FUgKyaXtsxs8gzWjZ7QjgMlTwoRBHeh5T5tMgqq8Aj++U2b?=
 =?us-ascii?Q?Iygy++qGLsu4x7eEq4S+g7oXqaH3cAjf5Xu/8pR09yjjUfH/r5FvHIKPNrlD?=
 =?us-ascii?Q?Btn6/rxmTYsoCue7HVKa6L+SiHqhwIVXn+Z9x4rRQYUzHaDw1CYByhgeAU1x?=
 =?us-ascii?Q?atOVUZjuEYT6gnbs324fRdmaV/6jalKgKzkee8HeCwEv0RNZ/gkKrRISk15r?=
 =?us-ascii?Q?N/qMmlZnfSo/e623lp5aR2fKwIGLXpGP9Y7IaQhLK4wJohVX6Mf7yL2VKU1v?=
 =?us-ascii?Q?B6DtwCUkrvIboPgOSLLuFZV+p2nSjwNmAaPFOvQ+lhyFGdpB38sM0R7SmMWR?=
 =?us-ascii?Q?+lMFMtGBE+hNM13Xy8GWMJz5p/LnCQpTOBVu2GG5hjq6OjQq9fHZHWWSKK6/?=
 =?us-ascii?Q?hW52Eg9lUVSs/WWYDfovIAEjBBkUpYBLoYsZBoOpadhJ6xE1DojVkOs9XUvn?=
 =?us-ascii?Q?AwVwl2QLl0r8Su+84CzotQoYqP51ut94nOjwC0KtMuPMJK/so05eDFWpP3nX?=
 =?us-ascii?Q?Kz86W0fgFwG+dsR7kwTPDtgn0HvG0EWiH8YCk8S5dL9vN2WCHMp2iOfPvlLF?=
 =?us-ascii?Q?vvjFaLCRfgQCbwu+81cmTlZGngVtR5e92Nu7icXeHMqahwzYvoaNqNmuPUaS?=
 =?us-ascii?Q?MCHst2YOIO/S7tAQeEONDvlCubk0pcrNQ1hWTz4KzOgmoCle5fW4DF/6r4Tg?=
 =?us-ascii?Q?ssFETvm982+US1qn0ZxiTS65n13k9rgRQtqjsItiizjRwamSSteNz9v1F10Y?=
 =?us-ascii?Q?DNq/9kRQQ26kAdcEYUO/C3uybU7t1mfUPmTAMrbdCdkvijQB01AClC5I+nnJ?=
 =?us-ascii?Q?K1o21i/SH1tgEnScm/Oukr+hJa/W6aZip1VroCYURPmHsy/cyyqzyohFbMVU?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4bab6f-4259-4be7-7921-08dcf277119d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 08:53:59.1908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHDGyco+SyjS/2pYYNbDqkIcGANS45FVF6q4r9o2vjQb5QewV+Ty1hNeHF16eVDU9yGQ6nxfQ4u1IeQHTbD5TjgXWq5hsfvHYbujvfE/wZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5898
X-Authority-Analysis: v=2.4 cv=b8Tg4cGx c=1 sm=1 tr=0 ts=6717682a cx=c_pps a=gHjWyi4SN+6fNgZLRl0D7Q==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=bRTqI5nwn0kA:10 a=GFCt93a2AAAA:8 a=t7CeM3EgAAAA:8 a=F4_d0iVdzyuZofu-chwA:9
 a=0UNspqPZPZo5crgNHNjb:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: ejKSBZ4wWlO5ElKeFSruTXlCA2WoB8zt
X-Proofpoint-ORIG-GUID: ejKSBZ4wWlO5ElKeFSruTXlCA2WoB8zt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_08,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2410220057

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 013ff63b649475f0ee134e2c8d0c8e65284ede50 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
CVE: CVE-2023-45896
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 fs/ntfs3/record.c | 67 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 13 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 1351fb02e140..7ab452710572 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -193,8 +193,9 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 {
 	const struct MFT_REC *rec = mi->mrec;
 	u32 used = le32_to_cpu(rec->used);
-	u32 t32, off, asize;
+	u32 t32, off, asize, prev_type;
 	u16 t16;
+	u64 data_size, alloc_size, tot_size;
 
 	if (!attr) {
 		u32 total = le32_to_cpu(rec->total);
@@ -213,6 +214,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		if (!is_rec_inuse(rec))
 			return NULL;
 
+		prev_type = 0;
 		attr = Add2Ptr(rec, off);
 	} else {
 		/* Check if input attr inside record. */
@@ -226,6 +228,11 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 			return NULL;
 		}
 
+		/* Overflow check. */
+		if (off + asize < off)
+			return NULL;
+
+		prev_type = le32_to_cpu(attr->type);
 		attr = Add2Ptr(attr, asize);
 		off += asize;
 	}
@@ -245,7 +252,11 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 	/* 0x100 is last known attribute for now. */
 	t32 = le32_to_cpu(attr->type);
-	if ((t32 & 0xf) || (t32 > 0x100))
+	if (!t32 || (t32 & 0xf) || (t32 > 0x100))
+		return NULL;
+
+	/* attributes in record must be ordered by type */
+	if (t32 < prev_type)
 		return NULL;
 
 	/* Check overflow and boundary. */
@@ -254,16 +265,15 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 	/* Check size of attribute. */
 	if (!attr->non_res) {
+		/* Check resident fields. */
 		if (asize < SIZEOF_RESIDENT)
 			return NULL;
 
 		t16 = le16_to_cpu(attr->res.data_off);
-
 		if (t16 > asize)
 			return NULL;
 
-		t32 = le32_to_cpu(attr->res.data_size);
-		if (t16 + t32 > asize)
+		if (t16 + le32_to_cpu(attr->res.data_size) > asize)
 			return NULL;
 
 		if (attr->name_len &&
@@ -274,21 +284,52 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		return attr;
 	}
 
-	/* Check some nonresident fields. */
-	if (attr->name_len &&
-	    le16_to_cpu(attr->name_off) + sizeof(short) * attr->name_len >
-		    le16_to_cpu(attr->nres.run_off)) {
+	/* Check nonresident fields. */
+	if (attr->non_res != 1)
 		return NULL;
-	}
 
-	if (attr->nres.svcn || !is_attr_ext(attr)) {
+	t16 = le16_to_cpu(attr->nres.run_off);
+	if (t16 > asize)
+		return NULL;
+
+	t32 = sizeof(short) * attr->name_len;
+	if (t32 && le16_to_cpu(attr->name_off) + t32 > t16)
+		return NULL;
+
+	/* Check start/end vcn. */
+	if (le64_to_cpu(attr->nres.svcn) > le64_to_cpu(attr->nres.evcn) + 1)
+		return NULL;
+
+	data_size = le64_to_cpu(attr->nres.data_size);
+	if (le64_to_cpu(attr->nres.valid_size) > data_size)
+		return NULL;
+
+	alloc_size = le64_to_cpu(attr->nres.alloc_size);
+	if (data_size > alloc_size)
+		return NULL;
+
+	t32 = mi->sbi->cluster_mask;
+	if (alloc_size & t32)
+		return NULL;
+
+	if (!attr->nres.svcn && is_attr_ext(attr)) {
+		/* First segment of sparse/compressed attribute */
+		if (asize + 8 < SIZEOF_NONRESIDENT_EX)
+			return NULL;
+
+		tot_size = le64_to_cpu(attr->nres.total_size);
+		if (tot_size & t32)
+			return NULL;
+
+		if (tot_size > alloc_size)
+			return NULL;
+	} else {
 		if (asize + 8 < SIZEOF_NONRESIDENT)
 			return NULL;
 
 		if (attr->nres.c_unit)
 			return NULL;
-	} else if (asize + 8 < SIZEOF_NONRESIDENT_EX)
-		return NULL;
+	}
 
 	return attr;
 }
-- 
2.43.0


