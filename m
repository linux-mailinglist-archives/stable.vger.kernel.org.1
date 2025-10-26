Return-Path: <stable+bounces-189794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D47C0AA0B
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06AD3AF688
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BC62DF14A;
	Sun, 26 Oct 2025 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="u1cDIBOH"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A1C1547D2
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488893; cv=none; b=lsMLFgpUlUjrPKvofO2E+fTAA+L3J/B22cdEvHVuZkftVjjZGl0hPPyXDoS6EOQVGbT7lIzWqrvvgqUesSHNqLUHc7wa7vrCl7XlW8OnJLP+aVAhkWTrpkZmsDLROhbuEcctMibWgJiGm6qnMjmik1XvL78UssnJbA8T2e/etdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488893; c=relaxed/simple;
	bh=pVibfQkDEkMxNv4irFSPbluYYf4VO4PztMt6RJin3mA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=PxvC/+bRCGJqoRe5plKmd7+jyL26tibeHXAPgxyw+50Fan8lkFetD293pJVdTjMi4yN46IWpKNrF0wpSt17F3FPiZPjyt7zmrmiWjo5XX4fbedpq0jS3MnHuYe6wV8DUQIQP0ahQe9JpZ13KDXRkcjQG58Urz7IrC96b1RMMmD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=u1cDIBOH; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-940f8a73275so436226239f.1
        for <stable@vger.kernel.org>; Sun, 26 Oct 2025 07:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761488890; x=1762093690; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkjuGIsVHDrpkdeJRMAUUl0iEbisEBLQ3sJOBvIxlwQ=;
        b=u1cDIBOHG99kS6Tn6g3ADmhDwy6LROYL1z065ZGpZR00CE6zV10jwUyipDNjaclwSW
         Kq9jj1Q9yR3HdrEtLomBS5VJXjiK+7mGDNy5x9PyYVNwxPS7+2QxG79z27JHl2SYRwg3
         ltTjA6KkIiRsiqVxAzjjBYqih2+wJRATICawC8D+dr5G3CuH43ccnxllcyHly8dZhRiu
         vhbT598+jMWwiDgD3eziG9+V3/vwqF9d0Uu66huEH3SJBuIfESfJO53/62ByXz8T4K3y
         Ywm1gd9TxizWtdalJdNIkvpYuHz4joH6nfRu2rXGiClSsvjqV5+3RS71zaujR+tX83kQ
         6DVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488890; x=1762093690;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pkjuGIsVHDrpkdeJRMAUUl0iEbisEBLQ3sJOBvIxlwQ=;
        b=wqEnELZAxojdiCDQ24yC5qX+DElK0iONedasxbBZsueVoSm5mwMWiJ1Z7FTzyb8Y14
         PLYaMVUccj9Za2m8jpkoBIGVSujkxO9Y39QjXTpCZZscNls8pcZjVl3XQR70MsH3ZoiK
         nLcJhtFrfAFZsHxvoacuOKg6KVssfxYhu1yCDBHQeuxOTCFsm97IhHxxEu2usk+Fw3Sf
         Jsn0/C9Xtcb0oqF9tN6Dd9mO/bVhVwzOGY9+t/58Sgafwe6kEDJM4qtJA1NVjGg5ikHK
         Nb331DQAKRLAjFJqj2aVSsH8ptjHfOHKPuqgWb/+dC6X7bkfuQzyrLJrWUDvf10Noh54
         dM9Q==
X-Gm-Message-State: AOJu0YwkcBxpALd73dsuwV2vUHVHM3GETFILR+icCKv5irQrT5Lb0OK5
	ipXgNI1agAE4jVV7sByVgEG2fCF+YUPumEQxb7CZF6kodGrsOi3ljebuQiIHHMEz57M=
X-Gm-Gg: ASbGncs9ozs8ofjyVoJ7FSqx5Axwc3HZPgo33CNWnvzA5RWQ5PIfKEx1T3qEi/RaGB4
	H7BwAEFVs/ietOUpMtLE3T16x+JzR0JSsJuaKJ9KDvI1DyhF7a9mXkgQB1WVCFrNB8ZnStYBUWW
	btNK0PgHHQpQSqiYO6N7OO96mNliOdpzsL/1/TR0aAPtSgn7uNTAfz508ziYwGOuo+YlQklzOBM
	hne/AhzXcUg8CL3WGb6d+nz1It8QOENovV5jdP5Tk2WvHuyrB2qY0d7k/UCuycordsm4094C/R+
	HYGn0LrLK+R/Oi01054cqhBUs2I84yplewGGBMSYLm/1dtV/sPi+x49jaiwUaOMtoW005HObKqD
	OcSYQ7xC2DieZJx7+vGD2+OWoj2XxjnnMTpthgC2QVcMmIqOQYueNzADidZIRkfl7J7SLOBw7s1
	ydel/WQbVs7DCf/lYeH+M=
