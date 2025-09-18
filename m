Return-Path: <stable+bounces-177754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7164B4401D
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 17:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF04A432DF
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 15:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1653164AA;
	Thu,  4 Sep 2025 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EiiZGS+6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A235930BF62;
	Thu,  4 Sep 2025 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998663; cv=none; b=IBdDmxOHli/lW0RPGZixj0Cwbj9aSobQkJh8UCbPMDXoahb93YnYyACBAbQjP9NlrVZnTxi4/mxElfpiVy6DPklVkEt2qJw25J5O3eMLEedzXDsypX4mDtpaU2iP3qasgS3jlbEWVVsH4+Za9p6Wm7sps+ZfWdTqFGnpp8jpPxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998663; c=relaxed/simple;
	bh=wtdYW7iZNYv/cDvVg//d2XbvFpmO8M6Ep9bLdIRPL5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbZygwfEm7HneTmvOwWL9QBfMCWWkH4tU7HfM+AHqRuK1VVxcZJS7kyNE6MiR1p8IfPLpRcltuubeXD6iNkmMPfAkSl+cb0NrlR6JHuFKS1T3z0wqtWfesi41pXZ+WE9rCxG2VMhSLjFS5okmZnL8xu19yVWx0Ue7ddA80hTHjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EiiZGS+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E528C4CEF6;
	Thu,  4 Sep 2025 15:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756998663;
	bh=wtdYW7iZNYv/cDvVg//d2XbvFpmO8M6Ep9bLdIRPL5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EiiZGS+63taa+8skl983wMc02bM4g8z0J7OkHBrh+O8UtHOfE2xQtvnewQykoUA3v
	 z5UC7RZ6F+LqkGgplSkwSyGfvx4PtKh2/31fygVFaa7ArgujEkFcu4sZ/6KINNHeID
	 Plm0cCxcoc3QXz7oxtzQhpLJjJGcSzNAlhmoZ1+I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.45
Date: Thu,  4 Sep 2025 17:10:50 +0200
Message-ID: <2025090450-drinkable-wad-3bdc@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090450-fabulous-sinner-9790@gregkh>
References: <2025090450-fabulous-sinner-9790@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml b/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml
index e153f8d26e7a..2735c78b0b67 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml
@@ -60,7 +60,6 @@ properties:
           - const: bus
           - const: core
           - const: vsync
-          - const: lut
           - const: tbu
           - const: tbu_rt
         # MSM8996 has additional iommu clock
diff --git a/Makefile b/Makefile
index 208a50953301..cc59990e3796 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 44
+SUBLEVEL = 45
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/mips/boot/dts/lantiq/danube_easy50712.dts b/arch/mips/boot/dts/lantiq/danube_easy50712.dts
index 1ce20b7d05cb..c4d7aa5753b0 100644
--- a/arch/mips/boot/dts/lantiq/danube_easy50712.dts
+++ b/arch/mips/boot/dts/lantiq/danube_easy50712.dts
@@ -82,13 +82,16 @@ conf_out {
 			};
 		};
 
-		etop@e180000 {
+		ethernet@e180000 {
 			compatible = "lantiq,etop-xway";
 			reg = <0xe180000 0x40000>;
 			interrupt-parent = <&icu0>;
 			interrupts = <73 78>;
+			interrupt-names = "tx", "rx";
 			phy-mode = "rmii";
 			mac-address = [ 00 11 22 33 44 55 ];
+			lantiq,rx-burst-length = <4>;
+			lantiq,tx-burst-length = <4>;
 		};
 
 		stp0: stp@e100bb0 {
diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 5a75283d17f1..6031a0272d87 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -497,7 +497,7 @@ void __init ltq_soc_init(void)
 		ifccr = CGU_IFCCR_VR9;
 		pcicr = CGU_PCICR_VR9;
 	} else {
-		clkdev_add_pmu("1e180000.etop", NULL, 1, 0, PMU_PPE);
+		clkdev_add_pmu("1e180000.ethernet", NULL, 1, 0, PMU_PPE);
 	}
 
 	if (!of_machine_is_compatible("lantiq,ase"))
@@ -531,9 +531,9 @@ void __init ltq_soc_init(void)
 						CLOCK_133M, CLOCK_133M);
 		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
 		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
-		clkdev_add_pmu("1e180000.etop", "ppe", 1, 0, PMU_PPE);
-		clkdev_add_cgu("1e180000.etop", "ephycgu", CGU_EPHY);
-		clkdev_add_pmu("1e180000.etop", "ephy", 1, 0, PMU_EPHY);
+		clkdev_add_pmu("1e180000.ethernet", "ppe", 1, 0, PMU_PPE);
+		clkdev_add_cgu("1e180000.ethernet", "ephycgu", CGU_EPHY);
+		clkdev_add_pmu("1e180000.ethernet", "ephy", 1, 0, PMU_EPHY);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_ASE_SDIO);
 		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
 	} else if (of_machine_is_compatible("lantiq,grx390")) {
@@ -592,7 +592,7 @@ void __init ltq_soc_init(void)
 		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0 | PMU_AHBM);
 		clkdev_add_pmu("1f203034.usb2-phy", "phy", 1, 0, PMU_USB1_P);
 		clkdev_add_pmu("1e106000.usb", "otg", 1, 0, PMU_USB1 | PMU_AHBM);
-		clkdev_add_pmu("1e180000.etop", "switch", 1, 0, PMU_SWITCH);
+		clkdev_add_pmu("1e180000.ethernet", "switch", 1, 0, PMU_SWITCH);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
 		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
 		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 5b3c093611ba..7209d00a9c25 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -632,19 +632,19 @@ static void __init kvm_check_ins(u32 *inst, u32 features)
 #endif
 	}
 
