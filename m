Return-Path: <stable+bounces-59370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 681A1931C04
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 22:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C8D1C21E20
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 20:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B1813A416;
	Mon, 15 Jul 2024 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PmqU9nzG"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3904D8C8
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 20:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075753; cv=none; b=jRyNO4p0L06rok4vHO2/ActPyksP7um42lCgSBI0RN2mbiG2NomvOEBrbRLI3mdq/KlAtzNOdhcC/SayFaJfQ6NxP6Hfsp0FQn8ChqxB1/IkMxwbt9M/OSwQeCwhwC0u8F4wpQxZlsuriSQOICKTl/I5vzJFHCrT96bwxHCynGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075753; c=relaxed/simple;
	bh=g3hbCNH/7Az+tBcBUIFR1cuGCyiK+dGq6yX94ar/NLg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QRpGUqbPJlaMJyVDBi1mHcCCStQN7g8YJiN5P4hHtzvQAWDTluWV3nE17s7jZtud4GxB1GTHcnuHqFQEhDojSE6YIKSF5HBVBSXV7AKh3dlJ+gjL/7Xg4q009skfgIGAI8splyqtCbIxIbfYx22Cw9M+EmivHOK1Yl3ebDDQ8o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PmqU9nzG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6522c6e5ed9so90432937b3.0
        for <stable@vger.kernel.org>; Mon, 15 Jul 2024 13:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721075751; x=1721680551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g3hbCNH/7Az+tBcBUIFR1cuGCyiK+dGq6yX94ar/NLg=;
        b=PmqU9nzG7zXLRV3RoCLpDZK+XIAhbFH66sqF4dVac7xB+CjFCEXmrfpPRwMI3+mu3h
         sFHNncwgHxooP/kZc+KGl3fGV1FWeGAB3VQHGGdNAt0QwSjrGNbNVD3DoTO2qdYjUsbM
         hEfx52hVGQEnka48CGFW07k9D0gflysVDu68D2uGGBv2cttdTlFOvamB0yZ98xDDRTh/
         pAIlFAeLo+DqFln9ikkB0YW3YBMQCb37OlDDCg+xiRqaAfniLHZsrforyMiIsLqDuHjB
         1OYOHEI2AZ/DBfJkd8kuPDPUZoVnpEt8mu72f/QB5xFQPXND4JBpCR4SNOhCZ6pCNlGN
         uPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721075751; x=1721680551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3hbCNH/7Az+tBcBUIFR1cuGCyiK+dGq6yX94ar/NLg=;
        b=VoLkTsljXySNYMjKdT/BGCTyRM02ZqRlEipbbm2q40NXhDljQ+TGiXG7UcVy0HEcgg
         eOLg6logLYCQomVZtsOxFqLkqA6d0wCatTJbdKZ0Y77SBnefrjXrUHS4zdi/ws80dGrd
         P643yHFe3e5v2Hhq1JV0SuD7QDe/BmPerOiT74KcRppU8k3OLXCUFxB7I9+3Wg8YSf4D
         ZyhJqQnPYzx3XqIWXW4Hb8XdARH83l58ZEi85tHaBUgB9vdfIqnH/Ya1DxDPQF0b5M7x
         qXXZCFuVXx0ObcEpVRLxouBZoDlM4sI42erZoWC/6wjdhqsmoSqWliTQwEYwjJY30BFU
         jVCw==
X-Forwarded-Encrypted: i=1; AJvYcCXxAuVepszuL0+BpbFVFgODl1OyFmeFkDZisXgoKSW6yQL7X3FTz1h5YjVKh9tSyxk8xbVtArWUcktSQdkEFhbxmz4fx30q
X-Gm-Message-State: AOJu0YyId+a6g6ZsK1n0juntb8FCLFBkg9tBZaN1ro//wfzeoemz7t9i
	O/vDFSqlvyCFlMs4oBVuPmtVhJj1CMN/+ztfBx1HNnB6wYJqKuGNGRPlxZWq1R2I0w7R1g+vfsY
	tYCb2LozzR35cRduO7FEl3PYjSoUEjQ==
X-Google-Smtp-Source: AGHT+IH4ym4QfhuevIFUgezKcBMK5YTiwbG8bQPdCmtxbQ0M3CWtw7c90kRVvGPkGs83t3o7cBRAh6B4y/Fp3p67rBJX
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:44d5:6deb:3ee6:84ff])
 (user=axelrasmussen job=sendgmr) by 2002:a05:690c:dc7:b0:648:2a9d:1a63 with
 SMTP id 00721157ae682-663814ecfa6mr2997b3.7.1721075750718; Mon, 15 Jul 2024
 13:35:50 -0700 (PDT)
Date: Mon, 15 Jul 2024 13:35:41 -0700
In-Reply-To: <CACzhbgRoMEAzkEVZPMEHR2JsNn5ZNw1SwKqP1FVzej4g_87snQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CACzhbgRoMEAzkEVZPMEHR2JsNn5ZNw1SwKqP1FVzej4g_87snQ@mail.gmail.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240715203541.389415-1-axelrasmussen@google.com>
Subject: Re: [PATCH 6.6] fork: defer linking file vma until vma is fully initialized
From: Axel Rasmussen <axelrasmussen@google.com>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, 
	Miaohe Lin <linmiaohe@huawei.com>, Thorvald Natvig <thorvald@google.com>, 
	Jane Chu <jane.chu@oracle.com>, Christian Brauner <brauner@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Muchun Song <muchun.song@linux.dev>, 
	Oleg Nesterov <oleg@redhat.com>, Peng Zhang <zhangpeng.00@bytedance.com>, 
	Tycho Andersen <tandersen@netflix.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alex.williamson@redhat.com, 
	Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"

I tried out Sasha's suggestion. Note that *just* taking
aac6db75a9 ("vfio/pci: Use unmap_mapping_range()") is not sufficient, we also
need b7c5e64fec ("vfio: Create vfio_fs_type with inode per device").

But, the good news is both of those apply more or less cleanly to 6.6. And, at
least under a very basic test which exercises VFIO memory mapping, things seem
to work properly with that change.

I would agree with Leah that these seem a bit big to be stable fixes. But, I'm
encouraged by the fact that Sasha suggested taking them. If there are no big
objections (Alex? :) ) I can send the backport patches this week.

