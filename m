Return-Path: <stable+bounces-114905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B816A309D8
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 12:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F25C1889ED0
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 11:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7CC1F8692;
	Tue, 11 Feb 2025 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKPzg1Ps"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB870807
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272886; cv=none; b=V5tAf1k9OBW1Q8ECUXuoRX1rJH/bP8Zc9NWXwM+IpMcRybb3CJVq8QLlgUcdzpOBV2JN+UcPPSOQ75DQwyjaQhElRBjclTvaf7sqNrM5zjHYtTfvgdH+FWJwpcBDsMwaOnoCFTeuVEpaeLKzWNaPI9iQHPywdkooqII2gJDs/j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272886; c=relaxed/simple;
	bh=4MNJunL0fZCdWVua9FPUVIkmqCjUFDUiWENVNWXzvVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rb7WG3IWUa/0RailM7aod6oyq9awmvxfDjuMZYbehIe1TcZo26Xt0ePSkFIB0KHG9j06GJwhsHcD1LqRzDf6K5o24dB28/jQ0R44VYXctkACr9dz6Xz7C9m10poQGjP5OYUv7ihCzZ92CQ5HFBULu1wgr3BigTIJxOYYx9lAM6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKPzg1Ps; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739272883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lqcg4MSjf8u40+vTG4y4tTMPkIreUT6mk3VNGGj4hWI=;
	b=XKPzg1PsYmRmx3yLwxHBWtkTVRp2PkUxjzTOv04rdyXQ3BTmjoBGcrVPe1MtgbF1ee22e6
	yZbz+PAQKaUf8DfUuOPv70ELbpT4iw0cl46eaawevhqGZq63MstBXQ3N+ukhC1NgpvgUez
	irhA5+HVZwgMd1ee6aTGRxxn6GdXG9U=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-qbLLWu8ZNDGWBq7gb0q_LA-1; Tue, 11 Feb 2025 06:21:20 -0500
X-MC-Unique: qbLLWu8ZNDGWBq7gb0q_LA-1
X-Mimecast-MFC-AGG-ID: qbLLWu8ZNDGWBq7gb0q_LA
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e5b2c00f76bso7985673276.0
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 03:21:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739272879; x=1739877679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lqcg4MSjf8u40+vTG4y4tTMPkIreUT6mk3VNGGj4hWI=;
        b=Tg9V0LU/KV8Afjs42mYT8x8j7ZVrR+Qs13sP/TVnQIBKHS+K02T5GrTruCue1ItRH9
         5FCSEDIuB2q+C4ubgKgawlD1nSHPupxDEnlrFYm4n/pc5SRFRjNSPpm2f3NfQ1Eda2LP
         lfwKrWT8LN7JHJgnGM5jHajX6j1QtGpEmYAD5VUgcPRa2v5HytQ38hU+UuuOf3pAiQR+
         h9rqFfYmJH48XrPy6+5xvP4vsf7o+QYZ5twHJ51sBDNm3C+XlLe/ePKiKBN/l9S/oLHh
         XCjvduJBxAX4XgikwxoQLQ+ScLSkdy8bkx6+585q4rWS1+30mFi7YYPxRtEClnvQG5tm
         PF9A==
X-Forwarded-Encrypted: i=1; AJvYcCUb7Toh7v7sFP/WwAulJ2cQmIy6F2O/yneDp3zw0RP3rrvemcKEo3QUGRyF9wpSUd1PymPiK34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwk5f0yXP2xbyG6Kcc+pBJCqE8cH3+xBDfLuHT/DEdvK+EoIqz
	j7hXJdZp8otVN80mPgGob+KXzGGoMQX3NYMWCKyVqjc+np39+CdZhEYFTZy2cwIj/0IcptrebDK
	ljquidvleX6E1+MZybByCSmL6a28VKnNPyEiJY8MWsg54bHRHE6Sh+5CGSFHBN9E404cuNCpVfB
	xFG+91UTlbI/UEniBfaAuz4/NIC2Ei
X-Gm-Gg: ASbGnctwjYBLFdFnF6AY1sSw4XH2GKRx1WExN+nDzBm3E+cXgG/FE+Rlrs6QtgCGDtA
	1VPKLMUaEZui9BDXwLywTrtAcAF/xj+7Qp1PJM5QtKpcfWgEn4ALhry2zoAI=
