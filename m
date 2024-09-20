Return-Path: <stable+bounces-76797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 530C497D399
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 11:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25B01F25D29
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 09:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E433714A093;
	Fri, 20 Sep 2024 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WeV4/Ant"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35910143898
	for <stable@vger.kernel.org>; Fri, 20 Sep 2024 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726824492; cv=none; b=H4znNZrIK8zix+V0qWgHcfAN3KAnKKKPXX6mGL+WVVIa07YS3y0h3vdtZWM+LVIK2EkAJwF3J3d7RMCTeU/5laqA36RKejEx+n+gdrEY+2AcERn/+Nc1RnyhX7Ov0ThCmNly2x0nyR2g+Mq3EdJjz0z8NyfRLEQ7WMWsol3bAFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726824492; c=relaxed/simple;
	bh=Y5Lhb1lEZ1zJkOQ249BuEkfmGYxxn+oEQD4Mg33C1U0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kCNK4jPxpFoGvhuwLZWMJ6zbBvT4Kp8dwtUDGXIrC+Cpmxhyexd1uupTzoE+RFv8DmZr2cd9qwGsonFKZiH/k5Lpp10fSKgejJF+PiJeZYageViTYd58gJbXuXS5Y89vz7W4tBn2F3JLyJyk7mz+u2JUtlSLl+19HW4qa19XUug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WeV4/Ant; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-206f9b872b2so15879745ad.3
        for <stable@vger.kernel.org>; Fri, 20 Sep 2024 02:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726824490; x=1727429290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5Lhb1lEZ1zJkOQ249BuEkfmGYxxn+oEQD4Mg33C1U0=;
        b=WeV4/Ant8anK6ymmz3ErqlUilpSc1Ql5d8aEE2jGDa3ATyB5tN3dFe6JCpZe7N6s+N
         IX4g5QayvR4Tw5ttqLSm74FBRaA+GRN3nlp+21Iq86Hj4Dq5JaN8EBbgk+9OQHRCCkxr
         DuwoPCSHUSBlVn5/i7H/7+yhxJfZSmYPTArcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726824490; x=1727429290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5Lhb1lEZ1zJkOQ249BuEkfmGYxxn+oEQD4Mg33C1U0=;
        b=sfYRvSPfrMGHLtGYBzcPI2jkuoT5VUIstuE8g9jo3tRpxY8f7MCkL7KA4gViYYSIz7
         zgm5NffZ/uZNTh2qJpsAtNe+0qemGJJkLyghD/iVFsuFnj145ESkdN+ZDvOqdvywjYPN
         tMTlZTvawcPxvNO/sQdg1V72ab4hKlNzpF/hVNXjntCocGWuRUFxPtBj+O7d3L9J3UfJ
         sR89BPV04CcnsY4LQxRqFhHykyCCGUc6pPlXioi6+FKpBwQlMUaAVfTVKQtLfsitVi1F
         6XsbP+h1S0e5mNFz699aSxIBfS0tP59ELC6lEa9wyUsQgqPsV2alCYXBC0yN2wszGJJQ
         aiTg==
X-Forwarded-Encrypted: i=1; AJvYcCVlMek02xfCE7e/KPpaw3+o8pjweVLqX25nSLOuZmPZuLykhh44SRd4Umxh5qqS9arsoV1+EWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGCzpPzMLvWxtpMFqmOFObZGG5JKsksjW4YS78TuimfbK78ga1
	XSmZqL66T3NN2v65MXkAHYH2v8NPBa/1znkr8VqWLJRWFBoZalcr46rCHmcg8Q==
X-Google-Smtp-Source: AGHT+IGFdhtqLL0p/NC041FHjjv9PTjEG7ihD72i2Hj/9Obz9C0AtvY6ONBsnIzpaxi1QD136eHrpg==
X-Received: by 2002:a17:902:ea12:b0:206:9818:5439 with SMTP id d9443c01a7336-208d980773bmr22015025ad.19.1726824490364;
        Fri, 20 Sep 2024 02:28:10 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d19c0sm91985695ad.146.2024.09.20.02.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 02:28:09 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: pchelkin@ispras.ru,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: chenridong@huawei.com,
	gthelen@google.com,
	lvc-project@linuxtesting.org,
	mkoutny@suse.com,
	shivani.agarwal@broadcom.com,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	cgroups@vger.kernel.org,
	ajay.kaher@broadcom.com
Subject: Re: 5.10.225 stable kernel cgroup_mutex not held assertion failure
Date: Fri, 20 Sep 2024 02:28:03 -0700
Message-Id: <20240920092803.101047-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240919-5e2d9ccca61f5022e0b574af-pchelkin@ispras.ru>
References: <20240919-5e2d9ccca61f5022e0b574af-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> we've also encountered this problem. The thing is that commit 688325078a8b
> ("cgroup/cpuset: Prevent UAF in proc_cpuset_show()") relies on the RCU
> synchronization changes introduced by commit d23b5c577715 ("cgroup: Make
> operations on the cgroup root_list RCU safe") which wasn't backported to
> 5.10 as it couldn't be cleanly applied there. That commit converted access
> to the root_list synchronization from depending on cgroup mutex to be
> RCU-safe.

> 5.15 also has this problem, while 6.1 and later stables have the backport
> of this RCU-changing commit so they are not affected. As mentioned by
> Michal here:
> https://lore.kernel.org/stable/xrc6s5oyf3b5hflsffklogluuvd75h2khanrke2laes3en5js2@6kvpkcxs7ufj/

> In the next email I'll send the adapted to 5.10/5.15 commit along with its
> upstream-fix to avoid build failure in some situations. Would be nice if
> you give them a try. Thanks!

Thanks Fedor.

Upstream commit 1be59c97c83c is merged in 5.4 with commit 10aeaa47e4aa and
in 4.19 with commit 27d6dbdc6485. The issue is reproducible in 5.4 and 4.19
also.

I am sending the backport patch of d23b5c577715 and a7fb0423c201 for 5.4 and
4.19 in the next email.

Thanks,
Shivani