-	switch (inst_no_rt & ~KVM_MASK_RB) {
 #ifdef CONFIG_PPC_BOOK3S_32
+	switch (inst_no_rt & ~KVM_MASK_RB) {
 	case KVM_INST_MTSRIN:
 		if (features & KVM_MAGIC_FEAT_SR) {
 			u32 inst_rb = _inst & KVM_MASK_RB;
 			kvm_patch_ins_mtsrin(inst, inst_rt, inst_rb);
 		}
 		break;
-#endif
 	}
+#endif
 
-	switch (_inst) {
 #ifdef CONFIG_BOOKE
+	switch (_inst) {
 	case KVM_INST_WRTEEI_0:
 		kvm_patch_ins_wrteei_0(inst);
 		break;
@@ -652,8 +652,8 @@ static void __init kvm_check_ins(u32 *inst, u32 features)
 	case KVM_INST_WRTEEI_1:
 		kvm_patch_ins_wrtee(inst, 0, 1);
 		break;
-#endif
 	}
+#endif
 }
 
 extern u32 kvm_template_start[];
diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index d92d1348045c..8454c1c3655a 100644
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -181,6 +181,8 @@ int kvm_riscv_vcpu_set_reg_vector(struct kvm_vcpu *vcpu,
 		struct kvm_cpu_context *cntx = &vcpu->arch.guest_context;
 		unsigned long reg_val;
 
+		if (reg_size != sizeof(reg_val))
+			return -EINVAL;
 		if (copy_from_user(&reg_val, uaddr, reg_size))
 			return -EFAULT;
 		if (reg_val != cntx->vector.vlenb)
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 765b4646648f..910accfeb785 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -159,8 +159,28 @@ static int cmp_id(const void *key, const void *elem)
 		return 1;
 }
 
+static u32 cpuid_to_ucode_rev(unsigned int val)
+{
+	union zen_patch_rev p = {};
+	union cpuid_1_eax c;
+
+	c.full = val;
+
+	p.stepping  = c.stepping;
+	p.model     = c.model;
+	p.ext_model = c.ext_model;
+	p.ext_fam   = c.ext_fam;
+
+	return p.ucode_rev;
+}
+
 static bool need_sha_check(u32 cur_rev)
 {
+	if (!cur_rev) {
+		cur_rev = cpuid_to_ucode_rev(bsp_cpuid_1_eax);
+		pr_info_once("No current revision, generating the lowest one: 0x%x\n", cur_rev);
+	}
+
 	switch (cur_rev >> 8) {
 	case 0x80012: return cur_rev <= 0x800126f; break;
 	case 0x80082: return cur_rev <= 0x800820f; break;
@@ -741,8 +761,6 @@ static struct ucode_patch *cache_find_patch(struct ucode_cpu_info *uci, u16 equi
 	n.equiv_cpu = equiv_cpu;
 	n.patch_id  = uci->cpu_sig.rev;
 
-	WARN_ON_ONCE(!n.patch_id);
-
 	list_for_each_entry(p, &microcode_cache, plist)
 		if (patch_cpus_equivalent(p, &n, false))
 			return p;
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index 7d476fa697ca..0fab130a8249 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -80,20 +80,25 @@ static bool parse_8000_001e(struct topo_scan *tscan, bool has_topoext)
 
 	cpuid_leaf(0x8000001e, &leaf);
 
-	tscan->c->topo.initial_apicid = leaf.ext_apic_id;
-
 	/*
-	 * If leaf 0xb is available, then the domain shifts are set
-	 * already and nothing to do here. Only valid for family >= 0x17.
+	 * If leaf 0xb/0x26 is available, then the APIC ID and the domain
+	 * shifts are set already.
 	 */
-	if (!has_topoext && tscan->c->x86 >= 0x17) {
+	if (!has_topoext) {
+		tscan->c->topo.initial_apicid = leaf.ext_apic_id;
+
 		/*
-		 * Leaf 0x80000008 set the CORE domain shift already.
-		 * Update the SMT domain, but do not propagate it.
+		 * Leaf 0x8000008 sets the CORE domain shift but not the
+		 * SMT domain shift. On CPUs with family >= 0x17, there
+		 * might be hyperthreads.
 		 */
-		unsigned int nthreads = leaf.core_nthreads + 1;
+		if (tscan->c->x86 >= 0x17) {
+			/* Update the SMT domain, but do not propagate it. */
+			unsigned int nthreads = leaf.core_nthreads + 1;
 
-		topology_update_dom(tscan, TOPO_SMT_DOMAIN, get_count_order(nthreads), nthreads);
+			topology_update_dom(tscan, TOPO_SMT_DOMAIN,
+					    get_count_order(nthreads), nthreads);
+		}
 	}
 
 	store_node(tscan, leaf.nnodes_per_socket + 1, leaf.node_id);
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 1a8148dec4af..33a6cb1ac603 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -860,6 +860,8 @@ static int __pv_send_ipi(unsigned long *ipi_bitmap, struct kvm_apic_map *map,
 	if (min > map->max_apic_id)
 		return 0;
 
+	min = array_index_nospec(min, map->max_apic_id + 1);
+
 	for_each_set_bit(i, ipi_bitmap,
 		min((u32)BITS_PER_LONG, (map->max_apic_id - min + 1))) {
 		if (map->phys_map[min + i]) {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index dbd295ef3eba..17ec4c4a3d92 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9969,8 +9969,11 @@ static void kvm_sched_yield(struct kvm_vcpu *vcpu, unsigned long dest_id)
 	rcu_read_lock();
 	map = rcu_dereference(vcpu->kvm->arch.apic_map);
 
-	if (likely(map) && dest_id <= map->max_apic_id && map->phys_map[dest_id])
-		target = map->phys_map[dest_id]->vcpu;
+	if (likely(map) && dest_id <= map->max_apic_id) {
+		dest_id = array_index_nospec(dest_id, map->max_apic_id + 1);
+		if (map->phys_map[dest_id])
+			target = map->phys_map[dest_id]->vcpu;
+	}
 
 	rcu_read_unlock();
 
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 24c80078ca44..5915fb98ffdc 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1281,14 +1281,14 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
 	struct block_device *bdev;
 	unsigned long flags;
 	struct bio *bio;
+	bool prepared;
 
 	/*
 	 * Submit the next plugged BIO. If we do not have any, clear
 	 * the plugged flag.
 	 */
-	spin_lock_irqsave(&zwplug->lock, flags);
-
 again:
+	spin_lock_irqsave(&zwplug->lock, flags);
 	bio = bio_list_pop(&zwplug->bio_list);
 	if (!bio) {
 		zwplug->flags &= ~BLK_ZONE_WPLUG_PLUGGED;
@@ -1296,13 +1296,14 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
 		goto put_zwplug;
 	}
 
-	if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
+	prepared = blk_zone_wplug_prepare_bio(zwplug, bio);
+	spin_unlock_irqrestore(&zwplug->lock, flags);
+
+	if (!prepared) {
 		blk_zone_wplug_bio_io_error(zwplug, bio);
 		goto again;
 	}
 
-	spin_unlock_irqrestore(&zwplug->lock, flags);
-
 	bdev = bio->bi_bdev;
 
 	/*
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index e614e4bef9ea..a813bc97cf42 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2329,6 +2329,12 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
 		}
 	},
+	{
+		// TUXEDO InfinityBook Pro AMD Gen9
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GXxHRXx"),
+		},
+	},
 	{ },
 };
 
diff --git a/drivers/atm/atmtcp.c b/drivers/atm/atmtcp.c
index eeae160c898d..fa3c76a2b49d 100644
--- a/drivers/atm/atmtcp.c
+++ b/drivers/atm/atmtcp.c
@@ -279,6 +279,19 @@ static struct atm_vcc *find_vcc(struct atm_dev *dev, short vpi, int vci)
         return NULL;
 }
 
+static int atmtcp_c_pre_send(struct atm_vcc *vcc, struct sk_buff *skb)
+{
+	struct atmtcp_hdr *hdr;
+
+	if (skb->len < sizeof(struct atmtcp_hdr))
+		return -EINVAL;
+
+	hdr = (struct atmtcp_hdr *)skb->data;
+	if (hdr->length == ATMTCP_HDR_MAGIC)
+		return -EINVAL;
+
+	return 0;
+}
 
 static int atmtcp_c_send(struct atm_vcc *vcc,struct sk_buff *skb)
 {
@@ -288,9 +301,6 @@ static int atmtcp_c_send(struct atm_vcc *vcc,struct sk_buff *skb)
 	struct sk_buff *new_skb;
 	int result = 0;
 
-	if (skb->len < sizeof(struct atmtcp_hdr))
-		goto done;
-
 	dev = vcc->dev_data;
 	hdr = (struct atmtcp_hdr *) skb->data;
 	if (hdr->length == ATMTCP_HDR_MAGIC) {
@@ -347,6 +357,7 @@ static const struct atmdev_ops atmtcp_v_dev_ops = {
 
 static const struct atmdev_ops atmtcp_c_dev_ops = {
 	.close		= atmtcp_c_close,
+	.pre_send	= atmtcp_c_pre_send,
 	.send		= atmtcp_c_send
 };
 
diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
index f741ca279052..e15d11ed165e 100644
--- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
+++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
@@ -143,6 +143,10 @@ static efi_status_t mm_communicate(u8 *comm_buf, size_t payload_size)
 	return var_hdr->ret_status;
 }
 
+#define COMM_BUF_SIZE(__payload_size)	(MM_COMMUNICATE_HEADER_SIZE + \
+					 MM_VARIABLE_COMMUNICATE_SIZE + \
+					 (__payload_size))
+
 /**
  * setup_mm_hdr() -	Allocate a buffer for StandAloneMM and initialize the
  *			header data.
@@ -173,9 +177,8 @@ static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func,
 		return NULL;
 	}
 
-	comm_buf = kzalloc(MM_COMMUNICATE_HEADER_SIZE +
-				   MM_VARIABLE_COMMUNICATE_SIZE + payload_size,
-			   GFP_KERNEL);
+	comm_buf = alloc_pages_exact(COMM_BUF_SIZE(payload_size),
+				     GFP_KERNEL | __GFP_ZERO);
 	if (!comm_buf) {
 		*ret = EFI_OUT_OF_RESOURCES;
 		return NULL;
@@ -239,7 +242,7 @@ static efi_status_t get_max_payload(size_t *size)
 	 */
 	*size -= 2;
 out:
-	kfree(comm_buf);
+	free_pages_exact(comm_buf, COMM_BUF_SIZE(payload_size));
 	return ret;
 }
 
@@ -282,7 +285,7 @@ static efi_status_t get_property_int(u16 *name, size_t name_size,
 	memcpy(var_property, &smm_property->property, sizeof(*var_property));
 
 out:
-	kfree(comm_buf);
+	free_pages_exact(comm_buf, COMM_BUF_SIZE(payload_size));
 	return ret;
 }
 
@@ -347,7 +350,7 @@ static efi_status_t tee_get_variable(u16 *name, efi_guid_t *vendor,
 	memcpy(data, (u8 *)var_acc->name + var_acc->name_size,
 	       var_acc->data_size);
 out:
-	kfree(comm_buf);
+	free_pages_exact(comm_buf, COMM_BUF_SIZE(payload_size));
 	return ret;
 }
 
@@ -404,7 +407,7 @@ static efi_status_t tee_get_next_variable(unsigned long *name_size,
 	memcpy(name, var_getnext->name, var_getnext->name_size);
 
 out:
-	kfree(comm_buf);
+	free_pages_exact(comm_buf, COMM_BUF_SIZE(payload_size));
 	return ret;
 }
 
@@ -467,7 +470,7 @@ static efi_status_t tee_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 	ret = mm_communicate(comm_buf, payload_size);
 	dev_dbg(pvt_data.dev, "Set Variable %s %d %lx\n", __FILE__, __LINE__, ret);
 out:
-	kfree(comm_buf);
+	free_pages_exact(comm_buf, COMM_BUF_SIZE(payload_size));
 	return ret;
 }
 
@@ -507,7 +510,7 @@ static efi_status_t tee_query_variable_info(u32 attributes,
 	*max_variable_size = mm_query_info->max_variable_size;
 
 out:
-	kfree(comm_buf);
+	free_pages_exact(comm_buf, COMM_BUF_SIZE(payload_size));
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index dfb6cfd83760..02138aa55793 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -88,8 +88,8 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	r = amdgpu_vm_bo_map(adev, *bo_va, csa_addr, 0, size,
-			     AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE |
-			     AMDGPU_VM_PAGE_EXECUTABLE);
+			     AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
+			     AMDGPU_PTE_EXECUTABLE);
 
 	if (r) {
 		DRM_ERROR("failed to do bo_map on static CSA, err=%d\n", r);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index c4fdd82a0042..57b5d90ca89b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3668,14 +3668,16 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		effective_mode &= ~S_IWUSR;
 
 	/* not implemented yet for APUs other than GC 10.3.1 (vangogh) and 9.4.3 */
-	if (((adev->family == AMDGPU_FAMILY_SI) ||
-	     ((adev->flags & AMD_IS_APU) && (gc_ver != IP_VERSION(10, 3, 1)) &&
-	      (gc_ver != IP_VERSION(9, 4, 3) && gc_ver != IP_VERSION(9, 4, 4)))) &&
-	    (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
-	     attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr ||
-	     attr == &sensor_dev_attr_power1_cap.dev_attr.attr ||
-	     attr == &sensor_dev_attr_power1_cap_default.dev_attr.attr))
-		return 0;
+	if (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
+	    attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr ||
+	    attr == &sensor_dev_attr_power1_cap.dev_attr.attr ||
+	    attr == &sensor_dev_attr_power1_cap_default.dev_attr.attr) {
+		if (adev->family == AMDGPU_FAMILY_SI ||
+		    ((adev->flags & AMD_IS_APU) && gc_ver != IP_VERSION(10, 3, 1) &&
+		     (gc_ver != IP_VERSION(9, 4, 3) && gc_ver != IP_VERSION(9, 4, 4))) ||
+		    (amdgpu_sriov_vf(adev) && gc_ver == IP_VERSION(11, 0, 3)))
+			return 0;
+	}
 
 	/* not implemented yet for APUs having < GC 9.3.0 (Renoir) */
 	if (((adev->family == AMDGPU_FAMILY_SI) ||
diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index bb61bbdcce5b..9fa13da513d2 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -664,7 +664,7 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 	 * monitor doesn't power down exactly after the throw away read.
 	 */
 	if (!aux->is_remote) {
-		ret = drm_dp_dpcd_probe(aux, DP_LANE0_1_STATUS);
+		ret = drm_dp_dpcd_probe(aux, DP_DPCD_REV);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 42e62b040961..2508e9e9431d 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -381,19 +381,19 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 
 		of_id = of_match_node(mtk_drm_of_ids, node);
 		if (!of_id)
-			continue;
+			goto next_put_node;
 
 		pdev = of_find_device_by_node(node);
 		if (!pdev)
-			continue;
+			goto next_put_node;
 
 		drm_dev = device_find_child(&pdev->dev, NULL, mtk_drm_match);
 		if (!drm_dev)
-			continue;
+			goto next_put_device_pdev_dev;
 
 		temp_drm_priv = dev_get_drvdata(drm_dev);
 		if (!temp_drm_priv)
-			continue;
+			goto next_put_device_drm_dev;
 
 		if (temp_drm_priv->data->main_len)
 			all_drm_priv[CRTC_MAIN] = temp_drm_priv;
@@ -405,10 +405,17 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 		if (temp_drm_priv->mtk_drm_bound)
 			cnt++;
 
-		if (cnt == MAX_CRTC) {
-			of_node_put(node);
+next_put_device_drm_dev:
+		put_device(drm_dev);
+
+next_put_device_pdev_dev:
+		put_device(&pdev->dev);
+
+next_put_node:
+		of_node_put(node);
+
+		if (cnt == MAX_CRTC)
 			break;
-		}
 	}
 
 	if (drm_priv->data->mmsys_dev_num == cnt) {
diff --git a/drivers/gpu/drm/mediatek/mtk_plane.c b/drivers/gpu/drm/mediatek/mtk_plane.c
index 74c2704efb66..6e20f7037b5b 100644
--- a/drivers/gpu/drm/mediatek/mtk_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_plane.c
@@ -292,7 +292,8 @@ static void mtk_plane_atomic_disable(struct drm_plane *plane,
 	wmb(); /* Make sure the above parameter is set before update */
 	mtk_plane_state->pending.dirty = true;
 
-	mtk_crtc_plane_disable(old_state->crtc, plane);
+	if (old_state && old_state->crtc)
+		mtk_crtc_plane_disable(old_state->crtc, plane);
 }
 
 static void mtk_plane_atomic_update(struct drm_plane *plane,
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 4b3a8ee8e278..3eee6517541e 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -879,12 +879,8 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 
 	if (ret == 0 && args->flags & MSM_SUBMIT_FENCE_FD_OUT) {
 		sync_file = sync_file_create(submit->user_fence);
-		if (!sync_file) {
+		if (!sync_file)
 			ret = -ENOMEM;
-		} else {
-			fd_install(out_fence_fd, sync_file->file);
-			args->fence_fd = out_fence_fd;
-		}
 	}
 
 	if (ret)
@@ -912,10 +908,14 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 out_unlock:
 	mutex_unlock(&queue->lock);
 out_post_unlock:
-	if (ret && (out_fence_fd >= 0)) {
-		put_unused_fd(out_fence_fd);
+	if (ret) {
+		if (out_fence_fd >= 0)
+			put_unused_fd(out_fence_fd);
 		if (sync_file)
 			fput(sync_file->file);
+	} else if (sync_file) {
+		fd_install(out_fence_fd, sync_file->file);
+		args->fence_fd = out_fence_fd;
 	}
 
 	if (!IS_ERR_OR_NULL(submit)) {
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index 6749f0fbca96..52464a1346f8 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -241,6 +241,12 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 	if (ret)
 		return ret;
 
+	ret = msm_disp_snapshot_init(ddev);
+	if (ret) {
+		DRM_DEV_ERROR(dev, "msm_disp_snapshot_init failed ret = %d\n", ret);
+		return ret;
+	}
+
 	ret = priv->kms_init(ddev);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to load kms\n");
@@ -293,10 +299,6 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 		goto err_msm_uninit;
 	}
 
-	ret = msm_disp_snapshot_init(ddev);
-	if (ret)
-		DRM_DEV_ERROR(dev, "msm_disp_snapshot_init failed ret = %d\n", ret);
-
 	drm_mode_config_reset(ddev);
 
 	return 0;
diff --git a/drivers/gpu/drm/msm/registers/display/dsi.xml b/drivers/gpu/drm/msm/registers/display/dsi.xml
index 501ffc585a9f..c7a7b633d747 100644
--- a/drivers/gpu/drm/msm/registers/display/dsi.xml
+++ b/drivers/gpu/drm/msm/registers/display/dsi.xml
@@ -159,28 +159,28 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 		<bitfield name="RGB_SWAP" low="12" high="14" type="dsi_rgb_swap"/>
 	</reg32>
 	<reg32 offset="0x00020" name="ACTIVE_H">
-		<bitfield name="START" low="0" high="11" type="uint"/>
-		<bitfield name="END" low="16" high="27" type="uint"/>
+		<bitfield name="START" low="0" high="15" type="uint"/>
+		<bitfield name="END" low="16" high="31" type="uint"/>
 	</reg32>
 	<reg32 offset="0x00024" name="ACTIVE_V">
-		<bitfield name="START" low="0" high="11" type="uint"/>
-		<bitfield name="END" low="16" high="27" type="uint"/>
+		<bitfield name="START" low="0" high="15" type="uint"/>
+		<bitfield name="END" low="16" high="31" type="uint"/>
 	</reg32>
 	<reg32 offset="0x00028" name="TOTAL">
-		<bitfield name="H_TOTAL" low="0" high="11" type="uint"/>
-		<bitfield name="V_TOTAL" low="16" high="27" type="uint"/>
+		<bitfield name="H_TOTAL" low="0" high="15" type="uint"/>
+		<bitfield name="V_TOTAL" low="16" high="31" type="uint"/>
 	</reg32>
 	<reg32 offset="0x0002c" name="ACTIVE_HSYNC">
-		<bitfield name="START" low="0" high="11" type="uint"/>
-		<bitfield name="END" low="16" high="27" type="uint"/>
+		<bitfield name="START" low="0" high="15" type="uint"/>
+		<bitfield name="END" low="16" high="31" type="uint"/>
 	</reg32>
 	<reg32 offset="0x00030" name="ACTIVE_VSYNC_HPOS">
-		<bitfield name="START" low="0" high="11" type="uint"/>
-		<bitfield name="END" low="16" high="27" type="uint"/>
+		<bitfield name="START" low="0" high="15" type="uint"/>
+		<bitfield name="END" low="16" high="31" type="uint"/>
 	</reg32>
 	<reg32 offset="0x00034" name="ACTIVE_VSYNC_VPOS">
-		<bitfield name="START" low="0" high="11" type="uint"/>
-		<bitfield name="END" low="16" high="27" type="uint"/>
+		<bitfield name="START" low="0" high="15" type="uint"/>
+		<bitfield name="END" low="16" high="31" type="uint"/>
 	</reg32>
 
 	<reg32 offset="0x00038" name="CMD_DMA_CTRL">
@@ -209,8 +209,8 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 		<bitfield name="WORD_COUNT" low="16" high="31" type="uint"/>
 	</reg32>
 	<reg32 offset="0x00058" name="CMD_MDP_STREAM0_TOTAL">
-		<bitfield name="H_TOTAL" low="0" high="11" type="uint"/>
-		<bitfield name="V_TOTAL" low="16" high="27" type="uint"/>
+		<bitfield name="H_TOTAL" low="0" high="15" type="uint"/>
+		<bitfield name="V_TOTAL" low="16" high="31" type="uint"/>
 	</reg32>
 	<reg32 offset="0x0005c" name="CMD_MDP_STREAM1_CTRL">
 		<bitfield name="DATA_TYPE" low="0" high="5" type="uint"/>
diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
index 7a2cceaee6e9..1199dfc1194c 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
@@ -663,6 +663,10 @@ static bool nv50_plane_format_mod_supported(struct drm_plane *plane,
 	struct nouveau_drm *drm = nouveau_drm(plane->dev);
 	uint8_t i;
 
+	/* All chipsets can display all formats in linear layout */
+	if (modifier == DRM_FORMAT_MOD_LINEAR)
+		return true;
+
 	if (drm->client.device.info.chipset < 0xc0) {
 		const struct drm_format_info *info = drm_format_info(format);
 		const uint8_t kind = (modifier >> 12) & 0xff;
diff --git a/drivers/gpu/drm/nouveau/nvkm/falcon/gm200.c b/drivers/gpu/drm/nouveau/nvkm/falcon/gm200.c
index b7da3ab44c27..7c43397c19e6 100644
--- a/drivers/gpu/drm/nouveau/nvkm/falcon/gm200.c
+++ b/drivers/gpu/drm/nouveau/nvkm/falcon/gm200.c
@@ -103,7 +103,7 @@ gm200_flcn_pio_imem_wr_init(struct nvkm_falcon *falcon, u8 port, bool sec, u32 i
 static void
 gm200_flcn_pio_imem_wr(struct nvkm_falcon *falcon, u8 port, const u8 *img, int len, u16 tag)
 {
-	nvkm_falcon_wr32(falcon, 0x188 + (port * 0x10), tag++);
+	nvkm_falcon_wr32(falcon, 0x188 + (port * 0x10), tag);
 	while (len >= 4) {
 		nvkm_falcon_wr32(falcon, 0x184 + (port * 0x10), *(u32 *)img);
 		img += 4;
@@ -249,9 +249,11 @@ int
 gm200_flcn_fw_load(struct nvkm_falcon_fw *fw)
 {
 	struct nvkm_falcon *falcon = fw->falcon;
-	int target, ret;
+	int ret;
 
 	if (fw->inst) {
+		int target;
+
 		nvkm_falcon_mask(falcon, 0x048, 0x00000001, 0x00000001);
 
 		switch (nvkm_memory_target(fw->inst)) {
@@ -285,15 +287,6 @@ gm200_flcn_fw_load(struct nvkm_falcon_fw *fw)
 	}
 
 	if (fw->boot) {
-		switch (nvkm_memory_target(&fw->fw.mem.memory)) {
-		case NVKM_MEM_TARGET_VRAM: target = 4; break;
-		case NVKM_MEM_TARGET_HOST: target = 5; break;
-		case NVKM_MEM_TARGET_NCOH: target = 6; break;
-		default:
-			WARN_ON(1);
-			return -EINVAL;
-		}
-
 		ret = nvkm_falcon_pio_wr(falcon, fw->boot, 0, 0,
 					 IMEM, falcon->code.limit - fw->boot_size, fw->boot_size,
 					 fw->boot_addr >> 8, false);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c
index 52412965fac1..5b721bd9d799 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c
@@ -209,11 +209,12 @@ nvkm_gsp_fwsec_v2(struct nvkm_gsp *gsp, const char *name,
 	fw->boot_addr = bld->start_tag << 8;
 	fw->boot_size = bld->code_size;
 	fw->boot = kmemdup(bl->data + hdr->data_offset + bld->code_off, fw->boot_size, GFP_KERNEL);
-	if (!fw->boot)
-		ret = -ENOMEM;
 
 	nvkm_firmware_put(bl);
 
+	if (!fw->boot)
+		return -ENOMEM;
+
 	/* Patch in interface data. */
 	return nvkm_gsp_fwsec_patch(gsp, fw, desc->InterfaceOffset, init_cmd);
 }
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 5f745d9ed6cc..445bbe0299b0 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -671,7 +671,8 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 	}
 
 	if (ttm_bo->type == ttm_bo_type_sg) {
-		ret = xe_bo_move_notify(bo, ctx);
+		if (new_mem->mem_type == XE_PL_SYSTEM)
+			ret = xe_bo_move_notify(bo, ctx);
 		if (!ret)
 			ret = xe_bo_move_dmabuf(ttm_bo, new_mem);
 		return ret;
diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
index b0684e6d2047..dd7bd766ae18 100644
--- a/drivers/gpu/drm/xe/xe_sync.c
+++ b/drivers/gpu/drm/xe/xe_sync.c
@@ -77,6 +77,7 @@ static void user_fence_worker(struct work_struct *w)
 {
 	struct xe_user_fence *ufence = container_of(w, struct xe_user_fence, worker);
 
+	WRITE_ONCE(ufence->signalled, 1);
 	if (mmget_not_zero(ufence->mm)) {
 		kthread_use_mm(ufence->mm);
 		if (copy_to_user(ufence->addr, &ufence->value, sizeof(ufence->value)))
@@ -89,7 +90,6 @@ static void user_fence_worker(struct work_struct *w)
 	 * Wake up waiters only after updating the ufence state, allowing the UMD
 	 * to safely reuse the same ufence without encountering -EBUSY errors.
 	 */
-	WRITE_ONCE(ufence->signalled, 1);
 	wake_up_all(&ufence->xe->ufence_wq);
 	user_fence_put(ufence);
 }
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 15fd497c920c..a4845d4213b0 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1402,8 +1402,12 @@ static int xe_vm_create_scratch(struct xe_device *xe, struct xe_tile *tile,
 
 	for (i = MAX_HUGEPTE_LEVEL; i < vm->pt_root[id]->level; i++) {
 		vm->scratch_pt[id][i] = xe_pt_create(vm, tile, i);
-		if (IS_ERR(vm->scratch_pt[id][i]))
-			return PTR_ERR(vm->scratch_pt[id][i]);
+		if (IS_ERR(vm->scratch_pt[id][i])) {
+			int err = PTR_ERR(vm->scratch_pt[id][i]);
+
+			vm->scratch_pt[id][i] = NULL;
+			return err;
+		}
 
 		xe_pt_populate_empty(tile, vm, vm->scratch_pt[id][i]);
 	}
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index c5bdf0f1b32f..6b90d2c03e88 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1210,7 +1210,13 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	if (!drvdata->input) {
+	/*
+	 * Check that input registration succeeded. Checking that
+	 * HID_CLAIMED_INPUT is set prevents a UAF when all input devices
+	 * were freed during registration due to no usages being mapped,
+	 * leaving drvdata->input pointing to freed memory.
+	 */
+	if (!drvdata->input || !(hdev->claimed & HID_CLAIMED_INPUT)) {
 		hid_err(hdev, "Asus input not registered\n");
 		ret = -ENOMEM;
 		goto err_stop_hw;
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b472140421f5..18c4e5f143a7 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -825,6 +825,8 @@
 #define USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_6019	0x6019
 #define USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_602E	0x602e
 #define USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_6093	0x6093
+#define USB_DEVICE_ID_LENOVO_LEGION_GO_DUAL_DINPUT	0x6184
+#define USB_DEVICE_ID_LENOVO_LEGION_GO2_DUAL_DINPUT	0x61ed
 
 #define USB_VENDOR_ID_LETSKETCH		0x6161
 #define USB_DEVICE_ID_WP9620N		0x4d15
@@ -898,6 +900,7 @@
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_2		0xc534
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1	0xc539
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_1	0xc53f
+#define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_2	0xc543
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_POWERPLAY	0xc53a
 #define USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER	0xc548
 #define USB_DEVICE_ID_SPACETRAVELLER	0xc623
diff --git a/drivers/hid/hid-input-test.c b/drivers/hid/hid-input-test.c
index 77c2d45ac62a..6f5c71660d82 100644
--- a/drivers/hid/hid-input-test.c
+++ b/drivers/hid/hid-input-test.c
@@ -7,7 +7,7 @@
 
 #include <kunit/test.h>
 
-static void hid_test_input_set_battery_charge_status(struct kunit *test)
+static void hid_test_input_update_battery_charge_status(struct kunit *test)
 {
 	struct hid_device *dev;
 	bool handled;
@@ -15,15 +15,15 @@ static void hid_test_input_set_battery_charge_status(struct kunit *test)
 	dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 
-	handled = hidinput_set_battery_charge_status(dev, HID_DG_HEIGHT, 0);
+	handled = hidinput_update_battery_charge_status(dev, HID_DG_HEIGHT, 0);
 	KUNIT_EXPECT_FALSE(test, handled);
 	KUNIT_EXPECT_EQ(test, dev->battery_charge_status, POWER_SUPPLY_STATUS_UNKNOWN);
 
-	handled = hidinput_set_battery_charge_status(dev, HID_BAT_CHARGING, 0);
+	handled = hidinput_update_battery_charge_status(dev, HID_BAT_CHARGING, 0);
 	KUNIT_EXPECT_TRUE(test, handled);
 	KUNIT_EXPECT_EQ(test, dev->battery_charge_status, POWER_SUPPLY_STATUS_DISCHARGING);
 
-	handled = hidinput_set_battery_charge_status(dev, HID_BAT_CHARGING, 1);
+	handled = hidinput_update_battery_charge_status(dev, HID_BAT_CHARGING, 1);
 	KUNIT_EXPECT_TRUE(test, handled);
 	KUNIT_EXPECT_EQ(test, dev->battery_charge_status, POWER_SUPPLY_STATUS_CHARGING);
 }
@@ -63,7 +63,7 @@ static void hid_test_input_get_battery_property(struct kunit *test)
 }
 
 static struct kunit_case hid_input_tests[] = {
-	KUNIT_CASE(hid_test_input_set_battery_charge_status),
+	KUNIT_CASE(hid_test_input_update_battery_charge_status),
 	KUNIT_CASE(hid_test_input_get_battery_property),
 	{ }
 };
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 9d80635a91eb..f5c217ac4bfa 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -595,13 +595,33 @@ static void hidinput_cleanup_battery(struct hid_device *dev)
 	dev->battery = NULL;
 }
 
-static void hidinput_update_battery(struct hid_device *dev, int value)
+static bool hidinput_update_battery_charge_status(struct hid_device *dev,
+						  unsigned int usage, int value)
+{
+	switch (usage) {
+	case HID_BAT_CHARGING:
+		dev->battery_charge_status = value ?
+					     POWER_SUPPLY_STATUS_CHARGING :
+					     POWER_SUPPLY_STATUS_DISCHARGING;
+		return true;
+	}
+
+	return false;
+}
+
+static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
+				    int value)
 {
 	int capacity;
 
 	if (!dev->battery)
 		return;
 
+	if (hidinput_update_battery_charge_status(dev, usage, value)) {
+		power_supply_changed(dev->battery);
+		return;
+	}
+
 	if (value == 0 || value < dev->battery_min || value > dev->battery_max)
 		return;
 
@@ -617,20 +637,6 @@ static void hidinput_update_battery(struct hid_device *dev, int value)
 		power_supply_changed(dev->battery);
 	}
 }
-
-static bool hidinput_set_battery_charge_status(struct hid_device *dev,
-					       unsigned int usage, int value)
-{
-	switch (usage) {
-	case HID_BAT_CHARGING:
-		dev->battery_charge_status = value ?
-					     POWER_SUPPLY_STATUS_CHARGING :
-					     POWER_SUPPLY_STATUS_DISCHARGING;
-		return true;
-	}
-
-	return false;
-}
 #else  /* !CONFIG_HID_BATTERY_STRENGTH */
 static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 				  struct hid_field *field, bool is_percentage)
@@ -642,14 +648,9 @@ static void hidinput_cleanup_battery(struct hid_device *dev)
 {
 }
 
-static void hidinput_update_battery(struct hid_device *dev, int value)
-{
-}
-
-static bool hidinput_set_battery_charge_status(struct hid_device *dev,
-					       unsigned int usage, int value)
+static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
+				    int value)
 {
-	return false;
 }
 #endif	/* CONFIG_HID_BATTERY_STRENGTH */
 
@@ -1515,11 +1516,7 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 		return;
 
 	if (usage->type == EV_PWR) {
-		bool handled = hidinput_set_battery_charge_status(hid, usage->hid, value);
-
-		if (!handled)
-			hidinput_update_battery(hid, value);
-
+		hidinput_update_battery(hid, usage->hid, value);
 		return;
 	}
 
diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 34fa71ceec2b..cce54dd9884a 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1983,6 +1983,10 @@ static const struct hid_device_id logi_dj_receivers[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_1),
 	 .driver_data = recvr_type_gaming_hidpp},
+	{ /* Logitech lightspeed receiver (0xc543) */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
+		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_2),
+	 .driver_data = recvr_type_gaming_hidpp},
 
 	{ /* Logitech 27 MHz HID++ 1.0 receiver (0xc513) */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVER),
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index cf7a6986cf20..234ddd4422d9 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4624,6 +4624,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC094) },
 	{ /* Logitech G Pro X Superlight 2 Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC09b) },
+	{ /* Logitech G PRO 2 LIGHTSPEED Wireless Mouse over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xc09a) },
 
 	{ /* G935 Gaming Headset */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0x0a87),
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 641292cfdaa6..5c424010bc02 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1453,6 +1453,14 @@ static const __u8 *mt_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	if (hdev->vendor == I2C_VENDOR_ID_GOODIX &&
 	    (hdev->product == I2C_DEVICE_ID_GOODIX_01E8 ||
 	     hdev->product == I2C_DEVICE_ID_GOODIX_01E9)) {
+		if (*size < 608) {
+			dev_info(
+				&hdev->dev,
+				"GT7868Q fixup: report descriptor is only %u bytes, skipping\n",
+				*size);
+			return rdesc;
+		}
+
 		if (rdesc[607] == 0x15) {
 			rdesc[607] = 0x25;
 			dev_info(
diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 2738ce947434..0f76e241e0af 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -144,6 +144,9 @@ static void ntrig_report_version(struct hid_device *hdev)
 	struct usb_device *usb_dev = hid_to_usb_dev(hdev);
 	unsigned char *data = kmalloc(8, GFP_KERNEL);
 
+	if (!hid_is_usb(hdev))
+		return;
+
 	if (!data)
 		goto err_free;
 
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 80372342c176..64f9728018b8 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -124,6 +124,8 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_PENSKETCH_T609A), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LABTEC, USB_DEVICE_ID_LABTEC_ODDOR_HANDBRAKE), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_LEGION_GO_DUAL_DINPUT), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_LEGION_GO2_DUAL_DINPUT), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_OPTICAL_USB_MOUSE_600E), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_608D), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_6019), HID_QUIRK_ALWAYS_POLL },
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c7033ffaba39..a076dc0b60ee 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -684,6 +684,7 @@ static bool wacom_is_art_pen(int tool_id)
 	case 0x885:	/* Intuos3 Marker Pen */
 	case 0x804:	/* Intuos4/5 13HD/24HD Marker Pen */
 	case 0x10804:	/* Intuos4/5 13HD/24HD Art Pen */
+	case 0x204:     /* Art Pen 2 */
 		is_art_pen = true;
 		break;
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f4bafc71a739..08886c3a28c6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7780,7 +7780,8 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	}
 	rx_rings = min_t(int, rx_rings, hwr.grp);
 	hwr.cp = min_t(int, hwr.cp, bp->cp_nr_rings);
-	if (hwr.stat > bnxt_get_ulp_stat_ctxs(bp))
+	if (bnxt_ulp_registered(bp->edev) &&
+	    hwr.stat > bnxt_get_ulp_stat_ctxs(bp))
 		hwr.stat -= bnxt_get_ulp_stat_ctxs(bp);
 	hwr.cp = min_t(int, hwr.cp, hwr.stat);
 	rc = bnxt_trim_rings(bp, &rx_rings, &hwr.tx, hwr.cp, sh);
@@ -7788,6 +7789,11 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 		hwr.rx = rx_rings << 1;
 	tx_cp = bnxt_num_tx_to_cp(bp, hwr.tx);
 	hwr.cp = sh ? max_t(int, tx_cp, rx_rings) : tx_cp + rx_rings;
+	if (hwr.tx != bp->tx_nr_rings) {
+		netdev_warn(bp->dev,
+			    "Able to reserve only %d out of %d requested TX rings\n",
+			    hwr.tx, bp->tx_nr_rings);
+	}
 	bp->tx_nr_rings = hwr.tx;
 
 	/* If we cannot reserve all the RX rings, reset the RSS map only
@@ -12241,6 +12247,17 @@ static int bnxt_set_xps_mapping(struct bnxt *bp)
 	return rc;
 }
 
+static int bnxt_tx_nr_rings(struct bnxt *bp)
+{
+	return bp->num_tc ? bp->tx_nr_rings_per_tc * bp->num_tc :
+			    bp->tx_nr_rings_per_tc;
+}
+
+static int bnxt_tx_nr_rings_per_tc(struct bnxt *bp)
+{
+	return bp->num_tc ? bp->tx_nr_rings / bp->num_tc : bp->tx_nr_rings;
+}
+
 static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 {
 	int rc = 0;
@@ -12258,6 +12275,13 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 	if (rc)
 		return rc;
 
+	/* Make adjustments if reserved TX rings are less than requested */
+	bp->tx_nr_rings -= bp->tx_nr_rings_xdp;
+	bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
+	if (bp->tx_nr_rings_xdp) {
+		bp->tx_nr_rings_xdp = bp->tx_nr_rings_per_tc;
+		bp->tx_nr_rings += bp->tx_nr_rings_xdp;
+	}
 	rc = bnxt_alloc_mem(bp, irq_re_init);
 	if (rc) {
 		netdev_err(bp->dev, "bnxt_alloc_mem err: %x\n", rc);
@@ -15676,7 +15700,7 @@ static void bnxt_trim_dflt_sh_rings(struct bnxt *bp)
 	bp->cp_nr_rings = min_t(int, bp->tx_nr_rings_per_tc, bp->rx_nr_rings);
 	bp->rx_nr_rings = bp->cp_nr_rings;
 	bp->tx_nr_rings_per_tc = bp->cp_nr_rings;
-	bp->tx_nr_rings = bp->tx_nr_rings_per_tc;
+	bp->tx_nr_rings = bnxt_tx_nr_rings(bp);
 }
 
 static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
@@ -15708,7 +15732,7 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		bnxt_trim_dflt_sh_rings(bp);
 	else
 		bp->cp_nr_rings = bp->tx_nr_rings_per_tc + bp->rx_nr_rings;
-	bp->tx_nr_rings = bp->tx_nr_rings_per_tc;
+	bp->tx_nr_rings = bnxt_tx_nr_rings(bp);
 
 	avail_msix = bnxt_get_max_func_irqs(bp) - bp->cp_nr_rings;
 	if (avail_msix >= BNXT_MIN_ROCE_CP_RINGS) {
@@ -15721,7 +15745,7 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 	rc = __bnxt_reserve_rings(bp);
 	if (rc && rc != -ENODEV)
 		netdev_warn(bp->dev, "Unable to reserve tx rings\n");
-	bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
+	bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
 	if (sh)
 		bnxt_trim_dflt_sh_rings(bp);
 
@@ -15730,7 +15754,7 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		rc = __bnxt_reserve_rings(bp);
 		if (rc && rc != -ENODEV)
 			netdev_warn(bp->dev, "2nd rings reservation failed.\n");
-		bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
+		bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
 	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
 		bp->rx_nr_rings++;
@@ -15764,7 +15788,7 @@ static int bnxt_init_dflt_ring_mode(struct bnxt *bp)
 	if (rc)
 		goto init_dflt_ring_err;
 
-	bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
+	bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
 
 	bnxt_set_dflt_rfs(bp);
 
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 3c2a7919b128..6c2d69ef1a8d 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5225,19 +5225,16 @@ static void macb_remove(struct platform_device *pdev)
 
 	if (dev) {
 		bp = netdev_priv(dev);
+		unregister_netdev(dev);
 		phy_exit(bp->sgmii_phy);
 		mdiobus_unregister(bp->mii_bus);
 		mdiobus_free(bp->mii_bus);
 
-		unregister_netdev(dev);
+		device_set_wakeup_enable(&bp->pdev->dev, 0);
 		cancel_work_sync(&bp->hresp_err_bh_work);
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_dont_use_autosuspend(&pdev->dev);
-		if (!pm_runtime_suspended(&pdev->dev)) {
-			macb_clks_disable(bp->pclk, bp->hclk, bp->tx_clk,
-					  bp->rx_clk, bp->tsu_clk);
-			pm_runtime_set_suspended(&pdev->dev);
-		}
+		pm_runtime_set_suspended(&pdev->dev);
 		phylink_destroy(bp->phylink);
 		free_netdev(dev);
 	}
diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 787218d60c6b..2c1b551e1442 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -1091,7 +1091,7 @@ get_stats (struct net_device *dev)
 	dev->stats.rx_bytes += dr32(OctetRcvOk);
 	dev->stats.tx_bytes += dr32(OctetXmtOk);
 
-	dev->stats.multicast = dr32(McstFramesRcvdOk);
+	dev->stats.multicast += dr32(McstFramesRcvdOk);
 	dev->stats.collisions += dr32(SingleColFrames)
 			     +  dr32(MultiColFrames);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 66e070095d1b..10285995c9ed 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -13,16 +13,45 @@
 static DEFINE_XARRAY(ice_adapters);
 static DEFINE_MUTEX(ice_adapters_mutex);
 
-static unsigned long ice_adapter_index(u64 dsn)
+#define ICE_ADAPTER_FIXED_INDEX	BIT_ULL(63)
+
+#define ICE_ADAPTER_INDEX_E825C	\
+	(ICE_DEV_ID_E825C_BACKPLANE | ICE_ADAPTER_FIXED_INDEX)
+
+static u64 ice_adapter_index(struct pci_dev *pdev)
 {
+	switch (pdev->device) {
+	case ICE_DEV_ID_E825C_BACKPLANE:
+	case ICE_DEV_ID_E825C_QSFP:
+	case ICE_DEV_ID_E825C_SFP:
+	case ICE_DEV_ID_E825C_SGMII:
+		/* E825C devices have multiple NACs which are connected to the
+		 * same clock source, and which must share the same
+		 * ice_adapter structure. We can't use the serial number since
+		 * each NAC has its own NVM generated with its own unique
+		 * Device Serial Number. Instead, rely on the embedded nature
+		 * of the E825C devices, and use a fixed index. This relies on
+		 * the fact that all E825C physical functions in a given
+		 * system are part of the same overall device.
+		 */
+		return ICE_ADAPTER_INDEX_E825C;
+	default:
+		return pci_get_dsn(pdev) & ~ICE_ADAPTER_FIXED_INDEX;
+	}
+}
+
+static unsigned long ice_adapter_xa_index(struct pci_dev *pdev)
+{
+	u64 index = ice_adapter_index(pdev);
+
 #if BITS_PER_LONG == 64
-	return dsn;
+	return index;
 #else
-	return (u32)dsn ^ (u32)(dsn >> 32);
+	return (u32)index ^ (u32)(index >> 32);
 #endif
 }
 
-static struct ice_adapter *ice_adapter_new(u64 dsn)
+static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 {
 	struct ice_adapter *adapter;
 
@@ -30,7 +59,7 @@ static struct ice_adapter *ice_adapter_new(u64 dsn)
 	if (!adapter)
 		return NULL;
 
-	adapter->device_serial_number = dsn;
+	adapter->index = ice_adapter_index(pdev);
 	spin_lock_init(&adapter->ptp_gltsyn_time_lock);
 	refcount_set(&adapter->refcount, 1);
 
@@ -63,24 +92,23 @@ static void ice_adapter_free(struct ice_adapter *adapter)
  */
 struct ice_adapter *ice_adapter_get(struct pci_dev *pdev)
 {
-	u64 dsn = pci_get_dsn(pdev);
 	struct ice_adapter *adapter;
 	unsigned long index;
 	int err;
 
-	index = ice_adapter_index(dsn);
+	index = ice_adapter_xa_index(pdev);
 	scoped_guard(mutex, &ice_adapters_mutex) {
 		err = xa_insert(&ice_adapters, index, NULL, GFP_KERNEL);
 		if (err == -EBUSY) {
 			adapter = xa_load(&ice_adapters, index);
 			refcount_inc(&adapter->refcount);
-			WARN_ON_ONCE(adapter->device_serial_number != dsn);
+			WARN_ON_ONCE(adapter->index != ice_adapter_index(pdev));
 			return adapter;
 		}
 		if (err)
 			return ERR_PTR(err);
 
-		adapter = ice_adapter_new(dsn);
+		adapter = ice_adapter_new(pdev);
 		if (!adapter)
 			return ERR_PTR(-ENOMEM);
 		xa_store(&ice_adapters, index, adapter, GFP_KERNEL);
@@ -99,11 +127,10 @@ struct ice_adapter *ice_adapter_get(struct pci_dev *pdev)
  */
 void ice_adapter_put(struct pci_dev *pdev)
 {
-	u64 dsn = pci_get_dsn(pdev);
 	struct ice_adapter *adapter;
 	unsigned long index;
 
-	index = ice_adapter_index(dsn);
+	index = ice_adapter_xa_index(pdev);
 	scoped_guard(mutex, &ice_adapters_mutex) {
 		adapter = xa_load(&ice_adapters, index);
 		if (WARN_ON(!adapter))
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index ac15c0d2bc1a..409467847c75 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -32,7 +32,7 @@ struct ice_port_list {
  * @refcount: Reference count. struct ice_pf objects hold the references.
  * @ctrl_pf: Control PF of the adapter
  * @ports: Ports list
- * @device_serial_number: DSN cached for collision detection on 32bit systems
+ * @index: 64-bit index cached for collision detection on 32bit systems
  */
 struct ice_adapter {
 	refcount_t refcount;
@@ -41,7 +41,7 @@ struct ice_adapter {
 
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
-	u64 device_serial_number;
+	u64 index;
 };
 
 struct ice_adapter *ice_adapter_get(struct pci_dev *pdev);
diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index e4c8cd12a41d..04bec5d8e708 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -2352,7 +2352,13 @@ ice_get_set_tx_topo(struct ice_hw *hw, u8 *buf, u16 buf_size,
  * The function will apply the new Tx topology from the package buffer
  * if available.
  *
- * Return: zero when update was successful, negative values otherwise.
+ * Return:
+ * * 0 - Successfully applied topology configuration.
+ * * -EBUSY - Failed to acquire global configuration lock.
+ * * -EEXIST - Topology configuration has already been applied.
+ * * -EIO - Unable to apply topology configuration.
+ * * -ENODEV - Failed to re-initialize device after applying configuration.
+ * * Other negative error codes indicate unexpected failures.
  */
 int ice_cfg_tx_topo(struct ice_hw *hw, const void *buf, u32 len)
 {
@@ -2385,7 +2391,7 @@ int ice_cfg_tx_topo(struct ice_hw *hw, const void *buf, u32 len)
 
 	if (status) {
 		ice_debug(hw, ICE_DBG_INIT, "Get current topology is failed\n");
-		return status;
+		return -EIO;
 	}
 
 	/* Is default topology already applied ? */
@@ -2472,31 +2478,45 @@ int ice_cfg_tx_topo(struct ice_hw *hw, const void *buf, u32 len)
 				 ICE_GLOBAL_CFG_LOCK_TIMEOUT);
 	if (status) {
 		ice_debug(hw, ICE_DBG_INIT, "Failed to acquire global lock\n");
-		return status;
+		return -EBUSY;
 	}
 
 	/* Check if reset was triggered already. */
 	reg = rd32(hw, GLGEN_RSTAT);
 	if (reg & GLGEN_RSTAT_DEVSTATE_M) {
-		/* Reset is in progress, re-init the HW again */
 		ice_debug(hw, ICE_DBG_INIT, "Reset is in progress. Layer topology might be applied already\n");
 		ice_check_reset(hw);
-		return 0;
+		/* Reset is in progress, re-init the HW again */
+		goto reinit_hw;
 	}
 
 	/* Set new topology */
 	status = ice_get_set_tx_topo(hw, new_topo, size, NULL, NULL, true);
 	if (status) {
-		ice_debug(hw, ICE_DBG_INIT, "Failed setting Tx topology\n");
-		return status;
+		ice_debug(hw, ICE_DBG_INIT, "Failed to set Tx topology, status %pe\n",
+			  ERR_PTR(status));
+		/* only report -EIO here as the caller checks the error value
+		 * and reports an informational error message informing that
+		 * the driver failed to program Tx topology.
+		 */
+		status = -EIO;
 	}
 
-	/* New topology is updated, delay 1 second before issuing the CORER */
+	/* Even if Tx topology config failed, we need to CORE reset here to
+	 * clear the global configuration lock. Delay 1 second to allow
+	 * hardware to settle then issue a CORER
+	 */
 	msleep(1000);
 	ice_reset(hw, ICE_RESET_CORER);
-	/* CORER will clear the global lock, so no explicit call
-	 * required for release.
-	 */
+	ice_check_reset(hw);
+
+reinit_hw:
+	/* Since we triggered a CORER, re-initialize hardware */
+	ice_deinit_hw(hw);
+	if (ice_init_hw(hw)) {
+		ice_debug(hw, ICE_DBG_INIT, "Failed to re-init hardware after setting Tx topology\n");
+		return -ENODEV;
+	}
 
-	return 0;
+	return status;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d1abd21cfc64..74d4f2fde3e0 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4559,17 +4559,23 @@ ice_init_tx_topology(struct ice_hw *hw, const struct firmware *firmware)
 			dev_info(dev, "Tx scheduling layers switching feature disabled\n");
 		else
 			dev_info(dev, "Tx scheduling layers switching feature enabled\n");
-		/* if there was a change in topology ice_cfg_tx_topo triggered
-		 * a CORER and we need to re-init hw
+		return 0;
+	} else if (err == -ENODEV) {
+		/* If we failed to re-initialize the device, we can no longer
+		 * continue loading.
 		 */
-		ice_deinit_hw(hw);
-		err = ice_init_hw(hw);
-
+		dev_warn(dev, "Failed to initialize hardware after applying Tx scheduling configuration.\n");
 		return err;
 	} else if (err == -EIO) {
 		dev_info(dev, "DDP package does not support Tx scheduling layers switching feature - please update to the latest DDP package and try again\n");
+		return 0;
+	} else if (err == -EEXIST) {
+		return 0;
 	}
 
+	/* Do not treat this as a fatal error. */
+	dev_info(dev, "Failed to apply Tx scheduling configuration, err %pe\n",
+		 ERR_PTR(err));
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index f522dd42093a..cde69f568665 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1295,7 +1295,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			skb = ice_construct_skb(rx_ring, xdp);
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
-			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
+			rx_ring->ring_stats->rx_stats.alloc_buf_failed++;
 			xdp_verdict = ICE_XDP_CONSUMED;
 		}
 		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit, ntc, xdp_verdict);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index a2cf3e79693d..511b3ba24542 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -107,7 +107,7 @@ static int mlx5_devlink_reload_fw_activate(struct devlink *devlink, struct netli
 	if (err)
 		return err;
 
-	mlx5_unload_one_devl_locked(dev, true);
+	mlx5_sync_reset_unload_flow(dev, true);
 	err = mlx5_health_wait_pci_up(dev);
 	if (err)
 		NL_SET_ERR_MSG_MOD(extack, "FW activate aborted, PCI reads fail after reset");
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
index 3efa8bf1d14e..4720523813b9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
@@ -575,7 +575,6 @@ int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 		if (err)
 			return err;
 	}
-	priv->dcbx.xoff = xoff;
 
 	/* Apply the settings */
 	if (update_buffer) {
@@ -584,6 +583,8 @@ int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 			return err;
 	}
 
+	priv->dcbx.xoff = xoff;
+
 	if (update_prio2buffer)
 		err = mlx5e_port_set_priority2buffer(priv->mdev, prio2buffer);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
index f4a19ffbb641..66d276a1be83 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
@@ -66,11 +66,23 @@ struct mlx5e_port_buffer {
 	struct mlx5e_bufferx_reg  buffer[MLX5E_MAX_NETWORK_BUFFER];
 };
 
+#ifdef CONFIG_MLX5_CORE_EN_DCB
 int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 				    u32 change, unsigned int mtu,
 				    struct ieee_pfc *pfc,
 				    u32 *buffer_size,
 				    u8 *prio2buffer);
+#else
+static inline int
+mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
+				u32 change, unsigned int mtu,
+				void *pfc,
+				u32 *buffer_size,
+				u8 *prio2buffer)
+{
+	return 0;
+}
+#endif
 
 int mlx5e_port_query_buffer(struct mlx5e_priv *priv,
 			    struct mlx5e_port_buffer *port_buffer);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 4a2f58a9d706..6176457b846b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -47,6 +47,7 @@
 #include "en.h"
 #include "en/dim.h"
 #include "en/txrx.h"
+#include "en/port_buffer.h"
 #include "en_tc.h"
 #include "en_rep.h"
 #include "en_accel/ipsec.h"
@@ -134,6 +135,8 @@ void mlx5e_update_carrier(struct mlx5e_priv *priv)
 	if (up) {
 		netdev_info(priv->netdev, "Link up\n");
 		netif_carrier_on(priv->netdev);
+		mlx5e_port_manual_buffer_config(priv, 0, priv->netdev->mtu,
+						NULL, NULL, NULL);
 	} else {
 		netdev_info(priv->netdev, "Link down\n");
 		netif_carrier_off(priv->netdev);
@@ -2917,9 +2920,11 @@ int mlx5e_set_dev_port_mtu(struct mlx5e_priv *priv)
 	struct mlx5e_params *params = &priv->channels.params;
 	struct net_device *netdev = priv->netdev;
 	struct mlx5_core_dev *mdev = priv->mdev;
-	u16 mtu;
+	u16 mtu, prev_mtu;
 	int err;
 
+	mlx5e_query_mtu(mdev, params, &prev_mtu);
+
 	err = mlx5e_set_mtu(mdev, params, params->sw_mtu);
 	if (err)
 		return err;
@@ -2929,6 +2934,18 @@ int mlx5e_set_dev_port_mtu(struct mlx5e_priv *priv)
 		netdev_warn(netdev, "%s: VPort MTU %d is different than netdev mtu %d\n",
 			    __func__, mtu, params->sw_mtu);
 
+	if (mtu != prev_mtu && MLX5_BUFFER_SUPPORTED(mdev)) {
+		err = mlx5e_port_manual_buffer_config(priv, 0, mtu,
+						      NULL, NULL, NULL);
+		if (err) {
+			netdev_warn(netdev, "%s: Failed to set Xon/Xoff values with MTU %d (err %d), setting back to previous MTU %d\n",
+				    __func__, mtu, err, prev_mtu);
+
+			mlx5e_set_mtu(mdev, params, prev_mtu);
+			return err;
+		}
+	}
+
 	params->sw_mtu = mtu;
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 4f55e55ecb55..516df7f1997e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -6,13 +6,15 @@
 #include "fw_reset.h"
 #include "diag/fw_tracer.h"
 #include "lib/tout.h"
+#include "sf/sf.h"
 
 enum {
 	MLX5_FW_RESET_FLAGS_RESET_REQUESTED,
 	MLX5_FW_RESET_FLAGS_NACK_RESET_REQUEST,
 	MLX5_FW_RESET_FLAGS_PENDING_COMP,
 	MLX5_FW_RESET_FLAGS_DROP_NEW_REQUESTS,
-	MLX5_FW_RESET_FLAGS_RELOAD_REQUIRED
+	MLX5_FW_RESET_FLAGS_RELOAD_REQUIRED,
+	MLX5_FW_RESET_FLAGS_UNLOAD_EVENT,
 };
 
 struct mlx5_fw_reset {
@@ -218,7 +220,7 @@ int mlx5_fw_reset_set_live_patch(struct mlx5_core_dev *dev)
 	return mlx5_reg_mfrl_set(dev, MLX5_MFRL_REG_RESET_LEVEL0, 0, 0, false);
 }
 
-static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev, bool unloaded)
+static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev)
 {
 	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
 	struct devlink *devlink = priv_to_devlink(dev);
@@ -227,8 +229,7 @@ static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev, bool unload
 	if (test_bit(MLX5_FW_RESET_FLAGS_PENDING_COMP, &fw_reset->reset_flags)) {
 		complete(&fw_reset->done);
 	} else {
-		if (!unloaded)
-			mlx5_unload_one(dev, false);
+		mlx5_sync_reset_unload_flow(dev, false);
 		if (mlx5_health_wait_pci_up(dev))
 			mlx5_core_err(dev, "reset reload flow aborted, PCI reads still not working\n");
 		else
@@ -271,7 +272,7 @@ static void mlx5_sync_reset_reload_work(struct work_struct *work)
 
 	mlx5_sync_reset_clear_reset_requested(dev, false);
 	mlx5_enter_error_state(dev, true);
-	mlx5_fw_reset_complete_reload(dev, false);
+	mlx5_fw_reset_complete_reload(dev);
 }
 
 #define MLX5_RESET_POLL_INTERVAL	(HZ / 10)
@@ -423,6 +424,11 @@ static bool mlx5_is_reset_now_capable(struct mlx5_core_dev *dev,
 		return false;
 	}
 
+	if (!mlx5_core_is_ecpf(dev) && !mlx5_sf_table_empty(dev)) {
+		mlx5_core_warn(dev, "SFs should be removed before reset\n");
+		return false;
+	}
+
 #if IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE)
 	if (reset_method != MLX5_MFRL_REG_PCI_RESET_METHOD_HOT_RESET) {
 		err = mlx5_check_hotplug_interrupt(dev);
@@ -581,6 +587,59 @@ static int mlx5_sync_pci_reset(struct mlx5_core_dev *dev, u8 reset_method)
 	return err;
 }
 
+void mlx5_sync_reset_unload_flow(struct mlx5_core_dev *dev, bool locked)
+{
+	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
+	unsigned long timeout;
+	bool reset_action;
+	u8 rst_state;
+	int err;
+
+	if (locked)
+		mlx5_unload_one_devl_locked(dev, false);
+	else
+		mlx5_unload_one(dev, false);
+
+	if (!test_bit(MLX5_FW_RESET_FLAGS_UNLOAD_EVENT, &fw_reset->reset_flags))
+		return;
+
+	mlx5_set_fw_rst_ack(dev);
+	mlx5_core_warn(dev, "Sync Reset Unload done, device reset expected\n");
+
+	reset_action = false;
+	timeout = jiffies + msecs_to_jiffies(mlx5_tout_ms(dev, RESET_UNLOAD));
+	do {
+		rst_state = mlx5_get_fw_rst_state(dev);
+		if (rst_state == MLX5_FW_RST_STATE_TOGGLE_REQ ||
+		    rst_state == MLX5_FW_RST_STATE_IDLE) {
+			reset_action = true;
+			break;
+		}
+		msleep(20);
+	} while (!time_after(jiffies, timeout));
+
+	if (!reset_action) {
+		mlx5_core_err(dev, "Got timeout waiting for sync reset action, state = %u\n",
+			      rst_state);
+		fw_reset->ret = -ETIMEDOUT;
+		goto done;
+	}
+
+	mlx5_core_warn(dev, "Sync Reset, got reset action. rst_state = %u\n",
+		       rst_state);
+	if (rst_state == MLX5_FW_RST_STATE_TOGGLE_REQ) {
+		err = mlx5_sync_pci_reset(dev, fw_reset->reset_method);
+		if (err) {
+			mlx5_core_warn(dev, "mlx5_sync_pci_reset failed, err %d\n",
+				       err);
+			fw_reset->ret = err;
+		}
+	}
+
+done:
+	clear_bit(MLX5_FW_RESET_FLAGS_UNLOAD_EVENT, &fw_reset->reset_flags);
+}
+
 static void mlx5_sync_reset_now_event(struct work_struct *work)
 {
 	struct mlx5_fw_reset *fw_reset = container_of(work, struct mlx5_fw_reset,
@@ -608,16 +667,13 @@ static void mlx5_sync_reset_now_event(struct work_struct *work)
 	mlx5_enter_error_state(dev, true);
 done:
 	fw_reset->ret = err;
-	mlx5_fw_reset_complete_reload(dev, false);
+	mlx5_fw_reset_complete_reload(dev);
 }
 
 static void mlx5_sync_reset_unload_event(struct work_struct *work)
 {
 	struct mlx5_fw_reset *fw_reset;
 	struct mlx5_core_dev *dev;
-	unsigned long timeout;
-	bool reset_action;
-	u8 rst_state;
 	int err;
 
 	fw_reset = container_of(work, struct mlx5_fw_reset, reset_unload_work);
@@ -626,6 +682,7 @@ static void mlx5_sync_reset_unload_event(struct work_struct *work)
 	if (mlx5_sync_reset_clear_reset_requested(dev, false))
 		return;
 
+	set_bit(MLX5_FW_RESET_FLAGS_UNLOAD_EVENT, &fw_reset->reset_flags);
 	mlx5_core_warn(dev, "Sync Reset Unload. Function is forced down.\n");
 
 	err = mlx5_cmd_fast_teardown_hca(dev);
@@ -634,44 +691,7 @@ static void mlx5_sync_reset_unload_event(struct work_struct *work)
 	else
 		mlx5_enter_error_state(dev, true);
 
-	if (test_bit(MLX5_FW_RESET_FLAGS_PENDING_COMP, &fw_reset->reset_flags))
-		mlx5_unload_one_devl_locked(dev, false);
-	else
-		mlx5_unload_one(dev, false);
-
-	mlx5_set_fw_rst_ack(dev);
-	mlx5_core_warn(dev, "Sync Reset Unload done, device reset expected\n");
-
-	reset_action = false;
-	timeout = jiffies + msecs_to_jiffies(mlx5_tout_ms(dev, RESET_UNLOAD));
-	do {
-		rst_state = mlx5_get_fw_rst_state(dev);
-		if (rst_state == MLX5_FW_RST_STATE_TOGGLE_REQ ||
-		    rst_state == MLX5_FW_RST_STATE_IDLE) {
-			reset_action = true;
-			break;
-		}
-		msleep(20);
-	} while (!time_after(jiffies, timeout));
-
-	if (!reset_action) {
-		mlx5_core_err(dev, "Got timeout waiting for sync reset action, state = %u\n",
-			      rst_state);
-		fw_reset->ret = -ETIMEDOUT;
-		goto done;
-	}
-
-	mlx5_core_warn(dev, "Sync Reset, got reset action. rst_state = %u\n", rst_state);
-	if (rst_state == MLX5_FW_RST_STATE_TOGGLE_REQ) {
-		err = mlx5_sync_pci_reset(dev, fw_reset->reset_method);
-		if (err) {
-			mlx5_core_warn(dev, "mlx5_sync_pci_reset failed, err %d\n", err);
-			fw_reset->ret = err;
-		}
-	}
-
-done:
-	mlx5_fw_reset_complete_reload(dev, true);
+	mlx5_fw_reset_complete_reload(dev);
 }
 
 static void mlx5_sync_reset_abort_event(struct work_struct *work)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h
index ea527d06a85f..d5b28525c960 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h
@@ -12,6 +12,7 @@ int mlx5_fw_reset_set_reset_sync(struct mlx5_core_dev *dev, u8 reset_type_sel,
 int mlx5_fw_reset_set_live_patch(struct mlx5_core_dev *dev);
 
 int mlx5_fw_reset_wait_reset_done(struct mlx5_core_dev *dev);
+void mlx5_sync_reset_unload_flow(struct mlx5_core_dev *dev, bool locked);
 int mlx5_fw_reset_verify_fw_complete(struct mlx5_core_dev *dev,
 				     struct netlink_ext_ack *extack);
 void mlx5_fw_reset_events_start(struct mlx5_core_dev *dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index b96909fbeb12..bdac3db1bd61 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -518,3 +518,13 @@ void mlx5_sf_table_cleanup(struct mlx5_core_dev *dev)
 	WARN_ON(!xa_empty(&table->function_ids));
 	kfree(table);
 }
+
+bool mlx5_sf_table_empty(const struct mlx5_core_dev *dev)
+{
+	struct mlx5_sf_table *table = dev->priv.sf_table;
+
+	if (!table)
+		return true;
+
+	return xa_empty(&table->function_ids);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h b/drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h
index 860f9ddb7107..89559a37997a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h
@@ -17,6 +17,7 @@ void mlx5_sf_hw_table_destroy(struct mlx5_core_dev *dev);
 
 int mlx5_sf_table_init(struct mlx5_core_dev *dev);
 void mlx5_sf_table_cleanup(struct mlx5_core_dev *dev);
+bool mlx5_sf_table_empty(const struct mlx5_core_dev *dev);
 
 int mlx5_devlink_sf_port_new(struct devlink *devlink,
 			     const struct devlink_port_new_attrs *add_attr,
@@ -61,6 +62,11 @@ static inline void mlx5_sf_table_cleanup(struct mlx5_core_dev *dev)
 {
 }
 
+static inline bool mlx5_sf_table_empty(const struct mlx5_core_dev *dev)
+{
+	return true;
+}
+
 #endif
 
 #endif
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 79e94632533c..a8c95b1732f4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -53,6 +53,8 @@ int __fbnic_open(struct fbnic_net *fbn)
 	fbnic_bmc_rpc_init(fbd);
 	fbnic_rss_reinit(fbd, fbn);
 
+	phylink_resume(fbn->phylink);
+
 	return 0;
 release_ownership:
 	fbnic_fw_xmit_ownership_msg(fbn->fbd, false);
@@ -79,6 +81,8 @@ static int fbnic_stop(struct net_device *netdev)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
 
+	phylink_suspend(fbn->phylink, fbnic_bmc_present(fbn->fbd));
+
 	fbnic_down(fbn);
 	fbnic_pcs_irq_disable(fbn->fbd);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 268489b15616..72bdc6c76c0c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -116,14 +116,12 @@ static void fbnic_service_task_start(struct fbnic_net *fbn)
 	struct fbnic_dev *fbd = fbn->fbd;
 
 	schedule_delayed_work(&fbd->service_task, HZ);
-	phylink_resume(fbn->phylink);
 }
 
 static void fbnic_service_task_stop(struct fbnic_net *fbn)
 {
 	struct fbnic_dev *fbd = fbn->fbd;
 
-	phylink_suspend(fbn->phylink, fbnic_bmc_present(fbd));
 	cancel_delayed_work(&fbd->service_task);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index f519d43738b0..445259f2ee93 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -47,6 +47,14 @@ static void dwxgmac2_core_init(struct mac_device_info *hw,
 	writel(XGMAC_INT_DEFAULT_EN, ioaddr + XGMAC_INT_EN);
 }
 
+static void dwxgmac2_update_caps(struct stmmac_priv *priv)
+{
+	if (!priv->dma_cap.mbps_10_100)
+		priv->hw->link.caps &= ~(MAC_10 | MAC_100);
+	else if (!priv->dma_cap.half_duplex)
+		priv->hw->link.caps &= ~(MAC_10HD | MAC_100HD);
+}
+
 static void dwxgmac2_set_mac(void __iomem *ioaddr, bool enable)
 {
 	u32 tx = readl(ioaddr + XGMAC_TX_CONFIG);
@@ -1532,6 +1540,7 @@ static void dwxgmac3_fpe_configure(void __iomem *ioaddr,
 
 const struct stmmac_ops dwxgmac210_ops = {
 	.core_init = dwxgmac2_core_init,
+	.update_caps = dwxgmac2_update_caps,
 	.set_mac = dwxgmac2_set_mac,
 	.rx_ipc = dwxgmac2_rx_ipc,
 	.rx_queue_enable = dwxgmac2_rx_queue_enable,
@@ -1646,8 +1655,8 @@ int dwxgmac2_setup(struct stmmac_priv *priv)
 		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
 
 	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-			 MAC_1000FD | MAC_2500FD | MAC_5000FD |
-			 MAC_10000FD;
+			 MAC_10 | MAC_100 | MAC_1000FD |
+			 MAC_2500FD | MAC_5000FD | MAC_10000FD;
 	mac->link.duplex = 0;
 	mac->link.speed10 = XGMAC_CONFIG_SS_10_MII;
 	mac->link.speed100 = XGMAC_CONFIG_SS_100_MII;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 5dcc95bc0ad2..4d6bb995d8d8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -203,10 +203,6 @@ static void dwxgmac2_dma_rx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
 	}
 
 	writel(value, ioaddr + XGMAC_MTL_RXQ_OPMODE(channel));
-
-	/* Enable MTL RX overflow */
-	value = readl(ioaddr + XGMAC_MTL_QINTEN(channel));
-	writel(value | XGMAC_RXOIE, ioaddr + XGMAC_MTL_QINTEN(channel));
 }
 
 static void dwxgmac2_dma_tx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
@@ -386,8 +382,11 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
 static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
 				   struct dma_features *dma_cap)
 {
+	struct stmmac_priv *priv;
 	u32 hw_cap;
 
+	priv = container_of(dma_cap, struct stmmac_priv, dma_cap);
+
 	/* MAC HW feature 0 */
 	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE0);
 	dma_cap->edma = (hw_cap & XGMAC_HWFEAT_EDMA) >> 31;
@@ -410,6 +409,8 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
 	dma_cap->vlhash = (hw_cap & XGMAC_HWFEAT_VLHASH) >> 4;
 	dma_cap->half_duplex = (hw_cap & XGMAC_HWFEAT_HDSEL) >> 3;
 	dma_cap->mbps_1000 = (hw_cap & XGMAC_HWFEAT_GMIISEL) >> 1;
+	if (dma_cap->mbps_1000 && priv->synopsys_id >= DWXGMAC_CORE_2_20)
+		dma_cap->mbps_10_100 = 1;
 
 	/* MAC HW feature 1 */
 	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE1);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 058cd9e9fd71..40d56ff66b6a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2488,6 +2488,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 	struct netdev_queue *nq = netdev_get_tx_queue(priv->dev, queue);
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
 	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[queue];
+	bool csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;
 	struct xsk_buff_pool *pool = tx_q->xsk_pool;
 	unsigned int entry = tx_q->cur_tx;
 	struct dma_desc *tx_desc = NULL;
@@ -2573,7 +2574,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		}
 
 		stmmac_prepare_tx_desc(priv, tx_desc, 1, xdp_desc.len,
-				       true, priv->mode, true, true,
+				       csum, priv->mode, true, true,
 				       xdp_desc.len);
 
 		stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
@@ -4902,6 +4903,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 {
 	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[queue];
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
+	bool csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;
 	unsigned int entry = tx_q->cur_tx;
 	struct dma_desc *tx_desc;
 	dma_addr_t dma_addr;
@@ -4953,7 +4955,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 	stmmac_set_desc_addr(priv, tx_desc, dma_addr);
 
 	stmmac_prepare_tx_desc(priv, tx_desc, 1, xdpf->len,
-			       true, priv->mode, true, true,
+			       csum, priv->mode, true, true,
 			       xdpf->len);
 
 	tx_q->tx_count_frames++;
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 807465dd4c8e..5f14799b68c5 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -712,8 +712,13 @@ void netvsc_device_remove(struct hv_device *device)
 	for (i = 0; i < net_device->num_chn; i++) {
 		/* See also vmbus_reset_channel_cb(). */
 		/* only disable enabled NAPI channel */
-		if (i < ndev->real_num_rx_queues)
+		if (i < ndev->real_num_rx_queues) {
+			netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_TX,
+					     NULL);
+			netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_RX,
+					     NULL);
 			napi_disable(&net_device->chan_table[i].napi);
+		}
 
 		netif_napi_del(&net_device->chan_table[i].napi);
 	}
@@ -1806,6 +1811,11 @@ struct netvsc_device *netvsc_device_add(struct hv_device *device,
 
 	/* Enable NAPI handler before init callbacks */
 	netif_napi_add(ndev, &net_device->chan_table[0].napi, netvsc_poll);
+	napi_enable(&net_device->chan_table[0].napi);
+	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX,
+			     &net_device->chan_table[0].napi);
+	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX,
+			     &net_device->chan_table[0].napi);
 
 	/* Open the channel */
 	device->channel->next_request_id_callback = vmbus_next_request_id;
@@ -1825,8 +1835,6 @@ struct netvsc_device *netvsc_device_add(struct hv_device *device,
 	/* Channel is opened */
 	netdev_dbg(ndev, "hv_netvsc channel opened successfully\n");
 
-	napi_enable(&net_device->chan_table[0].napi);
-
 	/* Connect with the NetVsp */
 	ret = netvsc_connect_vsp(device, net_device, device_info);
 	if (ret != 0) {
@@ -1844,12 +1852,14 @@ struct netvsc_device *netvsc_device_add(struct hv_device *device,
 
 close:
 	RCU_INIT_POINTER(net_device_ctx->nvdev, NULL);
-	napi_disable(&net_device->chan_table[0].napi);
 
 	/* Now, we can close the channel safely */
 	vmbus_close(device->channel);
 
 cleanup:
+	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX, NULL);
+	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX, NULL);
+	napi_disable(&net_device->chan_table[0].napi);
 	netif_napi_del(&net_device->chan_table[0].napi);
 
 cleanup2:
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index e457f809fe31..9a92552ee35c 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1252,13 +1252,27 @@ static void netvsc_sc_open(struct vmbus_channel *new_sc)
 	new_sc->rqstor_size = netvsc_rqstor_size(netvsc_ring_bytes);
 	new_sc->max_pkt_size = NETVSC_MAX_PKT_SIZE;
 
+	/* Enable napi before opening the vmbus channel to avoid races
+	 * as the host placing data on the host->guest ring may be left
+	 * out if napi was not enabled.
+	 */
+	napi_enable(&nvchan->napi);
+	netif_queue_set_napi(ndev, chn_index, NETDEV_QUEUE_TYPE_RX,
+			     &nvchan->napi);
+	netif_queue_set_napi(ndev, chn_index, NETDEV_QUEUE_TYPE_TX,
+			     &nvchan->napi);
+
 	ret = vmbus_open(new_sc, netvsc_ring_bytes,
 			 netvsc_ring_bytes, NULL, 0,
 			 netvsc_channel_cb, nvchan);
-	if (ret == 0)
-		napi_enable(&nvchan->napi);
-	else
+	if (ret != 0) {
 		netdev_notice(ndev, "sub channel open failed: %d\n", ret);
+		netif_queue_set_napi(ndev, chn_index, NETDEV_QUEUE_TYPE_TX,
+				     NULL);
+		netif_queue_set_napi(ndev, chn_index, NETDEV_QUEUE_TYPE_RX,
+				     NULL);
+		napi_disable(&nvchan->napi);
+	}
 
 	if (atomic_inc_return(&nvscdev->open_chn) == nvscdev->num_chn)
 		wake_up(&nvscdev->subchan_open);
diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index 58c6d47fbe04..2bfe314ef881 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -481,6 +481,7 @@ static inline void vsc8584_config_macsec_intr(struct phy_device *phydev)
 void vsc85xx_link_change_notify(struct phy_device *phydev);
 void vsc8584_config_ts_intr(struct phy_device *phydev);
 int vsc8584_ptp_init(struct phy_device *phydev);
+void vsc8584_ptp_deinit(struct phy_device *phydev);
 int vsc8584_ptp_probe_once(struct phy_device *phydev);
 int vsc8584_ptp_probe(struct phy_device *phydev);
 irqreturn_t vsc8584_handle_ts_interrupt(struct phy_device *phydev);
@@ -495,6 +496,9 @@ static inline int vsc8584_ptp_init(struct phy_device *phydev)
 {
 	return 0;
 }
+static inline void vsc8584_ptp_deinit(struct phy_device *phydev)
+{
+}
 static inline int vsc8584_ptp_probe_once(struct phy_device *phydev)
 {
 	return 0;
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 42cafa68c400..19983b206405 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -2337,9 +2337,7 @@ static int vsc85xx_probe(struct phy_device *phydev)
 
 static void vsc85xx_remove(struct phy_device *phydev)
 {
-	struct vsc8531_private *priv = phydev->priv;
-
-	skb_queue_purge(&priv->rx_skbs_list);
+	vsc8584_ptp_deinit(phydev);
 }
 
 /* Microsemi VSC85xx PHYs */
diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index 80992827a3bd..920f35f8f84e 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -1295,7 +1295,6 @@ static void vsc8584_set_input_clk_configured(struct phy_device *phydev)
 
 static int __vsc8584_init_ptp(struct phy_device *phydev)
 {
-	struct vsc8531_private *vsc8531 = phydev->priv;
 	static const u32 ltc_seq_e[] = { 0, 400000, 0, 0, 0 };
 	static const u8  ltc_seq_a[] = { 8, 6, 5, 4, 2 };
 	u32 val;
@@ -1512,17 +1511,7 @@ static int __vsc8584_init_ptp(struct phy_device *phydev)
 
 	vsc85xx_ts_eth_cmp1_sig(phydev);
 
-	vsc8531->mii_ts.rxtstamp = vsc85xx_rxtstamp;
-	vsc8531->mii_ts.txtstamp = vsc85xx_txtstamp;
-	vsc8531->mii_ts.hwtstamp = vsc85xx_hwtstamp;
-	vsc8531->mii_ts.ts_info  = vsc85xx_ts_info;
-	phydev->mii_ts = &vsc8531->mii_ts;
-
-	memcpy(&vsc8531->ptp->caps, &vsc85xx_clk_caps, sizeof(vsc85xx_clk_caps));
-
-	vsc8531->ptp->ptp_clock = ptp_clock_register(&vsc8531->ptp->caps,
-						     &phydev->mdio.dev);
-	return PTR_ERR_OR_ZERO(vsc8531->ptp->ptp_clock);
+	return 0;
 }
 
 void vsc8584_config_ts_intr(struct phy_device *phydev)
@@ -1549,6 +1538,16 @@ int vsc8584_ptp_init(struct phy_device *phydev)
 	return 0;
 }
 
+void vsc8584_ptp_deinit(struct phy_device *phydev)
+{
+	struct vsc8531_private *vsc8531 = phydev->priv;
+
+	if (vsc8531->ptp->ptp_clock) {
+		ptp_clock_unregister(vsc8531->ptp->ptp_clock);
+		skb_queue_purge(&vsc8531->rx_skbs_list);
+	}
+}
+
 irqreturn_t vsc8584_handle_ts_interrupt(struct phy_device *phydev)
 {
 	struct vsc8531_private *priv = phydev->priv;
@@ -1609,7 +1608,16 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
 
 	vsc8531->ptp->phydev = phydev;
 
-	return 0;
+	vsc8531->mii_ts.rxtstamp = vsc85xx_rxtstamp;
+	vsc8531->mii_ts.txtstamp = vsc85xx_txtstamp;
+	vsc8531->mii_ts.hwtstamp = vsc85xx_hwtstamp;
+	vsc8531->mii_ts.ts_info  = vsc85xx_ts_info;
+	phydev->mii_ts = &vsc8531->mii_ts;
+
+	memcpy(&vsc8531->ptp->caps, &vsc85xx_clk_caps, sizeof(vsc85xx_clk_caps));
+	vsc8531->ptp->ptp_clock = ptp_clock_register(&vsc8531->ptp->caps,
+						     &phydev->mdio.dev);
+	return PTR_ERR_OR_ZERO(vsc8531->ptp->ptp_clock);
 }
 
 int vsc8584_ptp_probe_once(struct phy_device *phydev)
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 7e0608f56835..0a0f0e18762b 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1355,6 +1355,9 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x2357, 0x0201, 4)},	/* TP-LINK HSUPA Modem MA180 */
 	{QMI_FIXED_INTF(0x2357, 0x9000, 4)},	/* TP-LINK MA260 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1031, 3)}, /* Telit LE910C1-EUX */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1034, 2)}, /* Telit LE910C4-WWX */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1037, 4)}, /* Telit LE910C4-WWX */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1038, 3)}, /* Telit LE910C4-WWX */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x103a, 0)}, /* Telit LE910C4-WWX */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1040, 2)},	/* Telit LE922A */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1050, 2)},	/* Telit FN980 */
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 110104a936d9..492f0354a792 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -935,10 +935,15 @@ static int of_changeset_add_prop_helper(struct of_changeset *ocs,
 		return -ENOMEM;
 
 	ret = of_changeset_add_property(ocs, np, new_pp);
-	if (ret)
+	if (ret) {
 		__of_prop_free(new_pp);
+		return ret;
+	}
 
-	return ret;
+	new_pp->next = np->deadprops;
+	np->deadprops = new_pp;
+
+	return 0;
 }
 
 /**
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 45445a1600a9..7b5d6562fe4a 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -24,6 +24,7 @@
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
 #include <linux/cma.h>
+#include <linux/dma-map-ops.h>
 
 #include "of_private.h"
 
@@ -128,13 +129,17 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
 		size = dt_mem_next_cell(dt_root_size_cells, &prop);
 
-		if (size &&
-		    early_init_dt_reserve_memory(base, size, nomap) == 0)
+		if (size && early_init_dt_reserve_memory(base, size, nomap) == 0) {
+			/* Architecture specific contiguous memory fixup. */
+			if (of_flat_dt_is_compatible(node, "shared-dma-pool") &&
+			    of_get_flat_dt_prop(node, "reusable", NULL))
+				dma_contiguous_early_fixup(base, size);
 			pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
 				uname, &base, (unsigned long)(size / SZ_1M));
