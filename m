Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3743E72081B
	for <lists+stable@lfdr.de>; Fri,  2 Jun 2023 19:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbjFBRDh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 13:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbjFBRD3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 13:03:29 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3911E48
        for <stable@vger.kernel.org>; Fri,  2 Jun 2023 10:03:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3iwzTOQGsT+ss2hWUA1EyJE976uhUJSRs1ySilh27skNNHpRsaaych1iEFFlcyqr761QrjHqH4xSQA25sNulE7nMkn60mt9avXdcHomK+BrOtYHF6gjO+qaT33JHbvcEJ8BJOcY0PEfa1zEh2tZiYbHyBCWkCGMo6JOjFznSJEPyVrihSY9tHEh3CIPSf1gbcJk13IkbHZKFMNAO5agmwO959QYqtTi+KyrmgZTwZS1OumxcV9qsPyfOXcxtZV4kDRxYW7q8rbPPFEE2TeCo3sLqv3UwFYEmhjDCwF0OiMbIuNSd4eBq4IT3OKyosoE0pJJP8ljdOIZ/LxppyjoEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+iZj/Yy3d+qE9ffzZEy5wyJ1166tBXObevu+BsK7qo=;
 b=A115BPg9FSMU7m9NtDk3zKvq58JcKVvZ4AetiwvHURaaWeqnFliWLSFekGrIJ2NeUA5BDFPBXgWJ/otz/FW7z+y7wpr8P3BZsbSk4Ui6OJbNm0cTq/fEt9qyOaz3nyyjfrjaOaStqKhwhIdvLh+KfUH3URCBrU+0GtN2BmyZ6sEN0Dy8XZpGcgz0IdMNiB36352iCrDBR3lvqRnBNSASkOo+YdcHoDYcspwKtqqi/r66PHu+6bpNXqgy9bSkVpsKK5FlLEhI7JOnwhBs6JGcF36qzmWW5PnYOfzwXMmt2HAXypH6VLuvl84Bw//Lh2Q9HkQDhjAuJ4fcQIC0zY5VoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+iZj/Yy3d+qE9ffzZEy5wyJ1166tBXObevu+BsK7qo=;
 b=LA20M6BsJju3k1bZJwMpDTAPTEj7lqw/6l/J3lnae+1CUe2wQwQzxSHLqEjB2Kh0XAUL7nbgudsvOWPhrnnkSFR9Olii+SGQATVN1p5UBZGKHJ9rK3DKzFDKwugxyvyAWUnxxqUVDuuoQgKlAtUXqGJj8DmCZ285Ia8PbTWMEFB8JRkucpF1KdOJdMnkw/bgjorwfE1dq9B7aM276hKGC4EK9UPnomYGML2o8YIAhd7p0D7clZR33HDDGI7Tuy7DQrTkZUnLm/THnG+62mqYSv02MJPn1RYtkmfjmzadm6xZoowPuSU9OaIyqk/R01OhqitwrGvPvsr6wL9RaIyA5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ed::13)
 by DB4PR10MB7518.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 17:03:17 +0000
Received: from DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::683:af5a:6b6e:c6b7]) by DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::683:af5a:6b6e:c6b7%7]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 17:03:17 +0000
Date:   Fri, 2 Jun 2023 19:03:09 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     "Souza, Jose" <jose.souza@intel.com>
Cc:     "Roper, Matthew D" <matthew.d.roper@intel.com>,
        "Wagner, Dominik" <wagner.dominik@siemens.com>,
        "holger.philipps@siemens.com" <holger.philipps@siemens.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.10 0/2] backport i915 fixes to 5.10
