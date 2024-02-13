Return-Path: <stable+bounces-19751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A900853478
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 16:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF0C5B2320C
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 15:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE165B672;
	Tue, 13 Feb 2024 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="P2EBWAXO"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B37655C39
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707837767; cv=none; b=Bf4jzEttpvLG76SF0rVnmQIh9VXmhdQq3zrxLOjrGvvJ+e10fR8k5xRdEOtbclY7EQJIMQe3DX8egLukloOdDsnOT113bDa4jfF/1Xhpw6bfujOMZbTrwIH0KHR26Lnvbl0TgIFtrN/7AtX5vVJnpidR8XNnVUEfxFAJg+JKZ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707837767; c=relaxed/simple;
	bh=3+rbeK+hsnHFw3vKJ91A/pV4kZ2a/dxYwCpM/H5zRyE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Uv6Gq9eGSzfuoG54KdjAdUKJ0HmKLTkwbD4JZ0NEYuYpOEW3FYDw0AHix90sHrhfLqlXg2/SIRkIR+mcgfbemZrrfDKUW51LbqGmioneJo0fmLsmiYuUdrQtJ521spZejpBzZWtte96dC8gL/463pujzHv3kG2QGrV44OktDPM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=P2EBWAXO; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso85682939f.1
        for <stable@vger.kernel.org>; Tue, 13 Feb 2024 07:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707837763; x=1708442563; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osJMD6oQ1Ruq6z4x/RF7MnbROMSvGQzmYm2/M6kn1Nk=;
        b=P2EBWAXONjJ8oIllSfN9BpFd3pKaZWL3s2grwZLplQ5NMBvFG0ZR0xFeCPiady/ZD0
         IZaXBYqlSn+UhD4Zd7PfupYjBWhMnbGFZczktGsj+1VT7fCUKouUBj94Xvt1lXkc9Gl/
         Vljyi4KYOQUs7D7I34abqF8r5uHt04KpzPMHdS0dXn1hs4FnysAj+93FT3f5Pz1S6QBN
         fZuvGHxojVUGOb4IDgr9CBJTAaBXXokANBvqkZJs/OLi2Bvp1/cmfgwaBLXAww1DTKbO
         x+yvOwopPGva1VZCupkWUxZRyZ1TeJQ5Zbtqfiv5GyonQNOH3iCBwVmtpQ7k5x4SYEkd
         5cFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707837763; x=1708442563;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=osJMD6oQ1Ruq6z4x/RF7MnbROMSvGQzmYm2/M6kn1Nk=;
        b=iJa499EwS3XN7GE+WlDYo7zFEDzY7WprK0ct4bxxfCn6onZS7ngGA3uOUYvNreqTbn
         Fchkskqg/lJD++L3xsuCqXhpT663C2IbbxdNodC87rdBZRTUlS2z8iEglDDZsMoO7XaP
         QyxlwcT6zPEhvrNfEtxxWqpb/lL+IVU8JaRKP2OnRtFpIgueldflOXR9cIwTuNFSYSKv
         q9qjr4j81cQ52bVO2kVdQ6FKpQAD/If0HGZAEGV3/3bW4CVyMhFkRcW9zs0Zm3JgPlua
         mq47kuBaJ/ziXsKTZg/BIcWBvrrCgHIJRHQAfofD7hUUmccEuRm2FQlYABmulplZVHok
         PGSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOkVjcNX5kcOwqIBUjxZVcgMj6Jj602gyv/3B1hcAoOHHhXHuDBhyRNA/2JwJBU7nPfcw7/pFvbjwOtw0KoaP6udLKVeaM
X-Gm-Message-State: AOJu0YwhGhoCbkaQK65u6vdcitArzk0dE0S73dk3hQNKM7obwJEXvPRF
	hdLUi/FQ/YZMofdHMxG4ghNkOdLDatmlCYXyDEn+mJl6Bp3FQfxWweFh0dS/FRiCyi262sOqcqZ
	S
X-Google-Smtp-Source: AGHT+IHNpa4t4nPHljAT8PFXzF7VwQSPIBKsc422PpG+w7VCMYETwVluqIkVIjPR/ZMinuG9rZhsxQ==
X-Received: by 2002:a6b:3f08:0:b0:7c4:655:6e05 with SMTP id m8-20020a6b3f08000000b007c406556e05mr8337056ioa.2.1707837763127;
        Tue, 13 Feb 2024 07:22:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdZqFL5I81QBx1Y+gwqe6cdpbTQT+uKMrMNhUd0T/dX7Fn0atzB+PzlfAXhXYzdPS6Zv2qoIIGZXNGScfVEbBRwrcv5lo9
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id fr4-20020a056638658400b0046e917416c8sm1953044jab.89.2024.02.13.07.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 07:22:42 -0800 (PST)
Message-ID: <853b6529-3af3-458a-9985-294fb63ea2ea@kernel.dk>
Date: Tue, 13 Feb 2024 08:22:41 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable <stable@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: 6.1-stable backport
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Can you cherry pick commit 33391eecd631 to 6.1-stable? Looks like we
never got that one marked appropriately. For full reference:

commit 33391eecd63158536fb5257fee5be3a3bdc30e3c
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Jan 20 07:51:07 2023 -0700

    block: treat poll queue enter similarly to timeouts

Thanks,
-- 
Jens Axboe


