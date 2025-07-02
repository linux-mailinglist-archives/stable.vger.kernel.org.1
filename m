Return-Path: <stable+bounces-159209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7FDAF0EA6
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 11:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500031BC82CC
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 09:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D4B242D86;
	Wed,  2 Jul 2025 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NibrHSar"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDCC244678;
	Wed,  2 Jul 2025 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446809; cv=none; b=PRtaTWPDQiV2ks07Bji4PTZnPXU1o4/RXW3guesN13YPT35jPfkvGk82RIYa6sKkRJKrnfBX8ovVekR1Q0xGRyQGhfXpGwgax+1rBwQVtWQ6MP/csjam/u5rrQvmUfrfTs5lr1QVa5JeYRIPd37yfe9bMxSwmDApcO9kMZkT3ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446809; c=relaxed/simple;
	bh=ozh9/+qetdy1B44Hk1ck9qSNB6VPcxBClhcVl6wJg/8=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To; b=uuU7US6HB1fYyQuh6GK0fUJtZZx6ZasiEPQ8rvMBsiVpTkwge0diTvod1a9Q2kPKxehLd/Pjks7lu3l/UGRhERQ/evYM2ab+v+3O6QwAVDF13mrpTGIzr5rMYtkeRA5Y05IGOnprLVEhLSHkNOaVte6bnDotz8GrjP0/qvFOFIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NibrHSar; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751446807; x=1782982807;
  h=message-id:date:mime-version:subject:from:to:references:
   in-reply-to;
  bh=ozh9/+qetdy1B44Hk1ck9qSNB6VPcxBClhcVl6wJg/8=;
  b=NibrHSarcbASkUMY6PsYzDfDSSIelJvkne6Et1OXD7zvqID7Iz4F+w2s
   3RrhAzZlXbdaDGkGAl9D1G9IwHuEtFzfG3xERdoYPEQfgO9J8BLbNI9hE
   22SzEmpb1zwr/UbNKGk4b6xu+faaMb7l2hXdTnrs+N5BdkeNc2ciJx7N2
   LDzngQaoyIHsPH0dkhrkhxDUMTkdK7hypbvZ/qxaLLqymHF1aAf/DjL5e
   gwiGQ8wHv3Y9/HwPUn4k7PPuRJg9M2+Hw7E42be7ilZuucJbl2UA+Tfqh
   rb4vHFYWFKT/pXTlUg+lX8iQo/24+56vIoJSLwKxkvZbHsqb9rnzVvxNi
   w==;
X-CSE-ConnectionGUID: 4UBIrfQ+QSSmHCDpa9gB5g==
X-CSE-MsgGUID: uhFdxgAHQpi6DZs6mMl4jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="63979299"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208,223";a="63979299"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:00:06 -0700
X-CSE-ConnectionGUID: RifH1KUrRtuZRm+aVX2CrQ==
X-CSE-MsgGUID: ZQGBJ625SRK6jkZ5y9Bn8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208,223";a="154342502"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.243.252]) ([10.124.243.252])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:00:03 -0700
Content-Type: multipart/mixed; boundary="------------3m0g6PfBR00YwHw0BbrfPgi0"
Message-ID: <96d68cb2-9240-4179-bca0-8ad2d70ab281@linux.intel.com>
Date: Wed, 2 Jul 2025 17:00:00 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] Performance Regression in IOMMU/VT-d Since
 Kernel 6.10
From: Baolu Lu <baolu.lu@linux.intel.com>
To: Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>,
 kevin.tian@intel.com, jroedel@suse.de, robin.murphy@arm.com,
 will@kernel.org, joro@8bytes.org, dwmw2@infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org
References: <20250701171154.52435-1-ioanna-maria.alifieraki@canonical.com>
 <7d2214f3-3b54-4b74-a18b-aca1fdf4fdb4@linux.intel.com>
Content-Language: en-US
In-Reply-To: <7d2214f3-3b54-4b74-a18b-aca1fdf4fdb4@linux.intel.com>

