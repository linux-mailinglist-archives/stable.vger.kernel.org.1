Return-Path: <stable+bounces-127429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ECBA7958C
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 21:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68FD13B3368
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 19:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2B318DB3D;
	Wed,  2 Apr 2025 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hZmf90ob"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB6DBA42
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743620452; cv=fail; b=hOQ+x7wdOWR0q9y1LBx9zeYAtazQPXdG8rxjpCOpfDvb0wGhl1MJYlQGm6dCQJ9R7/LLesefNomWt+3EJ3BPBypPOuuN2vv3stfYvGvO/mKL6luQ8NUPgyyMI02uCNXohmZWWLCclyDwmvhnGA09/oelwHqEQ301u0xvMxM9d0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743620452; c=relaxed/simple;
	bh=mMXstf9Rr9U8afrwbI2WjERZePHpSOtAGMG+onC56xA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8E1tp8whGtodHerq02m9hLhUYMItbR8jHPv7vvoB6Xa/p0rXLGdwvGlUqcyYwg3VP5ZnPr54xskMlni3oVrduO/8CFg7hyIIYy1sbCGUHPY3sPGy++vv8a+R5gRjFB8lIdBxt8Lz9We7bkl+k5MO3sOhm/TBNXT5GJ8Nxe4/2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hZmf90ob; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBypMCi7FQCIzCRyNwvNL+QVQL8WraCes75ke+aqAuLXgjnbg+1pmKJlQ8gAJRK1UFi+Ta6SVYSWhwoNI8Z+oQgyr/PMWvMBnJVwDX42eCAeA4Kt9oRC/pTS7sPdfUlh1ZV3rXcvXoTrIvG+FkS7VVzy2gFSUnxMxry+0nTG5iDqeXaCmfsRSkhZyNaE5n5a5qWKTlUhWxnWKHD4egnlZn+OfuDc7UTB/y8UeeAl9Fup7lh5OPElg0J3IVxupwKZ1iEl6wDmvETXX+bl2QjxdIuEUYhv7s3waJALc6sx09RdXRlKipNcSLvdef0TxNNDRAzRMYnE7aNJn5PdDYpmLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24g02xTdMJEEbU9paJTIiBkoenXHGaYbqKeuki4Ptj0=;
 b=oQtibqMRsSFpnNsCDDBMP9uIEQPU5ehjn+bDQLoSFmJsCYbEv+4PSOI91Gs3U9ccoM1pXAu6SqK5fO1yMVcCZqWTRG9sRLZt7vYWN1z9ajZ2zlnbPT6HKt+lDMDVDO0ucc9AP6Fo15A5EolrDqcTCUVJ0DLCG5nWmTFihcUMfGVOi/8RKu1oRc9tcfsA3JOPQS+EYoVtxhpmm1cac3Zpj+FxHIT1MfhbRn3yTICS0n9r0JCDJ79Ab3KoF9vjjhwHf+uDjbXCw+ihIjcUIBNM0jPcHDD2Zxxe9c/kQ5hXDeXR9nJInSfRCTXN/CQoYSKic8onzcUTmoAumxmuSdF39g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24g02xTdMJEEbU9paJTIiBkoenXHGaYbqKeuki4Ptj0=;
 b=hZmf90ob6oeQCQ9v0sq7E6Mss7Ng063dqBfmFWGrdLTVYvtRSw/F9v+2zdAvkzUHCJ9u+r4KtKG/fdPyLQ/Cz9jo1gwauMgfuz989jmGjbGRou9UMyRXXtMrxXOU6AImMRLaxl1q7Qd2T7Nd4HgcWBX0JOsJZbvT0em6Iyeb+l8=
