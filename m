Return-Path: <stable+bounces-18999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D85784BAEF
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 17:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86985B29697
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 16:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191CF130AE8;
	Tue,  6 Feb 2024 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNfQJKv+"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8124712E1ED
	for <stable@vger.kernel.org>; Tue,  6 Feb 2024 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236898; cv=none; b=nzbpjPQEPbm+e7Wr2k4nLpa8M0KnpCDlAdYQDv+2q9oBJoGomHxuLdJ4spe6EaNaTdSCV0EpxZ0SVPhCvXD9p0DGgLHtWZcEI/q/uWDXjJNR05OxyCEszKcTu2nmD0SS4RA4twndF95k9QfATLewRTiWho84dC6VcLGWi2kDAiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236898; c=relaxed/simple;
	bh=ceZoGpmkVxWKhm6Unp8oGaPw0g2sZr5OSeZbxJISSTE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Y9/VWijObplkegr7DlI4kKzI9bXydfYcOOuhQht0beHIyuVORjuGLVDZyWVWJDEPD45wEPELh/9ABKx0q97zlo9t9neu4erxjhQAqy0/1JHhTy2cPl14fP7EatxdoHvNpqFTk7OA0SIXZHfBPNWYby0atloGdYn3YW5d81mBy3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNfQJKv+; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-46d11cbd695so705152137.1
        for <stable@vger.kernel.org>; Tue, 06 Feb 2024 08:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707236896; x=1707841696; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bJa/E5EZKvSNnN5gqyVU5nptQO5wJnIXZWzsjsilm2U=;
        b=PNfQJKv+ETPrapDFWW/Mmn3stzUTnaMG9rt2PT5GBSA6KBBoFnHtMA6mF/OflR+OBG
         +t373uF7gITWDRWCBCI1q+2DCdHj/qWVRHGZBAOMbT8b0P6FQBkPVtb9M3r2s3u/Af9M
         mFORNZq9dyslHoqa0MW14sOpKqSgI502K7N1rnoBjGc2hNRKGaoRXMZGhSOsiZfgOecy
         9kZluhwq7bSCMyBwo5M8GS7xu2WqaJHJktdIwT9kZwt68NHOB/ok4BM4sXc6XcsHOJeh
         u7S581dVONezXRrp5DzbRoZL2QOOVQasr/OPducW7/gtHWCGl6+Ke9G/ms74JIG1zD8H
         sr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707236896; x=1707841696;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJa/E5EZKvSNnN5gqyVU5nptQO5wJnIXZWzsjsilm2U=;
        b=BLCYxpcnUK1gBO0vDi8UATU0s1dqgLiFDd2W+J1pfd+a4bz6A+Q7gBuIQjLd/JKxaa
         seYg4u/nqtZEv2QfdbbyUEOfUVR1BViNNdne7I3Ru1ZYPbQqn54zK694oSef5WtN3KWL
         U9kfqGx6mfaNtoDxKm+ozSTyy3btQvi574wFPjf9D5QU8/LbsQBxTGo75J1kDTDzQftM
         /VyM+oTm/mfLtWPB/gfYnbZ1CHectLrJO7yFwMo5JJshh3g3NfpQBQOOvUeE7MW30W9v
         kwSZcnmjLUbh6upvF5lwzo4qMr8yqZ9SFgcB6e6gd8j3DeQoJy8yNcE4kqrXyfnSn5bz
         7Xnw==
X-Gm-Message-State: AOJu0Ywgt6LnQgFtOuYbW4XqfcCqLPWDyGpasmFodifPGCwn6wYaLZT8
	YM1yNyRhYsS4gx7p1MYL5vljCKvaK04O7UakKyvQUIrItJCp9xHlb3tRe41zIWB1uoHyH5Nzh9A
	oEiRUiPLefYSbQo3/qoFnzoTpbuDdaFSGi/o=
X-Google-Smtp-Source: AGHT+IF8ebOKis4ZCNJl3xfmdPbEr4V1hz/kUODMzQ77dvggzwb0rgdpwgb4Dy8mNNCcYBsZDaI8KiGVhZAzCsCLad0=
X-Received: by 2002:a67:bd1a:0:b0:46d:1f47:8a33 with SMTP id
 y26-20020a67bd1a000000b0046d1f478a33mr13466vsq.30.1707236896334; Tue, 06 Feb
 2024 08:28:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Allen <allen.lkml@gmail.com>
Date: Tue, 6 Feb 2024 08:28:04 -0800
Message-ID: <CAOMdWSKyoAgFHiSnfbPKELB57295VTBqh-mvjPd--MCDU-uvyw@mail.gmail.com>
Subject: Patches for v5.15.149-rc
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

   I believe these patches are likely already on your radar. I just wanted to
inform you that it would be highly appreciated if we could see their inclusion
in the upcoming release.

e0526ec5360a 2024-01-30hv_netvsc: Fix race condition between
netvsc_probe and netvsc_remove [Jakub Kicinski]

  We would like to even get:

9cae43da9867 hv_netvsc: Register VF in netvsc_probe if
NET_DEVICE_REGISTER missed

included, but the patch is still in netdev and has not made it into
Linus's tree. If it does come in,
could you please consider including it too.


Thanks,
- Allen

