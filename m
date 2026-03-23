Return-Path: <stable+bounces-229995-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEFzFdSMwWlxTwQAu9opvQ
	(envelope-from <stable+bounces-229995-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:56:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BBE2FBB14
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1403E30CAE78
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1C12DECBF;
	Mon, 23 Mar 2026 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="rtDMhlqV"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542B224A076
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291558; cv=none; b=JYutJ7DpWejeeznzNDr1sXL7waYYcyvzhPaA1dUdh4IJyRxPNZjO6/aND+x4AC0ZG+WkF69rgANP1TDgJLAnhfSQdt8ffvHBpv5ni2lQmaPjCRrPJwR+rQFgv0Nsr4dNbVdb4W5Ne14cRiERqESYcG0iQT6CE8HlkqP8s75dU24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291558; c=relaxed/simple;
	bh=xKWqh2Mq3To1C8FNyFOCYh6IisBe2esHhyb63lXCN4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C67zWpVlmf/OPK4KhXPqbx1/cmBm/pXGJJz2/LAiZL8TIaTMqkCZzotp9sgFj06iiKHhK23J6Odtf0A5kcaLPBjBvlydBin6HHZrtp1PUdtk1UypUke9wit2NBeyixYwwMu/pMU4CVQX8SB5SW7SWuV99pOSGuQPtoVMxeYojYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=rtDMhlqV; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38a42a0d7f7so42372061fa.1
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 11:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1774291555; x=1774896355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p5I9WcMIMbWgGzcbuEa00kzIbh/DzG5Pp6MMimlIG30=;
        b=rtDMhlqVppyrDYiVuLUCnKpjKtxyUL55hUA8L0v9aocfcZY711cfYZ9VPxnovaaXNT
         XdfFWimghihvd2QSEehD/DYtQwH2FIhZYcZDHjkv+Dpn1Yauf7FWAQAU/kzg20VZGLYA
         A+mLBD6v9ILx2E3qB2Mzo/Hh2/aqYcVwp50iSoOfyJI6/OnkL2k+sygCLE7GQLHd2dNg
         ynsS0BRlMG7aU1xILmuWPDl3V2WtvLAmDzvvLA1gtbYYIjMvyyX43vTbUt+dCV4UO1vp
         sTFP/p9IxPAY7TDgNuynVDbMPptDfvvhDpAkOGycpaH0XB/+ziLUE3DCQKPBGpy14vXt
         M6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291555; x=1774896355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5I9WcMIMbWgGzcbuEa00kzIbh/DzG5Pp6MMimlIG30=;
        b=HkFBjNaDYaMND0bad9EIVI4OxxqUm+d13vMqpTjXg1S7t1vWL97DHjmVal+Vrjupn7
         AR5gtd3y5UT3kUEPB9E7kBldprpTbbnsegAzID5M6Iy9PG1JCak9eT9vHVt9Ud2O5sSg
         s3QrlWRcCYpWqs3pYO2B7tTWJmxc/kY11sOJi/rLWfKNThjujPES75NqZIzMfZyB1Ygu
         DL9fzJd3LdndJVBf9Q9mIkhmuErQWWCUFxNIg4ja8Po7ezDXTwvxUN4Ze7xQ4X65A0OO
         3arsVBgyKOvFRW7Xpd2ui/S74w5pwp7fzWMZAV3Kg0UYVcasUp+4skDFdXyA7j1Q0H77
         sbyg==
X-Forwarded-Encrypted: i=1; AJvYcCX5MBuUzRixjWfdeu47oZIVQy3azjJBhcXcp9PRtQJrtJLNMBhLEQP7L+7Y0o9jYvb3/srrGEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwevTAoVcA+aMd8jV7UtvBB6O1GC73fdvxyfiKrIjNyDshYd4lF
	2De3KZ0IsI953Dp9GlQqqtPUgidPdrRufbtPiIm6ToXQ47n/JmfDHUY=
X-Gm-Gg: ATEYQzxozxhJ+Kd5pYErTNXdHpl7jo4rK60KF91/U58hGmVqp0iAR5O6GLLhKIk4C6x
	SuJ0vtA2Pv3xxvZ1aHGeuET6BPyJfO+RqP7rcNlr6crGjKnDTNXjDe9nBcz+PI9yJXV2sjdqz6s
	cQiPiIyY6tfL4JxOa++M4EWOFsTfIdOffNNfW+x58x9PsuXiJMSIES9r9AFHh3YfSuBMumyornB
	o1dbXWttgxMmUPkFDGJU5Ac6ZbZW5eUpuNX4Ey2/Vqvajlg/u82dAbJiUU7hX/cMAF6vSD/+CF5
	bBgvcu5QME8gigEMXQryfoffik1Z9NTHCMxhmj88cuLAtysezZ+O0rw7C6+lhunZS1bj7eX3fDc
	lpc9PD6jbYYSXJ1BIeZ2oOxvXMp8ByBt4e9pZXCKjr415dYL5sfPjay5tiIMXbacT0bGJatr3sI
	CtWPJjP+wq/HrpwsZQqFt7sskNLFb66I+p8Nur0ovHXf+Zcam2W3Eiyo5UeAXytOGCSzfup0Cvp
	g==
X-Received: by 2002:a2e:a30e:0:b0:38b:f1c3:cfb6 with SMTP id 38308e7fff4ca-38c327e9c52mr1248601fa.4.1774291555190;
        Mon, 23 Mar 2026 11:45:55 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b444d.dip0.t-ipconnect.de. [91.43.68.77])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bf9aa200dsm30082831fa.28.2026.03.23.11.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 11:45:54 -0700 (PDT)
Message-ID: <941eaeda-94b3-4726-ba64-3223ea0cc3d2@googlemail.com>
Date: Mon, 23 Mar 2026 19:45:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/212] 6.18.20-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260323134503.770111826@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229995-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid]
X-Rspamd-Queue-Id: C6BBE2FBB14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 23.03.2026 um 14:43 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.20 release.
> There are 212 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

