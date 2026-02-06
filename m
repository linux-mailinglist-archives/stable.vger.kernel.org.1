Return-Path: <stable+bounces-214647-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P7VI+jXhWlZHQQAu9opvQ
	(envelope-from <stable+bounces-214647-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 13:00:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2C1FD6C1
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 13:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0C07301DEDB
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 12:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA032EE5FD;
	Fri,  6 Feb 2026 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="PW2ylB+K"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DA532ED44
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770379237; cv=pass; b=VfzKnMnhWjxoIPXSz4fdNUn5ChCioyL9b5h9nLC6YUd5TIfuxPZmTf4KF0fPxGbpnHOM79tS5767BFRcLtf2WndZy5shYdxC1LmRnYfvpYaA2V3MvH0wduisTjSpOaCus4984vIpOKiiT8t0blPxBgVQ/kdOUUxAgSaHEX/f/FU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770379237; c=relaxed/simple;
	bh=g20uevV4tVvJLv/9bgO5Hh+jgvBQc0njCfo+a67kzcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1pxaVJGtQYgFg7mgX3Q+Z2bId2FxRqKUoF/Lvs/+LxGXlNYwJpsvALZr0fLEgpG8IN0CCBOIM2vmlln0HzAWSqPy78SrLlyDoR34TIfsiVETITGFEZyQq6RyBcl8+LVeYERCtMwe8oFNeCP14gEazIu2H0UYGQQYwHErGOMRpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=PW2ylB+K; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8869cd7bb1so107445866b.1
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 04:00:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770379236; cv=none;
        d=google.com; s=arc-20240605;
        b=SkFduLJaIPG133wWnFgOwTfe/6qKnDOMAEPOT+AF1z0DHVPfMFUpgU8PdhfTqAO3mQ
         D+YqLLZe58BG7Uffkx6klv859bf5aGDqNoDzBVTqN5O/09cV8qL/Kl9njywUapXwV+P0
         vxHb0AY7shfAvR3AXCS334Cg2RLm/Vi2olzkf0y+xnYpL1FW9cqXCAJFpz0rIOXAatrN
         NsU9mLlzI19ni8P6an4eK+hxP0cYh+txv/VCBgaOOXceSJ62BCC+YZKXTTNLaQhfFXZM
         1wbfIEur/DDM8dz7C/o/cJpeWO7pnyHqbFyShzBigfCT1MYnXO+9l2kAwtrVM1RBqVSh
         d7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6I/x/WRhEO+daalBrvU8SHSRaTRx4bAG6z/mD8JVCJ8=;
        fh=bN1N9u37F9sfpeWZ2mDRMBHW5qqsdrFlcOzPW13gTq4=;
        b=Fr4H3QQ4Ps7ZmNKaP0ezT2l5u0+TGcjlIYolVNkOmq8YYkzpSyH2WhPSjbtc9KqOWr
         tBBl252+mI/D74o1LKB8G3j1EcJx5o8za29AVHv5YkY8AvhmUOynFJv6D3pVeowRf8VW
         nWk2mUrcD/zviRkAg+sAyHy+/xoeBSBr4ynS6NtKYnytni+UhNVnqKYa2jYQQDf6g7vf
         afIFXkrWhl/eIcx3dK277JdAmUSC2+Z/hS4I5MimzfXh3641C8kblxTceJmt4eIFdTJ0
         FpkjAw5HLVmD4+UOgN1KQ/GiPmIToN6FwjlWer0iAyqLtO5OUVMlqLBqiwB/tP3m6dak
         dv8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1770379236; x=1770984036; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6I/x/WRhEO+daalBrvU8SHSRaTRx4bAG6z/mD8JVCJ8=;
        b=PW2ylB+K483sgI6EECDPhPXiNxXLi6K0a+55Or3F8znRgtBsFXrYavTzLOi3O9ojwr
         u2Du7AB7qZ284ph0AGJp/LkfC+i/2UHf93tKYVKyX6ZWYiSZ4WbhF7WpiL7E3NCkc4Vn
         gJHAVkQTHmUvUrGOBg2wyCE5Rh8oYpE8EbJY3KKrfgnZpjVlT838jl7kQmDxLX04OEvP
         b7FcS03erhHmuqsLnw9z0i43nI/RmYTlTqKqft6Zeb/wLZiKfTlfx/LSj6AkqSmXj+Dq
         RJazPdMV7mnmVPgCnQZW/WBpTjTZcgj34eilpB4L3HzJ7EN3zX/Jb/ySPYhLTfbboVfi
         5yjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770379236; x=1770984036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6I/x/WRhEO+daalBrvU8SHSRaTRx4bAG6z/mD8JVCJ8=;
        b=OFCGCRZQtfK/z45v/3xtKW3Gx10A5iTcAF/SThWn3dCXAidlqsyzgs24d0vk5TEOWx
         SyRyDOi1xEyJLE9bsWzgtiDblFqlYpraqisDRNMd+9Gq2Yn3giCIS2KMs2PpqODj0IEd
         XXswWxM0WFC47OSVFSgM1yWAzkNO/PgNG/etsIwCvJk+wQewyuHA1qQU5JOenR5mHq9k
         Iap0fx138fr/Q9wiP9zquoZmswmRj8vVhORNlWcG4a1dw9PCeL1jfzBWD93WDrKymJp4
         wCnpHIIBUoh6awnRHdBm92wB/kCDIrs/o5E9deHrBlvt9sXEjVhc7WWRJeccR+99N3cU
         rqhg==
X-Gm-Message-State: AOJu0Yw6ufSpNK9PeUj5nfI+W8iHRzn0KD58ZC4QiWsUjfOzDsBPSbsW
	iC0Aqpt+1nFUU7euPAMpu/Bhl0cyO77knT5OApltdg0fptbxtD6xpqghAEuhu2XTFW4wBUbVtpk
	q4onoxflvplWAKTn8Hgea/EPRJqGAzHDDllO5VN/Uo3cdqR6jE0i/x8N1dQ==
X-Gm-Gg: AZuq6aJNVoaZHYgfXkb7kIr1SMVTSa7PZr6NCIIgJu4HV2/es5TYkMqpNFHzcSG+JhS
	cptoqiVXNLdQxLCZ9jp4Kip+hQtkn+J/VS9GYEJQjFw9n3JbaonCnTXomtnLvQO0snmr3WCP4A5
	QO7r29xpRfy7Q5uzr9OHM1SXVe5dvjnDgKCAZ6hfJWaFCl9iqUsu3FHyUYz0B2BwHpfpM7ffLRK
	6UNeSdgRwl4ptSG3uKq7c7slVFwvqvCXHstoXgmHrgTmmFhWhtBb/BlFXKsPEzQyYGFI8/9
X-Received: by 2002:a17:907:7f8a:b0:b86:fca7:3dc2 with SMTP id
 a640c23a62f3a-b8edf15ce6cmr149172366b.10.1770379234954; Fri, 06 Feb 2026
 04:00:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204143851.857060534@linuxfoundation.org>
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Fri, 6 Feb 2026 17:29:58 +0530
X-Gm-Features: AZwV_QjOvgjK9NEvluJj9yu0cCeB3pX9VAK9jLAhSJ1LBGv7_CJIl-nLLopraP0
Message-ID: <CAG=yYwnSJCp6W6+0MGG_aaj+Ao7Qhiza0FKvrP-4wf6f9x1SQQ@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/122] 6.18.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[rajagiritech-edu-in.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214647-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,rajagiritech-edu-in.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: EC2C1FD6C1
X-Rspamd-Action: no action

 Build error related
screenshot  below.

--------------------<screenshot>-----------------------

$make -j 4
  DESCEND objtool
  DESCEND bpf/resolve_btfids
  INSTALL libsubcmd_headers
  INSTALL libbpf_headers
  INSTALL libsubcmd_headers
make[5]: *** No rule to make target 'str_error.h', needed by
'/home/jeffrin/kernel/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf.o'.
Stop.
make[4]: *** [Makefile:152:
/home/jeffrin/kernel/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf-in.o]
Error 2
make[3]: *** [Makefile:61:
/home/jeffrin/kernel/linux-stable-rc/tools/bpf/resolve_btfids//libbpf/libbpf.a]
Error 2
make[2]: *** [Makefile:76: bpf/resolve_btfids] Error 2
make[1]: *** [/home/jeffrin/kernel/linux-stable-rc/Makefile:1449:
tools/bpf/resolve_btfids] Error 2
make[1]: *** Waiting for unfinished jobs....
  CALL    scripts/checksyscalls.sh
make: *** [Makefile:248: __sub-make] Error 2
-----------------------<screenshot>---------------------------

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