Message-ID: <20230602190309.09e2f39e@md1za8fc.ad001.siemens.net>
In-Reply-To: <bfd9ed85b0c4c58a8ad830462271da3195d23ac5.camel@intel.com>
References: <20230602160507.2057-1-henning.schild@siemens.com>
        <20230602161408.GN6953@mdroper-desk1.amr.corp.intel.com>
        <20230602183308.6669c7fe@md1za8fc.ad001.siemens.net>
        <bfd9ed85b0c4c58a8ad830462271da3195d23ac5.camel@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:610:58::33) To DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2ed::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5762:EE_|DB4PR10MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 957fe224-994b-450d-b467-08db638b4275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIsxk34iWmKscjEwXaSvwGHtZlfCOD/I+UdBwhxQNHFeRkiDwJZXv+8yi1UM73+rJSKNgtKmM/Lr4w2kMLgYzuOdsun8Vi7ncTkLb9VSTw+ZU1+dpGDp9spTclI4rl+Jk5c2TqEQEqgKiRSCCllm3WDzseiPR7zClUlAesNkA9XlkChdg+G/nNRC/foSY5hwQ4r+z4+3YjGJl1smuMus3ShQJIo/XEzq54WHTP7XR/4LOuoXvVQzowsm/Ew7FTryFT4RZmz1POleDm/EDlZEWvdqNrpBFzYeFrOEKfJuTw+vdkBW75TBmhjXe86RFxnLTG4yozxg8HOoz8fYmSHbJhCzQdTIWI4TRcthQ3R8ljsFyNebBzAeuoX22NNL9oxqToU723FIOnjzZ/0R+6rHSl5YNfiAbQ14bXFGM8khyHzcQ7zCtQfVDhOgbXxqNOkuEVIxyV069rn0GPRnMKpHws95NlvHj+9ADMEF3Wg3rVQt006qySEYaXGJvlcBMKqyordRD7PZw0q0IAMk3EXc0MZUz2O+K3UjzdUog3n9X6E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199021)(6506007)(6512007)(9686003)(1076003)(86362001)(186003)(66946007)(66556008)(66476007)(6916009)(4326008)(5660300002)(8936002)(8676002)(478600001)(83380400001)(2906002)(6486002)(45080400002)(38100700002)(44832011)(966005)(82960400001)(316002)(54906003)(26005)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RS9MbE42b21ycEpKMml3by9MRHpjWlVKcUQwd1lVNU9PRXl6akhzNktJdFNa?=
 =?utf-8?B?bkkyd01FWUNzTXVwVzFPd0l2akJMMXBEVDVBOUp1MGcvUnJOVUU0MlgyQXM4?=
 =?utf-8?B?MklIakhyZm41ZEZZTjhhV3ZUTnRDZHVzMTFPY2Y4UXpXMXJJQVNVUG54TEYy?=
 =?utf-8?B?d1ExN0xORk41SEJxcnN6VUxBNDRDemNYTkUrc240ci9JQnprRG5ndERranlz?=
 =?utf-8?B?ODlmbm00cy83emU2Tm0vTWhiZXNDNEJrbURDVW9GcGRpSzFpQmVEOGR3K3Jo?=
 =?utf-8?B?R0xYTDY5QUFGZnY4ZlpJOGx4eGxvSDluWnkxdkZhcWRsNlZSYnFTdFQ5UHl1?=
 =?utf-8?B?ZDJUMVFxM1dKYytIV1RoUHhVZlZNcnlabjF5eUZZYU80TUdBejBVN0xsczMy?=
 =?utf-8?B?ZEc0YTQyVXRSQUIxM2hJeHZQZHBodWhjYTlaazRhTUNMTll3QmtuYmpkemJ1?=
 =?utf-8?B?NUsxQ0ZwVlBQZHB2NEw1aWhmZ01LYzM4RlBPTXVsRHN3c09ibGwyR1FQNUhY?=
 =?utf-8?B?a2FCdXZwSVhhMTE0RDF6ZmJZbTBSQnBVT0tranozYlNKbXpWNENPY2VFYlZt?=
 =?utf-8?B?a29VT3hGLzhNUXg3d0NZUURTTDdVWUZYRGNHaTVHVmVuYU5Ua1BKZEdOejly?=
 =?utf-8?B?N0VkWEFqK2pvUzhYLzN2SE04Q0dTL3hTeTM3YzVQS0k3L2g3Nkw5Ukp5UVFn?=
 =?utf-8?B?VkFyRU8wdExCTGx5V3NNdzZCNDcwUDFlT0VkVGpSTENvcExoUWJLRG00Mk1r?=
 =?utf-8?B?eFloSjliVTBXWkI1bVJMZ0l4cmhEME9aSHpDREVuak9UdlFkRkVnRW50TmJa?=
 =?utf-8?B?VVVZdno5SDVqaUFQeDNNdGtEaHY5SjFyQWdxMmtZTytCSlltZ0JCS1RNMHBh?=
 =?utf-8?B?SzRFdEk2eWJydU04ZVpwcVRDb1ZxaUVBdkwxWkNvTlNUZHpkNTYrNmgwd3R2?=
 =?utf-8?B?UTB5TitiS1QrTHg4a2EwYlJFZFFsME1FVG5JN1RrQ213andNYlg4dlZwTUFz?=
 =?utf-8?B?OHAra09LZC9GOXlxQU1SLzRKMHd6bUs2UFVJRk5vYnhjQU5ydmszMzRMOEZz?=
 =?utf-8?B?bkZteVloYS9PeW45TmNERDI3V3JwQnJhQUJrZVRNdlhRUW56WHhLRVozVFpx?=
 =?utf-8?B?d1IxRm5ZSFoxcXFHMVlqK2M5NVB3OGIza0VHK2ZwL3ZDeENPU1ovUkZNd005?=
 =?utf-8?B?enRZcWVseG8rR2krbzBxUmFWUzJxQWJSQ0RDcG45b01MUTQ3dEVlZ0dQaitG?=
 =?utf-8?B?TVFtNzl0NXlpVitwSG9YamFQbmFlVHFlN0NwdmRuemRENWFCR0RhY2xNNDJE?=
 =?utf-8?B?NjlPeHdZOVJWM3RQd045Q21vRW1ybm5JK1RYM2cyNFFKeGZqcnhEUTVuTHk1?=
 =?utf-8?B?SXI1VTRuVGZIc28rc1BBWklSSXZjVmVUeXZ0d3N4dmZING5oNHlub0tzYUpM?=
 =?utf-8?B?VXVSV1VQcHZVVXg1dzI1ZU1Cc0oxY3ppR2d3cG8vRktOcEZlcnBmUFRGYTNM?=
 =?utf-8?B?T0UvNDMrVUx4cGZUaU5CSm9ZOUpGOU1EQlNYbTBUYXdJWlFQZGJsNGJiYkIr?=
 =?utf-8?B?MGNPdTE1SjMxUk1SZ29IQ3V3YlR2VjNjMjhNV0hUSkNjOTlndWR5UVAra1hu?=
 =?utf-8?B?RGg0NjZYdFVVTXFLeklmOGRqVHJaTy9VL0ZTNk5yeS8rSGRTSzhFK3FnQzRE?=
 =?utf-8?B?RjNveksxUW5tVEFBTG5kbTlBZXJIZUVHUWVQS2dIalowVDVqRXBjWXVjY2ll?=
 =?utf-8?B?R1JtV3JqU1FyVlpERW52RTZYOEdKRWJrd0l5Zk5FQVhaZ1VGN1g1Z0NhVHhv?=
 =?utf-8?B?elNWQldZbitaYmI5empGWmgrU0lmKzBqOGhFbzlqQ2pON1pEVWpnekd3NjZK?=
 =?utf-8?B?dTd4Y1lKUlpUT2Q4bUVwNitvR0hVQm9FMjZvTllRK201M1JmQnVNYUdlVzZi?=
 =?utf-8?B?MFR6MDVBYmVHakpVTmtuZ0MrekRZVC9tbGpvNWJMQjh0aHlGSFlCVFlIRzA0?=
 =?utf-8?B?bWpXVFJzOGFreVdjUDdvVDg2TGg0ZjlQKzArRnpoU25pSVJNSGdaazFrUHdx?=
 =?utf-8?B?N1hwb1hsOEszRy9pRlBlZ0RNYWltWkFwb1d0T2IyYmFWakxFVWdsYUtKS0gv?=
 =?utf-8?B?eG9TNnRNNTZBQUtjNExWc0graEZVY01SZ205N0VjMUxLRTArN2JsSzRvS2tI?=
 =?utf-8?B?cmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957fe224-994b-450d-b467-08db638b4275
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 17:03:17.3236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEk9tQ2C1QPqAWfqdqGjFuwsAzbvcqPquStpcmux8h/7rebKai/vnuAaOPFO3/nSaDtJp1F704kUJFPBlNZ/OGKkkSvNs3mQEr3JOvoXB+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7518
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

