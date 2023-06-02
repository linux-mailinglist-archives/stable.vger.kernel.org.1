Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2161E7207A3
	for <lists+stable@lfdr.de>; Fri,  2 Jun 2023 18:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbjFBQdU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 12:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbjFBQdS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 12:33:18 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2052.outbound.protection.outlook.com [40.107.105.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B081E99
        for <stable@vger.kernel.org>; Fri,  2 Jun 2023 09:33:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fv8UFfO8sZmhbEw0wYygfkX66s8m2fU9I8lM9G51WizLdL1iwpZ9tONug0RO6cbXGXsiTm0veSPtaXm5sfpSFezYGzHA5dCdCSnlsdX5ibNBip9Ad8s5f1gWIL71FHysBwChekIVDHlEKvl9X/eWYXHr0GV6BwV3VeI69QmHVgWnIr24l7QF+FaV7GcHDLwBUj61NKNCIvPDeRlZqdz8I57KXDNA/713WNSHQtvjpj68f4rSmozbeMZNzKrfNOfDWH+3aK5pn+rscasT0rbU5RN5zJxQscJ7bKLAJxxTaXDaDz1IAcbkGKmPpsIgBsV3IVNUIITm6KhODEj6jFxJMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dork7dZdknb9T3epQQb32ItY5nWD0RN87uLtkTWsFps=;
 b=KbGjTL4V1UCj2hUyvbj9/auXlKpnZ7wtVFn2uGpx2P/e6PBYvjkhN9u+qsvo2BqI0uF3bX80htLVVRDpxZziDwRMM3PTQOP3lCIKCHqRfCF8meNlGb55RwEPB3JTGRvlFK6PvIA5ljwFbUOsZ7DnQ8rE+zRu3ulvwXBPgxqyCEJTFzY5rDdRS6VtkXzvEbkC+ypZ5gzqRYJSudQCL2wVSGjU9M8sNz+fQTB5KTrSl7wAgpiU1UWIPeKDKqMJBFeVTuL+tVLVRxkydREWC4ZYQk3kH6EiWyVbJJPuSDb0TiolfWSFCpYuKlr+HpE1DAHk5TaW7EAKsN6EIPXOdWSABg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dork7dZdknb9T3epQQb32ItY5nWD0RN87uLtkTWsFps=;
 b=rg0EOIVERYv3GmtCHrd0d+uf7Dj4xEIZAFzg2k2U/WIcrmv6aQxMvIUNlmBoNoyP5bTwwmA8+De0DelIwHcbHHCGMCeDKl7RxU2soKBIL/f1vy/kfZNSpyUNe5VpqBzYFg3YnM29mxbj8QyosG9lbXK1nsHeG9SroQ5dDFlyPHGjfTMBqbSaIjw4GW/2zEDzNCzA/iz+oU7SuVVzSWeL5yE+ONNAEcOjHSQ6x94ogib6ylNfLPbDLQuJD8N+tIyM5ZwX4xHlJrp0+oxVGiTRLJglyOlsWBgXL5YzgZ7+NOJCNInTHMecFGmqKK696H8a4/ySk/kylhDYRJMfbxz/BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB8PR10MB3596.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:134::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 16:33:13 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 16:33:13 +0000
Date:   Fri, 2 Jun 2023 18:33:08 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Matt Roper <matthew.d.roper@intel.com>
Cc:     <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <holger.philipps@siemens.com>, <wagner.dominik@siemens.com>,
        =?UTF-8?B?Sm9zw6k=?= Roberto de Souza <jose.souza@intel.com>
Subject: Re: [PATCH 5.10 0/2] backport i915 fixes to 5.10
Message-ID: <20230602183308.6669c7fe@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230602161408.GN6953@mdroper-desk1.amr.corp.intel.com>
References: <20230602160507.2057-1-henning.schild@siemens.com>
        <20230602161408.GN6953@mdroper-desk1.amr.corp.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::14) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DB8PR10MB3596:EE_
