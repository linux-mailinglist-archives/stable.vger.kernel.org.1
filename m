Return-Path: <stable+bounces-223037-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE7JBgoZqGkVoAAAu9opvQ
	(envelope-from <stable+bounces-223037-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 12:35:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D153B1FF13F
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 12:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 397983011CBA
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 11:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E403537FB;
	Wed,  4 Mar 2026 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UoHxZ2w3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F06834C816
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624136; cv=none; b=S/0WBDHA/MYJ2yBoHwbZOLHy8I474KeP+6AOGOZkWgBwz48F0UmUoL86tmWsn6Hy/KaP/7QRBc78WmZUuFLGNZPbtmuPvkWlM5Hbo+kzLzNXPuHjxmqXEpUFGPbUSwPoAkc9iveZDMVQiIIkONxvPPgXOimooVunTEMEJPPahME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624136; c=relaxed/simple;
	bh=3Qfsaofs7qqYQe3UFNTQkb0pwZYV4mgYyLE+uuumv4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHj3lX4LaTO8oD8zABynxzkbuYFe8UWBqipvk+q7rusrXytEWt7HTwEL2l7YJQ84qerjuCDswfv90vuWyg6V8teyUerVq/9XJF6L5JypaQ3oOff0Fi442f9dCdhnvLaRSbGwv1kMEfcKgEC4WeFc4STy3v1Ku3zaECo4JpGALtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UoHxZ2w3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso60953385e9.2
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 03:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772624133; x=1773228933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kl7BBMfrARykldlepwzhA/sEf5yhg4tZnneBw1orNUo=;
        b=UoHxZ2w3CgmBboZbJNXf45h7T4m0ykqrNwhlGi8EDuei1NfxA/HBHb9Pc5dlsb/n9w
         UzoUXjDMvYtyPnz9s0tPO/MzdbuJxahdpnPHW/eb2kkLiLQFNt1h+PnYDA9mJMTIBu/E
         6GvKGUeTiel68zXhE46abjXB8/jNQLbdprYAUT1zRYcO1wLuv3K0AITv0uhiK7/sOzy6
         iTVMMUZ3vntJCHPwt8GDq1KUgFfCYKaQ7gtR5WE59/pLv/r2G9RcT12ZrbL9/1bCVXYW
         xNxDSixVPNO74LI3DTUrZ/iEWd1mKoefAk71+9LB41CLHwhp7dGof8eymrVko1RGYdXF
         MumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772624133; x=1773228933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kl7BBMfrARykldlepwzhA/sEf5yhg4tZnneBw1orNUo=;
        b=aNRlpZXIaPqbUkpJ00+ZFIu6wipK2qieiHq/0+pKqQhzQG8ZLeC9ATn8Wsfmgmaq61
         0xVHA35w843Fh+7aghWCiYPxbnZLPcd6LARIls30S9aCb7UqJzR1efjH+noT0w4le8Ds
         KBcGlXqmoHgdRAXiR7adl4tljDKX0uwp5y5jNktmLAp4ROkbVX67nLItdm3H2Z9GTqIz
         nZkx0K3RoUpLss4Mqiyn7yFhHgMKXsS2pc0tnZV3VuHUjTcbL0jlpgurSzaH18EbzRGp
         Gm+Lg1QYTvxO55JjY5TL4BjPIteUZttoFJpYbFTkucMZ8UGdQm+HWvquDcly4qA8fKkG
         TkhA==
X-Gm-Message-State: AOJu0Yy4i+wCFcxqmCW8FlUQwcUiOHgSlhB5SXeyZRHVTlL8gwq+sEx+
	CXTr/7rHzL/CXYQhl+CZRTkS8R/XqU4SRHskouKjp7Dm0lR3xqWH1ZiIQI61nPSsw8E=
X-Gm-Gg: ATEYQzy/e80NPzKnDSAlfMKMULb8aHzUJutbJM1qz2Q88yx6o2PWGHU9k71mmZXf2Nl
	lP2zlSDPk8Pq7ENKPm28R+5Bp/23wgpu1poLvON52f4yKRFFzfNblJ7QqVxPrGYk9LHmTru7yDg
	rWp9r17QHlmXDp9clw7ur0uHFZ9P7BBg9a6X8/kRwZrCm5U3SbXpGKDV0m0u/T2b0omRrzCYz78
	gp0b/ct6H4/K7scDIseXgtGZSKq2CDmYGI1eCImff5UFRRmMetA2oUVJEKqZDMGc3M4/5EO6ImB
	gTqlMeN1wJT6lIwaOlf17uPvvQMgcjDauw78GAPMCiaLyX46IMliPvBuSCUoWRZ2dlhKzLcOSvM
	gSRPMmCMMfRAhIBVaA+Zh2BS9u2m/BCqE3Gz8iPIxSRGrWbciNw4Rx0vhMeDfc9ipkbYdzeG6cJ
	4r/x70mH9MXxdQHWVw2BVWV0cJkbubo7CwA8ibxwKGjq54gAF8rwd+CKmupTY4XXBIqys=
X-Received: by 2002:a05:600c:34d6:b0:480:3bba:1cac with SMTP id 5b1f17b1804b1-4851983b2a9mr27517765e9.6.1772624132941;
        Wed, 04 Mar 2026 03:35:32 -0800 (PST)
Received: from ?IPV6:2001:a61:1359:b601:1f40:1a00:9770:8494? ([2001:a61:1359:b601:1f40:1a00:9770:8494])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485188422dbsm47619415e9.5.2026.03.04.03.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 03:35:32 -0800 (PST)
Message-ID: <a10606c5-916c-4ec7-83ae-da8188d0d88b@suse.com>
Date: Wed, 4 Mar 2026 12:35:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: hid-pl: handle probe errors
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
References: <20260303140548.1313133-1-oneukum@suse.com>
 <2026030450-tannery-babied-214a@gregkh>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <2026030450-tannery-babied-214a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D153B1FF13F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223037-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Action: no action



On 04.03.26 10:08, Greg KH wrote:
> On Tue, Mar 03, 2026 at 03:05:31PM +0100, Oliver Neukum wrote:
>> Commit 3756a272d2cf356d2203da8474d173257f5f8521 upstream.
>>
>> Errors in init must be reported back or we'll
>> follow a NULL pointer the first time FF is used.
>>
>> Fixes: 20eb127906709 ("hid: force feedback driver for PantherLord USB/PS2 2in1 Adapter")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Oliver Neukum <oneukum@suse.com>
>> ---
>>   drivers/hid/hid-pl.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> What kernel tree(s) is this for?

6.12

	Sorry
		Oliver