-		else
+		} else {
 			pr_err("Reserved memory: failed to reserve memory for node '%s': base %pa, size %lu MiB\n",
 			       uname, &base, (unsigned long)(size / SZ_1M));
+		}
 
 		len -= t_len;
 	}
@@ -417,7 +422,10 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 		       uname, (unsigned long)(size / SZ_1M));
 		return -ENOMEM;
 	}
-
+	/* Architecture specific contiguous memory fixup. */
+	if (of_flat_dt_is_compatible(node, "shared-dma-pool") &&
+	    of_get_flat_dt_prop(node, "reusable", NULL))
+		dma_contiguous_early_fixup(base, size);
 	/* Save region in the reserved_mem array */
 	fdt_reserved_mem_save_node(node, uname, base, size);
 	return 0;
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index d40afe74ddd1..f9473b816077 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -655,6 +655,14 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 		return -ETIMEDOUT;
 	}
 
+	/*
+	 * As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link
+	 * speeds greater than 5.0 GT/s, software must wait a minimum of 100 ms
+	 * after Link training completes before sending a Configuration Request.
+	 */
+	if (pci->max_link_speed > 2)
+		msleep(PCIE_RESET_CONFIG_WAIT_MS);
+
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
 
diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index 0564fdce47c2..0a0b5a7d84d7 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -368,7 +368,7 @@ static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
 	 * of 100ms following exit from a conventional reset before
 	 * sending a configuration request to the device.
 	 */
