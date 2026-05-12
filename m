Return-Path: <stable+bounces-245813-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNDNLfQ9A2po2AEAu9opvQ
	(envelope-from <stable+bounces-245813-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:49:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B86E522E65
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A66C3035EC5
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE1C346FCF;
	Tue, 12 May 2026 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="IaEox8m+"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BBA1D54FA
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597360; cv=none; b=SJulB+fV7wogcIdF4tjgMz8qFpBIJFxypSSxgmepHVrVNyiZK1sABliIAlgf32gX7pIWfpcPb5Jmn1PjVF/RB0jBh+tWHtGko4AV03OuiQWUx0j8SZ/cI8ACRpT0mT1EGXV5qr7cKfv1Fg/D4EeOJ2WI9rfD5OEU8tsVxt7XKI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597360; c=relaxed/simple;
	bh=f5QcyMJ6kfj/GfZxDsjJoPYHgDWJv9bievkdBnjUGU8=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=ks8gvDQC7vzD5pcCnHN6l36lpQjRcTDRSLuD+jW52hoKVJvys0zbOKwlwrpzJRs6DcFyBGTlJ5N4qDaRjrD20hNpPrUcfGIrOo2vcdox79I8SHDy2VIjwFTE1Yw38fKdUtd1TmvBGLcWYYcIXTD9POhmz79gHvSBTIhpCzSP97c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=IaEox8m+; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-694891f8f75so3110698eaf.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 07:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778597357; x=1779202157; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Bw9ZIy4OmTh0fnXdGR/tkY5AYd5Ek2mqS5yN/895JU=;
        b=IaEox8m+148Dstq4kJ7UvJAEzYqMb0TFhdc4AkBlucWc8HdxQm34PDF5Lq0kI2dDsY
         HH1uqN3Ma2JQ+9/T7au2R86sReThJ9459K4vHySKvHjoV9loxaGwQqzwlMS3M4mQku2V
         mtZh5XwXHzkvfl1rNBQHiz1Nz/jgHOXxLVyG+a9OLRRlDmBOSfqnmXMSx2Joc46/xX8z
         CV3G4U+rCLJb7digG2Ee9iXTVsW7OStkFe4WA0207Iid0NgykiVWw6dWlsmHFd3+KJW+
         suLRQAUjx3ug2mP/p+rxeGQCuSi+XpTKEFj9aF1SNb42McB4HIG3h/H9gEowWZgOs9q0
         g5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778597357; x=1779202157;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Bw9ZIy4OmTh0fnXdGR/tkY5AYd5Ek2mqS5yN/895JU=;
        b=S5j/49DlgRC7YdAXUyDIHmXdBr5q7ARa0+HLsEVmrk9S3GnuWTZgz0npdBlk4Vlg5k
         ebQ4cSHdbQjfGNpV/aX16+2RZLXPLoJkDXlKjDSW7IGFg6olfB9r3q6C2mw5OLgVeSOb
         sZ5lomWI4iWsFumwyBK3BGc8+ised+Uo14nqXyE0rOQMv8e9/4WIbC+/g/Fhyg/rMAGP
         47rfPcoxYfgg6tfsamlzMBNDk3JAxYz/P3gZ1vP9QZCzgzoGHcQTHpq6nyJruZTYeaDl
         hMC9AiRO4ZH+0L4yI0t8Qj7wwq46YiLbSlTxzBrvT596wYgatpoVECweVZPIEbE8V2uk
         8z8Q==
X-Gm-Message-State: AOJu0YxuBvfq4Bc7Q8ZrqUrTQrNhGOjsDMrGrRTKdk+KLASdFu8yMRCI
	z8lH2Uep9eWdfTq2OwUx48wFe9CEGtEpLXxhsDJari6z2zok/v5oozQuYI7Z4qoAih8=
X-Gm-Gg: Acq92OFIqhjetjsp9y4fKfw0uO1La5+2gY+WXs6XL9mVbjO1gb3z0YWh4tyDzcmDORR
	FrQSVDq7rzh96E712S4Dtzpy11xDLWI+G7RlzLiyDYqWXtTjo92C4BipCDeiIB/EoZo49Awsige
	oP/80MXpw1fBFG5rKHYOzTmxmyNurtayeDaa+OWIj1nw1B2NDrp2e9U+3aj32juzgPm7ovJp7B+
	diOK1Gr6johpx0a5Q1C2K8nu1iyWgr7NLWttvDx/tYSz6+fd+Ox+/RPe2ylTK614CxZYfW5PLqV
	AiKWH2VJ6qMvDkUj0Kfc0WO2AMWDaCBzVzQOKlhYZwKh3cn1Jy3ipxyryZYSyqgr8ZBgfA/DVAx
	0ZTbMaANBy1Av6wwLAA439elOka0nie3zEzi7ZD2WvGej56JpFNL3Lb3d7Gbas/PH9J3N4C3GAk
	rsNsTHyxj6izyeAQ5cP2W513Fp081ks7NT7/LoN6x2sdk2g0VqkAvAIDNqVHoMikhGzMGLJQmvs
	rRykI3C8jqmj8cdX2s=
X-Received: by 2002:a05:6820:178a:b0:686:d107:2865 with SMTP id 006d021491bc7-69998d5667amr16697001eaf.59.1778597356665;
        Tue, 12 May 2026 07:49:16 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-435574490b0sm13133456fac.17.2026.05.12.07.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 07:49:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------h7icaw2kWRlihDlB0uahbYBC"
Message-ID: <28c625f8-e34b-4086-b112-a3a99fc4950b@kernel.dk>
Date: Tue, 12 May 2026 08:49:13 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: support min length left for
 incremental" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, code@mgjm.de, krisman@suse.de
Cc: stable@vger.kernel.org
References: <2026051233-murkiness-french-8ca4@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026051233-murkiness-french-8ca4@gregkh>
X-Rspamd-Queue-Id: 5B86E522E65
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-245813-lists,stable=lfdr.de];
	DMARC_NA(0.00)[kernel.dk];
	RCVD_TLS_LAST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linuxfoundation.org:email,kernel.dk:email,kernel.dk:mid,gregkh:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is a multi-part message in MIME format.
