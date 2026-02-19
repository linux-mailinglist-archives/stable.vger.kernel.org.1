Return-Path: <stable+bounces-217459-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK4SGlcvl2kcvgIAu9opvQ
	(envelope-from <stable+bounces-217459-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:42:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E67216048D
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21B12302CD37
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 15:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F86347BC6;
	Thu, 19 Feb 2026 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OAN3vXSJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8524347BD7;
	Thu, 19 Feb 2026 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771515693; cv=none; b=XCnd/axVpHvWT61p3NjV3uU5ZapDJeYEvhbE537IzCwCUSf8urvXWQOWwCfliBk1a8fL0L2e8Iv1qG5zQ4FtXhbEBZZDaP8O7pXCCV7aEoqXiTylqM44eeyeKUodaQTd6vWAeJ8wdCUf3Yr4GzSCxId9wiAGrfiBzL2fk1yik14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771515693; c=relaxed/simple;
	bh=m4waWKrfPPwItIbJGyfOC3yHo8QrbMloInAso+/MMPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6uSmiRGpGVP+ei3IqoeVIT4aNTATfguBRzlfJssS7l/bO6nI/FDJeVutiaVbosbZ8OVcKs2+mCT1zELJKASrR0JtANpf5O1ytxoWbxI3qsfOowr6XQE+2aqcM34ZmXQ5OJynIVVTsTtDsIWfkuehoMZfdRYTRNv4QX/hzm8R7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OAN3vXSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F9DC116C6;
	Thu, 19 Feb 2026 15:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771515692;
	bh=m4waWKrfPPwItIbJGyfOC3yHo8QrbMloInAso+/MMPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OAN3vXSJpM+Kg+ngyHM32Gwv6sB0HECnKSob1/b+t75ZZIOGmVKfUrsb6W/tn7qwN
	 a2ib/GXmdkDlMF2NsxnJpO1HuCSayeOzihTwvtPT7++i+xsqCGtJRJIg8Nit9urt9M
	 zuEV7bLzRcngXJ7JPTG7+QQ86eqyIP7pVgZxaIkk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.19.3
Date: Thu, 19 Feb 2026 16:41:22 +0100
Message-ID: <2026021922-duty-trowel-9eeb@gregkh>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026021922-possibly-smartness-217f@gregkh>
References: <2026021922-possibly-smartness-217f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217459-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,0.0.0.1:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.0.0:email]
X-Rspamd-Queue-Id: 9E67216048D
X-Rspamd-Action: no action

diff --git a/Makefile b/Makefile
index f0eb659930b2..21df63507119 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 19
-SUBLEVEL = 2
+SUBLEVEL = 3
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 4e20a8f2eb25..95cc06799533 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1812,15 +1812,23 @@ ports {
 				#size-cells = <0>;
 
 				port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
 					reg = <0>;
-					ovl_2l1_in: endpoint {
+
+					ovl_2l1_in: endpoint@1 {
+						reg = <1>;
 						remote-endpoint = <&mmsys_ep_ext>;
 					};
 				};
 
 				port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
 					reg = <1>;
-					ovl_2l1_out: endpoint {
+
+					ovl_2l1_out: endpoint@1 {
+						reg = <1>;
 						remote-endpoint = <&rdma1_in>;
 					};
 				};
@@ -1872,15 +1880,23 @@ ports {
 				#size-cells = <0>;
 
 				port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
 					reg = <0>;
-					rdma1_in: endpoint {
+
+					rdma1_in: endpoint@1 {
+						reg = <1>;
 						remote-endpoint = <&ovl_2l1_out>;
 					};
 				};
 
 				port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
 					reg = <1>;
-					rdma1_out: endpoint {
+
+					rdma1_out: endpoint@1 {
+						reg = <1>;
 						remote-endpoint = <&dpi_in>;
 					};
 				};
@@ -2076,15 +2092,24 @@ ports {
 				#size-cells = <0>;
 
 				port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
 					reg = <0>;
-					dpi_in: endpoint {
+
+					dpi_in: endpoint@1 {
+						reg = <1>;
 						remote-endpoint = <&rdma1_out>;
 					};
 				};
 
 				port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
 					reg = <1>;
-					dpi_out: endpoint { };
+
+					dpi_out: endpoint@1  {
+						reg = <1>;
+					};
 				};
 			};
 		};
diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_init.c
index 170da98ad4f5..0fc02ca06457 100644
--- a/arch/loongarch/mm/kasan_init.c
+++ b/arch/loongarch/mm/kasan_init.c
@@ -40,39 +40,43 @@ static pgd_t kasan_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 #define __pte_none(early, pte) (early ? pte_none(pte) : \
 ((pte_val(pte) & _PFN_MASK) == (unsigned long)__pa(kasan_early_shadow_page)))
 
-void *kasan_mem_to_shadow(const void *addr)
+static void *mem_to_shadow(const void *addr)
 {
-	if (!kasan_enabled()) {
+	unsigned long offset = 0;
+	unsigned long maddr = (unsigned long)addr;
+	unsigned long xrange = (maddr >> XRANGE_SHIFT) & 0xffff;
+
+	if (maddr >= FIXADDR_START)
 		return (void *)(kasan_early_shadow_page);
-	} else {
-		unsigned long maddr = (unsigned long)addr;
-		unsigned long xrange = (maddr >> XRANGE_SHIFT) & 0xffff;
-		unsigned long offset = 0;
-
-		if (maddr >= FIXADDR_START)
-			return (void *)(kasan_early_shadow_page);
-
-		maddr &= XRANGE_SHADOW_MASK;
-		switch (xrange) {
-		case XKPRANGE_CC_SEG:
-			offset = XKPRANGE_CC_SHADOW_OFFSET;
-			break;
-		case XKPRANGE_UC_SEG:
-			offset = XKPRANGE_UC_SHADOW_OFFSET;
-			break;
-		case XKPRANGE_WC_SEG:
-			offset = XKPRANGE_WC_SHADOW_OFFSET;
-			break;
-		case XKVRANGE_VC_SEG:
-			offset = XKVRANGE_VC_SHADOW_OFFSET;
-			break;
-		default:
-			WARN_ON(1);
-			return NULL;
-		}
 
-		return (void *)((maddr >> KASAN_SHADOW_SCALE_SHIFT) + offset);
+	maddr &= XRANGE_SHADOW_MASK;
+	switch (xrange) {
+	case XKPRANGE_CC_SEG:
+		offset = XKPRANGE_CC_SHADOW_OFFSET;
+		break;
+	case XKPRANGE_UC_SEG:
+		offset = XKPRANGE_UC_SHADOW_OFFSET;
+		break;
+	case XKPRANGE_WC_SEG:
+		offset = XKPRANGE_WC_SHADOW_OFFSET;
+		break;
+	case XKVRANGE_VC_SEG:
+		offset = XKVRANGE_VC_SHADOW_OFFSET;
+		break;
+	default:
+		WARN_ON(1);
+		return NULL;
 	}
+
+	return (void *)((maddr >> KASAN_SHADOW_SCALE_SHIFT) + offset);
+}
+
+void *kasan_mem_to_shadow(const void *addr)
+{
+	if (kasan_enabled())
+		return mem_to_shadow(addr);
+	else
+		return (void *)(kasan_early_shadow_page);
 }
 
 const void *kasan_shadow_to_mem(const void *shadow_addr)
@@ -293,11 +297,8 @@ void __init kasan_init(void)
 	/* Maps everything to a single page of zeroes */
 	kasan_pgd_populate(KASAN_SHADOW_START, KASAN_SHADOW_END, NUMA_NO_NODE, true);
 
-	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
-					kasan_mem_to_shadow((void *)KFENCE_AREA_END));
-
-	/* Enable KASAN here before kasan_mem_to_shadow(). */
-	kasan_init_generic();
+	kasan_populate_early_shadow(mem_to_shadow((void *)VMALLOC_START),
+					mem_to_shadow((void *)KFENCE_AREA_END));
 
 	/* Populate the linear mapping */
 	for_each_mem_range(i, &pa_start, &pa_end) {
@@ -307,13 +308,13 @@ void __init kasan_init(void)
 		if (start >= end)
 			break;
 
-		kasan_map_populate((unsigned long)kasan_mem_to_shadow(start),
-			(unsigned long)kasan_mem_to_shadow(end), NUMA_NO_NODE);
+		kasan_map_populate((unsigned long)mem_to_shadow(start),
+			(unsigned long)mem_to_shadow(end), NUMA_NO_NODE);
 	}
 
 	/* Populate modules mapping */