-	msleep(PCIE_RESET_CONFIG_DEVICE_WAIT_MS);
+	msleep(PCIE_RESET_CONFIG_WAIT_MS);
 
 	if (starfive_pcie_host_wait_for_link(pcie))
 		dev_info(dev, "port link down\n");
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b65868e70951..c951f861a69b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -57,7 +57,7 @@
  *    completes before sending a Configuration Request to the device
  *    immediately below that Port."
  */
-#define PCIE_RESET_CONFIG_DEVICE_WAIT_MS	100
+#define PCIE_RESET_CONFIG_WAIT_MS	100
 
 /* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
 #define PCIE_MSG_TYPE_R_RC	0
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 354536de564b..e05174e5efbc 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -504,6 +504,7 @@ config PINCTRL_STMFX
 	tristate "STMicroelectronics STMFX GPIO expander pinctrl driver"
 	depends on I2C
 	depends on OF_GPIO
+	depends on HAS_IOMEM
 	select GENERIC_PINCONF
 	select GPIOLIB_IRQCHIP
 	select MFD_STMFX
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 32f94db6d6bf..e669768a7a5b 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -265,7 +265,7 @@ show_shost_supported_mode(struct device *dev, struct device_attribute *attr,
 	return show_shost_mode(supported_mode, buf);
 }
 
-static DEVICE_ATTR(supported_mode, S_IRUGO | S_IWUSR, show_shost_supported_mode, NULL);
+static DEVICE_ATTR(supported_mode, S_IRUGO, show_shost_supported_mode, NULL);
 
 static ssize_t
 show_shost_active_mode(struct device *dev,
@@ -279,7 +279,7 @@ show_shost_active_mode(struct device *dev,
 		return show_shost_mode(shost->active_mode, buf);
 }
 
-static DEVICE_ATTR(active_mode, S_IRUGO | S_IWUSR, show_shost_active_mode, NULL);
+static DEVICE_ATTR(active_mode, S_IRUGO, show_shost_active_mode, NULL);
 
 static int check_reset_type(const char *str)
 {
diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index ae063d1bc95f..017191b9f864 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -121,7 +121,11 @@ struct lvts_ctrl_data {
 
 struct lvts_data {
 	const struct lvts_ctrl_data *lvts_ctrl;
+	const u32 *conn_cmd;
+	const u32 *init_cmd;
 	int num_lvts_ctrl;
+	int num_conn_cmd;
+	int num_init_cmd;
 	int temp_factor;
 	int temp_offset;
 	int gt_calib_bit_offset;
@@ -880,7 +884,7 @@ static void lvts_ctrl_monitor_enable(struct device *dev, struct lvts_ctrl *lvts_
  * each write in the configuration register must be separated by a
  * delay of 2 us.
  */