X-MS-Office365-Filtering-Correlation-Id: c499c695-4fbd-4c4a-cf74-08db63870f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+IqWKG3EUs1uoUW5l89osaqBXWajiR26fCpKgs9BEl+mXOOos6l8xFxOKfutNj4WEwBgKQ+cbiRYTIA/sXlAGX5cVzgov8f0E8gXEPlbndvTUy92w3xLscBGl1ZZS+LB4OgN3wB8mtB7/Z/OYNjPJ0aoyETM02PvELA21tFUJlYbnHkKTl9OQHRjfB0hwLXpa9RvrEhHh+nl22IsiS28WIPjHLETcaeDF7Ez0vcq86Bm+UQ0VNthDOG+JAo+TAzV4xwm8Hr92tD3Kr2fKQaCSzMTVDpCNpXyZl9C9pYsWwPSIlDfngDsbP42argF49Rde1oElaUWgILrM5QD7zy5d1f5HpvUIS9BufraHqWOHg5YlwUP8YlTn42KMZReJcgbvlpsuGfoulL2ZGzsAxQ9wlnr0oc1nlm3AlgilP7Yz1VjGQJB098kJK37Qp4AT1pbIJxkJ95Dyy2uOEdBu0bm7SLJeJ+TXNGFy2MgmIZE/6gD3hPI6/8sh+UvK+6v5gH7O8ujJ28224fn8xmCJdaCD4y5G4Mc/e3oO+SYAmzeGE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(82960400001)(38100700002)(86362001)(8936002)(41300700001)(966005)(45080400002)(6512007)(26005)(6506007)(9686003)(5660300002)(44832011)(1076003)(8676002)(186003)(2906002)(83380400001)(66946007)(6486002)(66476007)(6666004)(316002)(54906003)(478600001)(4326008)(6916009)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFJyN2I4QjRZNnRvcTBzYUp2L0d1cW42UlNsQTN4ZnhobzlWcDVpQTZYSGxU?=
 =?utf-8?B?Q1NyTnFIS0ZuRFpRNjE3Z3ZtTk15SHBTSTR3RitzTnFkVnEwd0VDcmZwYlgy?=
 =?utf-8?B?TzRFTks2dkpsM1BHdDZ3V1VjcG1paXA2a0tLTGVIZ092YmFrWE5CcTUxbjdv?=
 =?utf-8?B?N2xtS285S0g5WFZRMnh6SExOU3RsWXdnTEpwZmFDYStwaUZsNTVPb0VSM0xY?=
 =?utf-8?B?VlIrUTBJQWVPY05LaXlSajhnNVd5T2JxM2ZVazQxQy8rK0VPN2J3eEE1SFFX?=
 =?utf-8?B?Y0hOaFRQWm5ObUNTc0FORW9IaUdHK1AySDZ4R0pBeEI0VFJNQktwL2xIcjRU?=
 =?utf-8?B?eE1DYXpMaXVWd1BUazUyTkpqVkJoWU5OOVpwSVRFL01NbmJiOWtTMXdXUllv?=
 =?utf-8?B?dUhYWjRHcm9jSXFaSXBmQVZjMG1kSE81WjdxZ0FWUXk0WTVHMWMrWHlkWjFl?=
 =?utf-8?B?RXFTUnRJa29xMHVTcGd1TGN2ZE9VOEZyVzdGZkZYbENWMyswRjlwcWNYZHYv?=
 =?utf-8?B?QWNpT2pLdUN6RTYzaWg2NG1mMjdIQ2FrQnI1VG1ESlJJSWdDVzZMdHVnYWVu?=
 =?utf-8?B?MDlxS2Nsa08xQjhMcjJiTFBwcllWbGUrM3pXQW5vVDlYYlZXOVM4cUdXK3Qv?=
 =?utf-8?B?endLdEkrU29ubTNwYm1WZWk1QmNKTzVXMVdWUEY3RG9GRDRBeS9FVXhuV040?=
 =?utf-8?B?aEg0eVdnbVpyNVZYQ1NkWmpHOHVodHRtdFEyQVNHM2tBdGVGdENwcnZ5cGx3?=
 =?utf-8?B?cVg1WlhvTGdPOGJaQjdZcjRvU3NUcEFyYzVUMHhLL0xnTVBIRXJXa0NQNi9L?=
 =?utf-8?B?emRxcFF2b3p3YkNJbFRtVVdEQ0d0WHN6U2V0MTR1YjBFWkgzNi9VNHJwRlYw?=
 =?utf-8?B?bWNGZStJS09aRG13UnFzdjlmZzg5UGhTakNBWG85alBLa3p4ZmFOOFoyZnc2?=
 =?utf-8?B?VUFqOHB5ZVE2ZVlDYis5RkNENTM0NGl4cEhqUGdybFBGcVB0akZmdjJwRWVm?=
 =?utf-8?B?aTRWVHE0UWZlT1hrWTFnQnZjVDVIUmZvc24vNDU3clF5djdvRlBlclZraHov?=
 =?utf-8?B?M08wY2crSy91ZjE3TUJtLzRtZjdGbTBCMzIrS1BaZG9uS0U1a2JMZ3VINW5l?=
 =?utf-8?B?RTNGZTU1Qzd2VVZUaVBPWG11RHBHL0d5OUs1ZG05VVl1RE16WSsvOGc0dVRY?=
 =?utf-8?B?amIyZ0tXSVhiNzl0WUt1ZFl4U0ZyZDZGV21aT1Vwek94Ni9PS0ZQNTJHbWp5?=
 =?utf-8?B?dFNaeFhPRGE2L21tMU5nSVd2Mi9ITTVoMDdGaUh0TFFSUElFQnpXcmpkeW9F?=
 =?utf-8?B?NUU5aWgvZ3ExbHNUdzJMWXpSbUdNTXo3T05KTlA1enRxcjlnY3hsUHQ0TThL?=
 =?utf-8?B?YjRxck1qK0ZOd3NyZUFhaFZsbnBzMlVzNnhLMjNZYnBTYTNNVHV5Qi90MG8x?=
 =?utf-8?B?bnlDY2xidWRVOUZSbEZJUDlhQ2hQSzBZNnRqc1FQY1phbTNqSENGT29tenJs?=
 =?utf-8?B?dkx1d1MyTlF3WGR5YWpzZFlaRWFGYjNESzVrU3AvVFVuNnlUVis5cXQ2Nnl1?=
 =?utf-8?B?SDh4UmU1bkhDZ0Zoek1OMTJWV3VJVUExRWFNZTZ6YXlXdnZPdW1vbis3RWJw?=
 =?utf-8?B?VWxqTFB2MDRGZnA5NSs5cUJTakdoaTBwQW5jNkFWOWw4ZWU4V0JQWWNyaXlQ?=
 =?utf-8?B?Q3luTnlmNTdUd0kvOVdqaEFrZnVaNnVNTkpkemVXUkxiL0JDUkNVWTVFV1Yx?=
 =?utf-8?B?aTg1V1IwVGQrRWJ3ZjJqOEYrVzNUY0d1K0ZEbDdra3puLzhleS9ITDB0amFC?=
 =?utf-8?B?RHFha2wwaGQ1d2JVVW10eGw4S2dNSzN4UFhrYXlmZkh6UXBQT3Z0Y2JiTVdU?=
 =?utf-8?B?SHdNQmU0cmFOcUc4YUpSN1l2YldKdU8xKzJzOWd1WkxQWmtvUGRUT1BkY3JM?=
 =?utf-8?B?WlJ3NHA4azJZTFBncjJncitnaVNUU0lWM2NZckkyb240WGhRZ215TnhucEpH?=
 =?utf-8?B?b0FZM1R6emZiWEZYTEQ0OHBQemtPN2REMlFiM0ltelVUSmkrYjBsOWU2VXdz?=
 =?utf-8?B?WnpjSmQ4MHdOUTcxZE9iaHE5ZW4xQWE3bnFYdmNZMTNScVRKVlJmUjIyTFRX?=
 =?utf-8?B?RmxuNFVGU3dZeEwvY0MwTmVuRGNnTkt3eGh3WDJZYk1sUllOYTdDd1lqVlho?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c499c695-4fbd-4c4a-cf74-08db63870f0c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 16:33:12.9195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlkRvx2mQq5Q/BP4Qz6COjtg+Azz+oa9eOJ9UvkBc4GEwfCgZWehe5jb5B9d0Kq+OEPNHssO6Dw2zfjH4u0FJSXLI7FiBCZcPD42nSFVz8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3596
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Am Fri, 2 Jun 2023 09:14:08 -0700
schrieb Matt Roper <matthew.d.roper@intel.com>:

