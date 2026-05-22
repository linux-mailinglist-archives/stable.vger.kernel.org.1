Return-Path: <stable+bounces-253734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNCjFKYnEGpQUQYAu9opvQ
	(envelope-from <stable+bounces-253734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:53:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E62BF5B17E8
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5DB4300E3B9
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D9F3BB665;
	Fri, 22 May 2026 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gdoD6v4G"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB483AB28C
	for <stable@vger.kernel.org>; Fri, 22 May 2026 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779443614; cv=none; b=MPa21lY7i/C0Jw/FYoCVq9DlO1PGxmGmlJBQYrPqsH8gtAH99rhuAPVYCYjABS22fzo5eZm7Qby1bTc93na7Ke6tC5RqPMcqKGQoJIzdp1odxhKdB6+MoE98ryOiIsrC+CwZAIkpzmGB55GzxaqUSPEqIKOB70YZvASrkIcosGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779443614; c=relaxed/simple;
	bh=42l72Eg+avfK4sTP+9vFVvJeXF63mLvoFbk/grDTiwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=noaKUjwEH0gI8qEVWFvhNNpBC9vvlAg7/gBe9RynL1WT1rs6Zax9LyBJOM1VOAI2utwuIemahVTK9qUMGR4iSBFSqcdWXx++EzK54ghT/JNFZ5XJC87NmcyBBDFIk3xGvIdpCi7uL66+xybKZZ++zvhgBm6zOeY/6AzAmQuMLUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gdoD6v4G; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a8dc2606a0so7756936e87.2
        for <stable@vger.kernel.org>; Fri, 22 May 2026 02:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779443611; x=1780048411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C8V4lykeLs2+AjJKIfeMSaVVh+X6pS5Qv/pXMKfcsgw=;
        b=gdoD6v4GG14wN/yGLcuPTzCpB+Tk3T79ygC7PX9x3x0hpRAkAqR59EtcFVV+e2BBGa
         2Q7ex97IRvOX6KO3Qdsskciv9brzGNu1SJOyXfyQtbY5R/SAcG1aXF4+r2jNRmEqzlXK
         EHUo34x+s5hm0jIF+G2Vz6sH9Qj77UkOfiwJ4AqnFOk/wyLXMn8nrgnRCOkIRBegcZGe
         SwOovYLd9odQDfDWLceyhFHac67uFD9pERGnoOj3irxjo0oF3h31E6+kZvybEIdOajqb
         YS9IvpCjwJj+dLtKFJmPXn9MsvFHtz6aEBVymeiKPS37Mn6Tpw2R4OwoFAhHxPs7WJRX
         zy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779443611; x=1780048411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8V4lykeLs2+AjJKIfeMSaVVh+X6pS5Qv/pXMKfcsgw=;
        b=RcqQTal4IKkLw5DOYMEYHbEB771y/mTGGMWhwagvqipJ4HaEtNF7qjGqSc+pd3Q1Wz
         b4VXOi5vz050j5b2yxSucIZEVGymPyVhy79oJWSYjvK2IC4wIMUKG+Nr20zuWY/+xbfc
         3xR80slJ9gyB/20s27Y4ov2rBlA5CRZsdLRw7+9H9DsAwRFyMZVBlZ/G5YC94tA8Mvfi
         Py218k/PD72j8OeJsnekAD3hEauQggJuy+LQTIf4NlExR+eXVkU5YeHOxUxIsxEYnL/8
         J8fo9AG8P24jl+4HEaHrCLkIwNzmRn7521VdpB6u2PnUExosn23GllodJT1OCUdE6GbS
         ODmA==
X-Forwarded-Encrypted: i=1; AFNElJ8x56kTMoU0WTQol+2ConGRnNXejdJfzjw5e/QX/S9S8YNrjsyL/VenHJX3azEiHCPwfqSRQ0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW4vJj5heBf9cOpIZP/MvlDmOZs+GKp7dxTlWQ9M4LLEyeMTB9
	7KxBLwZ8idkmveYG959BQaCYr7y1MzILur53dlNE5JDSTyzVNUAvor4khX6ZR0MXBJCPVHoih95
	isWu9fuk=
X-Gm-Gg: Acq92OFoOJ1SvV6GvxFmLNyroxGOUOAa+YCb5O/m75NvUvTrvfpVNyAvZbSgASkHcZ2
	W/8W22yllexmKR3VFwcXPJwasyDKxW5ZOYWOSq21DjIRI8WxRBg+qd+NnDq7O8l/dw+01S7gSMS
	8/xcBRZKs7lcnkSSZYmCXEn1BLC67V52uH3ipKaFHWldKM9O0QHosuwOtpgGpl7udMtIJ+E4v3A
	bTEsYSoozYBnK/2ZpXHgFRzpABVyaOz64m2LDuCYpySjcmGyPsk5tk4Rik5LV4SexmTbqVWvb9j
	L0NpT0RyMR/c/nZvQgvF40MdLJT1DHiDAZG16oMoezv7XiSiuQ+I/qUubmoaGlkc+YtwdVI4oeh
	Zi6Lo251RweDo/zdk74rQh9EFHft5oXDkH2ek+hZXrCvMpFO4fUcWzASr79OgZ5bB01PlxzoADa
	nqH0NRjv5N8uXNt4/o0H86eyZALzp5VC4C8e8r/SLrCrZ/QNigXxb5dRVtTom9XQftxbXFV/c49
	Fyg/w==
X-Received: by 2002:a05:6512:1444:10b0:5a8:7426:d2da with SMTP id 2adb3069b0e04-5aa3232c532mr597549e87.7.1779443611319;
        Fri, 22 May 2026 02:53:31 -0700 (PDT)
Received: from [100.64.15.206] (h-158-174-93-34.NA.cust.bahnhof.se. [158.174.93.34])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cea754sm300619e87.53.2026.05.22.02.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 02:53:30 -0700 (PDT)
Message-ID: <b5bdfe69-8e88-41d7-99c9-a57b2c765e1d@suse.com>
Date: Fri, 22 May 2026 11:53:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: target: iscsi: validate CHAP_R length before
 base64 decode
To: Alexandru Hossu <hossu.alexandru@gmail.com>, d.bogdanov@yadro.com
Cc: mlombard@arkamax.eu, martin.petersen@oracle.com, bvanassche@acm.org,
 ddiss@suse.de, target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
 stable@vger.kernel.org
References: <20260518121811.385350-1-hossu.alexandru@gmail.com>
 <20260518235040.48647-1-hossu.alexandru@gmail.com>
 <DINMKOIB4PRJ.1Y571RHF6NAQJ@arkamax.eu> <20260520180204.GA15940@yadro.com>
 <6a0e553a.010ccaa2.2ab173.fc09@mx.google.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <6a0e553a.010ccaa2.2ab173.fc09@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,yadro.com];
	TAGGED_FROM(0.00)[bounces-253734-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.com:dkim,yadro.com:email]