-static void lvts_write_config(struct lvts_ctrl *lvts_ctrl, u32 *cmds, int nr_cmds)
+static void lvts_write_config(struct lvts_ctrl *lvts_ctrl, const u32 *cmds, int nr_cmds)
 {
 	int i;
 
@@ -963,9 +967,10 @@ static int lvts_ctrl_set_enable(struct lvts_ctrl *lvts_ctrl, int enable)
 
 static int lvts_ctrl_connect(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 {
-	u32 id, cmds[] = { 0xC103FFFF, 0xC502FF55 };
+	const struct lvts_data *lvts_data = lvts_ctrl->lvts_data;
+	u32 id;
 
-	lvts_write_config(lvts_ctrl, cmds, ARRAY_SIZE(cmds));
+	lvts_write_config(lvts_ctrl, lvts_data->conn_cmd, lvts_data->num_conn_cmd);
 
 	/*
 	 * LVTS_ID : Get ID and status of the thermal controller
@@ -984,17 +989,9 @@ static int lvts_ctrl_connect(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 
 static int lvts_ctrl_initialize(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 {
-	/*
-	 * Write device mask: 0xC1030000
-	 */
-	u32 cmds[] = {
-		0xC1030E01, 0xC1030CFC, 0xC1030A8C, 0xC103098D, 0xC10308F1,
-		0xC10307A6, 0xC10306B8, 0xC1030500, 0xC1030420, 0xC1030300,
-		0xC1030030, 0xC10300F6, 0xC1030050, 0xC1030060, 0xC10300AC,
-		0xC10300FC, 0xC103009D, 0xC10300F1, 0xC10300E1
-	};
+	const struct lvts_data *lvts_data = lvts_ctrl->lvts_data;
 
-	lvts_write_config(lvts_ctrl, cmds, ARRAY_SIZE(cmds));
+	lvts_write_config(lvts_ctrl, lvts_data->init_cmd, lvts_data->num_init_cmd);
 
 	return 0;
 }
@@ -1423,6 +1420,25 @@ static int lvts_resume(struct device *dev)
 	return 0;
 }
 
+static const u32 default_conn_cmds[] = { 0xC103FFFF, 0xC502FF55 };
+static const u32 mt7988_conn_cmds[] = { 0xC103FFFF, 0xC502FC55 };
+
+/*
+ * Write device mask: 0xC1030000
+ */
+static const u32 default_init_cmds[] = {
+	0xC1030E01, 0xC1030CFC, 0xC1030A8C, 0xC103098D, 0xC10308F1,
+	0xC10307A6, 0xC10306B8, 0xC1030500, 0xC1030420, 0xC1030300,
+	0xC1030030, 0xC10300F6, 0xC1030050, 0xC1030060, 0xC10300AC,
+	0xC10300FC, 0xC103009D, 0xC10300F1, 0xC10300E1
+};
+
+static const u32 mt7988_init_cmds[] = {
+	0xC1030300, 0xC1030420, 0xC1030500, 0xC10307A6, 0xC1030CFC,
+	0xC1030A8C, 0xC103098D, 0xC10308F1, 0xC1030B04, 0xC1030E01,
+	0xC10306B8
+};
+
 /*
  * The MT8186 calibration data is stored as packed 3-byte little-endian
  * values using a weird layout that makes sense only when viewed as a 32-bit
@@ -1717,7 +1733,11 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 
 static const struct lvts_data mt7988_lvts_ap_data = {
 	.lvts_ctrl	= mt7988_lvts_ap_data_ctrl,
+	.conn_cmd	= mt7988_conn_cmds,
+	.init_cmd	= mt7988_init_cmds,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt7988_lvts_ap_data_ctrl),
+	.num_conn_cmd	= ARRAY_SIZE(mt7988_conn_cmds),
+	.num_init_cmd	= ARRAY_SIZE(mt7988_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT7988,
 	.temp_offset	= LVTS_COEFF_B_MT7988,
 	.gt_calib_bit_offset = 24,
@@ -1725,7 +1745,11 @@ static const struct lvts_data mt7988_lvts_ap_data = {
 
 static const struct lvts_data mt8186_lvts_data = {
 	.lvts_ctrl	= mt8186_lvts_data_ctrl,
+	.conn_cmd	= default_conn_cmds,
+	.init_cmd	= default_init_cmds,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8186_lvts_data_ctrl),
+	.num_conn_cmd	= ARRAY_SIZE(default_conn_cmds),
+	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT7988,
 	.temp_offset	= LVTS_COEFF_B_MT7988,
 	.gt_calib_bit_offset = 24,
@@ -1734,7 +1758,11 @@ static const struct lvts_data mt8186_lvts_data = {
 
 static const struct lvts_data mt8188_lvts_mcu_data = {
 	.lvts_ctrl	= mt8188_lvts_mcu_data_ctrl,
+	.conn_cmd	= default_conn_cmds,
+	.init_cmd	= default_init_cmds,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8188_lvts_mcu_data_ctrl),
+	.num_conn_cmd	= ARRAY_SIZE(default_conn_cmds),
+	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 20,
@@ -1743,7 +1771,11 @@ static const struct lvts_data mt8188_lvts_mcu_data = {
 
 static const struct lvts_data mt8188_lvts_ap_data = {
 	.lvts_ctrl	= mt8188_lvts_ap_data_ctrl,
+	.conn_cmd	= default_conn_cmds,
+	.init_cmd	= default_init_cmds,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8188_lvts_ap_data_ctrl),
+	.num_conn_cmd	= ARRAY_SIZE(default_conn_cmds),
+	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 20,
@@ -1752,7 +1784,11 @@ static const struct lvts_data mt8188_lvts_ap_data = {
 
 static const struct lvts_data mt8192_lvts_mcu_data = {
 	.lvts_ctrl	= mt8192_lvts_mcu_data_ctrl,
+	.conn_cmd	= default_conn_cmds,
+	.init_cmd	= default_init_cmds,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
+	.num_conn_cmd	= ARRAY_SIZE(default_conn_cmds),
+	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
@@ -1761,7 +1797,11 @@ static const struct lvts_data mt8192_lvts_mcu_data = {
 
 static const struct lvts_data mt8192_lvts_ap_data = {
 	.lvts_ctrl	= mt8192_lvts_ap_data_ctrl,
+	.conn_cmd	= default_conn_cmds,
+	.init_cmd	= default_init_cmds,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_ap_data_ctrl),
+	.num_conn_cmd	= ARRAY_SIZE(default_conn_cmds),
+	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
@@ -1770,7 +1810,11 @@ static const struct lvts_data mt8192_lvts_ap_data = {
 
 static const struct lvts_data mt8195_lvts_mcu_data = {
 	.lvts_ctrl	= mt8195_lvts_mcu_data_ctrl,
+	.conn_cmd	= default_conn_cmds,
+	.init_cmd	= default_init_cmds,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_mcu_data_ctrl),
+	.num_conn_cmd	= ARRAY_SIZE(default_conn_cmds),
+	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
@@ -1779,7 +1823,11 @@ static const struct lvts_data mt8195_lvts_mcu_data = {
 
 static const struct lvts_data mt8195_lvts_ap_data = {
 	.lvts_ctrl	= mt8195_lvts_ap_data_ctrl,
+	.conn_cmd	= default_conn_cmds,
+	.init_cmd	= default_init_cmds,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_ap_data_ctrl),
+	.num_conn_cmd	= ARRAY_SIZE(default_conn_cmds),
+	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index f16279351db5..aff4ec783562 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -96,6 +96,7 @@ struct vhost_net_ubuf_ref {
 	atomic_t refcount;
 	wait_queue_head_t wait;
 	struct vhost_virtqueue *vq;
+	struct rcu_head rcu;
 };
 
 #define VHOST_NET_BATCH 64
@@ -247,9 +248,13 @@ vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool zcopy)
 
 static int vhost_net_ubuf_put(struct vhost_net_ubuf_ref *ubufs)
 {
-	int r = atomic_sub_return(1, &ubufs->refcount);
+	int r;
+
+	rcu_read_lock();
+	r = atomic_sub_return(1, &ubufs->refcount);
 	if (unlikely(!r))
 		wake_up(&ubufs->wait);
+	rcu_read_unlock();
 	return r;
 }
 
@@ -262,7 +267,7 @@ static void vhost_net_ubuf_put_and_wait(struct vhost_net_ubuf_ref *ubufs)
 static void vhost_net_ubuf_put_wait_and_free(struct vhost_net_ubuf_ref *ubufs)
 {
 	vhost_net_ubuf_put_and_wait(ubufs);
-	kfree(ubufs);
+	kfree_rcu(ubufs, rcu);
 }
 
 static void vhost_net_clear_ubuf_info(struct vhost_net *n)
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 11ebddc57bc7..1831e015b2f2 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -127,6 +127,10 @@ static int efivarfs_d_compare(const struct dentry *dentry,
 {
 	int guid = len - EFI_VARIABLE_GUID_LEN;
 
+	/* Parallel lookups may produce a temporary invalid filename */
+	if (guid <= 0)
+		return 1;
+
 	if (name->len != len)
 		return 1;
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index f35d2eb0ed11..63acd91d15aa 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1410,6 +1410,16 @@ static void z_erofs_decompressqueue_kthread_work(struct kthread_work *work)
 }
 #endif
 
