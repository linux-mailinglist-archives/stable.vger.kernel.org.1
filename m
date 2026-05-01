Return-Path: <stable+bounces-242320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE0+CRCK9GnQCAIAu9opvQ
	(envelope-from <stable+bounces-242320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:10:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 781C24ABE90
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B88003011C72
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9742D77E9;
	Fri,  1 May 2026 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="MfTptZuR"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F56813D638
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633805; cv=none; b=DQfzefVnSRwQZzEPajG1w/2BO2Wi/4Dn3bbkzxhTGrrtpC6bGbnEVoYzfwp/vqvL61dUgfIVaRfYwEceP1ox1a2njzDw7p522sDE6djGfLaaCRC1PavSuLYQixp58m5Y/Z94xke0Oc+0rN7nF7Tz2JVgeD9V62UKdZNibo9dpB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633805; c=relaxed/simple;
	bh=s2lMh/Nf2nePJINK6nBbyvJi5YrUub6zt98oJ0pH2eo=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=k0rhjNy4oMa9zC6OWvCcLQQBQ21d19ylqwoKMx+jeTS3/PcXJQNzs+jkQLL71IgqIUe+5+KGJYsYmA+oy9LsviOkzlHoGZKnpMtUKBFq4yRC4LgzBnZ69i9IPSaxINOey6cvt4zlzHysf/o8ScRipDayU+nBecHVVtrMZ6kZWEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=MfTptZuR; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-47c7b282d73so212134b6e.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777633802; x=1778238602; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KD6ZUrivrzz32rDvva9uvRueUxzgMSK/urb4fdGE0Ng=;
        b=MfTptZuRSJpNcaRuDKaKcsmczCnLOxvnY7Jgy8RxLn8jOs84BJhEweOhAgEBDGb0ck
         4aLkcMZlCBZ2wV4ehBb8x5py+8BmOOLTtNfdV+Bg0HipfDxv8eEq0ZsNoZJe70bNeV9j
         hpDmgmBQMrNKTQs9nygZMaukJPGwQqB7RidnYh2nSc82/K8I79S3g9gXjmytFtP1H6bz
         emVGUyZE0ca+A4ioV5v4uj4rBT50mYVqvrymSuyjy2hMUNoP9h8E/hA/xzj8xknHgHXY
         5JexR0l1YbVFmes3BPf20xux3d1iqrkmiCsjiTMqztPprWH3cYhuBEKJQ+WQP9jr4shy
         27AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777633802; x=1778238602;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KD6ZUrivrzz32rDvva9uvRueUxzgMSK/urb4fdGE0Ng=;
        b=eCXcSehuzEP+yJ9OfrNjO0Oohja+Hv4lmj85olrubWVUKqFghFgFUsR8wfDv+jBJbQ
         iQnyKMileImJM/0q31mcFbhDMeZdatUxvnGzLuHfgdJa4ffwQ8toYAgl9BJETGlThGPn
         q+FihsJVWOonET7r10GXbmX0rlXYm+6033qvZ4mh28LYUo7miL3LkNbP8Cs+SDCXdFa8
         QrXMrfoy3L8kac2Qs/429MNvYPj1HvsRhjBiglsBvQs2tgtqLnIVUDGEdRx0FQnq4lsj
         wVvy2DjQh9J6JEU0Drr9iqQQbNdnqUXeFp9mhxTZOiXYOrXrKNWcj/Fs4ue1WOzx2pGj
         xE6g==
X-Gm-Message-State: AOJu0Yx6RMNRReMSx348wS+P50K0R9gfflZE4BYPo+3JWGFYjrv3fJ5f
	/WoRtTi2FmY2knAodNeO3KHRSjgCQnA7w3M1RaETEieD8/0EfDNS73P8GA77UCA2n20fEajuy2O
	HQ6BJ
X-Gm-Gg: AeBDievzkWmYaHdIg9e9zR0iJGkD6qXjydz1agWTsZXHB6gE5YQ8JeTqB/KBTZ3UObH
	YXgKRHvCs7MX4ccSlBbImeo6i2rrMFULwF7AEZJpsexDLDhnLjNQrC3isSnP388mRbN4/xE2GJU
	UXAhCKYhBrqUdPSUaC7aDYF1X/ndMiZ0U+9c+ieqAwoa4d82Ry9txsYH4rfHKGhW89G8TkhUD+2
	SLCF+AaoV+Nbr9oj0hHPbihD2xVBOWZwQPGUOulypkNZgtgxngnCocF4ax+eiteUilB/Md90wHp
	CjR3OPHJIYFhLRjgn2Yr16cw4FEWx7CAvDBaoEN5JpJfk3B5IfbaEVbLcWtHRTF00Q6K1X9KQ5q
	R0JdMu9T3vVWDd8361sifjG5vBXDTE5CiXxCxOfc95NPGvGgsHpoYnNkii/SvGRD2H2GLpXIZ0Z
	E1fsNcqL5PD9UW7AIlFR6XfGDTHzV6C7E0s0OjxSkYVSumYLEWjdexbBSyLovcuURBhq1BrBhli
	MsVVOpwnX6tRsDiC86c
X-Received: by 2002:a05:6808:e8c:b0:467:16e4:d263 with SMTP id 5614622812f47-47c75796572mr1103686b6e.44.1777633801893;
        Fri, 01 May 2026 04:10:01 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43454d324a4sm2412265fac.14.2026.05.01.04.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 04:10:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------rytrB7wbBzmU0OQrBpHp2kWo"
Message-ID: <8630d4bc-119c-46dd-a39f-d699e1b830be@kernel.dk>
Date: Fri, 1 May 2026 05:10:00 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/register: fix ring resizing with
 mixed/large" failed to apply to 6.18-stable tree
To: gregkh@linuxfoundation.org, krisman@suse.de
Cc: stable@vger.kernel.org
References: <2026050117-strenuous-scrunch-c2ce@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026050117-strenuous-scrunch-c2ce@gregkh>
X-Rspamd-Queue-Id: 781C24ABE90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-242320-lists,stable=lfdr.de];
	DMARC_NA(0.00)[kernel.dk];
	RCVD_TLS_LAST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,suse.de:email,kernel-dk.20251104.gappssmtp.com:dkim]

