Return-Path: <stable+bounces-52068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86FC907869
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 18:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DDE283555
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 16:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A985130E40;
	Thu, 13 Jun 2024 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Fj1LW9AI"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F21E1369B0;
	Thu, 13 Jun 2024 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296641; cv=none; b=lRZH5NKlRFhKVvMbc0VuSjsWH8X6mdNZqH127CZcuaVzFipZEhb//CvHeR5b/I1hbseDQcSmhUsmq7ztLQz1zRb9Ticj1SkeRbHFvEhO2uBATVj/hu8iQrYOweGIgmzvrzLJra9CpqQt5gO+QyTbHCizCaeAMDUEIrvsQal4c4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296641; c=relaxed/simple;
	bh=fjSpmKa07H/QcZPAV0gPjxEiKdXTobzP28qvtb4jRN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hJVb6q5HSrYlg55uAbcggssaTyx6ydVBVkHPVCkKe8qnE1/gDZkq2aTR9ni80pl8ulaNjkhi8/xr8+nSyL483+ZLFjxZEpVUVujCCYcFkl5PYGAnlPloMOUPr1UiIKm2d0UlTcyuoeMsTbG5I1TVCG9AVtFjR3MjT1CQ5fWDneA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Fj1LW9AI; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718296640; x=1749832640;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fjSpmKa07H/QcZPAV0gPjxEiKdXTobzP28qvtb4jRN0=;
  b=Fj1LW9AIeiOyJo9tu4JVXJ0tomh3kU+EfIBwWVgP+wjWWkJTWcGzuJ7Q
   h2UWsOebk932wqv3f9zJ9a56PRzUPLZuEpH+3I8il74oPp1wocYwoa6SC
   dX6MbPqV26Vd9kDBzMCxkQS7MSBjTz+0q0YJ2X47lGxhTRKR4Z2aixjGz
   U=;
X-IronPort-AV: E=Sophos;i="6.08,235,1712620800"; 
   d="scan'208";a="303217457"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 16:37:16 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:38744]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.96:2525] with esmtp (Farcaster)
 id f9ce92c6-cab6-4561-b075-5f2a84a17fba; Thu, 13 Jun 2024 16:37:15 +0000 (UTC)
X-Farcaster-Flow-ID: f9ce92c6-cab6-4561-b075-5f2a84a17fba
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 13 Jun 2024 16:37:15 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 13 Jun
 2024 16:37:11 +0000
Message-ID: <01d2b24c-a9d2-4be0-8fa0-35d9937eceb4@amazon.com>
Date: Thu, 13 Jun 2024 18:37:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH] Revert "vmgenid: emit uevent when
 VMGENID updates"
To: Lennart Poettering <mzxreary@0pointer.de>, "Jason A. Donenfeld"
	<Jason@zx2c4.com>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, Babis Chalios <bchalios@amazon.es>,
	"Theodore Ts'o" <tytso@mit.edu>, "Cali, Marco" <xmarcalx@amazon.co.uk>, Arnd
 Bergmann <arnd@arndb.de>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"Christian Brauner" <brauner@kernel.org>, <linux@leemhuis.info>,
	<regressions@lists.linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, "Michael
 Kelley (LINUX)" <mikelley@microsoft.com>, Sean Christopherson
	<seanjc@google.com>