+/* Use (kthread_)work in atomic contexts to minimize scheduling overhead */
+static inline bool z_erofs_in_atomic(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
+		return true;
+	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
+		return true;
+	return !preemptible();
+}
+
 static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 				       int bios)
 {
@@ -1424,8 +1434,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 
 	if (atomic_add_return(bios, &io->pending_bios))
 		return;
-	/* Use (kthread_)work and sync decompression for atomic contexts only */
-	if (!in_task() || irqs_disabled() || rcu_read_lock_any_held()) {
+	if (z_erofs_in_atomic()) {
 #ifdef CONFIG_EROFS_FS_PCPU_KTHREAD
 		struct kthread_worker *worker;
 
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 9d96b833015c..64dc7ec045d8 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1348,6 +1348,20 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 			truncate_setsize(target_inode, new_size);
 			fscache_resize_cookie(cifs_inode_cookie(target_inode),
 					      new_size);
+		} else if (rc == -EOPNOTSUPP) {
+			/*
+			 * copy_file_range syscall man page indicates EINVAL
+			 * is returned e.g when "fd_in and fd_out refer to the
+			 * same file and the source and target ranges overlap."
+			 * Test generic/157 was what showed these cases where
+			 * we need to remap EOPNOTSUPP to EINVAL
+			 */
+			if (off >= src_inode->i_size) {
+				rc = -EINVAL;
+			} else if (src_inode == target_inode) {
+				if (off + len > destoff)
+					rc = -EINVAL;
+			}
 		}
 		if (rc == 0 && new_size > target_cifsi->netfs.zero_point)
 			target_cifsi->netfs.zero_point = new_size;
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 31fce0a1b571..c0df2c184124 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1917,15 +1917,24 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct tcon_link *tlink;
 	struct cifs_tcon *tcon;
+	__u32 dosattr = 0, origattr = 0;
 	struct TCP_Server_Info *server;
 	struct iattr *attrs = NULL;
-	__u32 dosattr = 0, origattr = 0;
+	bool rehash = false;
 
 	cifs_dbg(FYI, "cifs_unlink, dir=0x%p, dentry=0x%p\n", dir, dentry);
 
 	if (unlikely(cifs_forced_shutdown(cifs_sb)))
 		return -EIO;
 
+	/* Unhash dentry in advance to prevent any concurrent opens */
+	spin_lock(&dentry->d_lock);
+	if (!d_unhashed(dentry)) {
+		__d_drop(dentry);
+		rehash = true;
+	}
+	spin_unlock(&dentry->d_lock);
+
 	tlink = cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink))
 		return PTR_ERR(tlink);
@@ -1977,7 +1986,8 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 			cifs_drop_nlink(inode);
 		}
 	} else if (rc == -ENOENT) {
-		d_drop(dentry);
+		if (simple_positive(dentry))
+			d_delete(dentry);
 	} else if (rc == -EBUSY) {
 		if (server->ops->rename_pending_delete) {
 			rc = server->ops->rename_pending_delete(full_path,
@@ -2030,6 +2040,8 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 	kfree(attrs);
 	free_xid(xid);
 	cifs_put_tlink(tlink);
+	if (rehash)
+		d_rehash(dentry);
 	return rc;
 }
 
@@ -2429,6 +2441,7 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
 	struct cifs_sb_info *cifs_sb;
 	struct tcon_link *tlink;
 	struct cifs_tcon *tcon;
+	bool rehash = false;
 	unsigned int xid;
 	int rc, tmprc;
 	int retry_count = 0;
@@ -2444,6 +2457,17 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
 	if (unlikely(cifs_forced_shutdown(cifs_sb)))
 		return -EIO;
 
+	/*
+	 * Prevent any concurrent opens on the target by unhashing the dentry.
+	 * VFS already unhashes the target when renaming directories.
+	 */
+	if (d_is_positive(target_dentry) && !d_is_dir(target_dentry)) {
+		if (!d_unhashed(target_dentry)) {
+			d_drop(target_dentry);
+			rehash = true;
+		}
+	}
+
 	tlink = cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink))
 		return PTR_ERR(tlink);
@@ -2485,6 +2509,8 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
 		}
 	}
 
+	if (!rc)
+		rehash = false;
 	/*
 	 * No-replace is the natural behavior for CIFS, so skip unlink hacks.
 	 */
@@ -2543,12 +2569,16 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
 			goto cifs_rename_exit;
 		rc = cifs_do_rename(xid, source_dentry, from_name,
 				    target_dentry, to_name);
+		if (!rc)
+			rehash = false;
 	}
 
 	/* force revalidate to go get info when needed */
 	CIFS_I(source_dir)->time = CIFS_I(target_dir)->time = 0;
 
 cifs_rename_exit:
+	if (rehash)
+		d_rehash(target_dentry);
 	kfree(info_buf_source);
 	free_dentry_path(page2);
 	free_dentry_path(page1);
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 6048b3fed3e7..b51ccfb88439 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -206,8 +206,10 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 	server = cifs_pick_channel(ses);
 
 	vars = kzalloc(sizeof(*vars), GFP_ATOMIC);
-	if (vars == NULL)
-		return -ENOMEM;
+	if (vars == NULL) {
+		rc = -ENOMEM;
+		goto out;
+	}
 	rqst = &vars->rqst[0];
 	rsp_iov = &vars->rsp_iov[0];
 
@@ -832,6 +834,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 	    smb2_should_replay(tcon, &retries, &cur_sleep))
 		goto replay_again;
 
+out:
 	if (cfile)
 		cifsFileInfo_put(cfile);
 
diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index 4c44ce1c8a64..bff3dc226f81 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -435,6 +435,13 @@ xfs_attr_rmtval_get(
 					0, &bp, &xfs_attr3_rmt_buf_ops);
 			if (xfs_metadata_is_sick(error))
 				xfs_dirattr_mark_sick(args->dp, XFS_ATTR_FORK);
+			/*
+			 * ENODATA from disk implies a disk medium failure;
+			 * ENODATA for xattrs means attribute not found, so
+			 * disambiguate that here.
+			 */
+			if (error == -ENODATA)
+				error = -EIO;
 			if (error)
 				return error;
 
diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index 17d9e6154f19..723a0643b838 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -2833,6 +2833,12 @@ xfs_da_read_buf(
 			&bp, ops);
 	if (xfs_metadata_is_sick(error))
 		xfs_dirattr_mark_sick(dp, whichfork);
+	/*
+	 * ENODATA from disk implies a disk medium failure; ENODATA for
+	 * xattrs means attribute not found, so disambiguate that here.
+	 */
+	if (error == -ENODATA && whichfork == XFS_ATTR_FORK)
+		error = -EIO;
 	if (error)
 		goto out_free;
 
