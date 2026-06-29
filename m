Return-Path: <stable+bounces-269833-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d6iVHYfkQmpyHAoAu9opvQ
	(envelope-from <stable+bounces-269833-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 23:32:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8106DEE03
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 23:32:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=EPDdPGF9;
	dkim=pass header.d=redhat.com header.s=google header.b=OkRjWqJ2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269833-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269833-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F6F1300A25B
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 21:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B17B3CA4B2;
	Mon, 29 Jun 2026 21:32:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8C73C9EF4
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 21:32:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782768759; cv=none; b=cb7qo1h7es/aSBDa5n7/nV+odUopVJqujKd8G+hOAG1p/9/CpjGYbKvHy0O+k/FjG32M5prW/w2gD9wylAD0KUH/v4Whsq8ffh5dcrua8kDP9sw+dovcOXM7JOB0gjeAoODMBduG/xAxoqLTIJ15bCufRwadKxPEjbEVJNMvvg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782768759; c=relaxed/simple;
	bh=CSRk1nqmk8ToNWejBPUj18Gym2Ng80mr6qO9hwj2XTo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PfLs/J2HrHnnkrZ7hYH91dz5yohvJCxPYog5RaoHQCtIVZSKfdGzeD9AiKMgWvNAzY2EfJLKFMONARwT5KlOkgiU3/PojAtzIdix8eGh9+2erZb4JR7s31bViWJZuyR03JAyv5AwuSqRLAAEo3UPEztuwhIwKSBQdUR5jzuUuvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPDdPGF9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OkRjWqJ2; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782768757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CSRk1nqmk8ToNWejBPUj18Gym2Ng80mr6qO9hwj2XTo=;
	b=EPDdPGF9yUhpiicElEoC9cXNQmVZ5DI2mOYo6rv7O9ykjKJletggMRjn5PgCTZHnUUWpc8
	oCRM/O/MAUyY/jNLb2SWejTlDB841zO4zCADlba/Gf7ljKt2Wps7fKatRi1sMUE6KZEW8j
	nU9QKFnG/l7VUWuYXkHMbUGy2TzXKNk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-sIIKpmqnNZGocwJaGzYSvQ-1; Mon, 29 Jun 2026 17:32:32 -0400
X-MC-Unique: sIIKpmqnNZGocwJaGzYSvQ-1
X-Mimecast-MFC-AGG-ID: sIIKpmqnNZGocwJaGzYSvQ_1782768752
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ee593a5a2fso58842206d6.1
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 14:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782768752; x=1783373552; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CSRk1nqmk8ToNWejBPUj18Gym2Ng80mr6qO9hwj2XTo=;
        b=OkRjWqJ24HEbJuJ+WEuQtRnFTRp2tt/vKW72lX6EgSPasFmUGUr6zWNtscqXqCa799
         t4Rctmc6NLhCch3kSSDAp4z8VarmYZRpWotS6TYIM/aaK9n7psL1YMFiyT7tFe7HUczI
         VqdaCaF2sZ1wMQgKCn8Mx0LmIe+wxbHncHif8Bgc74Uyfva6+nA8XDOA/l6WUO1ar10H
         YJOqHGoTApRwNNaUaqu5daek7Vvlt+CwO7b+z8lgKAVCVRi9XSYCRmOC9UnJnOwkt5FU
         5qF63YJXcbnWiSTqI3Agbs/cA9Mbv5WUs0KaQWqqJB6u0ICE6Ir8ilXK5XITEpJFYkh7
         aqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782768752; x=1783373552;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSRk1nqmk8ToNWejBPUj18Gym2Ng80mr6qO9hwj2XTo=;
        b=nH0h3RGoj9U1sDdQSK98epnQIONFOd294i+3HbHyspSXRaScpNOp8PCfVYJOUe4Lkq
         ELIQh4gw41YZzLKzVVj21LGwQ6EXrjfAnNLeEEX4twpIyuIJ6AQjB1uf9rPbxtPSp9Te
         ZkVmia6IRYrd2xLVZvNsMQ7yiW3/wummP+rVSvRFwI9j7W2envVb1BzO6/ZBbOinP5H6
         Hy13LFIKtRrYa57ziDUXTAWdBKyMgl8d/y+LGY5YPvw49ZkF4QE9sUOzAEnEat1Ph/0I
         YmnMdn4uSMF8i/lN1ku6/GdzxId3d3sWeXXznpCQ3FsgLggUA4YRkldH8kAzPTPuq/Ll
         /nLQ==
X-Forwarded-Encrypted: i=1; AHgh+RrGDSchMqA29C6j4xvm7w0H/hKYUTlnvzFi6rtlAPKkymug0V/kjLFrK3PUOMxT198PlJ3hK9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoOaAhbjjp4LQ8B1HzJ5fLUZJ3ktVqgLsZpQId4MmZC41X97cQ
	lsvfBoUjKb/ZJ84EXaAu5KQAqMYa3vlZroerHNSegX2v4L6Ow0vBqInNnRQMSOZtYr3yNGdbEbo
	nSof/CxvwrTbVvHuajquBL/yqpENvOV3bbp58KtA7z+r6IYInhkohrlkLDg==
X-Gm-Gg: AfdE7cmpwOpYQTf6ktSym96iPEto0l3leB7bsEKqbokeojTVyDvvl0Xa/uDmLqkgr3Q
	98WCUuqR6beQLACp+vG0njP+x5DuCclafWnwsEMOKb5iK8DZ4DuigwtZkJ885k+iphyMdLCoLYb
	E4/z8wQ5RTgq0KKsMZsVE3FmATC/KPoY6NiRZDVMgrYDJjL1kxvEKFabQgEFJ8iG/jhswJznAWJ
	6csB9z0vISngu8I4Bq57Dq+7SxRute2+3eueVa9tJwvwu/ddg2zAqYdApf76SF4xpYVtVM+6EUT
	tpH5zw9mj1/Bm6QQg6Dw29YNsDia5IAlAIdcBx8JHw0TcsTn9/W0/xUP7qRlPBYbO/ihKiK+AHp
	uzB+xzGE=
X-Received: by 2002:ad4:4eab:0:b0:8ee:d9b8:8538 with SMTP id 6a1803df08f44-8f1bc95fc6emr16241926d6.9.1782768752215;
        Mon, 29 Jun 2026 14:32:32 -0700 (PDT)
X-Received: by 2002:ad4:4eab:0:b0:8ee:d9b8:8538 with SMTP id 6a1803df08f44-8f1bc95fc6emr16241016d6.9.1782768751191;
        Mon, 29 Jun 2026 14:32:31 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a7b2699dsm7151196d6.46.2026.06.29.14.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 14:32:30 -0700 (PDT)
Message-ID: <24195bd1807ba2b47b80a30050d12ec010ba4f1f.camel@redhat.com>
Subject: Re: [PATCH v5 01/19] rust: drm: ioctl: fix unbounded lifetimes in
 ioctl handler arguments
From: lyude@redhat.com
To: Danilo Krummrich <dakr@kernel.org>, aliceryhl@google.com, 
	daniel.almeida@collabora.com, acourbot@nvidia.com, ecourtney@nvidia.com, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, 	lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, 	deborah.brouwer@collabora.com,
 boris.brezillon@collabora.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org,
 sashiko-bot@kernel.org
Date: Mon, 29 Jun 2026 17:32:29 -0400
In-Reply-To: <20260628145406.2107056-2-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
	 <20260628145406.2107056-2-dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dakr@kernel.org,m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:acourbot@nvidia.com,m:ecourtney@nvidia.com,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:deborah.brouwer@collabora.com,m:boris.brezillon@collabora.com,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:rust-for-linux@vger.kernel.org,m:stable@vger.kernel.org,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lyude@redhat.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269833-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[kernel.org,google.com,collabora.com,nvidia.com,garyguo.net,protonmail.com,umich.edu];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[lyude@redhat.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F8106DEE03

dGhpcyBtYWNybyBpcyB3aWxkLgoKUmV2aWV3ZWQtYnk6IEx5dWRlIFBhdWwgPGx5dWRlQHJlZGhh
dC5jb20+CgpPbiBTdW4sIDIwMjYtMDYtMjggYXQgMTY6NTMgKzAyMDAsIERhbmlsbyBLcnVtbXJp
Y2ggd3JvdGU6Cj4gUmVmZXJlbmNlcyB0byBkZXYsIGRhdGEsIGFuZCBmaWxlIGluIHRoZSBkZWNs
YXJlX2RybV9pb2N0bHMhIG1hY3JvCj4gYXJlCj4gY3JlYXRlZCB2aWEgdW5zYWZlIHBvaW50ZXIg
ZGVyZWZlcmVuY2VzLCBwcm9kdWNpbmcgdW5ib3VuZGVkCj4gbGlmZXRpbWVzLgo+IElmIGFuIGlv
Y3RsIGhhbmRsZXIgZXhwbGljaXRseSBhbm5vdGF0ZXMgaXRzIHBhcmFtZXRlcnMgd2l0aCAnc3Rh
dGljLAo+IHRoZSBjb21waWxlciBhY2NlcHRzIHRoaXMsIGFsbG93aW5nIHRoZSBoYW5kbGVyIHRv
IHN0YXNoIHJlZmVyZW5jZXMKPiB0aGF0Cj4gb3V0bGl2ZSB0aGUgaW9jdGwgY2FsbC4KPiAKPiBG
aXggdGhpcyBieSBhZGRpbmcgYSBoaWdoZXItcmFua2VkIGZ1bmN0aW9uIHBvaW50ZXIgY29lcmNp
b24gdGhhdAo+IGVuZm9yY2VzIHRoZSBoYW5kbGVyIGFjY2VwdHMgdW5pdmVyc2FsbHkgcXVhbnRp
ZmllZCBsaWZldGltZXM6Cj4gCj4gwqAgbGV0IF86IGZvcjwnYT4gZm4oJidhIF8sICYnYSBtdXQg
XywgJidhIF8pIC0+IF8gPSAkZnVuYzsKPiAKPiBTaW5jZSB0aGUgaGFuZGxlciBtdXN0IGJlIGNv
ZXJjaWJsZSB0byBhIGZ1bmN0aW9uIHBvaW50ZXIgYWNjZXB0aW5nCj4gYW55Cj4gbGlmZXRpbWUg
J2EsIGl0IGNhbiBubyBsb25nZXIgZGVtYW5kICdzdGF0aWMgb24gYW55IHBhcmFtZXRlci4KPiAK
PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+IEZpeGVzOiA5YTY5NTcwNjgyYjEgKCJydXN0
OiBkcm06IGlvY3RsOiBBZGQgRFJNIGlvY3RsIGFic3RyYWN0aW9uIikKPiBSZXBvcnRlZC1ieTog
c2FzaGlrby1ib3RAa2VybmVsLm9yZwo+IENsb3NlczoKPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvMjAyNjA2MjAwMTEzNDYuQTQ3RDAxRjAwMEU5QHNtdHAua2VybmVsLm9yZy8KPiBTdWdn
ZXN0ZWQtYnk6IEdhcnkgR3VvIDxnYXJ5QGdhcnlndW8ubmV0Pgo+IFNpZ25lZC1vZmYtYnk6IERh
bmlsbyBLcnVtbXJpY2ggPGRha3JAa2VybmVsLm9yZz4KPiAtLS0KPiDCoHJ1c3Qva2VybmVsL2Ry
bS9pb2N0bC5ycyB8IDYgKysrKysrCj4gwqAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
Cj4gCj4gZGlmZiAtLWdpdCBhL3J1c3Qva2VybmVsL2RybS9pb2N0bC5ycyBiL3J1c3Qva2VybmVs
L2RybS9pb2N0bC5ycwo+IGluZGV4IGNmMzI4MTAxZGRlNC4uY2NmNDE1MGQ4M2I2IDEwMDY0NAo+
IC0tLSBhL3J1c3Qva2VybmVsL2RybS9pb2N0bC5ycwo+ICsrKyBiL3J1c3Qva2VybmVsL2RybS9p
b2N0bC5ycwo+IEBAIC0xMzUsNiArMTM1LDEyIEBAIG1hY3JvX3J1bGVzISBkZWNsYXJlX2RybV9p
b2N0bHMgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC8vIGRldi9maWxlIG1hdGNoIHRoZSBjdXJyZW50IGRyaXZlcgo+IHRoZXNlIGlv
Y3RscyBhcmUgYmVpbmcgZGVjbGFyZWQKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvLyBmb3IsIGFuZCBpdCdzIG5vdCBjbGVhciBob3cg
dG8KPiBlbmZvcmNlIHRoaXMgd2l0aGluIHRoZSB0eXBlIHN5c3RlbS4KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsZXQgZGV2ID0KPiAk
Y3JhdGU6OmRybTo6ZGV2aWNlOjpEZXZpY2U6OmZyb21fcmF3KHJhd19kZXYpOwo+ICsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8vIEVu
Zm9yY2UgdGhhdCB0aGUgaGFuZGxlciBhY2NlcHRzCj4gaGlnaGVyLXJhbmtlZAo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLy8gbGlmZXRp
bWVzLCBwcmV2ZW50aW5nIGl0IGZyb20KPiByZXF1aXJpbmcgJ3N0YXRpYwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLy8gcmVmZXJlbmNl
cyB0aGF0IGNvdWxkIGVzY2FwZSB0aGlzCj4gc2NvcGUuCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsZXQgXzogZm9yPCdhPiBmbigmJ2Eg
XywgJidhIG11dCBfLCAmJ2EKPiBfKSAtPiBfID0gJGZ1bmM7Cj4gKwo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8vIFNBRkVUWTogVGhl
IGlvY3RsIGFyZ3VtZW50IGhhcyBzaXplCj4gYF9JT0NfU0laRShjbWQpYCwgd2hpY2ggd2UKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAv
LyBhc3NlcnRlZCBhYm92ZSBtYXRjaGVzIHRoZSBzaXplIG9mCj4gdGhpcyB0eXBlLCBhbmQgYWxs
IGJpdCBwYXR0ZXJucyBvZgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC8vIFVBUEkgc3RydWN0cyBtdXN0IGJlIHZhbGlkLgo=


