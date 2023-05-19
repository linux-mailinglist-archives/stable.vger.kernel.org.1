Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36A2709A49
	for <lists+stable@lfdr.de>; Fri, 19 May 2023 16:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjESOo4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 19 May 2023 10:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjESOoh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 19 May 2023 10:44:37 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FE010D2
        for <stable@vger.kernel.org>; Fri, 19 May 2023 07:44:19 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JBCI9U030263;
        Fri, 19 May 2023 14:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=yDyw1ZIPDpaF6pEu2zMqWh7yYyPNMwHb6E18Gu0JvCo=;
 b=d83E/AUdiB5I0gbr824ZfOdWbr52y3UZxd7nkFEf2M+6gA+g4pD6v6CaFQYVrfvH5C5h
 VkazLWF0o4UWARA7CPTcJ8IDtviiqYcXCduh72hFEKiIrQ4dlIdNVosVrE/BrLg7n+28
 cq5p0sL+61NvaVhS6ZXh635fLBKyMj3yND/1cRp+Lud9wosWdKJIIq63IBesPC7LVe+l
 ucDhngIDbmaF0aAo84Wy0Ja8VCq/foJN+FpmIZ5ZL4Lkh9akdeybQRFIIlc/Y0uAvBRO
 +zkFeyuStsFvB8+23wcnSEMqGsnsCbkiqrcjnvTJviX/QmiBPj4tmqIxY30fgSxCg71z kQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qhys06bf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 14:44:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oss6tjEmIy3EGvxyMgBaQJUxZG8l6kGzgFXxH2oqrjLQhprBwIf2it0Pca4BrW5CRFp87Gn8ju/nyHboYu/9/cchrU3ozlTBOS/AmSKrHtTkkmaGX56v9Pd8zic4a1WWifW8mups2x8EtTYFEXT+S1Cjdpjf6C1wknUWyI+kWRzZVYQy4AvAGmaGK8mMCTZNVfN6DgCoNvsSUPSHxCa6hHoh9v7nb/HnQpv4pt1pTegEbF1H5qyocjPpUZn7IVj/Vz4rnku4hf0cUEIdhp1hKaEOKN57KXAOVfD93IEFsVMn8pgdrmTM/6uJ3EsiM5vknqgeShXPi7pMlPNm4y83zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDyw1ZIPDpaF6pEu2zMqWh7yYyPNMwHb6E18Gu0JvCo=;
 b=WLSmTFDNuxV7hvYTCn+DFXsgtzxyt02NjXiIAll8Xt4dzJjqgypAXG3PEQrz9yU/EB3H/B+mNOkkITf/c56dpcCmcy8SRWVFjLkYRlSlTljQJIvd3tkAgUOvro4o5yOD7ZkGJRQMEALJalHbcX3/4Swp7bIvXDnBblftZhGRE3urZvryCF2L+20Jk55WPMT8B5iC0WwByZ5HyCblRtje5EfLoy0GTI0/ItpI6F0bGdVPaqp90Azezbj8jbc8w7iZA8kf8cYSyG61Kb47skIKnlqRqpRulPw7N9BmuS68S4L+OIHYzvrICawEINEFwApJAupMmRJiwJsW3aC3w539DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 14:44:12 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::60b2:e8cd:1927:54f3]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::60b2:e8cd:1927:54f3%5]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 14:44:11 +0000
From:   ovidiu.panait@windriver.com
To:     stable@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Jann Horn <jannh@google.com>,
        Ovidiu Panait <ovidiu.panait@windriver.com>
