Return-Path: <stable+bounces-152665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B74ADA259
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 17:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D250C188E195
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 15:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA4E27586E;
	Sun, 15 Jun 2025 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b="S6B63R2G"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEEB1BC3F
	for <stable@vger.kernel.org>; Sun, 15 Jun 2025 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750001818; cv=none; b=akRqSyCBDRv6nlBySp0Iabxnw+8111YV5Pa2do5J7AjUAf8D95ePkz9uBXcnZw5gFYQIHYN+PYd8QnPsQJXpdA4LtYzj5my5kRgsyD0TyE2NJgvd9cSjlTvrUN2rDXwX7ue9NBRQEh+OECXk6lRpgxhsi27X9uVX8+o4N73t4/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750001818; c=relaxed/simple;
	bh=DkHzpBRH1O7eKbb31v0W+kLZbCpUW8F6Cd2clufPCuw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mLp21+B427Ee5Wz0XmDV+oFHUVQHzweRFwlORrfladE0by0pUFg9Ik3uOAaLgGj5hzGCwJy0WkA4FOM+lX15AChdfKWzUy2th9oC8QzX33rwAFJSBa7bJlhdzuU+oBtvN0EBI0o5KvAemfVDRLk6swlmKZ7RW97RfGR0wjhffvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com; spf=pass smtp.mailfrom=zadarastorage.com; dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b=S6B63R2G; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zadarastorage.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74800b81f1bso2969752b3a.1
        for <stable@vger.kernel.org>; Sun, 15 Jun 2025 08:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara.com; s=google; t=1750001815; x=1750606615; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K0VuObXtSd8wmv+9XvUrESsF/3WA2Nz5/RgfdH6EkCU=;
        b=S6B63R2Gzu9E3VUX8mzWtUgSyi92qH3E9P5SWs3IhBk8K6o3/vxkLW6iHjbIvcxt42
         RRTsNyMgACC+JCFZxghDJoMOFGD2rTND5v5sWA5SU2FJoVXowoQgoEjHDcnd7+abLOEv
         Hv065y6/Eb6dnvF1lAHoOvIuEqDFmb0GIARgdhxZi/rL2H4VTYihjJf1xlCku3o3NwDs
         P3w4fBirEw/b+pSK+8emHqJHyWQC+BrQ/Phxc4+Txc4tcRZ8V6cN/6X0LmpiINMFRdf8
         R7YW2Ou2a8vZg7PY4UMtlcXMmMXiWmha/9IP3hYwsZ9OmJkzEQHEXQkqZN2A7DNhvh7s
         053A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750001815; x=1750606615;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0VuObXtSd8wmv+9XvUrESsF/3WA2Nz5/RgfdH6EkCU=;
        b=sJV0tKPl0xEdxJU528IPGWZ+YWb+EyMeRgprLMetYB7A78ZwGUbsMyT16a2Du1vDZp
         hnkr1h2fBX2X+xwDEtnVfNZ/rJf6Z/5qrADz6Kxm2TLK0G7B7F12iCCI54RVOEc/STFU
         y1VT+vA3DQcdSgVFBtjOR167xa8YJd3bY/p4UMW36LUoO3v93RmGY5hmrNCemkNjTu4I
         kvaUUiUekAhWSqinbfLm1i4Gvdm/qteOcJurK+IqwJ4iYuPyyrqgO+sW02o9rYAKR55j
         jVlloBwPTVvvYZhi5Ubhr+z+dKeGPQLRCfALKaKj5q1rbDobtNpC1mpJ02Cgv6lH9B52
         Xb5A==
X-Gm-Message-State: AOJu0Yy1N/5LNQm/AtXRCDqnLcJHImOSq7KrRd3iBME7GZbyImMgBtiN
	9ZrHKSSypGrGOHh8TqgYq4E1Yj6TcFJ8G+VEdVRtTHcULeMOds5GvMdvGUp5WdIqW1XzY/9mMp0
	OT5TNCne5GX+RpOB/d4AlaGcZAsjlDhgQ0O2hoD0S0qsI0kpLP5iw+JbW2Q==
X-Gm-Gg: ASbGncvwL1CqTaO+SFR/99z2Rm6/Kh0yCAX3yL5Q48RWj2GZZgWVypGLGxc3S8Qp02J
	KXRhFVyTeUsOsuxaKm/9R33be4RZAWtH/hVTUDSVtecdlZUD2RnCyQuoiTJFgo/k4sPefwqleLN
	igEM8bWbaoNDBz3KHDA1E4/TYpEUTrLxoRLfibjOXErqI=
X-Google-Smtp-Source: AGHT+IFhvRX3rf16RIYzpA5wWOD1PJbxilQQe6mZLmLYbJA1BkNRltLT2QWZ2XCIPdHnYJ88sGDJ8EJyhEZSQwBB7qg=
X-Received: by 2002:a05:6a21:68a:b0:1f5:7ba7:69d8 with SMTP id
 adf61e73a8af0-21fbd4ddb26mr8499341637.15.1750001815470; Sun, 15 Jun 2025
 08:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alex Lyakas <alex.lyakas@zadara.com>
Date: Sun, 15 Jun 2025 18:36:44 +0300
X-Gm-Features: AX0GCFvOO7LlhJvW9oiySCX7MKtXdytCLU8q9p01ku9qsJ8Z8RiQuAViQAMcKKs
Message-ID: <CAOcd+r0Rg6JGMjwZnCran8s+dbqZ+VyUcgP_u7EucKEXZasOdg@mail.gmail.com>
Subject: stable patch 42fac18 missing from linux-6.6
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

Greetings,

The following patch [1]:
"42fac18 btrfs: check delayed refs when we're checking if a ref exists"
has been marked as
"CC: stable@vger.kernel.org # 5.4+"
but I do not see that it has been backported to linux-6.6.y branch.

Can this patch be picked up in the next version of linux-6.6 please?

Thanks,
Alex.

[1]
commit 42fac187b5c746227c92d024f1caf33bc1d337e4
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Thu Apr 11 16:41:20 2024 -0400

    btrfs: check delayed refs when we're checking if a ref exists

    In the patch 78c52d9eb6b7 ("btrfs: check for refs on snapshot delete
    resume") I added some code to handle file systems that had been
    corrupted by a bug that incorrectly skipped updating the drop progress
    key while dropping a snapshot.  This code would check to see if we had
    already deleted our reference for a child block, and skip the deletion
    if we had already.
...
    Fixes: 78c52d9eb6b7 ("btrfs: check for refs on snapshot delete resume")
    CC: stable@vger.kernel.org # 5.4+
    Reviewed-by: Filipe Manana <fdmanana@suse.com>
    Signed-off-by: Josef Bacik <josef@toxicpanda.com>
    Signed-off-by: David Sterba <dsterba@suse.com>

