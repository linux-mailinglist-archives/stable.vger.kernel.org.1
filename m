Return-Path: <stable+bounces-204377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DBDCEC5DF
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 18:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8AC2300943D
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 17:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044CF29E10C;
	Wed, 31 Dec 2025 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5Ff6LuB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C40881732
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201697; cv=none; b=rurCkF4Egns7mSyx4L/EcU8lAxEH1n+q86zlSvcTMq6UISOKtV9FWltiPFXvsvQUsYAUu4RQ5QuxcGHAVgYGsb0WQnSPaMM6H9Qx8KsoU/Y0rcSnh+hcFpALdgxjNyUlh81FfBfkkV7gsPUfDnhNVMsOxbyBtm8SqwFD/AIRjKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201697; c=relaxed/simple;
	bh=CHd/2Oq6hEO6irVRaZQfXxgMM4a3n05oL7zK0AKwZFk=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=BMQfogjExBuS+it6VwMr+MaUx8hmf/XMBdI0tWt3U8shnhHYrsnuHyFlRpCEKB5fdpxHNFJnn0cff4ijJq9ywTq4dn7A5XwVHYSippX/bQP9OLRAwVWVoNfIT8Yq0KaSWdeYmZsDljLOQtrCehbuNRi9dOt+rZ/3k6q8fQK6Or0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5Ff6LuB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so80084935e9.0
        for <stable@vger.kernel.org>; Wed, 31 Dec 2025 09:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767201694; x=1767806494; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyHdo346TqBdenARQV+NRH4HKNDFO3oWZtIBX9jgQ78=;
        b=b5Ff6LuBYOJtUHfy/MK/BLvGIsSLCoKRf8IqukJaozdhEvW2sxKruneCyPSRjr86yP
         4TZVc9reJjdVDDDiFehJcluRDpACGLclbBmu4h8T1BXRGFq8OjF4pLuvKF1BZTSlB387
         fXTvpH+nD356pvhHD+pkrT2o+VOouPCrMz23s7t24fi1qwTVEKd09/CCPKj/Rw9YWKgL
         HBNft/k2ueb2BLdNsvfY2go/j3jjp/npWZ5EbYpkl44/wm2FnxKTuQSBx6ma2iavbsab
         9AjqSPyttrdMc1VpYdT/50XORtZptwPVtar1fApPd4GspAR5ZXzBD9EdOjTft+4qKfkZ
         zXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767201694; x=1767806494;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fyHdo346TqBdenARQV+NRH4HKNDFO3oWZtIBX9jgQ78=;
        b=KCzAVMkdtk9bFIA/yT2W0y3YJtEla4RkgvbxaEuSSjQHsenXJhkBpmvslZn+TxhbtY
         knU/lEctRUWwXRj/TKleLXoRmInUbrYPCmeH1NX/HBvydd1QOoDXHRfdxDUUlocQXbv7
         nmpMoGCxr1b0P09cjLz+kQae9k4WsDDAu0vW3Ilg8PLcCk+ZmuQV+D7W/ORkLjpU+rq6
         O6OrZTr1lKrVRuSByE33x9zBJhwZElyBVBN/LnE7o/Wwxr5BYszVCcff4bH3vC4g2VgM
         GuZHDCvIRcZJbOOP3UrTBhN4+uJXx1N7UpsMQJm05+r/4hdgDXyQjTi2b79ecyTprmSb
         SOwg==
X-Gm-Message-State: AOJu0YzZ02ph7rmmmoLUFcKZDDRMiNIZPQyWCvOGGanq4OrgshWFeBAe
	CtXUTomxM8fVAuSbzrbDF9L2iwv6Gw/lO1PF5kQ10JVcVyIhCGpoTCLhnAF4RteQ