This is a multi-part message in MIME format.
--------------rytrB7wbBzmU0OQrBpHp2kWo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/26 5:08 AM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x 45cd95763e198d74d369ede43aef0b1955b8dea4
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050117-strenuous-scrunch-c2ce@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Here's a backport for 6.18-stable.

-- 
Jens Axboe

--------------rytrB7wbBzmU0OQrBpHp2kWo
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-register-fix-ring-resizing-with-mixed-large.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-register-fix-ring-resizing-with-mixed-large.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA1ODE4NDRlNGQzY2JlZmFkYTgwNDc1NDE3NGU0NGE0NGM2YzMyOTc4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IE1vbiwgMjAgQXByIDIwMjYgMTM6NDE6MzggLTA2MDAKU3ViamVjdDogW1BBVENIXSBp
b191cmluZy9yZWdpc3RlcjogZml4IHJpbmcgcmVzaXppbmcgd2l0aCBtaXhlZC9sYXJnZQog
U1FFcy9DUUVzCgpDb21taXQgNDVjZDk1NzYzZTE5OGQ3NGQzNjllZGU0M2FlZjBiMTk1NWI4
ZGVhNCB1cHN0cmVhbS4KClRoZSByaW5nIHJlc2l6aW5nIG9ubHkgcHJvcGVybHkgaGFuZGxl
cyAibm9ybWFsIiBzaXplZCBTUUVzIG9yIENRRXMsIGlmCnRoZXJlIGFyZSBwZW5kaW5nIGVu
dHJpZXMgYXJvdW5kIGEgcmVzaXplLiBUaGlzIG5vcm1hbGx5IHNob3VsZCBub3QgYmUKdGhl
IGNhc2UsIGJ1dCB0aGUgY29kZSBpcyBzdXBwb3NlZCB0byBoYW5kbGUgdGhpcyByZWdhcmRs
ZXNzLgoKRm9yIHRoZSBtaXhlZCBTUUUvQ1FFIGNhc2VzLCB0aGUgY3VycmVudCBjb3B5aW5n
IHdvcmtzIGZpbmUgYXMgdGhleQphcmUgaW5kZXhlZCBpbiB0aGUgc2FtZSB3YXkuIEVhY2gg
aGFsZiBpcyBqdXN0IGNvcGllZCBzZXBhcmF0ZWx5LiBCdXQKZm9yIGZpeGVkIGxhcmdlIFNR
RXMgYW5kIENRRXMsIHRoZSBpdGVyYXRpb24gYW5kIGNvcHkgbmVlZCB0byB0YWtlIHRoYXQK
aW50byBhY2NvdW50LgoKQ2M6IHN0YWJsZUBrZXJuZWwub3JnCkZpeGVzOiA3OWNmZTllNTlj
MmEgKCJpb191cmluZy9yZWdpc3RlcjogYWRkIElPUklOR19SRUdJU1RFUl9SRVNJWkVfUklO
R1MiKQpSZXZpZXdlZC1ieTogR2FicmllbCBLcmlzbWFuIEJlcnRhemkgPGtyaXNtYW5Ac3Vz
ZS5kZT4KU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPgotLS0K
IGlvX3VyaW5nL3JlZ2lzdGVyLmMgfCAzNiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2lvX3VyaW5nL3JlZ2lzdGVyLmMgYi9pb191cmluZy9yZWdp
c3Rlci5jCmluZGV4IGZhYTQ0ZGQzMmNkNS4uNmM0ZWY0ODUyMTJkIDEwMDY0NAotLS0gYS9p
b191cmluZy9yZWdpc3Rlci5jCisrKyBiL2lvX3VyaW5nL3JlZ2lzdGVyLmMKQEAgLTUxNCwx
MCArNTE0LDIwIEBAIHN0YXRpYyBpbnQgaW9fcmVnaXN0ZXJfcmVzaXplX3JpbmdzKHN0cnVj
dCBpb19yaW5nX2N0eCAqY3R4LCB2b2lkIF9fdXNlciAqYXJnKQogCWlmICh0YWlsIC0gb2xk
X2hlYWQgPiBwLnNxX2VudHJpZXMpCiAJCWdvdG8gb3ZlcmZsb3c7CiAJZm9yIChpID0gb2xk
X2hlYWQ7IGkgPCB0YWlsOyBpKyspIHsKLQkJdW5zaWduZWQgc3JjX2hlYWQgPSBpICYgKGN0
eC0+c3FfZW50cmllcyAtIDEpOwotCQl1bnNpZ25lZCBkc3RfaGVhZCA9IGkgJiAocC5zcV9l
bnRyaWVzIC0gMSk7Ci0KLQkJbi5zcV9zcWVzW2RzdF9oZWFkXSA9IG8uc3Ffc3Flc1tzcmNf
aGVhZF07CisJCXVuc2lnbmVkIGluZGV4LCBkc3RfbWFzaywgc3JjX21hc2s7CisJCXNpemVf
dCBzcV9zaXplOworCisJCWluZGV4ID0gaTsKKwkJc3Ffc2l6ZSA9IHNpemVvZihzdHJ1Y3Qg
aW9fdXJpbmdfc3FlKTsKKwkJc3JjX21hc2sgPSBjdHgtPnNxX2VudHJpZXMgLSAxOworCQlk
c3RfbWFzayA9IHAuc3FfZW50cmllcyAtIDE7CisJCWlmIChjdHgtPmZsYWdzICYgSU9SSU5H
X1NFVFVQX1NRRTEyOCkgeworCQkJaW5kZXggPDw9IDE7CisJCQlzcV9zaXplIDw8PSAxOwor
CQkJc3JjX21hc2sgPSAoY3R4LT5zcV9lbnRyaWVzIDw8IDEpIC0gMTsKKwkJCWRzdF9tYXNr
ID0gKHAuc3FfZW50cmllcyA8PCAxKSAtIDE7CisJCX0KKwkJbWVtY3B5KCZuLnNxX3NxZXNb
aW5kZXggJiBkc3RfbWFza10sICZvLnNxX3NxZXNbaW5kZXggJiBzcmNfbWFza10sIHNxX3Np
emUpOwogCX0KIAlXUklURV9PTkNFKG4ucmluZ3MtPnNxLmhlYWQsIG9sZF9oZWFkKTsKIAlX
UklURV9PTkNFKG4ucmluZ3MtPnNxLnRhaWwsIHRhaWwpOwpAQCAtNTM0LDEwICs1NDQsMjAg
QEAgc3RhdGljIGludCBpb19yZWdpc3Rlcl9yZXNpemVfcmluZ3Moc3RydWN0IGlvX3Jpbmdf
Y3R4ICpjdHgsIHZvaWQgX191c2VyICphcmcpCiAJCWdvdG8gb3V0OwogCX0KIAlmb3IgKGkg
PSBvbGRfaGVhZDsgaSA8IHRhaWw7IGkrKykgewotCQl1bnNpZ25lZCBzcmNfaGVhZCA9IGkg
JiAoY3R4LT5jcV9lbnRyaWVzIC0gMSk7Ci0JCXVuc2lnbmVkIGRzdF9oZWFkID0gaSAmIChw
LmNxX2VudHJpZXMgLSAxKTsKLQotCQluLnJpbmdzLT5jcWVzW2RzdF9oZWFkXSA9IG8ucmlu
Z3MtPmNxZXNbc3JjX2hlYWRdOworCQl1bnNpZ25lZCBpbmRleCwgZHN0X21hc2ssIHNyY19t
YXNrOworCQlzaXplX3QgY3Ffc2l6ZTsKKworCQlpbmRleCA9IGk7CisJCWNxX3NpemUgPSBz
aXplb2Yoc3RydWN0IGlvX3VyaW5nX2NxZSk7CisJCXNyY19tYXNrID0gY3R4LT5jcV9lbnRy
aWVzIC0gMTsKKwkJZHN0X21hc2sgPSBwLmNxX2VudHJpZXMgLSAxOworCQlpZiAoY3R4LT5m
bGFncyAmIElPUklOR19TRVRVUF9DUUUzMikgeworCQkJaW5kZXggPDw9IDE7CisJCQljcV9z
aXplIDw8PSAxOworCQkJc3JjX21hc2sgPSAoY3R4LT5jcV9lbnRyaWVzIDw8IDEpIC0gMTsK
KwkJCWRzdF9tYXNrID0gKHAuY3FfZW50cmllcyA8PCAxKSAtIDE7CisJCX0KKwkJbWVtY3B5
KCZuLnJpbmdzLT5jcWVzW2luZGV4ICYgZHN0X21hc2tdLCAmby5yaW5ncy0+Y3Flc1tpbmRl
eCAmIHNyY19tYXNrXSwgY3Ffc2l6ZSk7CiAJfQogCVdSSVRFX09OQ0Uobi5yaW5ncy0+Y3Eu
aGVhZCwgb2xkX2hlYWQpOwogCVdSSVRFX09OQ0Uobi5yaW5ncy0+Y3EudGFpbCwgdGFpbCk7
Ci0tIAoyLjUzLjAKCg==

--------------rytrB7wbBzmU0OQrBpHp2kWo--