This is a multi-part message in MIME format.
--------------3m0g6PfBR00YwHw0BbrfPgi0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/2/2025 1:14 PM, Baolu Lu wrote:
> On 7/2/25 01:11, Ioanna Alifieraki wrote:
>> #regzbot introduced: 129dab6e1286
>>
>> Hello everyone,
>>
>> We've identified a performance regression that starts with linux
>> kernel 6.10 and persists through 6.16(tested at commit e540341508ce).
>> Bisection pointed to commit:
>> 129dab6e1286 ("iommu/vt-d: Use cache_tag_flush_range_np() in 
>> iotlb_sync_map").
>>
>> The issue occurs when running fio against two NVMe devices located
>> under the same PCIe bridge (dual-port NVMe configuration). Performance
>> drops compared to configurations where the devices are on different
>> bridges.
>>
>> Observed Performance:
>> - Before the commit: ~6150 MiB/s, regardless of NVMe device placement.
>> - After the commit:
>>    -- Same PCIe bridge: ~4985 MiB/s
>>    -- Different PCIe bridges: ~6150 MiB/s
>>
>>
>> Currently we can only reproduce the issue on a Z3 metal instance on
>> gcp. I suspect the issue can be reproducible if you have a dual port
>> nvme on any machine.
>> At [1] there's a more detailed description of the issue and details
>> on the reproducer.
> 
> This test was running on bare metal hardware instead of any
> virtualization guest, right? If that's the case,
> cache_tag_flush_range_np() is almost a no-op.
> 
> Can you please show me the capability register of the IOMMU by:
> 
> #cat /sys/bus/pci/devices/[pci_dev_name]/iommu/intel-iommu/cap

Also, can you please try whether the below changes make any difference?
I've also attached a patch file to this email so you can apply the
change more easily.

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7aa3932251b2..f60201ee4be0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1796,6 +1796,18 @@ static int domain_setup_first_level(struct 
intel_iommu *iommu,
  					  (pgd_t *)pgd, flags, old);
  }

