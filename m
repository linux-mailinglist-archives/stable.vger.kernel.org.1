Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C16471397F
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 14:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjE1Mzr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 08:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjE1Mzq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 08:55:46 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5086DBB;
        Sun, 28 May 2023 05:55:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxJFRDtUyMUTozxc9zsEo4HO/DbgIjIcD4mkEmOVxrXPY82YXp3A7p8M9PtQYQubaDvFmZaxo5uEPdLSejXNZQMwUSh+D5+XpyzzPdi1cEICBIQfKryaX0pvKP9BUeOH6W3Y6hvc+YIdTZjp4ducP4Gv1usZfkr0KTo5ta+/ZzT+7tDbSBhqzKdGGf2IlmunJS9zWZzXhr0R1JZCYmc1rrEKlqUPB0b5NVXsQvlKSJvJyXOxUQ5OtUCJaPWgJ3ntVYZReP4K/Got/rHC6nY/HqjFwabiLAY7fANQpP1gZqKOGwT+RJrA8M+/+jqU2qtuBh0JYILyUk6zbKgqBBFVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+T0I5PHmVNxrINNDTDl0JZihR25gyNmOFduzNsBfGU=;
 b=XoLy5etopJpTm4DBMEYf1CC27iiasgvorPCcjWIpgLmW7EoKQHnP+JTGJFG3HP3rlwyukmV8SyQhHOWTaXSK4m/N9DHGyiZQC9UzrZ3AyEw5yEket60AftLUtAODT4OgU0B9KTHVkfXM+OFrTuE04ofwawn+o+QEMI/PAvZjTzbKxhrP9Y7DkbI7ML3R5+b+y3MA7qunNzdTDRcHM71b7n+AJa2JS5LvlJJahNLen3D+MnOJsGj7d4JfpfoB1cIGXNOQiABhWHB62X7CskV8zI5UqG/tU7FC7YHTEpmPGqn3RrnCjWsf8DTcDpp1EqFFaFZvbXDpjvKYGvdeXOAHTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+T0I5PHmVNxrINNDTDl0JZihR25gyNmOFduzNsBfGU=;
 b=YdV4Sg1TJrkk7GzTpsgRj4rWFOnHROFxCNmxhF6KIsqA13jAqA9NCgWr92WygI5vGwvZWgflEW408MHkY1F0b6niipDZkjl90AvK5VpwKWzi95Hq3kyeqbPQcnOV07iln6OKAy3+i/s/4rKYbV0VFfnLPJtOdjz5bRiWFk76IVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Sun, 28 May
 2023 12:55:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Sun, 28 May 2023
 12:55:42 +0000
