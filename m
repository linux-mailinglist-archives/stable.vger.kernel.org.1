Return-Path: <stable+bounces-15765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5F783B8E5
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 06:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD95F286541
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 05:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F49E882A;
	Thu, 25 Jan 2024 05:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="lSKEbwtF"
X-Original-To: stable@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E6679EC
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 05:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706159131; cv=fail; b=U0Dr4E2TSbKeQaHcpFpT05affOdS8ICnrmGKbGuv2YamIqmZ11j5T1XFZb0bsi216ihrhBQCLtUVRHpkFqHF4KPS3+WP0iVWQQCqPGLEV4HccJ1OODknCNAceZyzpg3Ff/hMNcLP5jsMdaSnzAnAfRhvbv9UvY+anYdiRoQw5yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706159131; c=relaxed/simple;
	bh=hqxfEbpAO7VHVONJQ3tCh/1dDP/WjBsthMWkuW106T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gHHy3EuLsjdK7codN77dZZbYU0CeGi/9NUnsZCeQ1hfgVqYF/i3lMJnv/PxwdW+gdVpHq5yK9hk7+2k9DMHXgMAZt1uhgnk4HBxBIIl6O+qBsMDUTQVawaWHB3WLG9vJNtfqSUSSEUfjq/71WvWcksY2spb6Ugr8Y0txAysUSDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com; spf=pass smtp.mailfrom=kunbus.com; dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b=lSKEbwtF; arc=fail smtp.client-ip=40.107.8.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbr9jIhXLCtdyn9QzE3PpBSdIKbYtTd5dpdP62VxFZHD+kUVjTYshaStIdHdcCaGs66PXOUc9Pun03wrxohnG5sNB3SMMr0g0RXHS73FvwF0jhRl2buwpfPwmNf6C33ghWtUk4eQvBRNgC3Qt5ZjBs3vxwQKkEE8x1WlRWoY8COaFH3Wi2jJ914Qben/SCJqB5acjH29b5sFsfflFzA8u63mucJJORB+zl8TdYuLJQcQQmEYZR87MG65smFt0v0I3VfxMsDoqZGp67EqiIRf3pNgj3BPHn7eBLBr7OtYvbcXdEVUO+otmCMdYL2xiYXLZrRlTyvMk546qcy6WEfbYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqxfEbpAO7VHVONJQ3tCh/1dDP/WjBsthMWkuW106T8=;
 b=dyEqeBcyJS6eA84rHxWmOQDd+ohTPds0SgpkeLVq03IFRRBTiUvY+WrMq7iZFc1FUVC6ArlHL6/xCeYbEgTuIdm06xpo55bV5T8xpkhaFxggcTO+PT1TsK3TeguJwmB/1hlR70Sj2P7b0H6w+KPEjz5GSBriY9Mc/Oem56xHnofR5cWUAoGjcxSWyd7Tz1kKy9mKLrZQcN4R7yr5DBAH8kk4ZrGOqxT18xkgWA7LwXP4a355GMwlw5HXBI7JIJDe762N7uGqrP1OTlwu4VLoubyLBlcCIXYiKNywKvSFcOYfAR5SPfLEx1GhBjgrNcmMz+kUQDrBDQpia2n81sFa1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqxfEbpAO7VHVONJQ3tCh/1dDP/WjBsthMWkuW106T8=;
 b=lSKEbwtFN5xVDjFTUzzvhCZGerIwjJYgWa5+qUGhy9Q2+Bz9LZeR/z2Zp5bqzVXEWFNfhARZ7rE1JJ+D3kcKCdSrdDiO639FA+r4wbsh1P3ympCP1N5c/7ddubWeMDoujTQsT2KcrnCA7daPlJqEyJPizIwB5cSF5oj+CTFimUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AS8P193MB1640.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:397::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 05:05:26 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb%7]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 05:05:25 +0000
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
To: stable@vger.kernel.org
Cc: LinoSanfilippo@gmx.de,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.6.y] serial: Do not hold the port lock when setting rx-during-tx GPIO
Date: Thu, 25 Jan 2024 06:04:12 +0100
Message-ID: <20240125050412.4046-1-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024012204-tattered-oxidation-ac0c@gregkh>
References: <2024012204-tattered-oxidation-ac0c@gregkh>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::12) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AS8P193MB1640:EE_
X-MS-Office365-Filtering-Correlation-Id: 273c2cc0-105e-4530-2640-08dc1d633dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ntrOJfD3uLCBpW3UmpzHcufOyeZne995TpN/AWEibDbBy8LchuDyqW1No2EL+FaJfHWW+wRsalA+sa8tje/+8x5GVsOa4oLI2tk9FFukbRMU25o1RLM0uSDLc1MPHWGvMr5iJkff+ewVRYtG7mxA/796a21w84JYL5Ga/ybQqN0VxYto0jmAwhivk4uEeX+fE6e77MK6IHPGq6UoAV5ktzRN02hKlt/lmpsZ6EVsRGlm4oKY2gGMQoJA0fHn7zFYbYHQwCyRZtnws6gYcvDEbPb+dp6tCunJAFC9l4Cw9xw5KqtIZagQ0sglnsoejwqVHcOGdR/fX2dtPnf4MfHFnt7oyToXQgIdxPcFnYzIkUJmWEiRH8FKqL7n+GxZHaY5TlDrRk4aFxMHH9BRS9KKEKusYFojd/ZC1u9E828FSzrdPPUealT+kV2juNwYh8XNfFVqH0jNVazX41gGCqYKWa4grFD1rtKYOaAI6tvoN0OZqFSvMg5ic91QnjlT6QuIeEO40ri5Cyd7BA1Cy500FRvmXff4Wo4vOHi1clMR9K0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39830400003)(396003)(366004)(376002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(41300700001)(83380400001)(1076003)(38100700002)(6512007)(2616005)(4326008)(8676002)(8936002)(5660300002)(52116002)(2906002)(478600001)(6666004)(966005)(6486002)(6506007)(66556008)(54906003)(66476007)(6916009)(66946007)(316002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1DnlqA+L81EvR3tYLsmu3Cnm+Rk2K9vJOHKBQUOLZz84GeYQT4GmsVWieWdr?=
 =?us-ascii?Q?JTVOWhpCIOQTz4+sz2bqfxBUpnKjjtRB0ie/s+iCTUwLAfuDUsumoHR9U+en?=
 =?us-ascii?Q?mtH1igbzXnNYRYGfPaL4oM7HaKKuxSsNLCXAE2oA/hEetAltWwVEV/6DrtLK?=
 =?us-ascii?Q?OSLMtdndptOE5KsbtPZssLAFbcDNVyl22xBb/0LIZCLdNwJT3gpi6yVx5dnz?=
 =?us-ascii?Q?pn0CfyHxwiFEFNvuoOFXe9vLsJEWY5lBxrupwbRyGWC0Ai0YClH/jXreOX/I?=
 =?us-ascii?Q?LEIEm4S9a8GT9aQs6z0xiONRZ33DilWko5b0o92LlcBS2OwM+U/GKHVRsbil?=
 =?us-ascii?Q?MpDUSjKCZBZsAh14iEFJeZsU2rpgns5AnSo0JDWWtOaBRWQjydqr4PkxFwqX?=
 =?us-ascii?Q?McELVS4T0Uh601Z1JBquY8qMVOQ0X8lZSuekjMA5XKwkdDxsSRLIb8mQDcf7?=
 =?us-ascii?Q?R4mz0NIlMnbnbx9G+oMhgZ6Fk7TA5lv8+/M7I8rrVOzNLHOd375Fa/uVMAIK?=
 =?us-ascii?Q?Ip0TWOCKVRe+7qvnx9C7MPIvkEfQTJQdATuJFJl2mX3DYILQrHAE+2tvZQDc?=
 =?us-ascii?Q?G3fLnEljPtD15pASCaCwP+UEDt/dcF6mzpbfA43wp3rchdS0P9ML3o6wOhln?=
 =?us-ascii?Q?FjGWWsNgmAtJfOBkKT4jA1nTyVvWd1e7Mc8sGowP9Q93TAN/Jh0zHBbXyTiM?=
 =?us-ascii?Q?dcy/cH3mDSz5L1NdIaf8MD+ujQ89gNrbVHF/bRMLx4AYoKmtKVqaDYxmh9hF?=
 =?us-ascii?Q?Bg4O6Tb6XzdTBS1LBlBaD3OYoj8ldVPj0pB/WPg4FSoV1rYOPq46EQ45e4jO?=
 =?us-ascii?Q?0VtLB3GSyqCtzAa8MJw+uEjWMO6C9gh8PSxC4I76cvh2bqPHl8yUfHnozLbF?=
 =?us-ascii?Q?MPgLeKDAyyk2AreTP3yelf3XHr9LIZfMNRu6/yZ/lDfBp3UP686xa+LbkTJt?=
 =?us-ascii?Q?avjVpA5qHNnfdd2bDwv7UgZwVjBlPuMOPCXtEtMedkHXX7NiNDUCbAP6lfsM?=
 =?us-ascii?Q?AJaJlm5nfvsdNP91egU8Hj65gxrjoBrFkekouD2Qb97exbUTeC67paJ8g6yJ?=
 =?us-ascii?Q?kF0TSkJGQIL/l/As2PX2Er6kZYuks8rgY/6gPd+R396l5wo5BA72OB2AWt+6?=
 =?us-ascii?Q?EQiN05FGnlPRc5Wvyv2ECYu2ohgyJhpeE8OXa3AogsSy4jIj1WoNFq9EMknT?=
 =?us-ascii?Q?gEpaT18mjXjLgBRW5s22gLJKJrZPuu56UUcu/QrNA5W5F6u1th0nAPcGwtO4?=
 =?us-ascii?Q?ggWKjt2F+bs65tTdQbT6zwlOPq9daZWxCZexmdgNM3LhEcvazF492eznYUtj?=
 =?us-ascii?Q?L662eu3us4aLM4K3WLDxqLk5BnHLGBUjMe8WS+VdRWyLGxBle/+PknAbd0HC?=
 =?us-ascii?Q?SRysrBi+BF1Y9GYL60lw68d+T3xZULwyJQ+o1/68S4vUudLmiKyr5Yo2Pc65?=
 =?us-ascii?Q?d3q0EOgTwjaO4wU/bMh4XPvDtrraquYX6j2UttASk6x2J0aUl6VkSgRcCllh?=
 =?us-ascii?Q?sRcfbuV/iai8jS+CCmsQ2c7IJmdfwwwS/aId08aRIeNTv3uUPNtXyn33CKaK?=
 =?us-ascii?Q?cJpNeYSoUdHQrXYj1NvJ/7MD9AKZA+po4MIZSwytHdXPamC7Axbg5y8o/MJD?=
 =?us-ascii?Q?zIixavWzd2+ckMebW/yf80F33XhylDPoF8xUZNQimdSErCk/HBFw+wxRuFt7?=
 =?us-ascii?Q?8YZC1w=3D=3D?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273c2cc0-105e-4530-2640-08dc1d633dc2
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 05:05:25.6067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVuYg6RMKI9IKsSMcmYCHdNVSMo6lan1XH5Bpa2VuCTdHlzPF4njU13v1ZNuIspaW4kyI3QYvsrRG+MGWJVReg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1640

Qm90aCB0aGUgaW14IGFuZCBzdG0zMiBkcml2ZXIgc2V0IHRoZSByeC1kdXJpbmctdHggR1BJTyBp
biByczQ4NV9jb25maWcoKS4KU2luY2UgdGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgd2l0aCB0aGUg
cG9ydCBsb2NrIGhlbGQsIHRoaXMgY2FuIGJlIGEKcHJvYmxlbSBpbiBjYXNlIHRoYXQgc2V0dGlu
ZyB0aGUgR1BJTyBsaW5lIGNhbiBzbGVlcCAoZS5nLiBpZiBhIEdQSU8KZXhwYW5kZXIgaXMgdXNl
ZCB3aGljaCBpcyBjb25uZWN0ZWQgdmlhIFNQSSBvciBJMkMpLgoKQXZvaWQgdGhpcyBpc3N1ZSBi
eSBtb3ZpbmcgdGhlIEdQSU8gc2V0dGluZyBvdXRzaWRlIG9mIHRoZSBwb3J0IGxvY2sgaW50bwp0
aGUgc2VyaWFsIGNvcmUgYW5kIHRodXMgbWFraW5nIGl0IGEgZ2VuZXJpYyBmZWF0dXJlLgoKQWxz
byB3aXRoIGNvbW1pdCBjNTRkNDg1NDM2ODkgKCJzZXJpYWw6IHN0bTMyOiBBZGQgc3VwcG9ydCBm
b3IgcnM0ODUKUlhfRFVSSU5HX1RYIG91dHB1dCBHUElPIikgdGhlIFNFUl9SUzQ4NV9SWF9EVVJJ
TkdfVFggZmxhZyBpcyBvbmx5IHNldCBpZiBhCnJ4LWR1cmluZy10eCBHUElPIGlzIF9ub3RfIGF2
YWlsYWJsZSwgd2hpY2ggaXMgd3JvbmcuIEZpeCB0aGlzLCB0b28uCgpGdXJ0aGVybW9yZSByZXNl
dCBvbGQgR1BJTyBzZXR0aW5ncyBpbiBjYXNlIHRoYXQgY2hhbmdpbmcgdGhlIFJTNDg1CmNvbmZp
Z3VyYXRpb24gZmFpbGVkLgoKRml4ZXM6IGM1NGQ0ODU0MzY4OSAoInNlcmlhbDogc3RtMzI6IEFk
ZCBzdXBwb3J0IGZvciByczQ4NSBSWF9EVVJJTkdfVFggb3V0cHV0IEdQSU8iKQpGaXhlczogY2E1
MzBjZmE5NjhjICgic2VyaWFsOiBpbXg6IEFkZCBzdXBwb3J0IGZvciBSUzQ4NSBSWF9EVVJJTkdf
VFggb3V0cHV0IEdQSU8iKQpDYzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPgpDYzog
U2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPgpDYzogIDxzdGFibGVAdmdlci5r
ZXJuZWwub3JnPgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0Br
dW5idXMuY29tPgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQwMTAzMDYxODE4
LjU2NC0yLWwuc2FuZmlsaXBwb0BrdW5idXMuY29tClNpZ25lZC1vZmYtYnk6IEdyZWcgS3JvYWgt
SGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+CihjaGVycnkgcGlja2VkIGZyb20g
Y29tbWl0IDA3YzMwZWE1ODYxZmIyNmE3N2RhZGU4Y2RjNzg3MjUyZjYxMjJmYjEpClNpZ25lZC1v
ZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+Ci0tLQogZHJp
dmVycy90dHkvc2VyaWFsL2lteC5jICAgICAgICAgfCAgNCAtLS0tCiBkcml2ZXJzL3R0eS9zZXJp
YWwvc2VyaWFsX2NvcmUuYyB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKy0tCiBkcml2ZXJz
L3R0eS9zZXJpYWwvc3RtMzItdXNhcnQuYyB8ICA4ICsrLS0tLS0tCiAzIGZpbGVzIGNoYW5nZWQs
IDI2IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dHR5L3NlcmlhbC9pbXguYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYwppbmRleCAxM2NiNzgz
NDA3MDkuLmVkYjJlYzZhNTU2NyAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2lteC5j
CisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYwpAQCAtMTk0NywxMCArMTk0Nyw2IEBAIHN0
YXRpYyBpbnQgaW14X3VhcnRfcnM0ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0
cnVjdCBrdGVybWlvcyAqdGVybWlvCiAJICAgIHJzNDg1Y29uZi0+ZmxhZ3MgJiBTRVJfUlM0ODVf
UlhfRFVSSU5HX1RYKQogCQlpbXhfdWFydF9zdGFydF9yeChwb3J0KTsKIAotCWlmIChwb3J0LT5y
czQ4NV9yeF9kdXJpbmdfdHhfZ3BpbykKLQkJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHBvcnQt
PnJzNDg1X3J4X2R1cmluZ190eF9ncGlvLAotCQkJCQkgISEocnM0ODVjb25mLT5mbGFncyAmIFNF
Ul9SUzQ4NV9SWF9EVVJJTkdfVFgpKTsKLQogCXJldHVybiAwOwogfQogCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJp
YWxfY29yZS5jCmluZGV4IGY5MTJmOGJmMWU2My4uNmI0M2VlOTZmMzI2IDEwMDY0NAotLS0gYS9k
cml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwv
c2VyaWFsX2NvcmUuYwpAQCAtMTQwMSw2ICsxNDAxLDE2IEBAIHN0YXRpYyB2b2lkIHVhcnRfc2V0
X3JzNDg1X3Rlcm1pbmF0aW9uKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsCiAJCQkJICEhKHJzNDg1
LT5mbGFncyAmIFNFUl9SUzQ4NV9URVJNSU5BVEVfQlVTKSk7CiB9CiAKK3N0YXRpYyB2b2lkIHVh
cnRfc2V0X3JzNDg1X3J4X2R1cmluZ190eChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LAorCQkJCQlj
b25zdCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1ICpyczQ4NSkKK3sKKwlpZiAoIShyczQ4NS0+ZmxhZ3Mg
JiBTRVJfUlM0ODVfRU5BQkxFRCkpCisJCXJldHVybjsKKworCWdwaW9kX3NldF92YWx1ZV9jYW5z
bGVlcChwb3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhfZ3BpbywKKwkJCQkgISEocnM0ODUtPmZsYWdz
ICYgU0VSX1JTNDg1X1JYX0RVUklOR19UWCkpOworfQorCiBzdGF0aWMgaW50IHVhcnRfcnM0ODVf
Y29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCiB7CiAJc3RydWN0IHNlcmlhbF9yczQ4NSAq
cnM0ODUgPSAmcG9ydC0+cnM0ODU7CkBAIC0xNDEyLDEyICsxNDIyLDE3IEBAIHN0YXRpYyBpbnQg
dWFydF9yczQ4NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkKIAogCXVhcnRfc2FuaXRp
emVfc2VyaWFsX3JzNDg1KHBvcnQsIHJzNDg1KTsKIAl1YXJ0X3NldF9yczQ4NV90ZXJtaW5hdGlv
bihwb3J0LCByczQ4NSk7CisJdWFydF9zZXRfcnM0ODVfcnhfZHVyaW5nX3R4KHBvcnQsIHJzNDg1
KTsKIAogCXNwaW5fbG9ja19pcnFzYXZlKCZwb3J0LT5sb2NrLCBmbGFncyk7CiAJcmV0ID0gcG9y
dC0+cnM0ODVfY29uZmlnKHBvcnQsIE5VTEwsIHJzNDg1KTsKIAlzcGluX3VubG9ja19pcnFyZXN0
b3JlKCZwb3J0LT5sb2NrLCBmbGFncyk7Ci0JaWYgKHJldCkKKwlpZiAocmV0KSB7CiAJCW1lbXNl
dChyczQ4NSwgMCwgc2l6ZW9mKCpyczQ4NSkpOworCQkvKiB1bnNldCBHUElPcyAqLworCQlncGlv
ZF9zZXRfdmFsdWVfY2Fuc2xlZXAocG9ydC0+cnM0ODVfdGVybV9ncGlvLCAwKTsKKwkJZ3Bpb2Rf
c2V0X3ZhbHVlX2NhbnNsZWVwKHBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlvLCAwKTsKKwl9
CiAKIAlyZXR1cm4gcmV0OwogfQpAQCAtMTQ1Niw2ICsxNDcxLDcgQEAgc3RhdGljIGludCB1YXJ0
X3NldF9yczQ4NV9jb25maWcoc3RydWN0IHR0eV9zdHJ1Y3QgKnR0eSwgc3RydWN0IHVhcnRfcG9y
dCAqcG9ydCwKIAkJcmV0dXJuIHJldDsKIAl1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NShwb3J0
LCAmcnM0ODUpOwogCXVhcnRfc2V0X3JzNDg1X3Rlcm1pbmF0aW9uKHBvcnQsICZyczQ4NSk7CisJ
dWFydF9zZXRfcnM0ODVfcnhfZHVyaW5nX3R4KHBvcnQsICZyczQ4NSk7CiAKIAlzcGluX2xvY2tf
aXJxc2F2ZSgmcG9ydC0+bG9jaywgZmxhZ3MpOwogCXJldCA9IHBvcnQtPnJzNDg1X2NvbmZpZyhw
b3J0LCAmdHR5LT50ZXJtaW9zLCAmcnM0ODUpOwpAQCAtMTQ2Nyw4ICsxNDgzLDE0IEBAIHN0YXRp
YyBpbnQgdWFydF9zZXRfcnM0ODVfY29uZmlnKHN0cnVjdCB0dHlfc3RydWN0ICp0dHksIHN0cnVj
dCB1YXJ0X3BvcnQgKnBvcnQsCiAJCQlwb3J0LT5vcHMtPnNldF9tY3RybChwb3J0LCBwb3J0LT5t
Y3RybCk7CiAJfQogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnBvcnQtPmxvY2ssIGZsYWdzKTsK
LQlpZiAocmV0KQorCWlmIChyZXQpIHsKKwkJLyogcmVzdG9yZSBvbGQgR1BJTyBzZXR0aW5ncyAq
LworCQlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocG9ydC0+cnM0ODVfdGVybV9ncGlvLAorCQkJ
ISEocG9ydC0+cnM0ODUuZmxhZ3MgJiBTRVJfUlM0ODVfVEVSTUlOQVRFX0JVUykpOworCQlncGlv
ZF9zZXRfdmFsdWVfY2Fuc2xlZXAocG9ydC0+cnM0ODVfcnhfZHVyaW5nX3R4X2dwaW8sCisJCQkh
IShwb3J0LT5yczQ4NS5mbGFncyAmIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFgpKTsKIAkJcmV0dXJu
IHJldDsKKwl9CiAKIAlpZiAoY29weV90b191c2VyKHJzNDg1X3VzZXIsICZwb3J0LT5yczQ4NSwg
c2l6ZW9mKHBvcnQtPnJzNDg1KSkpCiAJCXJldHVybiAtRUZBVUxUOwpkaWZmIC0tZ2l0IGEvZHJp
dmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc3RtMzIt
dXNhcnQuYwppbmRleCA1ZTljZjBjNDg4MTMuLmI2ZjRmNDM2YTU2NSAxMDA2NDQKLS0tIGEvZHJp
dmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL3N0
bTMyLXVzYXJ0LmMKQEAgLTIyNiwxMiArMjI2LDYgQEAgc3RhdGljIGludCBzdG0zMl91c2FydF9j
b25maWdfcnM0ODUoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IGt0ZXJtaW9zICp0ZXIK
IAogCXN0bTMyX3VzYXJ0X2Nscl9iaXRzKHBvcnQsIG9mcy0+Y3IxLCBCSVQoY2ZnLT51YXJ0X2Vu
YWJsZV9iaXQpKTsKIAotCWlmIChwb3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhfZ3BpbykKLQkJZ3Bp
b2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlvLAotCQkJ
CQkgISEocnM0ODVjb25mLT5mbGFncyAmIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFgpKTsKLQllbHNl
Ci0JCXJzNDg1Y29uZi0+ZmxhZ3MgfD0gU0VSX1JTNDg1X1JYX0RVUklOR19UWDsKLQogCWlmIChy
czQ4NWNvbmYtPmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpIHsKIAkJY3IxID0gcmVhZGxfcmVs
YXhlZChwb3J0LT5tZW1iYXNlICsgb2ZzLT5jcjEpOwogCQljcjMgPSByZWFkbF9yZWxheGVkKHBv
cnQtPm1lbWJhc2UgKyBvZnMtPmNyMyk7CkBAIC0yNTYsNiArMjUwLDggQEAgc3RhdGljIGludCBz
dG0zMl91c2FydF9jb25maWdfcnM0ODUoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IGt0
ZXJtaW9zICp0ZXIKIAogCQl3cml0ZWxfcmVsYXhlZChjcjMsIHBvcnQtPm1lbWJhc2UgKyBvZnMt
PmNyMyk7CiAJCXdyaXRlbF9yZWxheGVkKGNyMSwgcG9ydC0+bWVtYmFzZSArIG9mcy0+Y3IxKTsK
KworCQlyczQ4NWNvbmYtPmZsYWdzIHw9IFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFg7CiAJfSBlbHNl
IHsKIAkJc3RtMzJfdXNhcnRfY2xyX2JpdHMocG9ydCwgb2ZzLT5jcjMsCiAJCQkJICAgICBVU0FS
VF9DUjNfREVNIHwgVVNBUlRfQ1IzX0RFUCk7Ci0tIAoyLjQzLjAKCg==

