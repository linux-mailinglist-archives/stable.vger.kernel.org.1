Return-Path: <stable+bounces-245620-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HCrEHMxA2oA1gEAu9opvQ
	(envelope-from <stable+bounces-245620-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:56:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DC1521C3B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D789830F6FD1
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFCE360EDD;
	Tue, 12 May 2026 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="M0c8F/Pm"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CA03905E6
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593717; cv=none; b=e3r6XAwk0nzUBnqvqv9o2oKzol5HaJVOaDUMsD6PDSEs1qtoOvNbPEloFja34TI3cvJ28vqrOWFEFf7UxZGNJ6HtcmmSu4P90tyOoWPm1njkt67Jo0VRrYUO0N6NT0sjxLCcUvYLQlTK1SBN0IamVBvFGAZXgJGqeQy87t+y8JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593717; c=relaxed/simple;
	bh=C/o8N1hxlt7c5qEouMtmcRc8Pfz7bOPUHXJv+APhCcI=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=nYKgg1THNkE2Fjod2m7ULSRlXewEhwGZpTPGg+B9HJhiFbKFnE2iSVm1QIG0xsITf9oXq/hJlqDlshMpqRnUiHEK3R1sh0C7c6aNpvcmaG6lwMmQlC8LMGwOiMj7IbkzT4FGSjPwXYA6jZBbzlEuz8kd4gM3d9v2DRRUnnowdeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=M0c8F/Pm; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6966e1a0b91so3311263eaf.3
        for <stable@vger.kernel.org>; Tue, 12 May 2026 06:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778593714; x=1779198514; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MerPRxmwPoXNcIIzF/6UqgOqYUNsW6IOGAF8gzH77ao=;
        b=M0c8F/Pm3+axOc52rLEQhygk9jKSVKt7/H9NbdjB7yAM3dofOacpV4FIoMR9ni9kSB
         7kbKjmLta3SRBHph0+NvGT6WTOX9TIZxlz9ZiWE/ZCvQM8ovAqxLxEc2xhSetkmFpCcL
         JMA4WWSyaiFDI8XiBuqpxLAorVRI2ZKtOn4PuGdlRVA0tcvX7VJhq3UZ8DS8XH0HBSBG
         mKWTzMtw2jSGDtbtQANAofAmsPIWntv7m1AxcM2xp5UrvzXu1ODnIyv8L/+8TIHqUf4d
         4xNHLgAiuUv8UiRuOfiGJdcODI6xDAr0UiHdtKazxZw+xoxNJVWagAFSLhocA8rLorK9
         Dvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778593714; x=1779198514;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MerPRxmwPoXNcIIzF/6UqgOqYUNsW6IOGAF8gzH77ao=;
        b=Yri+j8xdYTdgZ4Tf3MQQdBPe/57UWhHaaAmtTTX9SGMi2D0/OrgnAidtmBclxyXIrP
         CRuNr+EUamq/Mj6Qe83BeOO3R2YVgacrgvn7MdlFDdHBG+ETD6xXxwztmeF8ZKJtu5yc
         mO5VVk3OikYeDbJLiinXhaDllccq0sWgHknFr+1PdFrlsIRxyNMTs8XeewfCnEE7GBVj
         iAt2sedHtCyObtHw3ST9qV1eplZkTiqnsZgaNcR/1OZQqgoz2j71HkUvfcCLqxGfbjhm
         9+FtFW7/6bo0zyALFFIr0Il8O9I/AVYUOXw5FRjwoIf7XHaC80UQZxZJypXqSti7GriM
         Txrg==
X-Gm-Message-State: AOJu0YyArLAddXV/+R8lehXY85cXQsOy9rRNoddGCo8SZ+qD8aaebWmY
	yZ9CFIr664n3lyFNemta8wZ9SayCsstroQbskF47WVmxYnuJlItwF/KeMkMCnzmQ3BU=
X-Gm-Gg: Acq92OHWri1cOgINjUMIWyqjD2j5Wdo9offhue/pQcmf5hTsHrGSgTrBt4R5Yd7H1nm
	nDiPyg6dcpYttlq90KpQiUrFB3taCvXdy1MCQQHmJvTRxOb+Cbz/y6mSZSMu20LCDnqcFnmEJO9
	hupOCq3GsK47YopIul+vrnhxrmnRi0nozIW9DY3UdaqETiS2d3OdamypUsJq64OjcPwpdL+FgO4
	qvFT2TKhKo/FwgBBAsio7NzraeNgmZ/+pI/XClxLBNTaplcjowg5RcgQjnCFYaJrnYYKnm9T7e7
	s7RrPPImMwQT8MapTVMqsRdg2obVnrnKYSK6hL1Z0oQSfMZO2i1VCK2xL1/Uveub9quyMMmmmIM
	uBCV7enM3wAcm6nA5+zg3BjFsXjMbLyMX2Vh1oa6YHuq7UWk/IXrAPwUgfDSxlB60SjA76DorcF
	W4Vz/idWoME6uxcoRWn7cuEcWLdcpg4iRra+bh2TGFc0z7RpyCkHcC+Nou5Pvv90eyaiQQQyp+J
	OHmFvtF
X-Received: by 2002:a05:6820:80a:b0:695:818c:e56c with SMTP id 006d021491bc7-69998c8f448mr14815519eaf.7.1778593714264;
        Tue, 12 May 2026 06:48:34 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43557371c56sm11865308fac.9.2026.05.12.06.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 06:48:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------YKOONVjA0w60ueCPKCMHoxTp"
Message-ID: <c89c58b7-8d1e-457f-8f8b-acfb4895b6f1@kernel.dk>
Date: Tue, 12 May 2026 07:48:32 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/tw: serialize ctx->retry_llist
 with ->uring_lock" failed to apply to 6.18-stable tree
To: gregkh@linuxfoundation.org, invd@inhq.net, michael.rodler@x41-dsec.de,
 robert.femmer@x41-dsec.de
Cc: stable@vger.kernel.org
References: <2026051242-reproach-duplicity-8d39@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026051242-reproach-duplicity-8d39@gregkh>
X-Rspamd-Queue-Id: B9DC1521C3B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-245620-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:email,kernel.dk:email,kernel.dk:mid,kernel-dk.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

This is a multi-part message in MIME format.
--------------YKOONVjA0w60ueCPKCMHoxTp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/26 6:41 AM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x 17666e2d7592c3e85260cafd3950121524acc2c5
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051242-reproach-duplicity-8d39@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Here's one for 6.18-stable.

-- 
Jens Axboe

--------------YKOONVjA0w60ueCPKCMHoxTp
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-tw-serialize-ctx-retry_llist-with-uring_loc.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-tw-serialize-ctx-retry_llist-with-uring_loc.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA4ZDlkNTNmNzQ1YmQ2YWRhNTI2ZWExZDVjM2ZhYmY0ZmQ4ZDc1NmViIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IE1vbiwgMjcgQXByIDIwMjYgMTk6MTY6MzkgLTA2MDAKU3ViamVjdDogW1BBVENIIDEv
Ml0gaW9fdXJpbmcvdHc6IHNlcmlhbGl6ZSBjdHgtPnJldHJ5X2xsaXN0IHdpdGggLT51cmlu
Z19sb2NrCgpDb21taXQgMTc2NjZlMmQ3NTkyYzNlODUyNjBjYWZkMzk1MDEyMTUyNGFjYzJj
NSB1cHN0cmVhbS4KClRoZSBERUZFUl9UQVNLUlVOIGxvY2FsIHRhc2sgd29yayBwYXRocyBh
bGwgcnVuIHVuZGVyIGN0eC0+dXJpbmdfbG9jaywKd2hpY2ggc2VyaWFsaXplcyB0aGVtIHdp
dGggZWFjaCBvdGhlciBhbmQgd2l0aCB0aGUgcmVzdCBvZiB0aGUgcmluZydzCmhvdCBwYXRo
cy4gaW9fbW92ZV90YXNrX3dvcmtfZnJvbV9sb2NhbCgpIGlzIHRoZSBleGNlcHRpb24gLSBp
dCdzIGNhbGxlZApmcm9tIGlvX3JpbmdfZXhpdF93b3JrKCkgb24gYSBrd29ya2VyIHdpdGhv
dXQgaG9sZGluZyB0aGUgbG9jayBhbmQgZnJvbQp0aGUgaW9wb2xsIGNhbmNlbGF0aW9uIHNp
ZGUgcmlnaHQgYWZ0ZXIgZHJvcHBpbmcgaXQuCgotPndvcmtfbGxpc3QgaXMgZmluZSB3aXRo
IHRoaXMsIGFzIGl0J3Mgb25seSBldmVyIHVwZGF0ZWQgdmlhIHRoZQpleHBlY3RlZCBwYXRo
cy4gQnV0IHRoZSAtPnJldHJ5X2xsaXN0IGlzIHVwZGF0ZWQgd2hpbGUgcnVuaW5nLCBhbmQg
aGVuY2UKaXQgY291bGQgcG90ZW50aWFsbHkgcmFjZSBiZXR3ZWVuIG5vcm1hbCB0YXNrX3dv
cmsgcnVubmluZyBhbmQgdGhlCnRhc2staGFzLWV4aXRlZCBzaHV0ZG93biBwYXRoLgoKU2lt
cGx5IGdyYWIgLT51cmluZ19sb2NrIHdoaWxlIG1vdmluZyB0aGUgbG9jYWwgd29yayB0byB0
aGUgZmFsbGJhY2sKbGlzdCBmb3IgZXhpdCBwdXJwb3Nlcywgd2hpY2ggbmljZWx5IHNlcmlh
bGl6ZXMgaXQgYWNyb3NzIGJvdGggdGhlCm5vcm1hbCBhZGRpdGlvbnMgYW5kIHRoZSBleGl0
IHBydW5lIHBhdGguCgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpGaXhlczogZjQ2Yjlj
ZGIyMmY3ICgiaW9fdXJpbmc6IGxpbWl0IGxvY2FsIHR3IGRvbmUiKQpTaWduZWQtb2ZmLWJ5
OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcvaW9fdXJpbmcu
YyB8IDEyICsrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9pb191cmluZy9pb191cmluZy5jIGIvaW9f
dXJpbmcvaW9fdXJpbmcuYwppbmRleCA5OWNkNWJjYWMyMDEuLjAzZTdiOWQ2YjQ0OCAxMDA2
NDQKLS0tIGEvaW9fdXJpbmcvaW9fdXJpbmcuYworKysgYi9pb191cmluZy9pb191cmluZy5j
CkBAIC0xMzcwLDggKzEzNzAsMTggQEAgdm9pZCBpb19yZXFfdGFza193b3JrX2FkZF9yZW1v
dGUoc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGZsYWdzKQogCiBzdGF0aWMgdm9p
ZCBfX2NvbGQgaW9fbW92ZV90YXNrX3dvcmtfZnJvbV9sb2NhbChzdHJ1Y3QgaW9fcmluZ19j
dHggKmN0eCkKIHsKLQlzdHJ1Y3QgbGxpc3Rfbm9kZSAqbm9kZSA9IGxsaXN0X2RlbF9hbGwo
JmN0eC0+d29ya19sbGlzdCk7CisJc3RydWN0IGxsaXN0X25vZGUgKm5vZGU7CiAKKwkvKgor
CSAqIFJ1bm5pbmcgdGhlIHdvcmsgaXRlbXMgbWF5IHV0aWxpemUgLT5yZXRyeV9sbGlzdCBh
cyBhIG1lYW5zCisJICogZm9yIGNhcHBpbmcgdGhlIG51bWJlciBvZiB0YXNrX3dvcmsgZW50
cmllcyBydW4gYXQgdGhlIHNhbWUKKwkgKiB0aW1lLiBCdXQgdGhhdCBsaXN0IGNhbiBwb3Rl
bnRpYWxseSByYWNlIHdpdGggbW92aW5nIHRoZSB3b3JrCisJICogZnJvbSBoZXJlLCBpZiB0
aGUgdGFzayBpcyBleGl0aW5nLiBBcyBhbnkgbm9ybWFsIHRhc2tfd29yaworCSAqIHJ1bm5p
bmcgaG9sZHMgLT51cmluZ19sb2NrIGFscmVhZHksIGp1c3QgZ3VhcmQgdGhpcyBzbG93IHBh
dGgKKwkgKiB3aXRoIC0+dXJpbmdfbG9jayB0byBhdm9pZCByYWNpbmcgb24gLT5yZXRyeV9s
bGlzdC4KKwkgKi8KKwlndWFyZChtdXRleCkoJmN0eC0+dXJpbmdfbG9jayk7CisJbm9kZSA9
IGxsaXN0X2RlbF9hbGwoJmN0eC0+d29ya19sbGlzdCk7CiAJX19pb19mYWxsYmFja190dyhu
b2RlLCBmYWxzZSk7CiAJbm9kZSA9IGxsaXN0X2RlbF9hbGwoJmN0eC0+cmV0cnlfbGxpc3Qp
OwogCV9faW9fZmFsbGJhY2tfdHcobm9kZSwgZmFsc2UpOwotLSAKMi41My4wCgo=

--------------YKOONVjA0w60ueCPKCMHoxTp--