Received: from DM6PR02CA0062.namprd02.prod.outlook.com (2603:10b6:5:177::39)
 by IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 19:00:43 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::22) by DM6PR02CA0062.outlook.office365.com
 (2603:10b6:5:177::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.24 via Frontend Transport; Wed,
 2 Apr 2025 19:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 19:00:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 14:00:41 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Apr 2025 13:59:51 -0500
Date: Thu, 3 Apr 2025 00:25:46 +0530
From: Naveen N Rao <naveen.rao@amd.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
CC: Kirill Shutemov <kirill.shutemov@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	Vishal Annapurve <vannapurve@google.com>, Nikolay Borisov
	<nik.borisov@suse.com>, <stable@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/ioremap: Maintain consistent IORES_MAP_ENCRYPTED for
 BIOS data
Message-ID: <7cgiqaoeosg3vekjkcm5iorn5djdqbqv3evijgho6tvonzhe2t@jzn56u4ad7v3>
References: <174346288005.2166708.14425674491111625620.stgit@dwillia2-xfh.jf.intel.com>
 <z7h6sepvvrqvmpiccqubganhshcbzzrbvda7dntzufqywei4gz@6clsg5lbvamd>
 <00931e12-4e6a-9ec4-309c-372aaee333b9@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <00931e12-4e6a-9ec4-309c-372aaee333b9@amd.com>
Received-SPF: None (SATLEXMB03.amd.com: naveen.rao@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|IA1PR12MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e81543-30c5-45c5-b646-08dd7218aaea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i6MzQ/YxB50MGZAkszBWNU9ptBzMTbqWnz5jKdadJeX4SMgVHWtQkDd3owFZ?=
 =?us-ascii?Q?satCURy6WzUenFdu3XFaz/KnCfGcPffsW75doX/M+EqvudweghMfMyzBSwWq?=
 =?us-ascii?Q?RfadiB1vD6cLVmgI9bzR+4QKHRpEHUqAJwXgiEVc5hnTzZyBL7UX67cKKgiY?=
 =?us-ascii?Q?H+sL/K/7oTa7edpE6wjKCswGdAdMf/BR/9RsmfsMzpYSmvukUYPXGpAM58Z3?=
 =?us-ascii?Q?NKlKi4wfSUhjOCe6aH7LgMQbWeMvxFbHzLfChYTNGqLwV27Tv4HeCF30SBpl?=
 =?us-ascii?Q?aT0ZkoYpApx8wpv8gHaeIwzZXXHU1LPCZsB64SrAm0x5OkJwrWpVTrDvIczE?=
 =?us-ascii?Q?dcji+oQuvW/LlpnYJONzwTGOLdaR6zv4tcD5z9oEfCrFRztsWl8yJJrB7GBt?=
 =?us-ascii?Q?AuhdmON/rl4Icex86LCSbRgZkQDLZGShI5zaPw1QYeA9DqeWempzo5lBaWqI?=
 =?us-ascii?Q?nEFKA59DRyrAXqVp6s8zjSJtq4LicFfG0V0erSfl9HjO7PT2dt9Xc7rUSVHL?=
 =?us-ascii?Q?pIYy6Hx+F0X2auJHv83EsiLrHqoq1Om87TsB0ll5DJR9i8l+EW+r947Q677k?=
 =?us-ascii?Q?LBHiQbpGwScadbUe4fStjs44dl+kgBHMfMT2HvS9RxS+lUy3K8tH2p9tyOzi?=
 =?us-ascii?Q?8dH4XaEIpp4/BzDaZCtVmX8vp6pU/kdXBYBRwnO/ygHAHNHIucl/5u3gCTss?=
 =?us-ascii?Q?Y9nYeoz2udwfpmTf39dmWbUuy3gQ2cyKbCSQm1xqGeYiSzZR9bJ/jgtok4wP?=
 =?us-ascii?Q?Luy8cenUk1XiOZCm5YzruqGj/aoyCXtJF8TJuuo0jgyvvogHHn21zJ5h8lLb?=
 =?us-ascii?Q?wbB///25OhTIX6gL62RiCjKS/4PORTUsJaXMy6YqJF1W4uJ9cJUAC6Z5I96K?=
 =?us-ascii?Q?BZoJyne5t/bhGTZBIwgFoIkdZ1T+fVP/DHcNWxVYcuEKD4eHppQrBSfcfBgc?=
 =?us-ascii?Q?Dt6dB9ZyrBsHQ0cO/wGN27aspA6nk9ds355rqI5ZdO6xMvTXHHHXQOcZWMzK?=
 =?us-ascii?Q?CFeY7pU4c3dezcoJPgSdRyNxzMyHgZoeVT5a1WFpvYae7FKCxBxK47EpfUnz?=
 =?us-ascii?Q?iZfTt+DRVc9axnTQ2dZTT48jfIz+v6GAIWDRwevbfvWq4Pt8obdqvU4DeTlX?=
 =?us-ascii?Q?PSP6DAc79+7tADdu9dq+ZnqQFw2TcRcHhiilEAbQ+gmFE3US9CPZBz1mR2S2?=
 =?us-ascii?Q?FMj9uwMDRhFSEnSVE3jujJT3mYTX2Pguz8N662APVVJeUqnkomgs/jOJKjIJ?=
 =?us-ascii?Q?bu8BxObxu7iU9ti2cYb7imm8iBDnuCIT4z+tgUUyW0/fqu7EnhaJU0H3uBFY?=
 =?us-ascii?Q?w5Z2pWwHDXSIdonP6S77pQ58p0xKw6DgrpGjPj20bN3zCGoUEqgkrTmuWe68?=
 =?us-ascii?Q?rj9PSTswpsjO3wu4Wmpcb3OiqvA/KS+aXWgjZ9oAjNlIpjfN/IZ9T51XqbE+?=
 =?us-ascii?Q?5fD/z7dtCQ3DzjfkTNK8zBWJXt227xS6OKOE3FocMtu/Zaa3IyR9wP/E4B0g?=
 =?us-ascii?Q?Kmzw1eSg9wDnv+0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 19:00:42.7206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e81543-30c5-45c5-b646-08dd7218aaea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8190

On Tue, Apr 01, 2025 at 10:07:18AM -0500, Tom Lendacky wrote:
> On 4/1/25 02:57, Kirill Shutemov wrote:
> > On Mon, Mar 31, 2025 at 04:14:40PM -0700, Dan Williams wrote:
> >> Nikolay reports [1] that accessing BIOS data (first 1MB of the physical
> >> address space) via /dev/mem results in an SEPT violation.
> >>
> >> The cause is ioremap() (via xlate_dev_mem_ptr()) establishing an
> >> unencrypted mapping where the kernel had established an encrypted
> >> mapping previously.
> >>
> >> Teach __ioremap_check_other() that this address space shall always be
> >> mapped as encrypted as historically it is memory resident data, not MMIO
> >> with side-effects.
> > 
> > I am not sure if all AMD platforms would survive that.
> > 
> > Tom?
> 
> I haven't tested this, yet, but with SME the BIOS is not encrypted, so
> that would need an unencrypted mapping.
> 
> Could you qualify your mapping with a TDX check? Or can you do something
> in the /dev/mem support to map appropriately?
> 
> I'm adding @Naveen since he is preparing a patch to prevent /dev/mem
> from accessing ROM areas under SNP as those can trigger #VC for a page
> that is mapped encrypted but has not been validated. He's looking at
> possibly adding something to x86_platform_ops that can be overridden.
> The application would get a bad return code vs an exception.

The thought with x86_platform_ops was that TDX may want to differ and 
setup separate ranges to deny access to. For SEV-SNP, we primarily want 
to disallow the video ROM range at this point. Something like the below.

If this is not something TDX wants, then we should be able to add a 
check for SNP in devmem_is_allowed() directly without the 
x86_platform_ops.


- Naveen


---
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 583df2c6a2e3..fa9f23200ee4 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -761,6 +761,18 @@ static u64 __init get_jump_table_addr(void)
 	return ret;
 }
 
+bool sev_snp_mem_access_allowed(unsigned long pfn)
+{
+	/*
+	 * Reject access to ROM address range (0xc0000 to 0xfffff) for SEV-SNP guests
+	 * as that address range is not validated, so access can cause #VC exception
+	 */
+	if (pfn >= 0xc0 && pfn <= 0xff)
+		return 0;
+
+	return 1;
+}
+
 static void __head
 early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 		      unsigned long npages, enum psc_op op)
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ba7999f66abe..f94522da9eb5 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -454,6 +454,7 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 struct snp_guest_request_ioctl;
 
 void setup_ghcb(void);
