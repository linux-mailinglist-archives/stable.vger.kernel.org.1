Return-Path: <stable+bounces-225981-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIJ/OtdQuWmuAQIAu9opvQ
	(envelope-from <stable+bounces-225981-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:02:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B6F2AA5C2
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0253130330ED
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7F43C6A29;
	Tue, 17 Mar 2026 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zldl56rb"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9CD1A9F93
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752426; cv=none; b=mCVq5uDHUY+Jed8crrcfSsccNjWCLDSksrmm5bmR17qRE5h7okusYeLxq21gxF6cDq3QzOXManMwLatIkWNLFAPqmZFmjOGF/FiZbPh3SHkRCjwaM0Bpz8CvbHf8WqnaL4AzN3oX6QNnrlEeLiPzTyYfmLMyjTrLbxIUVLW1omg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752426; c=relaxed/simple;
	bh=0TsENLm6uwNc0Mrw19ubm+ticlfEhLVl1wcpyWtC3Hg=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=lZ5in9uud6uDB0OU0bAuZIt4L3sq+NfyD8/842di8I+BuXaktECOAkFtCkvS1wIIrg5q18Uf+7d6XIoTds+pYqFt/QSQRsmSFVDvpl0Lyn93FGRjlMG2Urc4Ak6BYvxHoZTFsYfPzkvneNHeX+pN5U6E2Lveupdw71Ola4wfGC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zldl56rb; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4673790ab85so3749517b6e.3
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773752424; x=1774357224; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgVTDFCtEDHNLJbx6j9/R/eIrgdiYhY+i4tz7NtdnEE=;
        b=zldl56rbX91IQAPmTEbjAO3uf4/LF8tCC60woE14nMflM9+zOqeGOxcmo4QInbgE2X
         BAxu9k09gspgmDwDtWR2SyyJJ0DocZGzMu7znRjbUzVrUxkV+rrRjBWOYfQeLqgdAeaX
         12RNL3uMbckQHvaVv9ZsAUHBqKcPyVMuqq1lTnGtwVRS1BU3VASs0+96UCKmxqcVRuy7
         RcV1qHk91jlixf8FJzx+1mV2f0+bugcAmbimPxvdE5fjvN4b7o2rCunrV7JX7Ot0P49Y
         gSZQIjyUyw+qgPpeFwd9PVPiRV27UHJj4ilAdcv6Yx6lSyH3H6JIgnDEInhXdO4dSUil
         0Scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773752424; x=1774357224;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dgVTDFCtEDHNLJbx6j9/R/eIrgdiYhY+i4tz7NtdnEE=;
        b=dDRFbWdcfFW7R6i0QSjSygJXD8STF89Pg39wQkpbq/nSSJgq55Kkl5PQyzaK4bZRdf
         QN0b9mgE2ddI1mjd9DPhgu/u+Mm0EL0YnGy8Ip5RwkFKB1ni6rjfOeVVO9h6NZt/4TPi
         tRSDOhfRo5qAR5VTJVdLQgsfIpLzdNNS5HCjpRcx1XsqEITSX+wloQMu8HrgmAFbQXuX
         pWxVOp+QLOILvBVtcRafySEh+NeYxcEDjpeO3U3IxLD2vzQMXC6TJY7Pt0wECCvn6RM9
         W2vb89DChom0+H66RRxYI8NC3DrHp+bbHxoENVlGag2rYW0v/ktuUpvxbMGikR7EORCz
         uFIg==
X-Gm-Message-State: AOJu0Yxxh5i4muXk2XqzRC/Eupdeq7VlAwWpRT8sonvWg6+9aqVaKxwn
	WBuWpPZQJnYEPBvD7/eI0sWcP6bRQAnx34HmMEmjH1n9qvIHCUO755HbFoQjjuGj1ETgG7wSte8
	IWedyI6k=
X-Gm-Gg: ATEYQzzBPAzrEpEoZnfAXHyuPAVSMGtHwwtmA+h90U4aLB/YdU8Tru70wzRR9oISRnz
	RdDG/tq6Ibmwgmsk4k82F6xi/3t10l92pSAFQJ86XVk4qK49Le7ghTh9Jecx5w2ufwS2qHNfMpe
	USL2V5l/vwWreOd0EawVsm49IXWTVX7a10OhdbWcEhDCUJ+AGBkHpL8y4b90/OELPsEcUTZ6waY
	5gyckqYGHXbXFd8MDp+c979EJGYQ9c3dDoiKn739tD06atG0gAiXPe8KwCL6/Xa7JkQ+TjYtFu1
	WaXZSNkPLt5Kq/KS4cW+/rzp5AnwKLQ4ao9/UX2CAd5GhVONfMwZ0p+H0TrU/Mt3ElQ+rO3xELI
	bPqTgcEr1ZnH0v5enGXCYVQNzWPggTMgXbI6PNMf/2EZ4sI3biXc2frfey/c7TT438Mnk/fA+ln
	lwiGNniu6Sa9wBGMjc3pPUfiAqCXb5xm1k4Q8/658kl/oWbiIfYF6CWSsefDmv752VqH6yG3/qp
	hglI+eOpuwDDeDeKEGo
X-Received: by 2002:a05:6870:2f14:b0:409:57ae:54e4 with SMTP id 586e51a60fabf-417b91dac27mr10329953fac.9.1773752423565;
        Tue, 17 Mar 2026 06:00:23 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e1fb6efsm20836277fac.3.2026.03.17.06.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 06:00:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------VlwmA7nEB2KYKfTYkuRasryA"
Message-ID: <8dcd0d6e-08a7-4fc7-8ab6-3bc771c27b0a@kernel.dk>
Date: Tue, 17 Mar 2026 07:00:21 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: check if target buffer list
 is still legacy on" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org, keenanat2000@gmail.com
Cc: stable@vger.kernel.org
References: <2026031701-humid-ultimate-853d@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026031701-humid-ultimate-853d@gregkh>
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225981-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,kernel-dk.20230601.gappssmtp.com:dkim,kernel.dk:email,kernel.dk:mid]
X-Rspamd-Queue-Id: C4B6F2AA5C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.
--------------VlwmA7nEB2KYKfTYkuRasryA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/26 6:55 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here's one for 6.6-stable.