-	kasan_map_populate((unsigned long)kasan_mem_to_shadow((void *)MODULES_VADDR),
-		(unsigned long)kasan_mem_to_shadow((void *)MODULES_END), NUMA_NO_NODE);
+	kasan_map_populate((unsigned long)mem_to_shadow((void *)MODULES_VADDR),
+		(unsigned long)mem_to_shadow((void *)MODULES_END), NUMA_NO_NODE);
 	/*
 	 * KAsan may reuse the contents of kasan_early_shadow_pte directly, so we
 	 * should make sure that it maps the zero page read-only.
@@ -328,4 +329,5 @@ void __init kasan_init(void)
 
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
+	kasan_init_generic();
 }
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index db9b9a8e139c..4565a58bb213 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -228,3 +228,17 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 
 	return smmu;
 }
+
+int __init arm_smmu_impl_module_init(void)
+{
+	if (IS_ENABLED(CONFIG_ARM_SMMU_QCOM))
+		return qcom_smmu_module_init();
+
+	return 0;
+}
+
+void __exit arm_smmu_impl_module_exit(void)
+{
+	if (IS_ENABLED(CONFIG_ARM_SMMU_QCOM))
+		qcom_smmu_module_exit();
+}
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 573085349df3..22906d2c9a2d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -774,10 +774,6 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
 {
 	const struct device_node *np = smmu->dev->of_node;
 	const struct of_device_id *match;
-	static u8 tbu_registered;
-
-	if (!tbu_registered++)
-		platform_driver_register(&qcom_smmu_tbu_driver);
 
 #ifdef CONFIG_ACPI
 	if (np == NULL) {
@@ -802,3 +798,13 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
 
 	return smmu;
 }
+
+int __init qcom_smmu_module_init(void)
+{
+	return platform_driver_register(&qcom_smmu_tbu_driver);
+}
+
+void __exit qcom_smmu_module_exit(void)
+{
+	platform_driver_unregister(&qcom_smmu_tbu_driver);
+}
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 5e690cf85ec9..1e218fbea35a 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2365,7 +2365,29 @@ static struct platform_driver arm_smmu_driver = {
 	.remove = arm_smmu_device_remove,
 	.shutdown = arm_smmu_device_shutdown,
 };
-module_platform_driver(arm_smmu_driver);
+
+static int __init arm_smmu_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&arm_smmu_driver);
+	if (ret)
+		return ret;
+
+	ret = arm_smmu_impl_module_init();
+	if (ret)
+		platform_driver_unregister(&arm_smmu_driver);
+
+	return ret;
+}
+module_init(arm_smmu_init);
+
+static void __exit arm_smmu_exit(void)
+{
+	arm_smmu_impl_module_exit();
+	platform_driver_unregister(&arm_smmu_driver);
+}
+module_exit(arm_smmu_exit);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
 MODULE_AUTHOR("Will Deacon <will@kernel.org>");
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 2dbf3243b5ad..26d2e33cd328 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -540,6 +540,11 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu);
 struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu);
 struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu);
 
+int __init arm_smmu_impl_module_init(void);
+void __exit arm_smmu_impl_module_exit(void);
+int __init qcom_smmu_module_init(void);
+void __exit qcom_smmu_module_exit(void);
+
 void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx);
 int arm_mmu500_reset(struct arm_smmu_device *smmu);
 
diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index ccfc2d26dd37..0798bfd0372e 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -1546,8 +1546,9 @@ qla2x00_update_optrom(struct bsg_job *bsg_job)
 	ha->optrom_buffer = NULL;
 	ha->optrom_state = QLA_SWAITING;
 	mutex_unlock(&ha->optrom_mutex);
-	bsg_job_done(bsg_job, bsg_reply->result,
-		       bsg_reply->reply_payload_rcv_len);
+	if (!rval)
+		bsg_job_done(bsg_job, bsg_reply->result,
+			     bsg_reply->reply_payload_rcv_len);
 	return rval;
 }
 
@@ -2612,8 +2613,9 @@ qla2x00_manage_host_stats(struct bsg_job *bsg_job)
 				    sizeof(struct ql_vnd_mng_host_stats_resp));
 
 	bsg_reply->result = DID_OK;
-	bsg_job_done(bsg_job, bsg_reply->result,
-		     bsg_reply->reply_payload_rcv_len);
+	if (!ret)
+		bsg_job_done(bsg_job, bsg_reply->result,
+			     bsg_reply->reply_payload_rcv_len);
 
 	return ret;
 }
@@ -2702,8 +2704,9 @@ qla2x00_get_host_stats(struct bsg_job *bsg_job)
 							       bsg_job->reply_payload.sg_cnt,
 							       data, response_len);
 	bsg_reply->result = DID_OK;
-	bsg_job_done(bsg_job, bsg_reply->result,
-		     bsg_reply->reply_payload_rcv_len);
+	if (!ret)
+		bsg_job_done(bsg_job, bsg_reply->result,
+			     bsg_reply->reply_payload_rcv_len);
 
 	kfree(data);
 host_stat_out:
@@ -2802,8 +2805,9 @@ qla2x00_get_tgt_stats(struct bsg_job *bsg_job)
 				    bsg_job->reply_payload.sg_cnt, data,
 				    response_len);
 	bsg_reply->result = DID_OK;
-	bsg_job_done(bsg_job, bsg_reply->result,
-		     bsg_reply->reply_payload_rcv_len);
+	if (!ret)
+		bsg_job_done(bsg_job, bsg_reply->result,
+			     bsg_reply->reply_payload_rcv_len);
 
 tgt_stat_out:
 	kfree(data);
@@ -2864,8 +2868,9 @@ qla2x00_manage_host_port(struct bsg_job *bsg_job)
 				    bsg_job->reply_payload.sg_cnt, &rsp_data,
 				    sizeof(struct ql_vnd_mng_host_port_resp));
 	bsg_reply->result = DID_OK;
-	bsg_job_done(bsg_job, bsg_reply->result,
-		     bsg_reply->reply_payload_rcv_len);
+	if (!ret)
+		bsg_job_done(bsg_job, bsg_reply->result,
+			     bsg_reply->reply_payload_rcv_len);
 
 	return ret;
 }
@@ -3240,7 +3245,8 @@ int qla2x00_mailbox_passthru(struct bsg_job *bsg_job)
 
 	bsg_job->reply_len = sizeof(*bsg_job->reply);
 	bsg_reply->result = DID_OK << 16;
-	bsg_job_done(bsg_job, bsg_reply->result, bsg_reply->reply_payload_rcv_len);
+	if (!ret)
+		bsg_job_done(bsg_job, bsg_reply->result, bsg_reply->reply_payload_rcv_len);
 
 	kfree(req_data);
 
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 9f2cc5fb9f45..d4505a426446 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1401,12 +1401,16 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a0, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a1, 0xff),	/* Telit FN20C04 (RNDIS) */
+	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a2, 0xff),	/* Telit FN920C04 (MBIM) */
 	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a3, 0xff),	/* Telit FN920C04 (ECM) */
 	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a4, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a6, 0xff),	/* Telit FN920C04 (RNDIS) */
+	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a7, 0xff),	/* Telit FN920C04 (MBIM) */
 	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a8, 0xff),	/* Telit FN920C04 (ECM) */
@@ -1415,6 +1419,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10aa, 0xff),	/* Telit FN920C04 (MBIM) */
 	  .driver_info = NCTRL(3) | RSVD(4) | RSVD(5) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10ab, 0xff),	/* Telit FN920C04 (RNDIS) */
+	  .driver_info = NCTRL(3) | RSVD(4) | RSVD(5) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b0, 0xff, 0xff, 0x30),	/* Telit FE990B (rmnet) */
 	  .driver_info = NCTRL(5) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b0, 0xff, 0xff, 0x40) },
