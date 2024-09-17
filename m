Return-Path: <stable+bounces-76619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 564F397B4F0
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 22:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894C41C221E8
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 20:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C1427470;
	Tue, 17 Sep 2024 20:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="X0jv3Jpe"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B21187851;
	Tue, 17 Sep 2024 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726606532; cv=none; b=SyhYM4nWlTxeVGAiNHlS4yXjuhR87reUCs/rsaGtATAmcE6F6u1rgD0PHo4lfkPt/mIvYUInIkYWoSGLN/DmWNc8b6ByXWm/ua66cE9LqXBvnnNVJsGpebv0Lstk4jSlV7ztyt72jZX2efoWtGE8OJZ8kN6dge3vnSu1zdAlcaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726606532; c=relaxed/simple;
	bh=0HRbMpgSpWuJMfbAKur5WSqdhmw4LM9drJ989gsTTeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CxucIP2NuqUPlb+g1Ivrvoinwc9PbmPWVlYPxjllbdnVWiqHD6b+Qjn3pgMCzaUKTIeOpxw+6y/lK/8jbN/Vh/8ALlc4KYgN0j42/FSNE/gSh8zN8k1f9lemiN/En+g6Ta3oqiaxDNHvNMFxHV53xk2fS/d3D8zw9I6e8Xaftw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=X0jv3Jpe; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1726606530; x=1758142530;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0HRbMpgSpWuJMfbAKur5WSqdhmw4LM9drJ989gsTTeM=;
  b=X0jv3Jpe8DJdxU2xuCctufQ+/eW/znu84c4DH6yi9SAlesTBkvCm8y9N
   9ED1pUTEX6+prX17bxPFFwYrvtH+K6ujGJ8GLEh6BMhcwSgakQh6XkoDC
   ryTHjEInvAcfcaS9GEB3sU6lc25R+C2BM2/F4wYGfFqAm07uX9OANVypI
   s=;
X-IronPort-AV: E=Sophos;i="6.10,235,1719878400"; 
   d="scan'208";a="126870230"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 20:55:28 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:51685]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.45:2525] with esmtp (Farcaster)
 id c2281199-2c62-4271-b314-23e8901afbbe; Tue, 17 Sep 2024 20:55:28 +0000 (UTC)
X-Farcaster-Flow-ID: c2281199-2c62-4271-b314-23e8901afbbe
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 17 Sep 2024 20:55:28 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Tue, 17 Sep 2024
 20:55:23 +0000
Message-ID: <84c3696d-8108-4a2e-90d7-7830ca6cc3b9@amazon.com>
Date: Tue, 17 Sep 2024 22:55:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH] Revert "vmgenid: emit uevent when
 VMGENID updates"
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: Lennart Poettering <mzxreary@0pointer.de>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Babis Chalios
	<bchalios@amazon.es>, Theodore Ts'o <tytso@mit.edu>, "Cali, Marco"
	<xmarcalx@amazon.co.uk>, Arnd Bergmann <arnd@arndb.de>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, Christian Brauner <brauner@kernel.org>,
	<linux@leemhuis.info>, <regressions@lists.linux.dev>, Paolo Bonzini
	<pbonzini@redhat.com>, "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
	Sean Christopherson <seanjc@google.com>
