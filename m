Return-Path: <stable+bounces-240267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN0nGTU76GlfHQIAu9opvQ
	(envelope-from <stable+bounces-240267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 05:06:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA361441B3D
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 05:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5391330239B2
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 03:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C443A2564;
	Wed, 22 Apr 2026 03:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="rZzCwGbF"
X-Original-To: stable@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5752FA0DF;
	Wed, 22 Apr 2026 03:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776827172; cv=none; b=VxefWwIE0/23a+KBop7gTGSttoLEzbDNz+/RqnrhvfKwwrXI9inQIXApZWP0ibuNrj+p6BZvfoUaMxfhyJgwh2E+Mt3hEc2kgwhLFRANhA2guCNCnMIP6OrixJCEOC5Vn+8ExpDh2MA53xjzHn4zmcHnUVGDE91bZXNSasiVW34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776827172; c=relaxed/simple;
	bh=blqL3mFR3adcGH2UwlHQGd8Qsd7EOzat16kRkRxuVJI=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=YGcp8muUxRlnGJnbev7LcS6dFOt0eSxoNdgf6wvP/z59PYpy+aQqUwXWI2yWLC0/78LnU7wAm+L+yYeEURjbUOsAfGhcpkGAH/5ntgP3dDPbZsrGkF7bejWJMkEuJaKF57ubNSuVMS7F5ppx9rkEewNCJJI8KJcoMmPUcM/ZDVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=rZzCwGbF; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 134C0285D92;
	Wed, 22 Apr 2026 05:05:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1776827157; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=GHskIr3MgwHrZ7dL2xhkZFz/E44lGNvOcI3NVnkH408=;
	b=rZzCwGbFWaWR8m5fGg90vTVSwYQSDYFzoQIz1T3NtdIOaI/dP7YA+x8bVI2mohI0YtdQME
	eIuFxSahRhdMQjnyDxfkDxkC2zLDV1qp9WkzJJZviWXY4m4eTXTfc77c5ZDqcASvPZ8oV4
	GSK2m+/rFRliqkNc9WyMai8g3Qm1ejxXCRYImMHse7kxClt/dTm1g/F5hPovMorHlsK1Yl
	82Dx8osUkZPrzcF1sjqpavVXLuR5mljj6KEkl44eeqTOjtn5v+PXA/q8/V9Dm/oZVCxlfa
	5ux/NYzaKqCMFq+tWU6x59UZxIGsWo7snLPeyj8SQW3Iz+yphqHASrBd7Fts0Q==
Content-Type: multipart/mixed; boundary="------------xnDkrZ0X6chx0hMrZz4YRIXk"
Message-ID: <e97a0147-4aea-445c-b0ce-c6d20b5ccfa2@cachyos.org>
Date: Wed, 22 Apr 2026 03:05:00 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Legion S7 15IMH
To: Takashi Iwai <tiwai@suse.de>, Cameron Berkenpas <cam@neo-zeon.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 stable@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260413154818.351597-1-dnaim@cachyos.org>
 <87ik9uua4a.wl-tiwai@suse.de>
 <ed4dae33-7c4e-4ccc-82c1-fa1aee137bcd@cachyos.org>
 <878qaqt40c.wl-tiwai@suse.de>
From: Eric Naim <dnaim@cachyos.org>
In-Reply-To: <878qaqt40c.wl-tiwai@suse.de>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cachyos.org,quarantine];
	R_DKIM_ALLOW(-0.20)[cachyos.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240267-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[cachyos.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dnaim@cachyos.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EA361441B3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.
--------------xnDkrZ0X6chx0hMrZz4YRIXk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/26 3:06 PM, Takashi Iwai wrote:
> On Tue, 14 Apr 2026 05:28:00 +0200,
> Eric Naim wrote:
>>
>> On 4/13/26 11:56 PM, Takashi Iwai wrote:
>>> On Mon, 13 Apr 2026 17:48:17 +0200,
>>> Eric Naim wrote:
>>>>
>>>> Fix speaker output on the Lenovo Legion S7 15IMH05.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Eric Naim <dnaim@cachyos.org>
>>>
>>> Thanks, applied now.
>>>
>>>
>>> Takashi
>>
>> Sorry Takashi, can you remove this from your tree? I seem to have gotten the
>> PID wrong for this device. I'll follow up with a v2 or fixup once I've
>> confirmed I got the correct PID. Let me know which of the two resolutions you
>> prefer.
> 
> As the tree was published, could you rather a correction patch on the
> top?  Put Fixes tag for pointing to the corrected commit.
> 
> 
> thanks,
> 
> Takashi

Alright, I finally got a reply from the user that requested this from me.
After looking at [1] and reading through [2], it looks like the HDA verbs for
ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS are just copied from
ALC287_FIXUP_YOGA7_14ITL_SPEAKERS, and is different from the original patch
that was tested in [2] and the provided verbs from [1].

Cameron, you submitted the original patch for this. Can you confirm?

Attached is my proposal fix for the ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS
quirk. I'll get the reporter to test this and report back.

[1]
https://github.com/thiagotei/linux-realtek-alc287/blob/2a3a57c14adf3313d4c14df1a0a8a8bd3f544369/lenovo-legion/verbs-legion.txt

[2] https://bugzilla.kernel.org/show_bug.cgi?id=208555

-- 
Regards,
  Eric
--------------xnDkrZ0X6chx0hMrZz4YRIXk
Content-Type: text/x-patch; charset=UTF-8; name="15imh-fixup.patch"
Content-Disposition: attachment; filename="15imh-fixup.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3NvdW5kL2hkYS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYyBiL3NvdW5k
L2hkYS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYwppbmRleCBhZTc0ZTFiNjllYjMuLjFmMTc0
YjcwZWM1NyAxMDA2NDQKLS0tIGEvc291bmQvaGRhL2NvZGVjcy9yZWFsdGVrL2FsYzI2OS5j
CisrKyBiL3NvdW5kL2hkYS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYwpAQCAtNjEwNywxMiAr
NjEwNyw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaGRhX2ZpeHVwIGFsYzI2OV9maXh1cHNb
XSA9IHsKIAkJCSB7IDB4MjAsIEFDX1ZFUkJfU0VUX0NPRUZfSU5ERVgsIDB4MjQgfSwKIAkJ
CSB7IDB4MjAsIEFDX1ZFUkJfU0VUX1BST0NfQ09FRiwgMHg0MSB9LAogCi0JCQkgeyAweDIw
LCBBQ19WRVJCX1NFVF9DT0VGX0lOREVYLCAweDI2IH0sCi0JCQkgeyAweDIwLCBBQ19WRVJC
X1NFVF9QUk9DX0NPRUYsIDB4YyB9LAotCQkJIHsgMHgyMCwgQUNfVkVSQl9TRVRfUFJPQ19D
T0VGLCAweDAgfSwKLQkJCSB7IDB4MjAsIEFDX1ZFUkJfU0VUX1BST0NfQ09FRiwgMHgxYSB9
LAotCQkJIHsgMHgyMCwgQUNfVkVSQl9TRVRfUFJPQ19DT0VGLCAweGIwMjAgfSwKLQogCQkJ
IHsgMHgyMCwgQUNfVkVSQl9TRVRfQ09FRl9JTkRFWCwgMHgyNiB9LAogCQkJIHsgMHgyMCwg
QUNfVkVSQl9TRVRfUFJPQ19DT0VGLCAweDIgfSwKIAkJCSB7IDB4MjAsIEFDX1ZFUkJfU0VU
X1BST0NfQ09FRiwgMHgwIH0sCg==

--------------xnDkrZ0X6chx0hMrZz4YRIXk--