+static bool domain_need_iotlb_sync_map(struct dmar_domain *domain,
+				       struct intel_iommu *iommu)
+{
+	if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
+		return true;
+
+	if (rwbf_quirk || cap_rwbf(iommu->cap))
+		return true;
+
+	return false;
+}
+
  static int dmar_domain_attach_device(struct dmar_domain *domain,
  				     struct device *dev)
  {
@@ -1833,6 +1845,8 @@ static int dmar_domain_attach_device(struct 
dmar_domain *domain,
  	if (ret)
  		goto out_block_translation;

+	domain->iotlb_sync_map |= domain_need_iotlb_sync_map(domain, iommu);
+
  	return 0;

  out_block_translation:
@@ -3945,7 +3959,10 @@ static bool risky_device(struct pci_dev *pdev)
  static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
  				      unsigned long iova, size_t size)
  {
-	cache_tag_flush_range_np(to_dmar_domain(domain), iova, iova + size - 1);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+
+	if (dmar_domain->iotlb_sync_map)
+		cache_tag_flush_range_np(dmar_domain, iova, iova + size - 1);

  	return 0;
  }
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 3ddbcc603de2..7ab2c34a5ecc 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -614,6 +614,9 @@ struct dmar_domain {
  	u8 has_mappings:1;		/* Has mappings configured through
  					 * iommu_map() interface.
  					 */
+	u8 iotlb_sync_map:1;		/* Need to flush IOTLB cache or write
+					 * buffer when creating mappings.
+					 */

  	spinlock_t lock;		/* Protect device tracking lists */
  	struct list_head devices;	/* all devices' list */
-- 
2.43.0

Thanks,
baolu
--------------3m0g6PfBR00YwHw0BbrfPgi0
Content-Type: text/plain; charset=UTF-8;
 name="0001-iommu-vt-d-Avoid-unnecessary-cache_tag_flush_range_n.patch"
Content-Disposition: attachment;
 filename*0="0001-iommu-vt-d-Avoid-unnecessary-cache_tag_flush_range_n.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBkZGM0MjEwYTMzNjUxNDdkZjk3OGJkMGJmNDVkODI0YjljODY5ODc3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwu
Y29tPgpEYXRlOiBXZWQsIDIgSnVsIDIwMjUgMTY6NTE6NDggKzA4MDAKU3ViamVjdDogW1BB
VENIIDEvMV0gaW9tbXUvdnQtZDogQXZvaWQgdW5uZWNlc3NhcnkgY2FjaGVfdGFnX2ZsdXNo
X3JhbmdlX25wKCkKCkZvciB0ZXN0IHB1cnBvc2Ugb25seSEKClNpZ25lZC1vZmYtYnk6IEx1
IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Ci0tLQogZHJpdmVycy9pb21tdS9p
bnRlbC9pb21tdS5jIHwgMTkgKysrKysrKysrKysrKysrKysrLQogZHJpdmVycy9pb21tdS9p
bnRlbC9pb21tdS5oIHwgIDMgKysrCiAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2lv
bW11LmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKaW5kZXggN2FhMzkzMjI1MWIy
Li5mNjAyMDFlZTRiZTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUu
YworKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKQEAgLTE3OTYsNiArMTc5Niwx
OCBAQCBzdGF0aWMgaW50IGRvbWFpbl9zZXR1cF9maXJzdF9sZXZlbChzdHJ1Y3QgaW50ZWxf
aW9tbXUgKmlvbW11LAogCQkJCQkgIChwZ2RfdCAqKXBnZCwgZmxhZ3MsIG9sZCk7CiB9CiAK
K3N0YXRpYyBib29sIGRvbWFpbl9uZWVkX2lvdGxiX3N5bmNfbWFwKHN0cnVjdCBkbWFyX2Rv
bWFpbiAqZG9tYWluLAorCQkJCSAgICAgICBzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlvbW11KQor
eworCWlmIChjYXBfY2FjaGluZ19tb2RlKGlvbW11LT5jYXApICYmICFkb21haW4tPnVzZV9m
aXJzdF9sZXZlbCkKKwkJcmV0dXJuIHRydWU7CisKKwlpZiAocndiZl9xdWlyayB8fCBjYXBf
cndiZihpb21tdS0+Y2FwKSkKKwkJcmV0dXJuIHRydWU7CisKKwlyZXR1cm4gZmFsc2U7Cit9
CisKIHN0YXRpYyBpbnQgZG1hcl9kb21haW5fYXR0YWNoX2RldmljZShzdHJ1Y3QgZG1hcl9k
b21haW4gKmRvbWFpbiwKIAkJCQkgICAgIHN0cnVjdCBkZXZpY2UgKmRldikKIHsKQEAgLTE4
MzMsNiArMTg0NSw4IEBAIHN0YXRpYyBpbnQgZG1hcl9kb21haW5fYXR0YWNoX2RldmljZShz
dHJ1Y3QgZG1hcl9kb21haW4gKmRvbWFpbiwKIAlpZiAocmV0KQogCQlnb3RvIG91dF9ibG9j
a190cmFuc2xhdGlvbjsKIAorCWRvbWFpbi0+aW90bGJfc3luY19tYXAgfD0gZG9tYWluX25l
ZWRfaW90bGJfc3luY19tYXAoZG9tYWluLCBpb21tdSk7CisKIAlyZXR1cm4gMDsKIAogb3V0
X2Jsb2NrX3RyYW5zbGF0aW9uOgpAQCAtMzk0NSw3ICszOTU5LDEwIEBAIHN0YXRpYyBib29s
IHJpc2t5X2RldmljZShzdHJ1Y3QgcGNpX2RldiAqcGRldikKIHN0YXRpYyBpbnQgaW50ZWxf
aW9tbXVfaW90bGJfc3luY19tYXAoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLAogCQkJ
CSAgICAgIHVuc2lnbmVkIGxvbmcgaW92YSwgc2l6ZV90IHNpemUpCiB7Ci0JY2FjaGVfdGFn
X2ZsdXNoX3JhbmdlX25wKHRvX2RtYXJfZG9tYWluKGRvbWFpbiksIGlvdmEsIGlvdmEgKyBz
aXplIC0gMSk7CisJc3RydWN0IGRtYXJfZG9tYWluICpkbWFyX2RvbWFpbiA9IHRvX2RtYXJf
ZG9tYWluKGRvbWFpbik7CisKKwlpZiAoZG1hcl9kb21haW4tPmlvdGxiX3N5bmNfbWFwKQor
CQljYWNoZV90YWdfZmx1c2hfcmFuZ2VfbnAoZG1hcl9kb21haW4sIGlvdmEsIGlvdmEgKyBz
aXplIC0gMSk7CiAKIAlyZXR1cm4gMDsKIH0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUv
aW50ZWwvaW9tbXUuaCBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuaAppbmRleCAzZGRi
Y2M2MDNkZTIuLjdhYjJjMzRhNWVjYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9pb21tdS9pbnRl
bC9pb21tdS5oCisrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuaApAQCAtNjE0LDYg
KzYxNCw5IEBAIHN0cnVjdCBkbWFyX2RvbWFpbiB7CiAJdTggaGFzX21hcHBpbmdzOjE7CQkv
KiBIYXMgbWFwcGluZ3MgY29uZmlndXJlZCB0aHJvdWdoCiAJCQkJCSAqIGlvbW11X21hcCgp
IGludGVyZmFjZS4KIAkJCQkJICovCisJdTggaW90bGJfc3luY19tYXA6MTsJCS8qIE5lZWQg
dG8gZmx1c2ggSU9UTEIgY2FjaGUgb3Igd3JpdGUKKwkJCQkJICogYnVmZmVyIHdoZW4gY3Jl
YXRpbmcgbWFwcGluZ3MuCisJCQkJCSAqLwogCiAJc3BpbmxvY2tfdCBsb2NrOwkJLyogUHJv
dGVjdCBkZXZpY2UgdHJhY2tpbmcgbGlzdHMgKi8KIAlzdHJ1Y3QgbGlzdF9oZWFkIGRldmlj
ZXM7CS8qIGFsbCBkZXZpY2VzJyBsaXN0ICovCi0tIAoyLjQzLjAKCg==

--------------3m0g6PfBR00YwHw0BbrfPgi0--