References: <20240418114814.24601-1-Jason@zx2c4.com>
 <e09ce9fd-14cb-47aa-a22d-d295e466fbb4@amazon.com>
 <CAHmME9qKFraYWmzD9zKCd4oaMg6FyQGP5pL9bzZP4QuqV1O_Qw@mail.gmail.com>
 <ZieoRxn-On0gD-H2@gardel-login>
 <b819717c-74ea-4556-8577-ccd90e9199e9@amazon.com>
 <Ziujox51oPzZmwzA@zx2c4.com> <Zi9ilaX3254KL3Pp@gardel-login>
 <01d2b24c-a9d2-4be0-8fa0-35d9937eceb4@amazon.com>
 <CAHmME9rxn5KJJBOC3TqTEgotnsFO5r6F-DJn3ekc5ZgW8OaCFw@mail.gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CAHmME9rxn5KJJBOC3TqTEgotnsFO5r6F-DJn3ekc5ZgW8OaCFw@mail.gmail.com>
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDE3LjA5LjI0IDIwOjA0LCBKYXNvbiBBLiBEb25lbmZlbGQgd3JvdGU6Cj4gT24gVGh1LCBK
dW4gMTMsIDIwMjQgYXQgNjozN+KAr1BNIEFsZXhhbmRlciBHcmFmIDxncmFmQGFtYXpvbi5jb20+
IHdyb3RlOgo+PiBGcmllbmRseSBwaW5nIGFnYWluLiBXZSB3b3VsZCByZWFsbHkgbGlrZSB0byBo
YXZlIGEgY29uc3RydWN0aXZlCj4+IHRlY2huaWNhbCBjb252ZXJzYXRpb24gYW5kIGNvbGxhYm9y
YXRpb24gb24gaG93IHRvIG1ha2UgZm9yd2FyZCBwcm9ncmVzcwo+PiB3aXRoIFZNIGNsb25lIG5v
dGlmaWNhdGlvbnMgZm9yIHVzZXIgc3BhY2UgYXBwbGljYXRpb25zIHRoYXQgaG9sZCB1bmlxdWUK
Pj4gZGF0YSBhbmQgaGVuY2UgbmVlZCB0byBsZWFybiBhYm91dCBWTSBjbG9uZSBldmVudHMsIG91
dHNpZGUgb2YgYW55Cj4+IHJhbmRvbW5lc3Mgc2VtYW50aWNzLgo+IFdpdGggdGhlIG90aGVyIHdv
cmsgbm93IG1vc3RseSBkb25lLCBzdXJlLCBsZXQncyBwaWNrIHRoaXMgdXAgYWdhaW4uIEkKPiB0
aGluayBuZXh0IG9uIHRoZSBsaXN0IHdhcyBnZXR0aW5nIHRoZSB2aXJ0aW8gcm5nIGRldmljZSBk
ZWxpdmVyaW5nIFZNCj4gY2xvbmUgZXZlbnRzIGFuZCB1bmlxdWUgVVVJRHMuIFRoZXJlIHdhcyBh
IHNwZWMgY2hhbmdlIHBvc3RlZCBhIHdoaWxlCj4gYmFjayBhbmQgYSBwYXRjaCBmb3IgdGhlIGtl
cm5lbC4gRG8geW91IHdhbnQgdG8gcmVmcmVzaCB0aG9zZT8gSQo+IHRob3VnaHQgdGhhdCB3YXMg
YSBwcm9taXNpbmcgZGlyZWN0aW9uIC0tIGFuZCB0aGUgb25lIHdlIGFsbCBkZWNpZGVkCj4gdG9n
ZXRoZXIgaW4gcGVyc29uIGFzIHRoZSBtb3N0IHZpYWJsZSwgcmFjZS1mcmVlIHdheSwgZXRjIC0t
Cj4gZXNwZWNpYWxseSBiZWNhdXNlIGl0IHdvdWxkIG1ha2Ugd2F5cyBvZiBleHBvc2luZyB0aG9z
ZSBJRHMgbG93IGNvc3QuCj4gQW5kLCBpbXBvcnRhbnRseSBmb3IgeW91LCBJIHRoaW5rIHRoYXQg
bWlnaHQgKmFsc28qIGNvdmVyIHRoZSBuZWVkCj4gdGhhdCB5b3UgaGF2ZSBoZXJlLCBzbyB3ZSds
bCBraWxsIHNldmVyYWwgYmlyZHMgd2l0aCBvbmUgc3RvbmUuCgoKVGhlIHZpcnRpbyBwcm9wb3Nh
bCBvbmx5IGFkZHJlc3NlZCBjb25zdW1lcnMgdGhhdCByZXF1aXJlIHNpbmdsZSBhdG9taWMgCm1l
bW9yeSB1cGRhdGVzIHRvIGxlYXJuIGFib3V0IGFueSBldmVudCB0aGF0IGlzIGRpc3J1cHRpdmUg
dG8gdGhlaXIgCmVudHJvcHkgc291cmNlcy4gV2l0aCB2Z2V0cmFuZG9tIGFuZC9vciByZHJhbmQg
d2Ugc29sdmVkIHRoYXQgcHJvYmxlbSwgCnNvIHdlIGNhbiBjbG9zZSB0aGUgY2hhcHRlciBvZiB0
aGF0IGNsYXNzIG9mIHVzZSBjYXNlcy4KCldoYXQgaXMgc3RpbGwgb3BlbiBhcmUgdXNlciBzcGFj
ZSBhcHBsaWNhdGlvbnMgdGhhdCByZXF1aXJlIGV2ZW50IGJhc2VkIApub3RpZmljYXRpb24gb24g
Vk0gY2xvbmUgZXZlbnRzIC0gYW5kICpvbmx5KiBWTSBjbG9uZSBldmVudHMuIFRoaXMgCm1vc3Rs
eSBjYXRlcnMgZm9yIHRvb2xzIGxpa2Ugc3lzdGVtZCB3aGljaCBuZWVkIHRvIGV4ZWN1dGUgcG9s
aWN5IC0gc3VjaCAKYXMgZ2VuZXJhdGluZyByYW5kb21seSBnZW5lcmF0ZWQgTUFDIGFkZHJlc3Nl
cyAtIGluIHRoZSBldmVudCBhIFZNIHdhcyAKY2xvbmVkLgoKVGhhdCdzIHRoZSB1c2UgY2FzZSB0
aGlzIHBhdGNoICJ2bWdlbmlkOiBlbWl0IHVldmVudCB3aGVuIFZNR0VOSUQgCnVwZGF0ZXMiIGlz
IGFib3V0IGFuZCBJIHRoaW5rIHRoZSBiZXN0IHBhdGggZm9yd2FyZCBpcyB0byBqdXN0IHJldmVy
dCAKdGhlIHJldmVydC4gQSB1ZXZlbnQgZnJvbSB0aGUgZGV2aWNlIGRyaXZlciBpcyBhIHdlbGwg
ZXN0YWJsaXNoZWQsIHdlbGwgCmZpdHRpbmcgTGludXggbWVjaGFuaXNtIGZvciB0aGF0IHR5cGUg
b2Ygbm90aWZpY2F0aW9uLgoKCkFsZXgKCgoKCkFtYXpvbiBXZWIgU2VydmljZXMgRGV2ZWxvcG1l
bnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hh
ZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRy
YWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMjU3NzY0IEIKU2l0
ejogQmVybGluClVzdC1JRDogREUgMzY1IDUzOCA1OTcK


