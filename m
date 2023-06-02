Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70ABA720738
	for <lists+stable@lfdr.de>; Fri,  2 Jun 2023 18:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbjFBQRB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 12:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbjFBQQ7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 12:16:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37757E66
        for <stable@vger.kernel.org>; Fri,  2 Jun 2023 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685722605; x=1717258605;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=axiYM/31LKQipk98sW6TYIqyvUJYbsUfJPLlUNcqfV8=;
  b=if5OYwGy88VGJQ3MM5pRkKf2FpqTcXuGKGxVkDnoSoPAik/NIE9YBC8n
   OIn8MT3yRHAdwM4N+kAUJrN/8kVex3j/mhEsdTxKfYh2MTeI5vEicpTKJ
   sJMIakHxuYPMT5L8yGLeeEHAzSEOO/pBHicxZZFWxFRAko8JE8nMqIyZ0
   I9HJGLGLfHu9I89qNfSWIxUcGtwGUZHLQKWvVdKg19Cx+Sf8WPdFlJYuX
   rYIUM2Mbr4XQzyJu0r8FyZ/bE4vZ2jM5nOQn3TVwwHyFdDiLG2OKUrwz7
   YKIer5ApxePoKvqrVac9YxOGmxZVU3WRbZ71eUOA6X4PJncnfxCAFS99H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="358337196"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="358337196"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 09:14:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="820343348"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="820343348"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 02 Jun 2023 09:14:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 09:14:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 09:14:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 2 Jun 2023 09:14:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 2 Jun 2023 09:14:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebbeNry0BFbEVZLWME3H4xRfMxclhE2Qsd5L4/JX8211Rxm/VFJGT2t0+h6by4RafwjSwxrt0SK7x1Zf83XYcUU5nlvAZJgn7cjgmq6jgVMCdDNHnSVcAsqJGq7UvDtHNkiPRzMty5whCZfmmiJJb20xQwPRcG7laBprj4LvSnfTxWVQNoYw3N1j53p3KZP3PM4a8KqsSHDOBy0b662qIkBUOYfybFuoimv5Aa3+mhZZeQ/hs0TrZYeG5JZyqC2txkf66vLBNznMSs+4KbKmUI3kLAilmIaskUh6SG9X8tosaMdE7Uh8vPgeT8aoxNQ12B+SlLdC6BRWDWu8G/fq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOul8Z2LwJMrNeJAIV7rcfEHpTnDqy3qTLJQXS0jc24=;
 b=Xywmocs1jNGy41kPeAX8ZU6vHSjW++9f51yCFfWcYSvEO2B0gYdVWDxY4SdXgYLPP+5Pd89CPrP8mlZvKbDPg9oWFkjHdYBT7wl+bzhit+GMfzj7M99igSOz28rKvi1fZ5YwFfmnZZDpCQc5B6b0lGqVbOYkacXve5/hrOTHBunl1CGs+MBOEC8KBVT3vcWTJ3sOzHZyXRTyGXZxwUmheMeOHIrW2G8Mq7q5JgpqZP/T3EG7APNqZZGeON4KA9B5mJDzIZUs/MX3dcSR58/0JDnFcna1+GhGwxS00m3HwdSD0TuDufZ9wF9ZdcTMIQZN0uiE+tOozYXpRn+pQQz6RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB7859.namprd11.prod.outlook.com (2603:10b6:8:da::22) by
 CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24; Fri, 2 Jun 2023 16:14:12 +0000