Subject: [PATCH 5.4 1/1] KVM: x86: do not report a vCPU as preempted outside instruction boundaries
Date:   Fri, 19 May 2023 17:43:51 +0300
Message-Id: <20230519144351.2527664-1-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.39.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::16) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5327:EE_|IA1PR11MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: ff37c403-bdab-4143-ef9e-08db58778259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: evdYPWGvZ9V7bWehaQJj5YX2E/Lt6W1fRhNIGSLSe8pHDbHqIbW9mOCpD2XczIcJx06BvY0I17Pp85VmNF0IU/iFZeTJMfIOx/MpfsOz0w0xR03VWRmBXIB6F3wuS+alxt+GffGQtXW7QjtmfpHQQh/fC44ODFaJcIvpHvjpOa+uNp03YD0egfGEmxLvTPusIFWwDGhpq8H26+AHQGhS9ID2j6cCyhBdY2UTt/9JHwoCx6byMJ/ntmaznfbUkOjOTJPiudVrqIMrXX6fcVKL2vKD755+Co0UP1I+W6Z1ko1TVgFcyvbSFHZN6obYUB0yH53XJrT5hpwkr86OFJrNiHjqI883l6CgqlFyisrnM+JQuoU5yVpx6dk4e1n/gPNe2PPSjZ3ktEt907jrL/hBTg8DjjRX2bX/ZoFqJse/07HVDcCwW2oXWUnhtS7J+YKUrBoDblpvA9E5xrolI8TYhJxxNb90GIpCbZl8KmwqqPfKzS0vE9uBvBxAviKZJiKLDEOSiNk3/dXHAqVd3Odxb7yOznE0WTthha4mzB8ep9N4vwAyZ5xmb/v9sVPP0Am+LZxRg53V9wtteFqq/35sJs/Ldc2YH16gnqK/zomx2KAybFhhR9dFqHpbRlFjGyjm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39850400004)(451199021)(38350700002)(9686003)(478600001)(86362001)(38100700002)(6512007)(36756003)(66476007)(66946007)(4326008)(6666004)(6486002)(6916009)(54906003)(316002)(66556008)(186003)(5660300002)(8676002)(8936002)(26005)(41300700001)(6506007)(107886003)(1076003)(52116002)(2616005)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ty98x1sNUsKxnq8REh7b9X/2sht8cLxPsA4imcjTb+8zTZh6seU4T3VIRXAn?=
 =?us-ascii?Q?6JhtXME29xjNH1WxsERd1Gop3Y43Ec5J1syz7U3YjIrUezcjkBRYj1n7KtIN?=
 =?us-ascii?Q?DTy13DUpbS2jCQhtazZ8WN9Wo7G3nOwD3Luf9QZMuQxq24ORKjC+uMBAGovD?=
 =?us-ascii?Q?+1K+w9iuq5rTiPAryKSii1tPsXafcv8ot7CK79MHWUKPvLh5Cx5n92WUHGtD?=
 =?us-ascii?Q?DXDHQrfOA+qnEoSe/7RABTkkGCLihqqC52iiH1TfW01cLiN4dWQ0O+5N9kRK?=
 =?us-ascii?Q?L1S/qCxaXzSBjT3A8bKMgxqVkJtQvf6HNINGW9CPgxX/tsOdVl2izlHH+yui?=
 =?us-ascii?Q?0GYa7E5UK9FL1yz2LaxauriWSAxw03nTxXXRpCkEDbzyWzVrAmdV/sU97tan?=
 =?us-ascii?Q?1hLhpqICb6MwkAz+gFQwr3HcWHfSy0f3FC5t4rx8kOlB2NR5/wMNCgmDss7G?=
 =?us-ascii?Q?JCo7n3PmM+RAaodewjjtezueVFsOMJlPPraPQzL6S0xMZQIQH+HZXj/KQO8s?=
 =?us-ascii?Q?Ibf6KsIuJTKnuj1IIN66o5KSuhnjmcyywAGrdPEuy350KrZ3HNIHzrnK2mf7?=
 =?us-ascii?Q?eufc0LNJm2u9vJQ2i0AZ0PK5VeJN91iam2jfIY52yIsNiFWor9GmJX0Qyr5G?=
 =?us-ascii?Q?gox17yfbmu1kbo7Z0FBB1APOgVebu+qhC0GIOxyfyEwbk1dFWFtacOtRqr/v?=
 =?us-ascii?Q?JzxIfNDlh0lQigXx4g2dQf2sUT/ps/3lIPqeF+RJPFaql2FoaFxJA1lLO+cB?=
 =?us-ascii?Q?RUi7hSfXG3DXBkhyDfViDl4OKb88entNYtWAlQARDKgiUF7NQkxxWl1gKO/w?=
 =?us-ascii?Q?o/XSroL5fMliK4QNWezpmTcmaZVHTrSDOXFp0Bl8iqWkkJ0L9e0jszdqVO97?=
 =?us-ascii?Q?j5FEgeY/mDLxO+2ZQPT9CNSLDLFrKjUAp7OR8UR1wXzfnpMHOENLrY8vrAxk?=
 =?us-ascii?Q?GEEXnc8wKR2hmwQcekDovJ75BwGkH9tKgTw4WniChr3f9OodWSfqa3RZw0uz?=
 =?us-ascii?Q?7pFdfdaG9ejCE1sJTOjTwRt0wyx1yJTKmNQoFmtD/IblyfaNNVZy7BckcbzO?=
 =?us-ascii?Q?+AsINiqdr/QOGt/sNl4/9f4cYabDeCuC4PQQvVBraTnt+fT/bWOUg2iRe8u0?=
 =?us-ascii?Q?Olcsz0YIXBxs0cEmnX1VDDnih34NCz8Mjt4QF/KMOps2lV23hKqQmcRSJioI?=
 =?us-ascii?Q?GQ6GKcd5q6724Hm/JxI9LRO3VuEzVz3OqiguEiRcDkxhHpvtjG88QNI4udlt?=
 =?us-ascii?Q?LbozLvGvXcgFgKqKG7pJnV4kCFZcOwnITJJvLtHYRnQhMet33eNRGQYYdxVm?=
 =?us-ascii?Q?SXg5oFwKaAa0pp5CRE4Nw33/oOTj1atZ8+Q6Rcnln1uPUdqqqNO/Q359xIlZ?=
 =?us-ascii?Q?YJuS/bkZ7V4H/0KOKks1sGrT2fhsNAjn1ih38jUO6vsVakL1Z5sI2PGvLXjT?=
 =?us-ascii?Q?ZKnPL2OnyUO/eTP1rdS8wcBdC+asSqAe8CcjmtfXVSyc9Fag5FkU/jgj6+3f?=
 =?us-ascii?Q?Lpmo0Tyd8Nj2yoR4BtUjB0lSqEQgIBXnjkh9ou1yQwVCQd8boMWWScxjH732?=
 =?us-ascii?Q?v87soGw2U0c6Y3t29OBOQ0hxAjm0dr0Pf3Ik4tpsMq7sVe6cPGlNs0SL/vaO?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff37c403-bdab-4143-ef9e-08db58778259
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 14:44:11.6857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJ/tEkSIEqhi/3YjVGkq2qjbgC/2QGsDc6QBuKKkJr6fo+ll6UXnwXfy/6DDStZaxl20c7ezGsJRBPfDooVzu94OLVKE7h61xNpJIahDMtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6097
X-Proofpoint-ORIG-GUID: EUar_zDQ5dFKWs8gJDM4xFe50-SIXu7D
X-Proofpoint-GUID: EUar_zDQ5dFKWs8gJDM4xFe50-SIXu7D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_10,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305190124
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
 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/svm.c              |  3 ++-
 arch/x86/kvm/vmx/vmx.c          |  1 +
 arch/x86/kvm/x86.c              | 22 ++++++++++++++++++++++
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4bc476d7fa6c..80239c84b4dd 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -563,6 +563,7 @@ struct kvm_vcpu_arch {
 	u64 ia32_misc_enable_msr;
 	u64 smbase;
 	u64 smi_count;
+	bool at_instruction_boundary;
 	bool tpr_access_reporting;
 	u64 ia32_xss;
 	u64 microcode_version;
@@ -981,6 +982,8 @@ struct kvm_vcpu_stat {
 	u64 irq_injections;
 	u64 nmi_injections;
 	u64 req_event;
+	u64 preemption_reported;
+	u64 preemption_other;
 };
 
 struct x86_instruction_info;
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index c5a9de8d0725..e9444e202c33 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -6246,7 +6246,8 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
 
 static void svm_handle_exit_irqoff(struct kvm_vcpu *vcpu)
 {
-
+	if (to_svm(vcpu)->vmcb->control.exit_code == SVM_EXIT_INTR)
+		vcpu->arch.at_instruction_boundary = true;
 }
 
 static void svm_sched_in(struct kvm_vcpu *vcpu, int cpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9bd08d264603..c93070829790 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6358,6 +6358,7 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu)
 	);
 
 	kvm_after_interrupt(vcpu);
+	vcpu->arch.at_instruction_boundary = true;
 }
 STACK_FRAME_NON_STANDARD(handle_external_interrupt_irqoff);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f5e9590a8f31..d152afdfa8b4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -207,6 +207,8 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "nmi_injections", VCPU_STAT(nmi_injections) },
 	{ "req_event", VCPU_STAT(req_event) },
 	{ "l1d_flush", VCPU_STAT(l1d_flush) },
+	{ "preemption_reported", VCPU_STAT(preemption_reported) },
+	{ "preemption_other", VCPU_STAT(preemption_other) },
 	{ "mmu_shadow_zapped", VM_STAT(mmu_shadow_zapped) },
 	{ "mmu_pte_write", VM_STAT(mmu_pte_write) },
 	{ "mmu_pde_zapped", VM_STAT(mmu_pde_zapped) },
@@ -3562,6 +3564,19 @@ static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
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
 
@@ -8446,6 +8461,13 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
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