References: <20240418114814.24601-1-Jason@zx2c4.com>
 <e09ce9fd-14cb-47aa-a22d-d295e466fbb4@amazon.com>
 <CAHmME9qKFraYWmzD9zKCd4oaMg6FyQGP5pL9bzZP4QuqV1O_Qw@mail.gmail.com>
 <ZieoRxn-On0gD-H2@gardel-login>
 <b819717c-74ea-4556-8577-ccd90e9199e9@amazon.com>
 <Ziujox51oPzZmwzA@zx2c4.com> <Zi9ilaX3254KL3Pp@gardel-login>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <Zi9ilaX3254KL3Pp@gardel-login>
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGV5IEphc29uLAoKT24gMjkuMDQuMjQgMTE6MDQsIExlbm5hcnQgUG9ldHRlcmluZyB3cm90ZToK
PiBPbiBGciwgMjYuMDQuMjQgMTQ6NTIsIEphc29uIEEuIERvbmVuZmVsZCAoSmFzb25AengyYzQu
Y29tKSB3cm90ZToKPgo+PiBJIGRvbid0IHRoaW5rIGFkZGluZyBVQVBJIHRvIGFuIGluZGl2aWR1
YWwgZGV2aWNlIGRyaXZlciBsaWtlIHRoaXMKPiBEb2VzIHZtZ2VuaWQgcmVhbGx5IHF1YWxpZnkg
YXMgImFuIGluZGl2aWR1YWwgZGV2aWNlIGRyaXZlciI/IEl0J3MgYQo+IHByZXR0eSBnZW5lcmlj
IHNvZnR3YXJlIGludGVyZmFjZSwgaW1wbGVtZW50ZWQgYnkgdmFyaW91cyBkaWZmZXJlbnQKPiBW
TU1zIHRoZXNlIGRheXMuIEl0IGlzIGFsc28gdGhlIG9ubHkgaW50ZXJmYWNlIEkgYW0gYXdhcmUg
b2YgdGhhdAo+IGFjdHVhbGx5IGV4aXN0cyBhbmQgd291bGQgcHJvdmlkZSB0aGUgY29uY2VwdCBy
aWdodCBub3c/Cj4KPiBpZiB0aGlzIHdhcyByZWFsbHkgaHlwZXJ2IHNwZWNpZmljLCB0aGVuIEkn
ZCBhZ3JlZSBpdCdzIGp1c3QgYW4KPiAiaW5kaXZpZHVhbCBkZXZpY2UgZHJpdmVyIi4gQnV0IGl0
J3Mgd2lkZWx5IGltcGxlbWVudGVkLCBmb3IgZXhhbXBsZSBhCj4gdHJpdmlhbCBjb21tYW5kIGxp
bmUgc3dpdGNoIGluIHFlbXUuCj4KPiBIZW5jZSwgZm9yIHNvbWV0aGluZyB0aGlzIGdlbmVyaWMs
IGFuZCB3aWRlbHkgZGVwbG95ZWQgd2l0aCBtdWx0aXBsZQo+IGJhY2tlbmQgaW1wbGVtZW50YXRp
b25zIEkgdGhpbmsgd2UgY2FuIHNheSBpdCdzIGtpbmRhIG1vcmUgb2YgYQo+IHN1YnN5c3RlbSBh
bmQgbGVzcyBvZiBhbiBpbmRpdmlkdWFsIGRyaXZlciwgbm8/Cj4KPj4gaXMgYSBnb29kIGFwcHJv
YWNoIGVzcGVjaWFsbHkgY29uc2lkZXJpbmcgdGhhdCB0aGUgdmlydGlvIGNoYW5nZXMgd2UKPj4g
ZGlzY3Vzc2VkIHNvbWUgdGltZSBhZ28gd2lsbCBsaWtlbHkgYXVnbWVudCB0aGlzIGFuZCBjcmVh
dGUgYW5vdGhlcgo+PiBtZWFucyBvZiBhIHNpbWlsYXIgbm90aWZpY2F0aW9uLiBBbmQgZ2l2ZW4g
dGhhdCB0aGlzIGludGVyc2VjdHMgd2l0aAo+PiBvdGhlciB1c2Vyc3BhY2Utb3JpZW50ZWQgd29y
ayBJIGhvcGUgdG8gZ2V0IGJhY2sgdG8gcHJldHR5IHNvb24sIEkKPj4gdGhpbmsgaW50cm9kdWNp
bmcgc29tZSBhZGhvYyBtZWNoYW5pc20gbGlrZSB0aGlzIGFkZHMgY2x1dHRlciBhbmQKPj4gaXNu
J3QgdGhlIGlkZWFsIHdheSBmb3J3YXJkLgo+IElmIG9uZSBkYXkgYSB2aXJ0aW8tYmFzZWQgZXF1
aXZhbGVudCBzaG93cyB1cCwgdGhlbiBJJ2QgYmUgZW50aXJlbHkKPiBmaW5lIHdpdGggc3VwcG9y
dGluZyB0aGlzIGluIHVzZXJzcGFjZSBkaXJlY3RseSB0b28gLCBiZWNhdXNlIHZpcnRpbwo+IHRv
byBpcyBhIGdlbmVyaWMgdGhpbmcgdHlwaWNhbGx5IGltcGxlbWVudGVkIGJ5IG11bHRpcGxlIFZN
TQo+IGJhY2tlbmRzLiBGcm9tIG15IHVzZXJzcGFjZSBwZXJzcGVjdGl2ZSBJIHNlZSBsaXR0bGUg
YmVuZWZpdCBpbiB0aGUKPiBrZXJuZWwgYWJzdHJhY3Rpbmcgb3ZlciB2bWdlbmlkIGFuZCB2aXJ0
aW8tZ2VuaWQgKGlmIHRoYXQgZXZlcgo+IG1hdGVyaWFsaXplcyksIGFzIGEgc3lzdGVtZCBwZXJz
b24gSSBhbSBub3QgYXNraW5nIGZvciB0aGlzIGtpbmQgb2YKPiBhYnN0cmFjdGlvbiAoaW4gY2Fz
ZSBhbnlvbmUgd29uZGVycykuIEEgZ2VuZXJpYyBBQ1BJIGRldmljZSBzdWNoIGFzCj4gdm1nZW5p
ZCBpcyBlbnRpcmVseSBlbm91Z2ggb2YgImdlbmVyaWMiIGZvciBtZS4KPgo+IFRoZSB3YXkgd2Ug
d291bGQgcHJvY2VzcyB0aGUgZXZlbnQgaW4gdXNlcnNwYWNlIGluIHN5c3RlbWQgKGZyb20gYQo+
IHVkZXYgcnVsZSkgaXMgc28gZ2VuZXJpYyB0aGF0IGl0J3MgdHJpdmlhbCB0byBtYXRjaCBhZ2Fp
bnN0IHR3bwo+IGdlbmVyaWMgaW50ZXJmYWNlcywgaW5zdGVhZCBvZiBqdXN0IG9uZS4KPgo+IEFu
ZCBldmVuIGlmIHRoZXJlJ3MgdmFsdWUgaW4gYSBnZW5lcmljIGFic3RyYWN0aW9uIHByb3ZpZGVk
IGJ5IHRoZQo+IGtlcm5lbCBvdmVyIGJvdGggdm1nZW5pZCBhbmQgYSBmdXR1cmUgdmlydGlvLWJh
c2VkIHRoaW5nOiB0aGUga2VybmVsCj4gcGF0Y2ggaW4gcXVlc3Rpb24gd2FzIGEgKnNpbmdsZSog
bGluZSwgYW5kIG91ciBob29rdXAgaW4gdXNlcnNwYWNlCj4gY291bGQgZWFzaWx5IGJlIG1vdmVk
IG92ZXIgd2hlbiB0aGUgZGF5IGNvbWVzLCBiZWNhdXNlIGl0J3MgcmVhbGx5IG5vdAo+IGEgcm9j
a2V0IHNjaWVuY2UgbGV2ZWwgaW50ZXJmYWNlLiBJdCdzIGEgc2luZ2xlIHBhcmFtZXRlcmxlc3Mg
ZXZlbnQsCj4gaG93IG11Y2ggZWFzaWVyIGNvdWxkIHRoaW5ncyBnZXQ/Cj4KPiBJIHVuZGVyc3Rh
bmQgdGhhdCBob3cgdGhpcyBhbGwgaGFwcGVuZWQgd2Fzbid0IHRvIGV2ZXJ5b25lcyB3aXNoZXMs
Cj4gYnV0IGRvIHdlIHJlYWxseSBoYXZlIHRvIG1ha2UgYWxsIG9mIHRoaXMgc28gY29tcGxleCBp
ZiBpdCBjb3VsZCBqdXN0Cj4gYmUgc28gc2ltcGxlPyBXaHkgZGVsYXkgdGhpcyBmdXJ0aGVyLCB3
aHkgZ28gYmFjayBhZ2FpbiBnaXZlbiB0aGUKPiBldmVudCwgdGhlIGludGVyZmFjZSBpdHNlbGYg
aXMgc3VjaCBhbiB1dHRlciB0cml2aWFsaXR5PyBEbyB3ZSByZWFsbHkKPiBtYWtlIHN1Y2ggYSB0
aHJlYXRyZSBhcm91bmQgYSBzaW5nbGUgbGluZSBjaGFuZ2UsIGEgc2luZ2xlIGFkZGl0aW9uYWwK
PiB1ZXZlbnQsIGp1c3QgYmVjYXVzZSBvZiBwb2xpdGljcz8KCgpGcmllbmRseSBwaW5nIGFnYWlu
LiBXZSB3b3VsZCByZWFsbHkgbGlrZSB0byBoYXZlIGEgY29uc3RydWN0aXZlIAp0ZWNobmljYWwg
Y29udmVyc2F0aW9uIGFuZCBjb2xsYWJvcmF0aW9uIG9uIGhvdyB0byBtYWtlIGZvcndhcmQgcHJv
Z3Jlc3MgCndpdGggVk0gY2xvbmUgbm90aWZpY2F0aW9ucyBmb3IgdXNlciBzcGFjZSBhcHBsaWNh
dGlvbnMgdGhhdCBob2xkIHVuaXF1ZSAKZGF0YSBhbmQgaGVuY2UgbmVlZCB0byBsZWFybiBhYm91
dCBWTSBjbG9uZSBldmVudHMsIG91dHNpZGUgb2YgYW55IApyYW5kb21uZXNzIHNlbWFudGljcy4K
CgpUaGFua3MsCgpBbGV4CgoKCgoKQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9wbWVudCBDZW50
ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVl
aHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFt
IEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQgpTaXR6OiBCZXJs
aW4KVXN0LUlEOiBERSAzNjUgNTM4IDU5Nwo=


