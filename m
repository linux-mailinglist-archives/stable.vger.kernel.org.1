Return-Path: <stable+bounces-195390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BCEC75F18
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 8C1F829068
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F58335B132;
	Thu, 20 Nov 2025 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wcu/cJ1+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C47366DC3
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664164; cv=none; b=ude4AqqS877J1LABzA97uHBAy8vOJGR4XiZmUNtxzct8eCTdCCH/gEc97ljsAdQVpI+L+ADLYsew11Zi3UdEXuxcIDnUEsEuuoiWWgfuy2RTjZpIkYa4sBDXto3Y5jTVD+xXDk87Si6Kkt51o8MRqmGnizdP1w40yHEoZODZRq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664164; c=relaxed/simple;
	bh=BUNEW8GjADCHmQIiXlr853bKW9HvDyV3X6lrlUAhep8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kz1fEZfg6AYeTnoC9lS1L65c/h15KjL9QOBSwODaOuuKt8QtC8axxXxtbmEpDAwiTavKu7QY3qxAL25dhwsvRUiGE+eGGXmocYsGj9GVJcvVbtHue3GPQzErtgYkfAZBDroc01SKUc5ysp46BtZidEMYweXLSp+kJTzw6ozeLvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wcu/cJ1+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aad4823079so1070339b3a.0
        for <stable@vger.kernel.org>; Thu, 20 Nov 2025 10:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763664161; x=1764268961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FCsMbyFAXE+sL0BOV2F7/Ne2j4+o3DG6bVR0QALJdcE=;
        b=Wcu/cJ1+lmw5A0Nra5VDFlaioHYT+UUSRt5Ygkc1RlnKFQJrSITe7eP0pQrDp9m4hU
         I39s49hXN3Yt58lTVFa9vIgH00x8pGACJYUbU6sczaMKLnfWCI65OIunXKZ7dsW3t1ut
         kWPqbrxLbsO8lo7RCG5h/a32qcW4ne+XjMeRXBKzSpgPhz+vS3Wz+cP8FgK2sp42qPYF
         OLDrK+P2iPbXmcOb2lczhqFtaPnFYqWpG2rPejsMAbhRBAFlOQLfuBKTNaCgq1JwOSn1
         zIq5nd2q4fzaMk6T4bokMiHYtRpkgnZHHzaUaxDfJrdwOgXRkiOf9K34A0x04gK9+t2n
         RGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763664161; x=1764268961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCsMbyFAXE+sL0BOV2F7/Ne2j4+o3DG6bVR0QALJdcE=;
        b=qE1NDSGwzvRy5WOy+9E2wMFAXYDU++abZrhFz5lCO+dRAmMajZpFEuRpyEEC1X320t
         PFTpUa9oGdMnS9j4xeiRTi8zO4DXG06EYpT/9qpvewHcDVkFa3lazOyo9V0ccOzf222c
         9JG2YL+aiF08uQvi4kNWkfj7Kk4FD+jO2Hwah7cqQdVdaklAL9jctwTHku5EdM2bP+hO
         53w6qld5UVCZc9/DtUGZuLrBlUeiyoqVlyjAGUc9WRak/dlwehN8mxnmgdWQLfHAs2Iv
         ATQCmkGCoDpqNWzqFV8ZzaGHJv70lMRxftzxB5pg2dOrNFOe8H6QDzXXrbocOLL9PVrd
         7swA==
X-Forwarded-Encrypted: i=1; AJvYcCWZYvVoer48JYzd3e3hKKLRF4PAho7Rsk8ReI+N8yA0S8UxArtGVCJ0aDFrstB8S18qfqq2ZUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxWENrbLZATEYOPS5oDp1YLjWGwDg8ekRKOjY2zwMnreFWNQh
	bl+FSbF/knQiS1Xuy5ZtCmdWoyzUMfV6Oz+2i+VQ+JJkYUzysVGlnQkM
X-Gm-Gg: ASbGncu+54BEWkgZRTCoakRkSej6vu/VR1MyzMxfZYzDzrI/Nh5yVQAZacU92cAiY8G
	xgcIMYhceGe/6h+ghYUjDohO30OSAzmKHeUjWT9YD177h2dTtDRakx8JdnvFmojGSGnCt+wvtu3
	GAmxHQOIj272SU0z+LrFPTJIw/qo8kOcUcqsFtmUm81d/AaDm/cGLFffoQXq0JfPVqUTZTL1zjl
	yilx/MpPpNKjuYdlplFaAAUOxuRJVxS4ohypDTr6k1nZdqj01ughNpfPz1QNNv3yM8VTaXx0LL1
	aglD4+hsTE5MlzwojuUvLhpVwzLjdGLk/PnTV7wwEcVqKqp/r8BSWO9uTYFJXXcRAIWgELAR4dc
	pggtuhUYit+TlG8CwnbG5UFxJBRb83bX8stcCGSSsFvgpmGmJNBA6SWQyAh8R/H8rBZgA9Iwgu6
	iT5xIsJq0znDJuwfU+OWU0zEyi9WQ=
X-Google-Smtp-Source: AGHT+IFC3vQmm4T+O9x1swdQHkPxcdLNX2FjoEzV5FPY9fpi+xrqXDUFQdxI60qbTxTzZWHqID5ZqA==
X-Received: by 2002:a05:6a00:2d87:b0:7ba:13f4:a99a with SMTP id d2e1a72fcca58-7c3f145af7bmr4954362b3a.27.1763664161090;
        Thu, 20 Nov 2025 10:42:41 -0800 (PST)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f024b7d2sm3456767b3a.40.2025.11.20.10.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 10:42:40 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	linux-mm@kvack.org,
	shakeel.butt@linux.dev,
	athul.krishna.kr@protonmail.com,
	miklos@szeredi.hu,
	stable@vger.kernel.org
Subject: [PATCH v1 0/2] mm: skip wait in wait_sb_inodes() for hangable-writeback mappings 
Date: Thu, 20 Nov 2025 10:42:09 -0800
Message-ID: <20251120184211.2379439-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported by Athul upstream in [1], there is a userspace regression caused
by commit 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal rb
tree") where if there is a bug in a fuse server that causes the server to
never complete writeback, it will make wait_sb_inodes() wait forever, causing
sync paths to hang.

This is a resubmission of this patch [2] that was dropped from the original
series due to a buggy/malicious server still being able to hold up sync() /
the system in other ways if they wanted to, but the wait_sb_inodes() path is
particularly common and easier to hit for malfunctioning servers.

Thanks,
Joanne

[1] https://lore.kernel.org/regressions/CAJnrk1ZjQ8W8NzojsvJPRXiv9TuYPNdj8Ye7=Cgkj=iV_i8EaA@mail.gmail.com/T/#t
[2] https://lore.kernel.org/linux-fsdevel/20241122232359.429647-4-joannelkoong@gmail.com/

Joanne Koong (2):
  mm: rename AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM to
    AS_WRITEBACK_MAY_HANG
  fs/writeback: skip inodes with potential writeback hang in
    wait_sb_inodes()

 fs/fs-writeback.c       |  3 +++
 fs/fuse/file.c          |  2 +-
 include/linux/pagemap.h | 10 +++++-----
 mm/vmscan.c             |  3 +--
 4 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.47.3


