Return-Path: <stable+bounces-166530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3394B1AF52
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 09:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A41189BEF8
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 07:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950C4238C0D;
	Tue,  5 Aug 2025 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0AraxPJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6296C238C39
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 07:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754378801; cv=none; b=UyxMNGdI8bMV+1Smsy5ypgd1w7bu+hX3ZPw6SzwgIhI2DTeDHIUEcbMXPZ2CSFpG9263Gd92k1pp3ZmocA3p/vyoVPkjqJjqWDDx2D1sZa9TrU6k/HB5iqe3l8P8vqst46BmdIdS9E5BVzFwCoZs3sWw7Zh2VVqt9qrleceXtoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754378801; c=relaxed/simple;
	bh=FdD4Wkif05FCg9N9ocZ/LPdXfRlBkFJyWM2b3OKOLVc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uvQQNxc9d+0AaKQS1jEbs6/j3a0eXS8JJYK1AzENLOW/6yPuc+sJUbfkFg9K2BM852bQ21eiyazU6RCD8pcFpkMrI4qmuUnatX9pNTomoKPG1kIRWMVgWeFA5HnZa/c0DRhYRBTKcKF35QfEwkhKxFYXFN3keXCTriDty9N0xmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g0AraxPJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754378799; x=1785914799;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=FdD4Wkif05FCg9N9ocZ/LPdXfRlBkFJyWM2b3OKOLVc=;
  b=g0AraxPJQXvC6FEfs4JNFsiGLiQgWlJupnuwsynCtqPoBlPIH6bDkPG7
   btFDFNt4oZdr7cN8V7nH+DL/BQ3YynbNlybIcn2XjaKAgcnLuW6hLnvhZ
   xP6yeAXXRdS8zwHm+57Q9/TAv9qVzefxE5yvn3y1SK6Iets+fpiyGB44k
   MsJeRVxgy34reMQuYaV8xP86HWoQEiw8xp2IZhjtbFsNQ+Ih7iQHlcYjW
   ed1am9hr9NFNs+aDB72KxK7Mp5f5TAiBPZ3t/y7amfe5dumlCJe9d4aIo
   nOkURTzcseSN6OsnL2yoTMCUIvI9EC/0gFOW9NWvskxmmShV13zsYDVMA
   w==;
