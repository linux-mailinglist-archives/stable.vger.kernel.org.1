Return-Path: <stable+bounces-139331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6316EAA618E
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2000E3A946F
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 16:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0CD20C47C;
	Thu,  1 May 2025 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DP6vcg8b"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF243D561
	for <stable@vger.kernel.org>; Thu,  1 May 2025 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118154; cv=none; b=ZhV5vTTWhnSiEwXzHBaZG6lHL/Bg3H3bwRNX6nMYxmrxr5wkQ0kVAi1v2ykA7DR2Fjo0qOtetwxFepeV+Iwhj5Zz2ELhk1KqVuTJp9qL3gvRpuzzW/ApBvqu+YyUdAtmN7g1tBdNFBbB8B6oR1Ca/62S/lPnJGlpactUgb2Gpzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118154; c=relaxed/simple;
	bh=lEZyOTCziqfAp7P2v7S/ZbSExArgQSuqLooj2xklG2k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Q0kd9RTuioW/sJYyj0cRPqMTJozcU9yHBURgzZU1PBznDLwdZdGi4RafqC73qY5IPZKe399+ls2GqqzDYYB9hDaG1iobLYvHdcg4usUEMh16shCCD/nR5KwrsTF0UnsezenUG5YCV7bYcsb9dt7ebmT8u0rn7Ozw7t7WfzNLU5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DP6vcg8b; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac25d2b2354so173908266b.1
        for <stable@vger.kernel.org>; Thu, 01 May 2025 09:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746118150; x=1746722950; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hu/yzkV+721imoVR7KgnkRWWT6XkZk1iUZhaZpqFJx4=;
        b=DP6vcg8bIvknRxIaEfKj2JDfJdacNf3niV2GjmFCSYX7ElWV+75c/vM0Vyzake+Fda
         THTyRGDLnNZ+kzUpVes5aVzDDEqvkEuSk1yG/jzeTrgzkl6Mx4Hy//Lz42q/x8xQajkv
         lLoCW6uM7EVsplbyyHMUnzHtJesuppH35K4kt/CW7c//E9aKKJReaX4u983JVUUXO3mF
         HK5dbPqCzsmLIv+2IpW05Lra7PJBnJV+Z8DjgfyWxFdrt9ih445DmJGCm6UMaWRQMF3u
         tBvh8xTdRKarQUk9S1pHUR0XblUFq1ZkL5fsEvkyb3AS7Pv7Gf2xUTMJc4KlFjY1A62v
         3mRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746118150; x=1746722950;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hu/yzkV+721imoVR7KgnkRWWT6XkZk1iUZhaZpqFJx4=;
        b=Wy+BWfDMxgKPgpnHmBGkTdt54BXZz8iYAPT2so4OXZrCLIF2DvVyCiAn2HZS1n/itB
         Tk6ZsxA3vQyPpoQIUkCMHkp/5evLvsgsrk25eRfwBzM9PJZ38KE1RvbX8TlFwO4o5cSg
         hDHwCCbNSmXzsu7TQJF02zs7agtKkF4JvsDHVYAiRhZqSc7cJCt2KF9058MGhioBK16Z
         g25hETTcSkL2Vtu8xx5aHmvlXJH0AiIvkr6Rh/PtdQ5Pj3HKfZTa1qcxr6QPB+7bjbhf
         E1n0zR81mEso7xrvS8khjVgaG0HL4GL9VbcFyJ7Is3MbM2Xh35gXkHkAczTGSY0whONw
         tKdw==
X-Gm-Message-State: AOJu0Ywh+b6gNNhOf1nksRtWgM71jjfSFCYnB/ofUoMjIyqeQ3ODoBs9
	iq6NNvFKOrM6TRJu4zo2QIL8PIUnataxJ/SHBSefiPSBVM9696WyB6UP+wAJ4CL3uxpSUVp5Flf
	AsaESgITUFReNLhnd0H3zBGM7wgr+VpESppxIpk7NZU9U4YQWcA4Ig3M=
X-Gm-Gg: ASbGncsPDWHDrYl/+uiAdxydPYRJ25N8YVTjnizT49hevvWCfl1KQnahDoT98E2Yt4D
	JYuEhffwW4e8dGaqK7vOZrw7T8CPQ0+M65JEaYi7x/vcnB0BOrKW/uHo9kKJ9yzlcQ/PNeVcI3l
	Rv1Uo32yFBZeic/j8wHFEnQqfVxBXvY1AmaAqSMZ/bds5rl8AgC4iV
X-Google-Smtp-Source: AGHT+IHsqSl1rz2A2EL7MscbLN11ftKk4Kn8Zr3XE5qHdE75gDOjkwZYcVH2VVka85YcLS8nqPCuQXkKLSB5Fzs8Ar8=
X-Received: by 2002:a17:907:e84a:b0:ac3:10e3:7fa5 with SMTP id
 a640c23a62f3a-acefbb35960mr337919866b.21.1746118150326; Thu, 01 May 2025
 09:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Thu, 1 May 2025 09:48:59 -0700
X-Gm-Features: ATxdqUH6mV191jlxrCMFslmhsm2bx50N8I6Y78uRz5HNFSj4jvppHHAOBLdc2xo
Message-ID: <CAAH4kHb8OUZKh6Dbkt4BEN6w927NjKrj60CSjjg_ayqq0nDdhA@mail.gmail.com>
Subject: Please backport 980a573621ea to 6.12, 6.14
To: stable@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"

980a573621ea ("tpm: Make chip->{status,cancel,req_canceled} opt")

This is a dependent commit for the series of patches to add the AMD
SEV-SNP SVSM vTPM device driver. Kernel 6.11 added SVSM support, but
not support for the critical component for boot integrity that follows
the SEV-SNP threat model. That series
https://lore.kernel.org/all/20250410135118.133240-1-sgarzare@redhat.com/
is applied at tip but is not yet in the mainline.

I have confirmed that this patch applies cleanly. Stefano's patch
series needs a minor tweak to the first patch due to the changed
surrounding function declarations in arch/x86/include/asm/sev.h
https://github.com/deeglaze/amdese-linux/commits/vtpm612/
I've independently tested the patches.

-- 
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

