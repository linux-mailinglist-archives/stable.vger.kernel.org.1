Return-Path: <stable+bounces-87648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF009A936F
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 00:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5E82841D3
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 22:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DE51E2839;
	Mon, 21 Oct 2024 22:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PGmXsVex"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B94137750
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729550141; cv=none; b=dmE1D9M7sbJP9nul9h28yTeQNllijeLGGn128PprOQTZ1fSf5BqJQLFSbG/0YBkdYGpQUz9DLLJtm9Icahimnf6m7fHgOEiJJPfIiPx+kHOUNAExPZ9t1zZdgITi+7OcxFVjrpCPIYlrr5mPLxAN0Kt7PxoqpRMXaA9mhWviazQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729550141; c=relaxed/simple;
	bh=+g6PyTyYHx5gky/Tv4QL0KVrdWzdFg9dVioMw52YkY8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=eVEt2D0VLY9X0RqjQrJ0q1Ts2N9097rhR89PIX45V4qEZ7AvTEGZysTix62mQp1yEj2Z0OsJJl8FLRFtVSc66rHB+t5//d/oq3ZR/j0kib4okcuXiUhkfTp6wBbLwVEyVpBxSQ/5SM6O2oNaT3rdNI+UlT99eWgaziHwmeSdrsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PGmXsVex; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43153c6f70aso44415e9.1
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 15:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729550138; x=1730154938; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+g6PyTyYHx5gky/Tv4QL0KVrdWzdFg9dVioMw52YkY8=;
        b=PGmXsVex5gl5Ek16EU+ZyWwlB+6DcDGXynt8V1uFRmM/UrM6D71KFm5ACISuKNmQLw
         zdq1ylVOdBtyf0JfWiNRS0HTHBxM8yPobYa06Z+XPNLLNB9noYtyFtKx7SelnqWcgAXE
         jFvubbKb89IbotWfltbIW+WbAD72qWdEn4AZTkf4VkHGBJUFFRpV4MfkGkOSmtyYgG5+
         RfLAw2mBIVUGZ/TLtGRbrjyjwX9pqiGVRi0jxjLuiEhMIubGoT3aRHsoiBZXbP3N8NUi
         aY/5XOkifBCLW138WvVXItKa8kGutC/IE/J8OvhEdxcsQRsj35Y4NqvLOWPjF3g9K8jK
         5qTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729550138; x=1730154938;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+g6PyTyYHx5gky/Tv4QL0KVrdWzdFg9dVioMw52YkY8=;
        b=VTpNMMuGeSG/vC3WJGWNgimCdRkhopnGtFFDBjsnNjb5ckjPgcUqlgBYX0AaYVqZPi
         9KkDT6UogzwLmY+KV3JYhhYrfZn2WUTi3rdqVIIIAWZkCPhVztJE7ue8uqVlt9/6EEVV
         mc9aRDBkmiKxPGaYEV9SYn9fCNOFICF6kmTV5m2lBexDUSvfX3jiQSINXDygp7U5k970
         FV2IbAzjavOitZWuwrEOxObZnGjLWbYbH3vYIB04KLXusnhWt0hbisTyr99kPaP3nqcG
         NX5SVE3zvgT9qxVLI/iWIlsPTYvqwayS0YX3VEQ9IPGSUuRQy85/Vp8rQ6XdCEtD+yCt
         v94w==
X-Gm-Message-State: AOJu0Ywd7KvMjATxigOFvAfptsASEC18gydl18+RnNrai+X5DYf5lPpK
	M8W6wbVSZD7GEnP4Xq80hR8SrfaJpfL2XA4K85juF/zA/FxB9W6Bu1wurm8bST36p/u8e5ADXs2
	XnvY2fAuKC4hTip4sMyDccj3mId9QxSszUoT7WTbX0YW+R+tRxtgN
X-Google-Smtp-Source: AGHT+IGRndgLZscysqNTodM/QH38N3O3S67YBZlkkgrvQxqZYkA4tkW24WjU8RB6FunWHLSboFLuLK1Z1XSWvyDKCKo=
X-Received: by 2002:a05:600c:1e1e:b0:426:68ce:c97a with SMTP id
 5b1f17b1804b1-4317d0b86f5mr755805e9.7.1729550137710; Mon, 21 Oct 2024
 15:35:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Kochera <kochera@google.com>
Date: Mon, 21 Oct 2024 17:35:26 -0500
Message-ID: <CAN1hJ_PjnxgOmY0gxeHVcLYhjLbLsjNUHWfwbWwq2sXX2qwAwQ@mail.gmail.com>
Subject: Backport Fix for CVE-2024-26800 to V5.15
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, I wanted to check on the backport of the fix for CVE-2024-26800
on the 5.15 kernel.

Here is the commit fixing the issue:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=13114dc5543069f7b97991e3b79937b6da05f5b0
and as you can see the commit it says it fixes was backported to 5.15
to fix a different CVE but this one wasn't as far as I can tell.

Thank You,
Michael Kochera

