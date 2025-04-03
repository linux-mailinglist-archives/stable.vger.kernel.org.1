Return-Path: <stable+bounces-127709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E38AA7A83F
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 18:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D173AA824
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 16:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086002512E8;
	Thu,  3 Apr 2025 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wetno2yd"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E639D2D052
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743699350; cv=none; b=iHNZYVAksQvb3Z6CjtrcoPDX6lZLMtNDZWwPWKyrOk/5hTZd8yysOza2xdiFSXTe6VJd4OFH50VnezswaJvKMftIg8rIMV4W51JGj1RbmEV95P/I8RVvnaGpotErq1AIV0gtjfzRf9aC9RXx5V2jl0SCzKAflsU8gQhWzUA9+aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743699350; c=relaxed/simple;
	bh=EyLMteJZHpf+c/7WOAQy9LKueOP8B66XJRU5MZrURz4=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=V26fltRYkPCW/LxqKdBZOjmacFNQqRYQlNjaeM6w/m0spb2NB4yN2VcJescxpMVPjDH8WPeSB+ysGkXL+XW/uWuwPDl47ev7731kkpVD8AoRZ0USxxTYYm4kDyBegnLxGB8v7SpwuclG1JhkRXzoEwhtAOPHghXOfB6OvDYcvC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wetno2yd; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85b40a5120eso33171539f.1
        for <stable@vger.kernel.org>; Thu, 03 Apr 2025 09:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743699346; x=1744304146; darn=vger.kernel.org;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BiMMc46FKrGVJA5Rg0gHYEV+Im+4oZ+8kZWSLHc6qNE=;
        b=wetno2ydpc+XAYX8IS5XatxIfj5sbJDd2BrUy3Ap/Qj+G+Wgo6t0fdl25R4aG1bZzY
         ZqUVE+TF1SDW+21bWqXHGNTF5w/H+ZcXCkwW0ClCsOJsc3IKO28z7HiebUOOsVguuapz
         srm5PXaVY+1+v8AdGXngJsz1S5QbYHOmVtX87PZbd+x5ybkg9+RhcAHeeNrr+xxkx8CT
         X+RvA+viJPfNSB0+BQnwOh3o/mBZSPSe1OCaAxQa5RFLbR6dNqIlFCOrobBwlLDa3BHR
         C0vYIBHn4yiJJb48qBw98LXOX+tJJ9uiGaIX3KwM8zDT3DTEnpypu9KAVvpcrz+UVQtb
         sxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743699346; x=1744304146;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BiMMc46FKrGVJA5Rg0gHYEV+Im+4oZ+8kZWSLHc6qNE=;
        b=lY57WvXRDunRYcQn6WyvNxhdQlrgYuR5ZnxQiE9zNKK0lNNggsOvUXWxdaYZppPEpV
         Q/REL7lSJ497FzajWC/NjIwWmNENB42HkxJTVKPcg76UT3Lir1BMWzQGZrN4IbRVPq6n
         ghqeQtZo0yyM9EmnCqxLSkgfPFkhlMlgHDtiCc9HjRVyVs/466qTa/P4mWJt4uKmEqh6
         ds+7FK0vD1vvyA0LDeAvxCBm72QMA5BAPS52Cpc0qW+MmOD0DYrcMBc63EzuWiBiNd/4
         cnQOhctsTuun4i1Q/OQvYupKJatLI9sUPZw2EZfDBQIZjRFfcSq4i402ypRolR62FQaW
         wMRw==
X-Forwarded-Encrypted: i=1; AJvYcCU6k8HklrvK7FH3o7UVNHZbgdnA+ZHMfm67/c4hUS/GUq26fdzSNUk8x5vN/gEOXY91abiqeHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSORxQxV9rA4taeu4UKVExaSnhIF1+LYK3QCYxvCKsi/RC+16h
	t4lAIyqwO57w6tisg65pBDfwkGtDe5M28Dx1yU+i11aebi2+78ldNTYQn0UtKjs=
X-Gm-Gg: ASbGnctOI8bEWqTLX0+nCIN3uNjmhE0BDFFtgkZfUSetuAD6fkV8rNGDY+fM4uasB+v
	QswShehOa0ed6j0Flap5MIEj8Tth+Z6+kr99slZ/qgIzqFyNKuM/OQnj8jj41QHyapq7lPhKi59
	g6BvP1z8i9smflEApAHwQEc8fI92BG3pqOugk8hBvgCqq0gLpsAeNA15t/UErgUnaZYtq5TeaYQ
	hkYiOdDflW9BQBBRaQaz1zxkTNBHKHGoE47SfjvYVBuHcN4Xv0Jd20GWpW7s3ErRyBR1ri9KHBg
	SzNUZYpqCb/qPOX/6Z1TzlNiLOAcT1rmS0Vi60wms2hFmIMz64s=
