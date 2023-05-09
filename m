Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAD16FC7FD
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 15:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjEINfv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 09:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbjEINfu (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 09:35:50 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB05E6D
        for <stable@vger.kernel.org>; Tue,  9 May 2023 06:35:48 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349AUm3d017160;
        Tue, 9 May 2023 13:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=xBOOuEjWS9HQra+n/mWPOTMbeV7e+UcRqQihwPlrMm8=;
 b=oSmlIHzKWy+VJc/2gYklJkDScNodoA/otUkpVdaZwkZa5Or0lRsoKaTQSP69sYIRlxnR
 u60v06cOz97rWPBJyZAl78WD4kJJsOTyJSJfpNKuAIKcJ4wI4/SPUw8Gs6SyPGZlVyqX
 H+5UCr70r6HMx2IK9WJbmymgXnEgMtk1te9MklBz7tGaj3e91aFQR8vYRwiLUyEbt6y0
 CUDMZKuJEKPUNn4MCR1aIq1haOqOpXNhjWbrVvjhZtITGJKoIRVIV5Nkr7NwNZyaLLjG
 8p63CcsIvcQZtGY8cLRaCHzPAH1lW0CQYc3efrzKkrHfgO1brHfQK8dKqkjZrwV9QHHA yw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qf8b90n90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 13:35:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJocXPlm1I9xDXHWu+zCFC06TZv2/7ogeEy6kMehFLoMMJUVX8BFgMECsE71pUWwLaycgVEhGkRVIJHiXlV+VHU5mR8sTnchDKC+QZPJz/Mrc921j1MXHkE0kmcfr7EbtP5W0HLQLeR07ChYD/iXUehIgctSfqHK7gKDsUFSeIJTHAMQnFA9XfoghijMTHwvyomIIWu+XuYyiTi52/4p7Y9qX8bGq0fcofn1T6JRXQGmO2bNULWxa4B+BdNmcdl/EvQg3wpvqsHx10HW3DG5rukObAhhGvVcNv+xXkcLQZWZ+VB5a/UpvbTjyTMfLaRRrcJTAM9uoXxUknuCx6Wc2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBOOuEjWS9HQra+n/mWPOTMbeV7e+UcRqQihwPlrMm8=;
 b=D812NWeeVoK/1xobPrdS6WwcrfK1M9AmpRuXTfip3g2aiqmmrCTILbzxAVe+g7v75KsgS9StQdoZamT3x+XcxctezpDaldVURJ7xInm949iSqaobnLRriPhFAd8borMYkR+i0iR8bkGEwBU0vsp15zLoR+7KX9mV89IjSOd3DOijLcTxNEluLYNFSXzEvGYR+JbrQATKd9Lfg5mHuHCXkdV3gkswffMyICAij2sJWbYB0E+ugqhj9rn9wn1QKpNdToLktr/o/INorVgDn4RZkTJulh9a/mcprHKSfPa1bcqLlXWpO63fg0e0S8AJLEXG4B4TG67PHZCEuKsOXhBB3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by SN7PR11MB7068.namprd11.prod.outlook.com (2603:10b6:806:29b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.30; Tue, 9 May
 2023 13:35:40 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::60b2:e8cd:1927:54f3]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::60b2:e8cd:1927:54f3%8]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 13:35:40 +0000
From:   ovidiu.panait@windriver.com
To:     stable@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Jann Horn <jannh@google.com>,
        Ovidiu Panait <ovidiu.panait@windriver.com>