diff --git a/drivers/video/fbdev/riva/riva_hw.c b/drivers/video/fbdev/riva/riva_hw.c
index 8b829b720064..f292079566cf 100644
--- a/drivers/video/fbdev/riva/riva_hw.c
+++ b/drivers/video/fbdev/riva/riva_hw.c
@@ -436,6 +436,9 @@ static char nv3_arb(nv3_fifo_info * res_info, nv3_sim_state * state,  nv3_arb_in
     vmisses = 2;
     eburst_size = state->memory_width * 1;
     mburst_size = 32;
+    if (!state->mclk_khz)
+	return (0);
+
     gns = 1000000 * (gmisses*state->mem_page_miss + state->mem_latency)/state->mclk_khz;
     ainfo->by_gfacc = gns*ainfo->gdrain_rate/1000000;
     ainfo->wcmocc = 0;
diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index 5f0dd01fd834..891ce7b76d63 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -932,7 +932,6 @@ static int ufx_ops_ioctl(struct fb_info *info, unsigned int cmd,
 			 unsigned long arg)
 {
 	struct ufx_data *dev = info->par;
-	struct dloarea *area = NULL;
 
 	if (!atomic_read(&dev->usb_active))
 		return 0;
@@ -947,6 +946,10 @@ static int ufx_ops_ioctl(struct fb_info *info, unsigned int cmd,
 
 	/* TODO: Help propose a standard fb.h ioctl to report mmap damage */
 	if (cmd == UFX_IOCTL_REPORT_DAMAGE) {
+		struct dloarea *area __free(kfree) = kmalloc(sizeof(*area), GFP_KERNEL);
+		if (!area)
+			return -ENOMEM;
+
 		/* If we have a damage-aware client, turn fb_defio "off"
 		 * To avoid perf imact of unnecessary page fault handling.
 		 * Done by resetting the delay for this fb_info to a very
@@ -956,7 +959,8 @@ static int ufx_ops_ioctl(struct fb_info *info, unsigned int cmd,
 		if (info->fbdefio)
 			info->fbdefio->delay = UFX_DEFIO_WRITE_DISABLE;
 
-		area = (struct dloarea *)arg;
+		if (copy_from_user(area, (u8 __user *)arg, sizeof(*area)))
+			return -EFAULT;
 
 		if (area->x < 0)
 			area->x = 0;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c30e69392a62..86e00b9e0d1c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -151,6 +151,12 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 		}
 
 		dec_page_count(F2FS_F_SB(folio), __read_io_type(folio));
+
+		if (F2FS_F_SB(folio)->node_inode && is_node_folio(folio) &&
+			f2fs_sanity_check_node_footer(F2FS_F_SB(folio),
+				folio, folio->index, NODE_TYPE_REGULAR, true))
+			bio->bi_status = BLK_STS_IOERR;
+
 		folio_end_read(folio, bio->bi_status == BLK_STS_OK);
 	}
 
@@ -352,18 +358,27 @@ static void f2fs_write_end_io(struct bio *bio)
 						STOP_CP_REASON_WRITE_FAIL);
 		}
 
-		f2fs_bug_on(sbi, is_node_folio(folio) &&
-				folio->index != nid_of_node(folio));
+		if (is_node_folio(folio)) {
+			f2fs_sanity_check_node_footer(sbi, folio,
+				folio->index, NODE_TYPE_REGULAR, true);
+			f2fs_bug_on(sbi, folio->index != nid_of_node(folio));
+		}
 
 		dec_page_count(sbi, type);
+
+		/*
+		 * we should access sbi before folio_end_writeback() to
+		 * avoid racing w/ kill_f2fs_super()
+		 */
+		if (type == F2FS_WB_CP_DATA && !get_pages(sbi, type) &&
+				wq_has_sleeper(&sbi->cp_wait))
+			wake_up(&sbi->cp_wait);
+
 		if (f2fs_in_warm_node_list(sbi, folio))
 			f2fs_del_fsync_node_entry(sbi, folio);
 		folio_clear_f2fs_gcing(folio);
 		folio_end_writeback(folio);
 	}
-	if (!get_pages(sbi, F2FS_WB_CP_DATA) &&
-				wq_has_sleeper(&sbi->cp_wait))
-		wake_up(&sbi->cp_wait);
 
 	bio_put(bio);
 }
@@ -1418,7 +1433,6 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 
 static void f2fs_map_lock(struct f2fs_sb_info *sbi, int flag)
 {
-	f2fs_down_read(&sbi->cp_enable_rwsem);
 	if (flag == F2FS_GET_BLOCK_PRE_AIO)
 		f2fs_down_read(&sbi->node_change);
 	else
@@ -1431,7 +1445,6 @@ static void f2fs_map_unlock(struct f2fs_sb_info *sbi, int flag)
 		f2fs_up_read(&sbi->node_change);
 	else
 		f2fs_unlock_op(sbi);
-	f2fs_up_read(&sbi->cp_enable_rwsem);
 }
 
 int f2fs_get_block_locked(struct dnode_of_data *dn, pgoff_t index)
@@ -1793,7 +1806,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 	return err;
 }
 
-bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len)
+static bool __f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len,
+				bool check_first)
 {
 	struct f2fs_map_blocks map;
 	block_t last_lblk;
@@ -1815,10 +1829,17 @@ bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len)
 		if (err || map.m_len == 0)
 			return false;
 		map.m_lblk += map.m_len;
+		if (check_first)
+			break;
 	}
 	return true;
 }
 
+bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len)
+{
+	return __f2fs_overwrite_io(inode, pos, len, false);
+}
+
 static int f2fs_xattr_fiemap(struct inode *inode,
 				struct fiemap_extent_info *fieinfo)
 {
@@ -3929,6 +3950,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
 
 	while (cur_lblock < last_lblock && cur_lblock < sis->max) {
 		struct f2fs_map_blocks map;
+		bool last_extent = false;
 retry:
 		cond_resched();
 
@@ -3954,11 +3976,10 @@ static int check_swap_activate(struct swap_info_struct *sis,
 		pblock = map.m_pblk;
 		nr_pblocks = map.m_len;
 
-		if ((pblock - SM_I(sbi)->main_blkaddr) % blks_per_sec ||
-				nr_pblocks % blks_per_sec ||
-				f2fs_is_sequential_zone_area(sbi, pblock)) {
-			bool last_extent = false;
-
+		if (!last_extent &&
+			((pblock - SM_I(sbi)->main_blkaddr) % blks_per_sec ||
+			nr_pblocks % blks_per_sec ||
+			f2fs_is_sequential_zone_area(sbi, pblock))) {
 			not_aligned++;
 
 			nr_pblocks = roundup(nr_pblocks, blks_per_sec);
@@ -3979,8 +4000,8 @@ static int check_swap_activate(struct swap_info_struct *sis,
 				goto out;
 			}
 
-			if (!last_extent)
-				goto retry;
+			/* lookup block mapping info after block migration */
+			goto retry;
 		}
 
 		if (cur_lblock + nr_pblocks >= sis->max)
@@ -4181,7 +4202,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	 * f2fs_map_lock and f2fs_balance_fs are not necessary.
 	 */
 	if ((flags & IOMAP_WRITE) &&
-		!f2fs_overwrite_io(inode, offset, length))
+		!__f2fs_overwrite_io(inode, offset, length, true))
 		map.m_may_create = true;
 
 	err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_DIO);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 20edbb99b814..d9a8465cb2f4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -287,7 +287,7 @@ enum {
 #define DEF_CP_INTERVAL			60	/* 60 secs */
 #define DEF_IDLE_INTERVAL		5	/* 5 secs */
 #define DEF_DISABLE_INTERVAL		5	/* 5 secs */
-#define DEF_ENABLE_INTERVAL		5	/* 5 secs */
+#define DEF_ENABLE_INTERVAL		16	/* 16 secs */
 #define DEF_DISABLE_QUICK_INTERVAL	1	/* 1 secs */
 #define DEF_UMOUNT_DISCARD_TIMEOUT	5	/* 5 secs */
 
@@ -521,13 +521,25 @@ struct fsync_inode_entry {
 #define nats_in_cursum(jnl)		(le16_to_cpu((jnl)->n_nats))
 #define sits_in_cursum(jnl)		(le16_to_cpu((jnl)->n_sits))
 
-#define nat_in_journal(jnl, i)		((jnl)->nat_j.entries[i].ne)
-#define nid_in_journal(jnl, i)		((jnl)->nat_j.entries[i].nid)
-#define sit_in_journal(jnl, i)		((jnl)->sit_j.entries[i].se)
-#define segno_in_journal(jnl, i)	((jnl)->sit_j.entries[i].segno)
-
-#define MAX_NAT_JENTRIES(jnl)	(NAT_JOURNAL_ENTRIES - nats_in_cursum(jnl))
-#define MAX_SIT_JENTRIES(jnl)	(SIT_JOURNAL_ENTRIES - sits_in_cursum(jnl))
+#define nat_in_journal(jnl, i) \
+	(((struct nat_journal_entry *)(jnl)->nat_j.entries)[i].ne)
+#define nid_in_journal(jnl, i) \
+	(((struct nat_journal_entry *)(jnl)->nat_j.entries)[i].nid)
+#define sit_in_journal(jnl, i) \
+	(((struct sit_journal_entry *)(jnl)->sit_j.entries)[i].se)
+#define segno_in_journal(jnl, i) \
+	(((struct sit_journal_entry *)(jnl)->sit_j.entries)[i].segno)
+
+#define sum_entries(sum)	((struct f2fs_summary *)(sum))
+#define sum_journal(sbi, sum) \
+	((struct f2fs_journal *)((char *)(sum) + \
+	((sbi)->entries_in_sum * sizeof(struct f2fs_summary))))
+#define sum_footer(sbi, sum) \
+	((struct summary_footer *)((char *)(sum) + (sbi)->sum_blocksize - \
+	sizeof(struct summary_footer)))
+
+#define MAX_NAT_JENTRIES(sbi, jnl)	((sbi)->nat_journal_entries - nats_in_cursum(jnl))
+#define MAX_SIT_JENTRIES(sbi, jnl)	((sbi)->sit_journal_entries - sits_in_cursum(jnl))
 
 static inline int update_nats_in_cursum(struct f2fs_journal *journal, int i)
 {
@@ -545,14 +557,6 @@ static inline int update_sits_in_cursum(struct f2fs_journal *journal, int i)
 	return before;
 }
 
-static inline bool __has_cursum_space(struct f2fs_journal *journal,
-							int size, int type)
-{
-	if (type == NAT_JOURNAL)
-		return size <= MAX_NAT_JENTRIES(journal);
-	return size <= MAX_SIT_JENTRIES(journal);
-}
-
 /* for inline stuff */
 #define DEF_INLINE_RESERVED_SIZE	1
 static inline int get_extra_isize(struct inode *inode);
@@ -1525,6 +1529,15 @@ enum f2fs_lookup_mode {
 	LOOKUP_AUTO,
 };
 
+/* For node type in __get_node_folio() */
+enum node_type {
+	NODE_TYPE_REGULAR,
+	NODE_TYPE_INODE,
+	NODE_TYPE_XATTR,
+	NODE_TYPE_NON_INODE,
+};
+
+
 static inline int f2fs_test_bit(unsigned int nr, char *addr);
 static inline void f2fs_set_bit(unsigned int nr, char *addr);
 static inline void f2fs_clear_bit(unsigned int nr, char *addr);
@@ -1716,7 +1729,6 @@ struct f2fs_sb_info {
 	long interval_time[MAX_TIME];		/* to store thresholds */
 	struct ckpt_req_control cprc_info;	/* for checkpoint request control */
 	struct cp_stats cp_stats;		/* for time stat of checkpoint */
-	struct f2fs_rwsem cp_enable_rwsem;	/* block cache/dio write */
 
 	struct inode_management im[MAX_INO_ENTRY];	/* manage inode cache */
 
@@ -1764,6 +1776,15 @@ struct f2fs_sb_info {
 	bool readdir_ra;			/* readahead inode in readdir */
 	u64 max_io_bytes;			/* max io bytes to merge IOs */
 
+	/* variable summary block units */
+	unsigned int sum_blocksize;		/* sum block size */
+	unsigned int sums_per_block;		/* sum block count per block */
+	unsigned int entries_in_sum;		/* entry count in sum block */
+	unsigned int sum_entry_size;		/* total entry size in sum block */
+	unsigned int sum_journal_size;		/* journal size in sum block */
+	unsigned int nat_journal_entries;	/* nat journal entry count in the journal */
+	unsigned int sit_journal_entries;	/* sit journal entry count in the journal */
+
 	block_t user_block_count;		/* # of user blocks */
 	block_t total_valid_block_count;	/* # of valid blocks */
 	block_t discard_blks;			/* discard command candidats */
@@ -2813,6 +2834,14 @@ static inline block_t __start_sum_addr(struct f2fs_sb_info *sbi)
 	return le32_to_cpu(F2FS_CKPT(sbi)->cp_pack_start_sum);
 }
 
+static inline bool __has_cursum_space(struct f2fs_sb_info *sbi,
+			struct f2fs_journal *journal, int size, int type)
+{
+	if (type == NAT_JOURNAL)
+		return size <= MAX_NAT_JENTRIES(sbi, journal);
+	return size <= MAX_SIT_JENTRIES(sbi, journal);
+}
+
 extern void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync);
 static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 					struct inode *inode, bool is_inode)
@@ -3857,6 +3886,9 @@ struct folio *f2fs_new_node_folio(struct dnode_of_data *dn, unsigned int ofs);
 void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
 struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
 						enum node_type node_type);
+int f2fs_sanity_check_node_footer(struct f2fs_sb_info *sbi,
+					struct folio *folio, pgoff_t nid,
+					enum node_type ntype, bool in_irq);
 struct folio *f2fs_get_inode_folio(struct f2fs_sb_info *sbi, pgoff_t ino);
 struct folio *f2fs_get_xnode_folio(struct f2fs_sb_info *sbi, pgoff_t xnid);
 int f2fs_move_node_folio(struct folio *node_folio, int gc_type);
@@ -3956,7 +3988,8 @@ void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
 								block_t len);
 void f2fs_write_data_summaries(struct f2fs_sb_info *sbi, block_t start_blk);
 void f2fs_write_node_summaries(struct f2fs_sb_info *sbi, block_t start_blk);
-int f2fs_lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
+int f2fs_lookup_journal_in_cursum(struct f2fs_sb_info *sbi,
+			struct f2fs_journal *journal, int type,
 			unsigned int val, int alloc);
 void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 int f2fs_check_and_fix_write_pointer(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 384fa7e2085b..fa20bcd70058 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1769,8 +1769,8 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 	sanity_check_seg_type(sbi, get_seg_entry(sbi, segno)->type);
 
-	segno = rounddown(segno, SUMS_PER_BLOCK);
-	sum_blk_cnt = DIV_ROUND_UP(end_segno - segno, SUMS_PER_BLOCK);
+	segno = rounddown(segno, sbi->sums_per_block);
+	sum_blk_cnt = DIV_ROUND_UP(end_segno - segno, sbi->sums_per_block);
 	/* readahead multi ssa blocks those have contiguous address */
 	if (__is_large_section(sbi))
 		f2fs_ra_meta_pages(sbi, GET_SUM_BLOCK(sbi, segno),
@@ -1780,17 +1780,17 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	while (segno < end_segno) {
 		struct folio *sum_folio = f2fs_get_sum_folio(sbi, segno);
 
-		segno += SUMS_PER_BLOCK;
+		segno += sbi->sums_per_block;
 		if (IS_ERR(sum_folio)) {
 			int err = PTR_ERR(sum_folio);
 
-			end_segno = segno - SUMS_PER_BLOCK;
-			segno = rounddown(start_segno, SUMS_PER_BLOCK);
+			end_segno = segno - sbi->sums_per_block;
+			segno = rounddown(start_segno, sbi->sums_per_block);
 			while (segno < end_segno) {
 				sum_folio = filemap_get_folio(META_MAPPING(sbi),
 						GET_SUM_BLOCK(sbi, segno));
 				folio_put_refs(sum_folio, 2);
-				segno += SUMS_PER_BLOCK;
+				segno += sbi->sums_per_block;
 			}
 			return err;
 		}
@@ -1806,8 +1806,8 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 		/* find segment summary of victim */
 		struct folio *sum_folio = filemap_get_folio(META_MAPPING(sbi),
 					GET_SUM_BLOCK(sbi, segno));
-		unsigned int block_end_segno = rounddown(segno, SUMS_PER_BLOCK)
-					+ SUMS_PER_BLOCK;
+		unsigned int block_end_segno = rounddown(segno, sbi->sums_per_block)
+					+ sbi->sums_per_block;
 
 		if (block_end_segno > end_segno)
 			block_end_segno = end_segno;
@@ -1833,12 +1833,13 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 					migrated >= sbi->migration_granularity)
 				continue;
 
-			sum = SUM_BLK_PAGE_ADDR(sum_folio, cur_segno);
-			if (type != GET_SUM_TYPE((&sum->footer))) {
+			sum = SUM_BLK_PAGE_ADDR(sbi, sum_folio, cur_segno);
+			if (type != GET_SUM_TYPE(sum_footer(sbi, sum))) {
 				f2fs_err(sbi, "Inconsistent segment (%u) type "
 						"[%d, %d] in SSA and SIT",
 						cur_segno, type,
-						GET_SUM_TYPE((&sum->footer)));
+						GET_SUM_TYPE(
+						sum_footer(sbi, sum)));
 				f2fs_stop_checkpoint(sbi, false,
 						STOP_CP_REASON_CORRUPTED_SUMMARY);
 				continue;
@@ -2096,6 +2097,7 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
 
+	stat_inc_gc_call_count(sbi, FOREGROUND);
 	for (segno = start_seg; segno <= end_seg; segno += SEGS_PER_SEC(sbi)) {
 		struct gc_inode_list gc_list = {
 			.ilist = LIST_HEAD_INIT(gc_list.ilist),
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 482a362f2625..591fcdf3ba77 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -606,7 +606,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 		goto retry;
 	}
 
-	i = f2fs_lookup_journal_in_cursum(journal, NAT_JOURNAL, nid, 0);
+	i = f2fs_lookup_journal_in_cursum(sbi, journal, NAT_JOURNAL, nid, 0);
 	if (i >= 0) {
 		ne = nat_in_journal(journal, i);
 		node_info_from_raw_nat(ni, &ne);
@@ -1500,9 +1500,9 @@ void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
 	f2fs_folio_put(afolio, err ? true : false);
 }
 
-static int sanity_check_node_footer(struct f2fs_sb_info *sbi,
+int f2fs_sanity_check_node_footer(struct f2fs_sb_info *sbi,
 					struct folio *folio, pgoff_t nid,
-					enum node_type ntype)
+					enum node_type ntype, bool in_irq)
 {
 	if (unlikely(nid != nid_of_node(folio)))
 		goto out_err;
@@ -1527,12 +1527,13 @@ static int sanity_check_node_footer(struct f2fs_sb_info *sbi,
 		goto out_err;
 	return 0;
 out_err:
-	f2fs_warn(sbi, "inconsistent node block, node_type:%d, nid:%lu, "
-		  "node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
-		  ntype, nid, nid_of_node(folio), ino_of_node(folio),
-		  ofs_of_node(folio), cpver_of_node(folio),
-		  next_blkaddr_of_node(folio));
 	set_sbi_flag(sbi, SBI_NEED_FSCK);
+	f2fs_warn_ratelimited(sbi, "inconsistent node block, node_type:%d, nid:%lu, "
+		"node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
+		ntype, nid, nid_of_node(folio), ino_of_node(folio),
+		ofs_of_node(folio), cpver_of_node(folio),
+		next_blkaddr_of_node(folio));
+
 	f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
 	return -EFSCORRUPTED;
 }
@@ -1578,7 +1579,7 @@ static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
 		goto out_err;
 	}
 page_hit:
-	err = sanity_check_node_footer(sbi, folio, nid, ntype);
+	err = f2fs_sanity_check_node_footer(sbi, folio, nid, ntype, false);
 	if (!err)
 		return folio;
 out_err:
@@ -1751,7 +1752,12 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool *submitted
 
 	/* get old block addr of this node page */
 	nid = nid_of_node(folio);
-	f2fs_bug_on(sbi, folio->index != nid);
+
+	if (f2fs_sanity_check_node_footer(sbi, folio, nid,
+					NODE_TYPE_REGULAR, false)) {
+		f2fs_handle_critical_error(sbi, STOP_CP_REASON_CORRUPTED_NID);
+		goto redirty_out;
+	}
 
 	if (f2fs_get_node_info(sbi, nid, &ni, !do_balance))
 		goto redirty_out;
@@ -1774,8 +1780,13 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool *submitted
 		goto redirty_out;
 	}
 
-	if (atomic && !test_opt(sbi, NOBARRIER))
-		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
+	if (atomic) {
+		if (!test_opt(sbi, NOBARRIER))
+			fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
+		if (IS_INODE(folio))
+			set_dentry_mark(folio,
+				f2fs_need_dentry_mark(sbi, ino_of_node(folio)));
+	}
 
 	/* should add to global list before clearing PAGECACHE status */
 	if (f2fs_in_warm_node_list(sbi, folio)) {
@@ -1916,8 +1927,9 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 					if (is_inode_flag_set(inode,
 								FI_DIRTY_INODE))
 						f2fs_update_inode(inode, folio);
-					set_dentry_mark(folio,
-						f2fs_need_dentry_mark(sbi, ino));
+					if (!atomic)
+						set_dentry_mark(folio,
+							f2fs_need_dentry_mark(sbi, ino));
 				}
 				/* may be written by other thread */
 				if (!folio_test_dirty(folio))
@@ -2937,7 +2949,7 @@ int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
 	/* scan the node segment */
 	last_offset = BLKS_PER_SEG(sbi);
 	addr = START_BLOCK(sbi, segno);
-	sum_entry = &sum->entries[0];
+	sum_entry = sum_entries(sum);
 
 	for (i = 0; i < last_offset; i += nrpages, addr += nrpages) {
 		nrpages = bio_max_segs(last_offset - i);
@@ -3078,7 +3090,7 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 	 * #2, flush nat entries to nat page.
 	 */
 	if (enabled_nat_bits(sbi, cpc) ||
-		!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL))
+		!__has_cursum_space(sbi, journal, set->entry_cnt, NAT_JOURNAL))
 		to_journal = false;
 
 	if (to_journal) {
@@ -3101,7 +3113,7 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 		f2fs_bug_on(sbi, nat_get_blkaddr(ne) == NEW_ADDR);
 
 		if (to_journal) {
-			offset = f2fs_lookup_journal_in_cursum(journal,
+			offset = f2fs_lookup_journal_in_cursum(sbi, journal,
 							NAT_JOURNAL, nid, 1);
 			f2fs_bug_on(sbi, offset < 0);
 			raw_ne = &nat_in_journal(journal, offset);
@@ -3172,7 +3184,7 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 * into nat entry set.
 	 */
 	if (enabled_nat_bits(sbi, cpc) ||
-		!__has_cursum_space(journal,
+		!__has_cursum_space(sbi, journal,
 			nm_i->nat_cnt[DIRTY_NAT], NAT_JOURNAL))
 		remove_nats_in_journal(sbi);
 
@@ -3183,7 +3195,7 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		set_idx = setvec[found - 1]->set + 1;
 		for (idx = 0; idx < found; idx++)
 			__adjust_nat_entry_set(setvec[idx], &sets,
-						MAX_NAT_JENTRIES(journal));
+					MAX_NAT_JENTRIES(sbi, journal));
 	}
 
 	/* flush dirty nats in nat entry set */
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 9cb8dcf8d417..824ac9f0e6e4 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -52,14 +52,6 @@ enum {
 	IS_PREALLOC,		/* nat entry is preallocated */
 };
 
-/* For node type in __get_node_folio() */
-enum node_type {
-	NODE_TYPE_REGULAR,
-	NODE_TYPE_INODE,
-	NODE_TYPE_XATTR,
-	NODE_TYPE_NON_INODE,
-};
-
 /*
  * For node information
  */
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index c3415ebb9f50..a6bfc8e759cf 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -514,7 +514,7 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 		struct curseg_info *curseg = CURSEG_I(sbi, i);
 
 		if (curseg->segno == segno) {
-			sum = curseg->sum_blk->entries[blkoff];
+			sum = sum_entries(curseg->sum_blk)[blkoff];
 			goto got_it;
 		}
 	}
@@ -522,8 +522,8 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 	sum_folio = f2fs_get_sum_folio(sbi, segno);
 	if (IS_ERR(sum_folio))
 		return PTR_ERR(sum_folio);
-	sum_node = SUM_BLK_PAGE_ADDR(sum_folio, segno);
-	sum = sum_node->entries[blkoff];
+	sum_node = SUM_BLK_PAGE_ADDR(sbi, sum_folio, segno);
+	sum = sum_entries(sum_node)[blkoff];
 	f2fs_folio_put(sum_folio, true);
 got_it:
 	/* Use the locked dnode page and inode */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c26424f47686..90d0bac9d294 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2685,12 +2685,12 @@ int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra)
 			valid_sum_count += f2fs_curseg_valid_blocks(sbi, i);
 	}
 
-	sum_in_page = (PAGE_SIZE - 2 * SUM_JOURNAL_SIZE -
+	sum_in_page = (sbi->blocksize - 2 * sbi->sum_journal_size -
 			SUM_FOOTER_SIZE) / SUMMARY_SIZE;
 	if (valid_sum_count <= sum_in_page)
 		return 1;
 	else if ((valid_sum_count - sum_in_page) <=
-		(PAGE_SIZE - SUM_FOOTER_SIZE) / SUMMARY_SIZE)
+		(sbi->blocksize - SUM_FOOTER_SIZE) / SUMMARY_SIZE)
 		return 2;
 	return 3;
 }
@@ -2710,7 +2710,7 @@ void f2fs_update_meta_page(struct f2fs_sb_info *sbi,
 {
 	struct folio *folio;
 
-	if (SUMS_PER_BLOCK == 1)
+	if (!f2fs_sb_has_packed_ssa(sbi))
 		folio = f2fs_grab_meta_folio(sbi, blk_addr);
 	else
 		folio = f2fs_get_meta_folio_retry(sbi, blk_addr);
@@ -2728,7 +2728,7 @@ static void write_sum_page(struct f2fs_sb_info *sbi,
 {
 	struct folio *folio;
 
-	if (SUMS_PER_BLOCK == 1)
+	if (!f2fs_sb_has_packed_ssa(sbi))
 		return f2fs_update_meta_page(sbi, (void *)sum_blk,
 				GET_SUM_BLOCK(sbi, segno));
 
@@ -2736,7 +2736,8 @@ static void write_sum_page(struct f2fs_sb_info *sbi,
 	if (IS_ERR(folio))
 		return;
 
-	memcpy(SUM_BLK_PAGE_ADDR(folio, segno), sum_blk, sizeof(*sum_blk));
+	memcpy(SUM_BLK_PAGE_ADDR(sbi, folio, segno), sum_blk,
+			sbi->sum_blocksize);
 	folio_mark_dirty(folio);
 	f2fs_folio_put(folio, true);
 }
@@ -2755,11 +2756,11 @@ static void write_current_sum_page(struct f2fs_sb_info *sbi,
 	mutex_lock(&curseg->curseg_mutex);
 
 	down_read(&curseg->journal_rwsem);
-	memcpy(&dst->journal, curseg->journal, SUM_JOURNAL_SIZE);
+	memcpy(sum_journal(sbi, dst), curseg->journal, sbi->sum_journal_size);
 	up_read(&curseg->journal_rwsem);
 
-	memcpy(dst->entries, src->entries, SUM_ENTRY_SIZE);
-	memcpy(&dst->footer, &src->footer, SUM_FOOTER_SIZE);
+	memcpy(sum_entries(dst), sum_entries(src), sbi->sum_entry_size);
+	memcpy(sum_footer(sbi, dst), sum_footer(sbi, src), SUM_FOOTER_SIZE);
 
 	mutex_unlock(&curseg->curseg_mutex);
 
@@ -2932,7 +2933,7 @@ static void reset_curseg(struct f2fs_sb_info *sbi, int type, int modified)
 	curseg->next_blkoff = 0;
 	curseg->next_segno = NULL_SEGNO;
 
-	sum_footer = &(curseg->sum_blk->footer);
+	sum_footer = sum_footer(sbi, curseg->sum_blk);
 	memset(sum_footer, 0, sizeof(struct summary_footer));
 
 	sanity_check_seg_type(sbi, seg_type);
@@ -3078,11 +3079,11 @@ static int change_curseg(struct f2fs_sb_info *sbi, int type)
 	sum_folio = f2fs_get_sum_folio(sbi, new_segno);
 	if (IS_ERR(sum_folio)) {
 		/* GC won't be able to use stale summary pages by cp_error */
-		memset(curseg->sum_blk, 0, SUM_ENTRY_SIZE);
+		memset(curseg->sum_blk, 0, sbi->sum_entry_size);
 		return PTR_ERR(sum_folio);
 	}
-	sum_node = SUM_BLK_PAGE_ADDR(sum_folio, new_segno);
-	memcpy(curseg->sum_blk, sum_node, SUM_ENTRY_SIZE);
+	sum_node = SUM_BLK_PAGE_ADDR(sbi, sum_folio, new_segno);
+	memcpy(curseg->sum_blk, sum_node, sbi->sum_entry_size);
 	f2fs_folio_put(sum_folio, true);
 	return 0;
 }
@@ -3814,7 +3815,7 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct folio *folio,
 
 	f2fs_wait_discard_bio(sbi, *new_blkaddr);
 
-	curseg->sum_blk->entries[curseg->next_blkoff] = *sum;
+	sum_entries(curseg->sum_blk)[curseg->next_blkoff] = *sum;
 	if (curseg->alloc_type == SSR) {
 		curseg->next_blkoff = f2fs_find_next_ssr_block(sbi, curseg);
 	} else {
@@ -4183,7 +4184,7 @@ void f2fs_do_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	}
 
 	curseg->next_blkoff = GET_BLKOFF_FROM_SEG0(sbi, new_blkaddr);
-	curseg->sum_blk->entries[curseg->next_blkoff] = *sum;
+	sum_entries(curseg->sum_blk)[curseg->next_blkoff] = *sum;
 
 	if (!recover_curseg || recover_newaddr) {
 		if (!from_gc)
@@ -4303,12 +4304,12 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
 
 	/* Step 1: restore nat cache */
 	seg_i = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	memcpy(seg_i->journal, kaddr, SUM_JOURNAL_SIZE);
+	memcpy(seg_i->journal, kaddr, sbi->sum_journal_size);
 
 	/* Step 2: restore sit cache */
 	seg_i = CURSEG_I(sbi, CURSEG_COLD_DATA);
-	memcpy(seg_i->journal, kaddr + SUM_JOURNAL_SIZE, SUM_JOURNAL_SIZE);
-	offset = 2 * SUM_JOURNAL_SIZE;
+	memcpy(seg_i->journal, kaddr + sbi->sum_journal_size, sbi->sum_journal_size);
+	offset = 2 * sbi->sum_journal_size;
 
 	/* Step 3: restore summary entries */
 	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
@@ -4330,9 +4331,9 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
 			struct f2fs_summary *s;
 
 			s = (struct f2fs_summary *)(kaddr + offset);
-			seg_i->sum_blk->entries[j] = *s;
+			sum_entries(seg_i->sum_blk)[j] = *s;
 			offset += SUMMARY_SIZE;
-			if (offset + SUMMARY_SIZE <= PAGE_SIZE -
+			if (offset + SUMMARY_SIZE <= sbi->blocksize -
 						SUM_FOOTER_SIZE)
 				continue;
 
@@ -4388,7 +4389,7 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 
 	if (IS_NODESEG(type)) {
 		if (__exist_node_summaries(sbi)) {
-			struct f2fs_summary *ns = &sum->entries[0];
+			struct f2fs_summary *ns = sum_entries(sum);
 			int i;
 
 			for (i = 0; i < BLKS_PER_SEG(sbi); i++, ns++) {
@@ -4408,11 +4409,13 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 
 	/* update journal info */
 	down_write(&curseg->journal_rwsem);
-	memcpy(curseg->journal, &sum->journal, SUM_JOURNAL_SIZE);
+	memcpy(curseg->journal, sum_journal(sbi, sum), sbi->sum_journal_size);
 	up_write(&curseg->journal_rwsem);
 
-	memcpy(curseg->sum_blk->entries, sum->entries, SUM_ENTRY_SIZE);
-	memcpy(&curseg->sum_blk->footer, &sum->footer, SUM_FOOTER_SIZE);
+	memcpy(sum_entries(curseg->sum_blk), sum_entries(sum),
+			sbi->sum_entry_size);
+	memcpy(sum_footer(sbi, curseg->sum_blk), sum_footer(sbi, sum),
+			SUM_FOOTER_SIZE);
 	curseg->next_segno = segno;
 	reset_curseg(sbi, type, 0);
 	curseg->alloc_type = ckpt->alloc_type[type];
@@ -4456,8 +4459,8 @@ static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
 	}
 
 	/* sanity check for summary blocks */
-	if (nats_in_cursum(nat_j) > NAT_JOURNAL_ENTRIES ||
-			sits_in_cursum(sit_j) > SIT_JOURNAL_ENTRIES) {
+	if (nats_in_cursum(nat_j) > sbi->nat_journal_entries ||
+			sits_in_cursum(sit_j) > sbi->sit_journal_entries) {
 		f2fs_err(sbi, "invalid journal entries nats %u sits %u",
 			 nats_in_cursum(nat_j), sits_in_cursum(sit_j));
 		return -EINVAL;
@@ -4481,13 +4484,13 @@ static void write_compacted_summaries(struct f2fs_sb_info *sbi, block_t blkaddr)
 
 	/* Step 1: write nat cache */
 	seg_i = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	memcpy(kaddr, seg_i->journal, SUM_JOURNAL_SIZE);
-	written_size += SUM_JOURNAL_SIZE;
+	memcpy(kaddr, seg_i->journal, sbi->sum_journal_size);
+	written_size += sbi->sum_journal_size;
 
 	/* Step 2: write sit cache */
 	seg_i = CURSEG_I(sbi, CURSEG_COLD_DATA);
-	memcpy(kaddr + written_size, seg_i->journal, SUM_JOURNAL_SIZE);
-	written_size += SUM_JOURNAL_SIZE;
+	memcpy(kaddr + written_size, seg_i->journal, sbi->sum_journal_size);
+	written_size += sbi->sum_journal_size;
 
 	/* Step 3: write summary entries */
 	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
@@ -4500,10 +4503,10 @@ static void write_compacted_summaries(struct f2fs_sb_info *sbi, block_t blkaddr)
 				written_size = 0;
 			}
 			summary = (struct f2fs_summary *)(kaddr + written_size);
-			*summary = seg_i->sum_blk->entries[j];
+			*summary = sum_entries(seg_i->sum_blk)[j];
 			written_size += SUMMARY_SIZE;
 
-			if (written_size + SUMMARY_SIZE <= PAGE_SIZE -
+			if (written_size + SUMMARY_SIZE <= sbi->blocksize -
 							SUM_FOOTER_SIZE)
 				continue;
 
@@ -4545,8 +4548,9 @@ void f2fs_write_node_summaries(struct f2fs_sb_info *sbi, block_t start_blk)
 	write_normal_summaries(sbi, start_blk, CURSEG_HOT_NODE);
 }
 
-int f2fs_lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
-					unsigned int val, int alloc)
+int f2fs_lookup_journal_in_cursum(struct f2fs_sb_info *sbi,
+			struct f2fs_journal *journal, int type,
+			unsigned int val, int alloc)
 {
 	int i;
 
@@ -4555,13 +4559,13 @@ int f2fs_lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
 			if (le32_to_cpu(nid_in_journal(journal, i)) == val)
 				return i;
 		}
-		if (alloc && __has_cursum_space(journal, 1, NAT_JOURNAL))
+		if (alloc && __has_cursum_space(sbi, journal, 1, NAT_JOURNAL))
 			return update_nats_in_cursum(journal, 1);
 	} else if (type == SIT_JOURNAL) {
 		for (i = 0; i < sits_in_cursum(journal); i++)
 			if (le32_to_cpu(segno_in_journal(journal, i)) == val)
 				return i;
-		if (alloc && __has_cursum_space(journal, 1, SIT_JOURNAL))
+		if (alloc && __has_cursum_space(sbi, journal, 1, SIT_JOURNAL))
 			return update_sits_in_cursum(journal, 1);
 	}
 	return -1;
@@ -4709,8 +4713,8 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 * entries, remove all entries from journal and add and account
 	 * them in sit entry set.
 	 */
-	if (!__has_cursum_space(journal, sit_i->dirty_sentries, SIT_JOURNAL) ||
-								!to_journal)
+	if (!__has_cursum_space(sbi, journal,
+			sit_i->dirty_sentries, SIT_JOURNAL) || !to_journal)
 		remove_sits_in_journal(sbi);
 
 	/*
@@ -4727,7 +4731,8 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		unsigned int segno = start_segno;
 
 		if (to_journal &&
-			!__has_cursum_space(journal, ses->entry_cnt, SIT_JOURNAL))
+			!__has_cursum_space(sbi, journal, ses->entry_cnt,
+				SIT_JOURNAL))
 			to_journal = false;
 
 		if (to_journal) {
@@ -4755,7 +4760,7 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			}
 
 			if (to_journal) {
-				offset = f2fs_lookup_journal_in_cursum(journal,
+				offset = f2fs_lookup_journal_in_cursum(sbi, journal,
 							SIT_JOURNAL, segno, 1);
 				f2fs_bug_on(sbi, offset < 0);
 				segno_in_journal(journal, offset) =
@@ -4962,12 +4967,13 @@ static int build_curseg(struct f2fs_sb_info *sbi)
 
 	for (i = 0; i < NO_CHECK_TYPE; i++) {
 		mutex_init(&array[i].curseg_mutex);
-		array[i].sum_blk = f2fs_kzalloc(sbi, PAGE_SIZE, GFP_KERNEL);
+		array[i].sum_blk = f2fs_kzalloc(sbi, sbi->sum_blocksize,
+				GFP_KERNEL);
 		if (!array[i].sum_blk)
 			return -ENOMEM;
 		init_rwsem(&array[i].journal_rwsem);
 		array[i].journal = f2fs_kzalloc(sbi,
-				sizeof(struct f2fs_journal), GFP_KERNEL);
+				sbi->sum_journal_size, GFP_KERNEL);
 		if (!array[i].journal)
 			return -ENOMEM;
 		array[i].seg_type = log_type_to_seg_type(i);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 07dcbcbeb7c6..3094f2de37b6 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -90,12 +90,11 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 #define GET_ZONE_FROM_SEG(sbi, segno)				\
 	GET_ZONE_FROM_SEC(sbi, GET_SEC_FROM_SEG(sbi, segno))
 
-#define SUMS_PER_BLOCK (F2FS_BLKSIZE / F2FS_SUM_BLKSIZE)
 #define GET_SUM_BLOCK(sbi, segno)	\
-	(SM_I(sbi)->ssa_blkaddr + (segno / SUMS_PER_BLOCK))
-#define GET_SUM_BLKOFF(segno) (segno % SUMS_PER_BLOCK)
-#define SUM_BLK_PAGE_ADDR(folio, segno)	\
-	(folio_address(folio) + GET_SUM_BLKOFF(segno) * F2FS_SUM_BLKSIZE)
+	(SM_I(sbi)->ssa_blkaddr + (segno / (sbi)->sums_per_block))
+#define GET_SUM_BLKOFF(sbi, segno) (segno % (sbi)->sums_per_block)
+#define SUM_BLK_PAGE_ADDR(sbi, folio, segno)	\
+	(folio_address(folio) + GET_SUM_BLKOFF(sbi, segno) * (sbi)->sum_blocksize)
 
 #define GET_SUM_TYPE(footer) ((footer)->entry_type)
 #define SET_SUM_TYPE(footer, type) ((footer)->entry_type = (type))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c4c225e09dc4..6be6d7372bad 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2636,11 +2636,10 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 {
 	unsigned int nr_pages = get_pages(sbi, F2FS_DIRTY_DATA) / 16;
-	long long start, writeback, lock, sync_inode, end;
+	long long start, writeback, end;
 	int ret;
 
-	f2fs_info(sbi, "%s start, meta: %lld, node: %lld, data: %lld",
-					__func__,
+	f2fs_info(sbi, "f2fs_enable_checkpoint() starts, meta: %lld, node: %lld, data: %lld",
 					get_pages(sbi, F2FS_DIRTY_META),
 					get_pages(sbi, F2FS_DIRTY_NODES),
 					get_pages(sbi, F2FS_DIRTY_DATA));
@@ -2659,18 +2658,11 @@ static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	}
 	writeback = ktime_get();
 
-	f2fs_down_write(&sbi->cp_enable_rwsem);
-
-	lock = ktime_get();
-
-	if (get_pages(sbi, F2FS_DIRTY_DATA))
-		sync_inodes_sb(sbi->sb);
+	sync_inodes_sb(sbi->sb);
 
 	if (unlikely(get_pages(sbi, F2FS_DIRTY_DATA)))
-		f2fs_warn(sbi, "%s: has some unwritten data: %lld",
-			__func__, get_pages(sbi, F2FS_DIRTY_DATA));
-
-	sync_inode = ktime_get();
+		f2fs_warn(sbi, "checkpoint=enable has some unwritten data: %lld",
+					get_pages(sbi, F2FS_DIRTY_DATA));
 
 	f2fs_down_write(&sbi->gc_lock);
 	f2fs_dirty_to_prefree(sbi);
@@ -2679,13 +2671,6 @@ static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 	f2fs_up_write(&sbi->gc_lock);
 
-	f2fs_info(sbi, "%s sync_fs, meta: %lld, imeta: %lld, node: %lld, dents: %lld, qdata: %lld",
-					__func__,
-					get_pages(sbi, F2FS_DIRTY_META),
-					get_pages(sbi, F2FS_DIRTY_IMETA),
-					get_pages(sbi, F2FS_DIRTY_NODES),
-					get_pages(sbi, F2FS_DIRTY_DENTS),
-					get_pages(sbi, F2FS_DIRTY_QDATA));
 	ret = f2fs_sync_fs(sbi->sb, 1);
 	if (ret)
 		f2fs_err(sbi, "%s sync_fs failed, ret: %d", __func__, ret);
@@ -2693,17 +2678,11 @@ static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	/* Let's ensure there's no pending checkpoint anymore */
 	f2fs_flush_ckpt_thread(sbi);
 
-	f2fs_up_write(&sbi->cp_enable_rwsem);
-
 	end = ktime_get();
 
-	f2fs_info(sbi, "%s end, writeback:%llu, "
-				"lock:%llu, sync_inode:%llu, sync_fs:%llu",
-				__func__,
-				ktime_ms_delta(writeback, start),
-				ktime_ms_delta(lock, writeback),
-				ktime_ms_delta(sync_inode, lock),
-				ktime_ms_delta(end, sync_inode));
+	f2fs_info(sbi, "f2fs_enable_checkpoint() finishes, writeback:%llu, sync:%llu",
+					ktime_ms_delta(writeback, start),
+					ktime_ms_delta(end, writeback));
 	return ret;
 }
 
@@ -4080,20 +4059,6 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 	if (sanity_check_area_boundary(sbi, folio, index))
 		return -EFSCORRUPTED;
 
-	/*
-	 * Check for legacy summary layout on 16KB+ block devices.
-	 * Modern f2fs-tools packs multiple 4KB summary areas into one block,
-	 * whereas legacy versions used one block per summary, leading
-	 * to a much larger SSA.
-	 */
-	if (SUMS_PER_BLOCK > 1 &&
-		    !(__F2FS_HAS_FEATURE(raw_super, F2FS_FEATURE_PACKED_SSA))) {
-		f2fs_info(sbi, "Error: Device formatted with a legacy version. "
-			"Please reformat with a tool supporting the packed ssa "
-			"feature for block sizes larger than 4kb.");
-		return -EOPNOTSUPP;
-	}
-
 	return 0;
 }
 
@@ -4304,6 +4269,18 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	spin_lock_init(&sbi->gc_remaining_trials_lock);
 	atomic64_set(&sbi->current_atomic_write, 0);
 
+	sbi->sum_blocksize = f2fs_sb_has_packed_ssa(sbi) ?
+		4096 : sbi->blocksize;
+	sbi->sums_per_block = sbi->blocksize / sbi->sum_blocksize;
+	sbi->entries_in_sum = sbi->sum_blocksize / 8;
+	sbi->sum_entry_size = SUMMARY_SIZE * sbi->entries_in_sum;
+	sbi->sum_journal_size = sbi->sum_blocksize - SUM_FOOTER_SIZE -
+		sbi->sum_entry_size;
+	sbi->nat_journal_entries = (sbi->sum_journal_size - 2) /
+		sizeof(struct nat_journal_entry);
+	sbi->sit_journal_entries = (sbi->sum_journal_size - 2) /
+		sizeof(struct sit_journal_entry);
+
 	sbi->dir_level = DEF_DIR_LEVEL;
 	sbi->interval_time[CP_TIME] = DEF_CP_INTERVAL;
 	sbi->interval_time[REQ_TIME] = DEF_IDLE_INTERVAL;
@@ -4906,7 +4883,6 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	init_f2fs_rwsem(&sbi->node_change);
 	spin_lock_init(&sbi->stat_lock);
 	init_f2fs_rwsem(&sbi->cp_rwsem);
-	init_f2fs_rwsem(&sbi->cp_enable_rwsem);
 	init_f2fs_rwsem(&sbi->quota_sem);
 	init_waitqueue_head(&sbi->cp_wait);
 	spin_lock_init(&sbi->error_lock);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index c42f4f979d13..353bf47959f3 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -58,6 +58,7 @@ struct f2fs_attr {
 			 const char *buf, size_t len);
 	int struct_type;
 	int offset;
+	int size;
 	int id;
 };
 
@@ -344,11 +345,30 @@ static ssize_t main_blkaddr_show(struct f2fs_attr *a,
 			(unsigned long long)MAIN_BLKADDR(sbi));
 }
 
+static ssize_t __sbi_show_value(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf,
+		unsigned char *value)
+{
+	switch (a->size) {
+	case 1:
+		return sysfs_emit(buf, "%u\n", *(u8 *)value);
+	case 2:
+		return sysfs_emit(buf, "%u\n", *(u16 *)value);
+	case 4:
+		return sysfs_emit(buf, "%u\n", *(u32 *)value);
+	case 8:
+		return sysfs_emit(buf, "%llu\n", *(u64 *)value);
+	default:
+		f2fs_bug_on(sbi, 1);
+		return sysfs_emit(buf,
+				"show sysfs node value with wrong type\n");
+	}
+}
+
 static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 			struct f2fs_sb_info *sbi, char *buf)
 {
 	unsigned char *ptr = NULL;
-	unsigned int *ui;
 
 	ptr = __struct_ptr(sbi, a->struct_type);
 	if (!ptr)
@@ -428,9 +448,30 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 				atomic_read(&sbi->cp_call_count[BACKGROUND]));
 #endif
 
-	ui = (unsigned int *)(ptr + a->offset);
+	return __sbi_show_value(a, sbi, buf, ptr + a->offset);
+}
 
-	return sysfs_emit(buf, "%u\n", *ui);
+static void __sbi_store_value(struct f2fs_attr *a,
+			struct f2fs_sb_info *sbi,
+			unsigned char *ui, unsigned long value)
+{
+	switch (a->size) {
+	case 1:
+		*(u8 *)ui = value;
+		break;
+	case 2:
+		*(u16 *)ui = value;
+		break;
+	case 4:
+		*(u32 *)ui = value;
+		break;
+	case 8:
+		*(u64 *)ui = value;
+		break;
+	default:
+		f2fs_bug_on(sbi, 1);
+		f2fs_err(sbi, "store sysfs node value with wrong type");
+	}
 }
 
 static ssize_t __sbi_store(struct f2fs_attr *a,
@@ -749,7 +790,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
-	if (!strcmp(a->attr.name, "gc_pin_file_threshold")) {
+	if (!strcmp(a->attr.name, "gc_pin_file_thresh")) {
 		if (t > MAX_GC_FAILED_PINNED_FILES)
 			return -EINVAL;
 		sbi->gc_pin_file_threshold = t;
@@ -906,7 +947,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
-	*ui = (unsigned int)t;
+	__sbi_store_value(a, sbi, ptr + a->offset, t);
 
 	return count;
 }
@@ -1053,24 +1094,27 @@ static struct f2fs_attr f2fs_attr_sb_##_name = {		\
 	.id	= F2FS_FEATURE_##_feat,				\
 }
 
-#define F2FS_ATTR_OFFSET(_struct_type, _name, _mode, _show, _store, _offset) \
+#define F2FS_ATTR_OFFSET(_struct_type, _name, _mode, _show, _store, _offset, _size) \
 static struct f2fs_attr f2fs_attr_##_name = {			\
 	.attr = {.name = __stringify(_name), .mode = _mode },	\
 	.show	= _show,					\
 	.store	= _store,					\
 	.struct_type = _struct_type,				\
-	.offset = _offset					\
+	.offset = _offset,					\
+	.size = _size						\
 }
 
 #define F2FS_RO_ATTR(struct_type, struct_name, name, elname)	\
 	F2FS_ATTR_OFFSET(struct_type, name, 0444,		\
 		f2fs_sbi_show, NULL,				\
-		offsetof(struct struct_name, elname))
+		offsetof(struct struct_name, elname),		\
+		sizeof_field(struct struct_name, elname))
 
 #define F2FS_RW_ATTR(struct_type, struct_name, name, elname)	\
 	F2FS_ATTR_OFFSET(struct_type, name, 0644,		\
 		f2fs_sbi_show, f2fs_sbi_store,			\
-		offsetof(struct struct_name, elname))
+		offsetof(struct struct_name, elname),		\
+		sizeof_field(struct struct_name, elname))
 
 #define F2FS_GENERAL_RO_ATTR(name) \
 static struct f2fs_attr f2fs_attr_##name = __ATTR(name, 0444, name##_show, NULL)
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index a7880787cad3..dc41722fcc9d 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -17,7 +17,6 @@
 #define F2FS_LOG_SECTORS_PER_BLOCK	(PAGE_SHIFT - 9) /* log number for sector/blk */
 #define F2FS_BLKSIZE			PAGE_SIZE /* support only block == page */
 #define F2FS_BLKSIZE_BITS		PAGE_SHIFT /* bits for F2FS_BLKSIZE */
