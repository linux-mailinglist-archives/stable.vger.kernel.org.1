Return-Path: <stable+bounces-233679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKIMLkYq1Wli1wcAu9opvQ
	(envelope-from <stable+bounces-233679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:01:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED3E3B171B
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D41A9301E035
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 16:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F023CF683;
	Tue,  7 Apr 2026 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="va4IW1vv"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5277E3CAE73
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577646; cv=none; b=CgmA5uKyqyISsQIzi05knb11ntYNyzXi/B0ycAdd7S3+Q1qeFpNagqxe5owVTM6reNMy6DqB5D2NTRp8wlkiR/sF+CszfN783LKdM7sx5iVDLH3/H4iqaSxrWWQlyosMmqCNubCBxfubhYwdEMn7UfZVeTbSzXgD8TAqiFFsWVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577646; c=relaxed/simple;
	bh=09S94OVk0XUqKTN/NkAUF2rL3SdZ1+OsE4WxCUGG0Nc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=RQ+0TQyhFfdRWDzHkhJcIrQy1rF8ZOwjjbnuaCedMDwJF315IVkFgq5xw+HbYxlG864szHN9IHBc0rJ37a6jTSVdMlqjv2kMeKFJLyH57PnXQ0vg/CJXONM1WE6ExXcNkuVWiRphEyqJ6eoYPLMne3B0NP+m/sfBT3Fqq8CdpmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=va4IW1vv; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-471618e202bso582819b6e.2
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 09:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775577633; x=1776182433; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzJJs6ngvTmHYREeExmUtaqrvlSpnYtWdK2ySCaiyLs=;
        b=va4IW1vv14nHu0t/Xylgvid4nV3X3gzIAf+BnNCxsizihsIP0fhbR/d8E8mN8d9vEB
         fmPQm0LChAkA+rMGDafb8O6sc/aqqBkCgmS6HwtQrkdTxZ/lBK53EVtUv4gsTfO7TXaK
         B30Z9Fv0O/vwCIM2Be4jg4pN70gQ/BK6bdlmKqnkij6XN/5s7myTPBaSFQ6GFqt03jBs
         os9Ty3+dPJccxo8v8E8S7+ozTu1giIEN5WorGK1CIcBPgXIiqaC3J3jbaVWoMYlzjVhi
         IiFCEw+COKS3vvv3cpPz6udMzqAWqQ7wMASrol2pS7f06pq2q/3mL7Q02ncHhSTmbqJT
         954w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775577633; x=1776182433;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XzJJs6ngvTmHYREeExmUtaqrvlSpnYtWdK2ySCaiyLs=;
        b=Z/bjGjioVJDhbVxa8wsvvFrNm7/5i+FVkIFtp2xQ7M0n3qtNrXYEPwNO0zDSTtkThH
         SB9HONvGEKPvLxx5oyPhNJaR/O5g2GAZ0VXlLq7sQbBtOaKaUMgaWa4GPw2R4DgYSqVI
         BQwYH1LKGSkFr089G0N2rV0DML5XBqpQawhYLBNn1iF4R3TIxldPdwiTzQfuath5zdxt
         O9jHBxD/EaRuR4h5nEenT6VmdA97BOAd/MKFesYXzxY9iZu1+/xqo68seLjesTKm8ODu
         DFaTI0SVj6z378b4qI5X3fWLCZq0lQZlZtJbOs7JDgJNrXNeaV8agWFBclUs4jsGggoH
         c1Ug==
X-Gm-Message-State: AOJu0Yw9RtfLtane5Tq0EQCcKL7UWr+QZkr2VrUbIA9yWFWA7rJn4bDi
	OgwmJNAy0UFepCU+rkbTEh3XZOniX08QNCkHs3W9yW9u5c4u3Q1EPI2sQRkhBaIBsXZtqsKo2G7
	7uR7M
X-Gm-Gg: AeBDietalBXny3GvRh4/ZFG1c4gvNIunukwtOq666bi3zz+BoxN7shJPI2uPWFx0IKQ
	ZzYTbZ4xiXl/fz2uMmoagQKZWpszEJ5xhXJlVnYHSaI/RF1OofSGoPnuhf8YMaJG5ay9uqhk0AK
	/VQesY8jtqT9C+/r6gHDhlm4zXbzuS/E2h1mrLH/IuadCMm/ApGAwkSa3P/ErrtrdlTVcM1IKKG
	jaj2sBveiMfFpUdcW8vIWVUSIq7mHRIruZHWoUOspMUvyLssPWIwytBWh71U5Y3ptNeFtmVg/jT
	vEZhWoX95Owlmk+8lAzIdHp0X77NXoPLYz+Ylh5z8RFNJoRSTLoJZPZh142cQwbMHP2BpQJAPKn
	7KG8oJvhn3H7pkCkVNg9qX8Z0WkXDcxgEiXSgnO55lSuh9cJT2iIST2rd4vvHI+ux9oDdTYJbzp
	HZJXoxMxHhOZHIift/PeEzGWKHNQInd38rIe6tik+0rNcNmi10VsAXmEKNEXLVsK7zU9RBdV0wR
	NHD8Mju
X-Received: by 2002:a05:6808:6f91:b0:467:32c1:ad0e with SMTP id 5614622812f47-46ef7a120f2mr7790724b6e.36.1775577633270;
        Tue, 07 Apr 2026 09:00:33 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46d93167969sm9946711b6e.14.2026.04.07.09.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 09:00:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------qu5L9Q3D27mApKqetVp0MG0U"
Message-ID: <0421b20e-0e77-4d88-bbb8-69ae3c6a6b25@kernel.dk>
Date: Tue, 7 Apr 2026 10:00:28 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: protect remaining lockless
 ctx->rings accesses with" failed to apply to 6.18-stable tree
To: gregkh@linuxfoundation.org, qjx1298677004@gmail.com
Cc: stable@vger.kernel.org
References: <2026040713-lucid-wireless-bd2e@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026040713-lucid-wireless-bd2e@gregkh>
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233679-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RSPAMD_EMAILBL_FAIL(0.00)[gregkh.linuxfoundation.org:query timed out];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,kernel.dk:email,kernel.dk:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9ED3E3B171B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.
--------------qu5L9Q3D27mApKqetVp0MG0U
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/7/26 8:55 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
> git checkout FETCH_HEAD
> git cherry-pick -x 61a11cf4812726aceaee17c96432e1c08f6ed6cb
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040713-lucid-wireless-bd2e@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Just in case, here's the patch for 6.18, as mentioned the same as the 6.19
backport.

-- 
Jens Axboe

--------------qu5L9Q3D27mApKqetVp0MG0U
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-protect-remaining-lockless-ctx-rings-access.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-protect-remaining-lockless-ctx-rings-access.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAxN2JkMjk0NjZlOWMwMzc3MjBmYjkyMjYzNWYwNjE1NTQ1ZjY1ZDE0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFR1ZSwgMzEgTWFyIDIwMjYgMDc6MDc6NDcgLTA2MDAKU3ViamVjdDogW1BBVENIXSBp
b191cmluZzogcHJvdGVjdCByZW1haW5pbmcgbG9ja2xlc3MgY3R4LT5yaW5ncyBhY2Nlc3Nl
cyB3aXRoCiBSQ1UKCkNvbW1pdCA2MWExMWNmNDgxMjcyNmFjZWFlZTE3Yzk2NDMyZTFjMDhm
NmVkNmNiIHVwc3RyZWFtLgoKQ29tbWl0IDk2MTg5MDgwMjY1ZSBhZGRyZXNzZWQgb25lIGNh
c2Ugb2YgY3R4LT5yaW5ncyBiZWluZyBwb3RlbnRpYWxseQphY2Nlc3NlZCB3aGlsZSBhIHJl
c2l6ZSBpcyBoYXBwZW5pbmcgb24gdGhlIHJpbmcsIGJ1dCB0aGVyZSBhcmUgc3RpbGwKYSBm
ZXcgb3RoZXJzIHRoYXQgbmVlZCBoYW5kbGluZy4gQWRkIGEgaGVscGVyIGZvciByZXRyaWV2
aW5nIHRoZQpyaW5ncyBhc3NvY2lhdGVkIHdpdGggYW4gaW9fdXJpbmcgY29udGV4dCwgYW5k
IGFkZCBzb21lIHNhbml0eSBjaGVja2luZwp0byB0aGF0IHRvIGNhdGNoIGJhZCB1c2VzLiAt
PnJpbmdzX3JjdSBpcyBhbHdheXMgdmFsaWQsIGFzIGxvbmcgYXMgaXQncwp1c2VkIHdpdGhp
biBSQ1UgcmVhZCBsb2NrLiBBbnkgdXNlIG9mIC0+cmluZ3NfcmN1IG9yIC0+cmluZ3MgaW5z
aWRlCmVpdGhlciAtPnVyaW5nX2xvY2sgb3IgLT5jb21wbGV0aW9uX2xvY2sgaXMgc2FuZSBh
cyB3ZWxsLgoKRG8gdGhlIG1pbmltdW0gZml4IGZvciB0aGUgY3VycmVudCBrZXJuZWwsIGJ1
dCBzZXQgaXQgdXAgc3VjaCB0aGF0IHRoaXMKYmFzaWMgaW5mcmEgY2FuIGJlIGV4dGVuZGVk
IGZvciBsYXRlciBrZXJuZWxzIHRvIG1ha2UgdGhpcyBoYXJkZXIgdG8KbWVzcyB1cCBpbiB0
aGUgZnV0dXJlLgoKVGhhbmtzIHRvIEp1bnhpIFFpYW4gZm9yIGZpbmRpbmcgYW5kIGRlYnVn
Z2luZyB0aGlzIGlzc3VlLgoKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKRml4ZXM6IDc5
Y2ZlOWU1OWMyYSAoImlvX3VyaW5nL3JlZ2lzdGVyOiBhZGQgSU9SSU5HX1JFR0lTVEVSX1JF
U0laRV9SSU5HUyIpClJldmlld2VkLWJ5OiBKdW54aSBRaWFuIDxxangxMjk4Njc3MDA0QGdt
YWlsLmNvbT4KVGVzdGVkLWJ5OiBKdW54aSBRaWFuIDxxangxMjk4Njc3MDA0QGdtYWlsLmNv
bT4KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvaW8tdXJpbmcvMjAyNjAzMzAxNzIz
NDguODk0MTYtMS1xangxMjk4Njc3MDA0QGdtYWlsLmNvbS8KU2lnbmVkLW9mZi1ieTogSmVu
cyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPgotLS0KIGlvX3VyaW5nL2lvX3VyaW5nLmMgfCA2
MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0KIGlvX3Vy
aW5nL2lvX3VyaW5nLmggfCAzNCArKysrKysrKysrKysrKysrKysrKystLS0tCiAyIGZpbGVz
IGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2lvX3VyaW5nL2lvX3VyaW5nLmMgYi9pb191cmluZy9pb191cmluZy5jCmluZGV4IGFj
MWE1Y2YxMDI4Ny4uODRmYjFmN2IwZDgxIDEwMDY0NAotLS0gYS9pb191cmluZy9pb191cmlu
Zy5jCisrKyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKQEAgLTE4OSwxMiArMTg5LDE1IEBAIHN0
YXRpYyB2b2lkIGlvX3BvaXNvbl9yZXEoc3RydWN0IGlvX2tpb2NiICpyZXEpCiAKIHN0YXRp
YyBpbmxpbmUgdW5zaWduZWQgaW50IF9faW9fY3FyaW5nX2V2ZW50cyhzdHJ1Y3QgaW9fcmlu
Z19jdHggKmN0eCkKIHsKLQlyZXR1cm4gY3R4LT5jYWNoZWRfY3FfdGFpbCAtIFJFQURfT05D
RShjdHgtPnJpbmdzLT5jcS5oZWFkKTsKKwlzdHJ1Y3QgaW9fcmluZ3MgKnJpbmdzID0gaW9f
Z2V0X3JpbmdzKGN0eCk7CisJcmV0dXJuIGN0eC0+Y2FjaGVkX2NxX3RhaWwgLSBSRUFEX09O
Q0UocmluZ3MtPmNxLmhlYWQpOwogfQogCiBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBf
X2lvX2NxcmluZ19ldmVudHNfdXNlcihzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCkKIHsKLQly
ZXR1cm4gUkVBRF9PTkNFKGN0eC0+cmluZ3MtPmNxLnRhaWwpIC0gUkVBRF9PTkNFKGN0eC0+
cmluZ3MtPmNxLmhlYWQpOworCXN0cnVjdCBpb19yaW5ncyAqcmluZ3MgPSBpb19nZXRfcmlu
Z3MoY3R4KTsKKworCXJldHVybiBSRUFEX09OQ0UocmluZ3MtPmNxLnRhaWwpIC0gUkVBRF9P
TkNFKHJpbmdzLT5jcS5oZWFkKTsKIH0KIAogc3RhdGljIGlubGluZSB2b2lkIHJlcV9mYWls
X2xpbmtfbm9kZShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgaW50IHJlcykKQEAgLTI1MzYsMTIg
KzI1MzksMTUgQEAgc3RhdGljIGVudW0gaHJ0aW1lcl9yZXN0YXJ0IGlvX2NxcmluZ19taW5f
dGltZXJfd2FrZXVwKHN0cnVjdCBocnRpbWVyICp0aW1lcikKIAlpZiAoaW9faGFzX3dvcmso
Y3R4KSkKIAkJZ290byBvdXRfd2FrZTsKIAkvKiBnb3QgZXZlbnRzIHNpbmNlIHdlIHN0YXJ0
ZWQgd2FpdGluZywgbWluIHRpbWVvdXQgaXMgZG9uZSAqLwotCWlmIChpb3dxLT5jcV9taW5f
dGFpbCAhPSBSRUFEX09OQ0UoY3R4LT5yaW5ncy0+Y3EudGFpbCkpCi0JCWdvdG8gb3V0X3dh
a2U7Ci0JLyogaWYgd2UgaGF2ZSBhbnkgZXZlbnRzIGFuZCBtaW4gdGltZW91dCBleHBpcmVk
LCB3ZSdyZSBkb25lICovCi0JaWYgKGlvX2NxcmluZ19ldmVudHMoY3R4KSkKLQkJZ290byBv
dXRfd2FrZTsKKwlzY29wZWRfZ3VhcmQocmN1KSB7CisJCXN0cnVjdCBpb19yaW5ncyAqcmlu
Z3MgPSBpb19nZXRfcmluZ3MoY3R4KTsKIAorCQlpZiAoaW93cS0+Y3FfbWluX3RhaWwgIT0g
UkVBRF9PTkNFKHJpbmdzLT5jcS50YWlsKSkKKwkJCWdvdG8gb3V0X3dha2U7CisJCS8qIGlm
IHdlIGhhdmUgYW55IGV2ZW50cyBhbmQgbWluIHRpbWVvdXQgZXhwaXJlZCwgd2UncmUgZG9u
ZSAqLworCQlpZiAoaW9fY3FyaW5nX2V2ZW50cyhjdHgpKQorCQkJZ290byBvdXRfd2FrZTsK
Kwl9CiAJLyoKIAkgKiBJZiB1c2luZyBkZWZlcnJlZCB0YXNrX3dvcmsgcnVubmluZyBhbmQg
YXBwbGljYXRpb24gaXMgd2FpdGluZyBvbgogCSAqIG1vcmUgdGhhbiBvbmUgcmVxdWVzdCwg
ZW5zdXJlIHdlIHJlc2V0IGl0IG5vdyB3aGVyZSB3ZSBhcmUgc3dpdGNoaW5nCkBAIC0yNjUy
LDkgKzI2NTgsOSBAQCBzdGF0aWMgaW50IGlvX2NxcmluZ193YWl0KHN0cnVjdCBpb19yaW5n
X2N0eCAqY3R4LCBpbnQgbWluX2V2ZW50cywgdTMyIGZsYWdzLAogCQkJICBzdHJ1Y3QgZXh0
X2FyZyAqZXh0X2FyZykKIHsKIAlzdHJ1Y3QgaW9fd2FpdF9xdWV1ZSBpb3dxOwotCXN0cnVj
dCBpb19yaW5ncyAqcmluZ3MgPSBjdHgtPnJpbmdzOworCXN0cnVjdCBpb19yaW5ncyAqcmlu
Z3M7CiAJa3RpbWVfdCBzdGFydF90aW1lOwotCWludCByZXQ7CisJaW50IHJldCwgbnJfd2Fp
dDsKIAogCW1pbl9ldmVudHMgPSBtaW5fdChpbnQsIG1pbl9ldmVudHMsIGN0eC0+Y3FfZW50
cmllcyk7CiAKQEAgLTI2NjcsMTUgKzI2NzMsMjMgQEAgc3RhdGljIGludCBpb19jcXJpbmdf
d2FpdChzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwgaW50IG1pbl9ldmVudHMsIHUzMiBmbGFn
cywKIAogCWlmICh1bmxpa2VseSh0ZXN0X2JpdChJT19DSEVDS19DUV9PVkVSRkxPV19CSVQs
ICZjdHgtPmNoZWNrX2NxKSkpCiAJCWlvX2NxcmluZ19kb19vdmVyZmxvd19mbHVzaChjdHgp
OwotCWlmIChfX2lvX2NxcmluZ19ldmVudHNfdXNlcihjdHgpID49IG1pbl9ldmVudHMpCisK
KwlyY3VfcmVhZF9sb2NrKCk7CisJcmluZ3MgPSBpb19nZXRfcmluZ3MoY3R4KTsKKwlpZiAo
X19pb19jcXJpbmdfZXZlbnRzX3VzZXIoY3R4KSA+PSBtaW5fZXZlbnRzKSB7CisJCXJjdV9y
ZWFkX3VubG9jaygpOwogCQlyZXR1cm4gMDsKKwl9CiAKIAlpbml0X3dhaXRxdWV1ZV9mdW5j
X2VudHJ5KCZpb3dxLndxLCBpb193YWtlX2Z1bmN0aW9uKTsKIAlpb3dxLndxLnByaXZhdGUg
PSBjdXJyZW50OwogCUlOSVRfTElTVF9IRUFEKCZpb3dxLndxLmVudHJ5KTsKIAlpb3dxLmN0
eCA9IGN0eDsKLQlpb3dxLmNxX3RhaWwgPSBSRUFEX09OQ0UoY3R4LT5yaW5ncy0+Y3EuaGVh
ZCkgKyBtaW5fZXZlbnRzOwotCWlvd3EuY3FfbWluX3RhaWwgPSBSRUFEX09OQ0UoY3R4LT5y
aW5ncy0+Y3EudGFpbCk7CisJaW93cS5jcV90YWlsID0gUkVBRF9PTkNFKHJpbmdzLT5jcS5o
ZWFkKSArIG1pbl9ldmVudHM7CisJaW93cS5jcV9taW5fdGFpbCA9IFJFQURfT05DRShyaW5n
cy0+Y3EudGFpbCk7CisJbnJfd2FpdCA9IChpbnQpIGlvd3EuY3FfdGFpbCAtIFJFQURfT05D
RShyaW5ncy0+Y3EudGFpbCk7CisJcmN1X3JlYWRfdW5sb2NrKCk7CisJcmluZ3MgPSBOVUxM
OwogCWlvd3EubnJfdGltZW91dHMgPSBhdG9taWNfcmVhZCgmY3R4LT5jcV90aW1lb3V0cyk7
CiAJaW93cS5oaXRfdGltZW91dCA9IDA7CiAJaW93cS5taW5fdGltZW91dCA9IGV4dF9hcmct
Pm1pbl90aW1lOwpAQCAtMjcwNiwxNCArMjcyMCw2IEBAIHN0YXRpYyBpbnQgaW9fY3FyaW5n
X3dhaXQoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgsIGludCBtaW5fZXZlbnRzLCB1MzIgZmxh
Z3MsCiAJdHJhY2VfaW9fdXJpbmdfY3FyaW5nX3dhaXQoY3R4LCBtaW5fZXZlbnRzKTsKIAlk
byB7CiAJCXVuc2lnbmVkIGxvbmcgY2hlY2tfY3E7Ci0JCWludCBucl93YWl0OwotCi0JCS8q
IGlmIG1pbiB0aW1lb3V0IGhhcyBiZWVuIGhpdCwgZG9uJ3QgcmVzZXQgd2FpdCBjb3VudCAq
LwotCQlpZiAoIWlvd3EuaGl0X3RpbWVvdXQpCi0JCQlucl93YWl0ID0gKGludCkgaW93cS5j
cV90YWlsIC0KLQkJCQkJUkVBRF9PTkNFKGN0eC0+cmluZ3MtPmNxLnRhaWwpOwotCQllbHNl
Ci0JCQlucl93YWl0ID0gMTsKIAogCQlpZiAoY3R4LT5mbGFncyAmIElPUklOR19TRVRVUF9E
RUZFUl9UQVNLUlVOKSB7CiAJCQlhdG9taWNfc2V0KCZjdHgtPmNxX3dhaXRfbnIsIG5yX3dh
aXQpOwpAQCAtMjc2NCwxMyArMjc3MCwyMiBAQCBzdGF0aWMgaW50IGlvX2NxcmluZ193YWl0
KHN0cnVjdCBpb19yaW5nX2N0eCAqY3R4LCBpbnQgbWluX2V2ZW50cywgdTMyIGZsYWdzLAog
CQkJYnJlYWs7CiAJCX0KIAkJY29uZF9yZXNjaGVkKCk7CisKKwkJLyogaWYgbWluIHRpbWVv
dXQgaGFzIGJlZW4gaGl0LCBkb24ndCByZXNldCB3YWl0IGNvdW50ICovCisJCWlmICghaW93
cS5oaXRfdGltZW91dCkKKwkJCXNjb3BlZF9ndWFyZChyY3UpCisJCQkJbnJfd2FpdCA9IChp
bnQpIGlvd3EuY3FfdGFpbCAtCisJCQkJCQlSRUFEX09OQ0UoaW9fZ2V0X3JpbmdzKGN0eCkt
PmNxLnRhaWwpOworCQllbHNlCisJCQlucl93YWl0ID0gMTsKIAl9IHdoaWxlICgxKTsKIAog
CWlmICghKGN0eC0+ZmxhZ3MgJiBJT1JJTkdfU0VUVVBfREVGRVJfVEFTS1JVTikpCiAJCWZp
bmlzaF93YWl0KCZjdHgtPmNxX3dhaXQsICZpb3dxLndxKTsKIAlyZXN0b3JlX3NhdmVkX3Np
Z21hc2tfdW5sZXNzKHJldCA9PSAtRUlOVFIpOwogCi0JcmV0dXJuIFJFQURfT05DRShyaW5n
cy0+Y3EuaGVhZCkgPT0gUkVBRF9PTkNFKHJpbmdzLT5jcS50YWlsKSA/IHJldCA6IDA7CisJ
Z3VhcmQocmN1KSgpOworCXJldHVybiBSRUFEX09OQ0UoaW9fZ2V0X3JpbmdzKGN0eCktPmNx
LmhlYWQpID09IFJFQURfT05DRShpb19nZXRfcmluZ3MoY3R4KS0+Y3EudGFpbCkgPyByZXQg
OiAwOwogfQogCiBzdGF0aWMgdm9pZCBpb19yaW5nc19mcmVlKHN0cnVjdCBpb19yaW5nX2N0
eCAqY3R4KQpAQCAtMjk1NCw3ICsyOTY5LDkgQEAgc3RhdGljIF9fcG9sbF90IGlvX3VyaW5n
X3BvbGwoc3RydWN0IGZpbGUgKmZpbGUsIHBvbGxfdGFibGUgKndhaXQpCiAJICovCiAJcG9s
bF93YWl0KGZpbGUsICZjdHgtPnBvbGxfd3EsIHdhaXQpOwogCi0JaWYgKCFpb19zcXJpbmdf
ZnVsbChjdHgpKQorCXJjdV9yZWFkX2xvY2soKTsKKworCWlmICghX19pb19zcXJpbmdfZnVs
bChjdHgpKQogCQltYXNrIHw9IEVQT0xMT1VUIHwgRVBPTExXUk5PUk07CiAKIAkvKgpAQCAt
Mjk3NCw2ICsyOTkxLDcgQEAgc3RhdGljIF9fcG9sbF90IGlvX3VyaW5nX3BvbGwoc3RydWN0
IGZpbGUgKmZpbGUsIHBvbGxfdGFibGUgKndhaXQpCiAJaWYgKF9faW9fY3FyaW5nX2V2ZW50
c191c2VyKGN0eCkgfHwgaW9faGFzX3dvcmsoY3R4KSkKIAkJbWFzayB8PSBFUE9MTElOIHwg
RVBPTExSRE5PUk07CiAKKwlyY3VfcmVhZF91bmxvY2soKTsKIAlyZXR1cm4gbWFzazsKIH0K
IApkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9fdXJpbmcuaCBiL2lvX3VyaW5nL2lvX3VyaW5n
LmgKaW5kZXggMGYwOTZmNDRkMzRiLi42ZWU0OTk5MWNlYzggMTAwNjQ0Ci0tLSBhL2lvX3Vy
aW5nL2lvX3VyaW5nLmgKKysrIGIvaW9fdXJpbmcvaW9fdXJpbmcuaApAQCAtMTMyLDE2ICsx
MzIsMjggQEAgc3RydWN0IGlvX3dhaXRfcXVldWUgewogI2VuZGlmCiB9OwogCitzdGF0aWMg
aW5saW5lIHN0cnVjdCBpb19yaW5ncyAqaW9fZ2V0X3JpbmdzKHN0cnVjdCBpb19yaW5nX2N0
eCAqY3R4KQoreworCXJldHVybiByY3VfZGVyZWZlcmVuY2VfY2hlY2soY3R4LT5yaW5nc19y
Y3UsCisJCQlsb2NrZGVwX2lzX2hlbGQoJmN0eC0+dXJpbmdfbG9jaykgfHwKKwkJCWxvY2tk
ZXBfaXNfaGVsZCgmY3R4LT5jb21wbGV0aW9uX2xvY2spKTsKK30KKwogc3RhdGljIGlubGlu
ZSBib29sIGlvX3Nob3VsZF93YWtlKHN0cnVjdCBpb193YWl0X3F1ZXVlICppb3dxKQogewog
CXN0cnVjdCBpb19yaW5nX2N0eCAqY3R4ID0gaW93cS0+Y3R4OwotCWludCBkaXN0ID0gUkVB
RF9PTkNFKGN0eC0+cmluZ3MtPmNxLnRhaWwpIC0gKGludCkgaW93cS0+Y3FfdGFpbDsKKwlz
dHJ1Y3QgaW9fcmluZ3MgKnJpbmdzOworCWludCBkaXN0OworCisJZ3VhcmQocmN1KSgpOwor
CXJpbmdzID0gaW9fZ2V0X3JpbmdzKGN0eCk7CiAKIAkvKgogCSAqIFdha2UgdXAgaWYgd2Ug
aGF2ZSBlbm91Z2ggZXZlbnRzLCBvciBpZiBhIHRpbWVvdXQgb2NjdXJyZWQgc2luY2Ugd2UK
IAkgKiBzdGFydGVkIHdhaXRpbmcuIEZvciB0aW1lb3V0cywgd2UgYWx3YXlzIHdhbnQgdG8g
cmV0dXJuIHRvIHVzZXJzcGFjZSwKIAkgKiByZWdhcmRsZXNzIG9mIGV2ZW50IGNvdW50Lgog
CSAqLworCWRpc3QgPSBSRUFEX09OQ0UocmluZ3MtPmNxLnRhaWwpIC0gKGludCkgaW93cS0+
Y3FfdGFpbDsKIAlyZXR1cm4gZGlzdCA+PSAwIHx8IGF0b21pY19yZWFkKCZjdHgtPmNxX3Rp
bWVvdXRzKSAhPSBpb3dxLT5ucl90aW1lb3V0czsKIH0KIApAQCAtNDMyLDkgKzQ0NCw5IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBpb19jcXJpbmdfd2FrZShzdHJ1Y3QgaW9fcmluZ19jdHgg
KmN0eCkKIAlfX2lvX3dxX3dha2UoJmN0eC0+Y3Ffd2FpdCk7CiB9CiAKLXN0YXRpYyBpbmxp
bmUgYm9vbCBpb19zcXJpbmdfZnVsbChzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCkKK3N0YXRp
YyBpbmxpbmUgYm9vbCBfX2lvX3NxcmluZ19mdWxsKHN0cnVjdCBpb19yaW5nX2N0eCAqY3R4
KQogewotCXN0cnVjdCBpb19yaW5ncyAqciA9IGN0eC0+cmluZ3M7CisJc3RydWN0IGlvX3Jp
bmdzICpyID0gaW9fZ2V0X3JpbmdzKGN0eCk7CiAKIAkvKgogCSAqIFNRUE9MTCBtdXN0IHVz
ZSB0aGUgYWN0dWFsIHNxcmluZyBoZWFkLCBhcyB1c2luZyB0aGUgY2FjaGVkX3NxX2hlYWQK
QEAgLTQ0Niw5ICs0NTgsMTUgQEAgc3RhdGljIGlubGluZSBib29sIGlvX3NxcmluZ19mdWxs
KHN0cnVjdCBpb19yaW5nX2N0eCAqY3R4KQogCXJldHVybiBSRUFEX09OQ0Uoci0+c3EudGFp
bCkgLSBSRUFEX09OQ0Uoci0+c3EuaGVhZCkgPT0gY3R4LT5zcV9lbnRyaWVzOwogfQogCi1z
dGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBpb19zcXJpbmdfZW50cmllcyhzdHJ1Y3QgaW9f
cmluZ19jdHggKmN0eCkKK3N0YXRpYyBpbmxpbmUgYm9vbCBpb19zcXJpbmdfZnVsbChzdHJ1
Y3QgaW9fcmluZ19jdHggKmN0eCkKIHsKLQlzdHJ1Y3QgaW9fcmluZ3MgKnJpbmdzID0gY3R4
LT5yaW5nczsKKwlndWFyZChyY3UpKCk7CisJcmV0dXJuIF9faW9fc3FyaW5nX2Z1bGwoY3R4
KTsKK30KKworc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgX19pb19zcXJpbmdfZW50cmll
cyhzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCkKK3sKKwlzdHJ1Y3QgaW9fcmluZ3MgKnJpbmdz
ID0gaW9fZ2V0X3JpbmdzKGN0eCk7CiAJdW5zaWduZWQgaW50IGVudHJpZXM7CiAKIAkvKiBt
YWtlIHN1cmUgU1EgZW50cnkgaXNuJ3QgcmVhZCBiZWZvcmUgdGFpbCAqLwpAQCAtNTA5LDYg
KzUyNywxMiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgaW9fdHdfbG9jayhzdHJ1Y3QgaW9fcmlu
Z19jdHggKmN0eCwgaW9fdHdfdG9rZW5fdCB0dykKIAlsb2NrZGVwX2Fzc2VydF9oZWxkKCZj
dHgtPnVyaW5nX2xvY2spOwogfQogCitzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBpb19z
cXJpbmdfZW50cmllcyhzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCkKK3sKKwlndWFyZChyY3Up
KCk7CisJcmV0dXJuIF9faW9fc3FyaW5nX2VudHJpZXMoY3R4KTsKK30KKwogLyoKICAqIERv
bid0IGNvbXBsZXRlIGltbWVkaWF0ZWx5IGJ1dCB1c2UgZGVmZXJyZWQgY29tcGxldGlvbiBp
bmZyYXN0cnVjdHVyZS4KICAqIFByb3RlY3RlZCBieSAtPnVyaW5nX2xvY2sgYW5kIGNhbiBv
bmx5IGJlIHVzZWQgZWl0aGVyIHdpdGgKLS0gCjIuNTMuMAoK

--------------qu5L9Q3D27mApKqetVp0MG0U--