X-Received: by 2002:a05:6902:1882:b0:e58:cb:70f0 with SMTP id 3f1490d57ef6-e5d944aff76mr3729069276.6.1739272879757;
        Tue, 11 Feb 2025 03:21:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEySDsODLaA99S0k3MpHSVgox4mE9T4+dIl+MaSpGCGoeqGwll8jEbPkbeXK+nZOu3Rm3oE0jE0g2IruMtsdOQ=
X-Received: by 2002:a05:6902:1882:b0:e58:cb:70f0 with SMTP id
 3f1490d57ef6-e5d944aff76mr3729053276.6.1739272879476; Tue, 11 Feb 2025
 03:21:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025021110-demeaning-mushroom-9922@gregkh>
In-Reply-To: <2025021110-demeaning-mushroom-9922@gregkh>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Tue, 11 Feb 2025 12:21:08 +0100
X-Gm-Features: AWEUYZlt7Q7-vlW0N5PggUYYwiTk2LN0p6mC_BSomPDfKFC8nf1-p-aZjcW9bvs
Message-ID: <CAOssrKcAwE01S5aEXENPki7CUt+tFsnPuz_fthRA59LrzpHuoA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] statmount: let unset strings be empty"
 failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: brauner@kernel.org, jlayton@kernel.org, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000002682a3062ddc061c"

--0000000000002682a3062ddc061c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 10:52=E2=80=AFAM <gregkh@linuxfoundation.org> wrote=
:
>
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Attaching the backport.

Thanks,
Miklos

--0000000000002682a3062ddc061c
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="statmount-let-unset-strings-be-empty-6.12.y.patch"
Content-Disposition: attachment; 
	filename="statmount-let-unset-strings-be-empty-6.12.y.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m70e4sky0>
X-Attachment-Id: f_m70e4sky0

