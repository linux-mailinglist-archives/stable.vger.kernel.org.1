Return-Path: <stable+bounces-223128-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL44Aax+qGmYvAAAu9opvQ
	(envelope-from <stable+bounces-223128-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 19:49:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7972E206A19
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 19:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F67B3005EBC
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 18:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDB13CB2E7;
	Wed,  4 Mar 2026 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gZBuOsHu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE751DDA18
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772650151; cv=none; b=pm7h/JGc5kGZeKwIsEzeCjgOcPtjLDyTol80MHPFMvVmHVkUihkVZOcfbq3pKYproPztiKL+9f62QpGqz6hDzZE5F+zvYglnoOYIJX53hjd3iLVzAOqf01H64W+X3iGnF/b9P/RrAARcIkb7BCgo2kKDK4owleDvd0HNl3RnREA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772650151; c=relaxed/simple;
	bh=bWep8U4TNVkDclsxjRLewSRSakxtZXQhKrgyA29n9/w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EWnLcLoJ1hdrTNj2k+REBmH3E0XkjnIUQfeP81Xtygh/3ObOI6C+Xq2BDjeMRLPFnFQJygsceoSxUhySZLZDS9w9Fgurvpcedsbp9BDboshT1OPxNQHK3ulqo4n/VNGJWLqxxC0T0u5PNzMO1BgnRA4L6DCxTPjlROc7C6Ml4OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gZBuOsHu; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439c4a93841so1182076f8f.1
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 10:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772650148; x=1773254948; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:references:cc:to:from:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bWep8U4TNVkDclsxjRLewSRSakxtZXQhKrgyA29n9/w=;
        b=gZBuOsHujLMaGKQhphDK1gPLni8qkU24JdpJaoV0w6v//qqK5bjaLmjZHSAUcWCge3
         ikvaq0fFyjwL+4zQG93NHWT9b7SI+TtEUUIBVAo7OqhxnVm5vNUWln8SL5Kn5Tyi4vKG
         XeVt8DwzqHxfp2KZGxtGt1I28uXbnntNshfUt/Dh2vjMBx7TtD2sZjv2rddfCw/UDiyt
         Zye66nHNwKg+RNiqq7CZ9kK0hczjNwocQaLmtdEr/+4fJKeGwA5kOKIilUmT/yrsFoj3
         FHTVGdt8YSeaULH5MaqQm+EFTihVydPncH3GX0HUTA58VAb1riAU+Jyixdr/r3VC2zNw
         JfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772650148; x=1773254948;
        h=in-reply-to:autocrypt:references:cc:to:from:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bWep8U4TNVkDclsxjRLewSRSakxtZXQhKrgyA29n9/w=;
        b=AFe6V8vc7AhTtUr0Ai/WB6O9qSnXUVZnu3qmKnNnM4u1Op1bS09cmJIcqNPIG7x8Ag
         FTa0CvLs3ZfIaL7vBit3yS4RvfoD6QLKv0TObDrUu3L6oOGoyUzcgk1KxN+DzqTwoWmF
         shy99D7zkIqvCFNCfxP1VhuohtZwSxOxotjydw4FkleNkNjzsCJeJjVsyIevwld5ropC
         So4Q9FMmW/M9p39GXXS5Zu/QXykjVnEZ3Tk+2KT+53oPaKA8uzmbXqYiweJqfP5eAXKG
         VOiVBmcy2tgoMJwriBxz4nTg/jyGotHMV/e9tQzJmmk5PrUyT9cEjTaFbpGicS5z8Nd+
         Yd1w==
X-Forwarded-Encrypted: i=1; AJvYcCX+xihQ+r78dQotUMdI7NTm7IkWajIIoreoIdQWAIxF+L9+Id5QCoOdYZ/SLZT5dftU3TrN/hM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNWrtUJV+joi84NCI0bWbbZo3mZh+mtmMqEtqEkAmX05xnx4kO
	ivanf74SUsn0yyts6p6JZbfPa8kdK9ponfymyqhXpbBOh9JTcFztRPw=
X-Gm-Gg: ATEYQzynfD18RJ9JIrgGSKPV7Gn/MI8/og386Ohwstn/QS1THXdhqOl06DZR9hwMsKM
	YOtwmlCxS5L1tr2UkcKloiqE8IsKCZekfFfbCUaqg777jJgfes8+T2jvlUyFtNKCN4JIja2+3LB
	nnbKvuv6kJCiR3PDfM3CBQxVmAv8yNIGSVVvY9+5ev6g0COdME2YiRcKzS3ZZaKR709fj6hRHxO
	UFWzKD+1hYs9uyYOznNZS+qwZypmc+lmu6FEO9hfmq6R08G2zrq9tJLT79zj+y9a7bcAts7NHTO
	DGZkWKlpblyXoOuP+Bh3fjROo9ceq6JKQOuhdpKW90gntwNb81WCwG+B+/BEOv7nyaTqFjgkQSb
	2sBARMiypXfH/CW/kG1Tmbju11APotyHEw/0Mfpwymrixoaa1pjcipigjX2OAzXaQVtenyIYgoC
	1DnCGk0LXdodCMisefxq83luy+aueSsw95zumi/EblpykwuylEK7zWePImFv33DRAsq/CG6KMB8
	Q==
X-Received: by 2002:a5d:5004:0:b0:439:cbf3:4a8f with SMTP id ffacd0b85a97d-439cbf34ac7mr2570782f8f.41.1772650147932;
        Wed, 04 Mar 2026 10:49:07 -0800 (PST)
Received: from [192.168.1.3] (p5b057b4d.dip0.t-ipconnect.de. [91.5.123.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ab6ebe56sm34160830f8f.15.2026.03.04.10.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 10:49:07 -0800 (PST)
Message-ID: <fc9c533e-d0eb-428f-9cfa-3cc014b54dc0@googlemail.com>
Date: Wed, 4 Mar 2026 19:49:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: Linux 6.1.165
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org
Cc: lwn@lwn.net, jslaby@suse.cz, gregkh@linuxfoundation.org,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <20260304131525.84627-1-sashal@kernel.org>
 <c435a3c6-5952-453f-9e50-31e0c6cdd09f@googlemail.com>
 <a4e5330c-5bd5-4262-a6eb-595ff01d1af6@googlemail.com>
Autocrypt: addr=pschneider1968@googlemail.com; keydata=
 xsFNBGlv4cEBEACXGorGuOodK/QtOD6x9ZVt9smetV/67CL5OjH80sdS97bSgsE8GY+EeMA2
 lL0M5xakGQRmbjDVPQqp3PPHMDGd1GUBiQHuC6maYsbYgoCiiCEAomXgT7o/IHrjtWOoKS13
 1u9zTxZAdQZVty4v2PC6akUKh8XrXc7RM+4PVpo/rZw3F/Bo01BVZPtm/3BCYtY9tw2qdZy+
 P/jensN8HjYjHZBtzZQxJhA35hIMaMpCDNccrJLIm/Tc3f6NpNeLrk9rZpnHegbL75caoyM9
 b3hEaqPqWE2zTSPdQbPvbvqFWCjzNRHZC8CBBJ7HQd2QGo4bNgWhXTR7H4oHyJaqHwHtbaiM
 pLbqI3MoLcVo5vBOMCjmqVqz/9bbXgkhdps/XhVhKxfU8SOuGdpZNKtpxaYAcJhrUvp/435j
 aiHg2yYbXlrF+tITLblC1qjWQ02qxxVI++bML8Qp1mMYPEiLivB5kxeMdFQgVYoTRwwqqooz
 tGutPhBy0086uy03Id7adlW6X+iHU4+SKm7Z9ZdEfszT+VcgP2TWzMkGq8od9QIN6X6iuKrZ
 2E3FkDNc0PiSf7DykZfwb5x+b1/WJUhEppEZ5cnKcGi4pzN4+pB64oWU0Bx5dIztzMD6eGxL
 rkve3j2+yvtea7ycqD2mZ5vF7KvBbgQ71f6MDyYnoDttmnbbmQARAQABzS9QZXRlciBTY2hu
 ZWlkZXIgPHBzY2huZWlkZXIxOTY4QGdvb2dsZW1haWwuY29tPsLBtgQTAQIAYBsUgAAAAAAE
 AA5tYW51MiwyLjUrMS4xMSwyLDECGwMFCQlMc28FCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AWIQQmVzsOruteZjTjUd4RoNgDSaactAUCaW/jAgIZAQAKCRARoNgDSaactAXbD/4tSoG4
 6MwbygLwTEbBOJkawnaZE/omJFfg2cgO1yfH+4Y5+lACI4/iqVIrKHcDR+Xhz9Sax6EI398q
 YBRZXQef0BWFDsm1FlhgW3gcOseLSfbWfzwHvZLj04/O85bhHGnO7AcZvLvvPN4d0JMaxZVS
 VVK3JHPIZ26Of/Z8OkK9W9Jug0RwQCoUVOBPzeGWgaCY8/Rd1X9Cg9Kd8H9+5/ElI/ZUegSP
 +/vlr/TLO+7qop18pdDivuSFzuJ0x1GnEMa5vNggvRbTT8LpxNhkISaQslHF8x5HcYjmj7uB
 i23Natg+I2E8NM5bFahks9wF/BUphQcpPmLOkuBYOpQ5ESj+HYTXUcjWcMZGCRrUDMW9I9VS
 ou+afjwWQHNE3+lJI/yQhvyidLSUEabRGkZEsJgfJ8oLbJ8rGvN9vouHVLpXlYjl0H0yCcnt
 Wwyn85lxTwZ9FFFgfEQKY82iI1v18a+eZ85EJy7FqlsmYVYTdQnAxX7NJAl8pjVYEIepl5RR
 /UVnxm45P2tSVuV9iA8o94ijze+jS3F5Eydh5wuWsMMCU/2hEZ72D2sl6/gpGpTXR2N0SJpf
 orYyAOSrkmH8pIza9SNsTiU6MGo1Cl+r36dXacCXPmSL2oO0n0HQK87vn8UHEmSGCOJTPe3h
 NTZpIyuuCpA4XJ6eHu0c8tCakNPAEc7BTQRpb+HBARAAklb51SvHEoWVc7rcwlU3ftChtwLm
 DhwEjBJWoilK3K3Z/Z8gtEkwRLEvDQOUJq+NjqkqCVHKAw0AWp8oF/9+ejkOkHOadVvSc9WH
 +ubyOmoAvrANl2THcP3qxjAkvN9xD7LHwy7Mcpf5OfOTna/zbK7XTbzNU16Cxdy97kM6ymH7
 p96ydLReHe9QQvPgPH8+2wvKu2Yv5D4S7Zh4yGnCImviw8A7IwXvuQ+WlcyhOQxhFZWO/j5P
 h5VhqhUIkh4u4gHo8gM2ekBwRydbuMNbiDTOuBazQ2ap94FZjBz5+BQaxNoAHbHj1GwmhpD4
 rfqmNQwW6rqpPOgMjA9LUf1mJYUAoJNOwgRNXJqmlBK1jhR4zOqRm/zk48XUZTxkNArOPTCv
 t/lfGTrPk7H2Wg/QU4cJrQIKKCdbpfxuKLgLcBjgog+SoQeUSmdZdtE+UZgQh472WD4T8f9S
 IdpOr2y2uU2v/4ppfBoBiQ+H9K0EsM7ssfFTBExaw5k9Tasm97ET2+1s7/uu/mh5kMDMnlvY
 oXt+byOEGpR07U7oueX7IKC+ljXPiaUZ3XW+21nX2nOXeTZXTIKDgoF99Vgmm/aiQdV/U09l
 EXXle3YLhh/ZXLVCJVBnpOygAXJ+gx7DqabXP8ZaDMGyb4fR//LFt6yvqKvqWfG39XW5J//z
 7ZMB/z8AEQEAAcLBmAQYAQIAQhYhBCZXOw6u615mNONR3hGg2ANJppy0BQJpb+HBGxSAAAAA
 AAQADm1hbnUyLDIuNSsxLjExLDIsMQIbDAUJCUxzbwAKCRARoNgDSaactGX3D/9mmZMZdRtf
 vq5PB3BWpEdj4AcQkbMCTp8rgz9fS0JFFmOqsxV4L5WbLPv3OJZyWduTijou0VcRbpNJAP1d
 5QAVYhmthHFQCAX3ybsn/HUozh9xdsvtxDm2uikbXxMZEt/TNSssSaqEBn9LF/t+9+V5ohsQ
 Da/akuLX5s04TwH927UVBh1llXO9Ocq7MxQL6ZjunCdqcoNrWM6ds+dLIc2bs17wMdzME7z6
 WjL0AErVm7elT0WoXJsDQujx0KNV2ZDm3nEs6r6zMobPcwWAcP2meTi8xYczjaInmAax1tlM
 VnwcJR6lpug83/mSABk81d2/ceccCrflrL4lsTdZ8ScYbQQEcXgSnxS2eg89x2ohlo9xPiFK
 SqedepHSYijawOeyRfebGeKx2dWp/6nuneLoGOwZxCux7MPWd5DtnjQVBx6ArhhobExY7cId
 CHcn4UvWqMJN+2nzmilvVNE4PqhtVUK06gm23eSZn8Oope7p9Xi6cht7YdYBFjOEpjqDMuVh
 gMk+ISBejhLtdCKXdcMlnw98B5djDXEnb+LxizmKm1zV40i1e+jrKFmHq0Z6+dEM2AJQTY3S
 Vclc/26CYiQNBm0uKlT3FMIFpwk9FFOS3nLj7lmPr2hyJvnpZF3bIx9dPsp14pE0D6EE44cl
 IX+NNrIwDpXrzCypeM2L5WtGyw==
In-Reply-To: <a4e5330c-5bd5-4262-a6eb-595ff01d1af6@googlemail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1TqpaKuBdYMOvE2i4lKkFawE"
X-Rspamd-Queue-Id: 7972E206A19
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.15 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-223128-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[googlemail.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,googlemail.com:dkim,googlemail.com:mid,mailvelope.com:url]
X-Rspamd-Action: no action

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------1TqpaKuBdYMOvE2i4lKkFawE
Content-Type: multipart/mixed; boundary="------------rSgSPd4KAak9Mg2bbW702SN8";
 protected-headers="v1"
From: Peter Schneider <pschneider1968@googlemail.com>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org
Cc: lwn@lwn.net, jslaby@suse.cz, gregkh@linuxfoundation.org,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Message-ID: <fc9c533e-d0eb-428f-9cfa-3cc014b54dc0@googlemail.com>
Subject: Re: Linux 6.1.165
References: <20260304131525.84627-1-sashal@kernel.org>
 <c435a3c6-5952-453f-9e50-31e0c6cdd09f@googlemail.com>
 <a4e5330c-5bd5-4262-a6eb-595ff01d1af6@googlemail.com>
In-Reply-To: <a4e5330c-5bd5-4262-a6eb-595ff01d1af6@googlemail.com>

--------------rSgSPd4KAak9Mg2bbW702SN8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgU2FzaGEsDQoNCg0KQW0gMDQuMDMuMjAyNiB1bSAxODo1MiBzY2hyaWViIFBldGVyIFNj
aG5laWRlcjoNCg0KWy4uLl0NCg0KPiBBbmQgaXQncyBhbHNvIHN0aWxsIChhZ2Fpbj8pIGlu
IGFsbCB0aGUgb3RoZXIgNi54IHN0YWJsZSBicmFuY2ggcmVsZWFzZXMgb2YgdG9kYXk6DQo+
IA0KPiA2LjYuMTI4wqAgMjJlNDYwYjYzMzNhNQ0KPiA2LjEyLjc1wqAgZjhmNzNiZjBmOGE1
Nw0KPiA2LjE4LjE2wqAgZDRhMTMyZjEyMWM1OQ0KPiA2LjE5LjbCoMKgIDRkN2E4ZjVmMjgx
ODcNCg0KLi4uYW5kIGNvbnNlcXVlbnRseSwgYnV0IG5vdCBzdXJwcmlzaW5nbHksIG5vbmUg
b2YgdGhlc2UgYnVpbGQgb24geDg2IHdpdGggQ09ORklHX1dFUlJPUj1ZLiBBbGwgdGhyb3cg
dGhlIHNhbWUgYnVpbGQgDQplcnJvciBhcyBJIGFscmVhZHkgcmVwb3J0ZWQgaW4gWzFdLg0K
DQpBbHNvLCBJJ20gc29tZXdoYXQgc3VycHJpc2VkIHRoYXQgeW91IGRpZG4ndCBpbmNsdWRl
IHRoZSBoaWdoIGxldmVsIGNoYW5nZWxvZyAod2l0aCBmaWxlcyBtb2RpZmllZCArIGdpdCBz
aG9ydGxvZykgd2l0aCANCnlvdXIgcmVsZWFzZSBhbm5vdW5jZW1lbnRzLCBsaWtlIEdyZWcg
YWx3YXlzIGRvZXMgd2l0aCBoaXMuIFRoYXQncyB2ZXJ5IHVuZm9ydHVuYXRlLCB0byBzYXkg
dGhlIGxlYXN0Lg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvc3RhYmxlL2M0MzVh
M2M2LTU5NTItNDUzZi05ZTUwLTMxZTBjNmNkZDA5ZkBnb29nbGVtYWlsLmNvbS8NCg0KDQpC
ZXN0ZSBHcsO8w59lLA0KUGV0ZXIgU2NobmVpZGVyDQoNCi0tIA0KQ2xpbWIgdGhlIG1vdW50
YWluIG5vdCB0byBwbGFudCB5b3VyIGZsYWcsIGJ1dCB0byBlbWJyYWNlIHRoZSBjaGFsbGVu
Z2UsDQplbmpveSB0aGUgYWlyIGFuZCBiZWhvbGQgdGhlIHZpZXcuIENsaW1iIGl0IHNvIHlv
dSBjYW4gc2VlIHRoZSB3b3JsZCwNCm5vdCBzbyB0aGUgd29ybGQgY2FuIHNlZSB5b3UuICAg
ICAgICAgICAgICAgICAgICAtLSBEYXZpZCBNY0N1bGxvdWdoIEpyLg0KDQpPcGVuUEdQOiAg
MHhBMzgyOEJENzk2Q0NFMTFBOENBREU4ODY2RTNBOTJDOTJDM0ZGMjQ0DQpEb3dubG9hZDog
aHR0cHM6Ly93d3cucGV0ZXJzLW5ldHpwbGF0ei5kZS9kb3dubG9hZC9wc2NobmVpZGVyMTk2
OF9wdWIuYXNjDQpodHRwczovL2tleXMubWFpbHZlbG9wZS5jb20vcGtzL2xvb2t1cD9vcD1n
ZXQmc2VhcmNoPXBzY2huZWlkZXIxOTY4QGdvb2dsZW1haWwuY29tDQpodHRwczovL2tleXMu
bWFpbHZlbG9wZS5jb20vcGtzL2xvb2t1cD9vcD1nZXQmc2VhcmNoPXBzY2huZWlkZXIxOTY4
QGdtYWlsLmNvbQ0KDQoNCg==

--------------rSgSPd4KAak9Mg2bbW702SN8--

--------------1TqpaKuBdYMOvE2i4lKkFawE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEJlc7Dq7rXmY041HeEaDYA0mmnLQFAmmofqIFAwAAAAAACgkQEaDYA0mmnLQk
ZQ/8DoT++utrFs+QmoYj6j0ZM5JP6iqDlUjjHcQH6Dd6CK982k+gEMwhqb3Wzt2d8mq1RSqQ7Sr5
wxQwwymbC50OlYBGuGHQsDnwkwwConb0AanpD+LR1EXQ+JjkNl36fX9Pj59IMAQ/og/bsiH9ryuU
UP6iVN376r5pglRmK5vQU9ar+AJiucxim8HpkwW4zuGyE7YXmPog1ID1piXhzOrQHalClnypjSZy
Kj3x6I2/3mO37MbpxTD6scyXOygI7ePqHac8ooMQZSuOdWBJxNWLsHN2OisYCEbzL8W5+tNLkKMO
4KZxpUQpxs/+uoiOYD04s8kttlcBC8fQZngzZzdRsItrH1E97jlo6RyuNPvdj9ttW5shuwgmv4gD
KbhyL73IeOKgoSri8M0khpli4opdqcImObU9EvjE6qjLiGmHdUV1opBzeMrClZd48d9/AH43gmlF
p03w3wSlDmoyIftWK9dabppxWoZPIxRr20+di+TisoE16dB+8ADQ0ARys/Lotpo94BSujaZOt16H
5NTKzCFvM8V6mMh6ha9ZzF3T+SnG3GxN96rKktjj94tYnwvXFrhHihpV31PxJrBvBb+SLAb52QXJ
WIAHBd2V9+B9fMfaNwywIAP4hNOQzhERKJKbQYx6+wzwEG0UyqwivMyGSg0UVN2n/HvV/Wi4fIPE
9eg=
=9ECs
-----END PGP SIGNATURE-----

--------------1TqpaKuBdYMOvE2i4lKkFawE--