X-Google-Smtp-Source: AGHT+IH7bgpz2kYBfQfW8/4foSZQs0u5m1HvkfLWiksKYoeZPEPRI17ZyQ6cLN7M599KEaJuxLd7/A==
X-Received: by 2002:a05:6e02:23c6:b0:430:c600:64b9 with SMTP id e9e14a558f8ab-431dc20f667mr169929485ab.24.1761488889720;
        Sun, 26 Oct 2025 07:28:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea995e766sm1995396173.51.2025.10.26.07.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 07:28:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------NdnCmXqZakUp1MidXmOVRopB"
Message-ID: <27aac3f8-06e7-4320-9410-30071e8cc447@kernel.dk>
Date: Sun, 26 Oct 2025 08:28:07 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/sqpoll: be smarter on when to
 update the stime usage" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, changfengnan@bytedance.com
Cc: stable@vger.kernel.org
References: <2025102618-plastic-eldercare-f957@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025102618-plastic-eldercare-f957@gregkh>

This is a multi-part message in MIME format.
--------------NdnCmXqZakUp1MidXmOVRopB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/26/25 8:22 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x a94e0657269c5b8e1a90b17aa2c048b3d276e16d
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102618-plastic-eldercare-f957@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

And here's this one, just a single fuzzed commit after patch 1 got
applied.