Am Fri, 2 Jun 2023 16:43:54 +0000
schrieb "Souza, Jose" <jose.souza@intel.com>:

> On Fri, 2023-06-02 at 18:33 +0200, Henning Schild wrote:
> > Am Fri, 2 Jun 2023 09:14:08 -0700
> > schrieb Matt Roper <matthew.d.roper@intel.com>:
> >  =20
> > > On Fri, Jun 02, 2023 at 06:05:05PM +0200, Henning Schild wrote: =20
> > > > This fixes the following problem which was seen on a Tigerlake
> > > > running Debian 10 with a 5.10 kernel.
> > > >=20
> > > > [  111.408631] Missing case (val =3D=3D 65535)
> > > > [  111.408698] WARNING: CPU: 2 PID: 446 at
> > > > drivers/gpu/drm/i915/intel_dram.c:95
> > > > skl_dram_get_dimm_info+0x72/0x1a0 [i915] [  111.408699] Modules
> > > > linked in: intel_powerclamp coretemp i915(+) joydev kvm_intel
> > > > kvm hid_generic irqbypass crc32_pclmul snd_hda_intel
> > > > ghash_clmulni_intel snd_intel_dspcfg snd_hda_codec aesni_intel
> > > > glue_helper crypto_simd cryptd snd_hwdep snd_hda_core
> > > > drm_kms_helper uas snd_pcm usb_storage intel_cstate mei_wdt
> > > > mei_hdcp snd_timer scsi_mod usbhid hid cec wdat_wdt snd mei_me
> > > > evdev mei intel_uncore rc_core watchdog pcspkr soundcore video
> > > > acpi_pad acpi_tad button drm fuse configfs loop(+) efi_pstore
> > > > efivarfs ip_tables x_tables autofs4 ext4 crc32c_generic crc16
> > > > mbcache jbd2 dm_mod xhci_pci xhci_hcd marvell dwmac_intel stmmac
> > > > igb e1000e usbcore nvme nvme_core pcs_xpcs phylink libphy
> > > > i2c_algo_bit t10_pi dca crc_t10dif crct10dif_generic
> > > > intel_lpss_pci ptp vmd intel_lpss i2c_i801 crct10dif_pclmul
> > > > pps_core crct10dif_common idma64 usb_common crc32c_intel
> > > > i2c_smbus [ 111.408755] CPU: 2 PID: 446 Comm: (udev-worker) Not
> > > > tainted 5.10.180 #2 [  111.408756] Hardware name: SIEMENS AG
> > > > SIMATIC IPC427G/no information, BIOS T29.01.02.D3.0 10/11/2022 [
> > > > 111.408797] RIP: 0010:skl_dram_get_dimm_info+0x72/0x1a0 [i915] [
> > > > 111.408799] Code: 01 00 00 0f 84 31 01 00 00 66 3d 00 01 0f 84
> > > > 27 01 00 00 41 0f b7 d0 48 c7 c6 ba 81 7c c1 48 c7 c7 be 81 7c
> > > > c1 e8 d2 75 89 fa <0f> 0b c6 45 01 00 44 0f b6 4d 00 31 f6 b9
> > > > 01 00 00 00 c1 fb 09 83 [  111.408801] RSP:
> > > > 0018:ffffa23a40b53b10 EFLAGS: 00010286 [  111.408802] RAX:
> > > > 0000000000000000 RBX: 000000000000ffff RCX: 0000000000000027 [
> > > > 111.408803] RDX: ffff947b278a0908 RSI: 0000000000000001 RDI:
> > > > ffff947b278a0900 [  111.408804] RBP: ffffa23a40b53b78 R08:
> > > > 0000000000000000 R09: ffffa23a40b53920 [ 111.408805] R10:
> > > > ffffa23a40b53918 R11: 0000000000000003 R12: 0000000000000000 [
> > > > 111.408806] R13: 000000000000004c R14: ffff9479b1a00000 R15:
> > > > ffff9479b1a00000 [  111.408808] FS: 00007ff9626478c0(0000)
> > > > GS:ffff947b27880000(0000) knlGS:0000000000000000 [  111.408809]
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [
> > > > 111.408810] CR2: 0000555753cbf15c CR3: 0000000108432002 CR4:
> > > > 0000000000770ee0 [  111.408810] PKRU: 55555554 [  111.408811]
> > > > Call Trace: [  111.408854] skl_dram_get_channel_info+0x24/0x160
> > > > [i915] [  111.408892] intel_dram_detect+0xef/0x630 [i915] [
> > > > 111.408931] i915_driver_probe+0xb18/0xc40 [i915] [  111.408969]
> > > >  ? i915_pci_probe+0x3f/0x160 [i915] [  111.408973]
> > > > local_pci_probe+0x3b/0x80 [  111.408975]
> > > > pci_device_probe+0xfc/0x1b0 [  111.408979]
> > > > really_probe+0x26e/0x460 [  111.408981]
> > > > driver_probe_device+0xb4/0x100 [  111.408983]
> > > > device_driver_attach+0xa9/0xb0 [  111.408984]  ?
> > > > device_driver_attach+0xb0/0xb0 [  111.408985]
> > > > __driver_attach+0xa1/0x140 [  111.408987]  ?
> > > > device_driver_attach+0xb0/0xb0 [  111.408989]
> > > > bus_for_each_dev+0x84/0xd0 [  111.408991]
> > > > bus_add_driver+0x13e/0x200 [  111.408993]
> > > > driver_register+0x89/0xe0 [  111.409036]  i915_init+0x60/0x75
> > > > [i915] [  111.409038]  ? 0xffffffffc18b8000 [  111.409041]
> > > > do_one_initcall+0x56/0x1f0 [  111.409044]
> > > > do_init_module+0x4a/0x240 [  111.409047]
> > > > __do_sys_finit_module+0xaa/0x110 [  111.409050]
> > > > do_syscall_64+0x30/0x40 [  111.409053]
> > > > entry_SYSCALL_64_after_hwframe+0x61/0xc6 [  111.409054] RIP:
> > > > 0033:0x7ff962d534f9 [  111.409056] Code: 08 89 e8 5b 5d c3 66
> > > > 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89
> > > > ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> > > > 73 01 c3 48 8b 0d d7 08 0d 00 f7 d8 64 89 01 48 [  111.409057]
> > > > RSP: 002b:00007fff57caf5d8 EFLAGS: 00000246 ORIG_RAX:
> > > > 0000000000000139 [ 111.409058] RAX: ffffffffffffffda RBX:
> > > > 0000555753cad120 RCX: 00007ff962d534f9 [  111.409059] RDX:
> > > > 0000000000000000 RSI: 00007ff962ee6efd RDI: 0000000000000010 [
> > > > 111.409060] RBP: 00007ff962ee6efd R08: 0000000000000000 R09:
> > > > 0000555753c7a320 [ 111.409061] R10: 0000000000000010 R11:
> > > > 0000000000000246 R12: 0000000000020000 [  111.409062] R13:
> > > > 0000000000000000 R14: 0000555753ca4f30 R15: 0000555752d40e4f [
> > > > 111.409064] ---[ end trace 2da6ec0bd6f7c3a1 ]---
> > > >=20
> > > >=20
> > > > Jos=C3=A9 Roberto de Souza (1):
> > > >   drm/i915/gen11+: Only load DRAM information from pcode
> > > >=20
> > > > Matt Roper (1):
> > > >   drm/i915/dg1: Wait for pcode/uncore handshake at startup   =20
> > >=20
> > > This second patch should only be needed for discrete GPUs (none of
> > > which are fully enabled on a 5.10 kernel).  Are you seeing it
> > > cause a change in behavior on an integrated TGL platform? =20
> >=20
> > When i started looking at things i thought it would be a bisect job,
> > because Debian 12 with 6.1 is not affected.
> > Then i found a ubuntu bug and basically just applied the patch that
> > bug was talking about (p2)
> >=20
> > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1933274
> >=20
> > which needs p1 for that new function
> >=20
> > Having both applied the problem i did see is indeed gone. Not that i
> > understand what that code does in depth.
> >=20
> > I think it is Tigerlake but i always have a hard time with the
> > "lakes"
> >=20
> > CPU:
> > Intel(R) Xeon(R) W-11865MLE @ 1.50GHz =20
>=20
> W-11865MLE integrated GPU.

