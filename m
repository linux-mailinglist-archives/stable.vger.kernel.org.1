Return-Path: <stable+bounces-188351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50451BF6F24
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 16:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 02D92355253
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 14:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD2133DEF5;
	Tue, 21 Oct 2025 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=surgut.co.uk header.i=@surgut.co.uk header.b="IYmZg1qc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701AC339702
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055272; cv=none; b=gSlxeEySFYySqFojCGNqJFhF/s5VMn/Iuf40jXc8fhR1fdCv61IgpBZSqPqXXeBjaMyk7TDJuLjfb+Uh7g5ekL0pWur7+zof2701h/z6IVa/37yxrY4FGOdzod5G4vsKPMpA/RKZsQ0VdFIfIr63tLqczyuz9jwWWFZ5Fa1IH8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055272; c=relaxed/simple;
	bh=FXZryhOBUuaH1agho0lX1ijHBCPEotwN/matuAtY8Kk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ICsYBk0iqLxm95UXi6py1ZOAOpP3+pg+847JtJaQjo6v/37YD9D4nUIC4ndg0zZNHoE692ExSf0nUN93sGtQqR6wAVY4i53Ozc1xQfI26g+7frHB+aBVHoE/Ps2vj0NHmMxc8vilIOOL3Hf9plxMv7XmYVv75yyRnKSrUHtR7j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surgut.co.uk; spf=pass smtp.mailfrom=surgut.co.uk; dkim=pass (1024-bit key) header.d=surgut.co.uk header.i=@surgut.co.uk header.b=IYmZg1qc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surgut.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surgut.co.uk
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b6bbfc57b75so334713166b.0
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 07:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=surgut.co.uk; s=google; t=1761055268; x=1761660068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3MlGVICVnwf2AbhcJWjlMkUKPriiyuKSWycGMTjAGCk=;
        b=IYmZg1qc31AjMTZJT7sYafOdY/6eROP8Wk0Zs+q7PhTNM9vJigqgp8TjftC0e1bCnX
         rdcF8rsJoBAoOtWX4a7NK+OBy+I4n5TQIkE3Q7gdb7Ld+XLGrblgqY7yjr/3jgEKNheO
         zjS6IRAmGYL88TynL++ImnIUiaTe+e6GqDXFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761055268; x=1761660068;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3MlGVICVnwf2AbhcJWjlMkUKPriiyuKSWycGMTjAGCk=;
        b=sVX65EyCJ7hs3l8GNigbl/OiAP2PEHoZ+YK7NnWdC8G5jR1lR70KXvvC28JcThUJx7
         rwvix0b8YvwdT9MX06hzY/oBIKLtRMJj7RDf+sr/OBStT8EWbFKq7zr+O1t/aWDfBEDa
         7cBAetZpTPc0AdW89wJc+NvbMJBedXDhwRTB6IcLPvnVvCNcxS/0txl1u7D/91sg8PVm
         2VYVnxxAoOW4cLiP8hcSx3jJs0KuvYZW1TBz61iD51pTjY7kCNWIU3PZ+Ih2aZqrMHSA
         eFQJRjWnrpWEQRQ2at0u8JNxvw4MSdmRU4uQ/BADP4N9h3qmZCe9BMPKES/sCd+IYgqj
         iQKw==
X-Gm-Message-State: AOJu0YzJQydduMnTgd2gVwXenbVtDIvynXObMrT+Sl5ujjr48XNtkSqu
	ScJwNe05Ps7vGfiqV1yF+SQGnFIEvns6srepqfLgEMlePTrxVpNBh0TQcy9zRAr3EjJ1HzBVkEo
	pG3va6GAATaf5BvndPTw7cmP+3vhOB6MhoQkVPd/5jzT3i7SectekxUhpxzqU
X-Gm-Gg: ASbGncsRBJuWW6819gVyliFgaJ4xh7ecfqWGHLbsxxLyWZs+R9Up7LBpyW48WEJMM4M
	Qnju+SjeqjubeR0IkLXCsdkFZtmu2c9GqVTauMyMudOYXX2UTFrd4wKrro7dh3aZDbnjGGkMYrV
	xlqf0DPF5I+Iqp88Ge3D+qu+MjK4+2F3CIvRMVwG71rEbbB5ZJRt/wBh6nCkw8Zt/lnXPGK7Qgx
	/Z9BI78W0emYbGvcMQMbBuMNHt4OR7yndFmIkdDWjEtqLyvTA7KCbgYdOSv1K8bXXw2tU1OzqVA
	NNDxkJAlcMtMWBX7eOEZqv2cdv6ZmE9+gifVoqA=
X-Google-Smtp-Source: AGHT+IEhP7kVq9PE132is9j8ouoWPlUTOCUfix/DfQvvmp+psPK5aOtwUG+tYX99bgBwAgKA98hVuFKznDNuCl9gxCM=
X-Received: by 2002:a17:906:e52:b0:b40:bdc3:ca04 with SMTP id
 a640c23a62f3a-b6d2b8811abmr4888166b.0.1761055267731; Tue, 21 Oct 2025
 07:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>
Date: Tue, 21 Oct 2025 15:00:56 +0100
X-Gm-Features: AS18NWAtEPVdNCWM7Q2aPN08-btIALJJ-APjrT481FTu1EUbYgDb0SaJ1vbV5_E
Message-ID: <CANBHLUjPbXYghPx5zDwLDcGKXb7v7+1u-bpZ=L9r=qW7vDZ=cg@mail.gmail.com>
Subject: [REGRESSION] Secureboot violation for linux enrolled by-hash into db
 v6.17.4 and v6.18-rc1
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>, masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"

If one enrolls linux kernel by-hash into db (for example using
virt-fw-vars), the secureboot fails with security violation as EDK2
computation of authenticode for the linux binary doesn't match the
enrolled hash.

This is reproducible in AWS VMs, as well as locally with EDK2 builds
with secureboot.

Not affected v6.17
Not affected v6.17.3
Affected v6.17.4
Affected v6.18-rc1
Affected v6.18-rc2

Suspected patches are:

$ git log --oneline  v6.17.3..v6.17.4 -- scripts/
8e5e13c8df9e6 kbuild: Add '.rel.*' strip pattern for vmlinux
7b80f81ae3190 kbuild: Restore pattern to avoid stripping .rela.dyn from vmlinux
5b5cdb1fe434e kbuild: keep .modinfo section in vmlinux.unstripped
86f364ee58420 kbuild: always create intermediate vmlinux.unstripped

Reverting all of the above, makes secureboot with by-hash enrolled
into db work again.

I will try to bisect this further to determine the culprit. It feels
like the strip potentially didn't update section offsets or their
numbers or something like that.

-- 
Regards,

Dimitri.