X-Google-Smtp-Source: AGHT+IGTKvQ9oLKV1vfxyDxbQOOuTNK2Di6YANZkic45T9IYGRiTr7kUtGQ+WmhqIxEjsDrQd12vdQ==
X-Received: by 2002:a05:6602:4c06:b0:85b:4941:3fe2 with SMTP id ca18e2360f4ac-8610ecc0203mr453526839f.7.1743699345918;
        Thu, 03 Apr 2025 09:55:45 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-861112a020dsm30571439f.20.2025.04.03.09.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 09:55:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------jCC0M0Z06xadKpBd3Gv8yKq9"
Message-ID: <0b556f07-d48a-4d01-84a9-1c79cb82f7dd@kernel.dk>
Date: Thu, 3 Apr 2025 10:55:44 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable <stable@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: 6.1-stable fix

This is a multi-part message in MIME format.
--------------jCC0M0Z06xadKpBd3Gv8yKq9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Ran into an issue testing 6.1, which I discovered was introduced by
a backport that was done. Here's the fix for it, please add it to
the 6.1-stable mix. Thanks!

-- 
Jens Axboe


--------------jCC0M0Z06xadKpBd3Gv8yKq9
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-filetable-ensure-node-switch-is-always-done.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-filetable-ensure-node-switch-is-always-done.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA1YTA3NDNkMmZkOTdmMGI3M2I3ODMwNWE5YTE1NWExNjRkOGNlNGY1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFRodSwgMyBBcHIgMjAyNSAxMDo0ODo0OSAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIGlv
X3VyaW5nL2ZpbGV0YWJsZTogZW5zdXJlIG5vZGUgc3dpdGNoIGlzIGFsd2F5cyBkb25lLCBp
ZgogbmVlZGVkCgpObyB1cHN0cmVhbSBwYXRjaCBleGlzdHMgZm9yIHRoaXMgaXNzdWUsIGFz
IGl0IHdhcyBpbnRyb2R1Y2VkIGJ5CmEgc3RhYmxlIGJhY2twb3J0LgoKQSBwcmV2aW91cyBi
YWNrcG9ydCByZWxpZWQgb24gb3RoZXIgY29kZSBjaGFuZ2VzIGluIHRoZSBpb191cmluZyBm
aWxlCnRhYmxlIGFuZCByZXNvdXJjZSBub2RlIGhhbmRsaW5nLCB3aGljaCBtZWFucyB0aGF0
IHNvbWV0aW1lcyBhIHJlc291cmNlCm5vZGUgc3dpdGNoIGNhbiBnZXQgbWlzc2VkLiBGb3Ig
Ni4xLXN0YWJsZSwgdGhhdCBjb2RlIGlzIHN0aWxsIGluCmlvX2luc3RhbGxfZml4ZWRfZmls
ZSgpLCBzbyBlbnN1cmUgd2UgZmFsbC10aHJvdWdoIHRvIHRoYXQgY2FzZSBmb3IgdGhlCnN1
Y2Nlc3MgcGF0aCB0b28uCgpGaXhlczogYTM4MTJhNDdhMzIwICgiaW9fdXJpbmc6IGRyb3Ag
YW55IGNvZGUgcmVsYXRlZCB0byBTQ01fUklHSFRTIikKU2lnbmVkLW9mZi1ieTogSmVucyBB
eGJvZSA8YXhib2VAa2VybmVsLmRrPgotLS0KIGlvX3VyaW5nL2ZpbGV0YWJsZS5jIHwgMiAr
LQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvaW9fdXJpbmcvZmlsZXRhYmxlLmMgYi9pb191cmluZy9maWxldGFibGUuYwpp
bmRleCA0NjYwY2I4OWVhOWYuLmE2NGI0ZGYwYWM5YyAxMDA2NDQKLS0tIGEvaW9fdXJpbmcv
ZmlsZXRhYmxlLmMKKysrIGIvaW9fdXJpbmcvZmlsZXRhYmxlLmMKQEAgLTk4LDcgKzk4LDcg
QEAgc3RhdGljIGludCBpb19pbnN0YWxsX2ZpeGVkX2ZpbGUoc3RydWN0IGlvX3JpbmdfY3R4
ICpjdHgsIHN0cnVjdCBmaWxlICpmaWxlLAogCSppb19nZXRfdGFnX3Nsb3QoY3R4LT5maWxl
X2RhdGEsIHNsb3RfaW5kZXgpID0gMDsKIAlpb19maXhlZF9maWxlX3NldChmaWxlX3Nsb3Qs
IGZpbGUpOwogCWlvX2ZpbGVfYml0bWFwX3NldCgmY3R4LT5maWxlX3RhYmxlLCBzbG90X2lu
ZGV4KTsKLQlyZXR1cm4gMDsKKwlyZXQgPSAwOwogZXJyOgogCWlmIChuZWVkc19zd2l0Y2gp
CiAJCWlvX3JzcmNfbm9kZV9zd2l0Y2goY3R4LCBjdHgtPmZpbGVfZGF0YSk7Ci0tIAoyLjQ5
LjAKCg==

--------------jCC0M0Z06xadKpBd3Gv8yKq9--