Message-ID: <261a70b7-a425-faed-8cd5-7fbf807bdef7@amd.com>
Date:   Sun, 28 May 2023 07:55:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: 6.1.30: thunderbolt: Clear registers properly when auto clear
 isn't in use cause call trace after resume
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        beld zhang <beldzhang@gmail.com>, stable@vger.kernel.org
Cc:     Linux USB <linux-usb@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Takashi Iwai <tiwai@suse.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <CAG7aomXv2KV9es2RiGwguesRnUTda-XzmeE42m0=GdpJ2qMOcg@mail.gmail.com>
 <ZHKW5NeabmfhgLbY@debian.me>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZHKW5NeabmfhgLbY@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0016.namprd12.prod.outlook.com
 (2603:10b6:806:6f::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 256fc0d2-8a32-495d-2c23-08db5f7ad80d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGoOc0/Qruy/NIQCMHv8WtjW6oSlhARnod2qaFv5w9uBDNuhdqNEF/XIXljw4RPNO77bLQRW8K2a4h6gWlgP89/KX3YHExm6i7kwwZWkJPvylmWBRp3SCvXB9Vb3nXuqckqKHRtSBAtGo4Q6YVYp3t9Jv3HNK1x84KakfB5TVGqvAAFfKgFLFzq0B3U/HyFlqGfuGfaFvmU99XhqxSR/6mY4Rnpb9Kxqzdo8/6qxVtKsly0eVnuzKbPT/lLtqCAMcBZvwdsYPs+8A+smeD+hch5/xlIWViXRVVoDpPLW0/hoeX4GohYfsaI25gO/vjfQbPeAXsYqI/nEd9I3d/sGVME+DQQj86VFNuhEy43Dpd84d+XcGzI6GTYLApLH+WKHH+WjnzU5bqrsfXTLG0tpQqDlLhq0S7UrLA9oTaBx0AHHMbswJp3RhEH46faE6jAZ0sO9X4xSF/9zPNgtUHcAf1ntWm9KxXrWo4WrtfU8fKh0lcutlYj6LtytBy2tNSepV4p2DuhgOwl7C8dsJRHdMq3W6oJmhvxED2KU7IkE0bV+UFmSeOvjbv4Z3LiwSROr/bUnYcIH7kn9nC34dWsUN4XffWsfUxa4Dztik6RKAXNEJ3EpJhwcScmwsaFAixRekqShoFyVVid+E2egf/90sQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199021)(86362001)(36756003)(31696002)(54906003)(478600001)(4326008)(110136005)(66946007)(45080400002)(66556008)(66476007)(316002)(6666004)(6486002)(5660300002)(8936002)(8676002)(41300700001)(2906002)(44832011)(38100700002)(2616005)(53546011)(6506007)(186003)(6512007)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEo1V0NzdS9tQXFUK1lyekJGRFZmbHcyYjRrOEpueWczazE5aENDT1dIUlhS?=
 =?utf-8?B?OEU0OTBKYmJNRTFEMjl5a2JRTlRvampBWTIrYVV2cS9JZHBsR3o5R0JwblFv?=
 =?utf-8?B?elVzcnBHcDRyajY3azhYaWlSR1pGUHJZbEpGVVZ3ek5oM0ZzUjRJSzhSSkNl?=
 =?utf-8?B?ZDZUVUdPdTdocnlMR3d5c2RYWE5vZk9uYTA4Y2tEMDNTNEZwODU3UWF0UzQ0?=
 =?utf-8?B?OUJsWXlCREw2REdvb3dvN0s4dEFMbjVtYW16a2VqMkpBcDNKQXQ2UWdRbzhl?=
 =?utf-8?B?eFo2cG9hUE1tMVN1M1owNHVrV3FRQU95bDF0WlZmOFB6N0paQk1LZFhVN2oz?=
 =?utf-8?B?R0Q4V21pREx6Rm5YVTQ4TWgxdzBqYWNCVFVHL2pqNVBXTmdYb2RiQ2kvU3Jt?=
 =?utf-8?B?VHIyRVR0R2ZqVDhrZWdGN1M2Mmw0ZVh3YTFJWkFoRFFjbHR2Y05IeXE2R1o0?=
 =?utf-8?B?NS9pcFNGRWhSRkhrdFVDVzlqYmJQOW11c0lmWVpWa0xSRDV4RGoxU3ZRUlUy?=
 =?utf-8?B?MzBuZXM3N1ZEQ3VqSmFUU1lhN0xwUEJOZk13K0tCQ2VIWFZ1NjZoUFpEMUNz?=
 =?utf-8?B?a25FMnR0K3ZkeGZ1MGhrR1Q2S2FTU0VWQk4zZ1h2b2N2ejNHRDErdmFhd2FZ?=
 =?utf-8?B?c0RxZ3JVRmdkaEF5ZEljMTNoS2VaRko5T1RralZkUytoMEloUENRK3hILzA3?=
 =?utf-8?B?V2xBaUZCTS91eWg2OE0yMXlVclp2aU1LSjk3YmVzMEFDNnhJTW5TazltNFhI?=
 =?utf-8?B?OHNITFR2R1gzc1J3TCtBZGJUdFNNRUhzdlFxOVhRU2dCaGp4ZzhhSDdHNFA5?=
 =?utf-8?B?aG9JTHdvTGRqZ1hGdElFTE54Smxoc1NtNEczYmlCZEhsb3A0Z0cwai9PaUk0?=
 =?utf-8?B?K2hzaFhhSE5BUUJ0U1J2aEp2RiswVUczWURpOHovUGpkcXVpZUF0U1ZjNXNR?=
 =?utf-8?B?VGZnb2wyYUR1bkFJOVhwbzJ0L3FiT3FZYVZJenVtZGFnWHZBQzZtdDgweHY0?=
 =?utf-8?B?RHMwSHFzNDhCdjdzLzJKUnNCYlhGbGl0Z0MvN0h6UHMyNk9PdkRDZi9nc1RJ?=
 =?utf-8?B?eWRaTGFZelNibnk5bkpVdFNUaXVQWmRqNnRkZzhhMXlrcDdKbGRocUdmWEpw?=
 =?utf-8?B?eHg4UkQwV3hoVGxqN3lzcUxZOVovVzVwQzFPWjlSdlBEWktHa09UWTZqRzhD?=
 =?utf-8?B?S3VxZFRzd0lQMUFhdVIvSUtwemRqd2Q1NnhoeWdRTXM1WG5VdEhnTzVOSWxP?=
 =?utf-8?B?WGRPTjBiNERyR3NLb2grOEpNYVh6TkZIcEd1a04wRzYyVlN0a0hlTEZZRnd0?=
 =?utf-8?B?M2tYUDN4VWxkNkpnamxheStvNUFOYnk4d2Q0QzExY2hzVXRrb2lzaDE2K0Jw?=
 =?utf-8?B?TmVrZHNaSUlqTklORjZ6TklpejFhaFRXUTJPbXVQN2NrNXUxQTFZVmxzb0s5?=
 =?utf-8?B?dHlOVGwrcEJESytYdEllYm1mOTlRbVJJKzkrOStjUld6VWZSUFRoYlpHdm1t?=
 =?utf-8?B?MHJTNTZaZFN1VjdSRGp3d0h6eWZBT2xZSVc2eDduSzdTTGVleEpwZnRFdmZp?=
 =?utf-8?B?b2M0Z3ZnODZPcXVuMmd0RngzU2Z6NTZqcG1TYURUMWpRcjJOdnJidnVTNm5t?=
 =?utf-8?B?blNiSmw5S0tveDdGVzJzMFNHZW9lQmJxVExjdC9WUnBwRWh5dFdkdVdBN1BS?=
 =?utf-8?B?ZnJtd0pLNjRDZkJUT1dXS1p3U1Azb2JGMXlYZDhyN0RpallEZm5LMlpDMVo5?=
 =?utf-8?B?RERsTDZEc25aK0c2YTN4cVdPbkRialNmcVJNYUYvL2JaczE4Qy9xWklWRllH?=
 =?utf-8?B?bWh1WndIdVRXRDdwSjVkUitOdU9OZGo0UDNBMTJGME1QSCtvcDhmdm94Zzcz?=
 =?utf-8?B?eUdUUnNTK2taSGVEZkNsbHRrMDdUbExwaHJ6UC8vT2RKR0IwNTN4R0drbDFj?=
 =?utf-8?B?d05KS2hRMlpyU1VEa0dGUi9vWjN0WGluZVFhZkUxM3dtY1NWU0lXaTdKdXRl?=
 =?utf-8?B?SmlOazh6T3ptRWVrWThtVGdJMnRzbjhlNGtmSGR2Q0c0Tmc0TDFSZWo0QUw4?=
 =?utf-8?B?WDhVaXFVRytBekwvL0lPMmx4L3VjOHEyVUVZVHNRQlR2dVpSN1FMSVlvWkxR?=
 =?utf-8?B?NGpybnJEeUEyaXBZUWcxOWhZOVB3RnNTS0NKdjhFQWgvNUxRcGk5aEt1eHNQ?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256fc0d2-8a32-495d-2c23-08db5f7ad80d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2023 12:55:41.9411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RH7XzBtuG/hsb/gAr6ozkGwXuun3+B0kVXEVJlDJLFjlWlW0G5iq7LEO3MV/JMJCS0D1Pm/dqBQ/G6s1IMm9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 5/27/23 18:48, Bagas Sanjaya wrote:
