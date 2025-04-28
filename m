Return-Path: <stable+bounces-136800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AF4A9E8BE
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 09:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EFC189C1AF
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 07:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061641DE2BA;
	Mon, 28 Apr 2025 07:01:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3543C3C
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745823716; cv=fail; b=N/COfz76kmnf/cWeqoe+UwbPe8nSj9FsC8Y+0vvY9y2go3EQvNjA3jXQ6duXO07MIZN6H7fwbeK4ybt8V4GDQfgfMD7Vm4hSFXdm1KCK+dQ3udbPzWriZFRsI4O5ESVGu8E1O7VMlRrA6Gm1w+nKrzIK+zBmWEUSJf1Rke/kmy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745823716; c=relaxed/simple;
	bh=/rVc8VYY3xVq3KEM9M2fRpJV7N9gDzC3Uybx6OZp8Fk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q1wBExszYw1CoIGdbnF+hbqsU822OOQ+YILbR4x44GE2fbIL7aXI6F3lExpsLr9Km4ZDJRS9ZjmO1XuHsWdNzhXvlrNInNnUbPMw7neWCtS4rswXd8p0xBXXX2Svcp7NTapepckf1JMKeBsSO3lUAbxQoEuqshBxy4EqKJB8dzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S1DYvG026304;
	Mon, 28 Apr 2025 07:01:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 468pf92gwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 07:01:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDaDSsTFYaQton7Qy9NTQkFo3JTeWNij85B6Y8aD4SrzAE+82NIfgPpIB5MduTla3e9d7+KUP+ZdIlWAKP9QpKULgW8NUKwpj6qxJrx37+M6cK78VRC8zmdCBsRKX7Gudoindgh/Dl2IELR5rvVbUYzSjHR66nnwsKcodMmr9AgMOLmOriaWK1zgYQ2VqJUHPv3lRlMawLMbEZ562+gic6CTpSL7Pkvp6K5tn/vc+8cfR40I11zSSdWxHvh4rBp11HERkDsvIzmeLgKFi5RDpl4FEgpqfGMH6zBBfqyN2hy4AwlNdvIQ2crVBBcDYYiuOOD3WAd5epStOC2wyNxYjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rVc8VYY3xVq3KEM9M2fRpJV7N9gDzC3Uybx6OZp8Fk=;
 b=tbx1Gx8QJpvQsO8uPTAGYcZyC0hD63gSptSz31Oh/gsluRug2Uwb2pxAITT7z1QgSIUBoDK7X/HxLhLOrahebM2rP95UCXx1pxxixNqthAzVb/FvILUZUYt6KC01UKULB1IkqmhNq/w5cVjE6276Obn7RDF6P7LrLkGi0PBGffo5jugbWQ6ShEn5g6CF9BeDiIO2DzamsLzYKqK2mi5lMBD2O0+UfrFwiXQLhyRB0Ke40uDaWomXpbzLh0e6gqOJyUNHElotWDsbIYrvqaxjDe1bB67mr4R8rMK4Qt4usUlzMPVHxljkEU1JOgIpxmNbhCs2t11eiG1AjXXYcul2uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB6170.namprd11.prod.outlook.com (2603:10b6:208:3ea::11)
 by DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 07:01:35 +0000
