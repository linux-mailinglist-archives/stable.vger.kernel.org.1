Return-Path: <stable+bounces-52245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB80A90951D
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 02:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 586EEB21664
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 00:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F18139D;
	Sat, 15 Jun 2024 00:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tU3YK3lS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AA27E6
	for <stable@vger.kernel.org>; Sat, 15 Jun 2024 00:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718412650; cv=none; b=j9a9Us5FPDEyEbo1Hv7Rc+8qGncxmlJoX4JM/bZNoXchPeRQQm8PyLD2txpBE3HaMIH1RAiP9HicFXkO+RoUZQF0eXZvK6I9F7u/JrgD0tLq5dMq+Njbtas/8Ib+b4w6VzV8TBBgzyig7FuC5+NGLjn2Nm1GmW+972nEwVw63pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718412650; c=relaxed/simple;
	bh=UEy9V3R/jg5Sl1WJinM3pJu8i265mDSd/lKhfwoOFMU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=JJBspjmPLYs2M/M50Mb4GY7hRF9MN66pr5nezZUh1PP76W5vm2xW8I0c/WkmWY5BIrH1TKVvoarb16BF9E2kR/IZqoc35zKOapSvHsfFbRn1KUzWGGQ0WfdtAQvKkihvHpu3NWXRMrjv9gjSJO3XoPQLcpJdWFGBWlEBHC3PbzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tU3YK3lS; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c036a14583so471993a91.1
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 17:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718412647; x=1719017447; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BSuEDN5a6HppvIxKM+0kaVWohso5dRbUUJQthhjI2E=;
        b=tU3YK3lS2QvS5jDpWt32PlZ6+/tLxTa3iAEPJ2kESaR5szawZJ6ASofZ5lVYhfbOqk
         71DFk+ghDDzlKxQL9KY9YlfQuqMJvuKenJ7UaUTgs0oRWuLfTkSTxTIOjTmtKz2O9l1A
         0wyBTzv10S/EANknX6ArbZEPHzRF1p1kGQQesyWKkoKUII3w2h3P1VsbCVrIXtkVs+0U
         I1TRBBhPSYZXIM8BH2zveXzdPYfPFSFGBVSwHQJpMClk09wcoJfhGLF32KDWHPXlfe0f
         WMrscqQ6BH18XVMqgyxKBr04bJs+ic+7V9ZdddeZBB3kZApKk/PuuU9sZid+eO4v5I0h
         z67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718412647; x=1719017447;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4BSuEDN5a6HppvIxKM+0kaVWohso5dRbUUJQthhjI2E=;
        b=Kj1SmGJECBnVLvJEuofBrHjp5pWYGZvbxOp8z2W5VMwCeWRy0IULQ2ycsP7qAkU/sl
         Ttyetf/sj24j5Hebcxhv0w9i5AP3CqxJoIz9ZvsJ1fNcwO10+wR5/dYI9CdPUGboNTt6
         wPCEqc8vy4n2Xul7yVX7MRRFBsFmke2dVZQqFb5fNevbLCF6sk8yvTvc6Ct8OmXt6a9m
         +Opln/3dDmPErmBYtZ7VVmJJFuPfnxt2nDsB5Xq0KOlnD46kA0BqCd4BMtYW4Haxt4z0
         p1FThki2kcONvDbgI4Qe2JqnzNdDWQTrDf+I1XezQojNkgGvQJpE0HSiG7b3/5HyJYZG
         vd0A==
X-Gm-Message-State: AOJu0Yyhe1uBAP+9CeN/AEh6yYB/yiVPXE/YXybl6hzwXMycB+RzKnBw
	8FI+G0eX8yURpPKRsspiDg3+CQft6rGSRUAmxF5vyj/P4K/kQQT+xOD4jylF4lR9gh4Sw63QwUZ
	f
