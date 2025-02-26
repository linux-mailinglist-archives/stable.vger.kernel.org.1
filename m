Return-Path: <stable+bounces-119736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C91A46A3F
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 19:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444F33ACE18
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 18:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F115237704;
	Wed, 26 Feb 2025 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVrIBSZI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B27C21D5AE
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596117; cv=none; b=P8q7qRpQRilBmonbo6mrDK5U2Ov1JBO4emmDqyjXyLsmHNXBFVHMJdfKHAbRx14ju2lNQFrGQWwiUNYAUbKjQaNvR0CSVCiVCbLVE0WLYfN8YOylxRlBp94DcEWauQO1q642w3Mpwis+9IutODRbTeTa952TYkPo1lCgmgrBmnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596117; c=relaxed/simple;
	bh=3hozpgoSS59OL/VEqqi5QtKt2hfzFcBfjU/Lbnupyjk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PTAEEATe7lBPRql13Q3IWq0xsj/ck16NsNu9VxheBzYdCJ3ps26VmzqHKuYs9TVcWWitTarJerhhKrka09WGjCxzWG9hic1IyROKoSe6HdUCedRE+bueG/QM+GYa5R/Mz9JLg6fd4Rf4pIc8zz6IE2jN4c3eSQDbuNR+frrNEm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QVrIBSZI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220f0382404so1318895ad.1
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 10:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740596114; x=1741200914; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tz4Qs953FyQ8pSwuSRRMRObCEn7/+1IJwtCxcvgUByo=;
        b=QVrIBSZIgZzgdatwxWv/2nuYHAGYHzrrCe4RxydfADy2Yo32UId4uVC6SF/XFx+oF3
         iTKYEBUPAwp+mjviMbykoIT+zV1oXoB2c9zPuqGBjxmUZbIdwjvXJR7hv0T+nWYB8BqT
         En8KbJywhdIbQHDOavvTTxkC4wj3Aw685g0WiR4Djfa7vWNYjENL4JFEaJnYRf83NNbf
         7pFK412HiGbl1aa7wJ479rbTT1lV3qOFVygGUg8mRKBJQlMDpBAi6m2+XonzCbVLgIgZ
         dPKsSUnhI6+ng4UutNH1pya0uuotKQ0C10qwlsFDa1FyT/BDQa5iaU1Q4Gp50qvjZNGz
         rtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740596114; x=1741200914;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tz4Qs953FyQ8pSwuSRRMRObCEn7/+1IJwtCxcvgUByo=;
        b=kfg8o5hLyGhPjJVe2PdgpQdm2ZJccwmm7/nEFkTF7kFI8tupKKgUr8dfO9NcrQqNzn
         H+WJ8cXaTzi7qKvuEPjmo2uWBOkLiCAbXYplLwrf/Pgf7DKzbL4ZYB7kA75+N/B3/Qln
         66pS2W9lw6JRe8yLT3lIXL4En9gG/MQBjnkAjRrb4+em5itmF3l4ZkX0SxNg1HhrDmg5
         sg6935P33rxM0zMM/mvJrlPbqvSJr7xijgMNJC7Ki4cbTOCPYREslIQmMrxR8uKfcm9h
         ivFYc6tnYgwc3RDFf35KsS9M33n3J8ZEmLNDxotbiOitRwaNmwN7ABhSMxfme3MSNjW2
         dJEA==
X-Forwarded-Encrypted: i=1; AJvYcCXS2xB7Xmah76oNbn6j+piCKsfNSrBZGubWvfBfd8txoKhYhEzPLYhmQt1eQ9C9M/EFpTsr1FY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1HDMgk7jUK6UdEbcbdVvcFJzUS/t3aR4iFBsbzTW57CzDd2BN
	nrfZwDMRHQGGHL0soSN4pRcbNlTO0z2i1jTbFQKLhyXmgEyvM/Fr53G5VBNVm/iEovvOK7NLVgO
	iZA==
X-Google-Smtp-Source: AGHT+IEiiWKKK5H8nmcWMiqbiAfTi/yBBsoyxX+kvTyaicEXWSkrrWW/xyqbnD51MQeATwdUE4l+c4dsV6M=
X-Received: from plhv15.prod.google.com ([2002:a17:903:238f:b0:220:e5d1:24c2])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c7:b0:21f:4c65:6290
 with SMTP id d9443c01a7336-2232006201dmr74561105ad.1.1740596113491; Wed, 26
 Feb 2025 10:55:13 -0800 (PST)
Date: Wed, 26 Feb 2025 10:55:07 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226185510.2732648-1-surenb@google.com>
Subject: [PATCH 0/2] move_pages_pte() fixes
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, aarcange@redhat.com, 21cnbao@gmail.com, 
	v-songbaohua@oppo.com, david@redhat.com, peterx@redhat.com, 
	willy@infradead.org, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	hughd@google.com, jannh@google.com, kaleshsingh@google.com, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patchset bundles two *unrelated* fixes in move_pages_pte because otherwise
they would create a merge conflict. The first fix which was posted before
at [1] fixes a livelock issue. The second change corrects the use of PTEs
when unmapping them.

The patchset applies cleanly over mm-hotfixes-unstable which contains
Barry's fix [2] that changes related code.

[1] https://lore.kernel.org/all/20250225204613.2316092-1-surenb@google.com/
[2] https://lore.kernel.org/all/20250226003234.0B98FC4CEDD@smtp.kernel.org/

Suren Baghdasaryan (2):
  userfaultfd: do not block on locking a large folio with raised
    refcount
  userfaultfd: fix PTE unmapping stack-allocated PTE copies

 mm/userfaultfd.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)


base-commit: a88b5ef577dd7ddb8606ef233c0634f05e884d4a
-- 
2.48.1.658.g4767266eb4-goog