Received: from IA1PR11MB6170.namprd11.prod.outlook.com
 ([fe80::f850:53da:e11b:1653]) by IA1PR11MB6170.namprd11.prod.outlook.com
 ([fe80::f850:53da:e11b:1653%3]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 07:01:28 +0000
From: "Ren, Jianqi (Jacky) (CN)" <Jianqi.Ren.CN@windriver.com>
To: "xukuohai@huawei.com" <xukuohai@huawei.com>
CC: "He, Zhe" <Zhe.He@windriver.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: Several questions for backporting fix for CVE-2024-50063 to
 linux-5.15/5.10
Thread-Topic: Several questions for backporting fix for CVE-2024-50063 to
 linux-5.15/5.10
Thread-Index: Adu39txiea9iwMNPScqRrKhMBR0/+QAEEwIAAAEDbSA=
Date: Mon, 28 Apr 2025 07:01:28 +0000
Message-ID:
 <IA1PR11MB617031D997444204A6D7E20CBB812@IA1PR11MB6170.namprd11.prod.outlook.com>
References:
 <IA1PR11MB61702C3C1E8E46A4577E9D3BBB812@IA1PR11MB6170.namprd11.prod.outlook.com>
 <8aae9397-427e-44fb-9c5a-0a49d0ead27b@windriver.com>
In-Reply-To: <8aae9397-427e-44fb-9c5a-0a49d0ead27b@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6170:EE_|DM4PR11MB6117:EE_
x-ms-office365-filtering-correlation-id: cf2242ac-6021-4797-45d7-08dd86227f8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U2p6SjgxWjFpN04zR24xWnc4VWxEUHk0K0xRcTZPdjB5c1JqazAxU243MEJ2?=
 =?utf-8?B?RHJMN1pRSkluVm9vcWMwaThvbW81WXBQcXd6YTY2aExzZjd1K3ZCTWdmcmpM?=
 =?utf-8?B?VlJ4b0ppaFRXZisyNit3b3dRVnBsRHh3VEdseE9CSklTV25LQ0tuOFpONklJ?=
 =?utf-8?B?SElJUXRrM3pwaHQ4L2dZQzZsQThFU2wyTHB4UTBPNS9ub1FpQXpqanpuNGgr?=
 =?utf-8?B?M09oTnpkbmJNQ241dk5ob0lpTFVjY2hMdWVJUVhpd2ltUTdxV1lxakF4WFEr?=
 =?utf-8?B?MGM2Um8wRzZyaGg1WlVFRkJJU2ZLK0N5dXBHWnlJU2NvcTNramZ5aTc4RlFo?=
 =?utf-8?B?a3J2T3hUcE50NG94MkxGM09oeEFCeGdiRXpKU2czRjNhRnRGdE9KNEJTVVVV?=
 =?utf-8?B?Z0N4bUd0bUhJWGFid2lHa3hDMGZqU3E3L25KV1Z6RUdSYjZKU3A2TlRSazh0?=
 =?utf-8?B?NTFuR0tPQXRqNjBmemRydlY3dkVEOVRsZW95KzFWRTdweGtaMTFLdlZaM3RL?=
 =?utf-8?B?MDg4dXVKQzJFTkdjVVd1SzdsckM2TW1kRStvRWVIK3pNSUdieVo5ZUFRM3JQ?=
 =?utf-8?B?cE93QkxjZXNieWhQL043cW5VNllPNVYycFNhS1R3NHJiV0NKamt4YmVodUFG?=
 =?utf-8?B?aFlXWXl3bzhJL2o3bDEyd0lIUTJiaWpra3N3c2JIUzF6RE1zWm9oaUtjU0V4?=
 =?utf-8?B?UTZxYk1HeHY5MmxsOGN2VFpXdDFtM3pWWXhJN0RzYThFUTNZM2ZFeG53K09N?=
 =?utf-8?B?enlobVh3QUFTTnVlbkl4MmVMM2FHUnAxbHZFSUlsNFVUSjIrR2hOa2Z2Rity?=
 =?utf-8?B?RUpRL3ZrZmh1QmQxc09uZmFiOUg5RXJBWGY5ZjFNbTR4ZFZ2M1lUZnR0OWtk?=
 =?utf-8?B?QTB6YWRFcXdxd3JyZGV1NGxZMXB2QThyYXBNSGQ3OVpkZWVOY3VEVnZiMXdz?=
 =?utf-8?B?UWtjQ3kxNDV2dFJoYjY0T3VkZkliRnBQdE9pWGxwcEdBWFJzNXR1eTVsZzYv?=
 =?utf-8?B?UnA3eDlkaXNGSkwzT3BDNmN5QXNYcE1CUVZOVUhNN1Myd0k1Z3JiZTRFVHNR?=
 =?utf-8?B?ZEtXL1FCS3RjUXlVOWVhcnYzNnVzV2h2ZjdxQVhNdWtwNW52ckVjK09GT3VN?=
 =?utf-8?B?VE1ldnJXNHNsYS9FeGFEZ0RZM1JjQ1RscVZkLytWVnhuK24yVWZHU0FuM0FF?=
 =?utf-8?B?ZjFNbFU3M1o5VXpGc2p5Ujg1QjlRUnpGaGhOTm5aR2JXeXVyckIzTzIrbmgx?=
 =?utf-8?B?d3Ewcm8ycEE0M2wyV2NWOHM4MHZKYlJDcUpVRzZ5ZzVrcUJiUG54OXlQLzUx?=
 =?utf-8?B?eTFFSnp4YUNMU2xSL0FPQ1JtVGJaSjZ4QXMwN2t1MTA1REwvd3daUDRPMkQ1?=
 =?utf-8?B?WXdhYVAwMEROTFZweVBSdW1zanhNVmVGZXNOSC9VOEhma0dtSU9xTE9JVTVh?=
 =?utf-8?B?WndXRC82WUVGeHFxWng4SzNPUzE0ZGpjeGkwUjYyR1B6WjhmMWNzRjZDcFBW?=
 =?utf-8?B?Y1FXaGhhUVV2Ykl6RDJId0JTZks4TitaWldhMStYbFVDc0tZeWVYUXo0Yk40?=
 =?utf-8?B?U3Uzb2lIRWI1Vkp4U2dETzJ0NHd5Mm43VDZ1bTdMNlR0M1M3VkpRTVdDVmQ4?=
 =?utf-8?B?MzVNN3dlUmF5cFZPR3RZaHQ0OTRoOWhPSXdZbHRabWFLT2k1SldoU0ZWcndK?=
 =?utf-8?B?UmJDME15ck5sMSswVlJWaGN2NThhMTFYY1ZaV1NuRlFoMFJiNzJKUEFUcXRT?=
 =?utf-8?B?ZThXZkxDT1JPZFNLZkdTNlpYL0VVdjlDMWdOamI5UkpSUHFnYlc0UUFWVkRk?=
 =?utf-8?B?bTlDelBoUEgvclBnbzl2SWY5OXZ0d3BuaGROU0t5UWxpdGkzbFRtWFlIUGo1?=
 =?utf-8?B?TFErRmVNa1FVbTBQczlxdy8yd3IvcVZsb2ZwTTBwdkMzcDJCUkp2ZEg2aTd4?=
 =?utf-8?B?WG5yRlkwcHRyNGw1NGg1dzJxTmZoN3hOOHNDK0RmekkrY2FGZDRUVXlLSkRp?=
 =?utf-8?Q?7vBZk14bKLKSktf0u33Fy/WA/w5yx4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6170.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c3krZjBoZ1RSeHhHSjVxZVZVTm4vYk5lVk44WmZKb0hwOTNnb3RaNXl3dC9h?=
 =?utf-8?B?WW9yR1FHNHh5TS9COEtQT3hFa0Vlb1lsTTRwQmpIeXBQOUN0QTZ3YU9ySVNv?=
 =?utf-8?B?MXhzckhFbCttYUV5NTlSK2twaHZOVnEyS1VGaW94a0ovSCt6VFl0RVVhNkx3?=
 =?utf-8?B?cjA5RFFKNTBlWkxjQ2hmZlRXeUg3U0NrUnlIUDlxRE43ZWRhSXpoRHBSdXIx?=
 =?utf-8?B?U3N6blQ1WnppVlhCNDhtZzlrTGZKR3NHZ3FkRE9KOXpLQnlvM0JFcnNVVk9i?=
 =?utf-8?B?QVo1a28yRWJHRGRWN3d0SnhpdDJFU01jUFAzamhkbVNFcGJJRnRCUVlRdkZi?=
 =?utf-8?B?QjRXakpxZDlMVUNyNlFPTTBvTlNmMTZlVVltZHZQS2hJUm9iVmxoZHYvenM0?=
 =?utf-8?B?V1lUQUwvQnBSb3JmK2ZwMWk3RGxhUTNuWVQrTTl5bXZaZ0d3U2xnRkVxVktu?=
 =?utf-8?B?K1RqVnNMMmdvdUc0L2RMT29XTU4xT3ZBdVZRRTY0N1BYeTNxS2Y4aG4rRytJ?=
 =?utf-8?B?aUdwU3V2NzRqTThIWUM5cWNrNmVUTmMvN2FyNE5MZmFRbkdZbWs5dzUyRVRC?=
 =?utf-8?B?Y0FTMzdhSXBjeUgzRVlWSHp3Wkk1SURBWkxLUEYrQXg5Q0RzcjZyUnY2MGg4?=
 =?utf-8?B?Z0VqM2NRelZRVDFIMVduSWExSXFTa1lMck9NdDQyZCtjOXdTYkVlc05uZDQ2?=
 =?utf-8?B?d0szMXVvcTB3QWZxeTFyUDZqLzVoYlZhVXNIbjFOUWtZazl5K1NUd2VVTjZ3?=
 =?utf-8?B?Q0RNVmZWd3diWkNBRFZNWGpMREorWi81cEhISXBuck13RzFyS21uN2hCK0Z1?=
 =?utf-8?B?UmRIMFpJMHlSU25oYll2Ujh5aHh5dEhOTjczUkdoaHZmTGtDUDk3VW90OEZY?=
 =?utf-8?B?cFBqcXB0S1pEVnNSUmRjdzErRktTVTlMQ2JPMlYxaUtyVXk3NlpZVTFqd0lN?=
 =?utf-8?B?U0hzdXlUQzVFSGtwekxOd2FmZTczQitDM1FZRy9YeS9LUXE2bHhzREVrK2hH?=
 =?utf-8?B?VDJjL3Y3SXBzekVDNXlqMEJXei9pNWFuZzdhRmJpcXNOZ3BOTzV4TDhpbHJ4?=
 =?utf-8?B?WkJxZnVFK2d3ZU5HMGF2NVgrM3pTK1FxcnlCOGdFWlNHYTZ4OXc1eU42Tnd6?=
 =?utf-8?B?TUtxMjdNTGt0WGsxVlhyTTkwVThLUzZQSUdmczlzNmtBWG9nSWQ1aUhzRHlI?=
 =?utf-8?B?NWlabTFEV3h3NjhXOFo2SC9walIxL3NzcGE2MnF4cDd0RU9nNzFXOHBkbHJ0?=
 =?utf-8?B?L1JiSlV2R0V6WGZtUzFkQ2Y3SUxHWUoyd3M4VlA4akpyZTh0Q1ZIKzBuUHFu?=
 =?utf-8?B?MVljVlZOWER2Yml5Q2tOdFdLdzllZVpjY1hNaXkxTDgzNEs4MXFEbWNoNk5J?=
 =?utf-8?B?T2tmZXdjYlZQTXFjR0NXQzgzSjVaRFU1STZSOGpVYkNrdmI4R0x0RFhBQVJn?=
 =?utf-8?B?ZkxkblRoL2FuSkN2OXU4SVQ4ZlZrMHVxUDJMemNvaExzK0xHKzcvVFlWWjNU?=
 =?utf-8?B?cFFlbmM5WEljSVhFeVBScFdiWnlRVVdmNmdWemQ1NlluUWpEL3RNdVdKVDV3?=
 =?utf-8?B?cjRiaTRRMnV0Zy9walJhd0MzcUZ6V1VnbGN4QWRPcEp1U3FKcGFsTGpEVVgx?=
 =?utf-8?B?RmhmcGxxdllkSGs5WDkyTWY4c0NuZWZiRHZyQmtPSThKUUwydjRSZnhBT0Zm?=
 =?utf-8?B?c2xiUnU1ckRjTXJ1c0FmeWd0OTgxUDcyU29GQUY5V08vYkNUaGM0RnNpdjdZ?=
 =?utf-8?B?aUZlcmExcC9pU0V0TzFYaHRHQURWbk9EaUs0S25YTkdydGYvZmRZQm5jWHRt?=
 =?utf-8?B?SzJFVHBKS3lVUjdBc0F2dWJTTDRFOC9GSU9KRVJVa01TdVdvWHVyNVIwSThN?=
 =?utf-8?B?UHlIVjJ3bHpJQWVtclhhRW9RMHVqZXp5QTBKalE0OWVQQ3hMNEpMODNXc2Q5?=
 =?utf-8?B?YWd1Z3kwbEcvdXFISlQyN01SQjN5alArQ3BuMGl3TllkK2RaR1FPUW56NmZZ?=
 =?utf-8?B?RnJOaDJ0Y0QxS3Q0aEhjb2VZd2FWSDFMYlJoTjF4K3JkK3ZTc0p3N0lseTJj?=
 =?utf-8?B?dkE4a2NxK1NHdTVGaWx5RjhUVWdDcGhqRnEvMkxNS0lQQTVpZ2JId3h5Yyt3?=
 =?utf-8?Q?Kz4SB+XVFpcCr92cUtDCRfx9g?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6170.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2242ac-6021-4797-45d7-08dd86227f8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 07:01:28.3161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jnnoOhgHDDfS4j+ZnXpSNvSudBX4HnccVdho+OwVF3SkUbU1MbWn/5at+HOX4xNZddTom0nCWNpuDRtK0FWbTH1AZ/ROD/XJKC+8JRq+arI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6117
X-Proofpoint-GUID: qfZqH3VDQjVRH47zyoKx4Mmkh4HPpaEm
X-Authority-Analysis: v=2.4 cv=EavIQOmC c=1 sm=1 tr=0 ts=680f27d3 cx=c_pps a=nskeBUqQUen4dZUz4TdP1w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=8r2qhXULAAAA:8 a=VwQbUJbxAAAA:8 a=SMwdy2V71rYzqtQOlG4A:9 a=QEXdDO2ut3YA:10 a=8gvLZcY7Nlvl4CGD_6nf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDA1NyBTYWx0ZWRfXxZYUf/VLQklh vJcKcwENQPBt8I5rznemWVIKMnoNUFCCfoJFR2j/7F7A8V62jJHJoRwC7El4P0DQQtNJSOdI741 lWOfXLNzw24xf9r1ZM2/kYzO9bx4jsge8diuvRiEQhFPKEIaYlsD6PpVaGgCxLFLlwJtv0mVTdb
 0/oTEdknzeDVzG0lo8gacD4QmSDG9T3mfEpH9jPE17xPB5ek0vS+d0TyYD0WJuVwRN+ep0V9J1z CMV7w87MCcifl/IaRTw80QXWgcgHPhbIERiRyX0OlAlT+GJYNltOU1bFNHHR/X1BTM3vxWamcgU aPyZD0ww/JlLuz+0XR12JAS3524GSyGitAjuMOed9kyn6bzmWLDRRxzq+UOQ0uY0IToN5ildTA7
 zKJN6GSobl0Xub9HMdPNq+wGDtsJcqcIkpdj8l3wI2SjnKid8BjWjJiGQWD+m2tuPWF1nW6S
X-Proofpoint-ORIG-GUID: qfZqH3VDQjVRH47zyoKx4Mmkh4HPpaEm
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=622 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2504280057

SGVsbG8sDQoNCldlIGFyZSBldmFsdWF0aW5nIENWRS0yMDI0LTUwMDYzIGZvciB2NS4xNSBhbmQg
djUuMTAuIEJ1dCB0aGUgY29udGV4dCBvZiB2NS4xNSBhbmQgdjUuMTAgaXMgYmVoaW5kIGN1cnJl
bnQgdmVyc2lvbiBxdWl0ZSBhIGxvdC4gSXQgc2VlbXMgdGhlIHN1Z2dlc3RlZCBmaXggaW4gaHR0
cHM6Ly93d3cuY3ZlLm9yZy9DVkVSZWNvcmQ/aWQ9Q1ZFLTIwMjQtNTAwNjMsIGh0dHBzOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQvY29t
bWl0Lz9pZD0yOGVhZDNlYWFiYzE2ZWNjOTA3Y2ZiNzE4NzZkYTAyODA4MGY2MzU2LCByZXF1aXJl
cyBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFibGUv
bGludXguZ2l0L2NvbW1pdC8/aWQ9ZjQ1ZDViNmNlMmU4MzU4MzRjOTRiOGI3MDA3ODc5ODRmMDJj
ZDY2MiB0byB3b3JrLiBCdXQgaXQgc2VlbXMgcmlza3kgdG8gcG9ydCBzbyBtYW55IGNoYW5nZXMu
DQoNCklzIGl0IHdvcnRoIHBvcnRpbmcgY29tbWl0IGY0NWQ1YjZjZTJlOCBwbHVzIDI4ZWFkM2Vh
YWJjMSB0byB2NS4xNSBhbmQgdjUuMTA/DQpJcyB0aGVyZSBhbnkgbWl0aWdhdGlvbiBmb3IgdGhp
cyBDVkU/DQpJcyB0aGVyZSBhbnkgcmVwcm9kdWNlciBhbmQgdGVzdCBjYXNlIGZvciB0aGlzIENW
RSBzbyB0aGF0IHdlIGNvdWxkIHZhbGlkYXRlIHRoZSBmaXggaWYgd2UgZGVjaWRlIHRvIHBvcnQg
aXQ/DQoNCg==