X-Rspamd-Queue-Id: E62BF5B17E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/21/26 02:43, Alexandru Hossu wrote:
> On Wed, May 20, 2026, Dmitry Bogdanov <d.bogdanov@yadro.com> wrote:
>> Yes, the length of Base64 decoded string is not deterministic.
>> Moreover, length of Base64 encoded string must be divisible by 4. Which
>> is biger that 4/3 of decoded.
>>
>> | MD5_SIGNATURE_SIZE      | 16   | 21,33333 | 22       | 24                   |
>> | SHA256_SIGNATURE_SIZE   | 32   | 42,66667 | 43       | 44                   |
>>
>> So, that formula is not correct and will break all iscsi authentication.
> 
> v3 (sent about an hour before your email) already handles this. Trailing
> '=' are stripped before the comparison, so the check is applied only to
> the data characters:
> 
> 	while (r_len > 0 && chap_r[r_len - 1] == '=')
> 		r_len--;
> 	if (r_len > DIV_ROUND_UP(chap->digest_size * 4, 3)) {
> 
> Using your table as input:
> 
>    MD5 padded:     "data==" -> r_len = 24-2 = 22, 22 <= 22 ✓
>    SHA-256 padded: "data="  -> r_len = 44-1 = 43, 43 <= 43 ✓
> 
>> Alexandru, may be better just to change size of client_diggest variable
>> to match it with chap_r like for initiatorchg and initiatorchg_binhex?
> 
> That also prevents the overflow. The length check is preferred for
> consistency with the HEX branch, which validates input length before
> calling the decoder rather than relying on a larger destination buffer.
> 
I would prefer to use the size of the original string as a buffer;
that will ensure that the buffer is always large enough and avoids
a lot of rather pointless calculation. There really is no point
in trying to be precise on the number of bytes to allocate; at
most we'll be saving 3 bytes which really is not worth the effort.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

