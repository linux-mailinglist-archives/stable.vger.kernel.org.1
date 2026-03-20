Return-Path: <stable+bounces-227613-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLS8DnGuvWnIAQMAu9opvQ
	(envelope-from <stable+bounces-227613-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:30:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D6F2E0D85
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76B81308861E
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 20:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB3F346AE5;
	Fri, 20 Mar 2026 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="rsOqPfFe"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35B2C3259;
	Fri, 20 Mar 2026 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774038619; cv=fail; b=S3xHFTBezIUKJo9Ij+SdShlWv/q4M3XBkyjGQlea2P83M/VnhK24f+zEeYioODrO2qtULk9dd0avp48xCi/GH06aLcQcUJP73RoDqc32z7oufsxxMOjIpkdnXRmHnek1lL44ktkXy02PwAVey4m3/ATJx1Jw+3C2yR/bT+xNp4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774038619; c=relaxed/simple;
	bh=BCG7QoCCj5KR2SubaJCCAPMj0ghY1l1Xlc9mysyzgeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M20Hjgq5vjsMSCyhCYeDjouUxjeYQ4CrZn9Agq5kvKr6S61QGo8UfqXKhJjzWLg28xb0GM4wJNMw1BxYz5hIHHcqjRYEyU1m0h334fPCgWMpg4nS973XGglw39zKinNbtHDu2Mb3CmR80ldqIHXL5ZbqUXBY20L+HaPDeI1oEn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=rsOqPfFe; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K8qba1324122;
	Fri, 20 Mar 2026 20:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Dvo0XZsL5HqxKVW4sHjDYeZGFoEgIZnjqWwCCj90V9c=; b=
	rsOqPfFeBdUxP1bpQql7rsF8ztoNdm3TjOwgBWxzXdpUNbKHMuQsrpinhjvY6Ivc
	03SjnkwlFEBIiE8T1mFvwFD+hNNxNB1c0dCHZ8UCEIEYCtmaF+YDi9KI2Qinz1k1
	1dVT6NkmwgnzCamsa0KhBRBqFOY3QoQLIOfasswU9sYLymFtKUOR2N/BaOMFUr2Y
	orH3XfzDrMIUUArLh8ihLBA9KegGXQqSrCNYTRck0gsWHNkLxigKbfaXN11xLVDQ
	EEfA1Pl3CLpm7rCfxnM+v4Qk8lmmkiwggqUAgy875V1g2T++JI40uNHCbi+CSfH+
	Xggp9PstHe+dUph3ay+F7Q==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cy9anw33g-4
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 20:29:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9PbZDF4QzvP+m687bXonnFLqO3DWH605BLwIG8iCsS0QLjm4LOFlIP3YNzd2xrD5VmAR8r592lI2ZHn7E7jAYVLSJ6iOa3q6G/UKS+u5UQI1adbl/TacYTLllB7M+rsElf3QDUGehv97eepaFTiOZp5vMXlvuhenHOQ1+aihFyOcJSoftrlZfVlUIFcs1gT1ALe5otJOMtbkWlTqBbdCc18/m5wKxJwekghk7dZf+nAohfr+37gE3ZOGGYAahzXqUJ0HEda2bY6/jkfTLolfWLlfeUE8182XTf0FV9tS+Fp/2vCv3k6gnRkpPRBJkP95WDDlrnVkNnpxWlefZQNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dvo0XZsL5HqxKVW4sHjDYeZGFoEgIZnjqWwCCj90V9c=;
 b=KOS3kuuvj8jpvlXWVnzU4wv4yd40KkP42qfJukyfAPQnVkBx+n0yR3l2G53iwHAsHY9Z7aLxAZWObv7xA3DzAOrhcbRBpPzMgIu8CJGQUgTGWxtNMbSPlkjPrhgJKxXK7wYmuNe2NsEt/AeqgduJ4Kaf16bsEJY+WlM4UShMYEbY59EOQicUo9VsV6XlmOMMl+pMjDZgrjWQCdOS5h4AOFK6B8GRTde0ZTZeklw80twMAR6ASyPJP2cnW5eowN3JfXzRskry8Cp3mAr1FScFr4wirzvI7texGZouq+F8MOIR9bzsrscg7nMWr4GVr06Z01LvEzBXX534HMURaYlOTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by MW4PR11MB6785.namprd11.prod.outlook.com (2603:10b6:303:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.14; Fri, 20 Mar
 2026 20:29:28 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 20:29:28 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        christian.loehle@arm.com, artem.bityutskiy@linux.intel.com,
        quic_zhonhan@quicinc.com, aboorvad@linux.ibm.com
Subject: [PATCH 6.12.y 3/6] cpuidle: menu: Tweak threshold use in get_typical_interval()
Date: Fri, 20 Mar 2026 22:29:05 +0200
Message-ID: <20260320202908.24377-4-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320202908.24377-1-ionut.nechita@windriver.com>
References: <20260320202908.24377-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::19) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|MW4PR11MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 3954ec4c-947a-4c76-b689-08de86bf627f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/3cNCaxpuXhrBGhkk7rjRPmYRUMmDjCcap5rkbFxnLLw+ohIpZ0sOFAJAHXTVbzDDQIbTcJ5nVx9qc0EEVKubRfzWQng6CuuLtycnZxp1Zjdm4B9iCOxusq0VCVmsVZBQQLRo9QYxUcUus6ync0Jru0Ip7gOcq4gb9beLiK+NJjlnmA46K6EoZABgBBEUlSLvWkxJhl7+vw+TbUO5Lqzd6Zhezp4lzq4dyjIC77TY/C8xnCoc8WuwFKFZf0TnfL29LGGHyfqjT8wTXG/lHpOqrvcNSoZ7vUgOotX+jOukXuq2FiiKM7+7i3NmM48hQ/K9ptV+Uh4iV+N94FGxEdToY/EK1is6o/aG+Ty9QyX7VpSRdCmEWJ5VGtUElOdJYfvfT6jQ7K6hxT3WEdWoqA1FffRqtkTsAaetwTxCcY/fwAIyh6qk+0TXBZaVtg+PGRs5a+Gr1hayZNkGATaH9FQTuBtwyXA/Mf0D5hpxc8t74HZbXvbJGDEOmSTczwQCcwbvhnn5yKZg/u2u0dHTkvZOkZUDz5LY3RpSpIWpyi4uocRYMOjfmOa8SEuzxTFmkIKRy2EJTuyC4weEpLh4gsagkcJWdGeM6fFWKr6C2PZ4rO7kPjb9ZSd2lqYRa4JsIyeC8IKpxpAwVhqIBcNFT4xRgBZ+BOMIK/6223felOyG/b3bG0+fwvNLahiOd3N3h0/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Az/XQ53Oni+pHKXG24JDvJS7uS18MGC4cDhY67Bxt2SuuP7+focmDVdICAox?=
 =?us-ascii?Q?c5AZJB0hBLsqWiTyRW2zu/WjFSZTTu8tp4lMI8sGZ6ghEzjG2+Ja5exGCID5?=
 =?us-ascii?Q?NrQNhgXQFrAojnDWwfOeyPlLl+bFqiqAoDhWEVnL0QA+hxiZi9CvjHimX464?=
 =?us-ascii?Q?j/SrDSeseGKfCAtbWA5ESORuzw0r1oPZJ7KLFo4UhnWE805HVvPvk3EkItJY?=
 =?us-ascii?Q?VJqvFBMwAoMhd+EgcOoM+LeojhqU6cylQZHkEpmsA1cn+fzDztrIy1DL6il2?=
 =?us-ascii?Q?/lFG086bI/KnX86S8kyfPnfILQrwXtmXMz5tFJb68ir9AYU8JQQlKLQG0q5G?=
 =?us-ascii?Q?K6LY0WWDgSnN7VrBSjc1YOL9Lva/ApAlE3Opjs2EAoICPa6L7Zf4N1u31siQ?=
 =?us-ascii?Q?GzqBRk8u1F7izfBLWBCtEbKZUNdlSnEulAdltBXZto8EN+t7rvBPvbKSKuCO?=
 =?us-ascii?Q?G4B58s+8Ym2vtGih1EfFtPauv0dOFZa6jSdOjBToswDtg7WH4r0n5vNRJysZ?=
 =?us-ascii?Q?7p+/l6B5dcsiz0Zo1CLzLwPE6r17xJhvI06AO4IEyIy+HJHjv3d9MFJyyeQl?=
 =?us-ascii?Q?M0I02tSuvvMLir4nz9vvdATY8Y9O1zKwevf59OqwRI8jL5iJmg1Kv5lK+qrC?=
 =?us-ascii?Q?LTmlJzYn6uGWkh4dmBEQpwdFhMg5Y2K/NsiAKDaS7/MHCG0gSAs5ddkXwpUm?=
 =?us-ascii?Q?W+P4aLimPH+HEg5Mc7e+XIX/M1ixQiLg2aUD2X5gKr5ckQFUPkUAYhmzpJ+9?=
 =?us-ascii?Q?2vBAcaNnwyVrkJJWWMZUEvASrl7D8rZsoc1gA8GMG0XjQPKOLIDd4LrrS17i?=
 =?us-ascii?Q?1k2v4uYgwfSVhprK3bpBRgFS+vpDgQKIz2cfjoZ1xfKZlKAhNy8Zfr8uWBlZ?=
 =?us-ascii?Q?tms4hUAWts1kM4/2C3dcG16jyEpAGqTYRKjDE30fKlQehu4qZeOGTN6X/soB?=
 =?us-ascii?Q?hELTu5bm2aNXCpxkYKxJYl1cok1fLLtizusceiZcfgBHRRh9UtzX6EvUhaZl?=
 =?us-ascii?Q?SxBwflgrpK6HY2/VvAmdtj+icz92u4axVXSwCTpL01fxNvLR78p/MvgXsEz8?=
 =?us-ascii?Q?WQozjVMtweHX/XnjDBnbKVT22lfYOdjxLytVJLu8DXZGMAK4FNa2wTDWO0Or?=
 =?us-ascii?Q?QejseIBT7mrHyGsgGXz4sMpXos2Hpv0JCdWFkREDbF9ifarBQVWwWzmnZxUF?=
 =?us-ascii?Q?hI7fpyKy7VyH2W6Gq+a+nASeTnHYly5C7htdP6YtsOYOG/VP9T9CfKnrAOfd?=
 =?us-ascii?Q?km2pcSMEDXon/v6XAATKjK85J5h/4TPK8UudQT7UpWcePQTvEg4jO7u1yoXW?=
 =?us-ascii?Q?7dOdC9qrN+s8sBk6UzsbHIDkny0tO/NEPDLpYPDf8WIFCrRWQ6egjEJJN92L?=
 =?us-ascii?Q?GhtC3CwZ/zkj3RgmNPXBGEbHpWAoZRCKBas6txhBFdidRK18zzVAIPBB1s/+?=
 =?us-ascii?Q?6LwYIr8cQSI1u1BbQzmSOcWTpXgEryjTh2xIq7vqMIESnvUHrjHzSs2G/+la?=
 =?us-ascii?Q?qp/IiZv3kiqK0w8msKJHFFGKPWzm8GcUwAFZk85wxE+VYhK537BBIkr3XYGH?=
 =?us-ascii?Q?aAwGkdBGY+37N2sT5FsYA9ZpW5HXtJr/w8o6F4nT7JX9dn59yxK8HVjmxkNJ?=
 =?us-ascii?Q?sg/g28tEIgKntME29d0ADCt3QECUEPYr3kBYzpb4gpZI3PHrg/Gz4EPAP+/s?=
 =?us-ascii?Q?miLCo+plurv9nOajrt/C6pnRBvuFgT99bLOaUd5xoQUjnSARaEKhgNPf3BfH?=
 =?us-ascii?Q?t1quWM/0GcshIXa/eTyt4bhqzT5t5r2jJRK2DBXrlF8u3CVR5f2OyJUm5x5w?=
X-MS-Exchange-AntiSpam-MessageData-1: QGKrw7aTYrM1jg7QtwOnn3MALRFClxYslmM=
X-Exchange-RoutingPolicyChecked:
	o0hIifPycjPv9LTxUzqUzyJ2ff9X1SfHpSOZuwvxl2R/42vn+6bVo1XBaPnrSAmWXaYRW8rDg/ZRAvRCk81zoeKJZkC9bIhiuIKGE1bA2a4apAIwbq0CYazsXsqojHr5UAq8dZM9p7zYfp50nXtwRI8x3J0Nh5yWcJ/4fzlbmqFrGnmtGTHEbnnF1NZcEPgT2kaLLWLDtATEzDs6a1xFCw5c2/aQT57IOVcRFplpd/DmBc+7Tce7/FdChCNZyDRSLrIAH7A+ONsFL3M/kvfN514yPPvvit++h46PoibfLbNegIuxps54Vfd/UqHBkWImEgt7TQuXEpa4VKrUiXAKFg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3954ec4c-947a-4c76-b689-08de86bf627f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:29:28.3454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cs/us27X1vxA4qs1VuH/vK85DsHIMDY876uslFMtuvkYdbI+kwPx5AqayF8C89zDsOtotKvDwTCeZcxSykXFZsOEdpBtW4dJChMIi9ICyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6785
X-Authority-Analysis: v=2.4 cv=IrMTsb/g c=1 sm=1 tr=0 ts=69bdae2b cx=c_pps
 a=g4Zu/129bcKSj1q/f/8ScQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=bC-a23v3AAAA:8
 a=p-nOP-kxAAAA:8 a=QyXUC8HyAAAA:8 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8
 a=LhCKFc7Jy4j90cW2OcsA:9 a=FO4_E8m0qiDe52t0p3_H:22 a=XN2wCei03jY4uMu7D0Wg:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: CXW2WYDyhs567QT68maJbbhOZ75m3z6m
X-Proofpoint-GUID: CXW2WYDyhs567QT68maJbbhOZ75m3z6m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE2NyBTYWx0ZWRfXxrp2W6LH9U+F
 P44TDAOQ1XYcmVACZ0ytKt2hDoRToI5PszxJ2MWrOjBcocM5kuyDdJTcNNhKdoScIWv6C8wC+g8
 pQgi40Iyes+fJRo5BK7Uct6Bo/LyTHGH/4ecJ14ihCTACUiJhOO9BwQ73eFn7cX5BNeOqZPxCqd
 fpTI3M1rrGL6OU/VFKB1VlvlMSjBj2mCZqxfnbrQsaA5mBN4oCoDwqfB0fiMtcd7oXfZGAxsfHf
 kJ5jCsz287F9w+/CsorlfQ5Emt+8ZWqpfpvT6N7+McZ1CDCGyTTCGJg7UmtAmuPWwiG+ULG8sTQ
 og4UlX0zZiPpSuzTh1dgYaXY74+tVuM2OdqhsiJ9h/hhsA3PCHrfJ1fwQUsrPnXXmsb3bjVT60n
 rwa+yqdWAUdjtt4E+495aepS4Q9+LccFnnL4fGK20WcHulr6y+SzAb3SpIArseiygGBkrKqAOxC
 hdg/0gZpBsW/DdZihOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200167
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,arm.com:email];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-227613-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C9D6F2E0D85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To prepare get_typical_interval() for subsequent changes, rearrange
the use of the data point threshold in it a bit and initialize that
threshold to UINT_MAX which is more consistent with its data type.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Link: https://patch.msgid.link/8490144.T7Z3S40VBb@rjwysocki.net
---
 drivers/cpuidle/governors/menu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 8943bb8f19190..96bee77b8354f 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -124,7 +124,7 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev);
  */
 static unsigned int get_typical_interval(struct menu_device *data)
 {
-	unsigned int max, divisor, thresh = INT_MAX;
+	unsigned int max, divisor, thresh = UINT_MAX;
 	u64 avg, variance, avg_sq;
 	int i;
 
@@ -137,8 +137,8 @@ static unsigned int get_typical_interval(struct menu_device *data)
 	for (i = 0; i < INTERVALS; i++) {
 		unsigned int value = data->intervals[i];
 
-		/* Discard data points above the threshold. */
-		if (value > thresh)
+		/* Discard data points above or at the threshold. */
+		if (value >= thresh)
 			continue;
 
 		divisor++;
@@ -202,7 +202,7 @@ static unsigned int get_typical_interval(struct menu_device *data)
 	if (divisor * 4 <= INTERVALS * 3)
 		return UINT_MAX;
 
-	thresh = max - 1;
+	thresh = max;
 	goto again;
 }
 
-- 
2.53.0