-- 
Jens Axboe
--------------NdnCmXqZakUp1MidXmOVRopB
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-sqpoll-be-smarter-on-when-to-update-the-sti.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-sqpoll-be-smarter-on-when-to-update-the-sti.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBiZmU1NTQ1NzRjNDE4YzBlZjU3Y2QyMzRiZWQxYmYzMWU5YmI0ZjAwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFR1ZSwgMjEgT2N0IDIwMjUgMTE6NDQ6MzkgLTA2MDAKU3ViamVjdDogW1BBVENIIDIv
Ml0gaW9fdXJpbmcvc3Fwb2xsOiBiZSBzbWFydGVyIG9uIHdoZW4gdG8gdXBkYXRlIHRoZSBz
dGltZQogdXNhZ2UKCkNvbW1pdCBhOTRlMDY1NzI2OWM1YjhlMWE5MGIxN2FhMmMwNDhiM2Qy
NzZlMTZkIHVwc3RyZWFtLgoKVGhlIGN1cnJlbnQgYXBwcm9hY2ggaXMgYSBiaXQgbmFpdmUs
IGFuZCBoZW5jZSBjYWxscyB0aGUgdGltZSBxdWVyeWluZwp3YXkgdG9vIG9mdGVuLiBPbmx5
IHN0YXJ0IHRoZSAiZG9pbmcgd29yayIgdGltZXIgd2hlbiB0aGVyZSdzIGFjdHVhbAp3b3Jr
IHRvIGRvLCBhbmQgdGhlbiB1c2UgdGhhdCBpbmZvcm1hdGlvbiB0byB0ZXJtaW5hdGUgKGFu
ZCBhY2NvdW50KSB0aGUKd29yayB0aW1lIG9uY2UgZG9uZS4gVGhpcyBncmVhdGx5IHJlZHVj
ZXMgdGhlIGZyZXF1ZW5jeSBvZiB0aGVzZSBjYWxscywKd2hlbiB0aGV5IGNhbm5vdCBoYXZl
IGNoYW5nZWQgYW55d2F5LgoKUnVubmluZyBhIGJhc2ljIHJhbmRvbSByZWFkZXIgdGhhdCBp
cyBzZXR1cCB0byB1c2UgU1FQT0xMLCBhIHByb2ZpbGUKYmVmb3JlIHRoaXMgY2hhbmdlIHNo
b3dzIHRoZXNlIGFzIHRoZSB0b3AgY3ljbGUgY29uc3VtZXJzOgoKKyAgIDMyLjYwJSAgaW91
LXNxcC0xMDc0ICBba2VybmVsLmthbGxzeW1zXSAgW2tdIHRocmVhZF9ncm91cF9jcHV0aW1l
X2FkanVzdGVkCisgICAxOS45NyUgIGlvdS1zcXAtMTA3NCAgW2tlcm5lbC5rYWxsc3ltc10g
IFtrXSB0aHJlYWRfZ3JvdXBfY3B1dGltZQorICAgMTIuMjAlICBpb191cmluZyAgICAgIGlv
X3VyaW5nICAgICAgICAgICBbLl0gc3VibWl0dGVyX3VyaW5nX2ZuCisgICAgNC4xMyUgIGlv
dS1zcXAtMTA3NCAgW2tlcm5lbC5rYWxsc3ltc10gIFtrXSBnZXRydXNhZ2UKKyAgICAyLjQ1
JSAgaW91LXNxcC0xMDc0ICBba2VybmVsLmthbGxzeW1zXSAgW2tdIGlvX3N1Ym1pdF9zcWVz
CisgICAgMi4xOCUgIGlvdS1zcXAtMTA3NCAgW2tlcm5lbC5rYWxsc3ltc10gIFtrXSBfX3Bp
X21lbXNldF9nZW5lcmljCisgICAgMi4wOSUgIGlvdS1zcXAtMTA3NCAgW2tlcm5lbC5rYWxs
c3ltc10gIFtrXSBjcHV0aW1lX2FkanVzdAoKYW5kIGFmdGVyIHRoaXMgY2hhbmdlLCB0b3Ag
b2YgcHJvZmlsZSBsb29rcyBhcyBmb2xsb3dzOgoKKyAgIDM2LjIzJSAgaW9fdXJpbmcgICAg
IGlvX3VyaW5nICAgICAgICAgICBbLl0gc3VibWl0dGVyX3VyaW5nX2ZuCisgICAyMy4yNiUg
IGlvdS1zcXAtODE5ICBba2VybmVsLmthbGxzeW1zXSAgW2tdIGlvX3NxX3RocmVhZAorICAg
MTAuMTQlICBpb3Utc3FwLTgxOSAgW2tlcm5lbC5rYWxsc3ltc10gIFtrXSBpb19zcV90dwor
ICAgIDYuNTIlICBpb3Utc3FwLTgxOSAgW2tlcm5lbC5rYWxsc3ltc10gIFtrXSB0Y3R4X3Rh
c2tfd29ya19ydW4KKyAgICA0LjgyJSAgaW91LXNxcC04MTkgIFtrZXJuZWwua2FsbHN5bXNd
ICBba10gbnZtZV9zdWJtaXRfY21kcy5wYXJ0LjAKKyAgICAyLjkxJSAgaW91LXNxcC04MTkg
IFtrZXJuZWwua2FsbHN5bXNdICBba10gaW9fc3VibWl0X3NxZXMKWy4uLl0KICAgICAwLjAy
JSAgaW91LXNxcC04MTkgIFtrZXJuZWwua2FsbHN5bXNdICBba10gY3B1dGltZV9hZGp1c3QK
CndoZXJlIGl0J3Mgc3BlbmRpbmcgdGhlIGN5Y2xlcyBvbiB0aGluZ3MgdGhhdCBhY3R1YWxs
eSBtYXR0ZXIuCgpSZXBvcnRlZC1ieTogRmVuZ25hbiBDaGFuZyA8Y2hhbmdmZW5nbmFuQGJ5
dGVkYW5jZS5jb20+CkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCkZpeGVzOiAzZmNiOWQx
NzIwNmUgKCJpb191cmluZy9zcXBvbGw6IHN0YXRpc3RpY3Mgb2YgdGhlIHRydWUgdXRpbGl6
YXRpb24gb2Ygc3EgdGhyZWFkcyIpClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9l
QGtlcm5lbC5kaz4KLS0tCiBpb191cmluZy9zcXBvbGwuYyB8IDQzICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNl
cnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pb191cmluZy9zcXBv
bGwuYyBiL2lvX3VyaW5nL3NxcG9sbC5jCmluZGV4IGFmMjMzYjJmYWIxMC4uNDRlNzk1OWI1
MmQ5IDEwMDY0NAotLS0gYS9pb191cmluZy9zcXBvbGwuYworKysgYi9pb191cmluZy9zcXBv
bGwuYwpAQCAtMTc2LDYgKzE3NiwxMSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaW9fc3FkX2V2
ZW50c19wZW5kaW5nKHN0cnVjdCBpb19zcV9kYXRhICpzcWQpCiAJcmV0dXJuIFJFQURfT05D
RShzcWQtPnN0YXRlKTsKIH0KIAorc3RydWN0IGlvX3NxX3RpbWUgeworCWJvb2wgc3RhcnRl
ZDsKKwl1NjQgdXNlYzsKK307CisKIHU2NCBpb19zcV9jcHVfdXNlYyhzdHJ1Y3QgdGFza19z
dHJ1Y3QgKnRzaykKIHsKIAl1NjQgdXRpbWUsIHN0aW1lOwpAQCAtMTg1LDEyICsxOTAsMjQg
QEAgdTY0IGlvX3NxX2NwdV91c2VjKHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrKQogCXJldHVy
biBzdGltZTsKIH0KIAotc3RhdGljIHZvaWQgaW9fc3FfdXBkYXRlX3dvcmt0aW1lKHN0cnVj
dCBpb19zcV9kYXRhICpzcWQsIHU2NCB1c2VjKQorc3RhdGljIHZvaWQgaW9fc3FfdXBkYXRl
X3dvcmt0aW1lKHN0cnVjdCBpb19zcV9kYXRhICpzcWQsIHN0cnVjdCBpb19zcV90aW1lICpp
c3QpCit7CisJaWYgKCFpc3QtPnN0YXJ0ZWQpCisJCXJldHVybjsKKwlpc3QtPnN0YXJ0ZWQg
PSBmYWxzZTsKKwlzcWQtPndvcmtfdGltZSArPSBpb19zcV9jcHVfdXNlYyhjdXJyZW50KSAt
IGlzdC0+dXNlYzsKK30KKworc3RhdGljIHZvaWQgaW9fc3Ffc3RhcnRfd29ya3RpbWUoc3Ry
dWN0IGlvX3NxX3RpbWUgKmlzdCkKIHsKLQlzcWQtPndvcmtfdGltZSArPSBpb19zcV9jcHVf
dXNlYyhjdXJyZW50KSAtIHVzZWM7CisJaWYgKGlzdC0+c3RhcnRlZCkKKwkJcmV0dXJuOwor
CWlzdC0+c3RhcnRlZCA9IHRydWU7CisJaXN0LT51c2VjID0gaW9fc3FfY3B1X3VzZWMoY3Vy
cmVudCk7CiB9CiAKLXN0YXRpYyBpbnQgX19pb19zcV90aHJlYWQoc3RydWN0IGlvX3Jpbmdf
Y3R4ICpjdHgsIGJvb2wgY2FwX2VudHJpZXMpCitzdGF0aWMgaW50IF9faW9fc3FfdGhyZWFk
KHN0cnVjdCBpb19yaW5nX2N0eCAqY3R4LCBzdHJ1Y3QgaW9fc3FfZGF0YSAqc3FkLAorCQkJ
ICBib29sIGNhcF9lbnRyaWVzLCBzdHJ1Y3QgaW9fc3FfdGltZSAqaXN0KQogewogCXVuc2ln
bmVkIGludCB0b19zdWJtaXQ7CiAJaW50IHJldCA9IDA7CkBAIC0yMDMsNiArMjIwLDggQEAg
c3RhdGljIGludCBfX2lvX3NxX3RocmVhZChzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwgYm9v
bCBjYXBfZW50cmllcykKIAlpZiAodG9fc3VibWl0IHx8ICF3cV9saXN0X2VtcHR5KCZjdHgt
PmlvcG9sbF9saXN0KSkgewogCQljb25zdCBzdHJ1Y3QgY3JlZCAqY3JlZHMgPSBOVUxMOwog
CisJCWlvX3NxX3N0YXJ0X3dvcmt0aW1lKGlzdCk7CisKIAkJaWYgKGN0eC0+c3FfY3JlZHMg
IT0gY3VycmVudF9jcmVkKCkpCiAJCQljcmVkcyA9IG92ZXJyaWRlX2NyZWRzKGN0eC0+c3Ff
Y3JlZHMpOwogCkBAIC0yODQsNyArMzAzLDYgQEAgc3RhdGljIGludCBpb19zcV90aHJlYWQo
dm9pZCAqZGF0YSkKIAl1bnNpZ25lZCBsb25nIHRpbWVvdXQgPSAwOwogCWNoYXIgYnVmW1RB
U0tfQ09NTV9MRU5dOwogCURFRklORV9XQUlUKHdhaXQpOwotCXU2NCBzdGFydDsKIAogCS8q
IG9mZmxvYWQgY29udGV4dCBjcmVhdGlvbiBmYWlsZWQsIGp1c3QgZXhpdCAqLwogCWlmICgh
Y3VycmVudC0+aW9fdXJpbmcpIHsKQEAgLTMxOSw2ICszMzcsNyBAQCBzdGF0aWMgaW50IGlv
X3NxX3RocmVhZCh2b2lkICpkYXRhKQogCW11dGV4X2xvY2soJnNxZC0+bG9jayk7CiAJd2hp
bGUgKDEpIHsKIAkJYm9vbCBjYXBfZW50cmllcywgc3F0X3NwaW4gPSBmYWxzZTsKKwkJc3Ry
dWN0IGlvX3NxX3RpbWUgaXN0ID0geyB9OwogCiAJCWlmIChpb19zcWRfZXZlbnRzX3BlbmRp
bmcoc3FkKSB8fCBzaWduYWxfcGVuZGluZyhjdXJyZW50KSkgewogCQkJaWYgKGlvX3NxZF9o
YW5kbGVfZXZlbnQoc3FkKSkKQEAgLTMyNyw5ICszNDYsOCBAQCBzdGF0aWMgaW50IGlvX3Nx
X3RocmVhZCh2b2lkICpkYXRhKQogCQl9CiAKIAkJY2FwX2VudHJpZXMgPSAhbGlzdF9pc19z
aW5ndWxhcigmc3FkLT5jdHhfbGlzdCk7Ci0JCXN0YXJ0ID0gaW9fc3FfY3B1X3VzZWMoY3Vy
cmVudCk7CiAJCWxpc3RfZm9yX2VhY2hfZW50cnkoY3R4LCAmc3FkLT5jdHhfbGlzdCwgc3Fk
X2xpc3QpIHsKLQkJCWludCByZXQgPSBfX2lvX3NxX3RocmVhZChjdHgsIGNhcF9lbnRyaWVz
KTsKKwkJCWludCByZXQgPSBfX2lvX3NxX3RocmVhZChjdHgsIHNxZCwgY2FwX2VudHJpZXMs
ICZpc3QpOwogCiAJCQlpZiAoIXNxdF9zcGluICYmIChyZXQgPiAwIHx8ICF3cV9saXN0X2Vt
cHR5KCZjdHgtPmlvcG9sbF9saXN0KSkpCiAJCQkJc3F0X3NwaW4gPSB0cnVlOwpAQCAtMzM3
LDE1ICszNTUsMTggQEAgc3RhdGljIGludCBpb19zcV90aHJlYWQodm9pZCAqZGF0YSkKIAkJ
aWYgKGlvX3NxX3R3KCZyZXRyeV9saXN0LCBJT1JJTkdfVFdfQ0FQX0VOVFJJRVNfVkFMVUUp
KQogCQkJc3F0X3NwaW4gPSB0cnVlOwogCi0JCWxpc3RfZm9yX2VhY2hfZW50cnkoY3R4LCAm
c3FkLT5jdHhfbGlzdCwgc3FkX2xpc3QpCi0JCQlpZiAoaW9fbmFwaShjdHgpKQorCQlsaXN0
X2Zvcl9lYWNoX2VudHJ5KGN0eCwgJnNxZC0+Y3R4X2xpc3QsIHNxZF9saXN0KSB7CisJCQlp
ZiAoaW9fbmFwaShjdHgpKSB7CisJCQkJaW9fc3Ffc3RhcnRfd29ya3RpbWUoJmlzdCk7CiAJ
CQkJaW9fbmFwaV9zcXBvbGxfYnVzeV9wb2xsKGN0eCk7CisJCQl9CisJCX0KKworCQlpb19z
cV91cGRhdGVfd29ya3RpbWUoc3FkLCAmaXN0KTsKIAogCQlpZiAoc3F0X3NwaW4gfHwgIXRp
bWVfYWZ0ZXIoamlmZmllcywgdGltZW91dCkpIHsKLQkJCWlmIChzcXRfc3BpbikgewotCQkJ
CWlvX3NxX3VwZGF0ZV93b3JrdGltZShzcWQsIHN0YXJ0KTsKKwkJCWlmIChzcXRfc3BpbikK
IAkJCQl0aW1lb3V0ID0gamlmZmllcyArIHNxZC0+c3FfdGhyZWFkX2lkbGU7Ci0JCQl9CiAJ
CQlpZiAodW5saWtlbHkobmVlZF9yZXNjaGVkKCkpKSB7CiAJCQkJbXV0ZXhfdW5sb2NrKCZz
cWQtPmxvY2spOwogCQkJCWNvbmRfcmVzY2hlZCgpOwotLSAKMi41MS4wCgo=

--------------NdnCmXqZakUp1MidXmOVRopB--

