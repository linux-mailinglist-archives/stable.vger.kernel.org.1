Return-Path: <stable+bounces-35674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0C28964B1
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 08:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191A01C21DD1
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 06:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4598414006;
	Wed,  3 Apr 2024 06:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uhz6PC8d"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6984D210F8
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 06:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712126643; cv=none; b=Ych2B36u7uyvLZbVcfYMaGQge1LmG0EAbAkkK+NqqZlYugEfbU2cak92XlyQLiJgxrSCGY1Wp4NdC/7t2x21V8Ck+wxfwyOH2Avpr7PlZtprK87NulaGBGqqsDJG2UnBiRG0coNhEY3D/0zqPfW9CfGkoSmNQX/vxFjyeorZMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712126643; c=relaxed/simple;
	bh=VctjFfQK7eQ2QoWPuR3Hw9A+wXNjnkhCJcylwd3L+es=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PCQNAESR4OBGqyyOcA37YtPITl5K9RAh0ZnvQI2NpKBQvmUUdaxMyQhTtX6u+j2yC90TxrY4ecedAoITG21d5T9VD4U+zAPCboi9jrHJQWlBJpvhg4oFk90ZimxgDr0iWSh+UdS5qbmdl2DjQohgt1c68NklzRjuY9SSwTreLZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uhz6PC8d; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso4662333a12.0
        for <stable@vger.kernel.org>; Tue, 02 Apr 2024 23:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712126639; x=1712731439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VctjFfQK7eQ2QoWPuR3Hw9A+wXNjnkhCJcylwd3L+es=;
        b=Uhz6PC8dG4Dpd5ennmGPPlcR3rjbR5e8Far48FnvS9ywyMj3LJMun4J4RoYv5ND/9R
         MfSXPRFXqNarBSbVu+24yiycwYf85sJpmn6OMys92Rxix7P4mXydz3SFF6vxysObBc3q
         odrzY09QryWSE6bj0pEVJWjnbRZxlm51Xtcptx4UoIWPLTfHpI2EbwrJG6Ze1IFb5nZc
         HnSePwDQ6hZ3fG5KIIvY3RCYNtAe8b5d2uijzK0Gn14BnLSS/1+yNzI82rJFb/anrWSJ
         J+hm/t6KAQzrdZgisUhwHdhetKAQnh7YpfmGS8hiYDKFK7jRFTROPhz21f5DOtwLLFHG
         N+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712126639; x=1712731439;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VctjFfQK7eQ2QoWPuR3Hw9A+wXNjnkhCJcylwd3L+es=;
        b=t6/8/wEtC1d++pBrOPxHLMli6s+J2PWfKMlYUxL88Cyf/q1nAjmtdpPT6sV2qIAE2a
         780Sz6S8bsjucGugtaU/+mIoQ7O0HthwZgUiF2TNy6a9FRp1t/rJ5fmCqMA3XExWTPoo
         lSiIg1FCcnizyR6C6/9C8QDuZFT24aCT4Qr9VDU/YNunUL57rikd6znpt2toyegb2roy
         NwT/Y3hySud5Mo8UuHNcUgUaSwZPYqfOHqWevWuIBhhvosUpIevSR67nDfduPS1TLtKt
         oCyFmpHzrgLI66CIqVk6OIGvFQYjqQw60b3l/cY82ZGbf6vgwx+L2ZPPVS0PEx/6bYC0
         +Fuw==
X-Gm-Message-State: AOJu0Yy+jFiPDcuu7LNF9xxt3zUxQKasctNnI/dkmnbiaszt3vD86+Ot
	BkC84pViX+/OgsBvN2Ee0gfXY9FN5jNm5jqDMnCXB2Fy2DKLlYd5XuVDFIUVDjNOQuoqUOFW0mD
	ZbXyMWSmXkhdQ0CKg66evVWmSRGn3sP3C2Uo=
X-Google-Smtp-Source: AGHT+IGp/zEA/6gxqT/dVckZTzLcWiOa2/HklU0KYe67P3QrTePycBq/KYGrh1xrZu2YIeOSt5t7M2mLKvErg9OMHnU=
X-Received: by 2002:a05:6402:26d1:b0:56d:c4eb:6328 with SMTP id
 x17-20020a05640226d100b0056dc4eb6328mr8339513edd.29.1712126639405; Tue, 02
 Apr 2024 23:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Meetakshi Setiya <meetakshisetiyaoss@gmail.com>
Date: Wed, 3 Apr 2024 12:13:48 +0530
Message-ID: <CAFTVevX6=4qFo6nwV14sCnfPRO9yb9q+YsP3XPaHMsP08E05iQ@mail.gmail.com>
Subject: Requesting backport for ffceb7640cb (smb: client: do not defer close
 open handles to deleted files)
To: stable@vger.kernel.org
Cc: Steve French <smfrench@gmail.com>, Shyam Prasad N <nspmangalore@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, bharathsm@microsoft.com
Content-Type: text/plain; charset="UTF-8"

commit ffceb7640cbfe6ea60e7769e107451d63a2fe3d3 upstream
smb: client: do not defer close open handles to deleted files
requesting backport to 6.8.x, 6.6.x, 6.5.x and 6.1.x

This patch fixes an issue with deferred closes on the smb client exposed by
patch 1 of this patch series:
https://lore.kernel.org/stable/CAFTVevWEnEDAQbw59N-R03ppFgqa3qwTySfn61-+T4Vodq97Gw@mail.gmail.com/
commit 2c7d399e551ccfd87bcae4ef5573097f3313d779
(smb: client: reuse file lease key in compound operations)

Without this patch applied, when an application deletes a file before closing
all open handles to the said file, the smb client can defer close its handles.
Consequentially, creating another file with the same name fails until all
deferred handles close (specified by closetimeo value). When the rename, delete
and set_path_size compound operations did not reuse leases, the lease breaks
took care of degrading the file handle leases everytime one of these operations
happened (even when on the same client). Without these (redundant) lease
breaks on the same client, the handles still remain valid and this fix becomes
necessary. Eg: Patch 1 without this patch would regress xfstest generic 591.

Thanks
Meetakshi