--------------h7icaw2kWRlihDlB0uahbYBC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/26 6:41 AM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x 7deba791ad495ce1d7921683f4f7d1190fa210d1
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051233-murkiness-french-8ca4@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Here's on for 6.12-stable.

-- 
Jens Axboe

--------------h7icaw2kWRlihDlB0uahbYBC
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-kbuf-support-min-length-left-for-incrementa.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-kbuf-support-min-length-left-for-incrementa.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA0NDcwZjMwZThhMGVmMWQ4NzU5ZDQ0NmZjYTc5YTY1OTlhMjU2YjFhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJ0aW4gTWljaGFlbGlzIDxjb2RlQG1nam0uZGU+
CkRhdGU6IFRodSwgMjMgQXByIDIwMjYgMTU6NTQ6MTEgLTA2MDAKU3ViamVjdDogW1BBVENI
XSBpb191cmluZy9rYnVmOiBzdXBwb3J0IG1pbiBsZW5ndGggbGVmdCBmb3IgaW5jcmVtZW50
YWwKIGJ1ZmZlcnMKCkluY3JlbWVudGFsbHkgY29uc3VtZWQgYnVmZmVyIHJpbmdzIGFyZSBn
ZW5lcmFsbHkgZnVsbHkgY29uc3VtZWQsIGJ1dAppdCdzIHF1aXRlIHBvc3NpYmxlIHRoYXQg
dGhlIGFwcGxpY2F0aW9uIGhhcyBhIG1pbmltdW0gc2l6ZSBpdCBuZWVkcyB0bwptZWV0IHRv
IGF2b2lkIHRydW5jYXRpb24uIEN1cnJlbnRseSB0aGF0IG1pbmltdW0gbGltaXQgaXMgMSBi
eXRlLCBidXQKdGhpcyBzaG91bGQgYmUgYSBzZXR0aW5nIHRoYXQgaXMgdGhlIGhhbmRzIG9m
IHRoZSBhcHBsaWNhdGlvbi4gRm9yCnJlY3Ztc2cgbXVsdGlzaG90LCBhIHByaW1lIHVzZSBj
YXNlIGZvciBpbmNyZW1lbnRhbGx5IGNvbnN1bWVkIGJ1ZmZlcnMsCnRoZSBhcHBsaWNhdGlv
biBtYXkgZ2V0IHNwdXJpb3VzIC1FRkFVTFQgcmV0dXJuZWQgYXQgdGhlIGVuZCBvZiBhbgpp
bmNyZW1lbnRhbGx5IGNvbnN1bWVkIGJ1ZmZlciwgYXMgbGVzcyBzcGFjZSBpcyBhdmFpbGFi
bGUgdGhhbiB0aGUKaGVhZGVycyBuZWVkLgoKR3JhYiBhIHUzMiBmaWVsZCBpbiBzdHJ1Y3Qg
aW9fdXJpbmdfYnVmX3JlZywgd2hpY2ggdGhlIGFwcGxpY2F0aW9uIGNhbgp1c2UgdG8gaW5m
b3JtIHRoZSBrZXJuZWwgb2YgdGhlIG1pbmltdW0gc2l6ZSB0aGF0IHNob3VsZCBiZSBhdmFp
bGFibGUKaW4gYW4gaW5jcmVtZW50YWxseSBjb25zdW1lZCBidWZmZXIuIElmIGxlc3MgdGhh
biB0aGF0IGlzIGF2YWlsYWJsZSwKdGhlIGN1cnJlbnQgYnVmZmVyIGlzIGZ1bGx5IHByb2Nl
c3NlZCBhbmQgdGhlIG5leHQgb25lIHdpbGwgYmUgcGlja2VkLgoKQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcKRml4ZXM6IGFlOThkYmY0M2Q3NSAoImlvX3VyaW5nL2tidWY6IGFkZCBz
dXBwb3J0IGZvciBpbmNyZW1lbnRhbCBidWZmZXIgY29uc3VtcHRpb24iKQpMaW5rOiBodHRw
czovL2dpdGh1Yi5jb20vYXhib2UvbGlidXJpbmcvaXNzdWVzLzE0MzMKU2lnbmVkLW9mZi1i
eTogTWFydGluIE1pY2hhZWxpcyA8Y29kZUBtZ2ptLmRlPgpbYXhib2U6IHdyaXRlIGNvbW1p
dCBtZXNzYWdlLCBjaGFuZ2UgaW9fYnVmZmVyX2xpc3QgbWVtYmVyIG5hbWVdClJldmlld2Vk
LWJ5OiBHYWJyaWVsIEtyaXNtYW4gQmVydGF6aSA8a3Jpc21hbkBzdXNlLmRlPgpTaWduZWQt
b2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CihjaGVycnkgcGlja2VkIGZy
b20gY29tbWl0IDdkZWJhNzkxYWQ0OTVjZTFkNzkyMTY4M2Y0ZjdkMTE5MGZhMjEwZDEpCi0t
LQogaW5jbHVkZS91YXBpL2xpbnV4L2lvX3VyaW5nLmggfCAzICsrLQogaW9fdXJpbmcva2J1
Zi5jICAgICAgICAgICAgICAgfCA4ICsrKysrKystCiBpb191cmluZy9rYnVmLmggICAgICAg
ICAgICAgICB8IDcgKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9pb191
cmluZy5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2lvX3VyaW5nLmgKaW5kZXggMzNjYmUzYTRl
ZDNlLi5mZGQ3YjkzMWVhMWQgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9pb191
cmluZy5oCisrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9pb191cmluZy5oCkBAIC03NTgsNyAr
NzU4LDggQEAgc3RydWN0IGlvX3VyaW5nX2J1Zl9yZWcgewogCV9fdTMyCXJpbmdfZW50cmll
czsKIAlfX3UxNgliZ2lkOwogCV9fdTE2CWZsYWdzOwotCV9fdTY0CXJlc3ZbM107CisJX191
MzIJbWluX2xlZnQ7CisJX191MzIJcmVzdls1XTsKIH07CiAKIC8qIGFyZ3VtZW50IGZvciBJ
T1JJTkdfUkVHSVNURVJfUEJVRl9TVEFUVVMgKi8KZGlmZiAtLWdpdCBhL2lvX3VyaW5nL2ti
dWYuYyBiL2lvX3VyaW5nL2tidWYuYwppbmRleCAzNDE4NGE3MzgxOTUuLmJkNmU1YzBmNjgz
YSAxMDA2NDQKLS0tIGEvaW9fdXJpbmcva2J1Zi5jCisrKyBiL2lvX3VyaW5nL2tidWYuYwpA
QCAtNDcsNyArNDcsNyBAQCBzdGF0aWMgYm9vbCBpb19rYnVmX2luY19jb21taXQoc3RydWN0
IGlvX2J1ZmZlcl9saXN0ICpibCwgaW50IGxlbikKIAkJdGhpc19sZW4gPSBtaW5fdCh1MzIs
IGxlbiwgYnVmX2xlbik7CiAJCWJ1Zl9sZW4gLT0gdGhpc19sZW47CiAJCS8qIFN0b3AgbG9v
cGluZyBmb3IgaW52YWxpZCBidWZmZXIgbGVuZ3RoIG9mIDAgKi8KLQkJaWYgKGJ1Zl9sZW4g
fHwgIXRoaXNfbGVuKSB7CisJCWlmIChidWZfbGVuID4gYmwtPm1pbl9sZWZ0X3N1Yl9vbmUg
fHwgIXRoaXNfbGVuKSB7CiAJCQlXUklURV9PTkNFKGJ1Zi0+YWRkciwgUkVBRF9PTkNFKGJ1
Zi0+YWRkcikgKyB0aGlzX2xlbik7CiAJCQlXUklURV9PTkNFKGJ1Zi0+bGVuLCBidWZfbGVu
KTsKIAkJCXJldHVybiBmYWxzZTsKQEAgLTcyNyw2ICs3MjcsMTAgQEAgaW50IGlvX3JlZ2lz
dGVyX3BidWZfcmluZyhzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwgdm9pZCBfX3VzZXIgKmFy
ZykKIAlpZiAocmVnLnJpbmdfZW50cmllcyA+PSA2NTUzNikKIAkJcmV0dXJuIC1FSU5WQUw7
CiAKKwkvKiBtaW5pbXVtIGxlZnQgYnl0ZSBjb3VudCBpcyBhIHByb3BlcnR5IG9mIGluY3Jl
bWVudGFsIGJ1ZmZlcnMgKi8KKwlpZiAoIShyZWcuZmxhZ3MgJiBJT1VfUEJVRl9SSU5HX0lO
QykgJiYgcmVnLm1pbl9sZWZ0KQorCQlyZXR1cm4gLUVJTlZBTDsKKwogCWJsID0gaW9fYnVm
ZmVyX2dldF9saXN0KGN0eCwgcmVnLmJnaWQpOwogCWlmIChibCkgewogCQkvKiBpZiBtYXBw
ZWQgYnVmZmVyIHJpbmcgT1IgY2xhc3NpYyBleGlzdHMsIGRvbid0IGFsbG93ICovCkBAIC03
NDcsNiArNzUxLDggQEAgaW50IGlvX3JlZ2lzdGVyX3BidWZfcmluZyhzdHJ1Y3QgaW9fcmlu
Z19jdHggKmN0eCwgdm9pZCBfX3VzZXIgKmFyZykKIAlpZiAoIXJldCkgewogCQlibC0+bnJf
ZW50cmllcyA9IHJlZy5yaW5nX2VudHJpZXM7CiAJCWJsLT5tYXNrID0gcmVnLnJpbmdfZW50
cmllcyAtIDE7CisJCWlmIChyZWcubWluX2xlZnQpCisJCQlibC0+bWluX2xlZnRfc3ViX29u
ZSA9IHJlZy5taW5fbGVmdCAtIDE7CiAJCWlmIChyZWcuZmxhZ3MgJiBJT1VfUEJVRl9SSU5H
X0lOQykKIAkJCWJsLT5mbGFncyB8PSBJT0JMX0lOQzsKIApkaWZmIC0tZ2l0IGEvaW9fdXJp
bmcva2J1Zi5oIGIvaW9fdXJpbmcva2J1Zi5oCmluZGV4IGQwOTExMzI3Yzk4My4uOTVjOTEz
NzU1MGE3IDEwMDY0NAotLS0gYS9pb191cmluZy9rYnVmLmgKKysrIGIvaW9fdXJpbmcva2J1
Zi5oCkBAIC0zOCw2ICszOCwxMyBAQCBzdHJ1Y3QgaW9fYnVmZmVyX2xpc3QgewogCV9fdTE2
IGZsYWdzOwogCiAJYXRvbWljX3QgcmVmczsKKworCS8qCisJICogbWluaW11bSByZXF1aXJl
ZCBhbW91bnQgdG8gYmUgbGVmdCB0byByZXVzZSBhbiBpbmNyZW1lbnRhbGx5CisJICogY29u
c3VtZWQgYnVmZmVyLiBJZiBsZXNzIHRoYW4gdGhpcyBpcyBsZWZ0IGF0IGNvbnN1bXB0aW9u
IHRpbWUsCisJICogYnVmZmVyIGlzIGRvbmUgYW5kIGhlYWQgaXMgaW5jcmVtZW50ZWQgdG8g
dGhlIG5leHQgYnVmZmVyLgorCSAqLworCV9fdTMyIG1pbl9sZWZ0X3N1Yl9vbmU7CiB9Owog
CiBzdHJ1Y3QgaW9fYnVmZmVyIHsKLS0gCjIuNTMuMAoK

--------------h7icaw2kWRlihDlB0uahbYBC--