+bool sev_snp_mem_access_allowed(unsigned long pfn);
 void early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
 				  unsigned long npages);
 void early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
@@ -496,6 +497,7 @@ static inline void sev_enable(struct boot_params *bp) { }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
 static inline void setup_ghcb(void) { }
+static inline bool sev_snp_mem_access_allowed(unsigned long pfn) { return true; }
 static inline void __init
 early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
 static inline void __init
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 36698cc9fb44..0add7878e413 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -307,6 +307,7 @@ struct x86_hyper_runtime {
  * @realmode_reserve:		reserve memory for realmode trampoline
  * @realmode_init:		initialize realmode trampoline
  * @hyper:			x86 hypervisor specific runtime callbacks
+ * @mem_access_allowed:	filter accesses to pfn
  */
 struct x86_platform_ops {
 	unsigned long (*calibrate_cpu)(void);
@@ -324,6 +325,7 @@ struct x86_platform_ops {
 	void (*set_legacy_features)(void);
 	void (*realmode_reserve)(void);
 	void (*realmode_init)(void);
+	bool (*mem_access_allowed)(unsigned long pfn);
 	struct x86_hyper_runtime hyper;
 	struct x86_guest guest;
 };
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 0a2bbd674a6d..83217de27b46 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -142,6 +142,7 @@ static bool enc_cache_flush_required_noop(void) { return false; }
 static void enc_kexec_begin_noop(void) {}
 static void enc_kexec_finish_noop(void) {}
 static bool is_private_mmio_noop(u64 addr) {return false; }
+static bool mem_access_allowed_noop(unsigned long pfn) { return true; }
 
 struct x86_platform_ops x86_platform __ro_after_init = {
 	.calibrate_cpu			= native_calibrate_cpu_early,
@@ -156,6 +157,7 @@ struct x86_platform_ops x86_platform __ro_after_init = {
 	.restore_sched_clock_state	= tsc_restore_sched_clock_state,
 	.realmode_reserve		= reserve_real_mode,
 	.realmode_init			= init_real_mode,
+	.mem_access_allowed		= mem_access_allowed_noop,
 	.hyper.pin_vcpu			= x86_op_int_noop,
 	.hyper.is_private_mmio		= is_private_mmio_noop,
 
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index bfa444a7dbb0..64750d710f9f 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -867,6 +867,9 @@ void __init poking_init(void)
  */
 int devmem_is_allowed(unsigned long pagenr)
 {
+	if (!x86_platform.mem_access_allowed(pagenr))
+		return 0;
+
 	if (region_intersects(PFN_PHYS(pagenr), PAGE_SIZE,
 				IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE)
 			!= REGION_DISJOINT) {
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 7490ff6d83b1..75e2d86cdab9 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -532,6 +532,7 @@ void __init sme_early_init(void)
 		 * parsing has happened.
 		 */
 		x86_init.resources.dmi_setup = snp_dmi_setup;
+		x86_platform.mem_access_allowed = sev_snp_mem_access_allowed;
 	}
 
 	/*