X-Gm-Gg: AY/fxX4MgRs+oLmOBiuiz2fCVxdkxngCH4OUFtPWNbMr7IjpH17CzkkbLVzlj085KZT
	pjE2EhA6UAQN+P4lytivO0gDD6N5hmkuti/69AA0FfihZ/qisZ6lfpELNHOXu7V1GPZUqHYZcsD
	xaMqLYzi62FTSNdyvL6eYfzoU0clr06SkvWX5Y9MnK3rVgdIdRyQvhSP/1Kb+QjlnmBnowf6SeA
	emFLZzMWO0kVaqXHvYxKavh96FSGzKduO90nX30hvYip76h4DyQS4mnyXNEz3ZnLQqN8TUp3gRK
	loDd42St2TdLh88Wj2IqvQhyLLPZRaN6xSWITSzo0E/3gbBPfoh49d4qiggNNpx8df3LAUA3CA5
	nbDHuZ3/U44Ik0pEUt1vDQaFVpSOo53fo8RzDyH6jXD698N2mM6HPgBIz0yQM/6FYYYuhrbJrmV
	sjC5aCqfVjqskymq8v/lIP5lmRxp4ffJIyYpR/fnJo2ncTMF+XfXDFUz2MKihASjqPU5wiBg==
X-Google-Smtp-Source: AGHT+IE3H1wu56x9YvWsQufYFISgqmz5b4pzFBkDKyiBPBqLKr56tuM5Ta7GI2FoVikJ3DWWs4z4Sw==
X-Received: by 2002:a05:600c:4fd4:b0:477:7bca:8b34 with SMTP id 5b1f17b1804b1-47d1955b744mr416116085e9.6.1767201694234;
        Wed, 31 Dec 2025 09:21:34 -0800 (PST)
Received: from [192.168.10.194] (net-188-216-175-96.cust.vodafonedsl.it. [188.216.175.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be273f147sm723672675e9.7.2025.12.31.09.21.32
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 09:21:33 -0800 (PST)
Message-ID: <547b67dc-0b01-41f7-92a8-ab4371195f40@gmail.com>
Date: Wed, 31 Dec 2025 18:21:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sergio Callegari <sergio.callegari@gmail.com>
Content-Language: en-US, it-IT
To: stable@vger.kernel.org
Subject: Sd card race on resume with filesystem errors (possible data loss?)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi and happy new year!

I would like to report a problem that I am encountering with the sdcard 
storage.

I have a laptop/convertible where /home is on an sd-card (because the 
internal disk is too small). The card is luks encrypted and has a btrfs 
filesystem on it.

When the laptop sleeps and then resumes, there is a race. The sdcard 
gets accessed for read/write but is not yet ready, so there are I/O 
errors. BTRFS is not happy with them and tends to remount RO.

This issue is well known to purism developers (e.g. see 
https://source.puri.sm/Librem5/linux/-/issues/484 and 
https://forums.puri.sm/t/sdcard-becomes-read-only-after-waking-up-from-suspend/20767/2).

My kernel logs are identical to those in 
https://source.puri.sm/Librem5/linux/-/issues/484 (first comment), apart 
from the fact that I get the errors from BTRFS, while the reporter there 
gets the errors from EXT4. This indicates that the race is not specific 
to BTRFS.

The errors in the kernel logs come right after the PM: suspend exit message.

 From what I understand:

1. The error is more frequent with the SD-LUKS-FILESYSTEM 
stratification, but not specific to it

2. A phone/tablet set up such as those that purism developers address 
will generally use sdcard for storage and require suspend, being a good 
trigger for the problem. However, the problem is in no means specific to 
phones, ARM devices, etc. I am getting it on an X86-64 laptop.

3. It is unclear to me if there is a real risk of data loss. Possibly 
with BTRFS that has a more complex data management this can be the case.

4.Even without data loss, the issue requires a reboot to get the 
filesystem back to RW, so it is annoying.

5. Purism developers have a kernel patch for it at 
https://source.puri.sm/Librem5/linux/-/merge_requests/788, but I believe 
it is not in linux mainline or stable. Would it make sense to consider 
that patch?

6. For stable kernels, there is a mitigation consisting in a systemd 
sleep-resume hook as in

  #!/bin/sh
/usr/bin/systemd-cat -p5 /usr/bin/echo ${1} ${2}

case "${1}" in
         post)
                 sleep 1.5
                 systemd-cat -p4 /usr/bin/echo "hack, wait for sdcard"
         ;;
esac

see https://source.puri.sm/Librem5/linux/-/issues/484#note_277648

This appears to reduce the occurrence of the problem, but not to 
eliminate it completely.

Thanks for the attention

Sergio