-#define F2FS_SUM_BLKSIZE		4096	/* only support 4096 byte sum block */
 #define F2FS_MAX_EXTENSION		64	/* # of extension entries */
 #define F2FS_EXTENSION_LEN		8	/* max size of extension */
 
@@ -442,10 +441,8 @@ struct f2fs_sit_block {
  * from node's page's beginning to get a data block address.
  * ex) data_blkaddr = (block_t)(nodepage_start_address + ofs_in_node)
  */
-#define ENTRIES_IN_SUM		(F2FS_SUM_BLKSIZE / 8)
 #define	SUMMARY_SIZE		(7)	/* sizeof(struct f2fs_summary) */
 #define	SUM_FOOTER_SIZE		(5)	/* sizeof(struct summary_footer) */
-#define SUM_ENTRY_SIZE		(SUMMARY_SIZE * ENTRIES_IN_SUM)
 
 /* a summary entry for a block in a segment */
 struct f2fs_summary {
@@ -468,22 +465,6 @@ struct summary_footer {
 	__le32 check_sum;		/* summary checksum */
 } __packed;
 
-#define SUM_JOURNAL_SIZE	(F2FS_SUM_BLKSIZE - SUM_FOOTER_SIZE -\
-				SUM_ENTRY_SIZE)
-#define NAT_JOURNAL_ENTRIES	((SUM_JOURNAL_SIZE - 2) /\
-				sizeof(struct nat_journal_entry))
-#define NAT_JOURNAL_RESERVED	((SUM_JOURNAL_SIZE - 2) %\
-				sizeof(struct nat_journal_entry))
-#define SIT_JOURNAL_ENTRIES	((SUM_JOURNAL_SIZE - 2) /\
-				sizeof(struct sit_journal_entry))
-#define SIT_JOURNAL_RESERVED	((SUM_JOURNAL_SIZE - 2) %\
-				sizeof(struct sit_journal_entry))
-
-/* Reserved area should make size of f2fs_extra_info equals to
- * that of nat_journal and sit_journal.
- */
-#define EXTRA_INFO_RESERVED	(SUM_JOURNAL_SIZE - 2 - 8)
-
 /*
  * frequently updated NAT/SIT entries can be stored in the spare area in
  * summary blocks
@@ -498,9 +479,16 @@ struct nat_journal_entry {
 	struct f2fs_nat_entry ne;
 } __packed;
 
+/*
+ * The nat_journal structure is a placeholder whose actual size varies depending
+ * on the use of packed_ssa. Therefore, it must always be accessed only through
+ * specific sets of macros and fields, and size calculations should use
+ * size-related macros instead of sizeof().
+ * Relevant macros: sbi->nat_journal_entries, nat_in_journal(),
+ * nid_in_journal(), MAX_NAT_JENTRIES().
+ */
 struct nat_journal {
-	struct nat_journal_entry entries[NAT_JOURNAL_ENTRIES];
-	__u8 reserved[NAT_JOURNAL_RESERVED];
+	struct nat_journal_entry entries[0];
 } __packed;
 
 struct sit_journal_entry {
@@ -508,14 +496,21 @@ struct sit_journal_entry {
 	struct f2fs_sit_entry se;
 } __packed;
 
+/*
+ * The sit_journal structure is a placeholder whose actual size varies depending
+ * on the use of packed_ssa. Therefore, it must always be accessed only through
+ * specific sets of macros and fields, and size calculations should use
+ * size-related macros instead of sizeof().
+ * Relevant macros: sbi->sit_journal_entries, sit_in_journal(),
+ * segno_in_journal(), MAX_SIT_JENTRIES().
+ */
 struct sit_journal {
-	struct sit_journal_entry entries[SIT_JOURNAL_ENTRIES];
-	__u8 reserved[SIT_JOURNAL_RESERVED];
+	struct sit_journal_entry entries[0];
 } __packed;
 
 struct f2fs_extra_info {
 	__le64 kbytes_written;
-	__u8 reserved[EXTRA_INFO_RESERVED];
+	__u8 reserved[];
 } __packed;
 
 struct f2fs_journal {
@@ -531,11 +526,33 @@ struct f2fs_journal {
 	};
 } __packed;
 
-/* Block-sized summary block structure */
+/*
+ * Block-sized summary block structure
+ *
+ * The f2fs_summary_block structure is a placeholder whose actual size varies
+ * depending on the use of packed_ssa. Therefore, it must always be accessed
+ * only through specific sets of macros and fields, and size calculations should
+ * use size-related macros instead of sizeof().
+ * Relevant macros: sbi->sum_blocksize, sbi->entries_in_sum,
+ * sbi->sum_entry_size, sum_entries(), sum_journal(), sum_footer().
+ *
+ * Summary Block Layout
+ *
+ * +-----------------------+ <--- Block Start
+ * | struct f2fs_summary   |
+ * | entries[0]            |
+ * | ...                   |
+ * | entries[N-1]          |
+ * +-----------------------+
+ * | struct f2fs_journal   |
+ * +-----------------------+
+ * | struct summary_footer |
+ * +-----------------------+ <--- Block End
+ */
 struct f2fs_summary_block {
-	struct f2fs_summary entries[ENTRIES_IN_SUM];
-	struct f2fs_journal journal;
-	struct summary_footer footer;
+	struct f2fs_summary entries[0];
+	// struct f2fs_journal journal;
+	// struct summary_footer footer;
 } __packed;
 
 /*