That second patch makes the problem i did see go away. Whether it is
the correct solution is nothing i can judge and i hope you can help
with that.

The problem is the WARNING coming 4 times at every bootup.

i915 0000:00:02.0: vgaarb: deactivate vga console
...
## 4 x WARNING
...
i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=3Dio+mem,decodes=
=3Dio+mem:owns=3Dio+mem

And a short flicker on the screen, likely at that time.

Seen on 5.10.180 and 5.10.162, gone with applying these two patches and
gone in 6.1.

regards,
Henning

> >=20
> > which to me suggests "discrete GPU"
> >=20
> > Henning
> >  =20
> > >=20
> > > Matt
> > >  =20
> > > >=20
> > > >  drivers/gpu/drm/i915/display/intel_bw.c | 80
> > > > +++--------------------- drivers/gpu/drm/i915/i915_drv.c
> > > >  | 4 ++ drivers/gpu/drm/i915/i915_drv.h         |  1 +
> > > >  drivers/gpu/drm/i915/i915_reg.h         |  3 +
> > > >  drivers/gpu/drm/i915/intel_dram.c       | 82
> > > > ++++++++++++++++++++++++- drivers/gpu/drm/i915/intel_sideband.c
> > > >   | 15 +++++ drivers/gpu/drm/i915/intel_sideband.h   |  2 +
> > > >  7 files changed, 114 insertions(+), 73 deletions(-)
> > > >=20
> > > > --=20
> > > > 2.39.3
> > > >=20
> > > >    =20
> > >  =20
> >  =20
>=20