> On Sat, May 27, 2023 at 04:15:51PM -0400, beld zhang wrote:
>> Upgrade to 6.1.30, got crash message after resume, but looks still
>> running normally

This is specific resuming from s2idle, doesn't happen at boot?

Does it happen with hot-plugging or hot-unplugging a TBT3 or USB4 dock too?

>>
>> After revert
>>      e16629c639d429e48c849808e59f1efcce886849
>>      thunderbolt: Clear registers properly when auto clear isn't in use
>> This error was gone.
> 
> Can you check latest mainline to see if this regression still happens?

In addition to checking mainline, can you please attach a full dmesg to 
somewhere ephemeral like a kernel bugzilla with thunderbolt.dyndbg='+p' 
on the kernel command line set?

> 
>>
>> kernel config attached, system is Slackware 15.0 on XPS 9700
>>
>> May 27 13:55:39 devel kernel: ------------[ cut here ]------------
>> May 27 13:55:39 devel kernel: thunderbolt 0000:07:00.0: interrupt for
>> TX ring 0 is already enabled
>> May 27 13:55:39 devel kernel: WARNING: CPU: 15 PID: 21394 at
>> drivers/thunderbolt/nhi.c:137 ring_interrupt_active+0x1ff/0x250
>> [thunderbolt]
>> May 27 13:55:39 devel kernel: Modules linked in: squashfs
>> nls_iso8859_1 nls_cp437 tun fuse 8021q garp mrp iptable_nat
>> xt_MASQUERADE nf_nat nf_conntrack nf_defrag_ipv4 ip_tables x_tables
>> efivarfs binfmt_misc snd_ctl_led snd_soc_sof_sdw
>> snd_soc_intel_hda_dsp_common snd_soc_intel_sof_maxim_common
>> snd_sof_probes snd_soc_rt715 snd_soc_rt711 snd_soc_rt1308_sdw
>> regmap_sdw snd_soc_dmic snd_sof_pci_intel_cnl snd_sof_intel_hda_common
>> snd_sof_pci soundwire_intel soundwire_generic_allocation
>> soundwire_cadence snd_sof_intel_hda snd_sof snd_sof_utils
>> snd_sof_xtensa_dsp snd_soc_acpi_intel_match snd_soc_acpi
>> snd_soc_hdac_hda soundwire_bus snd_hda_ext_core snd_hda_codec_hdmi
>> snd_soc_core coretemp snd_compress ac97_bus nouveau intel_tcc_cooling
>> snd_hda_intel x86_pkg_temp_thermal dell_smm_hwmon hid_multitouch
>> iwlmvm hwmon intel_powerclamp snd_intel_dspcfg mxm_wmi i915
>> i2c_designware_platform snd_intel_sdw_acpi rtsx_pci_sdmmc
>> drm_ttm_helper i2c_designware_core mac80211 drm_buddy i2c_algo_bit
>> dell_laptop snd_hda_codec
>> May 27 13:55:39 devel kernel:  ucsi_ccg dell_wmi mmc_core hid_generic
>> drm_display_helper ledtrig_audio sparse_keymap libarc4 snd_hwdep
>> intel_rapl_msr dell_smbios uvcvideo ttm snd_hda_core dell_wmi_sysman
>> kvm_intel videobuf2_vmalloc firmware_attributes_class
>> dell_wmi_descriptor wmi_bmof intel_wmi_thunderbolt dcdbas
>> processor_thermal_device_pci_legacy drm_kms_helper videobuf2_memops
>> iwlwifi intel_soc_dts_iosf kvm btusb r8153_ecm btrtl videobuf2_v4l2
>> snd_pcm syscopyarea processor_thermal_device irqbypass cdc_ether btbcm
>> evdev usbnet psmouse intel_lpss_pci btintel processor_thermal_rfim
>> snd_timer videobuf2_common crc32c_intel ucsi_acpi sysfillrect
>> ghash_clmulni_intel serio_raw cfg80211 efi_pstore r8152 typec_ucsi
>> bluetooth sysimgblt videodev processor_thermal_mbox intel_gtt
>> intel_lpss fb_sys_fops processor_thermal_rapl i2c_i801 roles snd
>> i2c_nvidia_gpu drm i2c_smbus ecdh_generic idma64 i2c_hid_acpi mii
>> usbhid thunderbolt mc soundcore rtsx_pci ecc agpgart i2c_ccgx_ucsi
>> rfkill intel_rapl_common mfd_core
>> May 27 13:55:39 devel kernel:  intel_pch_thermal i2c_hid typec video
>> button battery hid int3403_thermal int340x_thermal_zone
>> pinctrl_cannonlake pinctrl_intel wmi int3400_thermal intel_pmc_core
>> acpi_pad acpi_thermal_rel acpi_tad ac usb_storage
>> May 27 13:55:39 devel kernel: CPU: 15 PID: 21394 Comm: kworker/u32:15
>> Tainted: G        W          6.1.30-dell-2 #1
>> May 27 13:55:39 devel kernel: Hardware name: Dell Inc. XPS 17
>> 9700/0P1CHN, BIOS 1.11.1 11/18/2021
>> May 27 13:55:39 devel kernel: Workqueue: events_unbound async_run_entry_fn
>> May 27 13:55:39 devel kernel: RIP:
>> 0010:ring_interrupt_active+0x1ff/0x250 [thunderbolt]
>> May 27 13:55:39 devel kernel: Code: 24 04 e8 24 2b 3c e1 4c 8b 4c 24
>> 08 44 8b 44 24 04 48 c7 c7 50 c7 29 a0 48 8b 4c 24 10 48 8b 54 24 18
>> 48 89 c6 e8 71 34 e4 e0 <0f> 0b 45 84 ed 0f 85 09 ff ff ff 48 8b 43 08
>> f6 40 70 01 0f 85 38
>> May 27 13:55:39 devel kernel: RSP: 0018:ffffc90000517c48 EFLAGS: 00010082
>> May 27 13:55:39 devel kernel: RAX: 0000000000000000 RBX:
>> ffff888101dab800 RCX: 0000000000000000
>> May 27 13:55:39 devel kernel: RDX: 0000000000000004 RSI:
>> 0000000000000086 RDI: 00000000ffffffff
>> May 27 13:55:39 devel kernel: RBP: 0000000000000000 R08:
>> 80000000ffffe7b4 R09: 0000000082999bac
>> May 27 13:55:39 devel kernel: R10: ffffffffffffffff R11:
>> ffffffff82999ba1 R12: 0000000000001001
>> May 27 13:55:39 devel kernel: R13: 0000000000000001 R14:
>> 0000000000038200 R15: 0000000000000001
>> May 27 13:55:39 devel kernel: FS:  0000000000000000(0000)
>> GS:ffff88887d7c0000(0000) knlGS:0000000000000000
>> May 27 13:55:39 devel kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> May 27 13:55:39 devel kernel: CR2: 00007f745c010b00 CR3:
>> 000000000220a005 CR4: 00000000007706e0
>> May 27 13:55:39 devel kernel: PKRU: 55555554
>> May 27 13:55:39 devel kernel: Call Trace:
>> May 27 13:55:39 devel kernel:  <TASK>
>> May 27 13:55:39 devel kernel:  tb_ring_start+0x141/0x230 [thunderbolt]
>> May 27 13:55:39 devel kernel:  tb_ctl_start+0x1f/0x70 [thunderbolt]
>> May 27 13:55:39 devel kernel:  ? pci_pm_restore_noirq+0xc0/0xc0
>> May 27 13:55:39 devel kernel:  tb_domain_runtime_resume+0x15/0x30 [thunderbolt]
>> May 27 13:55:39 devel kernel:  __rpm_callback+0x41/0x110
>> May 27 13:55:39 devel kernel:  ? pci_pm_restore_noirq+0xc0/0xc0
>> May 27 13:55:39 devel kernel:  rpm_callback+0x59/0x70
>> May 27 13:55:39 devel kernel:  rpm_resume+0x4b3/0x7f0
>> May 27 13:55:39 devel kernel:  ? _raw_spin_unlock_irq+0x13/0x30
>> May 27 13:55:39 devel kernel:  ? __wait_for_common+0x171/0x1a0
>> May 27 13:55:39 devel kernel:  ? usleep_range_state+0x90/0x90
>> May 27 13:55:39 devel kernel:  ? preempt_count_add+0x68/0xa0
>> May 27 13:55:39 devel kernel:  __pm_runtime_resume+0x4a/0x80
>> May 27 13:55:39 devel kernel:  pci_pm_suspend+0x60/0x170
>> May 27 13:55:39 devel kernel:  ? pci_pm_freeze+0xb0/0xb0
>> May 27 13:55:39 devel kernel:  dpm_run_callback+0x3f/0x150
>> May 27 13:55:39 devel kernel:  ? _raw_spin_lock_irqsave+0x19/0x40
>> May 27 13:55:39 devel kernel:  __device_suspend+0x130/0x4d0
>> May 27 13:55:39 devel kernel:  async_suspend+0x1b/0x90
>> May 27 13:55:39 devel kernel:  async_run_entry_fn+0x1a/0xa0
>> May 27 13:55:39 devel kernel:  process_one_work+0x1bd/0x3c0
>> May 27 13:55:39 devel kernel:  worker_thread+0x4d/0x3c0
>> May 27 13:55:39 devel kernel:  ? process_one_work+0x3c0/0x3c0
>> May 27 13:55:39 devel kernel:  kthread+0xe5/0x110
>> May 27 13:55:39 devel kernel:  ? kthread_complete_and_exit+0x20/0x20
>> May 27 13:55:39 devel kernel:  ret_from_fork+0x1f/0x30
>> May 27 13:55:39 devel kernel:  </TASK>
>> May 27 13:55:39 devel kernel: ---[ end trace 0000000000000000 ]---
> 
> Anyway, I'm adding it to regzbot (as stable-specific regression for now):
> 
> #regzbot ^introduced: e16629c639d429
> #regzbot title: Properly clearing Thunderbolt registers when not autoclearing triggers ring_interrupt_active crash on resume
> 
> Thanks.
> 