diff --git a/include/linux/atmdev.h b/include/linux/atmdev.h
index 45f2f278b50a..70807c679f1a 100644
--- a/include/linux/atmdev.h
+++ b/include/linux/atmdev.h
@@ -185,6 +185,7 @@ struct atmdev_ops { /* only send is required */
 	int (*compat_ioctl)(struct atm_dev *dev,unsigned int cmd,
 			    void __user *arg);
 #endif
+	int (*pre_send)(struct atm_vcc *vcc, struct sk_buff *skb);
 	int (*send)(struct atm_vcc *vcc,struct sk_buff *skb);
 	int (*send_bh)(struct atm_vcc *vcc, struct sk_buff *skb);
 	int (*send_oam)(struct atm_vcc *vcc,void *cell,int flags);
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index b7773201414c..b42408a24ad1 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -153,6 +153,9 @@ static inline void dma_free_contiguous(struct device *dev, struct page *page,
 {
 	__free_pages(page, get_order(size));
 }
+static inline void dma_contiguous_early_fixup(phys_addr_t base, unsigned long size)
+{
+}
 #endif /* CONFIG_DMA_CMA*/
 
 #ifdef CONFIG_DMA_DECLARE_COHERENT
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index dbabc17b30cd..17e5112f7840 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -93,7 +93,7 @@ int hci_update_class_sync(struct hci_dev *hdev);
 
 int hci_update_eir_sync(struct hci_dev *hdev);
 int hci_update_class_sync(struct hci_dev *hdev);
-int hci_update_name_sync(struct hci_dev *hdev);
+int hci_update_name_sync(struct hci_dev *hdev, const u8 *name);
 int hci_write_ssp_mode_sync(struct hci_dev *hdev, u8 mode);
 
 int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
diff --git a/include/net/rose.h b/include/net/rose.h
index 23267b4efcfa..2b5491bbf39a 100644
--- a/include/net/rose.h
+++ b/include/net/rose.h
@@ -8,6 +8,7 @@
 #ifndef _ROSE_H
 #define _ROSE_H 
 
+#include <linux/refcount.h>
 #include <linux/rose.h>
 #include <net/ax25.h>
 #include <net/sock.h>
@@ -96,7 +97,7 @@ struct rose_neigh {
 	ax25_cb			*ax25;
 	struct net_device		*dev;
 	unsigned short		count;
-	unsigned short		use;
+	refcount_t		use;
 	unsigned int		number;
 	char			restarted;
 	char			dce_mode;
@@ -151,6 +152,21 @@ struct rose_sock {
 
 #define rose_sk(sk) ((struct rose_sock *)(sk))
 
+static inline void rose_neigh_hold(struct rose_neigh *rose_neigh)
+{
+	refcount_inc(&rose_neigh->use);
+}
+
+static inline void rose_neigh_put(struct rose_neigh *rose_neigh)
+{
+	if (refcount_dec_and_test(&rose_neigh->use)) {
+		if (rose_neigh->ax25)
+			ax25_cb_put(rose_neigh->ax25);
+		kfree(rose_neigh->digipeat);
+		kfree(rose_neigh);
+	}
+}
+
 /* af_rose.c */
 extern ax25_address rose_callsign;
 extern int  sysctl_rose_restart_request_timeout;
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 1c7e7035fc49..96b178f1bd5c 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -254,7 +254,7 @@
  * When fork_owner is set to VHOST_FORK_OWNER_KTHREAD:
  *   - Vhost will create vhost workers as kernel threads.
  */
-#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
+#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x84, __u8)
 
 /**
  * VHOST_GET_FORK_OWNER - Get the current fork_owner flag for the vhost device.
@@ -262,6 +262,6 @@
  *
  * @return: An 8-bit value indicating the current thread mode.
  */
-#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x84, __u8)
+#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x85, __u8)
 
 #endif
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 8df0dfaaca18..9e5d63efe7c5 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -480,8 +480,6 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 		pr_err("Reserved memory: unable to setup CMA region\n");
 		return err;
 	}
-	/* Architecture specific contiguous memory fixup. */
-	dma_contiguous_early_fixup(rmem->base, rmem->size);
 
 	if (default_cma)
 		dma_contiguous_default_area = cma;
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 7b04f7575796..ee45dee33d49 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -102,8 +102,8 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 
 #ifdef CONFIG_DMA_DIRECT_REMAP
 	addr = dma_common_contiguous_remap(page, pool_size,
-					   pgprot_dmacoherent(PAGE_KERNEL),
-					   __builtin_return_address(0));
+			pgprot_decrypted(pgprot_dmacoherent(PAGE_KERNEL)),
+			__builtin_return_address(0));
 	if (!addr)
 		goto free_page;
 #else
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index c12335499ec9..2eed8bc672f9 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1316,6 +1316,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		ftrace_graph_active--;
 		gops->saved_func = NULL;
 		fgraph_lru_release_index(i);
+		unregister_pm_notifier(&ftrace_suspend_notifier);
 	}
 	return ret;
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2f662ca4d3ff..ba3358eef34b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10130,10 +10130,10 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
 			ret = print_trace_line(&iter);
 			if (ret != TRACE_TYPE_NO_CONSUME)
 				trace_consume(&iter);
+
+			trace_printk_seq(&iter.seq);
 		}
 		touch_nmi_watchdog();
-
-		trace_printk_seq(&iter.seq);
 	}
 
 	if (!cnt)
diff --git a/net/atm/common.c b/net/atm/common.c
index d7f7976ea13a..881c7f259dbd 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -635,18 +635,27 @@ int vcc_sendmsg(struct socket *sock, struct msghdr *m, size_t size)
 
 	skb->dev = NULL; /* for paths shared with net_device interfaces */
 	if (!copy_from_iter_full(skb_put(skb, size), size, &m->msg_iter)) {
-		atm_return_tx(vcc, skb);
-		kfree_skb(skb);
 		error = -EFAULT;
-		goto out;
+		goto free_skb;
 	}
 	if (eff != size)
 		memset(skb->data + size, 0, eff-size);
+
+	if (vcc->dev->ops->pre_send) {
+		error = vcc->dev->ops->pre_send(vcc, skb);
+		if (error)
+			goto free_skb;
+	}
+
 	error = vcc->dev->ops->send(vcc, skb);
 	error = error ? error : size;
 out:
 	release_sock(sk);
 	return error;
+free_skb:
+	atm_return_tx(vcc, skb);
+	kfree_skb(skb);
+	goto out;
 }
 
 __poll_t vcc_poll(struct file *file, struct socket *sock, poll_table *wait)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 768bd5fd808f..262ff30261d6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2694,7 +2694,7 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 	if (!conn)
 		goto unlock;
 
-	if (status) {
+	if (status && status != HCI_ERROR_UNKNOWN_CONN_ID) {
 		mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
 				       conn->dst_type, status);
 
@@ -2709,6 +2709,12 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 		goto done;
 	}
 
+	/* During suspend, mark connection as closed immediately
+	 * since we might not receive HCI_EV_DISCONN_COMPLETE
+	 */
+	if (hdev->suspended)
+		conn->state = BT_CLOSED;
+
 	mgmt_conn = test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags);
 
 	if (conn->type == ACL_LINK) {
@@ -4389,7 +4395,17 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 		if (!conn)
 			continue;
 
-		conn->sent -= count;
+		/* Check if there is really enough packets outstanding before
+		 * attempting to decrease the sent counter otherwise it could
+		 * underflow..
+		 */
+		if (conn->sent >= count) {
+			conn->sent -= count;
+		} else {
+			bt_dev_warn(hdev, "hcon %p sent %u < count %u",
+				    conn, conn->sent, count);
+			conn->sent = 0;
+		}
 
 		switch (conn->type) {
 		case ACL_LINK:
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index af86df9de941..bc2aa514b8c5 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3491,13 +3491,13 @@ int hci_update_scan_sync(struct hci_dev *hdev)
 	return hci_write_scan_enable_sync(hdev, scan);
 }
 
-int hci_update_name_sync(struct hci_dev *hdev)
+int hci_update_name_sync(struct hci_dev *hdev, const u8 *name)
 {
 	struct hci_cp_write_local_name cp;
 
 	memset(&cp, 0, sizeof(cp));
 
-	memcpy(cp.name, hdev->dev_name, sizeof(cp.name));
+	memcpy(cp.name, name, sizeof(cp.name));
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_WRITE_LOCAL_NAME,
 					    sizeof(cp), &cp,
@@ -3550,7 +3550,7 @@ int hci_powered_update_sync(struct hci_dev *hdev)
 			hci_write_fast_connectable_sync(hdev, false);
 		hci_update_scan_sync(hdev);
 		hci_update_class_sync(hdev);
-		hci_update_name_sync(hdev);
+		hci_update_name_sync(hdev, hdev->dev_name);
 		hci_update_eir_sync(hdev);
 	}
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ade93532db34..8b75647076ba 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3826,8 +3826,11 @@ static void set_name_complete(struct hci_dev *hdev, void *data, int err)
 
 static int set_name_sync(struct hci_dev *hdev, void *data)
 {
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_set_local_name *cp = cmd->param;
+
 	if (lmp_bredr_capable(hdev)) {
-		hci_update_name_sync(hdev);
+		hci_update_name_sync(hdev, cp->name);
 		hci_update_eir_sync(hdev);
 	}
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 9a5c9497b393..261ddb6542a4 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2532,12 +2532,16 @@ static struct rtable *__mkroute_output(const struct fib_result *res,
 		    !netif_is_l3_master(dev_out))
 			return ERR_PTR(-EINVAL);
 
-	if (ipv4_is_lbcast(fl4->daddr))
+	if (ipv4_is_lbcast(fl4->daddr)) {
 		type = RTN_BROADCAST;
-	else if (ipv4_is_multicast(fl4->daddr))
+
+		/* reset fi to prevent gateway resolution */
+		fi = NULL;
+	} else if (ipv4_is_multicast(fl4->daddr)) {
 		type = RTN_MULTICAST;
-	else if (ipv4_is_zeronet(fl4->daddr))
+	} else if (ipv4_is_zeronet(fl4->daddr)) {
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (dev_out->flags & IFF_LOOPBACK)
 		flags |= RTCF_LOCAL;
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 53baf2dd5d5d..16c514f628ea 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -129,22 +129,12 @@ static const struct ppp_channel_ops pppol2tp_chan_ops = {
 
 static const struct proto_ops pppol2tp_ops;
 
-/* Retrieves the pppol2tp socket associated to a session.
- * A reference is held on the returned socket, so this function must be paired
- * with sock_put().
- */
+/* Retrieves the pppol2tp socket associated to a session. */
 static struct sock *pppol2tp_session_get_sock(struct l2tp_session *session)
 {
 	struct pppol2tp_session *ps = l2tp_session_priv(session);
-	struct sock *sk;
-
-	rcu_read_lock();
-	sk = rcu_dereference(ps->sk);
-	if (sk)
-		sock_hold(sk);
-	rcu_read_unlock();
 
-	return sk;
+	return rcu_dereference(ps->sk);
 }
 
 /* Helpers to obtain tunnel/session contexts from sockets.
@@ -206,14 +196,13 @@ static int pppol2tp_recvmsg(struct socket *sock, struct msghdr *msg,
 
 static void pppol2tp_recv(struct l2tp_session *session, struct sk_buff *skb, int data_len)
 {
-	struct pppol2tp_session *ps = l2tp_session_priv(session);
-	struct sock *sk = NULL;
+	struct sock *sk;
 
 	/* If the socket is bound, send it in to PPP's input queue. Otherwise
 	 * queue it on the session socket.
 	 */
 	rcu_read_lock();
-	sk = rcu_dereference(ps->sk);
+	sk = pppol2tp_session_get_sock(session);
 	if (!sk)
 		goto no_sock;
 
@@ -510,13 +499,14 @@ static void pppol2tp_show(struct seq_file *m, void *arg)
 	struct l2tp_session *session = arg;
 	struct sock *sk;
 
+	rcu_read_lock();
 	sk = pppol2tp_session_get_sock(session);
 	if (sk) {
 		struct pppox_sock *po = pppox_sk(sk);
 
 		seq_printf(m, "   interface %s\n", ppp_dev_name(&po->chan));
-		sock_put(sk);
 	}
+	rcu_read_unlock();
 }
 
 static void pppol2tp_session_init(struct l2tp_session *session)
@@ -1529,6 +1519,7 @@ static void pppol2tp_seq_session_show(struct seq_file *m, void *v)
 		port = ntohs(inet->inet_sport);
 	}
 
+	rcu_read_lock();
 	sk = pppol2tp_session_get_sock(session);
 	if (sk) {
 		state = sk->sk_state;
@@ -1564,8 +1555,8 @@ static void pppol2tp_seq_session_show(struct seq_file *m, void *v)
 		struct pppox_sock *po = pppox_sk(sk);
 
 		seq_printf(m, "   interface %s\n", ppp_dev_name(&po->chan));
-		sock_put(sk);
 	}
+	rcu_read_unlock();
 }
 
 static int pppol2tp_seq_show(struct seq_file *m, void *v)
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index a4a668b88a8f..b8078b42f5de 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -170,7 +170,7 @@ void rose_kill_by_neigh(struct rose_neigh *neigh)
 
 		if (rose->neighbour == neigh) {
 			rose_disconnect(s, ENETUNREACH, ROSE_OUT_OF_ORDER, 0);
-			rose->neighbour->use--;
+			rose_neigh_put(rose->neighbour);
 			rose->neighbour = NULL;
 		}
 	}
@@ -212,7 +212,7 @@ static void rose_kill_by_device(struct net_device *dev)
 		if (rose->device == dev) {
 			rose_disconnect(sk, ENETUNREACH, ROSE_OUT_OF_ORDER, 0);
 			if (rose->neighbour)
-				rose->neighbour->use--;
+				rose_neigh_put(rose->neighbour);
 			netdev_put(rose->device, &rose->dev_tracker);
 			rose->device = NULL;
 		}
@@ -655,7 +655,7 @@ static int rose_release(struct socket *sock)
 		break;
 
 	case ROSE_STATE_2:
-		rose->neighbour->use--;
+		rose_neigh_put(rose->neighbour);
 		release_sock(sk);
 		rose_disconnect(sk, 0, -1, -1);
 		lock_sock(sk);