-- 
Jens Axboe

--------------VlwmA7nEB2KYKfTYkuRasryA
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-kbuf-check-if-target-buffer-list-is-still-l.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-kbuf-check-if-target-buffer-list-is-still-l.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBlMGRkMDI5NzlhNmYxY2EzNzhmYjE3M2Q1ZTM2ZGQ1OTFlZThlZjNmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFRodSwgMTIgTWFyIDIwMjYgMDg6NTk6MjUgLTA2MDAKU3ViamVjdDogW1BBVENIXSBp
b191cmluZy9rYnVmOiBjaGVjayBpZiB0YXJnZXQgYnVmZmVyIGxpc3QgaXMgc3RpbGwgbGVn
YWN5IG9uCiByZWN5Y2xlCgpDb21taXQgYzJjMTg1YmU1Yzg1ZDM3MjE1Mzk3YzhlODc4MWFi
ZjBhNjliZWMxZiB1cHN0cmVhbS4KClRoZXJlJ3MgYSBnYXAgYmV0d2VlbiB3aGVuIHRoZSBi
dWZmZXIgd2FzIGdyYWJiZWQgYW5kIHdoZW4gaXQKcG90ZW50aWFsbHkgZ2V0cyByZWN5Y2xl
ZCwgd2hlcmUgaWYgdGhlIGxpc3QgaXMgZW1wdHksIHNvbWVvbmUgY291bGQndmUKdXBncmFk
ZWQgaXQgdG8gYSByaW5nIHByb3ZpZGVkIHR5cGUuIFRoaXMgY2FuIGhhcHBlbiBpZiB0aGUg
cmVxdWVzdAppcyBmb3JjZWQgdmlhIGlvLXdxLiBUaGUgbGVnYWN5IHJlY3ljbGluZyBpcyBt
aXNzaW5nIGNoZWNraW5nIGlmIHRoZQpidWZmZXJfbGlzdCBzdGlsbCBleGlzdHMsIGFuZCBp
ZiBpdCdzIG9mIHRoZSBjb3JyZWN0IHR5cGUuIEFkZCB0aG9zZQpjaGVja3MuCgpDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZwpGaXhlczogYzdmYjE5NDI4ZDY3ICgiaW9fdXJpbmc6IGFk
ZCBzdXBwb3J0IGZvciByaW5nIG1hcHBlZCBzdXBwbGllZCBidWZmZXJzIikKUmVwb3J0ZWQt
Ynk6IEtlZW5hbiBEb25nIDxrZWVuYW5hdDIwMDBAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5
OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcva2J1Zi5jIHwg
OCArKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL2lvX3VyaW5nL2tidWYuYyBiL2lvX3VyaW5nL2tidWYuYwpp
bmRleCBiMmMzODE2MzQzOTMuLmFkMWUxNDM1OTY2MiAxMDA2NDQKLS0tIGEvaW9fdXJpbmcv
a2J1Zi5jCisrKyBiL2lvX3VyaW5nL2tidWYuYwpAQCAtNzAsOSArNzAsMTUgQEAgdm9pZCBp
b19rYnVmX3JlY3ljbGVfbGVnYWN5KHN0cnVjdCBpb19raW9jYiAqcmVxLCB1bnNpZ25lZCBp
c3N1ZV9mbGFncykKIAogCWJ1ZiA9IHJlcS0+a2J1ZjsKIAlibCA9IGlvX2J1ZmZlcl9nZXRf
bGlzdChjdHgsIGJ1Zi0+YmdpZCk7Ci0JbGlzdF9hZGQoJmJ1Zi0+bGlzdCwgJmJsLT5idWZf
bGlzdCk7CisJLyoKKwkgKiBJZiB0aGUgYnVmZmVyIGxpc3Qgd2FzIHVwZ3JhZGVkIHRvIGEg
cmluZy1iYXNlZCBvbmUsIG9yIHJlbW92ZWQsCisJICogd2hpbGUgdGhlIHJlcXVlc3Qgd2Fz
IGluLWZsaWdodCBpbiBpby13cSwgZHJvcCBpdC4KKwkgKi8KKwlpZiAoYmwgJiYgIWJsLT5p
c19tYXBwZWQpCisJCWxpc3RfYWRkKCZidWYtPmxpc3QsICZibC0+YnVmX2xpc3QpOwogCXJl
cS0+ZmxhZ3MgJj0gflJFUV9GX0JVRkZFUl9TRUxFQ1RFRDsKIAlyZXEtPmJ1Zl9pbmRleCA9
IGJ1Zi0+YmdpZDsKKwlyZXEtPmtidWYgPSBOVUxMOwogCiAJaW9fcmluZ19zdWJtaXRfdW5s
b2NrKGN0eCwgaXNzdWVfZmxhZ3MpOwogCXJldHVybjsKLS0gCjIuNTMuMAoK

--------------VlwmA7nEB2KYKfTYkuRasryA--