RnJvbSAyMTdlODIxNWI4NzRmZmE1Y2NlZDA5MjIyOTFlM2MwNGE2ZmRkZjU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaWtsb3MgU3plcmVkaSA8bXN6ZXJlZGlAcmVkaGF0LmNvbT4K
RGF0ZTogVGh1LCAzMCBKYW4gMjAyNSAxMzoxNTowMCArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIHN0
YXRtb3VudDogbGV0IHVuc2V0IHN0cmluZ3MgYmUgZW1wdHkKCkp1c3QgbGlrZSBpdCdzIG5vcm1h
bCBmb3IgdW5zZXQgdmFsdWVzIHRvIGJlIHplcm8sIHVuc2V0IHN0cmluZ3Mgc2hvdWxkIGJlCmVt
cHR5IGluc3RlYWQgb2YgY29udGFpbmluZyByYW5kb20gdmFsdWVzLgoKSXQgc2VlbXMgdG8gYmUg
YSB0eXBpY2FsIG1pc3Rha2UgdGhhdCB0aGUgbWFzayByZXR1cm5lZCBieSBzdGF0bW91bnQgaXMg
bm90CmNoZWNrZWQsIHdoaWNoIGNhbiByZXN1bHQgaW4gdmFyaW91cyBidWdzLgoKV2l0aCB0aGlz
IGZpeCwgdGhlc2UgYnVncyBhcmUgcHJldmVudGVkLCBzaW5jZSBpdCBpcyBoaWdobHkgbGlrZWx5
IHRoYXQKdXNlcnNwYWNlIHdvdWxkIGp1c3Qgd2FudCB0byB0dXJuIHRoZSBtaXNzaW5nIG1hc2sg
Y2FzZSBpbnRvIGFuIGVtcHR5CnN0cmluZyBhbnl3YXkgKG1vc3Qgb2YgdGhlIHJlY2VudGx5IGZv
dW5kIGNhc2VzIGFyZSBvZiB0aGlzIHR5cGUpLgoKTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvYWxsL0NBSmZwZWdzVkNQZkNuMkRwTThpaVlTUzVEcE1zTEI4UUJVQ0hlY29qNnMwVnhmNGp6
Z0BtYWlsLmdtYWlsLmNvbS8KRml4ZXM6IDY4Mzg1ZDc3YzA1YiAoInN0YXRtb3VudDogc2ltcGxp
Znkgc3RyaW5nIG9wdGlvbiByZXRyaWV2YWwiKQpGaXhlczogNDZlYWU5OWVmNzMzICgiYWRkIHN0
YXRtb3VudCgyKSBzeXNjYWxsIikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyB2Ni44ClNp
Z25lZC1vZmYtYnk6IE1pa2xvcyBTemVyZWRpIDxtc3plcmVkaUByZWRoYXQuY29tPgpMaW5rOiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwMTMwMTIxNTAwLjExMzQ0Ni0xLW1zemVyZWRp
QHJlZGhhdC5jb20KUmV2aWV3ZWQtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+
ClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBCcmF1bmVyIDxicmF1bmVyQGtlcm5lbC5vcmc+Cihj
aGVycnkgcGlja2VkIGZyb20gY29tbWl0IGU1MmU5N2YwOWZiNjZmZDg2ODI2MGQwNWJkNmI3NGE5
YTNkYjM5ZWUpCi0tLQogZnMvbmFtZXNwYWNlLmMgfCAxNiArKysrKysrKysrKystLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9mcy9uYW1lc3BhY2UuYyBiL2ZzL25hbWVzcGFjZS5jCmluZGV4IDVlYTY0NGI2NzlhZC4uZTlj
OWYyMTk1ZmVmIDEwMDY0NAotLS0gYS9mcy9uYW1lc3BhY2UuYworKysgYi9mcy9uYW1lc3BhY2Uu
YwpAQCAtNTA1MCwyMiArNTA1MCwyOSBAQCBzdGF0aWMgaW50IHN0YXRtb3VudF9zdHJpbmcoc3Ry
dWN0IGtzdGF0bW91bnQgKnMsIHU2NCBmbGFnKQogCXNpemVfdCBrYnVmc2l6ZTsKIAlzdHJ1Y3Qg
c2VxX2ZpbGUgKnNlcSA9ICZzLT5zZXE7CiAJc3RydWN0IHN0YXRtb3VudCAqc20gPSAmcy0+c207
CisJdTMyIHN0YXJ0LCAqb2ZmcDsKKworCS8qIFJlc2VydmUgYW4gZW1wdHkgc3RyaW5nIGF0IHRo
ZSBiZWdpbm5pbmcgZm9yIGFueSB1bnNldCBvZmZzZXRzICovCisJaWYgKCFzZXEtPmNvdW50KQor
CQlzZXFfcHV0YyhzZXEsIDApOworCisJc3RhcnQgPSBzZXEtPmNvdW50OwogCiAJc3dpdGNoIChm
bGFnKSB7CiAJY2FzZSBTVEFUTU9VTlRfRlNfVFlQRToKLQkJc20tPmZzX3R5cGUgPSBzZXEtPmNv
dW50OworCQlvZmZwID0gJnNtLT5mc190eXBlOwogCQlyZXQgPSBzdGF0bW91bnRfZnNfdHlwZShz
LCBzZXEpOwogCQlicmVhazsKIAljYXNlIFNUQVRNT1VOVF9NTlRfUk9PVDoKLQkJc20tPm1udF9y
b290ID0gc2VxLT5jb3VudDsKKwkJb2ZmcCA9ICZzbS0+bW50X3Jvb3Q7CiAJCXJldCA9IHN0YXRt
b3VudF9tbnRfcm9vdChzLCBzZXEpOwogCQlicmVhazsKIAljYXNlIFNUQVRNT1VOVF9NTlRfUE9J
TlQ6Ci0JCXNtLT5tbnRfcG9pbnQgPSBzZXEtPmNvdW50OworCQlvZmZwID0gJnNtLT5tbnRfcG9p
bnQ7CiAJCXJldCA9IHN0YXRtb3VudF9tbnRfcG9pbnQocywgc2VxKTsKIAkJYnJlYWs7CiAJY2Fz
ZSBTVEFUTU9VTlRfTU5UX09QVFM6Ci0JCXNtLT5tbnRfb3B0cyA9IHNlcS0+Y291bnQ7CisJCW9m
ZnAgPSAmc20tPm1udF9vcHRzOwogCQlyZXQgPSBzdGF0bW91bnRfbW50X29wdHMocywgc2VxKTsK
IAkJYnJlYWs7CiAJZGVmYXVsdDoKQEAgLTUwODcsNiArNTA5NCw3IEBAIHN0YXRpYyBpbnQgc3Rh
dG1vdW50X3N0cmluZyhzdHJ1Y3Qga3N0YXRtb3VudCAqcywgdTY0IGZsYWcpCiAKIAlzZXEtPmJ1
ZltzZXEtPmNvdW50KytdID0gJ1wwJzsKIAlzbS0+bWFzayB8PSBmbGFnOworCSpvZmZwID0gc3Rh
cnQ7CiAJcmV0dXJuIDA7CiB9CiAKLS0gCjIuNDguMQoK
--0000000000002682a3062ddc061c--