X-Google-Smtp-Source: AGHT+IGGRPXiY2j0EaYPCbGEMdHyh2XKj96n6J9SQ9AeO6D3MdnzR+nPqxGgrVD+FrEUwJbbEV+7ew==
X-Received: by 2002:a17:902:f68c:b0:1f7:111c:2d36 with SMTP id d9443c01a7336-1f862b25618mr45086825ad.3.1718412646652;
        Fri, 14 Jun 2024 17:50:46 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f0260csm38526665ad.200.2024.06.14.17.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 17:50:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------q1xKxnuoHTMlS5CAOBBen0Qo"
Message-ID: <317b7b92-7484-4a6a-bf8e-413b4fb194c5@kernel.dk>
Date: Fri, 14 Jun 2024 18:50:44 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: check for non-NULL file pointer
 in" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
References: <2024061318-hypocrite-elude-31f3@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024061318-hypocrite-elude-31f3@gregkh>

This is a multi-part message in MIME format.
--------------q1xKxnuoHTMlS5CAOBBen0Qo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/24 1:30 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 5fc16fa5f13b3c06fdb959ef262050bd810416a2
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061318-hypocrite-elude-31f3@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

And here's the 6.6 variant, same as the 6.1-stable patch.

-- 
Jens Axboe


--------------q1xKxnuoHTMlS5CAOBBen0Qo
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-check-for-non-NULL-file-pointer-in-io_file_.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-check-for-non-NULL-file-pointer-in-io_file_.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBmYjk1Yzc2MTk1NjkyZDE1OTNjYjI5YTdhMzUzMzg5ZDVkY2Y0M2I4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFNhdCwgMSBKdW4gMjAyNCAxMjoyNTozNSAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIGlv
X3VyaW5nOiBjaGVjayBmb3Igbm9uLU5VTEwgZmlsZSBwb2ludGVyIGluCiBpb19maWxlX2Nh
bl9wb2xsKCkKCmNvbW1pdCA1ZmMxNmZhNWYxM2IzYzA2ZmRiOTU5ZWYyNjIwNTBiZDgxMDQx
NmEyIHVwc3RyZWFtLgoKSW4gZWFybGllciBrZXJuZWxzLCBpdCB3YXMgcG9zc2libGUgdG8g
dHJpZ2dlciBhIE5VTEwgcG9pbnRlcgpkZXJlZmVyZW5jZSBvZmYgdGhlIGZvcmNlZCBhc3lu
YyBwcmVwYXJhdGlvbiBwYXRoLCBpZiBubyBmaWxlIGhhZApiZWVuIGFzc2lnbmVkLiBUaGUg
dHJhY2UgbGVhZGluZyB0byB0aGF0IGxvb2tzIGFzIGZvbGxvd3M6CgpCVUc6IGtlcm5lbCBO
VUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDAwMDAwMDAwMDAwMDAwYjAKUEdE
IDAgUDREIDAKT29wczogMDAwMCBbIzFdIFBSRUVNUFQgU01QCkNQVTogNjcgUElEOiAxNjMz
IENvbW06IGJ1Zi1yaW5nLWludmFsaSBOb3QgdGFpbnRlZCA2LjguMC1yYzMrICMxCkhhcmR3
YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKGk0NDBGWCArIFBJSVgsIDE5OTYpLCBCSU9T
IHVua25vd24gMi8yLzIwMjIKUklQOiAwMDEwOmlvX2J1ZmZlcl9zZWxlY3QrMHhjMy8weDIx
MApDb2RlOiAwMCAwMCA0OCAzOSBkMSAwZiA4MiBhZSAwMCAwMCAwMCA0OCA4MSA0YiA0OCAw
MCAwMCAwMSAwMCA0OCA4OSA3MyA3MCAwZiBiNyA1MCAwYyA2NiA4OSA1MyA0MiA4NSBlZCAw
ZiA4NSBkMiAwMCAwMCAwMCA0OCA4YiAxMyA8NDg+IDhiIDkyIGIwIDAwIDAwIDAwIDQ4IDgz
IDdhIDQwIDAwIDBmIDg0IDIxIDAxIDAwIDAwIDRjIDhiIDIwIDViClJTUDogMDAxODpmZmZm
YjdiZWMzOGM3ZDg4IEVGTEFHUzogMDAwMTAyNDYKUkFYOiBmZmZmOTdhZjJiZTYxMDAwIFJC
WDogZmZmZjk3YWYyMzRmMTcwMCBSQ1g6IDAwMDAwMDAwMDAwMDAwNDAKUkRYOiAwMDAwMDAw
MDAwMDAwMDAwIFJTSTogZmZmZjk3YWVjZmIwNDgyMCBSREk6IGZmZmY5N2FmMjM0ZjE3MDAK
UkJQOiAwMDAwMDAwMDAwMDAwMDAwIFIwODogMDAwMDAwMDAwMDIwMDAzMCBSMDk6IDAwMDAw
MDAwMDAwMDAwMjAKUjEwOiBmZmZmYjdiZWMzOGM3ZGM4IFIxMTogMDAwMDAwMDAwMDAwYzAw
MCBSMTI6IGZmZmZiN2JlYzM4YzdkYjgKUjEzOiBmZmZmOTdhZWNmYjA1ODAwIFIxNDogZmZm
Zjk3YWVjZmIwNTgwMCBSMTU6IGZmZmY5N2FmMmJlNWUwMDAKRlM6ICAwMDAwN2Y4NTJmNzRi
NzQwKDAwMDApIEdTOmZmZmY5N2IxZWVlYzAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAw
MDAwMApDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMz
CkNSMjogMDAwMDAwMDAwMDAwMDBiMCBDUjM6IDAwMDAwMDAxNmRlYWIwMDUgQ1I0OiAwMDAw
MDAwMDAwMzcwZWYwCkNhbGwgVHJhY2U6CiA8VEFTSz4KID8gX19kaWUrMHgxZi8weDYwCiA/
IHBhZ2VfZmF1bHRfb29wcysweDE0ZC8weDQyMAogPyBkb191c2VyX2FkZHJfZmF1bHQrMHg2
MS8weDZhMAogPyBleGNfcGFnZV9mYXVsdCsweDZjLzB4MTUwCiA/IGFzbV9leGNfcGFnZV9m
YXVsdCsweDIyLzB4MzAKID8gaW9fYnVmZmVyX3NlbGVjdCsweGMzLzB4MjEwCiBfX2lvX2lt
cG9ydF9pb3ZlYysweGI1LzB4MTIwCiBpb19yZWFkdl9wcmVwX2FzeW5jKzB4MzYvMHg3MAog
aW9fcXVldWVfc3FlX2ZhbGxiYWNrKzB4MjAvMHgyNjAKIGlvX3N1Ym1pdF9zcWVzKzB4MzE0
LzB4NjMwCiBfX2RvX3N5c19pb191cmluZ19lbnRlcisweDMzOS8weGJjMAogPyBfX2RvX3N5
c19pb191cmluZ19yZWdpc3RlcisweDExYi8weGM1MAogPyB2bV9tbWFwX3Bnb2ZmKzB4Y2Uv
MHgxNjAKIGRvX3N5c2NhbGxfNjQrMHg1Zi8weDE4MAogZW50cnlfU1lTQ0FMTF82NF9hZnRl
cl9od2ZyYW1lKzB4NDYvMHg0ZQpSSVA6IDAwMzM6MHg1NWUwYTExMGE2N2UKQ29kZTogYmEg
Y2MgMDAgMDAgMDAgNDUgMzEgYzAgNDQgMGYgYjYgOTIgZDAgMDAgMDAgMDAgMzEgZDIgNDEg
YjkgMDggMDAgMDAgMDAgNDEgODMgZTIgMDEgNDEgYzEgZTIgMDQgNDEgMDkgYzIgYjggYWEg
MDEgMDAgMDAgMGYgMDUgPGMzPiA5MCA4OSAzMCBlYiBhOSAwZiAxZiA0MCAwMCA0OCA4YiA0
MiAyMCA4YiAwMCBhOCAwNiA3NSBhZiA4NSBmNgoKYmVjYXVzZSB0aGUgcmVxdWVzdCBpcyBt
YXJrZWQgZm9yY2VkIEFTWU5DIGFuZCBoYXMgYSBiYWQgZmlsZSBmZCwgYW5kCmhlbmNlIHRh
a2VzIHRoZSBmb3JjZWQgYXN5bmMgcHJlcCBwYXRoLgoKQ3VycmVudCBrZXJuZWxzIHdpdGgg
dGhlIHJlcXVlc3QgYXN5bmMgcHJlcCBjbGVhbmVkIHVwIGNhbiBubyBsb25nZXIgaGl0CnRo
aXMgaXNzdWUsIGJ1dCBmb3IgZWFzZSBvZiBiYWNrcG9ydGluZywgbGV0J3MgYWRkIHRoaXMg
c2FmZXR5IGNoZWNrIGluCmhlcmUgdG9vIGFzIGl0IHJlYWxseSBkb2Vzbid0IGh1cnQuIEZv
ciBib3RoIGNhc2VzLCB0aGlzIHdpbGwgaW5ldml0YWJseQplbmQgd2l0aCBhIENRRSBwb3N0
ZWQgd2l0aCAtRUJBREYuCgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpGaXhlczogYTc2
YzBiMzFlZWY1ICgiaW9fdXJpbmc6IGNvbW1pdCBub24tcG9sbGFibGUgcHJvdmlkZWQgbWFw
cGVkIGJ1ZmZlcnMgdXBmcm9udCIpClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9l
QGtlcm5lbC5kaz4KLS0tCiBpb191cmluZy9rYnVmLmMgfCAzICsrLQogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2lvX3Vy
aW5nL2tidWYuYyBiL2lvX3VyaW5nL2tidWYuYwppbmRleCAyNmEwMDkyMDA0MmMuLjcwMmMw
OGMyNmNkNCAxMDA2NDQKLS0tIGEvaW9fdXJpbmcva2J1Zi5jCisrKyBiL2lvX3VyaW5nL2ti
dWYuYwpAQCAtMTY4LDcgKzE2OCw4IEBAIHN0YXRpYyB2b2lkIF9fdXNlciAqaW9fcmluZ19i
dWZmZXJfc2VsZWN0KHN0cnVjdCBpb19raW9jYiAqcmVxLCBzaXplX3QgKmxlbiwKIAlyZXEt
PmJ1Zl9saXN0ID0gYmw7CiAJcmVxLT5idWZfaW5kZXggPSBidWYtPmJpZDsKIAotCWlmIChp
c3N1ZV9mbGFncyAmIElPX1VSSU5HX0ZfVU5MT0NLRUQgfHwgIWZpbGVfY2FuX3BvbGwocmVx
LT5maWxlKSkgeworCWlmIChpc3N1ZV9mbGFncyAmIElPX1VSSU5HX0ZfVU5MT0NLRUQgfHwK
KwkgICAgKHJlcS0+ZmlsZSAmJiAhZmlsZV9jYW5fcG9sbChyZXEtPmZpbGUpKSkgewogCQkv
KgogCQkgKiBJZiB3ZSBjYW1lIGluIHVubG9ja2VkLCB3ZSBoYXZlIG5vIGNob2ljZSBidXQg
dG8gY29uc3VtZSB0aGUKIAkJICogYnVmZmVyIGhlcmUsIG90aGVyd2lzZSBub3RoaW5nIGVu
c3VyZXMgdGhhdCB0aGUgYnVmZmVyIHdvbid0Ci0tIAoyLjQzLjAKCg==

--------------q1xKxnuoHTMlS5CAOBBen0Qo--

