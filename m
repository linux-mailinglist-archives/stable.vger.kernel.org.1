Return-Path: <stable+bounces-204434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD1BCEDFB6
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 08:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C09430057C1
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 07:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4868225EFB6;
	Fri,  2 Jan 2026 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AchbGgCU"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE447260F
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767338875; cv=none; b=DAhrCNSPAudyku6r4/JfM8LsIZZBFkrZFeKVJZpkOzDZHDChZ3r5vwqPb2aVTTSlaiF/V6Y44TzIyMOoeFHuqq2rrBOC9o/zZ8XZBjPJJYo52MLhg/TSdlTc4UnaLICt5nUDNM4R2ZNFfEhuiLUW/HUnLIOJt1r8CBhZMyjmqhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767338875; c=relaxed/simple;
	bh=nWdrJ9x9+1pmJj5i0TJoMUz65FPiWuu4anBUglynj5w=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=U5OIy+8QVWcLBb55btY3JOIpWbVyct5pjPx4akmalfw5HMN5yTJ2VZEEYavxBP9BrK2Qwakz2kFIUv8nr71al7EKsfc/sto6wQUdYP8DbpYsyw6gcUWUhEa3TFjkjtfvoaUwy9XJMwEnNP9aPTedthRIxGPbz0hrBQ5i/hidM/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AchbGgCU; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b2d56eaaceso1438523785a.0
        for <stable@vger.kernel.org>; Thu, 01 Jan 2026 23:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767338872; x=1767943672; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqSs/jd1cEUVMCPH0we8Tw+1mohvsxzNqFEEho5hTfc=;
        b=AchbGgCUd1C1LMPNzGxscCGSuFPWVf9lGp8lF+bWVMYm7v1dstfyW7ftwyvaxpS+LW
         KQYGJ8ne7JuPAtk8Jfq/3oUvjThm+3417eOLWjpTAcJNN7MdOQBM8E1xweqRvyZhanhl
         3YQKT2ZGiI1qMRUkBQ449M8qeCqTwZf1gyux24LQLgw3nhlYJyLelJEwnF2vV/FD6XRZ
         zxo3FMrSBmJOVMa7NFqoJjSDKCIajRRt9wYXbbUf4Bwy2EipAqIsxFMSrCRgJQDICJK2
         UldqCxJP8RhC7CSSiDL1+EGDxIvLM2amVqIyyYC3nyVaLq4fnn4wtbTXIX6hetv7QZ+A
         uLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767338872; x=1767943672;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MqSs/jd1cEUVMCPH0we8Tw+1mohvsxzNqFEEho5hTfc=;
        b=V+aO7N+9zbjkF5wIXnJHHUyjkMVUFPeka5Tb/SXrO7/O9LUHbCQqjc8ETEgYjp1KpL
         rc05/YD5tvx6gaXVVf4WKHra3lpifr9WWRYzlmeoqEtizTYDEBeJEfVwQCgCSookG5wL
         BxYlP7wF4PirtOf4YlJXu2UnS/VA6DqpQFtJGKtxBQ06QgD9srn7dkI3BOXZuPBn9yFg
         wcmEid5G+w5RNvh0oGmCLmtq21jCpluzvS7g5aEQcXo9NZoSZkvsoo2K+S35tJgxCt9+
         M1Xjloq4B2CYds3lOOAznh2fqu7aN7FS76XuqKspEfy9yHAKQrhPIB6E6pa2KODXeH3N
         Woqw==
X-Gm-Message-State: AOJu0Yz+6+YrOrU/i73GH7072wrwUhQftJuURJPKM3WBVtI+3WKkZrsN
	Vdqa2CDScpPIusNXY5zQn0OCYxTPJa011fjKoED0oFCDob5eFFfxJhi1gF88K+Up
X-Gm-Gg: AY/fxX70w5gMXZ1U6SYF58NheMZNmuefKhu7X+B40soJu2AvARHppi5dxRGawqnkmzQ
	djSZFl1u2JR/dkO07nvRyYCPJtGq1hKCJgGP4JCTlbIZwIHUyXO6JX9Z3iPGC84+tbv6j5xEQ6y
	utvaz5kyvgsnB64wu883s5uRzN2VKc+A/BI/7AYxnXTwJuO4nuiQqH6wSvEh7IIGljRZ8G97j4v
	2C4SSOGxM+dJpPG1NFWBVlgW8S8FyMSJFjuNLvxvfW9b9lADJOqAOsAMiH6y5rd0OuK+0MXZ+oD
	E9VsIcVoMhplKHPa5LzmG4AAN7PmTyLgQaKODvlbDn2f4xnajKumIwn106TCXqfVPjDg6qvj0JF
	ktNaBm500Q+rAMTcLf7Z/dJdGcU9BqWJXXO2B9rphkxBDjTTrNfd9NCuCOwdSLswe7WcLH//yMk
	VMfo1Anw+ipgjOwzIXdUgdOCJ4zYhQBVWmGPfOePQiz9lCT45hfTZ/ck2WB5Jh/6uGyKoG73KRW
	MHM
X-Google-Smtp-Source: AGHT+IHrVp0axZrli01xQ2cOQywyrWngcl0eVGklp+Yg0XqYodHrfKi1bILZacENY5jHVll+mLzhKg==
X-Received: by 2002:a05:620a:701a:b0:8b2:d2c9:f73 with SMTP id af79cd13be357-8c08faa4eb2mr5629385685a.41.1767338872285;
        Thu, 01 Jan 2026 23:27:52 -0800 (PST)
Received: from ?IPV6:2604:6400:443f:f201:4e5a:1810:92f:b504? ([2604:6400:443f:f201:4e5a:1810:92f:b504])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096a8c758sm3162316885a.24.2026.01.01.23.27.51
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jan 2026 23:27:51 -0800 (PST)
Message-ID: <3bb3d050-03ba-4d72-bb29-da1b6a9b6fc1@gmail.com>
Date: Fri, 2 Jan 2026 02:27:50 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: Jacob Highgate <jacob.highgate@gmail.com>
Subject: Request to backport a fix for boot issues with Southern Island GPUs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I would like to see the patch linked below backported to the 6.18 kernel.

Currently, on the 6.18 kernel, systems using Southern Island GCN GPUs 
are unable to boot using the amdgpu driver and they are shown an oops 
message.

Linked issues:

https://gitlab.freedesktop.org/drm/amd/-/issues/4744

https://gitlab.freedesktop.org/drm/amd/-/issues/4754

https://bugzilla.redhat.com/show_bug.cgi?id=2422040


This commit will fix it:

Subject - drm/amdgpu: don't attach the tlb fence for SI

Commit ID - eb296c09805ee37dd4ea520a7fb3ec157c31090f

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c?id=eb296c09805ee37dd4ea520a7fb3ec157c31090f


Thank you