X-CSE-ConnectionGUID: X/TMC+7DR3ibzb3BmkRVww==
X-CSE-MsgGUID: BvLTyhD7Q3C9Zza/9DgDAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="68031903"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="68031903"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 00:26:39 -0700
X-CSE-ConnectionGUID: 8Te4o/dsS46gGgt51HEJ4w==
X-CSE-MsgGUID: lCnTeREQRKGV6cHezwXppA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="195238247"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO [10.245.245.229]) ([10.245.245.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 00:26:37 -0700
Message-ID: <4b679826a9a5dba8d0be69178521d935daafb0b4.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: Defer buffer object shrinker write-backs and
 GPU waits
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: "Summers, Stuart" <stuart.summers@intel.com>, 
 "intel-xe@lists.freedesktop.org"
	 <intel-xe@lists.freedesktop.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Date: Tue, 05 Aug 2025 09:26:35 +0200
In-Reply-To: <de527a0808c804211c83ee8b16036e1232d87525.camel@intel.com>
References: <20250804081040.2458-1-thomas.hellstrom@linux.intel.com>
	 <de527a0808c804211c83ee8b16036e1232d87525.camel@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI1LTA4LTA0IGF0IDE5OjI5ICswMDAwLCBTdW1tZXJzLCBTdHVhcnQgd3JvdGU6
Cj4gT24gTW9uLCAyMDI1LTA4LTA0IGF0IDEwOjEwICswMjAwLCBUaG9tYXMgSGVsbHN0csO2bSB3
cm90ZToKPiA+IFdoZW4gdGhlIHhlIGJ1ZmZlci1vYmplY3Qgc2hyaW5rZXIgYWxsb3dzIEdQVSB3
YWl0cyBhbmQgd3JpdGUtYmFjaywKPiA+ICh0eXBpY2FsbHkgZnJvbSBrc3dhcGQpLCBwZXJmb3Jt
IG11bHRpbHBlIHBhc3Nlcywgc2tpcHBpbmcKPiAKPiAvcy9tdWx0aWxwZS9tdWx0aXBsZS8KPiAK
PiA+IHN1YnNlcXVlbnQgcGFzc2VzIGlmIHRoZSBzaHJpbmtlciBudW1iZXIgb2Ygc2Nhbm5lZCBv
YmplY3RzIHRhcmdldAo+ID4gaXMgcmVhY2hlZC4KPiA+IAo+ID4gMSkgV2l0aG91dCBHUFUgd2Fp
dHMgYW5kIHdyaXRlLWJhY2sKPiA+IDIpIFdpdGhvdXQgd3JpdGUtYmFjawo+ID4gMykgV2l0aCBi
b3RoIEdQVS13YWl0cyBhbmQgd3JpdGUtYmFjawo+ID4gCj4gPiBUaGlzIGlzIHRvIGF2b2lkIHN0
YWxscyBhbmQgY29zdGx5IHdyaXRlLSBhbmQgcmVhZGJhY2tzIHVubGVzcyB0aGV5Cj4gPiBhcmUg
cmVhbGx5IG5lY2Vzc2FyeS4KPiA+IAo+ID4gQ2xvc2VzOgo+ID4gaHR0cHM6Ly9naXRsYWIuZnJl
ZWRlc2t0b3Aub3JnL2RybS94ZS9rZXJuZWwvLS9pc3N1ZXMvNTU1NyNub3RlXzMwMzUxMzYKPiA+
IEZpeGVzOiAwMGM4ZWZjMzE4MGYgKCJkcm0veGU6IEFkZCBhIHNocmlua2VyIGZvciB4ZSBib3Mi
KQo+ID4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIHY2LjE1Kwo+ID4gU2lnbmVkLW9m
Zi1ieTogVGhvbWFzIEhlbGxzdHLDtm0gPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29t
Pgo+IAo+IEkgc2VlIHRoZSByZXBvcnRlZCByZXF1ZXN0ZWQ6Cj4gUmVwb3J0ZWQtYnk6IG1lbHZ5
biA8bWVsdnluMkBkbnNlbnNlLnB1Yj4KPiAKPiA+IC0tLQo+ID4gwqBkcml2ZXJzL2dwdS9kcm0v
eGUveGVfc2hyaW5rZXIuYyB8IDUxCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0K
PiA+IC0tCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX3Nocmlua2Vy
LmMKPiA+IGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX3Nocmlua2VyLmMKPiA+IGluZGV4IDFjM2Mw
NGQ1MmY1NS4uYmMzNDM5YmQ0NDUwIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3hl
L3hlX3Nocmlua2VyLmMKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9zaHJpbmtlci5j
Cj4gPiBAQCAtNTQsMTAgKzU0LDEwIEBAIHhlX3Nocmlua2VyX21vZF9wYWdlcyhzdHJ1Y3QgeGVf
c2hyaW5rZXIKPiA+ICpzaHJpbmtlciwgbG9uZyBzaHJpbmthYmxlLCBsb25nIHB1cmdlYQo+ID4g
wqDCoMKgwqDCoMKgwqDCoHdyaXRlX3VubG9jaygmc2hyaW5rZXItPmxvY2spOwo+ID4gwqB9Cj4g
PiDCoAo+ID4gLXN0YXRpYyBzNjQgeGVfc2hyaW5rZXJfd2FsayhzdHJ1Y3QgeGVfZGV2aWNlICp4
ZSwKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHN0cnVjdCB0dG1fb3BlcmF0aW9uX2N0eCAqY3R4LAo+ID4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IHhlX2JvX3No
cmlua19mbGFncyBmbGFncywKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgdG9fc2NhbiwgdW5zaWduZWQgbG9uZwo+
ID4gKnNjYW5uZWQpCj4gPiArc3RhdGljIHM2NCBfX3hlX3Nocmlua2VyX3dhbGsoc3RydWN0IHhl
X2RldmljZSAqeGUsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHR0bV9vcGVyYXRpb25fY3R4ICpjdHgsCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29u
c3Qgc3RydWN0IHhlX2JvX3Nocmlua19mbGFncwo+ID4gZmxhZ3MsCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9u
ZyB0b19zY2FuLCB1bnNpZ25lZCBsb25nCj4gPiAqc2Nhbm5lZCkKPiA+IMKgewo+ID4gwqDCoMKg
wqDCoMKgwqDCoHVuc2lnbmVkIGludCBtZW1fdHlwZTsKPiA+IMKgwqDCoMKgwqDCoMKgwqBzNjQg
ZnJlZWQgPSAwLCBscmV0Owo+ID4gQEAgLTkzLDYgKzkzLDQ4IEBAIHN0YXRpYyBzNjQgeGVfc2hy
aW5rZXJfd2FsayhzdHJ1Y3QgeGVfZGV2aWNlCj4gPiAqeGUsCj4gPiDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuIGZyZWVkOwo+ID4gwqB9Cj4gPiDCoAo+ID4gKy8qCj4gPiArICogVHJ5IHNocmlua2lu
ZyBpZGxlIG9iamVjdHMgd2l0aG91dCB3cml0ZWJhY2sgZmlyc3QsIHRoZW4gaWYgbm90Cj4gPiBz
dWZmaWNpZW50LAo+ID4gKyAqIHRyeSBhbHNvIG5vbi1pZGxlIG9iamVjdHMgYW5kIGZpbmFsbHkg
aWYgdGhhdCdzIG5vdCBzdWZmaWNpZW50Cj4gPiBlaXRoZXIsCj4gPiArICogYWRkIHdyaXRlYmFj
ay4gVGhpcyBhdm9pZHMgc3RhbGxzIGFuZCBleHBsaWNpdCB3cml0ZWJhY2tzIHdpdGgKPiA+IGxp
Z2h0IG9yCj4gPiArICogbW9kZXJhdGUgbWVtb3J5IHByZXNzdXJlLgo+ID4gKyAqLwo+ID4gK3N0
YXRpYyBzNjQgeGVfc2hyaW5rZXJfd2FsayhzdHJ1Y3QgeGVfZGV2aWNlICp4ZSwKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB0
dG1fb3BlcmF0aW9uX2N0eCAqY3R4LAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IHhlX2JvX3Nocmlua19mbGFncyBm
bGFncywKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHVuc2lnbmVkIGxvbmcgdG9fc2NhbiwgdW5zaWduZWQgbG9uZwo+ID4gKnNjYW5uZWQp
Cj4gPiArewo+ID4gK8KgwqDCoMKgwqDCoMKgYm9vbCBub193YWl0X2dwdSA9IHRydWU7Cj4gPiAr
wqDCoMKgwqDCoMKgwqBzdHJ1Y3QgeGVfYm9fc2hyaW5rX2ZsYWdzIHNhdmVfZmxhZ3MgPSBmbGFn
czsKPiA+ICvCoMKgwqDCoMKgwqDCoHM2NCBscmV0LCBmcmVlZDsKPiA+ICsKPiA+ICvCoMKgwqDC
oMKgwqDCoHN3YXAobm9fd2FpdF9ncHUsIGN0eC0+bm9fd2FpdF9ncHUpOwo+ID4gK8KgwqDCoMKg
wqDCoMKgc2F2ZV9mbGFncy53cml0ZWJhY2sgPSBmYWxzZTsKPiA+ICvCoMKgwqDCoMKgwqDCoGxy
ZXQgPSBfX3hlX3Nocmlua2VyX3dhbGsoeGUsIGN0eCwgc2F2ZV9mbGFncywgdG9fc2NhbiwKPiA+
IHNjYW5uZWQpOwo+ID4gK8KgwqDCoMKgwqDCoMKgc3dhcChub193YWl0X2dwdSwgY3R4LT5ub193
YWl0X2dwdSk7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAobHJldCA8IDAgfHwgKnNjYW5uZWQgPj0g
dG9fc2NhbikKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gbHJldDsK
PiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoGZyZWVkID0gbHJldDsKPiA+ICvCoMKgwqDCoMKgwqDC
oGlmICghY3R4LT5ub193YWl0X2dwdSkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGxyZXQgPSBfX3hlX3Nocmlua2VyX3dhbGsoeGUsIGN0eCwgc2F2ZV9mbGFncywKPiA+IHRv
X3NjYW4sIHNjYW5uZWQpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChs
cmV0IDwgMCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIGxyZXQ7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZnJlZWQg
Kz0gbHJldDsKPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiA+ICvCoMKgwqDCoMKgwqDCoGlmICgqc2Nh
bm5lZCA+PSB0b19zY2FuKQo+IAo+IFdoeSBub3QgaW5jbHVkZSB0aGlzIGluIHRoZSAhY3R4LT5u
b193YWl0X2dwdSBjb25kaXRpb24gYWJvdmU/IElmCj4gY3R4LQo+ID4gbm9fd2FpdF9ncHUgd2Fz
IHBhc3NlZCBpbiBhcyB0cnVlIGhlcmUsIHdlJ3JlIGp1c3QgY2hlY2tpbmcgc2Nhbm5lZAo+ID4g
Pj0KPiB0b19zY2FuIHR3aWNlIGluIGEgcm93IHdpdGggdGhlIHNhbWUgdmFsdWVzLgo+IAo+IE90
aGVyd2lzZSB0aGUgcGF0Y2ggbGd0bS4KClRoYW5rcyBmb3IgdGhlIHJldmlldy4gV2lsbCBmaXgu
Ci9UaG9tYXMKCj4gCj4gVGhhbmtzLAo+IFN0dWFydAo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybiBmcmVlZDsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChm
bGFncy53cml0ZWJhY2spIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBscmV0
ID0gX194ZV9zaHJpbmtlcl93YWxrKHhlLCBjdHgsIGZsYWdzLCB0b19zY2FuLAo+ID4gc2Nhbm5l
ZCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGxyZXQgPCAwKQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gbHJl
dDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmcmVlZCArPSBscmV0Owo+ID4g
K8KgwqDCoMKgwqDCoMKgfQo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIGZyZWVkOwo+
ID4gK30KPiA+ICsKPiA+IMKgc3RhdGljIHVuc2lnbmVkIGxvbmcKPiA+IMKgeGVfc2hyaW5rZXJf
Y291bnQoc3RydWN0IHNocmlua2VyICpzaHJpbmssIHN0cnVjdCBzaHJpbmtfY29udHJvbAo+ID4g
KnNjKQo+ID4gwqB7Cj4gPiBAQCAtMTk5LDYgKzI0MSw3IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25n
IHhlX3Nocmlua2VyX3NjYW4oc3RydWN0Cj4gPiBzaHJpbmtlciAqc2hyaW5rLCBzdHJ1Y3Qgc2hy
aW5rX2Nvbgo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBydW50aW1lX3BtID0g
eGVfc2hyaW5rZXJfcnVudGltZV9wbV9nZXQoc2hyaW5rZXIsCj4gPiB0cnVlLCAwLCBjYW5fYmFj
a3VwKTsKPiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgc2hyaW5rX2ZsYWdzLnB1cmdlID0gZmFs
c2U7Cj4gPiArCj4gPiDCoMKgwqDCoMKgwqDCoMKgbHJldCA9IHhlX3Nocmlua2VyX3dhbGsoc2hy
aW5rZXItPnhlLCAmY3R4LCBzaHJpbmtfZmxhZ3MsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbnJfdG9fc2NhbiwgJm5y
X3NjYW5uZWQpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoGlmIChscmV0ID49IDApCj4gCgo=