Subject: [PATCH 5.10 1/1] KVM: x86: do not report a vCPU as preempted outside instruction boundaries
Date:   Tue,  9 May 2023 16:33:30 +0300
Message-Id: <20230509133330.2638333-1-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.39.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0077.eurprd09.prod.outlook.com
 (2603:10a6:802:29::21) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5327:EE_|SN7PR11MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: 98935fab-c7e6-46a5-d5ca-08db50924793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /4H0+8BOJv32Z2PMdLF4OZLXecgPUc2xU1+D88+pqG/eEwDsVu8YwiRwtTk2PqEQjJcfgiRmYEQjWh+IW3Myrm9PxfQscNcrZZ8Cod/OreHxp5+RXol28++TuvbMLhGV7I9tn5Sxjmr8cLvN3lRfntQKcM5IpxxbDiB8TuRBRMeUpHz84TRtUAkqeLCfZm3pnnaV7Vh1dD4OHRYTFf/NklZtNv70Bo7t3JwQgeyc46A2EdblN7+elV84e/RIiUkxtl/M+yQuZbwG+3K9IkSQlSlsSRNUScwO4VxjQdS9vNdI9zVpSRnp0IRvK3tBcD9OnXi08AJfODVZ51r6XLiFmRjygh5AOrPpixUBajYKJN6RaPvHAIiu2DwUjZW4NfmjB+3hraNUf8LzwH+4KE4M25SEFtUDXlNsV2jB+oxbOChEeyJje1HgLqZZFXkclxm9rAPSZInwee0JSwv8sJCjttYKOyC+R6onfhWA+hu7fqYJ6LBGbZ/T9w2aPE0o7WJvuY0lNI0MYNnIbt8YPg8KpxGgogQVebO1fQvIJ/dV61duebn4Vp15WMQVfGvdzX7HcJf+mu/ze0ROMsoznF1JKC1JDUMBtXTpITumPEBTFzE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39850400004)(376002)(136003)(451199021)(6512007)(478600001)(186003)(9686003)(66946007)(6916009)(26005)(316002)(6506007)(54906003)(4326008)(1076003)(66476007)(66556008)(2616005)(6666004)(83380400001)(966005)(107886003)(6486002)(8676002)(52116002)(8936002)(41300700001)(5660300002)(2906002)(38100700002)(38350700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RThKUXuPbICQQ8NIn/wyUeFHJWBzfBvfDzSUm39bAskixHOVgnUt2BI2UbIj?=
 =?us-ascii?Q?lU2DMfC2xJSRCkb+o7g4qrfeGdbU3vd7p4RKIJX5q+m31yLxONdYIjFGkQks?=
 =?us-ascii?Q?/JU06JSPt5iuJsat5HUsT2aDytVSiy5LPDmlQTHz7zQFeESpXqlBvtVhr+rw?=
 =?us-ascii?Q?dvt/4k2UgDRJrvEmcvAD021YfuW8OgLlVyozQ/qNUdhCdkG08C9ig58yyno+?=
 =?us-ascii?Q?73cpe51n4K7RVMbByXnSYGNbU5yrkWuQW3NnhMemh9hp3rfKwfj0iSbwlErI?=
 =?us-ascii?Q?zQjVZmHJR4lEiJOmvI3sprYigI/cppl6OAUdpjYREHaPx2M9tHrWN5cOjBFB?=
 =?us-ascii?Q?XKBSdXT4NxuDggCDGdlqdplhb+rvMxMop0Z3p1v7km2Zdzu4q918oc1XXV8R?=
 =?us-ascii?Q?zYJiiLSyK7z7W58tdiRB4QfI6rb+WfdhdliuOePipb1WW/9W9xKAKdqTQp4p?=
 =?us-ascii?Q?YDdBX+HUUXvkrznkHTIvhW+jUcknTC70Di6AYRJoSJqjQV627Yjx0wuph/Kr?=
 =?us-ascii?Q?XorGfg7tk33KlELGAKhhUNQbYVNEDS9DJthkVBXrLUKzJNiD2d2PWnj99uDl?=
 =?us-ascii?Q?18301h+GrQMKn8aTmiDmYb1hVuLYCUNRapn9o7Y69QaeIGH10BziQDavb2nx?=
 =?us-ascii?Q?vCfF/OO0unXzkLUuP7Lmr2qDxfiRQvER5uGk3FucMdatLgoL0RTeSBMBwjic?=
 =?us-ascii?Q?R8+8G+Obdbv6DbXPeR9RELn1hVg4Z9PizITYHSV9zAY2pZx6KRmW0ieCIaD0?=
 =?us-ascii?Q?Hou0ZIdkptdXmWcn6omt3WL5/QpbwYOc1/ikirqCKRViV07nQBsTSTmPfnCa?=
 =?us-ascii?Q?eN+WgvfR0wdJ5o2FLHJ0AbS+sdJQDjpmGLXBlUqBNEYIPBoKDE1kJKYF5Aur?=
 =?us-ascii?Q?FYWpukEuIMBLrPRPu6/BEQ93dm0QO+OEoczG6MegllW6qYTdWHEsuiUc2wS+?=
 =?us-ascii?Q?z0KaUVntlFTtSpNFk4Pz83eOCRl5s1ffpATxVRxDyZRm1qKynfSfp417qUuj?=
 =?us-ascii?Q?Kh5FfWWtC7O1Toiqa+S3zUhDNqEsakUf+fmzU7lrklSdPBJqFEfqzmjCX/Nn?=
 =?us-ascii?Q?B92LwXreIHuktjh8cLkAiPRwZ2kHSz51O97NUdcihjcuo9VH5j05wLcdo1vA?=
 =?us-ascii?Q?IfkTi6D/MpOulXkRE1EVVRZ8DBID2zeUD0+kLF2ET997JAveCUseRYeegxqo?=
 =?us-ascii?Q?wmD/lHwIOISdV2gILggXQWWhVfqEuSpy3wtsA2VU/1LF7z7mJM9zuxNGIrWH?=
 =?us-ascii?Q?68rSLdeEKH0GO+5vB4ATjnaobMqthAU50P4sO1JRdAKlCoSjkp0VTW1gsUON?=
 =?us-ascii?Q?a5/o8p7ZMpdqydNirZBQS74Wu4SJQBdazN0vXND4OwXHIWH18mdCrKBXMOlv?=
 =?us-ascii?Q?Os9SkSlWPOj5SZ4OD1YFfa1X7G7S5nkC0rQ5Atlv+RRtlXnJNU/chu7o3IxW?=
 =?us-ascii?Q?g/BOlsfgeXU/Fj1MBCsBegs4BQq2eWuVJ1Fna9AukRUVUNLccxxss6m63SuY?=
 =?us-ascii?Q?l2DJHJ6j3MGUpn5wquPdmm4i8I6DKnOVcZL0/jpQZmHgIunew3GFB/n2X2S4?=
 =?us-ascii?Q?hj5l1ff1JkKWnKyw5Eg6irvpGuVO/d531/W+exsTVkAZHMT1ICr0L8NV9puC?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98935fab-c7e6-46a5-d5ca-08db50924793
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 13:35:40.1346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmJaDt2DVMWPawhMElUNRgHF2Wu8hwy48f/uoMUXk+GMWQTU39OVqj0xD02rxfOKBc6BuCs2Dji9YVBsxOAITy289nGcLwT2X+28OoMeZoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7068
X-Proofpoint-GUID: nML503DixkaPuEOB-d0N2ic1WGM2bIGf
X-Proofpoint-ORIG-GUID: nML503DixkaPuEOB-d0N2ic1WGM2bIGf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305090111
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

commit 6cd88243c7e03845a450795e134b488fc2afb736 upstream.

If a vCPU is outside guest mode and is scheduled out, it might be in the
process of making a memory access.  A problem occurs if another vCPU uses
the PV TLB flush feature during the period when the vCPU is scheduled
out, and a virtual address has already been translated but has not yet
been accessed, because this is equivalent to using a stale TLB entry.

To avoid this, only report a vCPU as preempted if sure that the guest
is at an instruction boundary.  A rescheduling request will be delivered
to the host physical CPU as an external interrupt, so for simplicity
consider any vmexit *not* instruction boundary except for external
interrupts.

It would in principle be okay to report the vCPU as preempted also
if it is sleeping in kvm_vcpu_block(): a TLB flush IPI will incur the
vmentry/vmexit overhead unnecessarily, and optimistic spinning is
also unlikely to succeed.  However, leave it for later because right
now kvm_vcpu_check_block() is doing memory accesses.  Even
though the TLB flush issue only applies to virtual memory address,
it's very much preferrable to be conservative.

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[OP: use VCPU_STAT() for debugfs entries]
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
5.10 backport of CVE-2022-39189 fix:
https://bugs.chromium.org/p/project-zero/issues/detail?id=2309

 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/svm/svm.c          |  2 ++
 arch/x86/kvm/vmx/vmx.c          |  1 +
 arch/x86/kvm/x86.c              | 22 ++++++++++++++++++++++
 4 files changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 660012ab7bfa..af4b4d3c6ff6 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -553,6 +553,7 @@ struct kvm_vcpu_arch {
 	u64 ia32_misc_enable_msr;
 	u64 smbase;
 	u64 smi_count;
+	bool at_instruction_boundary;
 	bool tpr_access_reporting;
 	bool xsaves_enabled;
 	u64 ia32_xss;
@@ -1061,6 +1062,8 @@ struct kvm_vcpu_stat {
 	u64 req_event;
 	u64 halt_poll_success_ns;
 	u64 halt_poll_fail_ns;
+	u64 preemption_reported;
+	u64 preemption_other;
 };
 
 struct x86_instruction_info;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5775983fec56..7b2b61309d8a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3983,6 +3983,8 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
 
 static void svm_handle_exit_irqoff(struct kvm_vcpu *vcpu)
 {
+	if (to_svm(vcpu)->vmcb->control.exit_code == SVM_EXIT_INTR)
+		vcpu->arch.at_instruction_boundary = true;
 }
 
 static void svm_sched_in(struct kvm_vcpu *vcpu, int cpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2c5d8b9f9873..16943e923902 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6510,6 +6510,7 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu)
 		return;
 
 	handle_interrupt_nmi_irqoff(vcpu, gate_offset(desc));
+	vcpu->arch.at_instruction_boundary = true;
 }
 
 static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0ccc8d1b972c..c1351335d22f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -231,6 +231,8 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("l1d_flush", l1d_flush),
 	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
 	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
+	VCPU_STAT("preemption_reported", preemption_reported),
+	VCPU_STAT("preemption_other", preemption_other),
 	VM_STAT("mmu_shadow_zapped", mmu_shadow_zapped),
 	VM_STAT("mmu_pte_write", mmu_pte_write),
 	VM_STAT("mmu_pde_zapped", mmu_pde_zapped),
@@ -4052,6 +4054,19 @@ static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
 	struct kvm_host_map map;
 	struct kvm_steal_time *st;
 
+	/*
+	 * The vCPU can be marked preempted if and only if the VM-Exit was on
+	 * an instruction boundary and will not trigger guest emulation of any
+	 * kind (see vcpu_run).  Vendor specific code controls (conservatively)
+	 * when this is true, for example allowing the vCPU to be marked
+	 * preempted if and only if the VM-Exit was due to a host interrupt.
+	 */
+	if (!vcpu->arch.at_instruction_boundary) {
+		vcpu->stat.preemption_other++;
+		return;
+	}
+
+	vcpu->stat.preemption_reported++;
 	if (!(vcpu->arch.st.msr_val & KVM_MSR_ENABLED))
 		return;
 
@@ -9357,6 +9372,13 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
 	vcpu->arch.l1tf_flush_l1d = true;
 
 	for (;;) {
+		/*
+		 * If another guest vCPU requests a PV TLB flush in the middle
+		 * of instruction emulation, the rest of the emulation could
+		 * use a stale page translation. Assume that any code after
+		 * this point can start executing an instruction.
+		 */
+		vcpu->arch.at_instruction_boundary = false;
 		if (kvm_vcpu_running(vcpu)) {
 			r = vcpu_enter_guest(vcpu);
 		} else {
-- 
2.39.1

