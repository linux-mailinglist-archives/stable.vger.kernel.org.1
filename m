Return-Path: <stable+bounces-223089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLv7OkZlqGl3uQAAu9opvQ
	(envelope-from <stable+bounces-223089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:00:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 044CE204C0E
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A45353007B0E
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 16:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B292436DA03;
	Wed,  4 Mar 2026 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWcybs0B"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D494936C0AA
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643288; cv=none; b=aFFx6rNIrKIcFgxfyOpAEChpk0iZR1rLELJ2BpSbUAwf0aTDvb2rZbXFpLkO/EsG+CAbFMKUqIfpGGB4sBYNEL8JsBHckwe1akUMna2i1KTG8QwKVH/aE8FhlORES5Mg7UVCGEozMo69quxumE4Le7Qe0L92weuDAZBvizrJM6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643288; c=relaxed/simple;
	bh=7gsYWETMH+1iTo+g8emw2P1xiW5TCavv1BNm8926GfY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Message-ID:Date:
	 In-Reply-To:References; b=OQnswev0yniNo4jXmAZ+HqvvaLsNsHAOn1tUJXMS5GOQ5RFefYPM/I+vd5JjW6uy3DN46mGGQposvxdLqWC5T1A6Km5dPSwbZadBQ6A6mNzck65YHJwwaCIjY+rTf8iYPmj6/c4DcWZCI49MJweDc/5W9xFRO3hNBsw2zj80dfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWcybs0B; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48378136adcso42312275e9.1
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 08:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772643285; x=1773248085; darn=vger.kernel.org;
        h=references:in-reply-to:date:message-id:subject:cc:to:from
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gsYWETMH+1iTo+g8emw2P1xiW5TCavv1BNm8926GfY=;
        b=ZWcybs0Bc318HI4gKkHJ7Bjc/2SN7w2Ud7ZTUiNL9AyR0A9pzNQHvmOhSqpXw5sYcQ
         559kkP60SVYba6vdB7zYX4UnHsOGH24wDlXG/kfobzayTCX8ZMtWSf+nZ2l6V/mSsETr
         zoSggis7ZnoXpCzLAiWCL8WmTY9PFuWFxptqu2/+hNSUaBGNMSqYVwziXuGwy7cONy59
         AvOSIg6GjPeg5IhjnFY0fUsYB021HJSE5TvJ0wcbqG3+LpRMZh7LVBfNIHz+VKNIVnFA
         K6BUTOV2JdsW0mJQXk6qxFSFqbep7ILhPs5bHfusNJ3WH8z40aIuEZVXa7OOD08Ezoyo
         7qmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772643285; x=1773248085;
        h=references:in-reply-to:date:message-id:subject:cc:to:from
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gsYWETMH+1iTo+g8emw2P1xiW5TCavv1BNm8926GfY=;
        b=u3xhVASFVrAKQtQNyBdf3vZBwOQN9+fKJLvbHLHx+XklOmo/ZWQMhGCffU6Eyv/G68
         WiAGgyP8w+kCa0d8xu3Wy2le5vw/S7bGcqhiCafKaNFMXRyHUpFsWnsaP3aeHFHkSSwk
         Ij9sYHHiV4LuvVDcp4BEFMVFtOzrEzrbYspmvLtj8kkeBxIz8Aw0VR6z3+ZVTD0eSR8B
         LBl6ofRC8SmklrxqnYvNAo8u09PLmRCOeiBx42BYJrgM0csRdPrvWCLAPcRIrKJHGNQP
         1eXLJ7cpYndz0PVv9BVnpoPr0qtyLuU23xC0hx2uhatPH1WjYjY0vyFcucC8j3BUE8Ny
         rxSA==
X-Gm-Message-State: AOJu0Yyvw538Pb1Or892hCylRopRnuojhw3IdP224J8KfM7folXhvluu
	yutMHAA2qyHB3sUH1tawV+VCO1vyyHncN+f3FsBARBuGXHJKgdSXzp9xBrtUtYASn+Y=
X-Gm-Gg: ATEYQzxXnWI31S33kbvSkWGFuY+sxQXfni+tbEtMb1G65CNtwIuq7urF7+XYAttm6DP
	DE8XdAUXrZc9svILsjbIo+fDOUM3VvjSdswLq08UnbV+jyTkPeVtGzWUyBR+wTAUFbjUYnNR5aQ
	Yqgf8mN6IctqFzMni7atcBx8Dy/IStmCixF5n6teh40GO6OQhvENXnTnj1pLyg4wVMEnMtRIt5F
	5DGPOf2X1wyS4y15vr/qSxlBj17zP7EGqBCqNGNOFDcZf849ByGu3XbOdjPaVfKvAzo/3HDfBA8
	lKWax4IyibXXl+ZFsE5UBvQYzXHg3InUciB8PWtkIboygomyVzDDJ/rx8TZIRX7hzi7b61rdwCf
	xm4yUay9UpmD/FTj7zrBN6glVTujncLXDxlR+gb5q6d484wzk39Y059TRzm3D9Uz2fSgHvmfFIu
	EHsO9KxvIasg7irERSEUXZCG5zT8YE3lIKzZrPvrwrpSq+JD56wPqoJBUiurv8JqvDXxV8bBjL
X-Received: by 2002:a05:600c:4e0f:b0:483:8f0f:36fe with SMTP id 5b1f17b1804b1-48519837c8cmr45664635e9.1.1772643284782;
        Wed, 04 Mar 2026 08:54:44 -0800 (PST)
Received: from [192.168.87.1] ([2001:8f8:1623:5b27:105a:4143:17c9:9894])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851c907a25sm4963385e9.1.2026.03.04.08.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:54:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Natarajan KV <natarajankv91@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de
Subject: [PATCH v3 6.6.y 0/8] netfilter: nft_set_pipapo: move clone allocation to insert/removal path
Message-ID: <1772643278.pipapo-v3.0@gmail.com>
Date: Wed, 04 Mar 2026 20:54:38 +0400
In-Reply-To: <2026030421-grunt-raft-15f0@gregkh>
References: <69a84adc.050a0220.1cea47.3011@mx.google.com> <2026030421-grunt-raft-15f0@gregkh>
X-Rspamd-Queue-Id: 044CE204C0E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223089-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[natarajankv91@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

VGhpcyBpcyBhIGJhY2twb3J0IG9mIHRoZSBmb2xsb3dpbmcgbWFpbmxpbmUgc2VyaWVzIHRvIDYu
Ni4xMjI6CgogIGE1OTBmNDc2MDkyMiAoIm5ldGZpbHRlcjogbmZ0X3NldF9waXBhcG86IG1vdmUg
cHJvdmVfbG9ja2luZyBoZWxwZXIgYXJvdW5kIikKICA4MGVmZDI5OTdmYjkgKCJuZXRmaWx0ZXI6
IG5mdF9zZXRfcGlwYXBvOiBtYWtlIHBpcGFwb19jbG9uZSBoZWxwZXIgcmV0dXJuIE5VTEwiKQog
IDhiOGEyNDE3NTU4YyAoIm5ldGZpbHRlcjogbmZ0X3NldF9waXBhcG86IHByZXBhcmUgZGVzdHJv
eSBmdW5jdGlvbiBmb3Igb24tZGVtYW5kIGNsb25lIikKICA2YzEwOGQ5YmVlNDQgKCJuZXRmaWx0
ZXI6IG5mdF9zZXRfcGlwYXBvOiBwcmVwYXJlIHdhbGsgZnVuY3Rpb24gZm9yIG9uLWRlbWFuZCBj
bG9uZSIpCiAgYzU0NDQ3ODZkMGVhICgibmV0ZmlsdGVyOiBuZnRfc2V0X3BpcGFwbzogbWVyZ2Ug
ZGVhY3RpdmF0ZSBoZWxwZXIgaW50byBjYWxsZXIiKQogIGEyMzgxMDY3MDNhYiAoIm5ldGZpbHRl
cjogbmZ0X3NldF9waXBhcG86IHByZXBhcmUgcGlwYXBvX2dldCBoZWxwZXIgZm9yIG9uLWRlbWFu
ZCBjbG9uZSIpCiAgM2YxZDg4NmNjN2MzICgibmV0ZmlsdGVyOiBuZnRfc2V0X3BpcGFwbzogbW92
ZSBjbG9uaW5nIG9mIG1hdGNoIGluZm8gdG8gaW5zZXJ0L3JlbW92YWwgcGF0aCIpCiAgNTMyYWVj
N2U4NzhiICgibmV0ZmlsdGVyOiBuZnRfc2V0X3BpcGFwbzogcmVtb3ZlIGRpcnR5IGZsYWciKQoK
VGhlIHBpcGFwbyBzZXQgYmFja2VuZCBjdXJyZW50bHkgY2FsbHMgcGlwYXBvX2Nsb25lKCkgZnJv
bSB0aGUgY29tbWl0CmFuZCBhYm9ydCBjYWxsYmFja3MuIFRoZXNlIGNhbGxiYWNrcyBtdXN0IG5v
dCBmYWlsLCBidXQgcGlwYXBvX2Nsb25lKCkKY2FuIGZhaWwgd2l0aCBFTk9NRU0uIFdoZW4gdGhp
cyBoYXBwZW5zLCB0aGUgd29ya2luZyBjb3B5IGVuZHMgdXAgaW4gYQpjb3JydXB0IHN0YXRlOiBm
cmVlZCBlbGVtZW50cyByZW1haW4gYWNjZXNzaWJsZSwgYW5kIHRoZSBkaXJ0eSBmbGFnIHN0YXlz
CnNldCwgY2F1c2luZyB0aGUgbmV4dCBjb21taXQgdG8gcHJvbW90ZSBhIHN0YWxlIGNsb25lLgoK
VGhpcyBzZXJpZXMgbW92ZXMgcGlwYXBvX2Nsb25lKCkgdG8gdGhlIGluc2VydCBhbmQgcmVtb3Zh
bCBwYXRocyB2aWEgYQpuZXcgcGlwYXBvX21heWJlX2Nsb25lKCkgaGVscGVyIHRoYXQgY3JlYXRl
cyB0aGUgd29ya2luZyBjb3B5IG9uIGRlbWFuZAphbmQgY2FuIHByb3BhZ2F0ZSAtRU5PTUVNIHRv
IHRoZSBjYWxsZXIuCgpQYXRjaGVzIDEtNCBjaGVycnktcGljayBjbGVhbmx5IGZyb20gbWFpbmxp
bmUuClBhdGNoZXMgNS04IGFyZSBhZGFwdGVkIGZvciA2LjYuMTIyJ3MgZGlmZmVyZW50IEFQSToK
IC0gbmZ0X3BpcGFwb19mbHVzaCgpIHN0aWxsIHVzZXMgdGhlIHBpcGFwb19kZWFjdGl2YXRlKCkg
aGVscGVyCiAgIChtYWlubGluZSByZW1vdmVkIGl0IHZpYSB0aGUgZWxlbV9wcml2IHJlZmFjdG9y
KQogLSBwaXBhcG9fZ2V0KCkgaGFzIG5vIEdGUCBwYXJhbWV0ZXIgKGFsd2F5cyBHRlBfQVRPTUlD
KQogLSBuZnRfcGlwYXBvX2NvbW1pdCgpIGlzIG5vbi1jb25zdCBpbiA2LjYueAoKQnVpbGQtdGVz
dGVkIHdpdGggYm90aCBuZnRfc2V0X3BpcGFwby5vIGFuZCBuZnRfc2V0X3BpcGFwb19hdngyLm8u
CgpGbG9yaWFuIFdlc3RwaGFsICg4KToKICBuZXRmaWx0ZXI6IG5mdF9zZXRfcGlwYXBvOiBtb3Zl
IHByb3ZlX2xvY2tpbmcgaGVscGVyIGFyb3VuZAogIG5ldGZpbHRlcjogbmZ0X3NldF9waXBhcG86
IG1ha2UgcGlwYXBvX2Nsb25lIGhlbHBlciByZXR1cm4gTlVMTAogIG5ldGZpbHRlcjogbmZ0X3Nl
dF9waXBhcG86IHByZXBhcmUgZGVzdHJveSBmdW5jdGlvbiBmb3Igb24tZGVtYW5kIGNsb25lCiAg
bmV0ZmlsdGVyOiBuZnRfc2V0X3BpcGFwbzogcHJlcGFyZSB3YWxrIGZ1bmN0aW9uIGZvciBvbi1k
ZW1hbmQgY2xvbmUKICBuZXRmaWx0ZXI6IG5mdF9zZXRfcGlwYXBvOiBtZXJnZSBkZWFjdGl2YXRl
IGhlbHBlciBpbnRvIGNhbGxlcgogIG5ldGZpbHRlcjogbmZ0X3NldF9waXBhcG86IHByZXBhcmUg
cGlwYXBvX2dldCBoZWxwZXIgZm9yIG9uLWRlbWFuZCBjbG9uZQogIG5ldGZpbHRlcjogbmZ0X3Nl
dF9waXBhcG86IG1vdmUgY2xvbmluZyBvZiBtYXRjaCBpbmZvIHRvIGluc2VydC9yZW1vdmFsIHBh
dGgKICBuZXRmaWx0ZXI6IG5mdF9zZXRfcGlwYXBvOiByZW1vdmUgZGlydHkgZmxhZwoKIG5ldC9u
ZXRmaWx0ZXIvbmZ0X3NldF9waXBhcG8uYyB8IDE5NiArKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLQogbmV0L25ldGZpbHRlci9uZnRfc2V0X3BpcGFwby5oIHwgICA2IC0tCiAyIGZpbGVz
IGNoYW5nZWQsIDEwNyBpbnNlcnRpb25zKCspLCA5NSBkZWxldGlvbnMoLSkKCi0tIAoyLjM5LjUK