> On Fri, Jun 02, 2023 at 06:05:05PM +0200, Henning Schild wrote:
> > This fixes the following problem which was seen on a Tigerlake
> > running Debian 10 with a 5.10 kernel.
> >=20
> > [  111.408631] Missing case (val =3D=3D 65535)
> > [  111.408698] WARNING: CPU: 2 PID: 446 at
> > drivers/gpu/drm/i915/intel_dram.c:95
> > skl_dram_get_dimm_info+0x72/0x1a0 [i915] [  111.408699] Modules
> > linked in: intel_powerclamp coretemp i915(+) joydev kvm_intel kvm
> > hid_generic irqbypass crc32_pclmul snd_hda_intel
> > ghash_clmulni_intel snd_intel_dspcfg snd_hda_codec aesni_intel
> > glue_helper crypto_simd cryptd snd_hwdep snd_hda_core
> > drm_kms_helper uas snd_pcm usb_storage intel_cstate mei_wdt
> > mei_hdcp snd_timer scsi_mod usbhid hid cec wdat_wdt snd mei_me
> > evdev mei intel_uncore rc_core watchdog pcspkr soundcore video
> > acpi_pad acpi_tad button drm fuse configfs loop(+) efi_pstore
> > efivarfs ip_tables x_tables autofs4 ext4 crc32c_generic crc16
> > mbcache jbd2 dm_mod xhci_pci xhci_hcd marvell dwmac_intel stmmac
> > igb e1000e usbcore nvme nvme_core pcs_xpcs phylink libphy
> > i2c_algo_bit t10_pi dca crc_t10dif crct10dif_generic intel_lpss_pci
> > ptp vmd intel_lpss i2c_i801 crct10dif_pclmul pps_core
> > crct10dif_common idma64 usb_common crc32c_intel i2c_smbus [
> > 111.408755] CPU: 2 PID: 446 Comm: (udev-worker) Not tainted
> > 5.10.180 #2 [  111.408756] Hardware name: SIEMENS AG SIMATIC
> > IPC427G/no information, BIOS T29.01.02.D3.0 10/11/2022 [
> > 111.408797] RIP: 0010:skl_dram_get_dimm_info+0x72/0x1a0 [i915] [
> > 111.408799] Code: 01 00 00 0f 84 31 01 00 00 66 3d 00 01 0f 84 27
> > 01 00 00 41 0f b7 d0 48 c7 c6 ba 81 7c c1 48 c7 c7 be 81 7c c1 e8
> > d2 75 89 fa <0f> 0b c6 45 01 00 44 0f b6 4d 00 31 f6 b9 01 00 00 00
> > c1 fb 09 83 [  111.408801] RSP: 0018:ffffa23a40b53b10 EFLAGS:
> > 00010286 [  111.408802] RAX: 0000000000000000 RBX: 000000000000ffff
> > RCX: 0000000000000027 [  111.408803] RDX: ffff947b278a0908 RSI:
> > 0000000000000001 RDI: ffff947b278a0900 [  111.408804] RBP:
> > ffffa23a40b53b78 R08: 0000000000000000 R09: ffffa23a40b53920 [
> > 111.408805] R10: ffffa23a40b53918 R11: 0000000000000003 R12:
> > 0000000000000000 [  111.408806] R13: 000000000000004c R14:
> > ffff9479b1a00000 R15: ffff9479b1a00000 [  111.408808] FS:
> > 00007ff9626478c0(0000) GS:ffff947b27880000(0000)
> > knlGS:0000000000000000 [  111.408809] CS:  0010 DS: 0000 ES: 0000
> > CR0: 0000000080050033 [  111.408810] CR2: 0000555753cbf15c CR3:
> > 0000000108432002 CR4: 0000000000770ee0 [  111.408810] PKRU:
> > 55555554 [  111.408811] Call Trace: [  111.408854]
> > skl_dram_get_channel_info+0x24/0x160 [i915] [  111.408892]
> > intel_dram_detect+0xef/0x630 [i915] [  111.408931]
> > i915_driver_probe+0xb18/0xc40 [i915] [  111.408969]  ?
> > i915_pci_probe+0x3f/0x160 [i915] [  111.408973]
> > local_pci_probe+0x3b/0x80 [  111.408975]
> > pci_device_probe+0xfc/0x1b0 [  111.408979]
> > really_probe+0x26e/0x460 [  111.408981]
> > driver_probe_device+0xb4/0x100 [  111.408983]
> > device_driver_attach+0xa9/0xb0 [  111.408984]  ?
> > device_driver_attach+0xb0/0xb0 [  111.408985]
> > __driver_attach+0xa1/0x140 [  111.408987]  ?
> > device_driver_attach+0xb0/0xb0 [  111.408989]
> > bus_for_each_dev+0x84/0xd0 [  111.408991]
> > bus_add_driver+0x13e/0x200 [  111.408993]
> > driver_register+0x89/0xe0 [  111.409036]  i915_init+0x60/0x75
> > [i915] [  111.409038]  ? 0xffffffffc18b8000 [  111.409041]
> > do_one_initcall+0x56/0x1f0 [  111.409044]
> > do_init_module+0x4a/0x240 [  111.409047]
> > __do_sys_finit_module+0xaa/0x110 [  111.409050]
> > do_syscall_64+0x30/0x40 [  111.409053]
> > entry_SYSCALL_64_after_hwframe+0x61/0xc6 [  111.409054] RIP:
> > 0033:0x7ff962d534f9 [  111.409056] Code: 08 89 e8 5b 5d c3 66 2e 0f
> > 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89
> > c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b
> > 0d d7 08 0d 00 f7 d8 64 89 01 48 [  111.409057] RSP:
> > 002b:00007fff57caf5d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139 [
> >  111.409058] RAX: ffffffffffffffda RBX: 0000555753cad120 RCX:
> > 00007ff962d534f9 [  111.409059] RDX: 0000000000000000 RSI:
> > 00007ff962ee6efd RDI: 0000000000000010 [  111.409060] RBP:
> > 00007ff962ee6efd R08: 0000000000000000 R09: 0000555753c7a320 [
> > 111.409061] R10: 0000000000000010 R11: 0000000000000246 R12:
> > 0000000000020000 [  111.409062] R13: 0000000000000000 R14:
> > 0000555753ca4f30 R15: 0000555752d40e4f [  111.409064] ---[ end
> > trace 2da6ec0bd6f7c3a1 ]---
> >=20
> >=20
> > Jos=C3=A9 Roberto de Souza (1):
> >   drm/i915/gen11+: Only load DRAM information from pcode
> >=20
> > Matt Roper (1):
> >   drm/i915/dg1: Wait for pcode/uncore handshake at startup =20
>=20
> This second patch should only be needed for discrete GPUs (none of
> which are fully enabled on a 5.10 kernel).  Are you seeing it cause a
> change in behavior on an integrated TGL platform?

