Return-Path: <stable+bounces-212864-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCAlG2iHfGmbNgIAu9opvQ
	(envelope-from <stable+bounces-212864-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 11:26:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05808B9559
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 11:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7912300E3AF
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 10:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ACB35E54F;
	Fri, 30 Jan 2026 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWzkMG+8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BF53451CE
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769768778; cv=none; b=FEyDO7tDKgBKcvai7dFhOuNk1C6YeGpxE7Sek2L97ySjNW1lczauPIVUIqG2WWQ2KBkl6iKnnkZy2DjYHaVFSHHOrZl8ju0JrSyvwCxCk61gMBTpyBbyWu+dimlc1BM26lsuDYJtny1ZrWJd6el9Ub85LX0o10MHkuEuydozoI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769768778; c=relaxed/simple;
	bh=KmYz0oNxeQVadBzjVShsDQKy5NXY02pVfuF5hsbrBto=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dyoC7o7DrK/WUFzqplyBdzoFZZBlGo3+DIdP0hrqyFOYW2hQU3JGHUlT4Ze/eQlzzI2ekaylOdg03hEuDDzGkNihNdHOs2kZ+bTof0fVHBfV1awZWbXlHr92Gd23/hwDQxfqcmChp3LfLWfVa1wriWTfe60DKBKixmiuvsoVLx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWzkMG+8; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b885e8c679bso316290766b.1
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 02:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769768776; x=1770373576; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KmYz0oNxeQVadBzjVShsDQKy5NXY02pVfuF5hsbrBto=;
        b=dWzkMG+8kDTPFWfTmAk6JQL3bjvjBybiWqiptqusFFERItdVxAKC5KOdZpGfkVzj3V
         PBTBWJ9xjPUTkfXWi0Ti8uI8OxZmsqUIabFv35ef/dJJNUiyvFG0CcA+XdMPTUqQnWjx
         iL0+Lm85xp2o3bmqJh5bfwGuAYHFbEYPv0pG9KmZE9cPdWGckYsDzIJJKMyIQyIpusQJ
         SGxZNQkA/shXlIvtyDmafQgaaoK2Z1O/rVbPtYMla+WR2SJtVT29Tbc8eR9Q10xZdNlL
         XAzUXTtanszpsUSzAXOHpjZNfWjk8AxBEdpWr/U99LL/4GA/fyIqv7N601V5h/8midut
         gNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769768776; x=1770373576;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmYz0oNxeQVadBzjVShsDQKy5NXY02pVfuF5hsbrBto=;
        b=cCu35GLxpo2wIZgIt83ig2X0S3/2CjLKV+6Veywf5DWx+/LLA2sLmfDYvY6voHj/Uf
         Yd0c4eLNo9vBtpvEX4mRb7831CdiwmDIeJo7p+bHzw7gycftSPTblzp9Yy0Yhx9bhnOU
         AcGvyP8SUqKR7xWeGrtSEzuLQvU+KGHqjZjTG0MRUZ8iWCXQ2qA6eXnk8usZjI/2+HwE
         4mKLWXO6Hzox0reXNKarKqcol8++LO4EqOHZ9rksZwGw7sD1QcGy0I8WyHKSsB3C+xS8
         j9OsplFn36q+Ht9WD/OjpCCCiEb0x8VMEgS10BesTaTBi/D5uVUrNW+yD08GDZsPDgny
         87fA==
X-Forwarded-Encrypted: i=1; AJvYcCVcS5KCnpg3D1nGkgHT6gM5PASXS9NPTRGPTWgW2bTznY91pc2p3+0TKFAmxRta/h/jitG18L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVNY2ZdYoUmZtR3YWYJlejKfpIha0/Xu1/aNJQSIgoHMijUoK0
	nf+CGYWn4AsbejkAcZh8HCWkXGe5ZnSynaUBlab8jgq7r13hVKr2YZTz
X-Gm-Gg: AZuq6aILguy6X3FgwkkFpctDoxHyzVlS6lXIWLiuDRZj5eLiVY6HaQQxIYj2Hmunham
	O9E60BWDlBjDyBiwHvqu/a7H27bAHVusKboPyqb7g27ONj+mNWa+EdVnovDayKMYsNjympoZRiV
	DmfKtqawxefR6LvuYtiGsJ8It5zYQcBHu0oD5AhlDBd5VyLf4FhKsUHGaRZGvTeQ2ajHEYKqZGD
	+Gy4tf9qRyQYGOPZsRV5KOE/EatC1y1onw9X9NFcE7RvjkkYA4RzYpBRsuw8EvqC9Fp7ortcgA6
	cTx+9M3MuvIFf6cEq48ITuxxSm6S2rWyW2BMqRcpGSS4h6upPkiTy9oC1DslhYoIO6pXw0kiyy8
	MGwR26rITb/UYBNPw/OjBhXYJ5s4EDvi8Fised4qm1JjrTfFSF8orew1kigK7b8lrCwgscH6pBY
	2MR38fpr6mD83bjg==
X-Received: by 2002:a17:906:4783:b0:b83:1376:2bb6 with SMTP id a640c23a62f3a-b8dff7a3553mr150244566b.40.1769768775373;
        Fri, 30 Jan 2026 02:26:15 -0800 (PST)
Received: from [10.176.235.211] ([137.201.254.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e04be76afsm86664466b.36.2026.01.30.02.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 02:26:14 -0800 (PST)
Message-ID: <ad7e2d0e5b219b4b2ef2aa7ab342513a2c66171f.camel@gmail.com>
Subject: Re: [PATCH] scsi: ufs: core: Fix RPMB region size detection for UFS
 2.2
From: Bean Huo <huobean@gmail.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman
 <avri.altman@wdc.com>,  Bart Van Assche <bvanassche@acm.org>, "James E.J.
 Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Bean Huo <beanhuo@micron.com>, Can Guo
 <can.guo@oss.qualcomm.com>,  linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 30 Jan 2026 11:26:13 +0100
In-Reply-To: <CAKTNdwG=He3iJ8cPo4fFbcEwQQRrt_SGzoviMhi2a3kMXAO8hA@mail.gmail.com>
References: <20260129-ufs-rpmb-v1-1-691534ab723f@flipper.net>
	 <8149b8cb5a7b36a1543ca05666f33a6373674e0e.camel@gmail.com>
	 <CAKTNdwG=He3iJ8cPo4fFbcEwQQRrt_SGzoviMhi2a3kMXAO8hA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-212864-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huobean@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05808B9559
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAxLTI5IGF0IDIxOjEwICswNDAwLCBBbGV4ZXkgQ2hhcmtvdiB3cm90ZToK
PiBPbiBUaHUsIEphbiAyOSwgMjAyNiBhdCA4OjUz4oCvUE0gQmVhbiBIdW8gPGh1b2JlYW5AZ21h
aWwuY29tPiB3cm90ZToKPiA+IAo+ID4gT24gVGh1LCAyMDI2LTAxLTI5IGF0IDExOjM4ICswNDAw
LCBBbGV4ZXkgQ2hhcmtvdiB3cm90ZToKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGhiYS0+ZGV2X2luZm8ucnBtYl9yZWdpb25fc2l6ZVswXSA9Cj4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZ2V0X3VuYWxpZ25lZF9iZTY0KGRlc2NfYnVmCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICsKPiA+ID4gUlBNQl9VTklUX0RFU0NfUEFSQU1fTE9HSUNBTF9CTEtfQ09VTlQpCj4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgPDwKPiA+ID4gZGVzY19idWZbUlBNQl9VTklUX0RFU0NfUEFSQU1fTE9HSUNBTF9C
TEtfU0laRV0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCA+PiAxNzsgLyogY29udmVydCB0byAxMjgga0J5dGVzIHVuaXRz
ICovCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoCB9Cj4gPiAKPiA+IEhpIEFsZXhleSwKPiA+IAo+ID4gdGhhbmtzIGZvciB5b3VyIGZp
eCwgSSBkaWRuJ3Qgbm90aWNlIHRoZXJlIGlzIFVGUyAyLnggb24gdGhlIG1hcmtldCB3aGljaAo+
ID4gd2lsbAo+ID4gdXNlIFVGUyBPUC1URUUgUlBNQiBmcmFtZXdvcmsuCj4gCj4gSGkgQmVhbiwg
aXQgdHVybnMgb3V0IG1hbnkgb2YgdGhlIFVGUyBtb2R1bGVzIGZvciBSb2NrY2hpcCBSSzM1NzYK
PiBiYXNlZCBkZXZpY2VzIGFyZSAyLjIuIEknbSBwb2tpbmcgYXJvdW5kIHRoZSBPUC1URUUgc3Vw
cG9ydCBvbiB0aGF0Cj4gcGxhdGZvcm0sIGFuZCBkaXNjb3ZlcmVkIHRoYXQgdGhlIGV4aXN0aW5n
IGRyaXZlciBkaWRuJ3Qgc2VlIHRoZSBSUE1CCj4gYXQgYWxsLCBzcGVudCBxdWl0ZSBhIGJpdCBv
ZiB0aW1lIHRyeWluZyB0byBmaWd1cmUgaXQgb3V0IGJlZm9yZQo+IHNwb3R0aW5nIHRoZSBkaWZm
ZXJlbmNlIGJldHdlZW4gdGhlIHR3byBzcGVjIHZlcnNpb25zIDopCj4gCj4gPiBoZXJlIGlzIHBv
dGVudGlhbCB1OCBPdmVyZmxvdywgc2luY2UgZm9yIHRoZSBVRlMzLngrLCBpdCBpcyB1OCBpbiB1
bml0Cj4gPiBkZXNjcmlwdG9yLCBidXQKPiA+IAo+ID4gCj4gPiBUaGUgY2FsY3VsYXRpb24gY2Fu
IG92ZXJmbG93IGZvciBsYXJnZXIgUlBNQiByZWdpb25zICg+MzJNQik6Cj4gPiDCoMKgIC0gQSB1
OCBjYW4gb25seSByZXByZXNlbnQgdXAgdG8gMjU1IMOXIDEyOEtCID0gfjMyTUIKPiA+IMKgwqAg
LSBUaGUgc2hpZnQgcmVzdWx0IGlzIGFzc2lnbmVkIGRpcmVjdGx5IHdpdGhvdXQgYm91bmRzIGNo
ZWNraW5nCj4gCj4gVGhlIHNwZWMgc2F5cyBpdCBjYW4gb25seSBiZSB1cCB0byAxNk1CIG1heGlt
dW0gKHNlZSBzZWN0aW9uIDEyLjQuMy4xCj4gUlBNQiBSZXNvdXJjZXMpLCBzbyBpdCBzaG91bGQg
YWx3YXlzIGZpdC4gSGFwcHkgdG8gYWRkIGEgY29tbWVudCBhYm91dAo+IHRoYXQuCj4gCj4gQmVz
dCByZWdhcmRzLAo+IEFsZXhleQoKSGkgQWxleGV5LAoKVGhhbmtzIGZvciB0aGUgY2xhcmlmaWNh
dGlvbiBvbiB0aGUgMTZNQiBSUE1CIGxpbWl0IC0gdGhhdCBhZGRyZXNzZXMgdGhlCm92ZXJmbG93
IGNvbmNlcm4uCgoKSW4geW91ciBhYm92ZSBvcGVyYXRpb24sIHdoeSBub3QgdXNlIFNaXzEyOEsg
dG8gYXZvaWQgdGhlIG1hZ2ljIG51bWJlcj8KQlRXLCBwbGVhc2UgdXBkYXRlIHlvdXIgY29tbWVu
dC4KCgoKS2luZCByZWdhcmRzLApCZWFuCgo=