Received: from DS7PR11MB7859.namprd11.prod.outlook.com
 ([fe80::9f98:8f3c:a608:8396]) by DS7PR11MB7859.namprd11.prod.outlook.com
 ([fe80::9f98:8f3c:a608:8396%3]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 16:14:12 +0000
Date:   Fri, 2 Jun 2023 09:14:08 -0700
From:   Matt Roper <matthew.d.roper@intel.com>
To:     Henning Schild <henning.schild@siemens.com>
CC:     <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <holger.philipps@siemens.com>, <wagner.dominik@siemens.com>,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>
Subject: Re: [PATCH 5.10 0/2] backport i915 fixes to 5.10
Message-ID: <20230602161408.GN6953@mdroper-desk1.amr.corp.intel.com>
References: <20230602160507.2057-1-henning.schild@siemens.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230602160507.2057-1-henning.schild@siemens.com>
X-ClientProxiedBy: SJ0PR05CA0154.namprd05.prod.outlook.com
 (2603:10b6:a03:339::9) To DS7PR11MB7859.namprd11.prod.outlook.com
 (2603:10b6:8:da::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB7859:EE_|CY8PR11MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0e45f9-68c0-4bd3-89e9-08db638466f3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DIPHJ27kjsoCu3VMhFWkL7+41UnsJ8DeQoU4F17ylfqpwd+6AbPLluOfT3gL/ovdIVQyv8ynDn+BmYtoiJNLRAuqDAAU2zcLJwyoGSQb7Z8i5TPj2VnUAq0SxFGR5cA/CnUykDxCgLfj6r9TZsxA5jFU4k0t19H3vhLeudD8VRpsASSG4VVv2y5vgl0Q+OGkfj8N6zz876aM9mzIJn+yYpZYwQju75Lisoo07Uf+YhSP6+xPR9DroW6ASp5Yj2/J4dIEihbmrfeqTcBQHWsvdVGTDPP9Gdmdy7/NL32O0ch2v5j5Jhn4N4XGP7J6bArf+o8fk3fbwSUT/Vz6haU8sXBRX2yw7y5LIpOT7XqnFHIlKWmEBZlsLyMZJD9LDhaR8FwzyA8EnL5f6bq3z6BLL/PNbainvLHbTW3BBU1oVoxoYVTMM9d7LfB9bOBFm4IQdQBEocXSEwh3XpX8K6z48Lx5yPmoejrPCtl4weSIWlZLaHQ4yfQWTRpMtkDitLRelKAP8SbV/1fwapWJ6eyNDkh1SLIO5hTtTsswOjmkvvfoXXS2aLF3IU94J+ybwvly
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB7859.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(186003)(54906003)(478600001)(6486002)(4326008)(6666004)(316002)(41300700001)(86362001)(66476007)(66556008)(33656002)(66946007)(6916009)(45080400002)(107886003)(5660300002)(26005)(2906002)(83380400001)(6506007)(6512007)(8676002)(8936002)(82960400001)(1076003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?7NbED1CVnuMz9IogIxR0FvJ+msdMLwSb7P6rF9cCoEGtXaRbIS8xLa7Y7L?=
 =?iso-8859-1?Q?dJh/EhNItfwpLqEMBLU/srCdG537265jLi1/IjP6EBiUmt93IhNear7VMo?=
 =?iso-8859-1?Q?i9im01Jny8n4sTYhJVRCyZlSjdjnP194hIodm2p0KlbzgKDDuezIYLrZ7w?=
 =?iso-8859-1?Q?PYNqNg1VdvEctVyyP8ZkgnSNxdzjcK6G8AwZ1xkOzabM0jaIR5eCeJrqIe?=
 =?iso-8859-1?Q?T7SY6HDrFGrHOom5ujRpLBUhLGzh/JQivy9jYk3G/mCNw0yVa525JCyEOK?=
 =?iso-8859-1?Q?zcVeqD3lhgAgD+f2XU3u4SqDgLShJa4RtVjh6PE+CH5msW5+cbwcUFx5yY?=
 =?iso-8859-1?Q?don3DLzC3NLi/ngaPNpmZkqWT4HUTPIn1aPuWxusTEtMYA6oRwgsOw+OHI?=
 =?iso-8859-1?Q?QhURWNXBQQ07pCR/rEj6ykqPqB4VSc1GLqu0lS/QxWFSjnVW4TLhl8ytfb?=
 =?iso-8859-1?Q?fRxSlUcSkB+L5mQq26V6gODexxTjy56yHBr2KY5pm8ao2QhUVBoBhBQ904?=
 =?iso-8859-1?Q?loVR4DYSIDgniXY5EqrvDq1xvLKDnVfOFg7g6KsbP4zenxaDyZzPbEScd9?=
 =?iso-8859-1?Q?9cGnc2OOUgmmQd/Fxh5FTmncMagy6TveU6Mv9Ls6/npu+Pup8wZTQrcbVA?=
 =?iso-8859-1?Q?y7XNnlkthqQ051ny3Y6Z9dU1LfRJ1dvRqCLxlKyGorBke8iUrAB9vzYz7c?=
 =?iso-8859-1?Q?8BznWErlQ8uysvB47PvMnUXxdY0TkzIXlN5hIHhe6V64h58iQa/cAaNdVH?=
 =?iso-8859-1?Q?dlYUwxfrKgScqJKkIrdi3Wj/EWcShEPCo5GG3NBKxwcXfXKfbBDAr0N/0u?=
 =?iso-8859-1?Q?izeItc0qQo8TRfvGHQd5PaSurD9YJr3JvK06dDGjs1iwp10kWtuGdLJyYD?=
 =?iso-8859-1?Q?d24KSZ5eBOYWcwDULkSsKSr8OhHKMYdGVugiYAapNpNT1xp0wF/MuQuz7v?=
 =?iso-8859-1?Q?WX6AjGL0pTA2LsZxLGLgFaY91ibW+YoF6jZ+HcxLceglngC9LMEj4rOoXO?=
 =?iso-8859-1?Q?mr3HZhx0tMcJzSnR9mdYatFGlXqNKE6rSmkks7yBQ90ITZocyrRNHPAwAl?=
 =?iso-8859-1?Q?fRQxP3+wit/W0HO5D59Sc6sekPpX56U7Lk3AIlfcjbVC2s5RnRKLk4M2wZ?=
 =?iso-8859-1?Q?tWSYZWssd3zL1xmcRlYuwXIoUmKdz/7YKpGg8etA4e5iVSx6RNuC8v1thm?=
 =?iso-8859-1?Q?UERBPe9jLnEVqdjyJ+lJJBF08gjiZiqGICRrJB/GEKkf6i9ZWY0PnUGOkA?=
 =?iso-8859-1?Q?CIbaqfzvVyFVBYgJd4Q0SNneq+6jRKK1AgcM77eLyFTOCHYf3tbJ+LYq/2?=
 =?iso-8859-1?Q?Wgk0KorjWNLRFQqfqg8JYtWN1z6PJEF3IEHc4jtpvhsfpUc512mS47+sYd?=
 =?iso-8859-1?Q?VIaiopyEecwWtsBK4KrrnQ1/n4qtKzeDxFULiQtENYdBeoE/jNzwbbf4R0?=
 =?iso-8859-1?Q?LB4C5v0Bl1oPNKqRMLTetUwUpocwEp/nPASVmt7guiy71fVCqooqKIISWY?=
 =?iso-8859-1?Q?6OfblkY0BvOljhnBSkVbZDnFtTlL+zSEIAuqNcX1EUFSrFoFFGjKrw6itF?=
 =?iso-8859-1?Q?+xOM17O7LwnWorQlQw5RjcEtxV/J7DKQlj3CsIL2GbfuSu4MeucSK+D0f0?=
 =?iso-8859-1?Q?bnc8BdrEysNOCT6JilUfyaRf5Eu3Ix6LB8FFpus3ncCg0+9J9l32xGsw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0e45f9-68c0-4bd3-89e9-08db638466f3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB7859.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 16:14:11.9002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vp3EuYZs+fPb8Ya0tMdPeGkdYBwOKvnb8d3d/800ibn+1LdOYObypVXp3iyE5PBWX8vN5v2HZSVBWftIzl4jfqzYFunU/6r4RMhBVgpmQeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7012
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jun 02, 2023 at 06:05:05PM +0200, Henning Schild wrote:
> This fixes the following problem which was seen on a Tigerlake running
> Debian 10 with a 5.10 kernel.
> 
> [  111.408631] Missing case (val == 65535)
> [  111.408698] WARNING: CPU: 2 PID: 446 at drivers/gpu/drm/i915/intel_dram.c:95 skl_dram_get_dimm_info+0x72/0x1a0 [i915]
> [  111.408699] Modules linked in: intel_powerclamp coretemp i915(+) joydev kvm_intel kvm hid_generic irqbypass crc32_pclmul snd_hda_intel ghash_clmulni_intel snd_intel_dspcfg snd_hda_codec aesni_intel glue_helper crypto_simd cryptd snd_hwdep snd_hda_core drm_kms_helper uas snd_pcm usb_storage intel_cstate mei_wdt mei_hdcp snd_timer scsi_mod usbhid hid cec wdat_wdt snd mei_me evdev mei intel_uncore rc_core watchdog pcspkr soundcore video acpi_pad acpi_tad button drm fuse configfs loop(+) efi_pstore efivarfs ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2 dm_mod xhci_pci xhci_hcd marvell dwmac_intel stmmac igb e1000e usbcore nvme nvme_core pcs_xpcs phylink libphy i2c_algo_bit t10_pi dca crc_t10dif crct10dif_generic intel_lpss_pci ptp vmd intel_lpss i2c_i801 crct10dif_pclmul pps_core crct10dif_common idma64 usb_common crc32c_intel i2c_smbus
> [  111.408755] CPU: 2 PID: 446 Comm: (udev-worker) Not tainted 5.10.180 #2
> [  111.408756] Hardware name: SIEMENS AG SIMATIC IPC427G/no information, BIOS T29.01.02.D3.0 10/11/2022
> [  111.408797] RIP: 0010:skl_dram_get_dimm_info+0x72/0x1a0 [i915]
> [  111.408799] Code: 01 00 00 0f 84 31 01 00 00 66 3d 00 01 0f 84 27 01 00 00 41 0f b7 d0 48 c7 c6 ba 81 7c c1 48 c7 c7 be 81 7c c1 e8 d2 75 89 fa <0f> 0b c6 45 01 00 44 0f b6 4d 00 31 f6 b9 01 00 00 00 c1 fb 09 83
> [  111.408801] RSP: 0018:ffffa23a40b53b10 EFLAGS: 00010286
> [  111.408802] RAX: 0000000000000000 RBX: 000000000000ffff RCX: 0000000000000027
> [  111.408803] RDX: ffff947b278a0908 RSI: 0000000000000001 RDI: ffff947b278a0900
> [  111.408804] RBP: ffffa23a40b53b78 R08: 0000000000000000 R09: ffffa23a40b53920
> [  111.408805] R10: ffffa23a40b53918 R11: 0000000000000003 R12: 0000000000000000
> [  111.408806] R13: 000000000000004c R14: ffff9479b1a00000 R15: ffff9479b1a00000
> [  111.408808] FS:  00007ff9626478c0(0000) GS:ffff947b27880000(0000) knlGS:0000000000000000
> [  111.408809] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  111.408810] CR2: 0000555753cbf15c CR3: 0000000108432002 CR4: 0000000000770ee0
> [  111.408810] PKRU: 55555554
> [  111.408811] Call Trace:
> [  111.408854]  skl_dram_get_channel_info+0x24/0x160 [i915]
> [  111.408892]  intel_dram_detect+0xef/0x630 [i915]
> [  111.408931]  i915_driver_probe+0xb18/0xc40 [i915]
> [  111.408969]  ? i915_pci_probe+0x3f/0x160 [i915]
> [  111.408973]  local_pci_probe+0x3b/0x80
> [  111.408975]  pci_device_probe+0xfc/0x1b0
> [  111.408979]  really_probe+0x26e/0x460
> [  111.408981]  driver_probe_device+0xb4/0x100
> [  111.408983]  device_driver_attach+0xa9/0xb0
> [  111.408984]  ? device_driver_attach+0xb0/0xb0
> [  111.408985]  __driver_attach+0xa1/0x140
> [  111.408987]  ? device_driver_attach+0xb0/0xb0
> [  111.408989]  bus_for_each_dev+0x84/0xd0
> [  111.408991]  bus_add_driver+0x13e/0x200
> [  111.408993]  driver_register+0x89/0xe0
> [  111.409036]  i915_init+0x60/0x75 [i915]
> [  111.409038]  ? 0xffffffffc18b8000
> [  111.409041]  do_one_initcall+0x56/0x1f0
> [  111.409044]  do_init_module+0x4a/0x240
> [  111.409047]  __do_sys_finit_module+0xaa/0x110
> [  111.409050]  do_syscall_64+0x30/0x40
> [  111.409053]  entry_SYSCALL_64_after_hwframe+0x61/0xc6
> [  111.409054] RIP: 0033:0x7ff962d534f9
> [  111.409056] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 08 0d 00 f7 d8 64 89 01 48
> [  111.409057] RSP: 002b:00007fff57caf5d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [  111.409058] RAX: ffffffffffffffda RBX: 0000555753cad120 RCX: 00007ff962d534f9
> [  111.409059] RDX: 0000000000000000 RSI: 00007ff962ee6efd RDI: 0000000000000010
> [  111.409060] RBP: 00007ff962ee6efd R08: 0000000000000000 R09: 0000555753c7a320
> [  111.409061] R10: 0000000000000010 R11: 0000000000000246 R12: 0000000000020000
> [  111.409062] R13: 0000000000000000 R14: 0000555753ca4f30 R15: 0000555752d40e4f
> [  111.409064] ---[ end trace 2da6ec0bd6f7c3a1 ]---
> 
> 
> José Roberto de Souza (1):
>   drm/i915/gen11+: Only load DRAM information from pcode
> 
> Matt Roper (1):
>   drm/i915/dg1: Wait for pcode/uncore handshake at startup

This second patch should only be needed for discrete GPUs (none of which
are fully enabled on a 5.10 kernel).  Are you seeing it cause a change
in behavior on an integrated TGL platform?


Matt

> 
>  drivers/gpu/drm/i915/display/intel_bw.c | 80 +++---------------------
>  drivers/gpu/drm/i915/i915_drv.c         |  4 ++
>  drivers/gpu/drm/i915/i915_drv.h         |  1 +
>  drivers/gpu/drm/i915/i915_reg.h         |  3 +
>  drivers/gpu/drm/i915/intel_dram.c       | 82 ++++++++++++++++++++++++-
>  drivers/gpu/drm/i915/intel_sideband.c   | 15 +++++
>  drivers/gpu/drm/i915/intel_sideband.h   |  2 +
>  7 files changed, 114 insertions(+), 73 deletions(-)
> 
> -- 
> 2.39.3
> 
> 

-- 
Matt Roper
Graphics Software Engineer
Linux GPU Platform Enablement
Intel Corporation