When i started looking at things i thought it would be a bisect job,
because Debian 12 with 6.1 is not affected.
Then i found a ubuntu bug and basically just applied the patch that bug
was talking about (p2)

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1933274

which needs p1 for that new function

Having both applied the problem i did see is indeed gone. Not that i
understand what that code does in depth.

I think it is Tigerlake but i always have a hard time with the "lakes"

CPU:
Intel(R) Xeon(R) W-11865MLE @ 1.50GHz

which to me suggests "discrete GPU"

Henning

>=20
> Matt
>=20
> >=20
> >  drivers/gpu/drm/i915/display/intel_bw.c | 80
> > +++--------------------- drivers/gpu/drm/i915/i915_drv.c         |
> > 4 ++ drivers/gpu/drm/i915/i915_drv.h         |  1 +
> >  drivers/gpu/drm/i915/i915_reg.h         |  3 +
> >  drivers/gpu/drm/i915/intel_dram.c       | 82
> > ++++++++++++++++++++++++- drivers/gpu/drm/i915/intel_sideband.c   |
> > 15 +++++ drivers/gpu/drm/i915/intel_sideband.h   |  2 +
> >  7 files changed, 114 insertions(+), 73 deletions(-)
> >=20
> > --=20
> > 2.39.3
> >=20
> >  =20
>=20

