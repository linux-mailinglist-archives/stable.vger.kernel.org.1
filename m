Return-Path: <stable+bounces-52244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE1B90951C
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 02:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E1828360D
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 00:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F61139D;
	Sat, 15 Jun 2024 00:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gXwXEY6+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0235D7E6
	for <stable@vger.kernel.org>; Sat, 15 Jun 2024 00:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718412535; cv=none; b=ouubhAnp+bUyyHozBt8rACBQ5ZjcGoQY8uQT4L/szRUmxP/B733rfkmGJnGJSY/W1xBvzBaInwzWrL5AlaYN4ehqNZmbvdMaGR+omZuiCYzXLGQ2lxjZBCF15KMt7TPR6P9Jv2MhNwn1jvqw+CEgin25A9vXzFF3IrMX1DmmGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718412535; c=relaxed/simple;
	bh=13TfIjePziYAhCLkYXskvjJbNGez/ppta1zcgCPe7ek=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=qJXtNd6m1CsCZWehv1M9tV8GVKqPGkcmvAMvseuGVJek3j8ub9yTngDjhIj6obUjWFyQik4dRmvuEIpKHw6o09TaUaJ8z7ayox1FTyE+5HkgcK3Uo0nvfwqcnxX9E+wQ3GkUMo+7Sy4wN22ksuKFNL9KT2tZYRCCTdRCaBm2vQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gXwXEY6+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c1b39ba2afso466097a91.2
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 17:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718412531; x=1719017331; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gvc37ezmpOcopzwx/SqCg2KkPwM0rfn4MAfyoWxBm98=;
        b=gXwXEY6+OJr3xueBwpN0h9CfyCv5rSIgxiWXfE2NzYYMfC3HDIU5V8u4nRmxohrENs
         +FdtDYUBLWFb22ZW05Ddd7kjlenFiCaKMFVhMAEaNRK8YJV/imSUHfSY/amdFWkF3F2d
         BFPk+6OQv/sTRohQ9Jz2Ecv23NObVCDiHZu1WsMgTiXwIerHRRO4DNZ6iqZYM78pc1VI
         CCxUPbymyScX3nSe8n8y8NlT3tyJw31HI0EsiuJN2O1TJyQWsl4E65dTPUdXUrSPJQAf
         F7H73zROX7yt5DF6/KfMghYdfavTI3acfH/2dDn2stOb1Cing4Hz2PBIf9fXjUQfy8iB
         YWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718412531; x=1719017331;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gvc37ezmpOcopzwx/SqCg2KkPwM0rfn4MAfyoWxBm98=;
        b=QO6Esq4jnOi/Rid2By/qutl54Fu86uB8aGM5alPF4bt8goIH8y3XpthCrBIsQstGxV
         4wik2yNO4rQd3L0iollsQDeC+UEcb+6Oi5EQS3R6yyZvCdmMcA7kcrtBd1pPN7OHMwza
         YApNjV89va0iyOFKhwrQNsiBadXt9OXkeskahb3VN3gGbI4mG8nxItaHrrg/s7G3uU1X
         SYa1y2uEyvm/lckLXVTjeKIwNl1BEW0WbfIW/v//HMfbH+4fNuMiYYUfP/Du6o6vz4Z3
         LKqwbhl3A0g/ZwRIpwIKSXsIfiHbro1NLqKhQKIRqSbvtoihTi+VyDcQLUfY3LMIdyjX
         EeQQ==
X-Gm-Message-State: AOJu0YwspQU+om6KHerWEIR7NFCQ8rKO2HlHWi7M4GAk1NqNbxIS2Zrg
	5pPIdf6VV+BRx/QbdOYH+7Zrv4ybwNCRyZa3qPWBW773/z/m9v85yZXbLlLSpdOdilevx2Qc8Cy
	W
X-Google-Smtp-Source: AGHT+IEPvuyxPsxxP5cfCyDR5VWw8thbjYCxC9LfjGI/qnN7pOnsyY7Pt2yJxTGzxMAQF8Bc2UeRxg==
X-Received: by 2002:a17:903:230f:b0:1f6:ee76:1b35 with SMTP id d9443c01a7336-1f862c36988mr44537495ad.5.1718412531124;
        Fri, 14 Jun 2024 17:48:51 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f0580dsm38288515ad.208.2024.06.14.17.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 17:48:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------LUsjQgVKzu5ZIg7mWbNPlpqC"
Message-ID: <00f44cd8-be41-43aa-9b9e-37cd845b34a8@kernel.dk>
Date: Fri, 14 Jun 2024 18:48:49 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: check for non-NULL file pointer
 in" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
References: <2024061319-avenue-nutlike-03f6@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024061319-avenue-nutlike-03f6@gregkh>

This is a multi-part message in MIME format.
--------------LUsjQgVKzu5ZIg7mWbNPlpqC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/24 1:30 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 5fc16fa5f13b3c06fdb959ef262050bd810416a2
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061319-avenue-nutlike-03f6@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Here's one for 6.1-stable.

-- 
Jens Axboe


--------------LUsjQgVKzu5ZIg7mWbNPlpqC
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-check-for-non-NULL-file-pointer-in-io_file_.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-check-for-non-NULL-file-pointer-in-io_file_.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA5ZWQzMjA4YTg2ZDJmYzY2NWM5NjI3ZTM2NzgzOGRjOGU3NzlhNzllIE1vbiBTZXAg
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
aW5nL2tidWYuYyBiL2lvX3VyaW5nL2tidWYuYwppbmRleCA1N2VmNjg1MGM2YTguLjU1OTAy
MzAzZDdkYyAxMDA2NDQKLS0tIGEvaW9fdXJpbmcva2J1Zi5jCisrKyBiL2lvX3VyaW5nL2ti
dWYuYwpAQCAtMTU0LDcgKzE1NCw4IEBAIHN0YXRpYyB2b2lkIF9fdXNlciAqaW9fcmluZ19i
dWZmZXJfc2VsZWN0KHN0cnVjdCBpb19raW9jYiAqcmVxLCBzaXplX3QgKmxlbiwKIAlyZXEt
PmJ1Zl9saXN0ID0gYmw7CiAJcmVxLT5idWZfaW5kZXggPSBidWYtPmJpZDsKIAotCWlmIChp
c3N1ZV9mbGFncyAmIElPX1VSSU5HX0ZfVU5MT0NLRUQgfHwgIWZpbGVfY2FuX3BvbGwocmVx
LT5maWxlKSkgeworCWlmIChpc3N1ZV9mbGFncyAmIElPX1VSSU5HX0ZfVU5MT0NLRUQgfHwK
KwkgICAgKHJlcS0+ZmlsZSAmJiAhZmlsZV9jYW5fcG9sbChyZXEtPmZpbGUpKSkgewogCQkv
KgogCQkgKiBJZiB3ZSBjYW1lIGluIHVubG9ja2VkLCB3ZSBoYXZlIG5vIGNob2ljZSBidXQg
dG8gY29uc3VtZSB0aGUKIAkJICogYnVmZmVyIGhlcmUsIG90aGVyd2lzZSBub3RoaW5nIGVu
c3VyZXMgdGhhdCB0aGUgYnVmZmVyIHdvbid0Ci0tIAoyLjQzLjAKCg==

--------------LUsjQgVKzu5ZIg7mWbNPlpqC--

