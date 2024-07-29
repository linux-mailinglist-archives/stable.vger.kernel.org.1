Return-Path: <stable+bounces-62372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5F093EED4
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2079BB236FB
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6F312D1FA;
	Mon, 29 Jul 2024 07:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j2VMVPKw"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0012A177
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239081; cv=none; b=YYd+Znwd7c+/AIFe6JyUfqA7PTS7c+Z7UkwJylM6knQyoeJOB7Z0W/RLkGa9MYas4TKub7mbZMdh/HWac32coqiIV5AcFZix2v3DaTE5Ktt0Zte/nO1qDBmSuzXNbVsPqErTixnZsJGCsaZhHXf9Fp8UtS63NVleh/7jHKpdbog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239081; c=relaxed/simple;
	bh=Tb6XaxwL2ciYkU7k1keEWOAaMb8Ocw2G7vPKcZiWSmo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RBDrckPfqa6xCy++19vUOscUoqQER4JLMfexXoLrQfBNGTGP2GYeYl3lcKpRBlcefYZceZclb4iNo48V1y3frP+jWyUewVuu5RkUEoJfirJTOMdZ4N9uZyNLDFCE37AQ9r8eRA1mR8pbzawu9i9pQMMrBIvwgXd9kErCg4Zo4yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j2VMVPKw; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-664b7a67ad4so53224887b3.2
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 00:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722239079; x=1722843879; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D+y5NR2xwulOlAVfTckSm2VVRjti4fGYYgklB0CIeOA=;
        b=j2VMVPKw5up6jhoN/irePPLRcikqE/P7xt1U/UnQ49BDDPGUZXZpQRwv7q2H/GTybL
         B9VkEjT1J91dd5uU5894A1cms9xJLadKGVGnWlR53sBgnwm6hGPz6eMoIk5JEW0dRu/5
         F5sEZwWS4D2tV5xCkX6bMhYMkR+YnD6g0d082YFGl5z42HXSFVld5A8dTkKlYIcuzI8P
         ojhkv0lx9KGrdoyDq982IxwIRfLhFdL66jEMFVUzz6nfUZ3UrRwlq1g/q38xFCm2BSng
         SM3maQPBtkA3+/3xTVfkwoHrHb07btr2xNTgwblcNzM4Gu30wfYgP2mgeo81oJVwWwYX
         ovew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722239079; x=1722843879;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+y5NR2xwulOlAVfTckSm2VVRjti4fGYYgklB0CIeOA=;
        b=VE7GxObiBITBp/EGfQ7S88L44X5OEiraL5g6IPCVDQS486W7YWp/CO1uiSrvVjDyBI
         cHg2TjckUhAU/E+E0O9Xc2jNaHze10l/yl/AA62omm8bfCOyXEDvBZH8iKEPC0nUBy7p
         Ob6vjIcy+FlK++6gwfi8ISJ9smj6MegGq7+TrChoCeuUpIaZBvjIPUExu8XT4N9wOeI2
         YoyECp0njrKG1hIy9hWgCONVWY4fRsxEejGOfbhYjQQQC5SDdgiBbvN34iGn4DjkTs6/
         ECJrkY37lE7Lm/8we5kkIQ25dTCKGEKI2LP4rOJl5u7o3aFkhQdFWlFbbSFs5BMCFoEm
         iHfw==
X-Gm-Message-State: AOJu0Yz2226W56JciPwnt8F3PVhi0uW8fvZfD0C1rBYSgevA6fcRY/ea
	CEGLIo6zWBXANi2FogiOuBz+reQAlhuCqHHsD5V8vNBJFOSPtXkyg9hX+pqrBSPUDBFj5PNKC88
	XI/HOLfjERpArVUKj5r8X02pxvH24yjIw9qXKt741irgTcp/zrEZFRDpvSId7hPRt/3hHAT+OMV
	yGjlicnwzNre3WJWoAH1YX1rBwIwrowA4f
X-Google-Smtp-Source: AGHT+IGEJ2MUGEuZbFZAVhn0zIdQZx/E5c8hdPtRhdgXfjUoUtlHTqdKJhDUL5//xfnRQ6YyklaEx7G8qJQ=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:33d8:464b:83b0:a265])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:2b0d:b0:e02:c619:73d with SMTP id
 3f1490d57ef6-e0b544198d2mr366853276.5.1722239078599; Mon, 29 Jul 2024
 00:44:38 -0700 (PDT)
Date: Mon, 29 Jul 2024 01:44:32 -0600
In-Reply-To: <2024072912-during-vitalize-fe0c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024072912-during-vitalize-fe0c@gregkh>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240729074434.1223587-1-yuzhao@google.com>
Subject: [PATCH 6.6.y 1/3] mm/mglru: fix div-by-zero in vmpressure_calc_level()
From: Yu Zhao <yuzhao@google.com>
To: stable@vger.kernel.org
Cc: Yu Zhao <yuzhao@google.com>, Wei Xu <weixugc@google.com>, 
	Alexander Motin <mav@ixsystems.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

evict_folios() uses a second pass to reclaim folios that have gone through
page writeback and become clean before it finishes the first pass, since
folio_rotate_reclaimable() cannot handle those folios due to the
isolation.

The second pass tries to avoid potential double counting by deducting
scan_control->nr_scanned.  However, this can result in underflow of
nr_scanned, under a condition where shrink_folio_list() does not increment
nr_scanned, i.e., when folio_trylock() fails.

The underflow can cause the divisor, i.e., scale=scanned+reclaimed in
vmpressure_calc_level(), to become zero, resulting in the following crash:

  [exception RIP: vmpressure_work_fn+101]
  process_one_work at ffffffffa3313f2b

Since scan_control->nr_scanned has no established semantics, the potential
double counting has minimal risks.  Therefore, fix the problem by not
deducting scan_control->nr_scanned in evict_folios().

Link: https://lkml.kernel.org/r/20240711191957.939105-1-yuzhao@google.com
Fixes: 359a5e1416ca ("mm: multi-gen LRU: retry folios written back while isolated")
Reported-by: Wei Xu <weixugc@google.com>
Signed-off-by: Yu Zhao <yuzhao@google.com>
Cc: Alexander Motin <mav@ixsystems.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 8b671fe1a879923ecfb72dda6caf01460dd885ef)
---
 mm/vmscan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e9d4c1f6d7bb..0fea816d9946 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5226,7 +5226,6 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 
 		/* retry folios that may have missed folio_rotate_reclaimable() */
 		list_move(&folio->lru, &clean);
-		sc->nr_scanned -= folio_nr_pages(folio);
 	}
 
 	spin_lock_irq(&lruvec->lru_lock);
-- 
2.46.0.rc1.232.g9752f9e123-goog