@@ -823,6 +823,7 @@ static int rose_connect(struct socket *sock, struct sockaddr *uaddr, int addr_le
 	rose->lci = rose_new_lci(rose->neighbour);
 	if (!rose->lci) {
 		err = -ENETUNREACH;
+		rose_neigh_put(rose->neighbour);
 		goto out_release;
 	}
 
@@ -834,12 +835,14 @@ static int rose_connect(struct socket *sock, struct sockaddr *uaddr, int addr_le
 		dev = rose_dev_first();
 		if (!dev) {
 			err = -ENETUNREACH;
+			rose_neigh_put(rose->neighbour);
 			goto out_release;
 		}
 
 		user = ax25_findbyuid(current_euid());
 		if (!user) {
 			err = -EINVAL;
+			rose_neigh_put(rose->neighbour);
 			dev_put(dev);
 			goto out_release;
 		}
@@ -874,8 +877,6 @@ static int rose_connect(struct socket *sock, struct sockaddr *uaddr, int addr_le
 
 	rose->state = ROSE_STATE_1;
 
-	rose->neighbour->use++;
-
 	rose_write_internal(sk, ROSE_CALL_REQUEST);
 	rose_start_heartbeat(sk);
 	rose_start_t1timer(sk);
@@ -1077,7 +1078,7 @@ int rose_rx_call_request(struct sk_buff *skb, struct net_device *dev, struct ros
 			     GFP_ATOMIC);
 	make_rose->facilities    = facilities;
 
-	make_rose->neighbour->use++;
+	rose_neigh_hold(make_rose->neighbour);
 
 	if (rose_sk(sk)->defer) {
 		make_rose->state = ROSE_STATE_5;
diff --git a/net/rose/rose_in.c b/net/rose/rose_in.c
index 4d67f36dce1b..7caae93937ee 100644
--- a/net/rose/rose_in.c
+++ b/net/rose/rose_in.c
@@ -56,7 +56,7 @@ static int rose_state1_machine(struct sock *sk, struct sk_buff *skb, int framety
 	case ROSE_CLEAR_REQUEST:
 		rose_write_internal(sk, ROSE_CLEAR_CONFIRMATION);
 		rose_disconnect(sk, ECONNREFUSED, skb->data[3], skb->data[4]);
-		rose->neighbour->use--;
+		rose_neigh_put(rose->neighbour);
 		break;
 
 	default:
@@ -79,12 +79,12 @@ static int rose_state2_machine(struct sock *sk, struct sk_buff *skb, int framety
 	case ROSE_CLEAR_REQUEST:
 		rose_write_internal(sk, ROSE_CLEAR_CONFIRMATION);
 		rose_disconnect(sk, 0, skb->data[3], skb->data[4]);
-		rose->neighbour->use--;
+		rose_neigh_put(rose->neighbour);
 		break;
 
 	case ROSE_CLEAR_CONFIRMATION:
 		rose_disconnect(sk, 0, -1, -1);
-		rose->neighbour->use--;
+		rose_neigh_put(rose->neighbour);
 		break;
 
 	default:
@@ -120,7 +120,7 @@ static int rose_state3_machine(struct sock *sk, struct sk_buff *skb, int framety
 	case ROSE_CLEAR_REQUEST:
 		rose_write_internal(sk, ROSE_CLEAR_CONFIRMATION);
 		rose_disconnect(sk, 0, skb->data[3], skb->data[4]);
-		rose->neighbour->use--;
+		rose_neigh_put(rose->neighbour);
 		break;
 
 	case ROSE_RR:
@@ -233,7 +233,7 @@ static int rose_state4_machine(struct sock *sk, struct sk_buff *skb, int framety
 	case ROSE_CLEAR_REQUEST:
 		rose_write_internal(sk, ROSE_CLEAR_CONFIRMATION);
 		rose_disconnect(sk, 0, skb->data[3], skb->data[4]);
-		rose->neighbour->use--;
+		rose_neigh_put(rose->neighbour);
 		break;
 
 	default:
@@ -253,7 +253,7 @@ static int rose_state5_machine(struct sock *sk, struct sk_buff *skb, int framety
 	if (frametype == ROSE_CLEAR_REQUEST) {
 		rose_write_internal(sk, ROSE_CLEAR_CONFIRMATION);
 		rose_disconnect(sk, 0, skb->data[3], skb->data[4]);
-		rose_sk(sk)->neighbour->use--;
+		rose_neigh_put(rose_sk(sk)->neighbour);
 	}
 
 	return 0;
diff --git a/net/rose/rose_route.c b/net/rose/rose_route.c
index a7054546f52d..28746ae5a258 100644
--- a/net/rose/rose_route.c
+++ b/net/rose/rose_route.c
@@ -93,11 +93,11 @@ static int __must_check rose_add_node(struct rose_route_struct *rose_route,
 		rose_neigh->ax25      = NULL;
 		rose_neigh->dev       = dev;
 		rose_neigh->count     = 0;
-		rose_neigh->use       = 0;
 		rose_neigh->dce_mode  = 0;
 		rose_neigh->loopback  = 0;
 		rose_neigh->number    = rose_neigh_no++;
 		rose_neigh->restarted = 0;
+		refcount_set(&rose_neigh->use, 1);
 
 		skb_queue_head_init(&rose_neigh->queue);
 
@@ -178,6 +178,7 @@ static int __must_check rose_add_node(struct rose_route_struct *rose_route,
 			}
 		}
 		rose_neigh->count++;
+		rose_neigh_hold(rose_neigh);
 
 		goto out;
 	}
@@ -187,6 +188,7 @@ static int __must_check rose_add_node(struct rose_route_struct *rose_route,
 		rose_node->neighbour[rose_node->count] = rose_neigh;
 		rose_node->count++;
 		rose_neigh->count++;
+		rose_neigh_hold(rose_neigh);
 	}
 
 out:
@@ -234,20 +236,12 @@ static void rose_remove_neigh(struct rose_neigh *rose_neigh)
 
 	if ((s = rose_neigh_list) == rose_neigh) {
 		rose_neigh_list = rose_neigh->next;
-		if (rose_neigh->ax25)
-			ax25_cb_put(rose_neigh->ax25);
-		kfree(rose_neigh->digipeat);
-		kfree(rose_neigh);
 		return;
 	}
 
 	while (s != NULL && s->next != NULL) {
 		if (s->next == rose_neigh) {
 			s->next = rose_neigh->next;
-			if (rose_neigh->ax25)
-				ax25_cb_put(rose_neigh->ax25);
-			kfree(rose_neigh->digipeat);
-			kfree(rose_neigh);
 			return;
 		}
 
@@ -263,10 +257,10 @@ static void rose_remove_route(struct rose_route *rose_route)
 	struct rose_route *s;
 
 	if (rose_route->neigh1 != NULL)
-		rose_route->neigh1->use--;
+		rose_neigh_put(rose_route->neigh1);
 
 	if (rose_route->neigh2 != NULL)
-		rose_route->neigh2->use--;
+		rose_neigh_put(rose_route->neigh2);
 
 	if ((s = rose_route_list) == rose_route) {
 		rose_route_list = rose_route->next;
@@ -330,9 +324,12 @@ static int rose_del_node(struct rose_route_struct *rose_route,
 	for (i = 0; i < rose_node->count; i++) {
 		if (rose_node->neighbour[i] == rose_neigh) {
 			rose_neigh->count--;
+			rose_neigh_put(rose_neigh);
 
-			if (rose_neigh->count == 0 && rose_neigh->use == 0)
+			if (rose_neigh->count == 0) {
 				rose_remove_neigh(rose_neigh);
+				rose_neigh_put(rose_neigh);
+			}
 
 			rose_node->count--;
 
@@ -381,11 +378,11 @@ void rose_add_loopback_neigh(void)
 	sn->ax25      = NULL;
 	sn->dev       = NULL;
 	sn->count     = 0;
-	sn->use       = 0;
 	sn->dce_mode  = 1;
 	sn->loopback  = 1;
 	sn->number    = rose_neigh_no++;
 	sn->restarted = 1;
+	refcount_set(&sn->use, 1);
 
 	skb_queue_head_init(&sn->queue);
 
@@ -436,6 +433,7 @@ int rose_add_loopback_node(const rose_address *address)
 	rose_node_list  = rose_node;
 
 	rose_loopback_neigh->count++;
+	rose_neigh_hold(rose_loopback_neigh);
 
 out:
 	spin_unlock_bh(&rose_node_list_lock);
@@ -467,6 +465,7 @@ void rose_del_loopback_node(const rose_address *address)
 	rose_remove_node(rose_node);
 
 	rose_loopback_neigh->count--;
+	rose_neigh_put(rose_loopback_neigh);
 
 out:
 	spin_unlock_bh(&rose_node_list_lock);
@@ -506,6 +505,7 @@ void rose_rt_device_down(struct net_device *dev)
 				memmove(&t->neighbour[i], &t->neighbour[i + 1],
 					sizeof(t->neighbour[0]) *
 						(t->count - i));
+				rose_neigh_put(s);
 			}
 
 			if (t->count <= 0)
@@ -513,6 +513,7 @@ void rose_rt_device_down(struct net_device *dev)
 		}
 
 		rose_remove_neigh(s);
+		rose_neigh_put(s);
 	}
 	spin_unlock_bh(&rose_neigh_list_lock);
 	spin_unlock_bh(&rose_node_list_lock);
@@ -548,6 +549,7 @@ static int rose_clear_routes(void)
 {
 	struct rose_neigh *s, *rose_neigh;
 	struct rose_node  *t, *rose_node;
+	int i;
 
 	spin_lock_bh(&rose_node_list_lock);
 	spin_lock_bh(&rose_neigh_list_lock);
@@ -558,17 +560,21 @@ static int rose_clear_routes(void)
 	while (rose_node != NULL) {
 		t         = rose_node;
 		rose_node = rose_node->next;
-		if (!t->loopback)
+
+		if (!t->loopback) {
+			for (i = 0; i < t->count; i++)
+				rose_neigh_put(t->neighbour[i]);
 			rose_remove_node(t);
+		}
 	}
 
 	while (rose_neigh != NULL) {
 		s          = rose_neigh;
 		rose_neigh = rose_neigh->next;
 
-		if (s->use == 0 && !s->loopback) {
-			s->count = 0;
+		if (!s->loopback) {
 			rose_remove_neigh(s);
+			rose_neigh_put(s);
 		}
 	}
 
@@ -684,6 +690,7 @@ struct rose_neigh *rose_get_neigh(rose_address *addr, unsigned char *cause,
 			for (i = 0; i < node->count; i++) {
 				if (node->neighbour[i]->restarted) {
 					res = node->neighbour[i];
+					rose_neigh_hold(node->neighbour[i]);
 					goto out;
 				}
 			}
@@ -695,6 +702,7 @@ struct rose_neigh *rose_get_neigh(rose_address *addr, unsigned char *cause,
 				for (i = 0; i < node->count; i++) {
 					if (!rose_ftimer_running(node->neighbour[i])) {
 						res = node->neighbour[i];
+						rose_neigh_hold(node->neighbour[i]);
 						goto out;
 					}
 					failed = 1;
@@ -784,13 +792,13 @@ static void rose_del_route_by_neigh(struct rose_neigh *rose_neigh)
 		}
 
 		if (rose_route->neigh1 == rose_neigh) {
-			rose_route->neigh1->use--;
+			rose_neigh_put(rose_route->neigh1);
 			rose_route->neigh1 = NULL;
 			rose_transmit_clear_request(rose_route->neigh2, rose_route->lci2, ROSE_OUT_OF_ORDER, 0);
 		}
 
 		if (rose_route->neigh2 == rose_neigh) {
-			rose_route->neigh2->use--;
+			rose_neigh_put(rose_route->neigh2);
 			rose_route->neigh2 = NULL;
 			rose_transmit_clear_request(rose_route->neigh1, rose_route->lci1, ROSE_OUT_OF_ORDER, 0);
 		}
@@ -919,7 +927,7 @@ int rose_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 			rose_clear_queues(sk);
 			rose->cause	 = ROSE_NETWORK_CONGESTION;
 			rose->diagnostic = 0;
-			rose->neighbour->use--;
+			rose_neigh_put(rose->neighbour);
 			rose->neighbour	 = NULL;
 			rose->lci	 = 0;
 			rose->state	 = ROSE_STATE_0;
@@ -1044,12 +1052,12 @@ int rose_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 
 	if ((new_lci = rose_new_lci(new_neigh)) == 0) {
 		rose_transmit_clear_request(rose_neigh, lci, ROSE_NETWORK_CONGESTION, 71);
-		goto out;
+		goto put_neigh;
 	}
 
 	if ((rose_route = kmalloc(sizeof(*rose_route), GFP_ATOMIC)) == NULL) {
 		rose_transmit_clear_request(rose_neigh, lci, ROSE_NETWORK_CONGESTION, 120);
-		goto out;
+		goto put_neigh;
 	}
 
 	rose_route->lci1      = lci;
@@ -1062,8 +1070,8 @@ int rose_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	rose_route->lci2      = new_lci;
 	rose_route->neigh2    = new_neigh;
 
-	rose_route->neigh1->use++;
-	rose_route->neigh2->use++;
+	rose_neigh_hold(rose_route->neigh1);
+	rose_neigh_hold(rose_route->neigh2);
 
 	rose_route->next = rose_route_list;
 	rose_route_list  = rose_route;
@@ -1075,6 +1083,8 @@ int rose_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	rose_transmit_link(skb, rose_route->neigh2);
 	res = 1;
 
+put_neigh:
+	rose_neigh_put(new_neigh);
 out:
 	spin_unlock_bh(&rose_route_list_lock);
 	spin_unlock_bh(&rose_neigh_list_lock);
@@ -1190,7 +1200,7 @@ static int rose_neigh_show(struct seq_file *seq, void *v)
 			   (rose_neigh->loopback) ? "RSLOOP-0" : ax2asc(buf, &rose_neigh->callsign),
 			   rose_neigh->dev ? rose_neigh->dev->name : "???",
 			   rose_neigh->count,
-			   rose_neigh->use,
+			   refcount_read(&rose_neigh->use) - rose_neigh->count - 1,
 			   (rose_neigh->dce_mode) ? "DCE" : "DTE",
 			   (rose_neigh->restarted) ? "yes" : "no",
 			   ax25_display_timer(&rose_neigh->t0timer) / HZ,
@@ -1295,18 +1305,22 @@ void __exit rose_rt_free(void)
 	struct rose_neigh *s, *rose_neigh = rose_neigh_list;
 	struct rose_node  *t, *rose_node  = rose_node_list;
 	struct rose_route *u, *rose_route = rose_route_list;
+	int i;
 
 	while (rose_neigh != NULL) {
 		s          = rose_neigh;
 		rose_neigh = rose_neigh->next;
 
 		rose_remove_neigh(s);
+		rose_neigh_put(s);
 	}
 
 	while (rose_node != NULL) {
 		t         = rose_node;
 		rose_node = rose_node->next;
 
+		for (i = 0; i < t->count; i++)
+			rose_neigh_put(t->neighbour[i]);
 		rose_remove_node(t);
 	}
 
diff --git a/net/rose/rose_timer.c b/net/rose/rose_timer.c
index 1525773e94aa..c52d7d20c519 100644
--- a/net/rose/rose_timer.c
+++ b/net/rose/rose_timer.c
@@ -180,7 +180,7 @@ static void rose_timer_expiry(struct timer_list *t)
 		break;
 
 	case ROSE_STATE_2:	/* T3 */
-		rose->neighbour->use--;
+		rose_neigh_put(rose->neighbour);
 		rose_disconnect(sk, ETIMEDOUT, -1, -1);
 		break;
 
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 38e2fbdcbeac..9f835e674c59 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -546,7 +546,9 @@ static void sctp_v6_from_sk(union sctp_addr *addr, struct sock *sk)
 {
 	addr->v6.sin6_family = AF_INET6;
 	addr->v6.sin6_port = 0;
+	addr->v6.sin6_flowinfo = 0;
 	addr->v6.sin6_addr = sk->sk_v6_rcv_saddr;
+	addr->v6.sin6_scope_id = 0;
 }
 
 /* Initialize sk->sk_rcv_saddr from sctp_addr. */
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index a134584acf90..74e69572796b 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -2230,7 +2230,7 @@ static int tx_macro_register_mclk_output(struct tx_macro *tx)
 }
 
 static const struct snd_soc_component_driver tx_macro_component_drv = {
-	.name = "RX-MACRO",
+	.name = "TX-MACRO",
 	.probe = tx_macro_component_probe,
 	.controls = tx_macro_snd_controls,
 	.num_controls = ARRAY_SIZE(tx_macro_snd_controls),
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 36c1d3090689..f114f75ebeb9 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -4,7 +4,6 @@
 
 #include <errno.h>
 #include <unistd.h>
-#include <stdio.h>
 #include <fcntl.h>
 #include <string.h>
 #include <stdlib.h>
@@ -88,11 +87,8 @@ int filename__read_debuglink(const char *filename __maybe_unused,
  */
 int filename__read_build_id(const char *filename, struct build_id *bid)
 {
-	FILE *fp;
-	int ret = -1;
+	int fd, ret = -1;
 	bool need_swap = false, elf32;
-	u8 e_ident[EI_NIDENT];
-	int i;
 	union {
 		struct {
 			Elf32_Ehdr ehdr32;
@@ -103,28 +99,27 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 			Elf64_Phdr *phdr64;
 		};
 	} hdrs;
-	void *phdr;
-	size_t phdr_size;
-	void *buf = NULL;
-	size_t buf_size = 0;
+	void *phdr, *buf = NULL;
+	ssize_t phdr_size, ehdr_size, buf_size = 0;
 
-	fp = fopen(filename, "r");
-	if (fp == NULL)
+	fd = open(filename, O_RDONLY);
+	if (fd < 0)
 		return -1;
 
-	if (fread(e_ident, sizeof(e_ident), 1, fp) != 1)
+	if (read(fd, hdrs.ehdr32.e_ident, EI_NIDENT) != EI_NIDENT)
 		goto out;
 
-	if (memcmp(e_ident, ELFMAG, SELFMAG) ||
-	    e_ident[EI_VERSION] != EV_CURRENT)
+	if (memcmp(hdrs.ehdr32.e_ident, ELFMAG, SELFMAG) ||
+	    hdrs.ehdr32.e_ident[EI_VERSION] != EV_CURRENT)
 		goto out;
 
-	need_swap = check_need_swap(e_ident[EI_DATA]);
-	elf32 = e_ident[EI_CLASS] == ELFCLASS32;
+	need_swap = check_need_swap(hdrs.ehdr32.e_ident[EI_DATA]);
+	elf32 = hdrs.ehdr32.e_ident[EI_CLASS] == ELFCLASS32;
+	ehdr_size = (elf32 ? sizeof(hdrs.ehdr32) : sizeof(hdrs.ehdr64)) - EI_NIDENT;
 
-	if (fread(elf32 ? (void *)&hdrs.ehdr32 : (void *)&hdrs.ehdr64,
-		  elf32 ? sizeof(hdrs.ehdr32) : sizeof(hdrs.ehdr64),
-		  1, fp) != 1)
+	if (read(fd,
+		 (elf32 ? (void *)&hdrs.ehdr32 : (void *)&hdrs.ehdr64) + EI_NIDENT,
+		 ehdr_size) != ehdr_size)
 		goto out;
 
 	if (need_swap) {
@@ -138,14 +133,18 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 			hdrs.ehdr64.e_phnum = bswap_16(hdrs.ehdr64.e_phnum);
 		}
 	}
-	phdr_size = elf32 ? hdrs.ehdr32.e_phentsize * hdrs.ehdr32.e_phnum
-			  : hdrs.ehdr64.e_phentsize * hdrs.ehdr64.e_phnum;
+	if ((elf32 && hdrs.ehdr32.e_phentsize != sizeof(Elf32_Phdr)) ||
+	    (!elf32 && hdrs.ehdr64.e_phentsize != sizeof(Elf64_Phdr)))
+		goto out;
+
+	phdr_size = elf32 ? sizeof(Elf32_Phdr) * hdrs.ehdr32.e_phnum
+			  : sizeof(Elf64_Phdr) * hdrs.ehdr64.e_phnum;
 	phdr = malloc(phdr_size);
 	if (phdr == NULL)
 		goto out;
 
-	fseek(fp, elf32 ? hdrs.ehdr32.e_phoff : hdrs.ehdr64.e_phoff, SEEK_SET);
-	if (fread(phdr, phdr_size, 1, fp) != 1)
+	lseek(fd, elf32 ? hdrs.ehdr32.e_phoff : hdrs.ehdr64.e_phoff, SEEK_SET);
+	if (read(fd, phdr, phdr_size) != phdr_size)
 		goto out_free;
 
 	if (elf32)
@@ -153,8 +152,8 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 	else
 		hdrs.phdr64 = phdr;
 
-	for (i = 0; i < elf32 ? hdrs.ehdr32.e_phnum : hdrs.ehdr64.e_phnum; i++) {
-		size_t p_filesz;
+	for (int i = 0; i < (elf32 ? hdrs.ehdr32.e_phnum : hdrs.ehdr64.e_phnum); i++) {
+		ssize_t p_filesz;
 
 		if (need_swap) {
 			if (elf32) {
@@ -180,8 +179,8 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 				goto out_free;
 			buf = tmp;
 		}
-		fseek(fp, elf32 ? hdrs.phdr32[i].p_offset : hdrs.phdr64[i].p_offset, SEEK_SET);
-		if (fread(buf, p_filesz, 1, fp) != 1)
+		lseek(fd, elf32 ? hdrs.phdr32[i].p_offset : hdrs.phdr64[i].p_offset, SEEK_SET);
+		if (read(fd, buf, p_filesz) != p_filesz)
 			goto out_free;
 
 		ret = read_build_id(buf, p_filesz, bid, need_swap);
@@ -194,7 +193,7 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 	free(buf);
 	free(phdr);
 out:
-	fclose(fp);
+	close(fd);
 	return ret;
 }
 
diff --git a/tools/tracing/latency/Makefile.config b/tools/tracing/latency/Makefile.config
index 0fe6b50f029b..6efa13e3ca93 100644
--- a/tools/tracing/latency/Makefile.config
+++ b/tools/tracing/latency/Makefile.config
@@ -1,7 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+include $(srctree)/tools/scripts/utilities.mak
+
 STOP_ERROR :=
 
+ifndef ($(NO_LIBTRACEEVENT),1)
+  ifeq ($(call get-executable,$(PKG_CONFIG)),)
+    $(error Error: $(PKG_CONFIG) needed by libtraceevent/libtracefs is missing on this system, please install it)
+  endif
+endif
+
 define lib_setup
   $(eval LIB_INCLUDES += $(shell sh -c "$(PKG_CONFIG) --cflags lib$(1)"))
   $(eval LDFLAGS += $(shell sh -c "$(PKG_CONFIG) --libs-only-L lib$(1)"))
diff --git a/tools/tracing/rtla/Makefile.config b/tools/tracing/rtla/Makefile.config
index 5f8c286712d4..a35d6ee55ffc 100644
--- a/tools/tracing/rtla/Makefile.config
+++ b/tools/tracing/rtla/Makefile.config
@@ -1,10 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+include $(srctree)/tools/scripts/utilities.mak
+
 STOP_ERROR :=
 
 LIBTRACEEVENT_MIN_VERSION = 1.5
 LIBTRACEFS_MIN_VERSION = 1.6
 
+ifndef ($(NO_LIBTRACEEVENT),1)
+  ifeq ($(call get-executable,$(PKG_CONFIG)),)
+    $(error Error: $(PKG_CONFIG) needed by libtraceevent/libtracefs is missing on this system, please install it)
+  endif
+endif
+
 define lib_setup
   $(eval LIB_INCLUDES += $(shell sh -c "$(PKG_CONFIG) --cflags lib$(1)"))
   $(eval LDFLAGS += $(shell sh -c "$(PKG_CONFIG) --libs-only-L lib$(1)"))

